#!/bin/bash

df -h --output=avail / | tail -n1 | awk '{print $1}'

