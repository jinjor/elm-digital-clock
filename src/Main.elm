module Main exposing (..)

import Clock exposing (Digit(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (Time, second)
import Time.DateTime as DateTime exposing (DateTime)


main : Program Int Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { timezoneOffset : Int
    , currentTime : Time
    }


init : Int -> ( Model, Cmd Msg )
init timezoneOffset =
    ( Model timezoneOffset 0, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model
                | currentTime = newTime
              }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every (0.1 * second) Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        ( h1, h2 ) =
            fromModelToDigitPair DateTime.hour model

        ( m1, m2 ) =
            fromModelToDigitPair DateTime.minute model

        ( s1, s2 ) =
            fromModelToDigitPair DateTime.second model

        children =
            [ viewDigit h1
            , viewDigit h2
            , colon
            , viewDigit m1
            , viewDigit m2
            , colon
            , viewDigit s1
            , viewDigit s2
            ]
    in
    div []
        [ a [ href "https://github.com/jinjor/elm-digital-clock", class "link" ] [ text "GitHub" ]
        , div [ class "clock" ] children
        , div [ class "clock", class "shadow" ] children
        ]


colon : Html msg
colon =
    div [ class "colon" ]
        [ div [ class "colon-dot", class "c1" ] []
        , div [ class "colon-dot", class "c2" ] []
        ]


fromModelToDigitPair : (DateTime -> Int) -> Model -> ( Digit, Digit )
fromModelToDigitPair getNumber model =
    model.currentTime
        |> DateTime.fromTimestamp
        |> DateTime.addMinutes -model.timezoneOffset
        |> getNumber
        |> Clock.digitPair


viewDigit : Digit -> Html msg
viewDigit (D d1 d2 d3 d4 d5 d6 d7) =
    div [ class "digit" ]
        [ viewDigitPart "d1" d1
        , viewDigitPart "d2" d2
        , viewDigitPart "d3" d3
        , viewDigitPart "d4" d4
        , viewDigitPart "d5" d5
        , viewDigitPart "d6" d6
        , viewDigitPart "d7" d7
        ]


viewDigitPart : String -> Bool -> Html msg
viewDigitPart cls on =
    div
        [ class "digit-part"
        , class cls
        , class
            (if on then
                "on"
             else
                ""
            )
        ]
        []
