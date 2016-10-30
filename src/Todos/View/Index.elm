module Todos.View.Index exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Layout as Layout
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
import Todos.View.Tabs exposing (viewTabs)
import Todos.View.Todos exposing (viewTodos)


view : Model -> Html Msg
view model =
    Layout.render UI
        model.mdl
        [ Layout.fixedHeader
        , Layout.fixedTabs
        , Layout.selectedTab (getSelectedTab model.tab)
        , Layout.onSelectTab SwitchTab
        ]
        { header = [ viewHeading model ]
        , drawer = []
        , main = [ viewMain model ]
        , tabs = ( viewTabs, [] )
        }


getSelectedTab : Tab -> Int
getSelectedTab tab =
    case tab of
        Todos ->
            0

        Info ->
            1


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
