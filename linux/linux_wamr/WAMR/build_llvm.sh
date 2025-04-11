#!/bin/sh

# Copyright (C) 2020 Intel Corporation. All rights reserved.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

cd wasm-micro-runtime/build-scripts/

/usr/bin/env python3 -m pip install --user -r requirements.txt
/usr/bin/env python3 build_llvm.py "$@"
