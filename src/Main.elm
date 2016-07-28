module Main exposing (..)

import Html.App
import Todos.Update exposing (init, update)
import Todos.View exposing (view)
import Todos.Subscriptions exposing (subscriptions)


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
