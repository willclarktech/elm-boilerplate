module Todos.View exposing (view, handleNewTodoKeyUp)

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
import OAuth.Types
import OAuth.View


view : Model -> OAuth.Types.Model -> Html Msg
view { currentText, todos, filterOption, currentlyEditing } oauthModel =
    let
        baseComponents =
            [ viewHeading oauthModel
            , viewNewTodoInput currentText
            ]

        components =
            if List.length todos /= 0 then
                List.append baseComponents
                    [ viewFilters filterOption
                    , viewTodos todos filterOption currentlyEditing
                    ]
            else
                baseComponents
    in
        div
            [ id "todos-app"
            , class "ui segments container"
            ]
            components


viewHeading : OAuth.Types.Model -> Html Msg
viewHeading oauthModel =
    div [ class "ui attached inverted orange segment" ]
        [ h1
            [ class "ui huge header"
            , style [ ( "font-size", "35px" ) ]
            ]
            [ text headingText
            , span []
                [ OAuth.View.view oauthModel ]
            ]
        ]


viewNewTodoInput : String -> Html Msg
viewNewTodoInput currentText =
    div [ class "ui compact attached segment" ]
        [ div [ class "ui huge form" ]
            [ input
                [ id "new-todo"
                , class "ui field"
                , placeholder placeholderText
                , on "keyup" <| Json.map (handleNewTodoKeyUp currentText) keyCode
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


viewTodos : List Todo -> FilterOption -> Maybe Todo -> Html Msg
viewTodos todos filterOption currentlyEditing =
    let
        relevantTodos =
            getTodosForFilterOption todos filterOption
    in
        div [ class "ui attached segment" ]
            <| case relevantTodos of
                [] ->
                    [ text "No todos to display..." ]

                _ ->
                    let
                        isCurrentlyEditing { id } =
                            case currentlyEditing of
                                Nothing ->
                                    False

                                Just currentTodo ->
                                    currentTodo.id == id
                    in
                        [ Html.Keyed.ol [ class "ui huge list" ]
                            <| List.map
                                (\todo ->
                                    ( toString todo.id
                                    , viewTodo todo (isCurrentlyEditing todo)
                                    )
                                )
                                relevantTodos
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


viewTodo : Todo -> Bool -> Html Msg
viewTodo todo isCurrentlyEditing =
    let
        baseClass =
            "item "

        todoClass =
            if todo.completed then
                baseClass ++ "completed"
            else
                baseClass

        todoText =
            if isCurrentlyEditing then
                span [ class "ui mini input" ]
                    [ input
                        [ class "edit"
                        , type' "text"
                        , value todo.text
                        , on "keyup" <| Json.map handleEditTodoKeyUp keyCode
                        , onInput <| UpdateTodo todo
                        ]
                        []
                    ]
            else
                label [ onClick <| handleClick todo ] [ text todo.text ]
    in
        li
            [ id ("todo-" ++ toString todo.id)
            , class todoClass
            ]
            [ viewCheckbox todo
            , todoText
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


handleNewTodoKeyUp : String -> Int -> Msg
handleNewTodoKeyUp currentText keyCode =
    if currentText /= "" && isEnter keyCode then
        CreateTodo
    else
        NoOp


handleEditTodoKeyUp : Int -> Msg
handleEditTodoKeyUp keyCode =
    if isEnter keyCode then
        StopEditing
    else
        NoOp


handleCheck : Todo -> Bool -> Msg
handleCheck todo checked =
    if checked then
        MarkAsCompleted todo
    else
        MarkAsIncomplete todo


handleClick : Todo -> Msg
handleClick todo =
    StartEditing todo
