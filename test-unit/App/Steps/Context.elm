module App.Steps.Context exposing (..)

import App.Todos
    exposing
        ( Model
        , Todo
        , Msg
        , initialModel
        )


type alias Context =
    { model : Maybe Model
    , initialCount : Maybe Int
    , currentText : Maybe String
    , newText : Maybe String
    , existingTodo : Maybe Todo
    , secondTodo : Maybe Todo
    , messageAfter : Maybe Msg
    }


initialContext : Context
initialContext =
    Context Nothing Nothing Nothing Nothing Nothing Nothing Nothing


getModel : Context -> Model
getModel ctx =
    case ctx.model of
        Just model ->
            model

        Nothing ->
            initialModel
