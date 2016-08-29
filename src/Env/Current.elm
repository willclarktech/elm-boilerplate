module Env.Current exposing (basePath, clientId, redirectUri)

import Env.Development as Env


basePath : String
basePath =
    Env.basePath


clientId : String
clientId =
    Env.clientId


redirectUri : String
redirectUri =
    Env.redirectUri
