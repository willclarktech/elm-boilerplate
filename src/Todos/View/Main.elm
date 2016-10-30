module Todos.View.Main exposing (viewMain)

import Html exposing (..)
import Html.Attributes exposing (..)
import Todos.Types exposing (Model, Msg, Todo, Tab(..), FilterOption(..))
import Todos.View.NewTodoInput exposing (viewNewTodoInput)
import Todos.View.Info exposing (viewInfo)
import Todos.View.Filters exposing (viewFilters)
import Todos.View.Todos exposing (viewTodos)


viewMain : Model -> Html Msg
viewMain { tab, currentText, todos, filterOption, currentlyEditing, oauth, mdl } =
    let
        relevantTodos =
            getTodosForFilterOption todos filterOption

        baseComponents =
            case tab of
                Todos ->
                    [ viewNewTodoInput mdl currentText
                    ]

                Info ->
                    [ viewInfo
                    ]

        showSaveButton =
            case oauth.userName of
                Nothing ->
                    False

                Just _ ->
                    True

        components =
            if tab == Todos && List.length todos /= 0 then
                List.append baseComponents
                    [ viewFilters mdl filterOption showSaveButton
                    , viewTodos mdl relevantTodos currentlyEditing
                    ]
            else
                baseComponents
    in
        div
            [ id "todos-app"
            , class "ui segments container"
            ]
            components


getTodosForFilterOption : List Todo -> FilterOption -> List Todo
getTodosForFilterOption todos filterOption =
    case filterOption of
        Completed ->
            List.filter (\todo -> todo.completed) todos

        Incomplete ->
            List.filter (\todo -> todo.completed /= True) todos

        All ->
            todos
