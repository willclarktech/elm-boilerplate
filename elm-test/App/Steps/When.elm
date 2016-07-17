module App.Steps.When exposing (when)

import App.Todos
    exposing
        ( handleKeyUp
        , updateText
        , createTodo
        )
import App.Steps.Context exposing (Context, getModel)
import GivenWhenThen.Helpers exposing (constructWhenFunction)
import GivenWhenThen.Types
    exposing
        ( WhenStep
        , WhenStepMap
        , WhenFunction
        )


when : WhenFunction Context
when =
    constructWhenFunction stepMap


stepMap : WhenStepMap Context
stepMap =
    [ ( "a todo is created"
      , whenATodoIsCreated
      )
    , ( "the ENTER key is pressed"
      , whenTheEnterKeyIsPressed
      )
    , ( "the T key is pressed"
      , whenTheTKeyIsPressed
      )
    , ( "the text is updated"
      , whenTheTextIsUpdated
      )
    ]


whenATodoIsCreated : WhenStep Context
whenATodoIsCreated oldCtx =
    let
        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | model = Just (createTodo oldModel)
        }


whenTheEnterKeyIsPressed : WhenStep Context
whenTheEnterKeyIsPressed oldCtx =
    { oldCtx
        | messageAfter = Just <| handleKeyUp 13
    }


whenTheTKeyIsPressed : WhenStep Context
whenTheTKeyIsPressed oldCtx =
    { oldCtx
        | messageAfter = Just <| handleKeyUp 84
    }


whenTheTextIsUpdated : WhenStep Context
whenTheTextIsUpdated oldCtx =
    let
        text =
            "Update text"

        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | model = Just (updateText text oldModel)
            , newText = Just text
        }
