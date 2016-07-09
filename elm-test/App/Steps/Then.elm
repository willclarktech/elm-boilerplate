module App.Steps.Then exposing (..)

import ElmTestBDDStyle
    exposing
        ( it
        , expect
        , toBe
        )
import App.Todos exposing (Msg(..))
import App.Steps.Helpers exposing (ThenStepDefinition, confirmIsJust)
import App.Steps.Context exposing (Context)


thenATodoShouldBeCreatedWithTheCurrentText : ThenStepDefinition Context
thenATodoShouldBeCreatedWithTheCurrentText ctx =
    it "Then a todo should be created with the current text"
        <| expect True toBe
        <| List.member (confirmIsJust "currentText" ctx.currentText)
        <| .todos (confirmIsJust "model" ctx.model)


thenTheCurrentTextShouldBeReset : ThenStepDefinition Context
thenTheCurrentTextShouldBeReset ctx =
    it "Then the current text should be reset"
        <| expect "" toBe
        <| .currentText (confirmIsJust "model" ctx.model)


thenTheExistingTodoShouldStillExist : ThenStepDefinition Context
thenTheExistingTodoShouldStillExist ctx =
    it "Then the existing todo should still exist"
        <| expect True toBe
        <| List.member (confirmIsJust "existingTodo" ctx.existingTodo)
        <| .todos (confirmIsJust "model" ctx.model)


thenATodoShouldBeCreated : ThenStepDefinition Context
thenATodoShouldBeCreated ctx =
    it "Then a Todo should be created"
        <| expect CreateTodo toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenNothingShouldHappen : ThenStepDefinition Context
thenNothingShouldHappen ctx =
    it "Then nothing should happen"
        <| expect NoOp toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenTheNewTextIsStoredInTheModel : ThenStepDefinition Context
thenTheNewTextIsStoredInTheModel ctx =
    it "Then the new text is stored in the model"
        <| expect (confirmIsJust "newText" ctx.newText) toBe
        <| .currentText (confirmIsJust "model" ctx.model)
