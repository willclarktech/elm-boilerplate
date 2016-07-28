module Main exposing (..)

import Html.App
import Todos.Todos as Todos
import Todos.Update as Update
import Todos.View as View


main : Program Never
main =
    Html.App.program
        { init = Update.init
        , view = View.view
        , update = Update.update
        , subscriptions = Update.subscriptions
        }
