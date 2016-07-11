module App.Steps.Helpers
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
        , confirmIsJust
        , constructGivenFunction
        , constructWhenFunction
        , constructThenFunction
        )

import ElmTestBDDStyle exposing (Assertion, Test, describe, it)


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
