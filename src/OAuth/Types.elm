module OAuth.Types
    exposing
        ( Model
        , Error(..)
        )


type alias Model =
    { fbAccessToken : Maybe String
    }


type Error
    = FbAccessTokenNotFound
    | Unknown
