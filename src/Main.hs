module Main where

import System.Process
import System.Console.StructuredCLI

import System.Exit                   
import Control.Monad                 (void)
import Control.Monad.IO.Class        (liftIO)
import Data.Default                  (def)
import Wifi

getWifi :: [String] -> [WifiSpot]
getWifi = map read

root :: Commands ()
root = do
  list 
  hello
  list
  command "exit" "return to previous level" $ do 
            exitSuccess
            return NoAction
  

wifi :: Commands ()
wifi = command "wifi" "to access the wifi menu" $ return NewLevel

hello :: Commands ()
hello = command "hello" "prints a greeting" $ do
          liftIO . putStrLn $ "Hello world!"
          return NoAction

list :: Commands ()
list = command "list" "list avaliable wifis" $ do
        wifiList <- readProcess "nmcli" ["-g", "SSID,SIGNAL", "device", "wifi", "list", "--rescan", "auto"] []
        liftIO . putStrLn $ unlines $ map show $ getWifi $ lines wifiList
        return NoAction


main :: IO ()
main =  void $ runCLI "WIFI-SMIT" def root
        -- wifiList <- readProcess "nmcli" ["-g", "SSID,SIGNAL", "device", "wifi", "list", "--rescan", "auto"] []
         --runCLI "Hellow CLI" def 
         --putStrLn $ unlines $ map show $ getWifi $ lines wifiList
