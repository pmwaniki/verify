
from api.models import Validation
import importlib
from datetime import datetime
import pytz
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
    error_module=importlib.import_module(f"api.error_scripts.{script}")
    data=error_module.generate(start=start,stop=stop)
    now=datetime.now(tz=pytz.timezone("Africa/Nairobi"))
    validation.last_updated=now
    validation.save()
    #print(data)

    return data.to_json(orient="table")


def markChecked(issue):
    pass