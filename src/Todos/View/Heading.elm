module Todos.View.Heading exposing (viewHeading)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import OAuth.Types
import OAuth.View
import Todos.Types exposing (Tab(..), Msg(..))
import Todos.Style
    exposing
        ( headingStyle
        , headerStyle
        , tabLinkStyle
        , activeTabLinkStyle
        )
import Todos.Copy exposing (tabText)


viewHeading : OAuth.Types.Model -> Tab -> Html Msg
viewHeading oauthModel tab =
    div
        [ class "ui attached inverted orange segment"
        , style headingStyle
        ]
        [ h1
            [ class "ui huge header"
            , style headerStyle
            ]
            [ span
                [ id "tab-todos"
                , style
                    (if tab == Todos then
                        activeTabLinkStyle
                     else
                        tabLinkStyle
                    )
                , onClick <| SwitchTab Todos
                ]
                [ text <| tabText Todos ]
            , text " / "
            , span
                [ id "tab-info"
                , style
                    (if tab == Info then
                        activeTabLinkStyle
                     else
                        tabLinkStyle
                    )
                , onClick <| SwitchTab Info
                ]
                [ text <| tabText Info ]
            , span []
                [ OAuth.View.view oauthModel ]
            ]
        ]
