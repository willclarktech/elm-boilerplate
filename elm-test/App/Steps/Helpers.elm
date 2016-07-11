module App.Steps.Helpers
    exposing
        ( confirmIsJust
        , constructGivenFunction
        , constructWhenFunction
        , constructThenFunction
        )

import ElmTestBDDStyle exposing (describe, it)
import App.Steps.Types
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


constructGivenFunction : GivenStepMap ctx -> GivenFunction ctx
constructGivenFunction givenStepMap description =
    let
        prefixedDescription =
            "Given " ++ description

        suite =
            describe prefixedDescription

        stepDefinition =
            getStepDefinition givenStepMap description prefixedDescription

        getGivenStepForContext tests context =
            suite <| runTestsWithCtx tests <| stepDefinition context
    in
        getGivenStepForContext


constructWhenFunction : WhenStepMap ctx -> WhenFunction ctx
constructWhenFunction whenStepMap description =
    let
        prefixedDescription =
            "When " ++ description

        suite =
            describe prefixedDescription

        stepDefinition =
            getStepDefinition whenStepMap description prefixedDescription

        getWhenStepForContext tests context =
            suite <| runTestsWithCtx tests <| stepDefinition context
    in
        getWhenStepForContext


constructThenFunction : ThenStepMap ctx -> ThenFunction ctx
constructThenFunction thenStepMap description =
    let
        prefixedDescription =
            "Then " ++ description

        test =
            it prefixedDescription

        stepDefinition =
            getStepDefinition thenStepMap description prefixedDescription

        getThenStepForContext context =
            test <| stepDefinition context
    in
        getThenStepForContext
