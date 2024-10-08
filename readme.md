# LPT Boostrap

This repository provides infrastructure setup for the lpt schowcase.

## Scopes
The setup is divided into 3 (not fully independent) scopes to allow independent terraform application:
1) State bucket, state service account, simple GKE cluster
2) GitHub (repos, teams)
3) Application infrastructure (application sa, docker repo, db)

The scope (1) is intended to be applied first, since it also provides the state bucket.
All scopes use different sub folders in the state bucket to store their states.

## Workflows
The bootsrap.yaml workflow is the primary, manually triggered workflow.
The scope must be selected as input for a workflow run (as well as the environment, but this currently is always `dev`
anyway).

### Workflow authentication and authorisation
Currently, the workflows use the Google Auth GitHub action based on a service account key, provided as repository secret.
The underlying service account `workflow-automation` was initially created manually and has necessary permission to
apply infrastructure changes via terraform.

## GKE
The created GKE cluster is not publicly accessible, external access is only provided on single IP (CIDR/32) basis.
This is important for local execution of `helm` or `kubectl`, e.g. to test deployments.


## Application service account
Scope (3) also creates the SA `lpt-application` which is intended to be the runtime SA for lpt application pods.
