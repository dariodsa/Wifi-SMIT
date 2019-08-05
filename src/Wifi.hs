module Wifi where

data WifiSpot = WifiSpot { name :: String, 
                           strength :: Int
                         } deriving (Eq, Show)

instance Ord WifiSpot where
    (<)  (WifiSpot _ s1) (WifiSpot _ s2) = s1 < s2
    (<=) (WifiSpot _ s1) (WifiSpot _ s2) = s1 <= s2

instance Read WifiSpot where
    readsPrec _ input =
      let name = takeWhile (/= ':') input
          strength = read $ tail $ dropWhile (/= ':') input
       in [(WifiSpot name strength, "")]

