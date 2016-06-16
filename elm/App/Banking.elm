module App.Banking exposing (init, update, view, subscriptions)

import Html exposing (..)
import Html.Attributes exposing (..)

type Msg
  = DepositCheck
  | MakeTransfer

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
    [ text "Example App"
    , viewAccountSummary
    , viewDepositCheck
    ]

viewAccountSummary : Html Msg
viewAccountSummary =
  div
    [ class "account-summary" ]
    [ p
      [ class "balance" ]
      [ text "110" ]
    ]

viewDepositCheck : Html Msg
viewDepositCheck =
  div
    [ class "bank-deposit" ]
    [ input
      [ class "from-account-number" ]
      []
    , input
      [ class "branch-number" ]
      []
    , input
      [ class "amount" ]
      []
    , button
      [ type' "submit"
      , class "submit"
      ]
      [ text "Deposit check" ]
    ]

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

noFx : Model -> (Model, Cmd a)
noFx model =
  (model, Cmd.none)
