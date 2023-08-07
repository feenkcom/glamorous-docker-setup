#!/usr/bin/env bash

function help() {
  echo "Use ${0##*/} [context name]"
  echo ""
  echo "Build and push a new Docker image with GToolkit of a given version."
  echo ""
  echo "Parameters:"
  echo "  version:          Glamorous Toolkit version to be used for an HTML export."
  echo "                    It can also be set using GT_PUSH_VERSION environment variable."
  echo "                    The value is mandatory. Example: v0.8.2774."
  echo "  set as latest:    Set a given export as latest."
  echo "                    Tag the build as a latest version."
  echo "                    It can also be set using GT_PUSH_AS_LATEST."
  echo "                    The value is mandatory and can have 'update-latest' or 'no-latest' values."
  echo "  context name:     Use a given Docker context (or default)."
}

if [ "$1" = "--help" ] || [ "$1" = "-h" ] ; then
  help
  exit 0
fi

DOCKER_HUB_REPOSITORY="feenkcom/gtoolkit"

# Define Glamorous Toolkit version
if [ -n "$1" ]; then
  GT_PUSH_VERSION="${1}"
fi
if [ -z "$GT_PUSH_VERSION" ] ; then
  echo "ERROR: Glamorous Toolkit version must be defined." >&2
  help >&2
  exit 1
fi
echo "Glamorous Toolkit version: $GT_PUSH_VERSION."

# Define SET AS LATEST value
if [ -n "$2" ] ; then
  GT_PUSH_AS_LATEST="${2}"
fi
if [ -z "$GT_PUSH_AS_LATEST" ] ; then
  echo "ERROR: 'set as latest' must be defined." >&2
  help >&2
  exit 2
fi
if [ ! "$GT_PUSH_AS_LATEST" = "update-latest" ] && [ ! "$GT_PUSH_AS_LATEST" = "no-latest" ]  ; then
  echo "ERROR: 'set as latest' must be 'update-latest' or 'no-latest' instead of: ${GT_EXPORT_AS_LATEST}." >&2
  help >&2
  exit 3
fi
echo "Export as latest is: $GT_PUSH_AS_LATEST."
if [ "$GT_PUSH_AS_LATEST" = "update-latest" ] ; then
  GT_DOCKER_TAG_LATEST_ARGS="--tag ${DOCKER_HUB_REPOSITORY}:latest"
  echo "The ${GT_PUSH_VERSION} will be tagged as latest too."
fi

# Jump to the Dockefile directory
cd docker/gtoolkit || exit 5

# Build and push
docker build \
  --build-arg GT_VERSION="${GT_PUSH_VERSION}" \
  --tag ${DOCKER_HUB_REPOSITORY}:"${GT_PUSH_VERSION}" \
  $GT_DOCKER_TAG_LATEST_ARGS \
  --push  .
