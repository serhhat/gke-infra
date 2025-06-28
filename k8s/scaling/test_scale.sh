#!/bin/bash

hey -z 60s -c 100 https://api.serhatsari.dev/api & 

hey -z 60s -c 100 https://frontend.serhatsari.dev & 
