module App.Steps.Given exposing (given)

import App.Todos exposing (Todo)
import App.Steps.Context exposing (Context, getModel)
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


givenACurrentText : GivenStep Context
givenACurrentText oldCtx =
    let
        text =
            "Buy milk"

        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | currentText = Just text
            , model =
                Just { oldModel | currentText = text }
        }


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


givenTheOtherTodoHasBeenMarkedAsCompleted : GivenStep Context
givenTheOtherTodoHasBeenMarkedAsCompleted oldCtx =
    markTodoAsComplete "secondTodo" .secondTodo oldCtx


givenTheTodoHasBeenMarkedAsCompleted : GivenStep Context
givenTheTodoHasBeenMarkedAsCompleted oldCtx =
    markTodoAsComplete "existingTodo" .existingTodo oldCtx
