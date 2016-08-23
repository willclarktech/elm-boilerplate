module Env.Current exposing (clientId, redirectUri)

import Env.Development as Env


clientId : String
clientId =
    Env.clientId


redirectUri : String
redirectUri =
    Env.redirectUri
