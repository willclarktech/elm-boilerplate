module Todos.UrlParser exposing (urlParser)

import Navigation
import String
import Todos.Types exposing (ProcessedLocation)
import OAuth.UrlParser


urlParser : Navigation.Parser (Result String ProcessedLocation)
urlParser =
    Navigation.makeParser parseLocation


parseLocation : Navigation.Location -> Result String ProcessedLocation
parseLocation location =
    Ok
        { path = String.dropLeft 1 location.hash
        , accessToken = OAuth.UrlParser.getDataFromLocation location
        }
