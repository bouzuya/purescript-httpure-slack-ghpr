module Model.PullRequest
  ( PullRequest
  , fromString
  , toString
  ) where

import Prelude

import Data.Array.NonEmpty as NonEmptyArray
import Data.Int as Int
import Data.Maybe (Maybe)
import Data.Maybe as Maybe
import Data.String.Regex (Regex)
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Data.String.Regex.Unsafe as RegexUnsafe

data PullRequest = PullRequest String String Int

regex :: Regex
regex =
  RegexUnsafe.unsafeRegex
    "^([-_a-z0-9]+)/([-_a-z0-9]+)#([0-9]+)$"
    RegexFlags.noFlags

fromString :: String -> Maybe PullRequest
fromString s = do
  matches <- Regex.match regex s
  user <- join (NonEmptyArray.index matches 1)
  repo <- join (NonEmptyArray.index matches 2)
  number <- (join (NonEmptyArray.index matches 3)) >>= Int.fromString
  if number < 0 then Maybe.Nothing else pure unit
  pure (PullRequest user repo number)

toString :: PullRequest -> String
toString (PullRequest user repo number) =
  user <> "/" <> repo <> "#" <> show number

