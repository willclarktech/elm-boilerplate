module Todos.View.Todos exposing (viewTodos)

import Html exposing (..)
import Html.Keyed
import Html.Attributes exposing (..)
import Todos.Types exposing (Todo, FilterOption(..), Msg)
import Todos.View.Todo exposing (viewTodo)


viewTodos : List Todo -> Maybe Todo -> Html Msg
viewTodos todos currentlyEditing =
    div [ class "ui attached segment" ]
        <| case todos of
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
                            todos
                    ]
