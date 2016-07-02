module App.TodosTest exposing (testSuite)

import App.Todos
    exposing
        ( Msg(..)
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
    Maybe {}


givenACurrentText tests oldCtx =
    describe "Given a current text"
        <| let
            currentText =
                "Buy milk"

            ctx =
                case oldCtx of
                    Just c ->
                        { c
                            | model =
                                { initialModel | currentText = currentText }
                        }

                    Nothing ->
                        { model =
                            { initialModel | currentText = currentText }
                        }

            runTest test =
                test ctx
           in
            List.map runTest tests


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
                }

            runTest test =
                test ctx
           in
            List.map runTest tests


whenATodoIsCreated tests ctx =
    describe "When a todo is created"
        <| let
            result =
                createTodo ctx.model

            runTest test =
                test ctx result
           in
            List.map runTest tests


thenATodoShouldBeCreatedWithTheCurrentText ctx result =
    it "Then a todo should be created with the current text"
        <| let
            expectedTodos =
                [ ctx.model.currentText ]
           in
            expect expectedTodos toBe result.todos


thenTheCurrentTextShouldBeReset ctx result =
    it "Then the current text should be reset"
        <| let
            expectedCurrentText =
                ""
           in
            expect expectedCurrentText toBe result.currentText


thenTheExistingTodoShouldStillExist ctx result =
    it "And the existing todo should still exist"
        <| expect (List.member ctx.existingTodo result.todos) toBe True


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
        Nothing
    ]


testSuite : Test
testSuite =
    describe "App.TodosTest"
        [ describe "createTodo" createTodoSuite
        , describe "handleKeyUp"
            <| let
                enterKey =
                    13

                tKey =
                    84
               in
                [ it "should create a Todo on Enter"
                    <| expect (CreateTodo) toBe (handleKeyUp enterKey)
                , it "should ignore other keys"
                    <| expect (NoOp) toBe (handleKeyUp tKey)
                ]
        , describe "updateText"
            [ it "should update the current text"
                <| let
                    newText =
                        "New text"

                    model =
                        { initialModel | currentText = "old text" }

                    expectedResult =
                        newText
                   in
                    expect expectedResult toBe (.currentText <| updateText newText model)
            ]
        ]
