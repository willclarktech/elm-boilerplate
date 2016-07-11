module App.Steps.Given exposing (given)

import App.Todos exposing (initialModel)
import App.Steps.Context exposing (Context)
import App.Steps.Helpers exposing (constructGivenFunction)
import App.Steps.Types
    exposing
        ( GivenStepDefinition
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


givenACurrentText : GivenStepDefinition Context
givenACurrentText oldCtx =
    let
        text =
            "Buy milk"

        oldModel =
            case oldCtx.model of
                Just model ->
                    model

                Nothing ->
                    initialModel
    in
        { oldCtx
            | currentText = Just text
            , model =
                Just { oldModel | currentText = text }
        }


givenAnExistingTodo : GivenStepDefinition Context
givenAnExistingTodo oldCtx =
    let
        existingTodo =
            "Existing todo"

        oldModel =
            case oldCtx.model of
                Just model ->
                    model

                Nothing ->
                    initialModel
    in
        { oldCtx
            | model =
                Just
                    { oldModel
                        | todos = [ existingTodo ]
                    }
            , existingTodo = Just existingTodo
        }
