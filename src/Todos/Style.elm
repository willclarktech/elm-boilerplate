module Todos.Style exposing (headingStyle, headerStyle)

type alias Style = List (String, String)

headingStyle : Style
headingStyle =
  [ ( "padding-top", "40px" )
  , ( "padding-bottom", "40px" )
  ]

headerStyle : Style
headerStyle =
  [ ( "font-size", "50px" ) ]
