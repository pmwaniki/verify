#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jan  9 16:46:21 2018

@author: pmwaniki
"""

import subprocess 
import json
import pandas as pd

import os

command="R -q --slave --no-init-file -f ./generate-errors.R"


p = subprocess.Popen(str.split(command), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
out, err = p.communicate()

data=json.loads(out)

data=pd.DataFrame(data)
