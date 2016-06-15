module App.Demo exposing (init, update, view, subscriptions)

import Html exposing (Html, h1, text)

type Msg
  = ShowDemo
  | HideDemo

type alias Model = {}

init : (Model, Cmd a)
init =
  noFx
    {}

update : Msg -> Model -> (Model, Cmd a)
update action model = noFx model

view : Model -> Html Msg
view model =
  h1
    []
    [ text "Example App" ]

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

noFx : Model -> (Model, Cmd a)
noFx model =
  (model, Cmd.none)
