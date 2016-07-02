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
                <| expect (UpdateText "Incomplete tod") toBe (handleKeyUp "Incomplete tod" 80)
            , it "should create a Todo on Enter"
                <| expect (CreateTodo) toBe (handleKeyUp "Full todo" 13)
            ]
        , describe "updateText"
            [ it "should add a character to the current text"
                <| let
                    newText =
                        "New text"

                    fixture =
                        { initialModel | currentText = "old text" }

                    expectedResult =
                        newText
                   in
                    expect expectedResult toBe (.currentText <| updateText newText fixture)
            ]
        ]
