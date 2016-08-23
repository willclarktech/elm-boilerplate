module Todos.Style
    exposing
        ( headingStyle
        , headerStyle
        , tabLinkStyle
        , activeTabLinkStyle
        )


type alias Style =
    List ( String, String )


headingStyle : Style
headingStyle =
    [ ( "padding-top", "40px" )
    , ( "padding-bottom", "40px" )
    ]


headerStyle : Style
headerStyle =
    [ ( "font-size", "50px" ) ]


tabLinkStyle : Style
tabLinkStyle =
    [ ( "cursor", "pointer" ) ]


activeTabLinkStyle : Style
activeTabLinkStyle =
    List.append tabLinkStyle
        [ ( "text-decoration", "underline" ) ]
