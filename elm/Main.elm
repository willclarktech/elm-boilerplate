module Main exposing (..)

import Html.App
import App.Todos as Todos


main : Program Never
main =
    Html.App.program
        { init = Todos.init
        , view = Todos.view
        , update = Todos.update
        , subscriptions = Todos.subscriptions
        }
