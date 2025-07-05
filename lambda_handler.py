import json
import os
import requests

def lambda_handler(event, context):
    api_url = os.getenv("API_GATEWAY_URL")
    print("Received event:", event)

    for record in event['Records']:
        message = json.loads(record['body'])
        response = requests.post(
            api_url + "/process/" + message['id'],
            headers={"Authorization": "Bearer " + message['token']}
        )
        print("POST status:", response.status_code)

        if response.status_code != 200:
            raise Exception(f"Failed to process message {message['id']}: {response.status_code} - {response.text}")
