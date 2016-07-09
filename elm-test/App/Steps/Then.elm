module App.Steps.Then exposing (..)

import ElmTestBDDStyle
    exposing
        ( Test
        , it
        , expect
        , toBe
        )
import App.Todos
    exposing
        ( Msg(..)
        )
import App.Steps.Helpers exposing (ThenStepDefinition)
import App.Steps.Context exposing (TodoCtx, KeyPressCtx)


thenATodoShouldBeCreatedWithTheCurrentText : ThenStepDefinition TodoCtx
thenATodoShouldBeCreatedWithTheCurrentText ctx =
    it "Then a todo should be created with the current text"
        <| let
            newTodo =
                ctx.model.currentText
           in
            case ctx.result of
                Just result ->
                    expect (List.member newTodo result.todos) toBe True

                Nothing ->
                    expect True toBe False


thenTheCurrentTextShouldBeReset : ThenStepDefinition TodoCtx
thenTheCurrentTextShouldBeReset ctx =
    it "Then the current text should be reset"
        <| let
            expectedCurrentText =
                ""
           in
            case ctx.result of
                Just result ->
                    expect expectedCurrentText toBe result.currentText

                Nothing ->
                    expect True toBe False


thenTheExistingTodoShouldStillExist : ThenStepDefinition TodoCtx
thenTheExistingTodoShouldStillExist ctx =
    it "And the existing todo should still exist"
        <| case ( ctx.result, ctx.existingTodo ) of
            ( Just result, Just existingTodo ) ->
                expect (List.member existingTodo result.todos) toBe True

            _ ->
                expect True toBe False


thenATodoShouldBeCreated : ThenStepDefinition KeyPressCtx
thenATodoShouldBeCreated ctx =
    it "Then a Todo should be created"
        <| expect ctx.result toBe (Just CreateTodo)


thenNothingShouldHappen : ThenStepDefinition KeyPressCtx
thenNothingShouldHappen ctx =
    it "Then nothing should happen"
        <| expect ctx.result toBe (Just NoOp)


thenTheNewTextIsStoredInTheModel : ThenStepDefinition TodoCtx
thenTheNewTextIsStoredInTheModel ctx =
    it "Then the new text is stored in the model"
        <| expect ctx.newText toBe (Just ctx.model.currentText)
