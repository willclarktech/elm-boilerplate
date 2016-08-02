module Main exposing (..)

import ElmTest exposing (Test, suite, runSuite)
import TodosTest.Update
import TodosTest.View


main : Program Never
main =
    runSuite testSuite


testSuite : Test
testSuite =
    suite "All tests"
        [ TodosTest.Update.testSuite
        , TodosTest.View.testSuite
        ]
