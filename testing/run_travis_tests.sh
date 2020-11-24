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

# Include seconds since script execution as a prefix for all command echo logs.
PS4='+ $SECONDS s\011 '  # Octal 9, for tab
set -x  # print commands as they are executed
set -e  # fail and exit on any command erroring
set -u  # fail and exit on any undefined variable reference

# Get the absolute path to the directory containing this script.
DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

install_bazel() {
  # Install Bazel for tests. Based on instructions at
  # https://docs.bazel.build/versions/master/install-ubuntu.html#install-on-ubuntu
  # (We skip the openjdk8 install step, since travis lets us have that by
  # default).

  # Add Bazel distribution URI as a package source
  echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" \
    | sudo tee /etc/apt/sources.list.d/bazel.list
  curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -

  # Update apt and install bazel (use -qq to minimize log cruft)
  sudo apt-get update
  sudo apt-get install bazel
}

install_python_packages() {
  ${DIR}/install_test_dependencies.sh
}

# Only install bazel if not already present (useful for locally testing this
# script).
which bazel || install_bazel
install_python_packages

$DIR/run_tfp_test.sh //tensorflow_probability/...
