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
        ( headingMD
        , placeholderText
        , getButtonText
        )


view : Model -> Html Msg
view { currentText, todos, filterOption } =
    div [ id "todos-app" ]
        [ viewHeading
        , viewNewTodoInput currentText
        , viewTodos todos filterOption
        , viewFilters
        ]


viewHeading : Html Msg
viewHeading =
    Markdown.toHtml [] headingMD


viewFilters : Html Msg
viewFilters =
    div [ id "filters" ]
        <| List.map viewFilterButton
            [ All, Completed, Incomplete ]


viewFilterButton : FilterOption -> Html Msg
viewFilterButton filterOption =
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
    in
        button
            [ id buttonId
            , onClick <| Filter filterOption
            ]
            [ text <| getButtonText buttonId ]


viewNewTodoInput : String -> Html Msg
viewNewTodoInput currentText =
    input
        [ id "new-todo"
        , placeholder placeholderText
        , on "keyup" <| Json.map (handleKeyUp currentText) keyCode
        , onInput UpdateText
        , value currentText
        ]
        []


viewTodos : List Todo -> FilterOption -> Html Msg
viewTodos todos filterOption =
    Html.Keyed.ol []
        <| List.map (\todo -> ( "todo-" ++ toString todo.id, viewTodo todo ))
        <| getTodosForFilterOption todos filterOption


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
        completed =
            todo.completed

        className =
            if completed then
                "completed"
            else
                ""
    in
        li
            [ id ("todo-" ++ toString todo.id)
            , class className
            ]
            [ input
                [ class "toggle"
                , type' "checkbox"
                , onCheck <| handleCheck todo
                , checked completed
                ]
                []
            , label [] [ text todo.text ]
            , button
                [ class "delete"
                , onClick <| Delete todo
                ]
                [ text "×" ]
            ]


handleKeyUp : String -> Int -> Msg
handleKeyUp currentText keyCode =
    if currentText /= "" && isEnter keyCode then
        CreateTodo
    else
        NoOp


isEnter : Int -> Bool
isEnter keyCode =
    keyCode == 13


handleCheck todo checked =
    if checked then
        MarkAsCompleted todo
    else
        MarkAsIncomplete todo
