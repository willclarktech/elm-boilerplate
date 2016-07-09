module App.Steps.Helpers
    exposing
        ( GivenStepDefinition
        , WhenStepDefinition
        , ThenStepDefinition
        , PartialTest
        , PartialSuite
        , runTestsWithCtx
        , confirmIsJust
        , stepNotYetDefined
        )

import ElmTestBDDStyle exposing (Assertion, Test)


type alias PreStepDefinition ctx =
    List (ctx -> Test) -> ctx -> Test


type alias GivenStepDefinition ctx =
    PreStepDefinition ctx


type alias WhenStepDefinition ctx =
    PreStepDefinition ctx


type alias ThenStepDefinition ctx =
    ctx -> Test


type alias PartialTest =
    Assertion -> Test


type alias PartialSuite =
    List Test -> Test


runTestWithCtx : a -> (a -> b) -> b
runTestWithCtx ctx test =
    test ctx


runTestsWithCtx : a -> List (a -> b) -> List b
runTestsWithCtx ctx tests =
    List.map (runTestWithCtx ctx) tests


stepNotYetDefined : String -> a
stepNotYetDefined step =
    Debug.crash ("This step does not yet have a definition: " ++ step)


handleUnsetContext : String -> a
handleUnsetContext string =
    Debug.crash ("You must set the " ++ string ++ " in a previous step.")


confirmIsJust : String -> Maybe a -> a
confirmIsJust description maybeRecord =
    case maybeRecord of
        Just record ->
            record

        Nothing ->
            handleUnsetContext description
