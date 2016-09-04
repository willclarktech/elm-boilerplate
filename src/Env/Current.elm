module Env.Current exposing (baseUrl, basePath, siteUrl, baseApiUrl, clientId, redirectUri)

import Env.Development as Env


baseUrl : String
baseUrl =
    Env.baseUrl


basePath : String
basePath =
    Env.basePath


siteUrl : String
siteUrl =
    baseUrl ++ basePath


baseApiUrl : String
baseApiUrl =
    Env.baseApiUrl


clientId : String
clientId =
    Env.clientId


redirectUri : String
redirectUri =
    siteUrl ++ "/"
