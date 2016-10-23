module Helpers exposing (isEnter, constructRequestBody, sendRequest)

import Http
import Json.Encode exposing (..)
import Env.Current exposing (baseApiUrl)


isEnter : Int -> Bool
isEnter keyCode =
    keyCode == 13


constructRequestBody : Value -> Value -> Http.Body
constructRequestBody query variables =
    Http.string
        <| encode 0
        <| object [ ( "query", query ), ( "variables", variables ) ]


sendRequest : Http.Body -> Platform.Task Http.RawError Http.Response
sendRequest body =
    Http.send Http.defaultSettings
        <| { verb = "POST"
           , url = baseApiUrl
           , headers = [ ( "Content-type", "application/json" ) ]
           , body = body
           }
