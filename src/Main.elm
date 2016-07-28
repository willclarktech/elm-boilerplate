module Main exposing (..)

import Html.App
import App.Todos as Todos
import App.View as View


main : Program Never
main =
    Html.App.program
        { init = Todos.init
        , view = View.view
        , update = Todos.update
        , subscriptions = Todos.subscriptions
        }
