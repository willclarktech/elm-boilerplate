module Todos.View.Filters exposing (viewFilters)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Todos.Types exposing (FilterOption(..), Msg(..))
import Todos.Copy exposing (getButtonText)


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
