#!/bin/bash

# Run curl command and save response to a variable
response=$(curl -sS https://www.cloudflare.com/cdn-cgi/trace)

# Declare an associative array to store variables and their values
declare -A variables

# Iterate over lines in the response
while IFS='=' read -r key value; do
	  # Assign the value to the corresponding variable
	    variables["$key"]="$value"
    done <<< "$response"

    # Access the value of a specific variable
    variable_value="${variables["warp"]}"

    # Check if the value is "off"
    if [[ "$variable_value" == "off" ]]; then
	      echo "The variable is off."
	      warp-cli connect
      else
	        echo "The variable is not off."
		warp-cli disconnect
    fi
