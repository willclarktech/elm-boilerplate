module App.Steps.Helpers
    exposing
        ( GivenStep
        , GivenStepDefinition
        , WhenStep
        , WhenStepDefinition
        , ThenStep
        , ThenStepDefinition
        , ThenStepMap
        , ThenFunction
        , stepNotYetDefined
        , runTestsWithCtx
        , confirmIsJust
        , constructThenFunction
        )

import ElmTestBDDStyle exposing (Assertion, Test, it)


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


type alias ThenStepMap ctx =
    List ( String, ThenStepDefinition ctx )


type alias ThenFunction ctx =
    String -> ThenStep ctx


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


getStepDefinition : ThenStepMap ctx -> String -> String -> ThenStepDefinition ctx
getStepDefinition thenStepMap description prefixedDescription =
    case thenStepMap of
        [] ->
            stepNotYetDefined prefixedDescription

        ( stepDescription, stepDefinition ) :: stepPairs ->
            case stepDescription == description of
                True ->
                    stepDefinition

                False ->
                    getStepDefinition stepPairs description prefixedDescription


constructThenFunction : ThenStepMap ctx -> ThenFunction ctx
constructThenFunction thenStepMap description =
    let
        prefixedDescription =
            "Then " ++ description

        test =
            it prefixedDescription

        stepDefinition =
            getStepDefinition thenStepMap description prefixedDescription
    in
        stepDefinition test
