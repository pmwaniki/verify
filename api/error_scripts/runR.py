import subprocess
import pandas as pd
from verify.settings import BASE_DIR
import os


data_path=os.path.join(BASE_DIR,'api/tmp')
script_path=os.path.join(BASE_DIR,'api/error_scripts')
def genIssues(rScript,outCsv,start=None,stop=None):
    command=[]
    command.append(os.path.join(script_path,rScript))
    if start is not None:
        command.append('--start=%s' % start)

    if stop is not None:
        command.append('--stop=%s' % stop)

    with subprocess.Popen(command, stdout=subprocess.PIPE,stdin=subprocess.PIPE,cwd=data_path) as proc:
        outs,errs=proc.communicate()
        if errs is None:
            data=pd.read_csv(os.path.join(data_path,outCsv))
        else:
            raise Exception(errs)
    return data


