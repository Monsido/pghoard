#!/bin/env bash

export DEB_BUILD_OPTIONS=nocheck

pip install -r requirements.txt
pip install -r requirements.dev.txt

make deb

cp -f ../*.deb /out/
