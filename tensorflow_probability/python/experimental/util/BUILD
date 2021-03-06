# Copyright 2020 The TensorFlow Probability Authors.
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
# Description:
#   TensorFlow Probability experimental utility functions.

load(
    "//tensorflow_probability/python:build_defs.bzl",
    "multi_substrate_py_library",
)

package(
    default_visibility = [
        "//tensorflow_probability:__subpackages__",
    ],
)

licenses(["notice"])

exports_files(["LICENSE"])

multi_substrate_py_library(
    name = "util",
    srcs = ["__init__.py"],
    srcs_version = "PY2AND3",
    substrates_omit_deps = [
        ":deferred_module",
    ],
    deps = [
        ":deferred_module",
    ],
)

py_library(
    name = "deferred_module",
    srcs = ["deferred_module.py"],
    srcs_version = "PY2AND3",
    deps = [
        # numpy dep,
        # tensorflow dep,
        "//tensorflow_probability/python/experimental/lazybones/utils:special_methods",
        "//tensorflow_probability/python/internal:nest_util",
    ],
)

py_test(
    name = "deferred_module_test",
    size = "small",
    srcs = ["deferred_module_test.py"],
    python_version = "PY3",
    deps = [
        ":deferred_module",
        # absl/testing:parameterized dep,
        # numpy dep,
        # tensorflow dep,
        "//tensorflow_probability",
        "//tensorflow_probability/python/internal:test_util",
        # tensorflow/compiler/jit dep,
    ],
)
