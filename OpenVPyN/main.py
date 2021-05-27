import tkinter as tk
from tkinter import *
from tkinter import ttk
import os
import threading
import requests
import time
from SECRETS import sudo_passwd

active = False


def disconnection():
    os.system("echo " + sudo_passwd + " | sudo -S pkill openvpn")


def connection():
    os.system("echo " + sudo_passwd + " | sudo -S openvpn --config profile.ovpn")


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
    padx = 15
    pady = 10
    outputtext = Text(frame, bg="#424242", width=37, height=10)
    outputtext.grid(column=1, row=3, padx=1, pady=1)

    pmt = ttk.Button(frame, text="Connect", command=lambda: threading.Thread(target=connect).start())
    pmt.grid(column=1, row=1, padx=padx, pady=pady)

    prt = ttk.Button(frame, text="Disconnect", command=lambda: threading.Thread(target=disconnect).start())
    prt.grid(column=1, row=2, padx=padx, pady=pady)

    def println(input_):
        outputtext.delete(1.0, 'end-1c')
        outputtext.insert(index=1.0, chars=input_)

    def connect():
        if ping_google():
            ip_before = requests.get("https://ipinfo.io/ip").text
            println("Connecting...")
            threading.Thread(target=connection).start()
            time.sleep(1)
            while not ping_google():
                time.sleep(1)
            ip_after = requests.get("https://ipinfo.io/ip").text
            if ping_google():
                if ip_after is not ip_before:
                    println("Successfully connected.")
                else:
                    println("Error, your IP did not change.")
            else:
                println("Connection Error.")
            println("Current IP: " + requests.get("https://ipinfo.io/ip").text)

    def disconnect():
        if ping_google():
            ip_before = requests.get("https://ipinfo.io/ip").text
            println("Disconnecting...")
            for j in range(2):
                threading.Thread(target=disconnection).start()
            time.sleep(1)
            while not ping_google():
                time.sleep(1)
            ip_after = requests.get("https://ipinfo.io/ip").text
            if ping_google():
                if ip_after is not ip_before:
                    println("Successfully disconnected.")
                else:
                    println("Error, your IP did not change.")
            else:
                println("Connection Error")
            println("Current IP: " + requests.get("https://ipinfo.io/ip").text)

    def ping_google():
        try:
            response = requests.get("https://www.google.de/").status_code
        except Exception as e:
            print(e)
            println("No internet connection!")
            return False
        if response == 200:
            return True
        else:
            return False

    # Start Window

    if ping_google():
        println("Current IP: " + requests.get("https://ipinfo.io/ip").text)
    else:
        disconnection()

    root.mainloop()


window()
for i in range(2):
    disconnection()
time.sleep(1)
