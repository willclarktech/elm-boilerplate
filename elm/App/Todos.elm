module App.Todos
    exposing
        ( init
        , update
        , view
        , subscriptions
        , initialModel
        , handleKeyUp
        , updateText
        , createTodo
        , Msg(..)
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, on, keyCode)
import Json.Decode as Json


type Msg
    = CreateTodo
    | UpdateText String
    | NoOp


type alias Model =
    { todos : List String
    , currentText : String
    }


initialModel : Model
initialModel =
    { todos = []
    , currentText = ""
    }


noFx : Model -> ( Model, Cmd a )
noFx model =
    ( model, Cmd.none )


init : ( Model, Cmd a )
init =
    noFx initialModel


update : Msg -> Model -> ( Model, Cmd a )
update action model =
    case action of
        CreateTodo ->
            ( createTodo model, Cmd.none )

        UpdateText text ->
            ( updateText text model, Cmd.none )

        _ ->
            noFx model


updateText : String -> Model -> Model
updateText text model =
    { model
        | currentText = text
    }


createTodo : Model -> Model
createTodo model =
    { model
        | todos = model.currentText :: model.todos
        , currentText = ""
    }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Example App" ]
        , input
            [ id "new-todo"
            , on "keyup" <| Json.map handleKeyUp keyCode
            , onInput UpdateText
            , value model.currentText
            ]
            []
        , ul [] <| List.map viewTodo model.todos
        ]


viewTodo : String -> Html Msg
viewTodo todo =
    li []
        [ label [] [ text todo ] ]


handleKeyUp : Int -> Msg
handleKeyUp keyCode =
    case isEnter keyCode of
        True ->
            CreateTodo

        False ->
            NoOp


isEnter : Int -> Bool
isEnter keyCode =
    keyCode == 13


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
