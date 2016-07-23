module App.Steps.Given exposing (given)

import App.Todos exposing (Todo)
import App.Steps.Context exposing (Context, getModel)
import GivenWhenThen.Helpers exposing (constructGivenFunction)
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
                        | todos = [ todo ]
                    }
            , secondTodo = Just todo
        }
