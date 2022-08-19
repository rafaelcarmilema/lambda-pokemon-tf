import json
from random import randrange
from sys import api_version
from unicodedata import name
from urllib import response
import urllib.parse
import boto3
import requests

# set url and get a results in json format
# a list of it 
def call_api():
    api_url = "https://pokeapi.co/api/v2/pokemon?offset=10&limit=10"
    response = requests.get(api_url)
    json_file = response.json()
    data = json_file['results']
    return data

# get 1 random pokemon with details of it 
def call_api_random_pokefact(random_pokemon):
    api_url = "https://pokeapi.co/api/v2/pokemon/"+random_pokemon
    response = requests.get(api_url)
    json_file = response.json()
    
    id = print(json_file["id"])
    name = print(json_file["name"])
    height = print(json_file["height"])
    weight = print(json_file["weight"])
    #data = json_file['results']
    return [id,name,height,weight]


# iterate thru the json file get only name and url for each pokemon
def iterate_json(data):
    for pokemon in data:
        print(pokemon['name']+" "+pokemon['url']) 

def lambda_handler(event, context):
    client = boto3.client('sns')

    random_pokemon = str(randrange(1,95)) # generate random pokemon 
    print(random_pokemon)
    ##Call api and get pokemon info from a random pokemon
    data = call_api_random_pokefact(random_pokemon)
    #data = call_api()

    #Generate the message and publish to sns topic
    response = client.publish(
    TopicArn='arn:aws:sns:us-east-1:205758311321:pokemon-fun-facts-topic',
    Message='Random Pokemon of the day is:\n'
            'name:'+data[1]+'\n'
            'id:'+data[0]+'\n'
            'height:'+data[2]+'\n'
            'weight:'+data[3]+'\n' ,
    Subject='Random Poke Facts',
    MessageStructure='string',
    MessageAttributes={
        'string': {
            'DataType': 'string',
            'StringValue': 'string',
            'BinaryValue': b'bytes'
        }
    },
)
    return  iterate_json(data)



####################### MAIN #########################

random_pokemon = str(randrange(1,95)) # generate random pokemon 
print(random_pokemon)
data = call_api_random_pokefact(random_pokemon)

# data = call_api()
# iterate_json(data)


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
