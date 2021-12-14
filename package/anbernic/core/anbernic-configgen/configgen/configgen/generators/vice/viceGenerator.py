#!/usr/bin/env python
import Command
import anbernicFiles
from generators.Generator import Generator
import viceConfig
import viceControllers
import os.path
import glob


class ViceGenerator(Generator):

    def getResolutionMode(self, config):
        return 'default'
    
    # Main entry of the module
    # Return command
    def generate(self, system, rom, playersControllers, gameResolution):

        if not os.path.exists(os.path.dirname(anbernicFiles.viceConfig)):
            os.makedirs(os.path.dirname(anbernicFiles.viceConfig))

        # configuration file
        viceConfig.setViceConfig(anbernicFiles.viceConfig, system)

        # controller configuration
        viceControllers.generateControllerConfig(anbernicFiles.viceConfig, playersControllers)

        commandArray = [anbernicFiles.anbernicBins[system.config['emulator']] + system.config['core'], "-autostart", rom]

        return Command.Command(array=commandArray, env={"XDG_CONFIG_HOME":anbernicFiles.CONF})
