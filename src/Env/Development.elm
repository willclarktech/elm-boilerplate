module Env.Development exposing (basePath, clientId, redirectUri)

-- Test app
--
-- Facebook:
-- https://developers.facebook.com/apps/171280426615613/dashboard/


baseUrl : String
baseUrl =
    "http://localhost:3000"


basePath : String
basePath =
    ""


redirectUri : String
redirectUri =
    baseUrl ++ basePath ++ "/"


clientId : String
clientId =
    "171280426615613"
