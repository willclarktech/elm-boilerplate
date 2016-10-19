module Todos.View.Filters exposing (viewFilters)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Todos.Types exposing (FilterOption(..), Msg(..))
import Todos.Copy exposing (getButtonText)


viewFilters : FilterOption -> Bool -> Html Msg
viewFilters activeOption showSaveButton =
    let
        filterButtons =
            div [ class "ui buttons" ]
                <| List.map (\option -> viewFilterButton option (option == activeOption))
                    [ All, Completed, Incomplete ]

        children =
            if showSaveButton then
                [ filterButtons, viewSaveButton ]
            else
                [ filterButtons ]
    in
        div
            [ id "filters"
            , class "ui tiny segment attached center aligned"
            ]
            children


viewFilterButton : FilterOption -> Bool -> Html Msg
viewFilterButton filterOption isActive =
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
            if isActive then
                baseClass ++ "active primary "
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
            , class "ui button secondary right floated"
            ]
            [ text <| getButtonText buttonId ]
