#! /usr/bin/env bash
TOP_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd -P)"
source ${TOP_DIR}/scripts/ug.bashrc

export APOLLO_BAZEL_DIST_DIR="${APOLLO_CACHE_DIR}/distdir"
export CYBER_PATH="${UG_ROOT_DIR}/cyber"

bin_path="${UG_ROOT_DIR}/bin"

add_to_path "${bin_path}"

# TODO(all): place all these in one place and add_to_path
# for entry in "${bin_path}" \
#     "${recorder_path}" "${monitor_path}"  \
#     "${channel_path}" "${node_path}" \
#     "${service_path}" \
#     "${launch_path}" \
#     "${visualizer_path}" \
#     "${rosbag_to_record_path}" ; do
#     add_to_path "${entry}"
# done

# ${CYBER_PATH}/python
# export PYTHONPATH=${bin_path}/cyber/python/internal:${PYTHONPATH}

export CYBER_DOMAIN_ID=80
export CYBER_IP=127.0.0.1

export GLOG_log_dir="${UG_ROOT_DIR}/data/log"
export GLOG_alsologtostderr=0
export GLOG_colorlogtostderr=1
export GLOG_minloglevel=0

export sysmo_start=0

# for DEBUG log
#export GLOG_minloglevel=-1
#export GLOG_v=4

source ${CYBER_PATH}/tools/cyber_tools_auto_complete.bash
