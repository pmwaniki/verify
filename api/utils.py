
from api.models import Validation
import importlib
from datetime import datetime
import pytz
import subprocess
import pandas as pd
from verify.settings import BASE_DIR
import os

data_path=os.path.join(BASE_DIR,'api/tmp')
# script_path=os.path.join(BASE_DIR,'../R-gen-errors/00-main.R')


def genIssues(rScript, outCsv="errors.csv", start=None, stop=None):
    command=[]
    command.append(os.path.abspath(rScript))
    command.append("--out=%s" % outCsv)
    if start is not None:
        command.append('--start=%s' % start)

    if stop is not None:
        command.append('--stop=%s' % stop)

    with subprocess.Popen(command, stdout=subprocess.PIPE,stdin=subprocess.PIPE,cwd=data_path) as proc:
        _, errs=proc.communicate()
        if errs is None:
            data=pd.read_csv(os.path.join(data_path,outCsv))
        else:
            raise Exception(errs)
    return data



def get_errors(request):
    print(request)
    validation_id=request["validation"][0]
    start=request.get("start")
    if start is not None:
        start=start[0]
    stop=request.get("stop")
    if stop is not None:
        stop=stop[0]
    validation=Validation.objects.get(validation_id=validation_id)
    script=validation.script
    # error_module=importlib.import_module('api.error_scripts.%s' % script)

    # data=error_module.generate(start=start,stop=stop)
    data=genIssues(rScript= script,outCsv="errors.csv",start=start,stop=stop)
    now=datetime.now(tz=pytz.timezone("Africa/Nairobi"))
    validation.last_updated=now
    validation.save()
    #print(data)

    return data.to_json(orient="table")


def markChecked(issue):
    pass