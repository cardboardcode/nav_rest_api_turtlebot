import requests
import json

# Define the URL and payload
url = 'http://localhost:8080/api/goal'
payload = {
    "robot_name": "robot0",
    "location_x": "0.10043600156715549",
    "location_y": "0.0007940823947127917",
    "location_th": "0.0"
}

# Set headers
headers = {
    'Content-Type': 'application/json'
}

# Send the POST request
response = requests.post(url, headers=headers, data=json.dumps(payload))

# Print the response from the server
print(f"Status Code: {response.status_code}")
print(f"Response Body: {response.text}")
