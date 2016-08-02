module Todos.TestSteps.Given exposing (given)

import Todos.Types exposing (Todo)
import Todos.TestContext exposing (Context, getModel)
import GivenWhenThen.Helpers
    exposing
        ( constructGivenFunction
        , confirmIsJust
        )
import GivenWhenThen.Types
    exposing
        ( GivenStep
        , GivenStepMap
        , GivenFunction
        )


given : GivenFunction Context
given =
    constructGivenFunction stepMap


stepMap : GivenStepMap Context
stepMap =
    [ ( "an initial count"
      , givenAnInitialCount
      )
    , ( "a current text"
      , givenACurrentText
      )
    , ( "a blank text"
      , givenABlankText
      )
    , ( "an existing todo"
      , givenAnExistingTodo
      )
    , ( "another existing todo"
      , givenAnotherExistingTodo
      )
    , ( "the todo has been marked as completed"
      , givenTheTodoHasBeenMarkedAsCompleted
      )
    , ( "the other todo has been marked as completed"
      , givenTheOtherTodoHasBeenMarkedAsCompleted
      )
    , ( "the todo has been marked as incomplete"
      , givenTheTodoHasBeenMarkedAsIncomplete
      )
    ]


givenAnInitialCount : GivenStep Context
givenAnInitialCount oldCtx =
    let
        count =
            0

        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | initialCount = Just count
            , model =
                Just { oldModel | counter = count }
        }


setCurrentText : String -> GivenStep Context
setCurrentText text oldCtx =
    let
        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | currentText = Just text
            , model =
                Just { oldModel | currentText = text }
        }


givenACurrentText : GivenStep Context
givenACurrentText oldCtx =
    setCurrentText "Buy milk" oldCtx


givenABlankText : GivenStep Context
givenABlankText oldCtx =
    setCurrentText "" oldCtx


givenAnExistingTodo : GivenStep Context
givenAnExistingTodo oldCtx =
    let
        todo =
            Todo 1 "Existing todo" False

        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | model =
                Just
                    { oldModel
                        | todos = [ todo ]
                    }
            , existingTodo = Just todo
        }


givenAnotherExistingTodo : GivenStep Context
givenAnotherExistingTodo oldCtx =
    let
        todo =
            Todo 2 "Another existing todo" False

        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | model =
                Just
                    { oldModel
                        | todos = todo :: oldModel.todos
                    }
            , secondTodo = Just todo
        }


markTodoAsComplete : String -> (Context -> Maybe Todo) -> Context -> Context
markTodoAsComplete todoKey getTodoFromCtx oldCtx =
    let
        oldModel =
            getModel oldCtx

        todoId =
            .id (confirmIsJust todoKey (getTodoFromCtx oldCtx))

        newTodos =
            List.map
                (\todo ->
                    let
                        isCurrent =
                            todo.id
                                == todoId
                    in
                        if isCurrent then
                            { todo | completed = True }
                        else
                            todo
                )
                oldModel.todos
    in
        { oldCtx
            | model =
                Just
                    { oldModel
                        | todos = newTodos
                    }
        }


markTodoAsIncomplete : String -> (Context -> Maybe Todo) -> Context -> Context
markTodoAsIncomplete todoKey getTodoFromCtx oldCtx =
    let
        oldModel =
            getModel oldCtx

        todoId =
            .id (confirmIsJust todoKey (getTodoFromCtx oldCtx))

        newTodos =
            List.map
                (\todo ->
                    let
                        isCurrent =
                            todo.id
                                == todoId
                    in
                        if isCurrent then
                            { todo | completed = False }
                        else
                            todo
                )
                oldModel.todos
    in
        { oldCtx
            | model =
                Just
                    { oldModel
                        | todos = newTodos
                    }
        }


givenTheOtherTodoHasBeenMarkedAsCompleted : GivenStep Context
givenTheOtherTodoHasBeenMarkedAsCompleted oldCtx =
    markTodoAsComplete "secondTodo" .secondTodo oldCtx


givenTheTodoHasBeenMarkedAsCompleted : GivenStep Context
givenTheTodoHasBeenMarkedAsCompleted oldCtx =
    markTodoAsComplete "existingTodo" .existingTodo oldCtx


givenTheTodoHasBeenMarkedAsIncomplete : GivenStep Context
givenTheTodoHasBeenMarkedAsIncomplete oldCtx =
    markTodoAsIncomplete "existingTodo" .existingTodo oldCtx
