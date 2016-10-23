module Todos.Decoders exposing (decodeSaveResponse, decodeQueryUserResponse)

import Json.Decode exposing (..)
import Todos.Types exposing (Todo, User, UserGraph, QueryUserResponse)


decodeSaveResponse : Decoder Int
decodeSaveResponse =
    "id" := int


decodeTodo : Decoder Todo
decodeTodo =
    object3 Todo
        ("id" := int)
        ("text" := string)
        ("completed" := bool)


decodeUser : Decoder User
decodeUser =
    object2 User
        ("id" := string)
        ("todos" := list decodeTodo)


decodeUserGraph : Decoder UserGraph
decodeUserGraph =
    object1 UserGraph
        ("user" := decodeUser)


decodeQueryUserResponse : Decoder QueryUserResponse
decodeQueryUserResponse =
    object1 QueryUserResponse
        ("data" := decodeUserGraph)
