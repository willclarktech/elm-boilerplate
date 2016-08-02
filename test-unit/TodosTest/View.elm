module TodosTest.View exposing (testSuite)

import ElmTest exposing (Test, suite)
import GivenWhenThen.Helpers exposing (constructGWTSuite)
import TodosTest.Context exposing (initialContext)
import TodosTest.Steps.Given exposing (given)
import TodosTest.Steps.When exposing (when)
import TodosTest.Steps.Then exposing (then')


handleKeyUpSuite : List Test
handleKeyUpSuite =
    constructGWTSuite
        [ given "a current text"
            [ when "the ENTER key is pressed"
                [ then' "a todo should be created" ]
            , when "the T key is pressed"
                [ then' "nothing should happen" ]
            ]
        , given "a blank text"
            [ when "the ENTER key is pressed"
                [ then' "nothing should happen" ]
            , when "the T key is pressed"
                [ then' "nothing should happen" ]
            ]
        ]
        initialContext


testSuite : Test
testSuite =
    suite "TodosTest.TodosTest"
        [ suite "handleKeyUp" handleKeyUpSuite
        ]
