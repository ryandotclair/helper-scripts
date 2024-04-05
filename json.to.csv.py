import pandas as pd
sourceFile = "my.file.json"
outputFile = "my.file.csv"

# For when you need to convert a json file to csv
# Nested JSON will appear as a single cell, however.
with open(sourceFile, encoding='utf-8') as inputfile:
    df = pd.read_json(inputfile)

df.to_csv(outputFile, encoding='utf-8', index=False)