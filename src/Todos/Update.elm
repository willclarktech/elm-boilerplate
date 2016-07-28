module Todos.Update
    exposing
        ( initialModel
        , init
        , update
        , updateText
        , createTodo
        , markAsCompleted
        , markAsIncomplete
        , delete
        , subscriptions
        )

import Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        )


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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
