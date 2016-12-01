#!/usr/bin/env bash

($(find . -name package.json -printf '%h\n'))