module Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        , Tab(..)
        , FilterOption(..)
        , ProcessedLocation
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
    , tab : Tab
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


type Tab
    = Todos
    | Info


type alias ProcessedLocation =
    { path : String
    , accessToken : Result String String
    }


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
    | SwitchTab Tab
    | NoOp
