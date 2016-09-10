module Todos.View.Todo exposing (viewTodo)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, onInput, onCheck, keyCode)
import Json.Decode
import Helpers exposing (isEnter)
import Todos.Types exposing (Todo, Msg(..))


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
    in
        li
            [ id ("todo-" ++ toString todo.id)
            , class todoClass
            ]
            [ viewCheckbox todo
            , viewTodoText todo isCurrentlyEditing
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


viewTodoText : Todo -> Bool -> Html Msg
viewTodoText todo isCurrentlyEditing =
    if isCurrentlyEditing then
        span [ class "ui mini input" ]
            [ input
                [ class "edit"
                , type' "text"
                , value todo.text
                , on "keyup" <| Json.Decode.map handleEditTodoKeyUp keyCode
                , onInput <| UpdateTodo todo
                ]
                []
            ]
    else
        label [ onClick <| handleClick todo ] [ text todo.text ]


viewDeleteButton : Todo -> Html Msg
viewDeleteButton todo =
    button
        [ class "delete ui compact icon negative button right floated"
        , onClick <| Delete todo
        ]
        [ text "×" ]


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
