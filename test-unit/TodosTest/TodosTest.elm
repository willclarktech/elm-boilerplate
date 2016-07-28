module TodosTest.TodosTest exposing (testSuite)

import ElmTest exposing (Test, suite)
import TodosTest.Steps.Context exposing (initialContext)
import TodosTest.Steps.Given exposing (given)
import TodosTest.Steps.When exposing (when)
import TodosTest.Steps.Then exposing (then')


createTodoSuite : List Test
createTodoSuite =
    [ given "an initial count"
        [ given "a current text"
            [ when "a todo is created"
                [ then' "a todo should be created with the current text"
                , then' "the current text should be reset"
                , then' "the counter should be incremented"
                ]
            , given "an existing todo"
                [ when "a todo is created"
                    [ then' "a todo should be created with the current text"
                    , then' "the existing todo should still exist"
                    ]
                ]
            ]
        ]
        initialContext
    ]


handleKeyUpSuite : List Test
handleKeyUpSuite =
    [ given "a current text"
        [ when "the ENTER key is pressed"
            [ then' "a todo should be created" ]
        , when "the T key is pressed"
            [ then' "nothing should happen" ]
        ]
        initialContext
    , given "a blank text"
        [ when "the ENTER key is pressed"
            [ then' "nothing should happen" ]
        , when "the T key is pressed"
            [ then' "nothing should happen" ]
        ]
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


markAsCompletedSuite : List Test
markAsCompletedSuite =
    [ given "an existing todo"
        [ when "the todo is marked as completed"
            [ then' "the todo should be completed" ]
        , given "another existing todo"
            [ when "the todo is marked as completed"
                [ then' "the other todo should not be completed" ]
            ]
        ]
        initialContext
    ]


markAsIncompleteSuite : List Test
markAsIncompleteSuite =
    [ given "an existing todo"
        [ given "the todo has been marked as completed"
            [ when "the todo is marked as incomplete"
                [ then' "the todo should not be completed" ]
            , given "another existing todo"
                [ given "the other todo has been marked as completed"
                    [ when "the todo is marked as incomplete"
                        [ then' "the other todo should be completed" ]
                    ]
                ]
            ]
        ]
        initialContext
    ]


deleteSuite : List Test
deleteSuite =
    [ given "an existing todo"
        [ when "the todo is deleted"
            [ then' "the todo should be gone" ]
        , given "another existing todo"
            [ when "the todo is deleted"
                [ then' "the other todo should remain" ]
            ]
        ]
        initialContext
    ]


testSuite : Test
testSuite =
    suite "TodosTest.TodosTest"
        [ suite "createTodo" createTodoSuite
        , suite "handleKeyUp" handleKeyUpSuite
        , suite "updateText" updateTextSuite
        , suite "markAsCompleted" markAsCompletedSuite
        , suite "markAsIncomplete" markAsIncompleteSuite
        , suite "delete" deleteSuite
        ]
