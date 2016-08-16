module Todos.UrlParser exposing (urlParser)

import Navigation
import OAuth.UrlParser


urlParser : Navigation.Parser (Result String String)
urlParser =
    OAuth.UrlParser.urlParser
