#!/bin/bash

##
## Use this scirpt to build flutter project
##

# provive device name if you have multiple interface/device
BUILD='debug'
PORT='8000'
INFACE='' # optional
FLUTTER='run' # flutter build options

# bash source(file) directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )/"
DEV_PACK_DIR="${DIR}"
DIR_CONF="${DEV_PACK_DIR}lib/config/"
CONF_FILE='build_conf.dart'
DIR_CONF_FILE="${DIR_CONF}$CONF_FILE"

IP=$(ip addr show $INFACE | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')

# TODO: -h|--help
if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "TODO: -h|--help"
    exit
fi

# option
for i in "$@"
do
case $1 in
    -b=*|--build=*)
    BUILD="${i#*=}"
    shift
    ;;
    -p=*|--port=*)
    PORT="${i#*=}"
    shift
    ;;
    -i=*|--ip=*)
    IP="${i#*=}"
    shift
    ;;
    -f=*|--flutter=*)
    FLUTTER="${i#*=}"
    shift
    ;;
    *)
    echo 'Invalid option'
    ;;
esac
done

# platform
unameOut="$(uname -s)"
case $unameOut in
    Linux*)     PLATFORM=Linux;;
    Darwin*)    PLATFORM=Mac;;
    CYGWIN*)    PLATFORM=Cygwin;;
    MINGW*)     PLATFORM=MinGw;;
    *)          PLATFORM="UNKNOWN:${unameOut}";;
esac

# check build BUILD
if [[ $BUILD == "release" ]]; then
	IP=''
fi

# code
BUILD_TYPE="const String BUILD_TYPE = '$BUILD';"
DEBUG_IP="const String DEBUG_IP = '$IP:$PORT';"

# check if directory exists
if [ ! -d $DIR_CONF ]; then
	mkdir $DIR_CONF
fi

printf "$BUILD_TYPE\n$DEBUG_IP" > $DIR_CONF_FILE

# flutter
flutter $FLUTTER