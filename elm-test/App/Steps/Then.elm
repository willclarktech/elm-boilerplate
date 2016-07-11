module App.Steps.Then exposing (then')

import ElmTestBDDStyle exposing (expect, toBe)
import App.Todos exposing (Msg(..))
import App.Steps.Context exposing (Context)
import App.Steps.Helpers
    exposing
        ( ThenStepDefinition
        , ThenStepMap
        , ThenFunction
        , constructThenFunction
        , confirmIsJust
        )


then' : ThenFunction Context
then' =
    constructThenFunction thenStepMap


thenStepMap : ThenStepMap Context
thenStepMap =
    [ ( "the existing todo should still exist"
      , thenTheExistingTodoShouldStillExist
      )
    , ( "a todo should be created"
      , thenATodoShouldBeCreated
      )
    , ( "a todo should be created with the current text"
      , thenATodoShouldBeCreatedWithTheCurrentText
      )
    , ( "the current text should be reset"
      , thenTheCurrentTextShouldBeReset
      )
    , ( "the new text should be stored in the model"
      , thenTheNewTextShouldBeStoredInTheModel
      )
    , ( "nothing should happen"
      , thenNothingShouldHappen
      )
    ]


thenATodoShouldBeCreatedWithTheCurrentText : ThenStepDefinition Context
thenATodoShouldBeCreatedWithTheCurrentText ctx =
    expect True toBe
        <| List.member (confirmIsJust "currentText" ctx.currentText)
        <| .todos (confirmIsJust "model" ctx.model)


thenTheCurrentTextShouldBeReset : ThenStepDefinition Context
thenTheCurrentTextShouldBeReset ctx =
    expect "" toBe
        <| .currentText (confirmIsJust "model" ctx.model)


thenTheExistingTodoShouldStillExist : ThenStepDefinition Context
thenTheExistingTodoShouldStillExist ctx =
    expect True toBe
        <| List.member (confirmIsJust "existingTodo" ctx.existingTodo)
        <| .todos (confirmIsJust "model" ctx.model)


thenATodoShouldBeCreated : ThenStepDefinition Context
thenATodoShouldBeCreated ctx =
    expect CreateTodo toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenNothingShouldHappen : ThenStepDefinition Context
thenNothingShouldHappen ctx =
    expect NoOp toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenTheNewTextShouldBeStoredInTheModel : ThenStepDefinition Context
thenTheNewTextShouldBeStoredInTheModel ctx =
    expect (confirmIsJust "newText" ctx.newText) toBe
        <| .currentText (confirmIsJust "model" ctx.model)
