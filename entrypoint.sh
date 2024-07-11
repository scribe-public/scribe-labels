#!/bin/sh

# Initialize JSON string
json="{"

# Loop through environment variables starting with GITHUB_
for var in $(printenv | grep "^GITHUB_" | awk -F= '{print $1}'); do
  # Get the value of the environment variable
  value=$(printenv "$var")
  # Escape double quotes in values
  value=$(echo "$value" | jq -R .)
  # Add the key-value pair to the JSON string
  json="${json}\"$var\":$value,"
done

# Remove the trailing comma and add the closing brace
json=$(echo "$json" | sed 's/,$//')
json="${json}}"

# Set the output using environment files
echo "scribe_github_env=$json" >> $GITHUB_ENV
