module OAuth.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import OAuth.Types exposing (Model)


view : Model -> Html a
view { accessToken, userName } =
    case ( accessToken, userName ) of
        ( Just token, Just name ) ->
            viewFbStatus token name

        _ ->
            viewFbLogin


viewFbStatus : String -> String -> Html a
viewFbStatus token name =
    let
        fbProfilePictureUrl =
            "https://graph.facebook.com/me/picture"
                ++ "?access_token="
                ++ token
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


viewFbLogin : Html a
viewFbLogin =
    let
        fbOAuthLink =
            "https://www.facebook.com/dialog/oauth"
                ++ "?client_id=171280426615613"
                ++ "&redirect_uri=http://localhost:3000/"
                ++ "&response_type=token"
    in
        a
            [ id "fb-login"
            , class "ui large inverted right floated button"
            , href fbOAuthLink
            ]
            [ text "Login with Facebook" ]
