module Wifi where

import System.Process
import System.Console.StructuredCLI

data WifiSpot = WifiSpot { name :: String, 
                           strength :: Int
                         } deriving (Eq)

instance Show WifiSpot where
   show (WifiSpot name strength) = name ++ ", strength:" ++ (show strength)

instance Ord WifiSpot where
    (<)  (WifiSpot _ s1) (WifiSpot _ s2) = s1 < s2
    (<=) (WifiSpot _ s1) (WifiSpot _ s2) = s1 <= s2

instance Read WifiSpot where
    readsPrec _ input =
      let name = takeWhile (/= ':') input
          strength = read $ tail $ dropWhile (/= ':') input
       in [(WifiSpot name strength, "")]


connectWifi :: String -> String -> IO (Either Bool String)
connectWifi ssid password = do
         (exitCode, std_out, std_err) <- readProcessWithExitCode "nmcli" ["device", "wifi", "connect", ssid, "password", password] []
         putStrLn std_out
         if length std_err == 0 then return $ Left True
         else return $ Right std_out

--turnWifi :: Bool -> Commands ()
turnWifi status = do 
           (exitCode, std_out, std_err) <- readProcessWithExitCode "nmcli" ["radio", "wifi", status] []
           putStrLn $ "Wifi turned " ++ status ++"."
           return NoAction
        
