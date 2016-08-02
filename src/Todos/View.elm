module Todos.View exposing (view, handleKeyUp)

import Json.Decode as Json
import Markdown
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
    exposing
        ( onInput
        , onClick
        , on
        , keyCode
        )
import Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        , FilterOption(..)
        )
import Todos.Update exposing (..)
import Todos.Copy exposing (headingMD, placeholderText)


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
        [ button
            [ id "filter-all"
            , onClick <| Filter All
            ]
            [ text "All" ]
        , button
            [ id "filter-completed"
            , onClick <| Filter Completed
            ]
            [ text "Completed" ]
        , button
            [ id "filter-incomplete"
            , onClick <| Filter Incomplete
            ]
            [ text "Incomplete" ]
        ]


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
    ul []
        <| List.map viewTodo
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

        onToggleMsg =
            if completed then
                MarkAsIncomplete todo
            else
                MarkAsCompleted todo
    in
        li
            [ id ("todo-" ++ toString todo.id)
            , class className
            ]
            [ input
                [ class "toggle"
                , type' "checkbox"
                , onClick <| onToggleMsg
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
