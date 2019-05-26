module Test.Main
  ( main
  ) where

import Prelude

import Effect (Effect)
import Test.Model.PullRequest as ModelPullRequest
import Test.Unit.Main as TestUnitMain

main :: Effect Unit
main = TestUnitMain.runTest do
  ModelPullRequest.tests
