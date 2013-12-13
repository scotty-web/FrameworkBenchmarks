{-# LANGUAGE GADTs #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import           System.Random
import           Control.Monad.IO.Class (liftIO)
import           Database.Persist
import           Database.Persist.Postgresql
import           Database.Persist.TH

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
World sql=World
    randomNumber        Int     sql=randomNumber
    deriving Show
|]

connStr :: ConnectionString
connStr = "host=localhost dbname=bench user=bench password=bench port=5432"

main :: IO ()
main = do
        gen <- newStdGen
        withPostgresqlPool connStr 10 $ \pool -> do
            flip runSqlPersistMPool pool $ do
                runMigration migrateAll    
           
                liftIO $ putStrLn "Population starting..."
                mapM_ (insert . World) (take 10000 $ randoms gen)
                liftIO $ putStrLn "Population complete."
