# Open VPyN Client
##Info
Openvpn doesn't provide a linux client with GUI, so here is such thing done in python.


## Install
1. rename "[demo]profile.ovpn to "profile.ovpn"
2. install the dependencies with pip3 and apt. 
3. It doesn't matter what the name of your Openvpn file is, it is only important that it ends with the ".opvn" file extension.
4. If you choose your own .ovpn file, make sure to remove "PROFILETEST.ovpn".

````
sudo apt install python3 python3-pip python-tk python3-tk openvpn
````

````
pip3 install requests
````

````
git clone https://github.com/MikMuellerDev/LinuxStuff && cd LinuxStuff/OpenVPyN/ && python3 main.py
````
