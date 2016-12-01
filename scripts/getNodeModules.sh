#!/usr/bin/env bash

echo `find . -name package.json -printf '%h\n'`