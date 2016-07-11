module App.Steps.Types
    exposing
        ( GivenStepDefinition
        , GivenStep
        , GivenStepMap
        , GivenFunction
        , WhenStepDefinition
        , WhenStep
        , WhenStepMap
        , WhenFunction
        , ThenStepDefinition
        , ThenStep
        , ThenStepMap
        , ThenFunction
        )

import ElmTestBDDStyle exposing (Assertion, Test)


type alias PreStep ctx =
    List (ctx -> Test) -> ctx -> Test


type alias GivenStep ctx =
    PreStep ctx


type alias WhenStep ctx =
    PreStep ctx


type alias ThenStep ctx =
    ctx -> Test


type alias GivenStepDefinition ctx =
    ctx -> ctx


type alias WhenStepDefinition ctx =
    ctx -> ctx


type alias ThenStepDefinition ctx =
    ctx -> Assertion


type alias GivenStepMap ctx =
    List ( String, GivenStepDefinition ctx )


type alias WhenStepMap ctx =
    List ( String, WhenStepDefinition ctx )


type alias ThenStepMap ctx =
    List ( String, ThenStepDefinition ctx )


type alias GivenFunction ctx =
    String -> GivenStep ctx


type alias WhenFunction ctx =
    String -> WhenStep ctx


type alias ThenFunction ctx =
    String -> ThenStep ctx
