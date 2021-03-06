module Main exposing (main)

import Browser
import Html exposing (Attribute, Html, button, div, h2, input, label, node, span, text)
import Html.Attributes exposing (style, type_, value)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { username : String
    , password : String
    , passwordAgain : String
    , count : Int
    }


init : Model
init =
    { username = ""
    , password = ""
    , passwordAgain = ""
    , count = 0
    }


type Msg
    = SetUsername String
    | SetPassword String
    | SetPasswordAgain String
    | Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetUsername username ->
            { model | username = username }

        SetPassword password ->
            { model
                | password = password
            }

        SetPasswordAgain passwordAgain ->
            { model
                | passwordAgain = passwordAgain
            }

        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


view : Model -> Html Msg
view model =
    node "main" [] (counter model ++ loginForm model)


counter : Model -> List (Html Msg)
counter model =
    [ h2 [] [ text "Counter" ]
    , div
        [ style "display" "flex"
        , style "align-items" "center"
        , style "text-align" "center"
        , style "margin" "0.5em"
        ]
        [ button [ onClick Decrement ] [ text "-" ]
        , span
            [ style "min-width" "1em"
            , style "padding" "0.5em"
            ]
            [ text (String.fromInt model.count) ]
        , button [ onClick Increment ] [ text "+" ]
        ]
    ]


loginForm : Model -> List (Html Msg)
loginForm model =
    [ h2 [] [ text "Login" ]
    , label [] [ text "username:" ]
    , input [ type_ "text", borderStyle "black", onInput SetUsername, value model.username ] []
    , label [] [ text "password:" ]
    , input [ type_ "password", passwordStyle model, onInput SetPassword, value model.password ] []
    , label [] [ text "password again:" ]
    , input [ type_ "password", passwordStyle model, onInput SetPasswordAgain, value model.passwordAgain ] []
    ]


borderStyle color =
    style "border" ("2px solid " ++ color)


passwordStyle : Model -> Attribute msg
passwordStyle model =
    let
        color =
            if model.password == "" && model.passwordAgain == "" then
                "orange"

            else if model.password == model.passwordAgain then
                "green"

            else
                "red"
    in
    borderStyle color
