module Routing exposing (..)

import Navigation
import UrlParser exposing (..)
import String


type Route
    = HomeIndexRoute
    | GameShowRoute String
    | GameErrorRoute
    | NotFoundRoute


toPath : Route -> String
toPath route =
    case route of
        HomeIndexRoute ->
            "/"

        GameShowRoute id ->
            "/game/" ++ id

        GameErrorRoute ->
            "/game-error"

        NotFoundRoute ->
            "/not-found"


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ format HomeIndexRoute (s "")
        , format GameShowRoute (s "game" </> string)
        , format GameErrorRoute (s "game-error")
        ]


pathParser : Navigation.Location -> Result String Route
pathParser location =
    location.pathname
        |> String.dropLeft 1
        |> parse identity routeParser


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser pathParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute


routeTitle : Route -> String
routeTitle route =
    case route of
        HomeIndexRoute ->
            "Ahoy, Matey!"

        GameShowRoute id ->
            id

        GameErrorRoute ->
            "Blow me down, game error!"

        NotFoundRoute ->
            "Yo Ho Ho, game not found!"
