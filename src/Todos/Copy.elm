module Todos.Copy
    exposing
        ( tabText
        , placeholderText
        , getButtonText
        , infoMD
        )

import Todos.Types exposing (Tab(..))


tabText : Tab -> String
tabText tab =
    case tab of
        Todos ->
            "todos"

        Info ->
            "info"


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

        "save" ->
            "Save"

        _ ->
            "OK"


infoMD : String
infoMD =
    """
# What’s it all about?

This is a boilerplate project for building front end apps with elm.

The source code and more info can be found [here](https://github.com/LikeJasper/elm-boilerplate).

The backend is yet to be written, so network requests are sent to a presumed REST API when you login or when you click "Save", but for the meantime there is no such functionality on this live site. See the repo for how to mock this functionality locally.
"""
