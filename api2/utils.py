
from api2.models import Validation, History
import importlib
from datetime import datetime
import pytz
import subprocess
import pandas as pd
from verify.settings import BASE_DIR
import os
import requests
import json
import pandas as pd

data_path=os.path.join(BASE_DIR,'api/tmp')
# rScript=os.path.join(BASE_DIR,'../R-gen-errors/00-main.R')
rScript=os.path.join('/home/pmwaniki/Dropbox/http/cin-web/R-gen-errors/00-main-neonatal.R')


# def genIssues(rScript, outCsv="errors.csv", start=None, stop=None,hosp=None):
#     command=[]
#     command.append(os.path.abspath(rScript))
#     command.append("--out=%s" % outCsv)
#     if start is not None:
#         command.append('--start=%s' % start)
#
#     if stop is not None:
#         command.append('--stop=%s' % stop)
#     if hosp is not None:
#         command.append('--hosp=%s' % hosp)
#
#     print(" ".join(command))
#
#     with subprocess.Popen(command ,stderr=subprocess.PIPE,stdin=subprocess.PIPE,cwd=data_path) as proc:
#         out, errs=proc.communicate()
#         if errs.decode('utf-8') == '':
#             data=pd.read_csv(os.path.join(data_path,outCsv))
#
#
#         else:
#             raise Exception(errs.decode('utf-8'))
#     return data

def genIssuesApi(url, start=None, stop=None,hosp=None):
    req_data={}
    # url="http://127.0.0.1:5000?validation=cin_peads"
    if start is not None:req_data['start']=start
    if stop is not None:req_data['stop'] = stop
    if hosp is not None:req_data['hosp'] = hosp

    r=requests.get(url,params=req_data)
    if r.status_code==200:
        data_json=json.loads(r.text)
        data=pd.DataFrame.from_dict(data_json)
        return data
    else:
        raise Exception(json.loads(r.text))


def get_errors(request):
    print(request)
    validation_id=request["validation"][0]
    start=request.get("start")
    if start is not None:
        start=start[0]
    stop=request.get("stop")
    if stop is not None:
        stop=stop[0]
    hosp=request.get('hosp')
    if hosp is not None:
        hosp=hosp[0]

    validation=Validation.objects.get(validation_id=validation_id)
    validation_url=validation.url
    # error_module=importlib.import_module('api.error_scripts.%s' % script)

    # data=error_module.generate(start=start,stop=stop)
    try:
        data = genIssuesApi(url=validation_url, start=start, stop=stop,hosp=hosp)
        now = datetime.now(tz=pytz.timezone("Africa/Nairobi"))
        validation.last_updated = now
        validation.save()
        # print(data)

        return data
    except Exception as err:
        raise Exception(err)




