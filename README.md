# Vehicle Auth

Authentication and authorization infrastructure for the Vehicle API using Amazon Cognito and Terraform.

## Technologies

- Terraform
- Amazon Cognito
- GitHub Actions

## Responsibility

This repository is responsible exclusively for user authentication and authorization.

User identity data is kept separate from the transactional data stored by the Vehicle API.

## Architecture

```text
Client
  |
  v
Amazon Cognito
  |
  | JWT
  v
Vehicle API
```

The Vehicle API does not store user passwords or authentication data.

## Cognito Resources

Terraform provisions:

- Cognito User Pool
- Cognito App Client
- `USER` group
- `ADMIN` group

## User Roles

### USER

Represents registered vehicle buyers.

Users in this group can purchase available vehicles.

### ADMIN

Represents application administrators.

Users in this group can:

- register vehicles;
- edit vehicle data.

## JWT Authorization

Amazon Cognito includes the user's groups in the JWT claim:

```json
{
  "cognito:groups": ["USER"]
}
```

The Vehicle API converts Cognito groups into Spring Security authorities:

```text
USER  -> ROLE_USER
ADMIN -> ROLE_ADMIN
```

## AWS Region

```text
us-east-2
```

## Terraform

### Initialize

```bash
terraform init
```

### Format

```bash
terraform fmt
```

### Validate

```bash
terraform validate
```

### Plan

```bash
terraform plan
```

### Apply

```bash
terraform apply
```

Always review the Terraform plan before applying infrastructure changes.

## Outputs

Terraform exposes:

- Cognito User Pool ID
- App Client ID
- JWT issuer URI

The issuer URI is used by the Vehicle API OAuth2 Resource Server configuration.

## CI

GitHub Actions validates Terraform changes by running:

```text
terraform init -backend=false
terraform fmt -check
terraform validate
```

The workflow runs for:

- feature branches;
- Pull Requests targeting `main`;
- pushes to `main`.

## Security

Terraform state files and variable files are not committed.

Ignored files include:

```text
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
crash.log
```

AWS credentials must never be committed to the repository.

## Related Repositories

### vehicle-api

Contains the Spring Boot API, business rules, tests, database migrations and application CI/CD.

### vehicle-infra

Contains the AWS infrastructure configuration for the Vehicle API environment.

## Project

This repository is part of the Tech Challenge - PósTech SOAT - Fase 3.