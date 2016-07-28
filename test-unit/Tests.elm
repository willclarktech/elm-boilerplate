module Tests exposing (testSuite)

import ElmTest exposing (Test, suite)
import Todos.Test


testSuite : Test
testSuite =
    suite "All tests" [ Todos.Test.testSuite ]
