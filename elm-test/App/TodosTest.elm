module App.TodosTest exposing (testSuite)

import ElmTestBDDStyle
    exposing
        ( Test
        , describe
        )
import App.Steps.Context exposing (initialContext)
import App.Steps.Given
    exposing
        ( givenACurrentText
        , givenAnExistingTodo
        )
import App.Steps.When
    exposing
        ( whenATodoIsCreated
        , whenTheEnterKeyIsPressed
        , whenTheTKeyIsPressed
        , whenTheTextIsUpdated
        )
import App.Steps.Then
    exposing
        ( thenATodoShouldBeCreated
        , thenATodoShouldBeCreatedWithTheCurrentText
        , thenTheCurrentTextShouldBeReset
        , thenTheNewTextIsStoredInTheModel
        , thenTheExistingTodoShouldStillExist
        , thenNothingShouldHappen
        )


createTodoSuite : List Test
createTodoSuite =
    [ givenACurrentText
        [ whenATodoIsCreated
            [ thenATodoShouldBeCreatedWithTheCurrentText
            , thenTheCurrentTextShouldBeReset
            ]
        , givenAnExistingTodo
            [ whenATodoIsCreated
                [ thenATodoShouldBeCreatedWithTheCurrentText
                , thenTheExistingTodoShouldStillExist
                ]
            ]
        ]
        initialContext
    ]


handleKeyUpSuite : List Test
handleKeyUpSuite =
    [ whenTheEnterKeyIsPressed [ thenATodoShouldBeCreated ]
        initialContext
    , whenTheTKeyIsPressed [ thenNothingShouldHappen ]
        initialContext
    ]


updateTextSuite : List Test
updateTextSuite =
    [ givenACurrentText
        [ whenTheTextIsUpdated [ thenTheNewTextIsStoredInTheModel ]
        ]
        initialContext
    ]


testSuite : Test
testSuite =
    describe "App.TodosTest"
        [ describe "createTodo" createTodoSuite
        , describe "handleKeyUp" handleKeyUpSuite
        , describe "updateText" updateTextSuite
        ]
