#!/usr/bin/env bash

dirs=`find . -name Dockerfile -printf '%h\n'`

for dir in $dirs; do
    image_name=$dir
    echo "Image $image_name needs to be built from $dir"
    # docker build -t ibillboard/$image_name /vagrant/images/applications/$dir
done