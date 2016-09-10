module Todos.View.Todos exposing (viewTodos)

import Html exposing (..)
import Html.Keyed
import Html.Attributes exposing (..)
import Todos.Types exposing (Todo, FilterOption(..), Msg)
import Todos.View.Todo exposing (viewTodo)


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
