#!/bin/bash

# Credit to Google Gemini for helping to create the script below.

# Function to check if a command exists
function command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if gcloud is installed
if ! command_exists "gcloud"; then
  echo "Error: gcloud is not installed. Please install gcloud and try again."
  exit 1
fi

# Check if a region argument is provided
if [[ -z "$1" ]]; then
  echo "Error: Please provide the GCP region as an argument."
  echo "Usage: $0 <region>"
  exit 1
fi

# Get the provided region as an argument
region="$1"

# Export the GCP_REGION environment variable
export GCP_REGION="$region"
echo "GCP_REGION environment variable set to: $region"

# Get all available GCP projects (might require additional permissions)
projects=$(gcloud projects list --format="value(projectId)")

# Filter projects starting with 'qwiklabs-gcp' and select the first
qwiklabs_project=$(echo "$projects" | grep ^qwiklabs-gcp | head -n 1)

# Check if a qualifying project is found
if [[ -z "$qwiklabs_project" ]]; then
  echo "Warning: No project starting with 'qwiklabs-gcp' found. Please set the project manually using 'gcloud config set project <project_id>'."
else
  # Export the GCP_PROJECT environment variable
  export GCP_PROJECT="$qwiklabs_project"
  echo "GCP_PROJECT environment variable set to: $qwiklabs_project"
  
  # Set the project using gcloud config
  gcloud config set project "$qwiklabs_project"
fi

# Set the compute/region using the provided argument
gcloud config set compute/region "$region"

# Set the artifacts location using the provided argument
gcloud config set artifacts/location "$region"

# Install Snyk CLI (if not already installed)
if ! command_exists "snyk"; then
  echo "Installing Snyk CLI..."
  curl --compressed https://static.snyk.io/cli/latest/snyk-linux -o snyk
  chmod +x ./snyk
  sudo mv ./snyk /usr/local/bin/
  echo "Snyk CLI installed."
fi

# Alias kubectl to k
if ! command_exists "k"; then
  echo "Creating alias 'k' for 'kubectl'..."
  alias k='kubectl'
  echo "Alias 'k' created."
fi

# Get the zone of the first (and only) zonal cluster
zone=$(gcloud container clusters list --format="value(location)")

# Check if a zone was found
if [[ -z "$zone" ]]; then
  echo "Error: No zonal GKE clusters found."
else
  # Configure kubectl with credentials to the cluster in the retrieved zone
  gcloud container clusters get-credentials workshop-cluster --zone $zone
fi
