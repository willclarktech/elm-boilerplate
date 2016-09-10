module Todos.Encoders exposing (encodeSaveRequest, encodeUser)

import Json.Encode exposing (..)
import Todos.Types exposing (Todo)


encodeSaveRequest : String -> List Todo -> String
encodeSaveRequest userId todos =
    encode 0
        <| encodeUser userId todos


encodeUser : String -> List Todo -> Value
encodeUser userId todos =
    object
        [ ( "id", string userId )
        , ( "todos", encodeTodos todos )
        ]


encodeTodos : List Todo -> Value
encodeTodos todos =
    list <| List.map encodeTodo todos


encodeTodo : Todo -> Value
encodeTodo todo =
    object
        [ ( "id", int todo.id )
        , ( "text", string todo.text )
        , ( "completed", bool todo.completed )
        ]
