module Env.Production exposing (baseUrl, basePath, baseApiUrl, clientId)

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


baseApiUrl : String
baseApiUrl =
    baseUrl ++ basePath ++ "/api"


clientId : String
clientId =
    "171263736617282"
