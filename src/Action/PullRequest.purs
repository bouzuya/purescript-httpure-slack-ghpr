module Action.PullRequest
  ( execute
  ) where

import Prelude

import Data.Maybe as Maybe
import HTTPure (ResponseM)
import HTTPure as HTTPure
import Model.PullRequest as PullRequest
import View.PullRequest as ViewPullRequest

execute :: String -> String -> ResponseM
execute url s = do
  case PullRequest.fromString s of
    Maybe.Nothing -> HTTPure.badRequest ("invalid pr: " <> s)
    Maybe.Just pr ->
      let
        headers = HTTPure.header "Content-Type" "application/json"
        rendered = ViewPullRequest.render (PullRequest.toString pr)
      in HTTPure.ok' headers rendered
