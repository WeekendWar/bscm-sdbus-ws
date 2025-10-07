#!/bin/bash

# Useful Arguments:
#   "--parallel-workers 20"
#   replace 20 with the # of processors/threads you have available

# Exit immediately if a command exits with a non-zero status
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR=$(realpath $SCRIPT_DIR)

# Use first arg as a passthrough to the colcon command
EXTRA_ARGS=$1
if [ ! -z "${EXTRA_ARGS}" ]; then
  echo Running with extra colcon args:
  echo $EXTRA_ARGS
fi

################################################################################
## Script Setup
################################################################################
PLATFORM_PKGS="\
  bscm-sdbus-cpp \
  claude-sdbus \
  sdbus-c++ \
"

# Point to COLCON_DEFAULTS_FILE if the user has not overridden
# Note: using a default file makes it easier to build
#       individual packages with colcon build --p
if [ -z "${COLCON_DEFAULTS_FILE}" ]; then
  export COLCON_DEFAULTS_FILE=$PROJECT_ROOT_DIR/defaults.yaml
fi

colcon build $EXTRA_ARGS \
  --packages-up-to \
    $PLATFORM_PKGS


# Packages we are skipping for now:
# septentrio_dds_node \