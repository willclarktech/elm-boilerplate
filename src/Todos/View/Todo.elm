module Todos.View.Todo exposing (viewTodo)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, onInput, onCheck, keyCode)
import Json.Decode
import Material
import Material.Button as Button
import Material.Toggles as Toggles
import Material.Icon as Icon
import Helpers exposing (isEnter)
import Todos.Types exposing (Todo, Msg(..))


viewTodo : Material.Model -> Todo -> Bool -> Html Msg
viewTodo uiModel todo isCurrentlyEditing =
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
            [ viewCheckbox uiModel todo
            , viewTodoText todo isCurrentlyEditing
            , viewDeleteButton uiModel todo
            ]


viewCheckbox : Material.Model -> Todo -> Html Msg
viewCheckbox uiModel todo =
    Toggles.checkbox UI
        [ 0, todo.id ]
        uiModel
        [ Toggles.value todo.completed
        , Toggles.onClick <| handleCheck todo (not todo.completed)
        ]
        []


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


viewDeleteButton : Material.Model -> Todo -> Html Msg
viewDeleteButton uiModel todo =
    Button.render UI
        [ 2, todo.id ]
        uiModel
        [ Button.icon
        , Button.onClick <| Delete todo
        ]
        [ Icon.i "delete" ]


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
