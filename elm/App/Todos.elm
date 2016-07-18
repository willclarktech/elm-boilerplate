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
        , markAsCompleted
        , Msg(..)
        , Model
        , Todo
        )

import Json.Decode as Json
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
    exposing
        ( onInput
        , onClick
        , on
        , keyCode
        )


type Msg
    = CreateTodo
    | UpdateText String
    | MarkAsCompleted Todo
    | NoOp


type alias Model =
    { todos : List Todo
    , currentText : String
    }


type alias Todo =
    { text : String
    , completed : Bool
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

        MarkAsCompleted todo ->
            ( markAsCompleted todo model, Cmd.none )

        _ ->
            noFx model


updateText : String -> Model -> Model
updateText text model =
    { model
        | currentText = text
    }


createTodo : Model -> Model
createTodo model =
    let
        newTodo =
            Todo model.currentText False
    in
        { model
            | todos = newTodo :: model.todos
            , currentText = ""
        }


findTodoAndMarkAsComplete : List Todo -> Todo -> List Todo
findTodoAndMarkAsComplete todos todo =
    case todos of
        [] ->
            []

        firstTodo :: remainingTodos ->
            { firstTodo | completed = True } :: remainingTodos


markAsCompleted : Todo -> Model -> Model
markAsCompleted todo model =
    let
        newTodos =
            findTodoAndMarkAsComplete model.todos todo
    in
        { model
            | todos = newTodos
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


viewTodo : Todo -> Html Msg
viewTodo todo =
    let
        className =
            if todo.completed then
                "completed"
            else
                ""
    in
        li [ class className ]
            [ input
                [ class "toggle"
                , type' "checkbox"
                , onClick <| MarkAsCompleted todo
                ]
                []
            , label [] [ text todo.text ]
            ]


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
