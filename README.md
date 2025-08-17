# 115-client-docker
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/lampoboba/115docker?sort=date)

Docker wrapper for 115 cloud storage Linux client with web interface. Based on [docker-baseimage-gui]("https://github.com/jlesage/docker-baseimage-gui")

115 网盘 Linux 版本的 Docker 封装。

## Overview

This Docker image provides a containerized version of the [115 Netdisk Linux client]("https://115.com/"), enabling you to access and manage your 115 cloud storage directly through a web browser. Perfect for headless servers, NAS systems, and remote environments where you need reliable access to your 115 Netdisk files without local GUI dependencies.

## Current Version

- Currently supports `v35.30.0` 115 Linux desktop client.
- Note: Previous versions are not tested.

## Features

- Web-Based Access: Use the 115 desktop client through any modern web browser
- Zero Dependencies: No need to install any desktop environment or GUI libraries on your host
- NAS Integration: Seamlessly works with TrueNAS Scale, Synology, QNAP, and other NAS platforms. Tested on TrueNAS Scale `v25.04`.
- Direct Downloads: Configure download paths to match your SMB/NFS shares for easy file management
- Cross-Platform: Runs on any Docker-compatible system (Linux, Windows, macOS)
- Headless Server Ready: Perfect for VPS, cloud servers, and remote systems

## Quick Start

### Pull the image

```shell
docker pull lampoboba/115docker
```

### Create and run container

```shell
docker create   --name=115docker                \
                -p 5800:5800                    \
                -p 5900:5900                    \
                -v <YOURCONFIGDIR>:/config      \
                -v <YOURDOWNLOADDIR>:/Downloads \
                --restart always                \
                lampoboba/115docker:latest
```

```shell
# start container
docker start 115docker
# stop container
docker stop 115docker
```

Note: The ports 5800 and 5900 are just examples. You can map these container ports to any available ports on your host system. For example:

- `-p 8080:5800` to access the web interface on port 8080
- `-p 6900:5900` to access VNC on port 6900

## Configuration

For a complete list of available environment variables and advanced configurations, please refer to the [docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui?tab=readme-ov-file#public-environment-variables) documentation.

## Usage

1. Access the Web Interface:

   - Open your browser and navigate to http://your-server-ip:5800 (or your chosen port)
   - The 115 client interface will load in your browser

2. Login to 115:

   - Use your 115 account credentials to log in
   - 115 login credentials are NOT retained between docker restarts

3. Configure Downloads path:
   - Set your preferred download location in the 115 client settings before downloading any files

## Known issues

1. 115 login credentials are NOT retained between docker restarts
2. Download path needs to be manually configured in the interface:
   - Go to Settings page
   - Click "Modify" in download path setting
   - A popup window will show to select the download folder
   - Click "+ Other Locations", then click "Computer"
   - Choose "/Download" folder from the root which is the mounted download directory from host.
