module OAuth.Types
    exposing
        ( Model
        , Msg(..)
        , Error(..)
        )


type alias Model =
    { clientId : String
    , redirectUri : String
    , accessToken : Maybe String
    , userName : Maybe String
    }


type Msg
    = UpdateAccessToken (Maybe String)
    | UpdateUserName (Maybe String)


type Error
    = FbAccessTokenNotFound
    | Unknown
