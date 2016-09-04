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
import Json.Encode exposing (..)
import Json.Decode exposing (..)
import Navigation exposing (modifyUrl)
import Env.Current exposing (basePath, baseApiUrl)
import OAuth.Types
import OAuth.Update
import OAuth.Helpers
    exposing
        ( getOAuthDetailsUrlForAccessToken
        , decodeUserDetails
        )
import Todos.Types
    exposing
        ( Model
        , Todo
        , User
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


noFx : Model -> ( Model, Cmd Msg )
noFx model =
    ( model, Cmd.none )


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
                noFx modelUpdatedForPath

            Ok token ->
                update (UpdateOAuthAccessToken <| Just token) modelUpdatedForPath


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        CreateTodo ->
            noFx <| createTodo model

        UpdateText text ->
            noFx <| updateText text model

        MarkAsCompleted todo ->
            noFx <| markAsCompleted todo model

        MarkAsIncomplete todo ->
            noFx <| markAsIncomplete todo model

        Delete todo ->
            noFx <| delete todo model

        StartEditing todo ->
            noFx <| startEditing todo model

        UpdateTodo todo text ->
            noFx <| updateTodo todo text model

        StopEditing ->
            noFx <| stopEditing model

        Filter filterOption ->
            noFx <| setFilter filterOption model

        Save ->
            sendSaveRequest model

        SaveFail _ ->
            noFx model

        SaveSuccess _ ->
            noFx model

        Load ->
            sendLoadRequest model

        LoadFail err ->
            noFx model

        LoadSuccess user ->
            noFx <| updateUser user model

        GetOAuthDetailsFailed error ->
            noFx model

        GetOAuthDetailsSucceeded details ->
            updateOAuthDetails details model

        UpdateOAuthAccessToken token ->
            updateOAuthAccessToken token model

        SwitchTab tab ->
            switchTab tab model

        NoOp ->
            noFx model


updateUser : User -> Model -> Model
updateUser user model =
    { model | todos = user.todos }


encodeTodo : Todo -> Json.Encode.Value
encodeTodo todo =
    Json.Encode.object
        [ ( "id", Json.Encode.int todo.id )
        , ( "text", Json.Encode.string todo.text )
        , ( "completed", Json.Encode.bool todo.completed )
        ]


encodeTodos : List Todo -> Json.Encode.Value
encodeTodos todos =
    Json.Encode.list <| List.map encodeTodo todos


encodeUser : String -> List Todo -> Json.Encode.Value
encodeUser userId todos =
    let
        user =
            [ ( "id", Json.Encode.string userId )
            , ( "todos", encodeTodos todos )
            ]
    in
        Json.Encode.object user


sendSaveRequest : Model -> ( Model, Cmd Msg )
sendSaveRequest model =
    case model.oauth.userId of
        Nothing ->
            ( model, Cmd.none )

        Just userId ->
            let
                body =
                    Http.string
                        <| Json.Encode.encode 0
                        <| encodeUser userId model.todos

                request =
                    { verb = "POST"
                    , headers = [ ( "Content-type", "application/json" ) ]
                    , url = Env.Current.baseApiUrl ++ "/users"
                    , body = body
                    }

                httpRequest =
                    Http.send Http.defaultSettings request

                responseJson =
                    Http.fromJson decodeSaveResponse httpRequest

                cmd =
                    Task.perform SaveFail SaveSuccess responseJson
            in
                ( model, cmd )


decodeSaveResponse : Json.Decode.Decoder Int
decodeSaveResponse =
    "id" := Json.Decode.int


decodeTodo : Json.Decode.Decoder Todo
decodeTodo =
    Json.Decode.object3 Todo
        ("id" := Json.Decode.int)
        ("text" := Json.Decode.string)
        ("completed" := Json.Decode.bool)


decodeUser : Json.Decode.Decoder User
decodeUser =
    Json.Decode.object2 User
        ("id" := Json.Decode.int)
        ("todos" := Json.Decode.list decodeTodo)


sendLoadRequest : Model -> ( Model, Cmd Msg )
sendLoadRequest model =
    case model.oauth.userId of
        Nothing ->
            ( model, Cmd.none )

        Just userId ->
            let
                httpRequest =
                    Http.get decodeUser
                        <| Env.Current.baseApiUrl
                        ++ "/users/"
                        ++ userId

                cmd =
                    Task.perform LoadFail LoadSuccess httpRequest
            in
                ( model, cmd )


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
                ( newModel, modifyUrl <| basePath ++ "/#info" )


getUserDetails : String -> Cmd Msg
getUserDetails accessToken =
    let
        url =
            getOAuthDetailsUrlForAccessToken accessToken
    in
        Task.perform GetOAuthDetailsFailed GetOAuthDetailsSucceeded
            <| Http.get decodeUserDetails url


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
                noFx newModel

            Just accessToken ->
                case accessToken of
                    "" ->
                        noFx newModel

                    _ ->
                        ( newModel, getUserDetails accessToken )


updateOAuthDetails : ( String, String ) -> Model -> ( Model, Cmd Msg )
updateOAuthDetails ( userName, userId ) model =
    let
        newModel =
            { model
                | oauth = OAuth.Update.update (OAuth.Types.UpdateUserDetails (Just userName) (Just userId)) model.oauth
            }
    in
        update Load newModel


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
