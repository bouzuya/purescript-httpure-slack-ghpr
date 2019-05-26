module Action.PullRequest
  ( execute
  ) where

import Prelude

import Bouzuya.HTTP.Client as Client
import Bouzuya.HTTP.Method as Method
import Data.Maybe as Maybe
import Data.Options ((:=))
import Data.Tuple as Tuple
import Effect.Class as Class
import Effect.Exception as Exception
import Foreign.Object as Object
import HTTPure (ResponseM)
import HTTPure as HTTPure
import Model.PullRequest as PullRequest
import Simple.JSON as SimpleJSON
import View.PullRequest as ViewPullRequest

type GHResponse =
  { base :: { ref :: String }
  , head :: { ref :: String }
  , title :: String
  }

execute :: String -> String -> ResponseM
execute url s = do
  case PullRequest.fromString s of
    Maybe.Nothing -> HTTPure.badRequest ("invalid pr: " <> s)
    Maybe.Just pr -> do
      { body } <-
        Client.fetch
          ( Client.url := (PullRequest.toUrlString pr)
          <> Client.headers :=
              (Object.fromFoldable
                [ Tuple.Tuple "User-Agent" "slack-ghpr"
                ])
          <> Client.method := Method.GET)
      { base: { ref: baseRef }, head: { ref: headRef }, title } <-
        Class.liftEffect
          (Maybe.maybe
            (Exception.throw "fetch title")
            pure
            (SimpleJSON.readJSON_ (Maybe.fromMaybe "" body) :: _ GHResponse))
      let
        headers = HTTPure.header "Content-Type" "application/json"
        rendered =
          ViewPullRequest.render
            { base: baseRef
            , head: headRef
            , name: (PullRequest.toString pr)
            , title
            }
      HTTPure.ok' headers rendered
