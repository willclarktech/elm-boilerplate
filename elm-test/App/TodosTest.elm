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


createTodoSuite : List Test
createTodoSuite =
    [ describe "Given a current text"
        <| let
            currentText =
                "Buy milk"

            model =
                { initialModel | currentText = currentText }
           in
            [ describe "When a todo is created"
                <| let
                    result =
                        createTodo model
                   in
                    [ it "Then a todo should be created with the current text"
                        <| let
                            expectedTodos =
                                [ currentText ]
                           in
                            expect expectedTodos toBe result.todos
                    , it "Then the current text should be reset"
                        <| let
                            expectedCurrentText =
                                ""
                           in
                            expect expectedCurrentText toBe result.currentText
                    ]
            , describe "And an existing todo"
                <| let
                    existingTodo =
                        "Existing todo"

                    newModel =
                        { model | todos = [ existingTodo ] }
                   in
                    [ describe "When a todo is created"
                        <| let
                            result =
                                createTodo newModel
                           in
                            [ it "Then a todo should be created with the current text"
                                <| expect (List.member currentText result.todos) toBe True
                            , it "And the existing todo should still exist"
                                <| expect (List.member existingTodo result.todos) toBe True
                            ]
                    ]
            ]
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
