module OAuth.Copy
    exposing
        ( getErrorText
        )

import OAuth.Types exposing (Error(..))


getErrorText : Error -> String
getErrorText error =
    case error of
        FbAccessTokenNotFound ->
            "Facebook access token not found in url string"

        _ ->
            "Unknown error"
