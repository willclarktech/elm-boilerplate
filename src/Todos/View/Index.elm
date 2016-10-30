module Todos.View.Index exposing (view)

import Html exposing (..)
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
import Todos.View.Tabs exposing (viewTabs)
import Todos.View.Main exposing (viewMain)


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
        , tabs = ( viewTabs, [] )
        , drawer = []
        , main = [ viewMain model ]
        }


getSelectedTab : Tab -> Int
getSelectedTab tab =
    case tab of
        Todos ->
            0

        Info ->
            1
