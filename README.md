# Docker with awscli

## The problem
Drone cannot use ECR private images for the build phase, since `auth_config` uses the basic authentication process for docker, which isn't working with ECR.
ECR requires an AWS authentication process with keys that rotate every 12 hours.

## Usage
Run the container as the first build step in Drone 
Provide the container a role with policy that has premissions for `ecr:*`, or provide keys with the environment variables of the container.
Use it to pull the build container, which will be available to the build phase.
Here's a drone pipline example:

```yaml
---
kind: pipeline
name: docker-sync
volumes:
  - name: docker
    host:
      path: /var/run/docker.sock
steps:
  - name: docker-pull
    image: roriz/docker-with-awscli
    environment:
      AWS_ACCESS_KEY_ID:
        from_secret: AWS_ACCESS_KEY_ID
      AWS_SECRET_ACCESS_KEY:
        from_secret: AWS_SECRET_ACCESS_KEY
    volumes:
      - name: docker
        path: /var/run/docker.sock
    commands:
      - $(aws ecr get-login --no-include-email --region sa-east-1)
      - docker pull <account_id>.dkr.ecr.us-east-1.amazonaws.com/build_image:tag
```
