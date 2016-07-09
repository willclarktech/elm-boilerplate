module App.Steps.Then exposing (..)

import ElmTestBDDStyle
    exposing
        ( Test
        , it
        , expect
        , toBe
        )
import App.Todos exposing (Msg(..))
import App.Steps.Helpers exposing (ThenStepDefinition, handleUnsetContext)
import App.Steps.Context exposing (Context)


thenATodoShouldBeCreatedWithTheCurrentText : ThenStepDefinition Context
thenATodoShouldBeCreatedWithTheCurrentText ctx =
    it "Then a todo should be created with the current text"
        <| case ( ctx.model, ctx.currentText ) of
            ( Just model, Just currentText ) ->
                expect (List.member currentText model.todos) toBe True

            _ ->
                handleUnsetContext "model and currentText"


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

                _ ->
                    handleUnsetContext "model"


thenTheExistingTodoShouldStillExist : ThenStepDefinition Context
thenTheExistingTodoShouldStillExist ctx =
    it "Then the existing todo should still exist"
        <| case ( ctx.model, ctx.existingTodo ) of
            ( Just model, Just existingTodo ) ->
                expect (List.member existingTodo model.todos) toBe True

            _ ->
                handleUnsetContext "model and existingTodo"


thenATodoShouldBeCreated : ThenStepDefinition Context
thenATodoShouldBeCreated ctx =
    it "Then a Todo should be created"
        <| case ctx.messageAfter of
            Just msg ->
                expect msg toBe CreateTodo

            _ ->
                handleUnsetContext "messageAfter"


thenNothingShouldHappen : ThenStepDefinition Context
thenNothingShouldHappen ctx =
    it "Then nothing should happen"
        <| case ctx.messageAfter of
            Just msg ->
                expect msg toBe NoOp

            _ ->
                handleUnsetContext "messageAfter"


thenTheNewTextIsStoredInTheModel : ThenStepDefinition Context
thenTheNewTextIsStoredInTheModel ctx =
    it "Then the new text is stored in the model"
        <| case ( ctx.model, ctx.newText ) of
            ( Just model, Just newText ) ->
                expect newText toBe model.currentText

            _ ->
                handleUnsetContext "model and newText"
