module Todos.View.Filters exposing (viewFilters)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material
import Material.Button as Button
import Todos.Types exposing (FilterOption(..), Msg(..))
import Todos.Copy exposing (getButtonText)


viewFilters : Material.Model -> FilterOption -> Bool -> Html Msg
viewFilters uiModel activeOption showSaveButton =
    let
        filterButtons =
            div []
                <| List.map (\option -> viewFilterButton uiModel option (option == activeOption))
                    [ All, Completed, Incomplete ]

        children =
            if showSaveButton then
                [ filterButtons, viewSaveButton uiModel ]
            else
                [ filterButtons ]
    in
        div
            [ id "filters"
            ]
            children


viewFilterButton : Material.Model -> FilterOption -> Bool -> Html Msg
viewFilterButton uiModel filterOption isActive =
    let
        ( index, idSuffix ) =
            case filterOption of
                All ->
                    ( 0, "all" )

                Completed ->
                    ( 1, "completed" )

                Incomplete ->
                    ( 2, "incomplete" )

        buttonId =
            "filter-" ++ idSuffix

        buttonColor =
            if isActive then
                Button.accent
            else
                Button.primary
    in
        Button.render UI
            [ 0, index ]
            uiModel
            [ Button.raised
            , Button.onClick <| Filter filterOption
            , Button.colored
            , buttonColor
            , Button.ripple
            ]
            [ span [ id buttonId ]
                [ text <| getButtonText buttonId ]
            ]


viewSaveButton : Material.Model -> Html Msg
viewSaveButton uiModel =
    let
        buttonId =
            "save"
    in
        Button.render UI
            [ 1 ]
            uiModel
            [ Button.raised
            , Button.onClick <| Save
            , Button.colored
            , Button.accent
            , Button.ripple
            ]
            [ span [ id buttonId ]
                [ text <| getButtonText buttonId ]
            ]
