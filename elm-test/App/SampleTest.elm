module App.SampleTest exposing (testSuite)

import App.Sample exposing (sum, product)
import ElmTest exposing (Test, suite, test, assertEqual)
import Check exposing (quickCheck, claim, true, that, is, for)
import Check.Producer exposing (filter, tuple, int, float)
import Check.Test exposing (evidenceToTest)


testSuite : Test
testSuite =
    suite "App.Sample"
        [ suite "sum"
            [ test "should return a sum of 2 Ints" <| assertEqual 8 (sum 3 5)
            , test "should return a sum of 2 Floats" <| assertEqual -10.5 (sum -20.5 10)
            ]
        , evidenceToTest
            << quickCheck
            <| Check.suite "product"
                [ claim "should multiply Ints"
                    `that` (\( a, b ) -> product a b)
                    `is` (\( a, b ) -> a * b)
                    `for` tuple ( int, int )
                , claim "should multiply Floats"
                    `that` (\( a, b ) -> product a b)
                    `is` (\( a, b ) -> a * b)
                    `for` tuple ( float, float )
                , claim "should be inverted by division with minimal imprecision"
                    `true` (\( a, b ) -> abs (product a b / b - a) < 1.0e-6)
                    `for` (filter (\( a, b ) -> b /= 0) (tuple ( float, float )))
                ]
        ]
