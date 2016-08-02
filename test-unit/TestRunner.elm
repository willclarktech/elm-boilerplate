module Main exposing (..)

import ElmTest exposing (Test, suite, runSuite)
import Todos.Test


main : Program Never
main =
    runSuite testSuite


testSuite : Test
testSuite =
    suite "All tests" [ Todos.Test.testSuite ]
