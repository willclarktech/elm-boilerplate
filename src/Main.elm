module Main exposing (..)

import Navigation
import Html exposing (Html)
import Todos.Types
import Todos.Update
import Todos.View
import OAuth.Types
import OAuth.UrlParser exposing (urlParser)
import OAuth.Update


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = (\model -> Sub.none)
        }


type alias Model =
    { todos : Todos.Types.Model
    , oauth : OAuth.Types.Model
    }


init : Result String String -> ( Model, Cmd Todos.Types.Msg )
init result =
    ( Model Todos.Update.init (OAuth.Update.init result)
    , Cmd.none
    )


update : Todos.Types.Msg -> Model -> ( Model, Cmd Todos.Types.Msg )
update msg model =
    let
        newTodos =
            Todos.Update.update msg model.todos
    in
        ( { model
            | todos = newTodos
          }
        , Cmd.none
        )


urlUpdate : Result String String -> Model -> ( Model, Cmd Todos.Types.Msg )
urlUpdate result model =
    let
        newOAuth =
            OAuth.Update.update result model.oauth
    in
        ( { model | oauth = newOAuth }, Cmd.none )


view : Model -> Html Todos.Types.Msg
view model =
    Todos.View.view model.todos model.oauth
