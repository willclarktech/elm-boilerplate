module OAuth.UrlParser exposing (getDataFromLocation)

import String
import Navigation
import OAuth.Types exposing (Error(..))
import OAuth.Copy exposing (getErrorText)


getDataFromLocation : Navigation.Location -> Result String String
getDataFromLocation =
    getFbAccessTokenFromHash << .hash


getFbAccessTokenFromHash : String -> Result String String
getFbAccessTokenFromHash hash =
    case trimLeftOfAccessToken hash of
        Ok trimmedHash ->
            Ok <| trimRightOfAccessToken trimmedHash

        err ->
            err


trimLeftOfAccessToken : String -> Result String String
trimLeftOfAccessToken hash =
    let
        accessTokenString =
            "access_token="

        accessTokenIndex =
            String.indices accessTokenString hash
    in
        case accessTokenIndex of
            i :: is ->
                Ok <| String.dropLeft (i + String.length accessTokenString) hash

            _ ->
                Err <| getErrorText FbAccessTokenNotFound


trimRightOfAccessToken : String -> String
trimRightOfAccessToken hash =
    case String.uncons hash of
        Nothing ->
            ""

        Just ( '&', remainder ) ->
            ""

        Just ( tokenPart, remainder ) ->
            String.cons tokenPart <| trimRightOfAccessToken remainder
