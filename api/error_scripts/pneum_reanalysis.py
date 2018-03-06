import pandas as pd
from verify.settings import BASE_DIR
import os

def generate(start=None,stop=None):
    data = pd.read_csv(os.path.join(BASE_DIR, "api/tmp/Records with weight or antibiotics documentation issues.csv"))
    return data