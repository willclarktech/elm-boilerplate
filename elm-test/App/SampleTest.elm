module App.SampleTest exposing (testSuite)

import App.Sample exposing (sum, product)
import ElmTestBDDStyle exposing (Test, describe, it, expect, toBe, itAlways, expectThat, isTheSameAs, forEvery)
import Check.Producer exposing (filter, tuple, int, float)


testSuite : Test
testSuite =
    describe "App.Sample"
        [ describe "sum"
            [ it "should return a sum of 2 Ints"
                <| expect 8 toBe (sum 3 5)
            , it "should return a sum of 2 Floats"
                <| expect -10.5 toBe (sum -20.5 10)
            ]
        , describe "product"
            [ itAlways "multiplies Ints"
                <| expectThat (\( a, b ) -> product a b)
                    isTheSameAs
                    (\( a, b ) -> a * b)
                    forEvery
                    (tuple ( int, int ))
            , itAlways "multiplies Floats"
                <| expectThat (\( a, b ) -> product a b)
                    isTheSameAs
                    (\( a, b ) -> a * b)
                    forEvery
                    (tuple ( float, float ))
            , itAlways "inverts by division with minimal imprecision"
                <| expectThat (\( a, b ) -> abs (product a b / b - a) < 1.0e-6)
                    isTheSameAs
                    (\( a, b ) -> True)
                    forEvery
                    (filter (\( a, b ) -> b /= 0) (tuple ( float, float )))
            ]
        ]
