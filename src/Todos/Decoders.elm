module Todos.Decoders exposing (decodeUpdateUserTodosResponse, decodeQueryUserResponse)

import Json.Decode exposing (..)
import Todos.Types exposing (Todo, User, UserGraph, UserGraphResponse)


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


decodeQueryUserResponse : Decoder UserGraphResponse
decodeQueryUserResponse =
    object1 UserGraphResponse
        ("data" := decodeUserGraph)


decodeUpdateUserTodosResponse : Decoder UserGraphResponse
decodeUpdateUserTodosResponse =
    object1 UserGraphResponse
        ("data" := decodeUserGraph)
