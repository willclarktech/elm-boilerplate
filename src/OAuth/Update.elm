module OAuth.Update
    exposing
        ( initialModel
        , init
        , update
        )

import OAuth.Types exposing (Model)


initialModel : Model
initialModel =
    { fbAccessToken = Nothing
    }


init : Result String String -> Model
init result =
    update result initialModel


updateFbAccessToken : Maybe String -> Model -> Model
updateFbAccessToken fbAccessToken model =
    { model
        | fbAccessToken = fbAccessToken
    }


update : Result String String -> Model -> Model
update result model =
    case result of
        Ok fbAccessToken ->
            updateFbAccessToken (Just fbAccessToken) model

        Err _ ->
            model
