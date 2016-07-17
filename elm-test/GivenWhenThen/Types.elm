module GivenWhenThen.Types
    exposing
        ( GivenStep
        , GivenStepMap
        , GivenFunction
        , WhenStep
        , WhenStepMap
        , WhenFunction
        , ThenStep
        , ThenStepMap
        , ThenFunction
        )

import ElmTestBDDStyle exposing (Assertion, Test)


type alias Pre ctx =
    List (ctx -> Test) -> ctx -> Test


type alias Given ctx =
    Pre ctx


type alias When ctx =
    Pre ctx


type alias Then ctx =
    ctx -> Test


type alias GivenFunction ctx =
    String -> Given ctx


type alias WhenFunction ctx =
    String -> When ctx


type alias ThenFunction ctx =
    String -> Then ctx


type alias GivenStep ctx =
    ctx -> ctx


type alias WhenStep ctx =
    ctx -> ctx


type alias ThenStep ctx =
    ctx -> Assertion


type alias GivenStepMap ctx =
    List ( String, GivenStep ctx )


type alias WhenStepMap ctx =
    List ( String, WhenStep ctx )


type alias ThenStepMap ctx =
    List ( String, ThenStep ctx )
