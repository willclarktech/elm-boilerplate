module TodosTest.Steps.When exposing (when)

import Todos.Types exposing (FilterOption(..))
import Todos.Update
    exposing
        ( updateText
        , createTodo
        , markAsCompleted
        , markAsIncomplete
        , delete
        , setFilter
        )
import Todos.View exposing (handleKeyUp)
import TodosTest.Context exposing (Context, getModel)
import GivenWhenThen.Helpers
    exposing
        ( constructWhenFunction
        , confirmIsJust
        )
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
    , ( "the todo is marked as completed"
      , whenTheTodoIsMarkedAsCompleted
      )
    , ( "the todo is marked as incomplete"
      , whenTheTodoIsMarkedAsIncomplete
      )
    , ( "the todo is deleted"
      , whenTheTodoIsDeleted
      )
    , ( "the todos are filtered by completed"
      , whenTheTodosAreFilteredByCompleted
      )
    , ( "the todos are filtered by incomplete"
      , whenTheTodosAreFilteredByIncomplete
      )
    , ( "the todos are filtered by all"
      , whenTheTodosAreFilteredByAll
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


pressKey : Int -> WhenStep Context
pressKey keyNumber oldCtx =
    let
        currentText =
            confirmIsJust "currentText" oldCtx.currentText
    in
        { oldCtx
            | messageAfter = Just <| handleKeyUp currentText keyNumber
        }


whenTheEnterKeyIsPressed : WhenStep Context
whenTheEnterKeyIsPressed oldCtx =
    pressKey 13 oldCtx


whenTheTKeyIsPressed : WhenStep Context
whenTheTKeyIsPressed oldCtx =
    pressKey 84 oldCtx


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


whenTheTodoIsMarkedAsCompleted : WhenStep Context
whenTheTodoIsMarkedAsCompleted oldCtx =
    let
        existingTodo =
            confirmIsJust "existingTodo" oldCtx.existingTodo

        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | model = Just (markAsCompleted existingTodo oldModel)
        }


whenTheTodoIsMarkedAsIncomplete : WhenStep Context
whenTheTodoIsMarkedAsIncomplete oldCtx =
    let
        existingTodo =
            confirmIsJust "existingTodo" oldCtx.existingTodo

        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | model = Just (markAsIncomplete existingTodo oldModel)
        }


whenTheTodoIsDeleted : WhenStep Context
whenTheTodoIsDeleted oldCtx =
    let
        existingTodo =
            confirmIsJust "existingTodo" oldCtx.existingTodo

        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | model = Just (delete existingTodo oldModel)
        }


setFilterOnModelForContext filterOption ctx =
    let
        oldModel =
            getModel ctx
    in
        { ctx
            | model = Just (setFilter filterOption oldModel)
        }


whenTheTodosAreFilteredByCompleted : WhenStep Context
whenTheTodosAreFilteredByCompleted oldCtx =
    setFilterOnModelForContext Completed oldCtx


whenTheTodosAreFilteredByIncomplete : WhenStep Context
whenTheTodosAreFilteredByIncomplete oldCtx =
    setFilterOnModelForContext Incomplete oldCtx


whenTheTodosAreFilteredByAll : WhenStep Context
whenTheTodosAreFilteredByAll oldCtx =
    setFilterOnModelForContext All oldCtx
