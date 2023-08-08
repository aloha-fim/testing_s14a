import requests
import json
import os
import zipfile
import torch

import bz2
import pickle
# import _pickle as cpickle
from dotenv import load_dotenv
import os
from os import environ

load_dotenv(".env")



def latlong(addr):
    lat = -1
    long = -1

    url = environ.get("GEO_URL")

    querystring = {
        "benchmark": "Public_AR_Current",
        "address": {addr},
        "format": "json".format(addr=addr),
    }

    headers = {
        "X-RapidAPI-Key": environ.get("X-RapidAPI-Key"),
        "X-RapidAPI-Host": environ.get("X-RapidAPI-Host"),
    }

    response = requests.get(url, headers=headers, params=querystring)

    json_data = json.loads(json.dumps(response.json()))

    result = json_data.get("result")

    if len(result.get("addressMatches")) > 0:
        lat = result.get("addressMatches")[0]["coordinates"]["y"]
        long = result.get("addressMatches")[0]["coordinates"]["x"]

    return lat, long


def load_model(model_zip_path, model_file_name):
    model_path = extract_zip_file(model_zip_path, model_file_name)

    # Load the model
    model = torch.load(model_path)

    return model


def extract_zip_file(model_zip_path, model_file_name):
    model_dir = os.path.dirname(model_zip_path)
    model_path = os.path.join(model_dir, model_file_name)

    # Check if the model file is already extracted
    if not os.path.exists(model_path):
        # extract the model file
        with zipfile.ZipFile(model_zip_path, "r") as zip_ref:
            zip_ref.extractall(model_dir)

    return model_path


def extract_pickle_file(model_zip_path, model_zip_file_name, model_pickle_file_name):
    success = False

    model_path = extract_zip_file(model_zip_path, model_pickle_file_name)
    model_dir = os.path.dirname(model_path)
    model_pickle_path = os.path.join(model_dir, model_pickle_file_name)

    if not os.path.isfile(model_pickle_path):
        with zipfile.ZipFile(model_zip_path, "r") as zip_ref:
            zip_ref.extract(model_pickle_path)
            success = True

    return success

# Load any compressed pickle file
def decompress_pickle(file):
    data = bz2.BZ2File(file, 'rb')
    data = pickle.load(data)
    
    return data