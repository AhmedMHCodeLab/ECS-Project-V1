# ECS Implementation Notes

## Configuration Decisions

- **Explain why ECS over Fargate vs EC2 launch type, why ECR over DockerHub, etc.**
- **Link directly to AWS or Terraform docs in your notes.**
- `internal = false` in ALB was used to make the Application Load Balancer internet-facing rather than internal.

### What This Setting Does:
- `internal = false`: Creates a load balancer accessible from the public internet
- `internal = true`: Would create a load balancer only accessible from within your VPC

## ECS vs Fargate — Quick Memory Hook

**ECS = Orchestrator** → "What to run, how many, and where."

**Fargate = Compute Engine** → "Runs it for me, no servers to manage."

### Analogy:

- **ECS** = Kitchen Manager (assigns dishes, controls the workflow)
- **Fargate** = Rented Kitchen Staff + Space (AWS-owned kitchen, you just say what to cook)

## In My Project

- **ECS**: Manages containers, connects them to ALB, handles scaling.
- **Fargate**: Runs those containers inside AWS-managed infrastructure (private subnets).
- **ECR**: The pantry with my prepped ingredients (Docker images).

### Flow:

1. CI/CD → Push image to ECR (Pantry stocked).
2. ECS Task Definition → Recipe card (what image, what resources, what ports).
3. ECS Service (Launch Type = FARGATE) → Kitchen Manager hires staff to cook the recipe.
4. Fargate → Spins up containers in private subnets, pulls image from ECR via NAT.
5. ALB → Waiter delivers dishes (user requests) to kitchen and returns results.

## Key Components

### Clusters
- Logical grouping of tasks or services
- Can contain multiple task definitions and services

### Capacity Terminology
- Task: Individual instance of a task definition
- Service: Maintains specified number of tasks simultaneously
- Task Definition: Blueprint for your application (Docker image, CPU/memory, ports, IAM roles, logging)

### ECS Task Definition
ECS Task Definition is where your infra starts to feel "real," because it's the actual blueprint that tells ECS/Fargate:

- What Docker image to run
- How much CPU/memory to give it
- What ports to expose
- Which IAM role to use for execution
- Where to send logs


#Although technically considered optional at times i've went the mile and added 