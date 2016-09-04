module OAuth.Types
    exposing
        ( Model
        , Msg(..)
        , Error(..)
        , AccessToken
        , UserName
        , UserId
        )


type alias Model =
    { clientId : String
    , redirectUri : String
    , accessToken : Maybe String
    , userName : Maybe String
    , userId : Maybe String
    }


type alias AccessToken =
    Maybe String


type alias UserName =
    Maybe String


type alias UserId =
    Maybe String


type Msg
    = UpdateAccessToken AccessToken
    | UpdateUserDetails UserName UserId


type Error
    = FbAccessTokenNotFound
    | Unknown
