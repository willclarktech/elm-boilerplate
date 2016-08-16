module OAuth.Helpers exposing (decodeUserName, getOAuthNameUrlForAccessToken)

import Json.Decode exposing (..)


getOAuthNameUrlForAccessToken : String -> String
getOAuthNameUrlForAccessToken accessToken =
    "https://graph.facebook.com/me"
        ++ "?fields=name"
        ++ "&access_token="
        ++ accessToken


decodeUserName : Decoder String
decodeUserName =
    "name" := Json.Decode.string
