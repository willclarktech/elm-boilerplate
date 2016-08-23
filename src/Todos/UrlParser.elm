module Todos.UrlParser exposing (urlParser)

import Navigation
import Todos.Types exposing (ProcessedLocation)
import OAuth.UrlParser


urlParser : Navigation.Parser (Result String ProcessedLocation)
urlParser =
    Navigation.makeParser parseLocation


parseLocation : Navigation.Location -> Result String ProcessedLocation
parseLocation location =
    Ok
        { path = location.pathname
        , accessToken = OAuth.UrlParser.getDataFromLocation location
        }
