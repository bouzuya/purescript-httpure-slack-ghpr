module Action
  ( Action(..)
  , execute
  ) where

import Prelude

import Action.PullRequest as ActionPullRequest
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import HTTPure (ResponseM)

data Action
  = PullRequest String String

derive instance eqAction :: Eq Action
derive instance genericAction :: Generic Action _
instance showAction :: Show Action where
  show = genericShow

execute :: Action -> ResponseM
execute =
  case _ of
    PullRequest responseUrl notation ->
      ActionPullRequest.execute responseUrl notation
