module OAuth.Update
    exposing
        ( initialModel
        , update
        )

import Env.Current exposing (clientId, redirectUri)
import OAuth.Types
    exposing
        ( Model
        , Msg(..)
        , AccessToken
        , UserName
        , UserId
        )


initialModel : Model
initialModel =
    { clientId = clientId
    , redirectUri = redirectUri
    , accessToken = Nothing
    , userName = Nothing
    , userId = Nothing
    }


update : Msg -> Model -> Model
update action model =
    case action of
        UpdateAccessToken token ->
            updateFbAccessToken token model

        UpdateUserDetails userName userId ->
            updateFbDetails ( userName, userId ) model


updateFbDetails : ( UserName, UserId ) -> Model -> Model
updateFbDetails ( userName, userId ) model =
    { model | userName = userName, userId = userId }


updateFbAccessToken : AccessToken -> Model -> Model
updateFbAccessToken accessToken model =
    { model | accessToken = accessToken }
