module Todos.View.Info exposing (viewInfo)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown
import Todos.Types exposing (Msg)
import Todos.Copy exposing (infoMD)


viewInfo : Html Msg
viewInfo =
    div
        [ id "info"
        , class "ui compact attached segment"
        ]
        [ Markdown.toHtml [] infoMD
        ]
