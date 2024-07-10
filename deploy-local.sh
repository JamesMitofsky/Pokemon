#!/bin/bash

# REQUIREMENTS
# 1. Make the file executable by running this in the terminal: chmod +x deploy.sh
# 2. Then run the script by typing: ./deploy-local.sh

# Ensure Docker is using buildx as the builder
docker buildx use default

# Build the Docker image with multi-platform support
docker buildx build -t europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon --platform linux/amd64,linux/arm64 .

# Push the image to the remote repository
docker push europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon

# Deploy the image to Google Cloud Run
echo "24" | gcloud run deploy --image=europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon service-student-james-dev --project=pokedevops --platform managed --region europe-west9

# Note: The 'echo "24"' command simulates selecting '24' for the European server during the interactive prompt of gcloud run deploy.
# It's a workaround and might not work if the prompt changes or requires more inputs.
# For a more robust solution, consider using gcloud's `--region` or `--zone` flags directly if possible.