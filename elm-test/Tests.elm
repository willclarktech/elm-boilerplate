module Tests exposing (testSuite)

import ElmTest exposing (Test, suite)
import App.SampleTest
import App.TodosTest


testSuite : Test
testSuite =
    suite "All tests"
        [ App.SampleTest.testSuite
        , App.TodosTest.testSuite
        ]
