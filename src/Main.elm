module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Svg as S exposing (Svg)
import Svg.Attributes as A
import Svg.Events as E



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    -- let
    -- _ =
    -- Debug.log "kwords" <| kWords 2 2
    -- in
    div []
        -- [ img [ src "/logo.svg" ] []
        -- , h1 [] [ text "Your Elm App is working!" ]
        [ S.svg [ A.style "width: 50%; border: 1px solid black", A.viewBox "-50 -50 100 100" ]
            [ S.g []
                (List.range 0 5
                    |> List.concatMap (kWords rots)
                    |> List.map viewInstance
                )
            ]
        ]


kWords : Int -> Int -> List (List Int)
kWords steps n =
    case n of
        0 ->
            [ [] ]

        _ ->
            kWords steps (n - 1)
                |> List.concatMap (\l -> List.range 0 steps |> List.map (\s -> s :: l))


type alias Mirror =
    Int


r =
    5


rots =
    3


viewInstance : List Mirror -> Svg msg
viewInstance mirrors =
    case mirrors of
        [] ->
            S.circle [ A.cx "0", A.cy "0", A.r (String.fromInt r) ] []

        head :: tail ->
            let
                ( x, y ) =
                    fromPolar ( 2 * r, toFloat head * 2 * pi / rots )
            in
            S.g
                [ A.transform <| "translate(" ++ String.fromFloat x ++ " " ++ String.fromFloat y ++ ") scale(1 -1)"
                , A.opacity <| String.fromFloat 0.35
                ]
                [ viewInstance tail ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
