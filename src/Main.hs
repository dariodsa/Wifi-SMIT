module Main where

import System.Process
import System.Console.StructuredCLI

import Control.Monad                 (void)
import Control.Monad.IO.Class        (liftIO)
import Data.Default                  (def)
import Wifi

getWifi :: [String] -> [WifiSpot]
getWifi = map read

root :: Commands ()
root = do
  world >+ do
    hello
    bye
    command "exit" "return to previous level" exit

world :: Commands ()
world = command "world" "enter into the world" $ return NewLevel

hello :: Commands ()
hello = command "hello" "prints a greeting" $ do
          liftIO . putStrLn $ "Hello world!"
          return NoAction

bye :: Commands ()
bye = command "bye" "say goodbye" $ do
        liftIO . putStrLn $ "Sayonara!"
        return NoAction


main :: IO ()
main =  void $ runCLI "WIFI-SMIT" def root
        -- wifiList <- readProcess "nmcli" ["-g", "SSID,SIGNAL", "device", "wifi", "list", "--rescan", "auto"] []
         --runCLI "Hellow CLI" def 
         --putStrLn $ unlines $ map show $ getWifi $ lines wifiList
