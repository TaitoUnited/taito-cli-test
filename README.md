# Taito CLI tests

Taito CLI integration test suite based on [full-stack-template](https://github.com/TaitoUnited/full-stack-template/).

Taito CLI is tested by:

- Building and deploying this project normally using a CI/CD pipeline (see `cloudbuild.yaml`)
- Running a bunch of Taito CLI commands against a remote environment (see `tests`)

These tests can be run on any environment as Taito CLI image and environment details (Kubernetes, Postgres, etc.) are defined for the Google Cloud Build as build variables. If you want to use some other CI/CD for running the tests, just add an appropriate CI/CD script.
