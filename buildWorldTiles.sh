#!/bin/bash
set -e;
dir="$(pwd)/";
docker run -t -i -v "$dir:/maps" ubuntu /maps/run.sh