module OAuth.Helpers exposing (decodeUserDetails, getOAuthDetailsUrlForAccessToken)

import Json.Decode exposing (..)
import Http


getOAuthDetailsUrlForAccessToken : String -> String
getOAuthDetailsUrlForAccessToken accessToken =
    Http.url "https://graph.facebook.com/me"
        [ ( "fields", "name" )
        , ( "access_token", accessToken )
        ]


decodeUserDetails : Decoder ( String, String )
decodeUserDetails =
    Json.Decode.object2 (,)
        ("name" := Json.Decode.string)
        ("id" := Json.Decode.string)
