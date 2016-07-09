module App.Steps.Given exposing (..)

import ElmTestBDDStyle
    exposing
        ( Test
        , describe
        )
import App.Steps.Helpers
    exposing
        ( GivenStepDefinition
        , runTestsWithCtx
        )
import App.Steps.Context exposing (TodoCtx)


givenACurrentText : GivenStepDefinition TodoCtx
givenACurrentText tests oldCtx =
    describe "Given a current text"
        <| let
            oldModel =
                oldCtx.model

            ctx =
                { oldCtx
                    | model =
                        { oldModel | currentText = "Buy milk" }
                }
           in
            runTestsWithCtx ctx tests


givenAnExistingTodo : GivenStepDefinition TodoCtx
givenAnExistingTodo tests oldCtx =
    describe "And an existing todo"
        <| let
            existingTodo =
                "Existing todo"

            oldModel =
                oldCtx.model

            ctx =
                { oldCtx
                    | model =
                        { oldModel
                            | todos = [ existingTodo ]
                        }
                    , existingTodo = Just existingTodo
                }
           in
            runTestsWithCtx ctx tests
