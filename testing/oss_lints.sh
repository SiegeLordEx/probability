#!/usr/bin/env bash
# Copyright 2018 The TensorFlow Probability Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================

set -v  # print commands as they're executed
set -e  # fail and exit on any command erroring

# Make sure the environment variables are set.
if [ -z "${SHARD}" ]; then
  echo "SHARD is unset."
  exit -1
fi

if [[ ${SHARD} != 0 ]]; then
  exit 0
fi

get_changed_py_files() {
  # grep --quiet forces exit status 0 even if no matches are found
  git diff \
      --name-only \
      --diff-filter=AM ${TRAVIS_BRANCH}...HEAD \
    | grep --quiet '^tensorflow_probability.*\.py$'
}

# Run lints on added/changed python files.
changed_py_files=$(get_changed_py_files)
if [[ -n "${changed_py_files}" ]]; then
  echo "Running pylint on ${changed_py_files}"
  pylint -j2 --rcfile=testing/pylintrc ${changed_py_files})
else
  echo "No files to lint."
fi
