module App.Steps.Given exposing (..)

import ElmTestBDDStyle
    exposing
        ( Test
        , describe
        )
import App.Todos exposing (initialModel)
import App.Steps.Helpers
    exposing
        ( GivenStepDefinition
        , runTestsWithCtx
        )
import App.Steps.Context exposing (Context)


givenACurrentText : GivenStepDefinition Context
givenACurrentText tests oldCtx =
    describe "Given a current text"
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


givenAnExistingTodo : GivenStepDefinition Context
givenAnExistingTodo tests oldCtx =
    describe "Given an existing todo"
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
