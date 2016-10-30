module Todos.View.NewTodoInput exposing (viewNewTodoInput, handleNewTodoKeyUp)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onInput, keyCode)
import Json.Decode
import Material
import Material.Textfield as Textfield
import Material.Options as Options
import Helpers exposing (isEnter)
import Todos.Types exposing (Msg(..))
import Todos.Copy exposing (placeholderText)


viewNewTodoInput : Material.Model -> String -> Html Msg
viewNewTodoInput uiModel currentText =
    div [ class "ui compact attached segment" ]
        [ div [ class "ui huge form" ]
            [ Textfield.render UI
                [ 0 ]
                uiModel
                [ Textfield.label placeholderText
                , Textfield.floatingLabel
                , Textfield.text'
                , Textfield.autofocus
                , Textfield.value currentText
                , Textfield.on "keyup" <| Json.Decode.map (handleNewTodoKeyUp currentText) keyCode
                , Textfield.onInput UpdateText
                , Options.inner [ Options.id "new-todo" ]
                ]
            ]
        ]


handleNewTodoKeyUp : String -> Int -> Msg
handleNewTodoKeyUp currentText keyCode =
    if currentText /= "" && isEnter keyCode then
        CreateTodo
    else
        NoOp
