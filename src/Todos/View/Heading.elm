module Todos.View.Heading exposing (viewHeading)

import Html exposing (..)
import Html.Attributes exposing (..)
import OAuth.View
import Todos.Types exposing (Model, Msg)
import Todos.Style exposing (headerStyle)
import Todos.Copy exposing (titleText)


viewHeading : Model -> Html Msg
viewHeading { oauth, tab } =
    div []
        [ h1
            [ style headerStyle
            ]
            [ text <| titleText
            , span []
                [ OAuth.View.view oauth ]
            ]
        ]
