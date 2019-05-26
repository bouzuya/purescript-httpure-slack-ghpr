module Test.Model.PullRequest
  ( tests
  ) where

import Prelude

import Data.Maybe as Maybe
import Model.PullRequest as PullRequest
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Model.PullRequest" do
  TestUnit.test "fromString / toString" do
    Assert.equal
      (Maybe.Just "user/repo#123")
      (map PullRequest.toString (PullRequest.fromString "user/repo#123"))
    Assert.equal
      (Maybe.Just "user-name/repo-name#123")
      (map
        PullRequest.toString
        (PullRequest.fromString "user-name/repo-name#123"))
    Assert.equal
      (Maybe.Just "user.name/repo.name#123")
      (map
        PullRequest.toString
        (PullRequest.fromString "user.name/repo.name#123"))
