import pandas as pd

def generate(start=None,stop=None):
    data = pd.read_csv("api/tmp/Records with weight or antibiotics documentation issues.csv")
    return data