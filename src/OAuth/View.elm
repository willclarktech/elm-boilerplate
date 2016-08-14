module OAuth.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import OAuth.Types exposing (Model)


view : Model -> Html a
view model =
    case model.fbAccessToken of
        Just token ->
            let
                fbProfilePictureUrl =
                    "https://graph.facebook.com/me/picture"
                        ++ "?access_token="
                        ++ token
            in
                a
                    [ id "fb-status"
                    , class "ui middle aligned content inverted right floated circular image"
                    ]
                    [ img [ src fbProfilePictureUrl ] [] ]

        Nothing ->
            let
                fbOAuthLink =
                    "https://www.facebook.com/dialog/oauth"
                        ++ "?client_id=171280426615613"
                        ++ "&redirect_uri=http://localhost:3000/"
                        ++ "&response_type=token"
            in
                a
                    [ id "fb-login"
                    , class "ui inverted right floated button"
                    , style [ ( "margin-top", "5px" ) ]
                    , href fbOAuthLink
                    ]
                    [ text "Login with Facebook" ]
