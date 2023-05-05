#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    read -p "Docker is not installed or running. Do you want to install it? [y/N]: " confirm
    if [[ $confirm =~ ^[nN](o)*$ ]]; then
        echo "Before using this script you must install Docker."
        exit 1
    fi

    # Check user's operating system and provide appropriate installation instructions
    if [[ "$(uname)" == "Darwin" ]]; then
        # Install Docker for MacOS
        echo "Please install Docker for MacOS by downloading and running the Docker for Mac installer:"
        echo "https://docs.docker.com/docker-for-mac/install/"
    elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
        # Install Docker for Linux
        echo "Please install Docker for Linux by following the instructions for your distribution:"
        echo "https://docs.docker.com/engine/install/"
    elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" || "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]]; then
        # Install Docker for Windows using Chocolatey
        echo "Please install Chocolatey by following the instructions on the official website:"
        echo "https://chocolatey.org/install"
        read -p "Once Chocolatey is installed, run 'choco install docker-desktop' to install Docker for Windows. Press enter to continue."
        choco install docker-desktop
    else
        echo "Unsupported operating system. Please install Docker manually."
        exit 1
    fi
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    read -p "Docker Compose is not installed. Do you want to install it? [y/N]: " confirm
    if [[ $confirm =~ ^[nN](o)*$ ]]; then
        echo "Before using this script you must install Docker Compose."
        exit 1
    fi

    # Check user's operating system and provide appropriate installation instructions
    if [[ "$(uname)" == "Darwin" ]]; then
        # Install Docker Compose for MacOS
        echo "Please install Docker Compose for MacOS by running the following command:"
        echo "brew install docker-compose"
    elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
        # Install Docker Compose for Linux
        echo "Please install Docker Compose for Linux by following the instructions on the official website:"
        echo "https://docs.docker.com/compose/install/"
    elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" || "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]]; then
        # Install Docker Compose for Windows using Chocolatey
        echo "Please install Docker Compose for Windows using Chocolatey by running the following command:"
        echo "choco install docker-compose"
    else
        echo "Unsupported operating system. Please install Docker Compose manually."
        exit 1
    fi
fi

# If both Docker and Docker Compose are installed, continue with the rest of the script
echo "Docker and Docker Compose are installed."
