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
        , startEditing
        , updateTodo
        , stopEditing
        , setFilter
        )

import Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        , FilterOption(..)
        )
import String exposing (trim)


initialModel : Model
initialModel =
    { counter = 0
    , todos = []
    , filterOption = All
    , currentText = ""
    , currentlyEditing = Nothing
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

        StartEditing todo ->
            ( startEditing todo model, Cmd.none )

        UpdateTodo todo text ->
            ( updateTodo todo text model, Cmd.none )

        StopEditing ->
            ( stopEditing model, Cmd.none )

        Filter filterOption ->
            ( setFilter filterOption model, Cmd.none )

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
            Todo model.counter (String.trim model.currentText) False
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
            if firstTodo.id == todo.id then
                { firstTodo | completed = status } :: remainingTodos
            else
                firstTodo :: findTodoAndSetStatus remainingTodos todo status


setCompleteStatusForTodoInModel : Todo -> Model -> Bool -> Model
setCompleteStatusForTodoInModel todo model status =
    { model
        | todos = findTodoAndSetStatus model.todos todo status
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


startEditing : Todo -> Model -> Model
startEditing todo model =
    { model
        | currentlyEditing = Just todo
    }


findTodoAndSetText : List Todo -> Todo -> String -> List Todo
findTodoAndSetText todos todo text =
    case todos of
        [] ->
            []

        firstTodo :: remainingTodos ->
            if firstTodo.id == todo.id then
                { firstTodo | text = text } :: remainingTodos
            else
                firstTodo :: findTodoAndSetText remainingTodos todo text


updateTodo : Todo -> String -> Model -> Model
updateTodo todo text model =
    { model
        | todos = findTodoAndSetText model.todos todo text
    }


stopEditing : Model -> Model
stopEditing model =
    { model
        | currentlyEditing = Nothing
    }


setFilter : FilterOption -> Model -> Model
setFilter filterOption model =
    { model
        | filterOption = filterOption
    }
