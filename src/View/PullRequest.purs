module View.PullRequest
  ( render
  ) where

import Prelude

import Data.String as String
import Simple.JSON as SimpleJSON
import View.Helper.Block as Block
import View.Helper.TextObject as TextObject

render ::
  { base :: String
  , head :: String
  , name :: String
  , title :: String
  }
  -> String
render { base, head, name, title } =
  SimpleJSON.writeJSON
    -- https://api.slack.com/reference/messaging/payload
    {
      -- undocumented:
      -- https://api.slack.com/slash-commands#responding_immediate_response
      response_type: "ephemeral", -- or "in_channel",
      blocks:
      [ Block.sectionBlock
        { text:
          TextObject.plainText
            { text:
              String.joinWith
                "\n"
                [ name
                , base <> " <- " <> head
                , title
                ]
            }
        }
      ]
    }
