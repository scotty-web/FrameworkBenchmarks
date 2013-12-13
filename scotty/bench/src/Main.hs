{-# LANGUAGE OverloadedStrings #-}

import           System.Environment (getArgs)
import           Web.Scotty
import           Data.Text
import           Data.Aeson ((.=), object)

main :: IO ()
main = do
        [threads, dbhost] <- getArgs
        scotty 3000 $ do
            get "/json" getJson
            get "/db/postgres" getPostgres
            get "/plaintext" getPlainText

getJson :: ActionM ()
getJson = json $ object ["message" .= msg]
    where msg = "Hello, World!" :: Text

getPostgres :: ActionM ()
getPostgres = text "Not implemented yet."

getPlainText :: ActionM ()
getPlainText = text "Hello, World!"
