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
import Html.Events exposing (on, keyCode)
import Json.Decode as Json
import String exposing (fromChar, dropRight)


type Msg
    = CreateTodo
    | UpdateText Int
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


init : ( Model, Cmd a )
init =
    noFx initialModel


update : Msg -> Model -> ( Model, Cmd a )
update action model =
    case action of
        CreateTodo ->
            ( createTodo model, Cmd.none )

        UpdateText keyCode ->
            ( updateText keyCode model, Cmd.none )

        _ ->
            noFx model


updateText : Int -> Model -> Model
updateText keyCode model =
    case isDelete keyCode of
        True ->
            { model
                | currentText = String.dropRight 1 model.currentText
            }

        False ->
            case getCharString keyCode of
                Nothing ->
                    model

                Just charString ->
                    { model
                        | currentText = model.currentText ++ String.fromChar charString
                    }


createTodo : Model -> Model
createTodo model =
    { model
        | todos = model.todos ++ [ model.currentText ]
        , currentText = ""
    }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Example App" ]
        , input
            [ id "new-todo"
            , on "keyup" <| Json.map handleKeyUp <| keyCode
            , value model.currentText
            ]
            []
        , ul [] <| List.map viewTodo model.todos
        ]


viewTodo : String -> Html Msg
viewTodo todo =
    li []
        [ label [] [ text todo ] ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


noFx : Model -> ( Model, Cmd a )
noFx model =
    ( model, Cmd.none )


handleKeyUp : Int -> Msg
handleKeyUp keyCode =
    case isEnter keyCode of
        True ->
            CreateTodo

        False ->
            UpdateText keyCode


isEnter : Int -> Bool
isEnter keyCode =
    keyCode == 13


isDelete : Int -> Bool
isDelete keyCode =
    keyCode == 8


getCharString : Int -> Maybe Char
getCharString keyCode =
    case keyCode of
        32 ->
            Just ' '

        48 ->
            Just '0'

        49 ->
            Just '1'

        50 ->
            Just '2'

        51 ->
            Just '3'

        52 ->
            Just '4'

        53 ->
            Just '5'

        54 ->
            Just '6'

        55 ->
            Just '7'

        56 ->
            Just '8'

        57 ->
            Just '9'

        65 ->
            Just 'a'

        66 ->
            Just 'b'

        67 ->
            Just 'c'

        68 ->
            Just 'd'

        69 ->
            Just 'e'

        70 ->
            Just 'f'

        71 ->
            Just 'g'

        72 ->
            Just 'h'

        73 ->
            Just 'i'

        74 ->
            Just 'j'

        75 ->
            Just 'k'

        76 ->
            Just 'l'

        77 ->
            Just 'm'

        78 ->
            Just 'n'

        79 ->
            Just 'o'

        80 ->
            Just 'p'

        81 ->
            Just 'q'

        82 ->
            Just 'r'

        83 ->
            Just 's'

        84 ->
            Just 't'

        85 ->
            Just 'u'

        86 ->
            Just 'v'

        87 ->
            Just 'w'

        88 ->
            Just 'x'

        89 ->
            Just 'y'

        90 ->
            Just 'z'

        107 ->
            Just '+'

        109 ->
            Just '-'

        186 ->
            Just ';'

        187 ->
            Just '='

        188 ->
            Just ','

        189 ->
            Just '–'

        190 ->
            Just '.'

        191 ->
            Just '/'

        219 ->
            Just '('

        220 ->
            Just '\\'

        221 ->
            Just ')'

        222 ->
            Just '\''

        _ ->
            Nothing
