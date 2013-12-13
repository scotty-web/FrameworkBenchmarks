{-# LANGUAGE OverloadedStrings #-}

import           Web.Scotty
import           Data.Text
import           Data.Aeson ((.=), object)

main :: IO ()
main = scotty 3000 $ do
    get "/json" getJson
    get "/plaintext" getPlainText

getJson :: ActionM ()
getJson = json $ object ["message" .= msg]
    where msg = "Hello, World!" :: Text

getPlainText :: ActionM ()
getPlainText = text "Hello, World!"
