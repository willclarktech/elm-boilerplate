module Main exposing (..)

import Navigation
import Todos.Update exposing (init, update, urlUpdate)
import Todos.View exposing (view)
import Todos.UrlParser exposing (urlParser)


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = (\model -> Sub.none)
        }
