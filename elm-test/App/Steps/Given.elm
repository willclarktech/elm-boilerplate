module App.Steps.Given exposing (given)

import ElmTestBDDStyle
    exposing
        ( Test
        , describe
        )
import App.Todos exposing (initialModel)
import App.Steps.Helpers
    exposing
        ( GivenStepDefinition
        , PartialSuite
        , stepNotYetDefined
        , runTestsWithCtx
        )
import App.Steps.Context exposing (Context)


given : String -> GivenStepDefinition Context
given description =
    let
        prefixedDescription =
            "Given " ++ description

        suite =
            describe prefixedDescription

        stepDefinition =
            case description of
                "a current text" ->
                    givenACurrentText

                "an existing todo" ->
                    givenAnExistingTodo

                _ ->
                    stepNotYetDefined (prefixedDescription)
    in
        stepDefinition suite


givenACurrentText : PartialSuite -> GivenStepDefinition Context
givenACurrentText suite tests oldCtx =
    suite
        <| let
            text =
                "Buy milk"

            oldModel =
                case oldCtx.model of
                    Just model ->
                        model

                    Nothing ->
                        initialModel

            ctx =
                { oldCtx
                    | currentText = Just text
                    , model =
                        Just { oldModel | currentText = text }
                }
           in
            runTestsWithCtx ctx tests


givenAnExistingTodo : PartialSuite -> GivenStepDefinition Context
givenAnExistingTodo suite tests oldCtx =
    suite
        <| let
            existingTodo =
                "Existing todo"

            oldModel =
                case oldCtx.model of
                    Just model ->
                        model

                    Nothing ->
                        initialModel

            ctx =
                { oldCtx
                    | model =
                        Just
                            { oldModel
                                | todos = [ existingTodo ]
                            }
                    , existingTodo = Just existingTodo
                }
           in
            runTestsWithCtx ctx tests
