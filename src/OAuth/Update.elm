module OAuth.Update
    exposing
        ( initialModel
        , update
        )

import OAuth.Types exposing (Model, Msg(..))


initialModel : Model
initialModel =
    { accessToken = Nothing
    , userName = Nothing
    }


update : Msg -> Model -> Model
update action model =
    case action of
        UpdateAccessToken token ->
            updateFbAccessToken token model

        UpdateUserName name ->
            updateFbName name model


updateFbName : Maybe String -> Model -> Model
updateFbName userName model =
    { model | userName = userName }


updateFbAccessToken : Maybe String -> Model -> Model
updateFbAccessToken accessToken model =
    { model | accessToken = accessToken }
