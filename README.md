## Wifi-SMIT
Wifi-SMIT is a console application built with Haskell which simplifies controling the wifi over the terminal. 
### Requirements
In order to use Wifi-SMIT you should have [nmcli](https://developer.gnome.org/NetworkManager/stable/nmcli.html). Application was tested on Fedora 30. 
### Install 
```
git clone https://github.com/dariodsa/Wifi-SMIT.git
cd Wifi-SMIT
cabal build && cabal run
```
### Usage
```
WIFI-SMIT > ?
- exit: exit the program
- connect: connect to a wifi
- list: list avaliable wifis
- on: turn wifi on
- off: turn wifi off

WIFI-SMIT > list 
AMIS-340A49, strength:72
POLE123, strength:69
ISKONOVAC-30CA1C, strength:54
B.net1665, strength:52
SindaNet, strength:50
Dora1, strength:32
WIFI-SMIT > on
Wifi turned on.
WIFI-SMIT > off
Wifi turned off.
WIFI-SMIT > connect
SSID name:Dora1
Password:
Device 'wlo1' successfully activated with 'b86e9cfe-b459-412e-abc5-dc7f85c12524'.
WIFI-SMIT > exit

```


