module Env.Production exposing (basePath, clientId, redirectUri)

-- Production app
--
-- Facebook:
-- https://developers.facebook.com/apps/171263736617282/dashboard/


baseUrl : String
baseUrl =
    "http://willclark.tech"


basePath : String
basePath =
    "/elm-boilerplate"


redirectUri : String
redirectUri =
    baseUrl ++ basePath ++ "/"


clientId : String
clientId =
    "171263736617282"
