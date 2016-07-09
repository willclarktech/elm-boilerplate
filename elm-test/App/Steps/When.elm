module App.Steps.When exposing (..)

import ElmTestBDDStyle
    exposing
        ( Test
        , describe
        )
import App.Todos
    exposing
        ( handleKeyUp
        , updateText
        , createTodo
        )
import App.Steps.Helpers
    exposing
        ( WhenStepDefinition
        , runTestsWithCtx
        )
import App.Steps.Context exposing (TodoCtx, KeyPressCtx)


whenATodoIsCreated : WhenStepDefinition TodoCtx
whenATodoIsCreated tests oldCtx =
    describe "When a todo is created"
        <| let
            ctx =
                { oldCtx
                    | result = Just (createTodo oldCtx.model)
                }
           in
            runTestsWithCtx ctx tests


whenTheEnterKeyIsPressed : WhenStepDefinition KeyPressCtx
whenTheEnterKeyIsPressed tests oldCtx =
    describe "When the ENTER key is pressed"
        <| let
            ctx =
                { oldCtx
                    | result = Just <| handleKeyUp 13
                }
           in
            runTestsWithCtx ctx tests


whenTheTKeyIsPressed : WhenStepDefinition KeyPressCtx
whenTheTKeyIsPressed tests oldCtx =
    describe "When the T key is pressed"
        <| let
            ctx =
                { oldCtx
                    | result = Just <| handleKeyUp 84
                }
           in
            runTestsWithCtx ctx tests


whenTheTextIsUpdated : WhenStepDefinition TodoCtx
whenTheTextIsUpdated tests oldCtx =
    describe "When the text is updated"
        <| let
            newText =
                "Update text"

            ctx =
                { oldCtx
                    | model = updateText newText oldCtx.model
                    , newText = Just newText
                }
           in
            runTestsWithCtx ctx tests
