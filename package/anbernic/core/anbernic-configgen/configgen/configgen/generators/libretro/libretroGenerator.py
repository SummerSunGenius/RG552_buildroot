#!/usr/bin/env python
import Command
import libretroControllers
import anbernicFiles
import libretroConfig
import libretroRetroarchCustom
import shutil
from generators.Generator import Generator
import os.path
from settings.unixSettings import UnixSettings
from utils.logger import eslog

class LibretroGenerator(Generator):

    # Main entry of the module
    # Configure retroarch and return a command
    def generate(self, system, rom, playersControllers, gameResolution):
        # Settings anbernic default config file if no user defined one
        if not 'configfile' in system.config:
            # Using anbernic config file
            system.config['configfile'] = anbernicFiles.retroarchCustom
            # Create retroarchcustom.cfg if does not exists
            if not os.path.isfile(anbernicFiles.retroarchCustom):
                libretroRetroarchCustom.generateRetroarchCustom()
            #  Write controllers configuration files
            retroconfig = UnixSettings(anbernicFiles.retroarchCustom, separator=' ')
            libretroControllers.writeControllersConfig(retroconfig, system, playersControllers)
            # force pathes
            libretroRetroarchCustom.generateRetroarchCustomPathes(retroconfig)
            # Write configuration to retroarchcustom.cfg
            if 'bezel' not in system.config or system.config['bezel'] == '':
                bezel = None
            else:
                bezel = system.config['bezel']
            # some systems (ie gw) won't bezels
            if system.isOptSet('forceNoBezel') and system.getOptBoolean('forceNoBezel'):
                bezel = None

            libretroConfig.writeLibretroConfig(retroconfig, system, playersControllers, rom, bezel, gameResolution)
            retroconfig.write()

        # Retroarch core on the filesystem
        retroarchCore = anbernicFiles.retroarchCores + system.config['core'] + anbernicFiles.libretroExt
        romName = os.path.basename(rom)

        # the command to run
        # For the NeoGeo CD (lr-fbneo) it is necessary to add the parameter: --subsystem neocd
        if system.name == 'neogeocd' and system.config['core'] == "fbneo":
            commandArray = [anbernicFiles.anbernicBins[system.config['emulator']], "-L", retroarchCore, "--subsystem", "neocd", "--config", system.config['configfile']]
        elif system.name == 'dos':
            commandArray = [anbernicFiles.anbernicBins[system.config['emulator']], "-L", retroarchCore, "--config", system.config['configfile'], rom + "/dosbox.bat"]
        else:
            commandArray = [anbernicFiles.anbernicBins[system.config['emulator']], "-L", retroarchCore, "--config", system.config['configfile']]

        configToAppend = []

        # Custom configs - per core
        customCfg = "{}/{}.cfg".format(anbernicFiles.retroarchRoot, system.name)
        if os.path.isfile(customCfg):
            configToAppend.append(customCfg)

        # Custom configs - per game
        customGameCfg = "{}/{}/{}.cfg".format(anbernicFiles.retroarchRoot, system.name, romName)
        if os.path.isfile(customGameCfg):
            configToAppend.append(customGameCfg)

        # Overlay management
        overlayFile = "{}/{}/{}.cfg".format(anbernicFiles.OVERLAYS, system.name, romName)
        if os.path.isfile(overlayFile):
            configToAppend.append(overlayFile)

        # RetroArch 1.7.8 (Anbernic 5.24) now requires the shaders to be passed as command line argument
        renderConfig = system.renderconfig
        if 'shader' in renderConfig and renderConfig['shader'] != None:
            shaderFilename = renderConfig['shader'] + ".glslp"
            eslog.log("searching shader {}".format(shaderFilename))
            if os.path.exists("/userdata/shaders/" + shaderFilename):
                video_shader_dir = "/userdata/shaders"
                eslog.log("shader {} found in /userdata/shaders".format(shaderFilename))
            else:
                video_shader_dir = "/usr/share/anbernic/shaders"
            video_shader = video_shader_dir + "/" + shaderFilename
            commandArray.extend(["--set-shader", video_shader])

        # Generate the append
        if configToAppend:
            commandArray.extend(["--appendconfig", "|".join(configToAppend)])

         # Netplay mode
        if 'netplay.mode' in system.config:
            if system.config['netplay.mode'] == 'host':
                commandArray.append("--host")
            elif system.config['netplay.mode'] == 'client' or system.config['netplay.mode'] == 'spectator':
                commandArray.extend(["--connect", system.config['netplay.server.ip']])
            if 'netplay.server.port' in system.config:
                commandArray.extend(["--port", system.config['netplay.server.port']])
            if 'netplay.nickname' in system.config:
                commandArray.extend(["--nick", system.config['netplay.nickname']])

        # Verbose logs
        commandArray.extend(['--verbose'])

        # Extension used by hypseus .daphne but lr-daphne starts with .zip
        if system.name == 'daphne':
            romName = os.path.splitext(os.path.basename(rom))[0]
            rom = anbernicFiles.daphneDatadir + '/roms/' + romName +'.zip'
        
        if system.name == 'dos':
            rom = 'set ROOT=' + rom

        if system.name == 'scummvm':
            rom = os.path.dirname(rom) + '/' + romName[1:-8]
        
        commandArray.append(rom)
        return Command.Command(array=commandArray)
