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


type alias TodoCtx =
    { model : Model
    , result : Maybe Model
    , newText : Maybe String
    , existingTodo : Maybe String
    }


initialTodoCtx : TodoCtx
initialTodoCtx =
    { model = initialModel
    , result = Nothing
    , newText = Nothing
    , existingTodo = Nothing
    }


type alias KeyPressCtx =
    { result : Maybe Msg }


initialKeyPressCtx : KeyPressCtx
initialKeyPressCtx =
    { result = Nothing }


type alias PreStepDefinition ctx =
    List (ctx -> Test) -> ctx -> Test


type alias GivenStepDefinition ctx =
    PreStepDefinition ctx


type alias WhenStepDefinition ctx =
    PreStepDefinition ctx


type alias ThenStepDefinition ctx =
    ctx -> Test


runTestWithCtx : a -> (a -> b) -> b
runTestWithCtx ctx test =
    test ctx


runTestsWithCtx : a -> List (a -> b) -> List b
runTestsWithCtx ctx tests =
    List.map (runTestWithCtx ctx) tests


givenACurrentText : GivenStepDefinition TodoCtx
givenACurrentText tests oldCtx =
    describe "Given a current text"
        <| let
            ctx =
                { oldCtx
                    | model =
                        { initialModel | currentText = "Buy milk" }
                }
           in
            runTestsWithCtx ctx tests


givenAnExistingTodo : GivenStepDefinition TodoCtx
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
           in
            runTestsWithCtx ctx tests


whenATodoIsCreated : WhenStepDefinition TodoCtx
whenATodoIsCreated tests oldCtx =
    describe "When a todo is created"
        <| let
            ctx =
                { oldCtx
                    | result = Just (createTodo oldCtx.model)
                }
           in
            runTestsWithCtx ctx tests


thenATodoShouldBeCreatedWithTheCurrentText : ThenStepDefinition TodoCtx
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


thenTheCurrentTextShouldBeReset : ThenStepDefinition TodoCtx
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


thenTheExistingTodoShouldStillExist : ThenStepDefinition TodoCtx
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
        initialTodoCtx
    ]


whenTheEnterKeyIsPressed : WhenStepDefinition KeyPressCtx
whenTheEnterKeyIsPressed tests oldCtx =
    describe "When the ENTER key is pressed"
        <| let
            ctx =
                { oldCtx
                    | result = Just <| handleKeyUp 13
                }
           in
            runTestsWithCtx ctx tests


whenTheTKeyIsPressed : WhenStepDefinition KeyPressCtx
whenTheTKeyIsPressed tests oldCtx =
    describe "When the T key is pressed"
        <| let
            ctx =
                { oldCtx
                    | result = Just <| handleKeyUp 84
                }
           in
            runTestsWithCtx ctx tests


thenATodoShouldBeCreated : ThenStepDefinition KeyPressCtx
thenATodoShouldBeCreated ctx =
    it "Then a Todo should be created"
        <| expect ctx.result toBe (Just CreateTodo)


thenNothingShouldHappen : ThenStepDefinition KeyPressCtx
thenNothingShouldHappen ctx =
    it "Then nothing should happen"
        <| expect ctx.result toBe (Just NoOp)


handleKeyUpSuite : List Test
handleKeyUpSuite =
    [ whenTheEnterKeyIsPressed [ thenATodoShouldBeCreated ]
        initialKeyPressCtx
    , whenTheTKeyIsPressed [ thenNothingShouldHappen ]
        initialKeyPressCtx
    ]


whenTheTextIsUpdated : WhenStepDefinition TodoCtx
whenTheTextIsUpdated tests oldCtx =
    describe "When the text is updated"
        <| let
            newText =
                "Update text"

            ctx =
                { oldCtx
                    | model = updateText newText oldCtx.model
                    , newText = Just newText
                }
           in
            runTestsWithCtx ctx tests


thenTheNewTextIsStoredInTheModel : ThenStepDefinition TodoCtx
thenTheNewTextIsStoredInTheModel ctx =
    it "Then the new text is stored in the model"
        <| expect ctx.newText toBe (Just ctx.model.currentText)


updateTextSuite : List Test
updateTextSuite =
    [ givenACurrentText
        [ whenTheTextIsUpdated [ thenTheNewTextIsStoredInTheModel ]
        ]
        initialTodoCtx
    ]


testSuite : Test
testSuite =
    describe "App.TodosTest"
        [ describe "createTodo" createTodoSuite
        , describe "handleKeyUp" handleKeyUpSuite
        , describe "updateText" updateTextSuite
        ]
