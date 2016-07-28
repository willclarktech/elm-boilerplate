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
        , markAsIncomplete
        , delete
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
    | MarkAsIncomplete Todo
    | Delete Todo
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

        MarkAsIncomplete todo ->
            ( markAsIncomplete todo model, Cmd.none )

        Delete todo ->
            ( delete todo model, Cmd.none )

        NoOp ->
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


findTodoAndSetStatus : List Todo -> Todo -> Bool -> List Todo
findTodoAndSetStatus todos todo status =
    case todos of
        [] ->
            []

        firstTodo :: remainingTodos ->
            let
                isRelevantTodo =
                    firstTodo.id == todo.id
            in
                if isRelevantTodo then
                    { firstTodo | completed = status } :: remainingTodos
                else
                    firstTodo :: findTodoAndSetStatus remainingTodos todo status


setCompleteStatusForTodoInModel : Todo -> Model -> Bool -> Model
setCompleteStatusForTodoInModel todo model status =
    let
        newTodos =
            findTodoAndSetStatus model.todos todo status
    in
        { model
            | todos = newTodos
        }


markAsCompleted : Todo -> Model -> Model
markAsCompleted todo model =
    setCompleteStatusForTodoInModel todo model True


markAsIncomplete : Todo -> Model -> Model
markAsIncomplete todo model =
    setCompleteStatusForTodoInModel todo model False


delete : Todo -> Model -> Model
delete todo model =
    let
        newTodos =
            List.filter (\todoToCheck -> todoToCheck.id /= todo.id) model.todos
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
        complete =
            todo.completed

        className =
            if complete then
                "completed"
            else
                ""

        onToggleMsg =
            if complete then
                MarkAsIncomplete todo
            else
                MarkAsCompleted todo
    in
        li
            [ id ("todo-" ++ toString todo.id)
            , class className
            ]
            [ input
                [ class "toggle"
                , type' "checkbox"
                , onClick <| onToggleMsg
                , checked complete
                ]
                []
            , label [] [ text todo.text ]
            , span
                [ class "delete"
                , onClick <| Delete todo
                ]
                [ text "×" ]
            ]


handleKeyUp : Int -> Msg
handleKeyUp keyCode =
    if isEnter keyCode then
        CreateTodo
    else
        NoOp


isEnter : Int -> Bool
isEnter keyCode =
    keyCode == 13


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
