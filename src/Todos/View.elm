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
import Todos.Types exposing (Todo, Model, Msg(..))
import Todos.Update exposing (..)
import Todos.Copy exposing (headingMD, placeholderText)


view : Model -> Html Msg
view { currentText, todos } =
    div [ id "todos-app" ]
        [ viewHeading
        , viewNewTodoInput currentText
        , viewTodos todos
        , viewFilters
        ]


viewHeading : Html Msg
viewHeading =
    Markdown.toHtml [] headingMD


viewFilters : Html Msg
viewFilters =
    div [ id "filters" ]
        [ div [ id "filter-all" ] [ text "filter-all" ]
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


viewTodos : List Todo -> Html Msg
viewTodos todos =
    ul [] <| List.map viewTodo todos


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
            , span
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
