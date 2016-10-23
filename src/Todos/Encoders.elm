module Todos.Encoders exposing (encodeSaveRequest, encodeQueryUserRequestBody)

import Http
import Json.Encode exposing (..)
import Todos.Types exposing (Todo)
import Helpers exposing (constructRequestBody)


encodeQueryUserRequestBody : String -> Http.Body
encodeQueryUserRequestBody userId =
    let
        query =
            string "query queryUser($userId: String!) { user(id: $userId) { id todos { id text completed } } }"

        variables =
            object [ ( "userId", string userId ) ]
    in
        constructRequestBody query variables


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
