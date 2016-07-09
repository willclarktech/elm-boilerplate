module App.Steps.Helpers
    exposing
        ( GivenStepDefinition
        , WhenStepDefinition
        , ThenStepDefinition
        , runTestsWithCtx
        , confirmIsJust
        )

import ElmTestBDDStyle exposing (Test)


type alias PreStepDefinition ctx =
    List (ctx -> Test) -> ctx -> Test


type alias GivenStepDefinition ctx =
    PreStepDefinition ctx


type alias WhenStepDefinition ctx =
    PreStepDefinition ctx


type alias ThenStepDefinition ctx =
    ctx -> Test


runTestWithCtx : a -> (a -> b) -> b
runTestWithCtx ctx test =
    test ctx


runTestsWithCtx : a -> List (a -> b) -> List b
runTestsWithCtx ctx tests =
    List.map (runTestWithCtx ctx) tests


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
