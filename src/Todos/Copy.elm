module Todos.Copy
    exposing
        ( headingMD
        , placeholderText
        , getButtonText
        )


headingMD : String
headingMD =
    """
# todos
"""


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
