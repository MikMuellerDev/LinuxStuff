#!/usr/bin/python3
import tkinter as tk
from tkinter import *
from tkinter import ttk
import os
import threading
import requests
import time
from SECRETSDEMO import sudo_passwd


# disconnects
def disconnecting():
    os.system("echo " + sudo_passwd + " | sudo -S pkill openvpn")


# connects to the actual vpn
def connecting():
    os.system("echo " + sudo_passwd + " | sudo -S openvpn --config *.ovpn")


def window(height=400, width=300):
    # Window properties
    root = tk.Tk()
    root.title("VPN")
    root.resizable(False, False)
    root.tk.call('wm', 'iconphoto', root._w, tk.PhotoImage(file='icon.png'))
    ttk.Style().theme_use('clam')

    # Canvas and Frame
    canvas = tk.Canvas(root, height=height, width=width)
    canvas.pack()
    frame = tk.Frame(root, bd=15)
    frame.place(relheight=1, relwidth=1)
    pad_x = 15
    pad_y = 10

    output = Text(frame, bg="#424242", width=37, height=10)
    output.grid(column=1, row=3, padx=1, pady=1)

    pmt = ttk.Button(frame, text="Connect", command=lambda: threading.Thread(target=connect).start())
    pmt.grid(column=1, row=1, padx=pad_x, pady=pad_y)

    prt = ttk.Button(frame, text="Disconnect", command=lambda: threading.Thread(target=disconnect).start())
    prt.grid(column=1, row=2, padx=pad_x, pady=pad_y)

    def println(input_):
        output.delete(1.0, 'end-1c')
        output.insert(index=1.0, chars=input_)

    def connect():
        if ping_google():
            ip_before = requests.get("https://ipinfo.io/ip").text
            println("Connecting...")
            threading.Thread(target=connecting).start()
            time.sleep(2)
            while not ping_google():
                time.sleep(2)
            println("Google pinged.")
            ip_after = requests.get("https://ipinfo.io/ip").text
            if ping_google():
                if ip_after is not ip_before:
                    println("Successfully connected.")
                    print("Successfully connected")
                else:
                    println("Error, your IP did not change.")
                    print("Error, your IP did not change.")
            else:
                println("Connection Error.")
            println("Current IP: " + requests.get("https://ipinfo.io/ip").text)

    def disconnect():
        if ping_google():
            ip_before = requests.get("https://ipinfo.io/ip").text
            println("Disconnecting...")
            print("Disconnecting")
            for j in range(2):
                threading.Thread(target=disconnecting).start()
            time.sleep(2)
            while not ping_google():
                time.sleep(2)
            println("Google pinged.")
            ip_after = requests.get("https://ipinfo.io/ip").text
            if ping_google():
                if ip_after is not ip_before:
                    println("Successfully disconnected.")
                    print("Successfully disconnected")
                else:
                    println("Error, your IP did not change.")
                    print("Error, your IP did not change.")
            else:
                println("Connection Error")
                print("Connection Error")
            println("Current IP: " + requests.get("https://ipinfo.io/ip").text)

    def ping_google():
        try:
            response = requests.get("https://www.google.de/").status_code
        except Exception as b:
            print(b)
            println("No internet connection!")
            return False
        if response == 200:
            return True
        else:
            return False

    # Start Window
    try:
        with open("profile.ovpn", "r") as file:
            println("Open VPN file detected.")
            print("Open VPN file detected.")
            if ping_google():
                println("Current IP: " + requests.get("https://ipinfo.io/ip").text)
                print("OpenVPyN V.1.9 by Mik Mueller\n"
                      "Visit my Github and contribute at:\n"
                      "https://github.com/MikMuellerDev/")
            else:
                disconnecting()
                print("Connection Error, cannot reach google.de")
                println("Connection Error, cannot reach google.de")
    except Exception as e:
        println(str(e))
        println("Make sure to include your openvpn    profile file in this directory."
                "     /home/$USER/LinuxStuff/OpenVPyN")
        print("Make sure to include your openvpn profile file in this directory:\n/home/$USER/LinuxStuff/OpenVPyN")

    root.mainloop()


window()
disconnecting()
