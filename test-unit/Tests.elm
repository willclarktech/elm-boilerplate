module Tests exposing (testSuite)

import ElmTest exposing (Test, suite)
import TodosTest.TodosTest as TodosTest


testSuite : Test
testSuite =
    suite "All tests" [ TodosTest.testSuite ]
