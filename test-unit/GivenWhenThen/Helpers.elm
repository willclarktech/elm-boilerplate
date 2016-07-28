module GivenWhenThen.Helpers
    exposing
        ( confirmIsJust
        , constructGivenFunction
        , constructWhenFunction
        , constructThenFunction
        , constructGWTSuite
        )

import ElmTestBDDStyle exposing (Test, describe, it)
import GivenWhenThen.Types
    exposing
        ( GivenStepMap
        , GivenFunction
        , WhenStepMap
        , WhenFunction
        , ThenStepMap
        , ThenFunction
        )


runTestWithCtx : a -> (a -> b) -> b
runTestWithCtx ctx test =
    test ctx


runTestsWithCtx : List (a -> b) -> a -> List b
runTestsWithCtx tests ctx =
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


getStepDefinition : List ( String, b ) -> String -> String -> b
getStepDefinition stepMap description prefixedDescription =
    case stepMap of
        [] ->
            stepNotYetDefined prefixedDescription

        ( stepDescription, stepDefinition ) :: remainingStepPairs ->
            case stepDescription == description of
                True ->
                    stepDefinition

                False ->
                    getStepDefinition remainingStepPairs description prefixedDescription


constructPreStepFunction : String -> List ( String, ctx -> b ) -> String -> List (b -> Test) -> ctx -> Test
constructPreStepFunction prefix stepMap description =
    let
        prefixedDescription =
            prefix ++ " " ++ description

        suite =
            describe prefixedDescription

        stepDefinition =
            getStepDefinition stepMap description prefixedDescription

        getStepForContext tests context =
            suite <| runTestsWithCtx tests <| stepDefinition context
    in
        getStepForContext


constructGivenFunction : GivenStepMap ctx -> GivenFunction ctx
constructGivenFunction stepMap description =
    constructPreStepFunction "Given" stepMap description


constructWhenFunction : WhenStepMap ctx -> WhenFunction ctx
constructWhenFunction stepMap description =
    constructPreStepFunction "When" stepMap description


constructThenFunction : ThenStepMap ctx -> ThenFunction ctx
constructThenFunction stepMap description =
    let
        prefixedDescription =
            "Then " ++ description

        test =
            it prefixedDescription

        stepDefinition =
            getStepDefinition stepMap description prefixedDescription

        getThenStepForContext context =
            test <| stepDefinition context
    in
        getThenStepForContext


constructGWTSuite : List (ctx -> Test) -> ctx -> List Test
constructGWTSuite steps initialContext =
    List.map (\step -> step initialContext) steps
