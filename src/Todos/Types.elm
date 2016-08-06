module Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        , FilterOption(..)
        )


type alias Model =
    { counter : Int
    , todos : List Todo
    , filterOption : FilterOption
    , currentText : String
    , currentlyEditing : Maybe Todo
    }


type alias Todo =
    { id : Int
    , text : String
    , completed : Bool
    }


type FilterOption
    = All
    | Completed
    | Incomplete


type Msg
    = CreateTodo
    | UpdateText String
    | MarkAsCompleted Todo
    | MarkAsIncomplete Todo
    | Delete Todo
    | StartEditing Todo
    | UpdateTodo Todo String
    | StopEditing
    | Filter FilterOption
    | NoOp
