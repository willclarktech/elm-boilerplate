module OAuth.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import OAuth.Types exposing (Model)


view : Model -> Html a
view { accessToken, userName, clientId, redirectUri } =
    case ( accessToken, userName ) of
        ( Just token, Just name ) ->
            viewFbStatus token name

        _ ->
            viewFbLogin clientId redirectUri


viewFbStatus : String -> String -> Html a
viewFbStatus token name =
    let
        fbProfilePictureUrl =
            Http.url "https://graph.facebook.com/me/picture"
                [ ( "access_token", token ) ]
    in
        button
            [ id "fb-status"
            , class "ui large inverted right floated button"
            ]
            [ span [ style [ ( "margin-right", "10px" ) ] ]
                [ text name ]
            , img
                [ src fbProfilePictureUrl
                , class "ui middle aligned content inverted circular image"
                ]
                []
            ]


viewFbLogin : String -> String -> Html a
viewFbLogin clientId redirectUri =
    let
        fbOAuthLink =
            Http.url "https://www.facebook.com/dialog/oauth"
                [ ( "client_id", clientId )
                , ( "redirect_uri", redirectUri )
                , ( "response_type", "token" )
                ]
    in
        a
            [ id "fb-login"
            , class "ui large inverted right floated button"
            , href fbOAuthLink
            ]
            [ text "Login with Facebook" ]
