#!/usr/bin/env python
import Command
import mupenConfig
import mupenControllers
import anbernicFiles
from generators.Generator import Generator
import ConfigParser
import os

class MupenGenerator(Generator):

    def generate(self, system, rom, playersControllers, gameResolution):

        # read the configuration file
        iniConfig = ConfigParser.ConfigParser()
        # To prevent ConfigParser from converting to lower case
        iniConfig.optionxform = str
        if os.path.exists(anbernicFiles.mupenCustom):
            iniConfig.read(anbernicFiles.mupenCustom)

        mupenConfig.setMupenConfig(iniConfig, system, playersControllers, gameResolution)
        mupenControllers.setControllersConfig(iniConfig, playersControllers, system.config)

        # save the ini file
        if not os.path.exists(os.path.dirname(anbernicFiles.mupenCustom)):
            os.makedirs(os.path.dirname(anbernicFiles.mupenCustom))
        with open(anbernicFiles.mupenCustom, 'w') as configfile:
            iniConfig.write(configfile)

        # command
        commandArray = [anbernicFiles.anbernicBins[system.config['emulator']], "--corelib", "/usr/lib/libmupen64plus.so.2.0.0", "--gfx", "/usr/lib/mupen64plus/mupen64plus-video-{}.so".format(system.config['core']), "--configdir", anbernicFiles.mupenConf, "--datadir", anbernicFiles.mupenConf]
        commandArray.append(rom)

        return Command.Command(array=commandArray)
