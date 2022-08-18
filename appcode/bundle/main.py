import json
from sys import api_version
from unicodedata import name
from urllib import response
import urllib.parse
import boto3
import requests

# set url and get a results in json format
def call_api():
    api_url = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=10"
    response = requests.get(api_url)
    json_file = response.json()
    data = json_file['results']
    print("inside call func")
    return data


# iterate thru the json file get only name and url for each pokemon
def iterate_json(data):
    for pokemon in data:
        print(pokemon['name']+" "+pokemon['url']) 

def lambda_handler(event, context):
    data = call_api()
    return  iterate_json(data)

    # Get the object from the event and show its content type
    # bucket = event['Records'][0]['s3']['bucket']['name']
    # key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    # try:
    #     response = s3.get_object(Bucket=bucket, Key=key)
    #     print("CONTENT TYPE: " + response['ContentType'])
    #     return response['ContentType']
    # except Exception as e:
    #     print(e)
    #     print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
    #     raise e
