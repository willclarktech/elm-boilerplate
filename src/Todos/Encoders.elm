module Todos.Encoders exposing (encodeUpdateUserTodosRequestBody, encodeQueryUserRequestBody)

import Http
import Json.Encode exposing (..)
import Todos.Types exposing (User, Todo)
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


encodeUpdateUserTodosRequestBody : User -> Http.Body
encodeUpdateUserTodosRequestBody user =
    let
        query =
            string "mutation updateUserTodos($user: UserInput!) { updateUserTodos(user: $user) { id todos { id text completed } } }"

        variables =
            object [ ( "user", encodeUser user ) ]
    in
        constructRequestBody query variables


encodeUser : User -> Value
encodeUser { id, todos } =
    object
        [ ( "id", string id )
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
