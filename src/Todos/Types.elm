module Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        , FilterOption(..)
        )

import OAuth.Types
import Http


type alias Model =
    { counter : Int
    , todos : List Todo
    , filterOption : FilterOption
    , currentText : String
    , currentlyEditing : Maybe Todo
    , oauth : OAuth.Types.Model
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
    | GetOAuthNameSucceeded String
    | GetOAuthNameFailed Http.Error
    | UpdateOAuthAccessToken (Maybe String)
    | NoOp
