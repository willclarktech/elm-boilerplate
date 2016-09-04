module Todos.View exposing (view, handleNewTodoKeyUp)

import Json.Decode as Json
import Html exposing (..)
import Html.Keyed exposing (ol)
import Html.Attributes exposing (..)
import Html.Events
    exposing
        ( onInput
        , onClick
        , onCheck
        , on
        , keyCode
        , targetChecked
        )
import Markdown
import Helpers exposing (isEnter)
import Todos.Types
    exposing
        ( Model
        , Todo
        , Msg(..)
        , Tab(..)
        , FilterOption(..)
        )
import Todos.Copy
    exposing
        ( tabText
        , placeholderText
        , getButtonText
        , infoMD
        )
import Todos.Style
    exposing
        ( headingStyle
        , headerStyle
        , tabLinkStyle
        , activeTabLinkStyle
        )
import OAuth.Types
import OAuth.View


view : Model -> Html Msg
view { tab, currentText, todos, filterOption, currentlyEditing, oauth } =
    let
        baseComponents =
            case tab of
                Todos ->
                    [ viewHeading oauth tab
                    , viewNewTodoInput currentText
                    ]

                Info ->
                    [ viewHeading oauth tab
                    , viewInfo
                    ]

        components =
            if tab == Todos && List.length todos /= 0 then
                List.append baseComponents
                    [ viewFilters filterOption oauth.userName
                    , viewTodos todos filterOption currentlyEditing
                    ]
            else
                baseComponents
    in
        div
            [ id "todos-app"
            , class "ui segments container"
            ]
            components


viewHeading : OAuth.Types.Model -> Tab -> Html Msg
viewHeading oauthModel tab =
    div
        [ class "ui attached inverted orange segment"
        , style headingStyle
        ]
        [ h1
            [ class "ui huge header"
            , style headerStyle
            ]
            [ span
                [ id "tab-todos"
                , style
                    (if tab == Todos then
                        activeTabLinkStyle
                     else
                        tabLinkStyle
                    )
                , onClick <| SwitchTab Todos
                ]
                [ text <| tabText Todos ]
            , text " / "
            , span
                [ id "tab-info"
                , style
                    (if tab == Info then
                        activeTabLinkStyle
                     else
                        tabLinkStyle
                    )
                , onClick <| SwitchTab Info
                ]
                [ text <| tabText Info ]
            , span []
                [ OAuth.View.view oauthModel ]
            ]
        ]


viewNewTodoInput : String -> Html Msg
viewNewTodoInput currentText =
    div [ class "ui compact attached segment" ]
        [ div [ class "ui huge form" ]
            [ input
                [ id "new-todo"
                , class "ui field"
                , placeholder placeholderText
                , on "keyup" <| Json.map (handleNewTodoKeyUp currentText) keyCode
                , onInput UpdateText
                , value currentText
                ]
                []
            ]
        ]


viewFilters : FilterOption -> Maybe String -> Html Msg
viewFilters activeOption userName =
    let
        filterButtons =
            div [ class "ui buttons" ]
                <| List.map (viewFilterButton activeOption)
                    [ All, Completed, Incomplete ]

        children =
            case userName of
                Nothing ->
                    [ filterButtons ]

                Just _ ->
                    [ filterButtons, viewSaveButton ]
    in
        div
            [ id "filters"
            , class "ui tiny segment attached center aligned"
            ]
            children


viewFilterButton : FilterOption -> FilterOption -> Html Msg
viewFilterButton activeOption filterOption =
    let
        idSuffix =
            case filterOption of
                All ->
                    "all"

                Completed ->
                    "completed"

                Incomplete ->
                    "incomplete"

        buttonId =
            "filter-" ++ idSuffix

        baseClass =
            "ui button "

        buttonClass =
            if activeOption == filterOption then
                baseClass ++ "active orange "
            else
                baseClass
    in
        button
            [ id buttonId
            , onClick <| Filter filterOption
            , class buttonClass
            ]
            [ text <| getButtonText buttonId ]


viewSaveButton : Html Msg
viewSaveButton =
    let
        buttonId =
            "save"
    in
        button
            [ id buttonId
            , onClick <| Save
            , class "ui button positive right floated"
            ]
            [ text <| getButtonText buttonId ]


viewTodos : List Todo -> FilterOption -> Maybe Todo -> Html Msg
viewTodos todos filterOption currentlyEditing =
    let
        relevantTodos =
            getTodosForFilterOption todos filterOption
    in
        div [ class "ui attached segment" ]
            <| case relevantTodos of
                [] ->
                    [ text "No todos to display..." ]

                _ ->
                    let
                        isCurrentlyEditing { id } =
                            case currentlyEditing of
                                Nothing ->
                                    False

                                Just currentTodo ->
                                    currentTodo.id == id
                    in
                        [ Html.Keyed.ol [ class "ui huge list" ]
                            <| List.map
                                (\todo ->
                                    ( toString todo.id
                                    , viewTodo todo (isCurrentlyEditing todo)
                                    )
                                )
                                relevantTodos
                        ]


getTodosForFilterOption : List Todo -> FilterOption -> List Todo
getTodosForFilterOption todos filterOption =
    case filterOption of
        Completed ->
            List.filter (\todo -> todo.completed) todos

        Incomplete ->
            List.filter (\todo -> todo.completed /= True) todos

        All ->
            todos


viewTodo : Todo -> Bool -> Html Msg
viewTodo todo isCurrentlyEditing =
    let
        baseClass =
            "item "

        todoClass =
            if todo.completed then
                baseClass ++ "completed"
            else
                baseClass

        todoText =
            if isCurrentlyEditing then
                span [ class "ui mini input" ]
                    [ input
                        [ class "edit"
                        , type' "text"
                        , value todo.text
                        , on "keyup" <| Json.map handleEditTodoKeyUp keyCode
                        , onInput <| UpdateTodo todo
                        ]
                        []
                    ]
            else
                label [ onClick <| handleClick todo ] [ text todo.text ]
    in
        li
            [ id ("todo-" ++ toString todo.id)
            , class todoClass
            ]
            [ viewCheckbox todo
            , todoText
            , viewDeleteButton todo
            ]


viewCheckbox : Todo -> Html Msg
viewCheckbox todo =
    span [ class "ui right spaced image" ]
        [ input
            [ class "toggle"
            , type' "checkbox"
            , onCheck <| handleCheck todo
            , checked todo.completed
            ]
            []
        ]


viewDeleteButton : Todo -> Html Msg
viewDeleteButton todo =
    button
        [ class "delete ui compact icon negative button right floated"
        , onClick <| Delete todo
        ]
        [ text "×" ]


viewInfo : Html Msg
viewInfo =
    div
        [ id "info"
        , class "ui compact attached segment"
        ]
        [ Markdown.toHtml [] infoMD
        ]


handleNewTodoKeyUp : String -> Int -> Msg
handleNewTodoKeyUp currentText keyCode =
    if currentText /= "" && isEnter keyCode then
        CreateTodo
    else
        NoOp


handleEditTodoKeyUp : Int -> Msg
handleEditTodoKeyUp keyCode =
    if isEnter keyCode then
        StopEditing
    else
        NoOp


handleCheck : Todo -> Bool -> Msg
handleCheck todo checked =
    if checked then
        MarkAsCompleted todo
    else
        MarkAsIncomplete todo


handleClick : Todo -> Msg
handleClick todo =
    StartEditing todo
