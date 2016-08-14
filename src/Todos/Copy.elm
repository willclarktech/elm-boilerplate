module Todos.Copy
    exposing
        ( headingText
        , placeholderText
        , getButtonText
        )

import Todos.Types exposing (Error(..))


headingText : String
headingText =
    "todos"


placeholderText : String
placeholderText =
    "What needs to be done?"


getButtonText : String -> String
getButtonText buttonId =
    case buttonId of
        "filter-all" ->
            "All"

        "filter-completed" ->
            "Completed"

        "filter-incomplete" ->
            "Incomplete"

        _ ->
            "OK"
