module Clock exposing (Digit(..), digitPair)


type Digit
    = D Bool Bool Bool Bool Bool Bool Bool


digitPair : Int -> ( Digit, Digit )
digitPair n =
    let
        first =
            (n // 10) % 10

        second =
            n % 10
    in
    ( digit first, digit second )


digit : Int -> Digit
digit n =
    case n of
        0 ->
            D t t t f t t t

        1 ->
            D f f t f f t f

        2 ->
            D t f t t t f t

        3 ->
            D t f t t f t t

        4 ->
            D f t t t f t f

        5 ->
            D t t f t f t t

        6 ->
            D t t f t t t t

        7 ->
            D t t t f f t f

        8 ->
            D t t t t t t t

        9 ->
            D t t t t f t t

        _ ->
            D f f f f f f f


t =
    True


f =
    False
