#!/bin/bash
cd `dirname $0`

docker build --secret id=credentials,src=./.credentials -t cs2-sniper:latest .
