#!/usr/bin/env python

import sys
import os
import io
import anbernicFiles
import settings
from Emulator import Emulator
import ConfigParser

def writePPSSPPConfig(system):
    iniConfig = ConfigParser.ConfigParser()
    # To prevent ConfigParser from converting to lower case
    iniConfig.optionxform = str
    if os.path.exists(anbernicFiles.ppssppConfig):
        try:
            with io.open(anbernicFiles.ppssppConfig, 'r', encoding='utf_8_sig') as fp:
                iniConfig.readfp(fp)
        except:
            pass

    createPPSSPPConfig(iniConfig, system)
    # save the ini file
    if not os.path.exists(os.path.dirname(anbernicFiles.ppssppConfig)):
        os.makedirs(os.path.dirname(anbernicFiles.ppssppConfig))
    with open(anbernicFiles.ppssppConfig, 'w') as configfile:
        iniConfig.write(configfile)

def createPPSSPPConfig(iniConfig, system):
    if not iniConfig.has_section("Graphics"):
        iniConfig.add_section("Graphics")
    if not iniConfig.has_section("General"):
        iniConfig.add_section("General")

    # Display FPS
#    if system.isOptSet('showFPS') and system.getOptBoolean('showFPS') == True:
#        iniConfig.set("Graphics", "ShowFPSCounter", "3") # 1 for Speed%, 2 for FPS, 3 for both
#    else:
#        iniConfig.set("Graphics", "ShowFPSCounter", "0")

    # Performances
#    if system.isOptSet('frameskip') and system.getOptBoolean('frameskip') == True:
#        iniConfig.set("Graphics", "FrameSkip",  "1")
#    else:
#        iniConfig.set("Graphics", "FrameSkip", "0")

    if system.isOptSet('frameskiptype'):
        iniConfig.set("Graphics", "FrameSkipType", system.config["frameskiptype"])
    else:
        iniConfig.set("Graphics", "FrameSkipType",  "0")

#    if system.isOptSet('internalresolution'):
#        iniConfig.set("Graphics", "InternalResolution", system.config["internalresolution"])
#    else:
#        iniConfig.set("Graphics", "InternalResolution", "1")

#    if system.isOptSet('InflightFrames'):
#        iniConfig.set("Graphics", "InflightFrames", system.config["InflightFrames"])
#    else:
#        iniConfig.set("Graphics", "InflightFrames", "1")

    if system.isOptSet('TextureBackoffCache') and system.getOptBoolean('TextureBackoffCache') == True:
        iniConfig.set("Graphics", "TextureBackoffCache",  "True")
    else:
        iniConfig.set("Graphics", "TextureBackoffCache", "False")

    # rewinding
    if system.isOptSet('rewind') and system.getOptBoolean('rewind') == True:
        iniConfig.set("General", "RewindFlipFrequency", "300") # 300 = every 5 seconds
    else:
        iniConfig.set("General", "RewindFlipFrequency",  "0")

    # custom : allow the user to configure directly mupen64plus.cfg via anbernic.conf via lines like : n64.mupen64plus.section.option=value
    for user_config in system.config:
        if user_config[:7] == "ppsspp.":
            section_option = user_config[7:]
            section_option_splitter = section_option.find(".")
            custom_section = section_option[:section_option_splitter]
            custom_option = section_option[section_option_splitter+1:]
            if not iniConfig.has_section(custom_section):
                iniConfig.add_section(custom_section)
            iniConfig.set(custom_section, custom_option, system.config[user_config])
