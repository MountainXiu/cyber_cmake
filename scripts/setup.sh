#!/usr/bin/env bash
TOP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
source ${TOP_DIR}/scripts/ug.bashrc

function create_data_dir() {
  local DATA_DIR="${UG_ROOT_DIR}/data"
  mkdir -p "${DATA_DIR}/log"
  mkdir -p "${DATA_DIR}/bag"
  mkdir -p "${DATA_DIR}/core"
}

function set_lib_path() {
  local CYBER_SETUP="${UG_ROOT_DIR}/cyber/setup.bash"
  [ -e "${CYBER_SETUP}" ] && . "${CYBER_SETUP}"
}

set_lib_path
create_data_dir