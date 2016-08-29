module Todos.UrlParser exposing (urlParser)

import Navigation
import String
import Todos.Types exposing (ProcessedLocation)
import OAuth.UrlParser
import Env.Current exposing (basePath)


urlParser : Navigation.Parser (Result String ProcessedLocation)
urlParser =
    Navigation.makeParser parseLocation


parseLocation : Navigation.Location -> Result String ProcessedLocation
parseLocation location =
    Ok
        { path = getPathExtensionFromPathname location.pathname
        , accessToken = OAuth.UrlParser.getDataFromLocation location
        }


getPathExtensionFromPathname : String -> String
getPathExtensionFromPathname pathname =
    let
        potentialBase =
            String.left (String.length basePath) pathname
    in
        if potentialBase == basePath then
            String.dropLeft (String.length basePath) pathname
        else
            pathname
