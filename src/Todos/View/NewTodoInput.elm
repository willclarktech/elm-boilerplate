module Todos.View.NewTodoInput exposing (viewNewTodoInput, handleNewTodoKeyUp)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onInput, keyCode)
import Json.Decode
import Helpers exposing (isEnter)
import Todos.Types exposing (Msg(..))
import Todos.Copy exposing (placeholderText)


viewNewTodoInput : String -> Html Msg
viewNewTodoInput currentText =
    div [ class "ui compact attached segment" ]
        [ div [ class "ui huge form" ]
            [ input
                [ id "new-todo"
                , class "ui field"
                , placeholder placeholderText
                , on "keyup" <| Json.Decode.map (handleNewTodoKeyUp currentText) keyCode
                , onInput UpdateText
                , value currentText
                ]
                []
            ]
        ]


handleNewTodoKeyUp : String -> Int -> Msg
handleNewTodoKeyUp currentText keyCode =
    if currentText /= "" && isEnter keyCode then
        CreateTodo
    else
        NoOp
