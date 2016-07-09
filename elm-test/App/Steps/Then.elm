module App.Steps.Then exposing (..)

import ElmTestBDDStyle
    exposing
        ( Test
        , it
        , expect
        , toBe
        )
import App.Todos exposing (Msg(..))
import App.Steps.Helpers exposing (ThenStepDefinition)
import App.Steps.Context exposing (Context)


thenATodoShouldBeCreatedWithTheCurrentText : ThenStepDefinition Context
thenATodoShouldBeCreatedWithTheCurrentText ctx =
    it "Then a todo should be created with the current text"
        <| case ( ctx.model, ctx.currentText ) of
            ( Just model, Just currentText ) ->
                expect (List.member currentText model.todos) toBe True

            _ ->
                expect True toBe False


thenTheCurrentTextShouldBeReset : ThenStepDefinition Context
thenTheCurrentTextShouldBeReset ctx =
    it "Then the current text should be reset"
        <| let
            expectedCurrentText =
                ""
           in
            case ctx.model of
                Just model ->
                    expect expectedCurrentText toBe model.currentText

                Nothing ->
                    expect True toBe False


thenTheExistingTodoShouldStillExist : ThenStepDefinition Context
thenTheExistingTodoShouldStillExist ctx =
    it "Then the existing todo should still exist"
        <| case ( ctx.model, ctx.existingTodo ) of
            ( Just model, Just existingTodo ) ->
                expect (List.member existingTodo model.todos) toBe True

            _ ->
                expect True toBe False


thenATodoShouldBeCreated : ThenStepDefinition Context
thenATodoShouldBeCreated ctx =
    it "Then a Todo should be created"
        <| expect ctx.messageAfter toBe (Just CreateTodo)


thenNothingShouldHappen : ThenStepDefinition Context
thenNothingShouldHappen ctx =
    it "Then nothing should happen"
        <| expect ctx.messageAfter toBe (Just NoOp)


thenTheNewTextIsStoredInTheModel : ThenStepDefinition Context
thenTheNewTextIsStoredInTheModel ctx =
    it "Then the new text is stored in the model"
        <| case ( ctx.model, ctx.newText ) of
            ( Just model, Just newText ) ->
                expect newText toBe model.currentText

            _ ->
                expect True toBe False
