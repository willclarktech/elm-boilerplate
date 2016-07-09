module App.Steps.Context exposing (..)

import App.Todos
    exposing
        ( Model
        , Msg
        , initialModel
        )


type alias TodoCtx =
    { model : Model
    , result : Maybe Model
    , newText : Maybe String
    , existingTodo : Maybe String
    }


type alias KeyPressCtx =
    { result : Maybe Msg }


initialTodoCtx : TodoCtx
initialTodoCtx =
    { model = initialModel
    , result = Nothing
    , newText = Nothing
    , existingTodo = Nothing
    }


initialKeyPressCtx : KeyPressCtx
initialKeyPressCtx =
    { result = Nothing }
