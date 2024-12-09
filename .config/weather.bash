#!/usr/bin/env bash
# Fetch JSON data from wttr.in API
response=$(curl -s "https://wttr.in/Paris?format=j1")

# Extract the current temperature and weather from the JSON response using jq
temperature=$(echo "$response" | jq -r '.current_condition[0].temp_C')
weather=$(echo "$response" | jq -r '.current_condition[0].weatherDesc[0].value')

# Output the values (optional)
echo "Current Temperature: $temperature°C"
echo "Current Weather: $weather"

# You can now use the variables $temperature and $weather in your script

