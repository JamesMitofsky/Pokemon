# Local setup

First, run the development server:

```bash
npm run dev
```

# Remote setup

## Use gCloud

Layout of the URL

```bash
europe-west9-docker.pkg.dev/[project-id]/[registry-id]/[image-name]
# [project-id]  /  [registry-id]  /  [image-name]
# pokedevops    /  student-james  /  pokemon
```

Check artifacts

```bash
gcloud artifacts docker images list europe-west9-docker.pkg.dev/pokedevops/student-james
# Listing items under project pokedevops, location europe-west9, repository student-james.
# Listed 0 items.
```

```bash
 gcloud auth configure-docker europe-west9-docker.pkg.dev
# Adding credentials for: europe-west9-docker.pkg.dev
# After update, the following will be written to your Docker config file located at [/Users/jamesmitofsky/.docker/config.json]:
#  {
#   "credHelpers": {
#     "europe-west9-docker.pkg.dev": "gcloud"
#   }
# }

# Do you want to continue (Y/n)?

# Docker configuration file updated.
```

# Launch a build in Docker

[Tutorial](https://dev.to/francescoxx/wtfnextjs-app-deployed-with-docker-4h3m)

## Build the docker image

1. [Docker settings to support multi-platform.](https://docs.docker.com/storage/containerd/)
2. [Command line modification to support multi-platform.](https://docs.docker.com/build/building/multi-platform/)
3. Use `buildx`, according to [this Stack Overflow post](https://stackoverflow.com/a/66921165/5395435).

```bash
# Sans `buildx`
# docker build -t europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon --platform linux/amd64,linux/arm64 .

docker buildx build -t europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon --platform linux/amd64,linux/arm64 .
```

## Push to remote

```bash
docker push europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon
```

## Deployment

```bash
gcloud run deploy --image=europe-west9-docker.pkg.dev/pokedevops/student-james/pokemon service-student-james-dev --project=pokedevops

# Then select `24` for the European server.
```

# Automation of Github Actions

- Use [act](https://nektosact.com/introduction.html)

## Run push command

```bash
act --secret-file .secrets
```

# Debugging

## Act — Github Actions Locally

Not working because:

```
Error: Error response from daemon: failed to resolve reference "docker.io/catthehacker/ubuntu:act-latest": failed to authorize: failed to fetch oauth token: unexpected status from GET request to https://auth.docker.io/token?scope=repository%3Acatthehacker%2Fubuntu%3Apull&service=registry.docker.io: 401 Unauthorized
```
