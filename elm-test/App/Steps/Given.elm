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
    [ ( "a current text"
      , givenACurrentText
      )
    , ( "an existing todo"
      , givenAnExistingTodo
      )
    ]


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
            Todo "Existing todo" False

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
