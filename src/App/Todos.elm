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
import Markdown
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
    exposing
        ( onInput
        , onClick
        , on
        , keyCode
        )
import Copy.Todos exposing (headingMD, placeholderText)


type Msg
    = CreateTodo
    | UpdateText String
    | MarkAsCompleted Todo
    | NoOp


type alias Model =
    { counter : Int
    , todos : List Todo
    , currentText : String
    }


type alias Todo =
    { id : Int
    , text : String
    , completed : Bool
    }


initialModel : Model
initialModel =
    { counter = 0
    , todos = []
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
            Todo model.counter model.currentText False
    in
        { model
            | todos = newTodo :: model.todos
            , currentText = ""
            , counter = model.counter + 1
        }


findTodoAndMarkAsComplete : List Todo -> Todo -> List Todo
findTodoAndMarkAsComplete todos todo =
    case todos of
        [] ->
            []

        firstTodo :: remainingTodos ->
            let
                isRelevantTodo =
                    firstTodo.id == todo.id
            in
                case isRelevantTodo of
                    True ->
                        { firstTodo | completed = True } :: remainingTodos

                    False ->
                        firstTodo :: findTodoAndMarkAsComplete remainingTodos todo


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
        [ Markdown.toHtml [] headingMD
        , input
            [ id "new-todo"
            , placeholder placeholderText
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
        li
            [ id ("todo-" ++ toString todo.id)
            , class className
            ]
            [ input
                [ class "toggle"
                , type' "checkbox"
                , onClick <| MarkAsCompleted todo
                , checked todo.completed
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
