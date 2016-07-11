module App.Steps.Given exposing (given)

import App.Todos exposing (initialModel)
import App.Steps.Context exposing (Context)
import App.Steps.Helpers
    exposing
        ( GivenStepDefinition
        , GivenStepMap
        , GivenFunction
        , constructGivenFunction
        )


given : GivenFunction Context
given =
    constructGivenFunction givenStepMap


givenStepMap : GivenStepMap Context
givenStepMap =
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
