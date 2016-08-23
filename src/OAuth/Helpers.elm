module OAuth.Helpers exposing (decodeUserName, getOAuthNameUrlForAccessToken)

import Json.Decode exposing (..)
import Http


getOAuthNameUrlForAccessToken : String -> String
getOAuthNameUrlForAccessToken accessToken =
    Http.url "https://graph.facebook.com/me"
        [ ( "fields", "name" )
        , ( "access_token", accessToken )
        ]


decodeUserName : Decoder String
decodeUserName =
    "name" := Json.Decode.string
