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

        components =
            if tab == Todos && List.length todos /= 0 then
                List.append baseComponents
                    [ viewFilters filterOption oauth.userName
                    , viewTodos todos filterOption currentlyEditing
                    ]
            else
                baseComponents
    in
        div
            [ id "todos-app"
            , class "ui segments container"
            ]
            components
