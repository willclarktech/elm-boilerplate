module App.Steps.Then exposing (then')

import ElmTestBDDStyle exposing (expect, toBe)
import App.Todos exposing (Msg(..))
import App.Steps.Context exposing (Context)
import GivenWhenThen.Types
    exposing
        ( ThenStep
        , ThenStepMap
        , ThenFunction
        )
import GivenWhenThen.Helpers
    exposing
        ( constructThenFunction
        , confirmIsJust
        )


then' : ThenFunction Context
then' =
    constructThenFunction stepMap


stepMap : ThenStepMap Context
stepMap =
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
    , ( "the todo should be completed"
      , thenTheTodoShouldBeCompleted
      )
    ]


thenATodoShouldBeCreatedWithTheCurrentText : ThenStep Context
thenATodoShouldBeCreatedWithTheCurrentText ctx =
    expect True toBe
        <| List.member (confirmIsJust "currentText" ctx.currentText)
        <| List.map (\todo -> todo.text)
        <| .todos (confirmIsJust "model" ctx.model)


thenTheCurrentTextShouldBeReset : ThenStep Context
thenTheCurrentTextShouldBeReset ctx =
    expect "" toBe
        <| .currentText (confirmIsJust "model" ctx.model)


thenTheExistingTodoShouldStillExist : ThenStep Context
thenTheExistingTodoShouldStillExist ctx =
    expect True toBe
        <| List.member (confirmIsJust "existingTodo" ctx.existingTodo)
        <| .todos (confirmIsJust "model" ctx.model)


thenATodoShouldBeCreated : ThenStep Context
thenATodoShouldBeCreated ctx =
    expect CreateTodo toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenNothingShouldHappen : ThenStep Context
thenNothingShouldHappen ctx =
    expect NoOp toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenTheNewTextShouldBeStoredInTheModel : ThenStep Context
thenTheNewTextShouldBeStoredInTheModel ctx =
    expect (confirmIsJust "newText" ctx.newText) toBe
        <| .currentText (confirmIsJust "model" ctx.model)


thenTheTodoShouldBeCompleted : ThenStep Context
thenTheTodoShouldBeCompleted ctx =
    expect False toBe
        <| List.isEmpty
        <| List.filter .completed
        <| List.filter (\todo -> todo.text == .text (confirmIsJust "existingTodo" ctx.existingTodo))
        <| .todos (confirmIsJust "model" ctx.model)
