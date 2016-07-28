module Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        )


type alias Model =
    { counter : Int
    , todos : List Todo
    , currentText : String
    }


type alias Todo =
    { id : Int
    , text : String
    , completed : Bool
    }


type Msg
    = CreateTodo
    | UpdateText String
    | MarkAsCompleted Todo
    | MarkAsIncomplete Todo
    | Delete Todo
    | NoOp
