module Todos.Subscriptions exposing (subscriptions)

import Todos.Types exposing (Model, Msg)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
