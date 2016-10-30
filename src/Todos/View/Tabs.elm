module Todos.View.Tabs exposing (viewTabs)

import Html exposing (..)
import Html.Attributes exposing (..)
import Todos.Types exposing (Msg, Tab(..))
import Todos.Copy exposing (tabText)


viewTabs : List (Html Msg)
viewTabs =
    [ span [ id "tab-todos" ]
        [ text <| tabText Todos ]
    , span [ id "tab-info" ]
        [ text <| tabText Info ]
    ]
