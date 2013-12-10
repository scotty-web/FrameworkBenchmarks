{-# LANGUAGE OverloadedStrings #-}

import           Web.Scotty
import           Data.Text
import           Data.Aeson ((.=), object)

main :: IO ()
main = scotty 3000 $ do
    get "/json" getJson

getJson :: ActionM ()
getJson = json $ object ["message" .= msg]
    where msg = "Hello, World!" :: Text
