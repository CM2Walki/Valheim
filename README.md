[![](https://img.shields.io/codacy/grade/e201fa6b35074864b200eaf558563a22.svg)](https://hub.docker.com/r/cm2network/valheim/) [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/cm2network/valheim)](https://hub.docker.com/r/cm2network/valheim/) [![Docker Stars](https://img.shields.io/docker/stars/cm2network/valheim.svg)](https://hub.docker.com/r/cm2network/valheim/) [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/csgo.valheim)](https://hub.docker.com/r/cm2network/valheim/) [![](https://img.shields.io/docker/image-size/cm2network/valheim)](https://img.shields.io/docker/image-size/cm2network/valheim) [![Discord](https://img.shields.io/discord/747067734029893653)](https://discord.gg/7ntmAwM)
# Supported tags and respective `Dockerfile` links
-	[`latest` (*buster/Dockerfile*)](https://github.com/CM2Walki/CSGO/blob/master/buster/Dockerfile)
-	[`metamod` (*buster-metamod/Dockerfile*)](https://github.com/CM2Walki/CSGO/blob/master/buster-metamod/Dockerfile)
-	[`sourcemod` (*buster-sourcemod/Dockerfile*)](https://github.com/CM2Walki/CSGO/blob/master/buster-sourcemod/Dockerfile)

# What is Valheim?
A brutal exploration and survival game for 1-10 players, set in a procedurally-generated purgatory inspired by viking culture. Battle, build, and conquer your way to a saga worthy of Odin’s patronage!

>  [Valheim](https://store.steampowered.com/app/892970/Valheim/)

<img src="https://static.wikia.nocookie.net/valheim/images/4/4c/Logo_valheim.png" alt="logo" width="300"/></img>

# How to use this image
## Hosting a simple game server

Running on the *host* interface (recommended):<br/>
```console
$ docker run -d --net=host --name=valheim-dedicated cm2network/valheim
```

Running using a bind mount for data persistence on container recreation:
```console
$ mkdir -p $(pwd)/valheim-data
$ chmod 777 $(pwd)/valheim-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host -v $(pwd)/valheim-data:/home/steam/valheim-dedicated/ --name=valheim-dedicated cm2network/valheim
```

Running multiple instances (increment X and Y):
```console
$ docker run -d --net=host --name=valheim-dedicated2 cm2network/valheim
```

**It's also recommended to use "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile

ADDITIONAL_ARGS="" (Pass additional arguments to the server. Make sure to escape correctly!)
```

If you want to learn more about configuring a Valheim server check this [documentation](https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers#Advanced_Configuration).

# Image Variants:
The `valheim` images come in three flavors, each designed for a specific use case.

## `valheim:latest`
This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is a bare-minimum Valheim dedicated server containing no 3rd party plugins.<br/>
