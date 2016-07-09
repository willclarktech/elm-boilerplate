module App.TodosTest exposing (testSuite)

import ElmTestBDDStyle exposing (Test, describe)
import App.Steps.Context exposing (initialContext)
import App.Steps.Given exposing (given)
import App.Steps.When exposing (when)
import App.Steps.Then exposing (then')


createTodoSuite : List Test
createTodoSuite =
    [ given "a current text"
        [ when "a todo is created"
            [ then' "a todo should be created with the current text"
            , then' "the current text should be reset"
            ]
        , given "an existing todo"
            [ when "a todo is created"
                [ then' "a todo should be created with the current text"
                , then' "the existing todo should still exist"
                ]
            ]
        ]
        initialContext
    ]


handleKeyUpSuite : List Test
handleKeyUpSuite =
    [ when "the ENTER key is pressed"
        [ then' "a todo should be created" ]
        initialContext
    , when "the T key is pressed"
        [ then' "nothing should happen" ]
        initialContext
    ]


updateTextSuite : List Test
updateTextSuite =
    [ given "a current text"
        [ when "the text is updated"
            [ then' "the new text should be stored in the model" ]
        ]
        initialContext
    ]


testSuite : Test
testSuite =
    describe "App.TodosTest"
        [ describe "createTodo" createTodoSuite
        , describe "handleKeyUp" handleKeyUpSuite
        , describe "updateText" updateTextSuite
        ]
