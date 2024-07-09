#!/bin/bash

# Build the Docker image
docker build -t europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon .

# Push the image to the remote repository
docker push europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon

# Deploy the image to Google Cloud Run
echo "24" | gcloud run deploy --image=europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon service-student-james-dev --project=pokedevops