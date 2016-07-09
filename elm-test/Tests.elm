module Tests exposing (testSuite)

import ElmTest exposing (Test, suite)
import App.TodosTest


testSuite : Test
testSuite =
    suite "All tests"
        [ App.TodosTest.testSuite
        ]
