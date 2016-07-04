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


type alias CreateTodoCtx =
    { model : Model
    , result : Maybe Model
    , existingTodo : Maybe String
    }


type alias HandleKeyUpCtx =
    { result : Maybe Msg }


type alias PreStepDefinition ctx =
    List (ctx -> Test) -> ctx -> Test


type alias GivenStepDefinition ctx =
    PreStepDefinition ctx


type alias WhenStepDefinition ctx =
    PreStepDefinition ctx


type alias ThenStepDefinition ctx =
    ctx -> Test


givenACurrentText : GivenStepDefinition CreateTodoCtx
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


givenAnExistingTodo : GivenStepDefinition CreateTodoCtx
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


whenATodoIsCreated : WhenStepDefinition CreateTodoCtx
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


thenATodoShouldBeCreatedWithTheCurrentText : ThenStepDefinition CreateTodoCtx
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


thenTheCurrentTextShouldBeReset : ThenStepDefinition CreateTodoCtx
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


thenTheExistingTodoShouldStillExist : ThenStepDefinition CreateTodoCtx
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


whenTheEnterKeyIsPressed : WhenStepDefinition HandleKeyUpCtx
whenTheEnterKeyIsPressed tests oldCtx =
    describe "When the ENTER key is pressed"
        <| let
            ctx =
                { oldCtx
                    | result = Just <| handleKeyUp 13
                }

            runTest test =
                test ctx
           in
            List.map runTest tests


whenTheTKeyIsPressed : WhenStepDefinition HandleKeyUpCtx
whenTheTKeyIsPressed tests oldCtx =
    describe "When the T key is pressed"
        <| let
            ctx =
                { oldCtx
                    | result = Just <| handleKeyUp 84
                }

            runTest test =
                test ctx
           in
            List.map runTest tests


thenATodoShouldBeCreated : ThenStepDefinition HandleKeyUpCtx
thenATodoShouldBeCreated ctx =
    it "Then a Todo should be created"
        <| expect ctx.result toBe (Just CreateTodo)


thenNothingShouldHappen : ThenStepDefinition HandleKeyUpCtx
thenNothingShouldHappen ctx =
    it "Then nothing should happen"
        <| expect ctx.result toBe (Just NoOp)


handleKeyUpSuite : List Test
handleKeyUpSuite =
    [ whenTheEnterKeyIsPressed [ thenATodoShouldBeCreated ]
        { result = Nothing }
    , whenTheTKeyIsPressed [ thenNothingShouldHappen ]
        { result = Nothing }
    ]


testSuite : Test
testSuite =
    describe "App.TodosTest"
        [ describe "createTodo" createTodoSuite
        , describe "handleKeyUp" handleKeyUpSuite
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
