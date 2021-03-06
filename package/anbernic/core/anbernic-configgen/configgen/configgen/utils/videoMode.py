#!/usr/bin/env python
import os
import sys
import anbernicFiles
import re
import time
import subprocess
import json
from logger import eslog

# Set a specific video mode
def changeMode(videomode):
    if checkModeExists(videomode):
        cmd = "anbernic-resolution setMode \"{}\"".format(videomode)
        if cmd is not None:
            eslog.log("setVideoMode({}): {} ".format(videomode, cmd))
            os.system(cmd)

def getCurrentMode():
	proc = subprocess.Popen(["anbernic-resolution currentMode"], stdout=subprocess.PIPE, shell=True)
	(out, err) = proc.communicate()
        for val in out.splitlines():
            return val # return the first line

def minTomaxResolution():
	proc = subprocess.Popen(["anbernic-resolution minTomaxResolution"], stdout=subprocess.PIPE, shell=True)
	(out, err) = proc.communicate()

def getCurrentResolution():
	proc = subprocess.Popen(["anbernic-resolution currentResolution"], stdout=subprocess.PIPE, shell=True)
	(out, err) = proc.communicate()
        vals = out.split("x")
        return { "width": int(vals[0]), "height": int(vals[1]) }

def checkModeExists(videomode):
	proc = subprocess.Popen(["anbernic-resolution listModes"], stdout=subprocess.PIPE, shell=True)
	(out, err) = proc.communicate()
        for valmod in out.splitlines():
            vals = valmod.split(":")
            if(videomode == vals[0]):
                return True
        eslog.error("invalid video mode {}".format(videomode))
        return False
