module App.TodosTest exposing (testSuite)

import App.Todos
    exposing
        ( Model
        , Msg(..)
        , initialModel
        , handleKeyUp
        , updateText
        , createTodo
        )
import ElmTestBDDStyle
    exposing
        ( Test
        , describe
        , it
        , expect
        , toBe
        )


type alias Ctx =
    { model : Model
    , result : Maybe Model
    , existingTodo : Maybe String
    }


type alias GivenStepDefinition =
    List (Ctx -> Test) -> Ctx -> Test


type alias WhenStepDefinition =
    List (Ctx -> Test) -> Ctx -> Test


type alias ThenStepDefinition =
    Ctx -> Test


givenACurrentText : GivenStepDefinition
givenACurrentText tests oldCtx =
    describe "Given a current text"
        <| let
            ctx =
                { oldCtx
                    | model =
                        { initialModel | currentText = "Buy milk" }
                }

            runTest test =
                test ctx
           in
            List.map runTest tests


givenAnExistingTodo : GivenStepDefinition
givenAnExistingTodo tests oldCtx =
    describe "And an existing todo"
        <| let
            existingTodo =
                "Existing todo"

            oldModel =
                oldCtx.model

            ctx =
                { oldCtx
                    | model =
                        { oldModel
                            | todos = [ existingTodo ]
                        }
                    , existingTodo = Just existingTodo
                }

            runTest test =
                test ctx
           in
            List.map runTest tests


whenATodoIsCreated : WhenStepDefinition
whenATodoIsCreated tests oldCtx =
    describe "When a todo is created"
        <| let
            ctx =
                { oldCtx
                    | result = Just (createTodo oldCtx.model)
                }

            runTest test =
                test ctx
           in
            List.map runTest tests


thenATodoShouldBeCreatedWithTheCurrentText : ThenStepDefinition
thenATodoShouldBeCreatedWithTheCurrentText ctx =
    it "Then a todo should be created with the current text"
        <| let
            newTodo =
                ctx.model.currentText
           in
            case ctx.result of
                Just result ->
                    expect (List.member newTodo result.todos) toBe True

                Nothing ->
                    expect True toBe False


thenTheCurrentTextShouldBeReset : ThenStepDefinition
thenTheCurrentTextShouldBeReset ctx =
    it "Then the current text should be reset"
        <| let
            expectedCurrentText =
                ""
           in
            case ctx.result of
                Just result ->
                    expect expectedCurrentText toBe result.currentText

                Nothing ->
                    expect True toBe False


thenTheExistingTodoShouldStillExist : ThenStepDefinition
thenTheExistingTodoShouldStillExist ctx =
    it "And the existing todo should still exist"
        <| case ( ctx.result, ctx.existingTodo ) of
            ( Just result, Just existingTodo ) ->
                expect (List.member existingTodo result.todos) toBe True

            _ ->
                expect True toBe False


createTodoSuite : List Test
createTodoSuite =
    [ givenACurrentText
        [ whenATodoIsCreated
            [ thenATodoShouldBeCreatedWithTheCurrentText
            , thenTheCurrentTextShouldBeReset
            ]
        , givenAnExistingTodo
            [ whenATodoIsCreated
                [ thenATodoShouldBeCreatedWithTheCurrentText
                , thenTheExistingTodoShouldStillExist
                ]
            ]
        ]
        { model = initialModel
        , result = Nothing
        , existingTodo = Nothing
        }
    ]


testSuite : Test
testSuite =
    describe "App.TodosTest"
        [ describe "createTodo" createTodoSuite
          -- , describe "handleKeyUp"
          --     <| let
          --         enterKey =
          --             13
          --
          --         tKey =
          --             84
          --        in
          --         [ it "should create a Todo on Enter"
          --             <| expect (CreateTodo) toBe (handleKeyUp enterKey)
          --         , it "should ignore other keys"
          --             <| expect (NoOp) toBe (handleKeyUp tKey)
          --         ]
          -- , describe "updateText"
          --     [ it "should update the current text"
          --         <| let
          --             newText =
          --                 "New text"
          --
          --             model =
          --                 { initialModel | currentText = "old text" }
          --
          --             expectedResult =
          --                 newText
          --            in
          --             expect expectedResult toBe (.currentText <| updateText newText model)
          --     ]
        ]
