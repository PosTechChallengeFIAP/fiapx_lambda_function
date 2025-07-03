import json
import os
import requests

def lambda_handler(event, context):
    api_url = os.getenv("API_GATEWAY_URL")

    for record in event['Records']:
        message = json.loads(record['body'])
        response = requests.post(
            api_url + "/process/" + message.id,
            headers={"Authorization": message.token}  # Optional
        )
        print("POST status:", response.status_code)