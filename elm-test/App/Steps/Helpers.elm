module App.Steps.Helpers
    exposing
        ( GivenStep
        , WhenStep
        , ThenStep
        , GivenStepDefinition
        , WhenStepDefinition
        , ThenStepDefinition
        , runTestsWithCtx
        , confirmIsJust
        , stepNotYetDefined
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


type alias PartialTest =
    Assertion -> Test


type alias PartialSuite =
    List Test -> Test


type alias GivenStepDefinition ctx =
    PartialSuite -> GivenStep ctx


type alias WhenStepDefinition ctx =
    PartialSuite -> WhenStep ctx


type alias ThenStepDefinition ctx =
    PartialTest -> ThenStep ctx


runTestWithCtx : a -> (a -> b) -> b
runTestWithCtx ctx test =
    test ctx


runTestsWithCtx : a -> List (a -> b) -> List b
runTestsWithCtx ctx tests =
    List.map (runTestWithCtx ctx) tests


stepNotYetDefined : String -> a
stepNotYetDefined step =
    Debug.crash ("This step does not yet have a definition: " ++ step)


confirmIsJust : String -> Maybe a -> a
confirmIsJust description maybeRecord =
    case maybeRecord of
        Just record ->
            record

        Nothing ->
            Debug.crash ("You must set the " ++ description ++ " in a previous step.")
