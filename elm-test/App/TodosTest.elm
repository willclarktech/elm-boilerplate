module App.TodosTest exposing (testSuite)

import ElmTestBDDStyle
    exposing
        ( Test
        , describe
        )
import App.Steps.Context
    exposing
        ( initialTodoCtx
        , initialKeyPressCtx
        )
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
        initialTodoCtx
    ]


handleKeyUpSuite : List Test
handleKeyUpSuite =
    [ whenTheEnterKeyIsPressed [ thenATodoShouldBeCreated ]
        initialKeyPressCtx
    , whenTheTKeyIsPressed [ thenNothingShouldHappen ]
        initialKeyPressCtx
    ]


updateTextSuite : List Test
updateTextSuite =
    [ givenACurrentText
        [ whenTheTextIsUpdated [ thenTheNewTextIsStoredInTheModel ]
        ]
        initialTodoCtx
    ]


testSuite : Test
testSuite =
    describe "App.TodosTest"
        [ describe "createTodo" createTodoSuite
        , describe "handleKeyUp" handleKeyUpSuite
        , describe "updateText" updateTextSuite
        ]
