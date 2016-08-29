module Todos.Update
    exposing
        ( initialModel
        , init
        , urlUpdate
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

import String exposing (trim)
import Task
import Http
import Navigation exposing (modifyUrl)
import Env.Current exposing (basePath)
import OAuth.Types
import OAuth.Update
import OAuth.Helpers
    exposing
        ( getOAuthNameUrlForAccessToken
        , decodeUserName
        )
import Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        , Tab(..)
        , FilterOption(..)
        , ProcessedLocation
        )


initialModel : Model
initialModel =
    { counter = 0
    , todos = []
    , filterOption = All
    , currentText = ""
    , currentlyEditing = Nothing
    , oauth = OAuth.Update.initialModel
    , tab = Todos
    }


init : Result String ProcessedLocation -> ( Model, Cmd Msg )
init result =
    urlUpdate result initialModel


urlUpdate : Result String ProcessedLocation -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    case result of
        Err _ ->
            update NoOp model

        Ok { path, accessToken } ->
            updatePathAndAccessToken path accessToken model


updatePathAndAccessToken : String -> Result String String -> Model -> ( Model, Cmd Msg )
updatePathAndAccessToken path accessToken model =
    let
        modelUpdatedForPath =
            case path of
                "" ->
                    { model | tab = Todos }

                "info" ->
                    { model | tab = Info }

                _ ->
                    model
    in
        case accessToken of
            Err _ ->
                ( model, Cmd.none )

            Ok token ->
                update (UpdateOAuthAccessToken <| Just token) model


update : Msg -> Model -> ( Model, Cmd Msg )
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

        GetOAuthNameFailed error ->
            ( model, Cmd.none )

        GetOAuthNameSucceeded name ->
            ( updateOAuthName name model, Cmd.none )

        UpdateOAuthAccessToken token ->
            updateOAuthAccessToken token model

        SwitchTab tab ->
            switchTab tab model

        NoOp ->
            ( model, Cmd.none )


switchTab : Tab -> Model -> ( Model, Cmd Msg )
switchTab tab model =
    let
        newModel =
            { model | tab = tab }
    in
        case tab of
            Todos ->
                ( newModel, modifyUrl <| basePath ++ "/" )

            Info ->
                ( newModel, modifyUrl <| basePath ++ "/info" )


getUserName : String -> Cmd Msg
getUserName accessToken =
    let
        url =
            getOAuthNameUrlForAccessToken accessToken
    in
        Task.perform GetOAuthNameFailed GetOAuthNameSucceeded
            <| Http.get decodeUserName url


updateOAuthAccessToken : Maybe String -> Model -> ( Model, Cmd Msg )
updateOAuthAccessToken accessToken model =
    let
        newOAuth =
            OAuth.Update.update (OAuth.Types.UpdateAccessToken accessToken) model.oauth

        newModel =
            { model
                | oauth = newOAuth
            }
    in
        case newOAuth.accessToken of
            Nothing ->
                ( newModel, Cmd.none )

            Just accessToken ->
                case accessToken of
                    "" ->
                        ( newModel, Cmd.none )

                    _ ->
                        ( newModel, getUserName accessToken )


updateOAuthName : String -> Model -> Model
updateOAuthName name model =
    { model
        | oauth = OAuth.Update.update (OAuth.Types.UpdateUserName (Just name)) model.oauth
    }


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
