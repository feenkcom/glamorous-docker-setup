#!/usr/bin/env bash

function help() {
  echo "Use ${0##*/} [version]"
  echo ""
  echo "Download GToolkit of a given version to the target directory."
  echo ""
  echo "Parameters:"
  echo "  version:          Glamorous Toolkit version to be downloaded."
  echo "                    It can also be set using GT_DOWNLOAD_VERSION environment variable."
  echo "                    The value is mandatory. Example: v0.8.2774."
}

# Define Glamorous Toolkit version
if [ -n "$1" ]; then
  GT_DOWNLOAD_VERSION="${1}"
fi
if [ -z "$GT_DOWNLOAD_VERSION" ] ; then
  echo "ERROR: Glamorous Toolkit version must be defined." >&2
  help >&2
  exit 1
fi
echo "Glamorous Toolkit version: ${GT_DOWNLOAD_VERSION}."

# Define target directory
GT_DOWNLOAD_TARGET_DIR="$PWD"
echo "Target directory: $GT_DOWNLOAD_TARGET_DIR."

# Check dependencies: cURL, unzip
if ! command -v curl unzip &> /dev/null ; then
  echo "ERROR: curl and unzip commands are required." >&2
  echo "  Available commands:" >&2
  command -v curl unzip >&2
  exit 3
fi
echo "Dependencies are available: curl, unzip."

# Check nonexistent or empty target directory
echo -n "Checking nonexistent or empty target directory ${GT_DOWNLOAD_TARGET_DIR}: "
if [ -d "${GT_DOWNLOAD_TARGET_DIR}" ] ; then
  if find "${GT_DOWNLOAD_TARGET_DIR}" -maxdepth 0 -empty | read v ; then
    # the directory exists and is empty
    echo "directory exists and is empty, which is permitted."
  else
    # the directory exists and is not empty
    echo "directory exists and is not empty, error."
    echo "ERROR: The ${GT_DOWNLOAD_TARGET_DIR} directory already exists and is not empty." >&2
    echo "  Content:" >&2
    ls -lah ${GT_DOWNLOAD_TARGET_DIR} >&2
    exit 4
  fi
else
  echo "done."
fi

# Define machine type
#  x86_64 on intel linux
#  aarch64 on ARM64 linux
#  arm64 on ARM64 macOS
#  x86_64 on intel macOS
GT_MACHINE="$(uname -m)"
if [ "$GT_MACHINE" = "arm64" ] ; then
  GT_MACHINE="aarch64"
fi

# Define OS
GT_OS="$(uname -s)"
if [ "$GT_OS" = "Darwin" ] ; then
  GT_OS="MacOS"
fi

# Examples of download links for a specific version
# https://github.com/feenkcom/gtoolkit/releases/download/v0.8.2771/GlamorousToolkit-Linux-aarch64-v0.8.2771.zip
# https://github.com/feenkcom/gtoolkit/releases/download/v0.8.2771/GlamorousToolkit-Linux-x86_64-v0.8.2771.zip
# https://github.com/feenkcom/gtoolkit/releases/download/v0.8.2771/GlamorousToolkit-MacOS-aarch64-v0.8.2771.zip
# https://github.com/feenkcom/gtoolkit/releases/download/v0.8.2771/GlamorousToolkit-MacOS-x86_64-v0.8.2771.zip

GT_FILE_NAME="GlamorousToolkit-${GT_OS}-${GT_MACHINE}-${GT_DOWNLOAD_VERSION}.zip"
GT_DOWNLOAD_LINK="https://github.com/feenkcom/gtoolkit/releases/download/${GT_DOWNLOAD_VERSION}/${GT_FILE_NAME}"

# Jump into a working directory
GT_WORKING_DIRECTORY="${GT_DOWNLOAD_TARGET_DIR}"
echo -n "Set working directory to ${GT_WORKING_DIRECTORY}: "
mkdir -p "${GT_WORKING_DIRECTORY}" || exit 5
cd "${GT_WORKING_DIRECTORY}" || exit 6
echo "done."

# Remove existing files
echo -n "Clean working directory ${GT_WORKING_DIRECTORY}: "
rm -rf -- *
echo "done."

# Download and extract Glamorous Toolkit
echo -n "Downloading ${GT_DOWNLOAD_LINK}: "
curl --fail --no-progress-meter --max-time 60 -o "/tmp/$GT_FILE_NAME" -L "$GT_DOWNLOAD_LINK" || exit 6
echo "done."
echo -n "Extracting $GT_FILE_NAME: "
unzip -q "/tmp/$GT_FILE_NAME" -d ${GT_WORKING_DIRECTORY} || exit 7
echo "done."

# Define VM executable file
if [ "$GT_OS" = "MacOS" ] ; then
  GT_VM_FILE="GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit-cli"
fi

if [ "$GT_OS" = "Linux" ] ; then
  GT_VM_FILE="bin/GlamorousToolkit-cli"
fi

if [ -z "$GT_VM_FILE" ] ; then
  echo "ERROR: Cannot define GlamorousToolkit VM executable file for ${GT_OS}." >&2
  exit 5
fi

if [ ! -f "$GT_VM_FILE" ] ; then
  echo "ERROR: GlamorousToolkit VM executable file does not exist: ${GT_VM_FILE}" >&2
  ls -R
  exit 6
fi
echo "VM executable file: ${GT_VM_FILE}."

# Define Image file
GT_IMAGE_FILE="GlamorousToolkit.image"
if [ ! -f "$GT_IMAGE_FILE" ] ; then
  echo "ERROR: GlamorousToolkit image file does not exist: ${GT_IMAGE_FILE}" >&2
  ls
  exit 7
fi
echo "VM image file: ${GT_IMAGE_FILE}."

# List files
echo "GToolkit files in ${GT_WORKING_DIRECTORY}:"
ls "${GT_WORKING_DIRECTORY}"
