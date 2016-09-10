module Todos.View.Index exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        , Tab(..)
        , FilterOption(..)
        )
import Todos.View.Heading exposing (viewHeading)
import Todos.View.Info exposing (viewInfo)
import Todos.View.NewTodoInput exposing (viewNewTodoInput)
import Todos.View.Filters exposing (viewFilters)
import Todos.View.Todos exposing (viewTodos)


view : Model -> Html Msg
view { tab, currentText, todos, filterOption, currentlyEditing, oauth } =
    let
        relevantTodos =
            getTodosForFilterOption todos filterOption

        baseComponents =
            case tab of
                Todos ->
                    [ viewHeading oauth tab
                    , viewNewTodoInput currentText
                    ]

                Info ->
                    [ viewHeading oauth tab
                    , viewInfo
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
                    [ viewFilters filterOption showSaveButton
                    , viewTodos relevantTodos currentlyEditing
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
