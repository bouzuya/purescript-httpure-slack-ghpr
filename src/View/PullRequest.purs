module View.PullRequest
  ( render
  ) where

import Prelude

import Simple.JSON as SimpleJSON
import View.Helper.Block as Block
import View.Helper.TextObject as TextObject

render :: String -> String -> String
render s title =
  SimpleJSON.writeJSON
    -- https://api.slack.com/reference/messaging/payload
    {
      -- undocumented:
      -- https://api.slack.com/slash-commands#responding_immediate_response
      response_type: "ephemeral", -- or "in_channel",
      blocks:
      [ Block.sectionBlock
        { text: TextObject.plainText { text: s <> " " <> title } }
      ]
    }
