module Main exposing (main)

import Browser
import Html exposing (Attribute, Html, div, h1, input, label, table, tbody, td, text, tr)
import Html.Attributes exposing (id, style, type_, value)
import Html.Events exposing (onInput)


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
    }


init : Model
init =
    { username = ""
    , password = ""
    , passwordAgain = ""
    }


type Msg
    = SetUsername String
    | SetPassword String
    | SetPasswordAgain String


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


view : Model -> Html Msg
view model =
    div [ id "main", style "margin" "8px" ]
        [ h1 [] [ text "Login" ]
        , table []
            [ tbody []
                [ tr []
                    [ td [] [ label [] [ text "username:" ] ]
                    , td [] [ input [ type_ "text", borderStyle "black", onInput SetUsername, value model.username ] [] ]
                    ]
                , tr []
                    [ td [] [ label [] [ text "password:" ] ]
                    , td [] [ input [ type_ "password", passwordStyle model, onInput SetPassword, value model.password ] [] ]
                    ]
                , tr []
                    [ td [] [ label [] [ text "password again:" ] ]
                    , td [] [ input [ type_ "password", passwordStyle model, onInput SetPasswordAgain, value model.passwordAgain ] [] ]
                    ]
                ]
            ]
        ]


borderStyle : String -> Attribute msg
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
