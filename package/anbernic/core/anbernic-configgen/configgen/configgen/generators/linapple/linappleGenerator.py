#!/usr/bin/env python
# -*- coding: utf-8 -*-

import Command
import anbernicFiles
import shutil
import os.path
import linappleConfig
import ConfigParser
from shutil import copyfile
from os.path import dirname
from os.path import isdir
from os.path import isfile
from generators.Generator import Generator


class LinappleGenerator(Generator):

    def generate(self, system, rom, playersControllers, gameResolution):
        
        # Master.dsk
        if not isfile(anbernicFiles.linappleMasterDSKFile):
            if not isdir(dirname(anbernicFiles.linappleConfigFile)):
                os.mkdir(dirname(anbernicFiles.linappleConfigFile))
            copyfile(anbernicFiles.linappleMasterDSK, anbernicFiles.linappleMasterDSKFile)

        # Configuration
        linappleConfig.generateLinappleConfig(rom, playersControllers, gameResolution)

        commandArray = [ anbernicFiles.anbernicBins[system.config['emulator']], "-f", "--autoboot" ]

        return Command.Command(array=commandArray)