module Main where

import System.Process
import System.Console.StructuredCLI
import System.Exit                   
import System.IO

import Control.Exception
import Control.Monad                 (void)
import Control.Monad.IO.Class        (liftIO)
import Data.Default                  (def)
import Wifi

withEcho :: Bool -> IO a -> IO a
withEcho echo action = do
  old <- hGetEcho stdin
  bracket_ (hSetEcho stdin echo) (hSetEcho stdin old) action


getWifi :: [String] -> [WifiSpot]
getWifi = map read

root :: Commands ()
root = do
  list 
  connect
  command "exit" "return to previous level" $ do 
            exitSuccess
            return NoAction
  

wifi :: Commands ()
wifi = command "wifi" "to access the wifi menu" $ return NewLevel


connect :: Commands ()
connect = command "connect" "connect to a wifi" $ do
          --liftIO . putStrLn $ "Hello world!"
          putStr "SSID name:"
          hFlush stdout
          ssid <- getLine
          putStr "Password:"
          hFlush stdout
          pass <- withEcho False getLine
          putChar '\n'
          status <- connectWifi ssid pass
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
