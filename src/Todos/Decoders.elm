module Todos.Decoders exposing (decodeSaveResponse, decodeUser)

import Json.Decode exposing (..)
import Todos.Types exposing (Todo, User)


decodeSaveResponse : Decoder Int
decodeSaveResponse =
    "id" := int


decodeUser : Decoder User
decodeUser =
    object2 User
        ("id" := int)
        ("todos" := list decodeTodo)


decodeTodo : Decoder Todo
decodeTodo =
    object3 Todo
        ("id" := int)
        ("text" := string)
        ("completed" := bool)
