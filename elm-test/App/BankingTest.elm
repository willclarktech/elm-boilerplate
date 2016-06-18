module App.BankingTest exposing (testSuite)

import App.Banking
import ElmTest exposing (Test, suite)


testSuite : Test
testSuite =
    suite "App.BankingTest"
        [ suite "check deposit"
            []
        ]
