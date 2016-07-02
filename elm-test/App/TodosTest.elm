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


testSuite : Test
testSuite =
    describe "App.TodosTest"
        [ describe "createTodo"
            [ it "should add a Todo to a list"
                <| let
                    fixture =
                        { initialModel | currentText = "Buy milk" }

                    expectedResult =
                        [ "Buy milk" ]
                   in
                    expect expectedResult toBe (.todos <| createTodo fixture)
            , it "should reset the current text"
                <| let
                    fixture =
                        { initialModel | currentText = "Some text" }

                    expectedResult =
                        ""
                   in
                    expect expectedResult toBe (.currentText <| createTodo fixture)
            ]
        , describe "handleKeyUp"
            [ it "should update the current text"
                <| expect (UpdateText 80) toBe (handleKeyUp 80)
            , it "should create a Todo on Enter"
                <| expect (CreateTodo) toBe (handleKeyUp 13)
            ]
        , describe "updateText"
            [ it "should add a character to the current text"
                <| let
                    keyCode =
                        84

                    fixture =
                        { initialModel | currentText = "tes" }

                    expectedResult =
                        "test"
                   in
                    expect expectedResult toBe (.currentText <| updateText keyCode fixture)
            , it "should remove a character from the current text"
                <| let
                    keyCode =
                        8

                    fixture =
                        { initialModel | currentText = "tes" }

                    expectedResult =
                        "te"
                   in
                    expect expectedResult toBe (.currentText <| updateText keyCode fixture)
            ]
        ]
