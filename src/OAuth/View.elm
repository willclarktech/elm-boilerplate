module OAuth.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import OAuth.Types exposing (Model)


view : Model -> Html a
view model =
    case model.fbAccessToken of
        Just token ->
            a
                [ id "fb-status"
                , class "ui inverted right floated button"
                ]
                [ text "Logged in" ]

        Nothing ->
            let
                facebookOAuthLink =
                    "https://www.facebook.com/dialog/oauth"
                        ++ "?client_id=171280426615613"
                        ++ "&redirect_uri=http://localhost:3000/"
                        ++ "&response_type=token"
            in
                a
                    [ id "fb-login"
                    , class "ui inverted right floated button"
                    , href facebookOAuthLink
                    ]
                    [ text "Login with Facebook" ]
