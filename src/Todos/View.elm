module Todos.View exposing (view, handleKeyUp)

import Json.Decode as Json
import Markdown
import Html exposing (..)
import Html.Keyed exposing (ol)
import Html.Attributes exposing (..)
import Html.Events
    exposing
        ( onInput
        , onClick
        , onCheck
        , on
        , keyCode
        , targetChecked
        )
import Helpers exposing (isEnter)
import Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        , FilterOption(..)
        )
import Todos.Update exposing (..)
import Todos.Copy
    exposing
        ( headingText
        , placeholderText
        , getButtonText
        )


view : Model -> Html Msg
view { currentText, todos, filterOption } =
    let
        baseComponents =
            [ viewHeading
            , viewNewTodoInput currentText
            ]

        components =
            if List.length todos /= 0 then
                List.append baseComponents [ viewFilters filterOption, viewTodos todos filterOption ]
            else
                baseComponents
    in
        div
            [ id "todos-app"
            , class "ui segments container"
            ]
            components


viewHeading : Html Msg
viewHeading =
    div [ class "ui raised attached inverted orange segment" ]
        [ h1 [ class "ui huge header" ]
            [ text headingText ]
        ]


viewNewTodoInput : String -> Html Msg
viewNewTodoInput currentText =
    div [ class "ui compact attached segment" ]
        [ div [ class "ui huge form" ]
            [ input
                [ id "new-todo"
                , class "ui field"
                , placeholder placeholderText
                , on "keyup" <| Json.map (handleKeyUp currentText) keyCode
                , onInput UpdateText
                , value currentText
                ]
                []
            ]
        ]


viewFilters : FilterOption -> Html Msg
viewFilters activeOption =
    footer
        [ id "filters"
        , class "ui tiny segment attached center aligned"
        ]
        [ div [ class "ui buttons" ]
            <| List.map (viewFilterButton activeOption)
                [ All, Completed, Incomplete ]
        ]


viewFilterButton : FilterOption -> FilterOption -> Html Msg
viewFilterButton activeOption filterOption =
    let
        idSuffix =
            case filterOption of
                All ->
                    "all"

                Completed ->
                    "completed"

                Incomplete ->
                    "incomplete"

        buttonId =
            "filter-" ++ idSuffix

        baseClass =
            "ui button "

        buttonClass =
            if activeOption == filterOption then
                baseClass ++ "active positive "
            else
                baseClass
    in
        button
            [ id buttonId
            , onClick <| Filter filterOption
            , class buttonClass
            ]
            [ text <| getButtonText buttonId ]


viewTodos : List Todo -> FilterOption -> Html Msg
viewTodos todos filterOption =
    let
        relevantTodos =
            getTodosForFilterOption todos filterOption
    in
        div [ class "ui attached segment" ]
            <| case relevantTodos of
                [] ->
                    [ text "No todos to display..." ]

                _ ->
                    [ Html.Keyed.ol [ class "ui big list" ]
                        <| List.map (\todo -> ( toString todo.id, viewTodo todo )) relevantTodos
                    ]


getTodosForFilterOption : List Todo -> FilterOption -> List Todo
getTodosForFilterOption todos filterOption =
    case filterOption of
        Completed ->
            List.filter (\todo -> todo.completed) todos

        Incomplete ->
            List.filter (\todo -> todo.completed /= True) todos

        All ->
            todos


viewTodo : Todo -> Html Msg
viewTodo todo =
    let
        baseClass =
            "item "

        todoClass =
            if todo.completed then
                baseClass ++ "completed"
            else
                baseClass
    in
        li
            [ id ("todo-" ++ toString todo.id)
            , class todoClass
            ]
            [ viewCheckbox todo
            , label [] [ text todo.text ]
            , viewDeleteButton todo
            ]


viewCheckbox : Todo -> Html Msg
viewCheckbox todo =
    span [ class "ui right spaced image" ]
        [ input
            [ class "toggle"
            , type' "checkbox"
            , onCheck <| handleCheck todo
            , checked todo.completed
            ]
            []
        ]


viewDeleteButton : Todo -> Html Msg
viewDeleteButton todo =
    button
        [ class "delete ui compact icon negative button right floated"
        , onClick <| Delete todo
        ]
        [ text "×" ]


handleKeyUp : String -> Int -> Msg
handleKeyUp currentText keyCode =
    if currentText /= "" && isEnter keyCode then
        CreateTodo
    else
        NoOp


handleCheck : Todo -> Bool -> Msg
handleCheck todo checked =
    if checked then
        MarkAsCompleted todo
    else
        MarkAsIncomplete todo
