module View.PullRequest
  ( render
  ) where

import Data.Maybe as Maybe
import Simple.JSON as SimpleJSON
import View.Helper.Block as Block
import View.Helper.BlockElement as BlockElement
import View.Helper.TextObject as TextObject

render :: String -> String
render s =
  SimpleJSON.writeJSON
    -- https://api.slack.com/reference/messaging/payload
    {
      -- undocumented:
      -- https://api.slack.com/slash-commands#responding_immediate_response
      response_type: "ephemeral", -- or "in_channel",
      blocks:
      [ Block.sectionBlock
        { text: TextObject.plainText { text: s } }
      ]
    }
