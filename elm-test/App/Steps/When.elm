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
import App.Steps.Context
    exposing
        ( Context
        , getModel
        )


whenATodoIsCreated : WhenStepDefinition Context
whenATodoIsCreated tests oldCtx =
    describe "When a todo is created"
        <| let
            oldModel =
                getModel oldCtx

            ctx =
                { oldCtx
                    | model = Just (createTodo oldModel)
                }
           in
            runTestsWithCtx ctx tests


whenTheEnterKeyIsPressed : WhenStepDefinition Context
whenTheEnterKeyIsPressed tests oldCtx =
    describe "When the ENTER key is pressed"
        <| let
            ctx =
                { oldCtx
                    | messageAfter = Just <| handleKeyUp 13
                }
           in
            runTestsWithCtx ctx tests


whenTheTKeyIsPressed : WhenStepDefinition Context
whenTheTKeyIsPressed tests oldCtx =
    describe "When the T key is pressed"
        <| let
            ctx =
                { oldCtx
                    | messageAfter = Just <| handleKeyUp 84
                }
           in
            runTestsWithCtx ctx tests


whenTheTextIsUpdated : WhenStepDefinition Context
whenTheTextIsUpdated tests oldCtx =
    describe "When the text is updated"
        <| let
            newText =
                "Update text"

            oldModel =
                getModel oldCtx

            ctx =
                { oldCtx
                    | model = Just (updateText newText oldModel)
                    , newText = Just newText
                }
           in
            runTestsWithCtx ctx tests
