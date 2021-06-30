#!/usr/bin/env bash
UG_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

export TAB="    " # 4 spaces
: ${VERBOSE:=yes}

BOLD='\033[1m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[32m'
WHITE='\033[34m'
YELLOW='\033[33m'
NO_COLOR='\033[0m'

function info() {
  (echo >&2 -e "[${WHITE}${BOLD}INFO${NO_COLOR}] $*")
}

function error() {
  (echo >&2 -e "[${RED}ERROR${NO_COLOR}] $*")
}

function warning() {
  (echo >&2 -e "${YELLOW}[WARNING] $*${NO_COLOR}")
}

function ok() {
  (echo >&2 -e "[${GREEN}${BOLD} OK ${NO_COLOR}] $*")
}

function print_delim() {
  echo "=============================================="
}

function get_now() {
  date +%s
}

function time_elapsed_s() {
  local start="${1:-$(get_now)}"
  local end="$(get_now)"
  echo "$end - $start" | bc -l
}

function success() {
  print_delim
  ok "$1"
  print_delim
}

function fail() {
  print_delim
  error "$1"
  print_delim
  exit 1
}

## Prevent multiple entries of my_bin_path in PATH
function add_to_path() {
  if [ -z "$1" ]; then
    return
  fi
  local my_bin_path="$1"
  if [ -n "${PATH##*${my_bin_path}}" ] && [ -n "${PATH##*${my_bin_path}:*}" ]; then
    export PATH=$PATH:${my_bin_path}
  fi
}

## Prevent multiple entries of my_libdir in LD_LIBRARY_PATH
function add_to_ld_library_path() {
  if [ -z "$1" ]; then
    return
  fi
  local my_libdir="$1"
  local result="${LD_LIBRARY_PATH}"
  if [ -z "${result}" ]; then
    result="${my_libdir}"
  elif [ -n "${result##*${my_libdir}}" ] && [ -n "${result##*${my_libdir}:*}" ]; then
    result="${result}:${my_libdir}"
  fi
  export LD_LIBRARY_PATH="${result}"
}

#commit_id=$(git log -1 --pretty=%H)
function git_sha1() {
  if [ -x "$(which git 2>/dev/null)" ] &&
    [ -d "${UG_ROOT_DIR}/.git" ]; then
    git rev-parse --short HEAD 2>/dev/null || true
  fi
}

function git_date() {
  if [ -x "$(which git 2>/dev/null)" ] &&
    [ -d "${UG_ROOT_DIR}/.git" ]; then
    git log -1 --pretty=%ai | cut -d " " -f 1 || true
  fi
}

function git_branch() {
  if [ -x "$(which git 2>/dev/null)" ] &&
    [ -d "${UG_ROOT_DIR}/.git" ]; then
    git rev-parse --abbrev-ref HEAD
  else
    echo "@non-git"
  fi
}