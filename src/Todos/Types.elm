module Todos.Types
    exposing
        ( Model
        , Todo
        , User
        , Msg(..)
        , Tab(..)
        , FilterOption(..)
        , ProcessedLocation
        , Style
        , UserGraphResponse
        , UserGraph
        )

import OAuth.Types
import Http
import Material


type alias Model =
    { counter : Int
    , todos : List Todo
    , filterOption : FilterOption
    , currentText : String
    , currentlyEditing : Maybe Todo
    , oauth : OAuth.Types.Model
    , tab : Tab
    , mdl : Material.Model
    }


type alias Todo =
    { id : Int
    , text : String
    , completed : Bool
    }


type alias User =
    { id : String
    , todos : List Todo
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


type alias UserGraph =
    { user : User }


type alias UserGraphResponse =
    { data : UserGraph
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
    | Save
    | SaveFail Http.Error
    | SaveSuccess UserGraphResponse
    | Load
    | LoadFail Http.Error
    | LoadSuccess UserGraphResponse
    | GetOAuthDetailsSucceeded ( String, String )
    | GetOAuthDetailsFailed Http.Error
    | UpdateOAuthAccessToken (Maybe String)
    | SwitchTab Tab
    | UI (Material.Msg Msg)
    | NoOp


type alias Style =
    List ( String, String )
