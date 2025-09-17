# Architectural Decision Records (ADRs)

This directory contains Architectural Decision Records (ADRs) for the n8n-application project. ADRs document important architectural decisions made during the development and evolution of the system.

## Overview

ADRs help us:
- Capture the reasoning behind architectural decisions
- Provide context for future team members
- Track the evolution of system architecture
- Avoid repeating past discussions

## ADR Format

We follow the [MADR v3+](https://adr.github.io/madr/) format with additional compliance and security fields. See [0000-template.md](0000-template.md) for the complete template.

## Current ADRs

| ADR | Title | Status | Date | Tags |
|-----|-------|--------|------|------|
| [0000](0000-template.md) | Template | Template | - | Template |
| [0001](0001-framework-docker-for-local-development.md) | Framework: Docker for Local Development | Accepted | 2024-01-15 | Development::Environment, DevEx, Containerization |
| [0002](0002-framework-kubernetes-as-deployment-platform.md) | Framework: Kubernetes as Deployment Platform | Accepted | 2024-01-15 | Infrastructure::Platform, Deployment |
| [0003](0003-framework-helm-for-deployment.md) | Framework: Helm for Deployment | Accepted | 2024-01-15 | Infrastructure::Deployment, DevOps |
| [0004](0004-adopt-backstage-techdocs-seams-approach.md) | Adopt Backstage TechDocs & Seams Approach | Proposed | 2024-09-17 | Documentation::Strategy, TechDocs |

## Creating New ADRs

1. Copy the [template](0000-template.md) to a new file with the next sequential number
2. Fill in all sections, removing guidance text in angle brackets
3. Update the status as decisions progress through the lifecycle
4. Add the new ADR to the table above

## ADR Lifecycle

- **Proposed**: Initial draft, under discussion
- **Accepted**: Decision approved and being implemented
- **Rejected**: Decision was considered but not adopted
- **Deprecated**: Previously accepted but no longer recommended
- **Superseded**: Replaced by a newer ADR

## Related Documentation

- [TechDocs](../techdocs/): Operational and technical documentation
- [Contributing Guidelines](../../README.md#contributing): How to contribute to the project

## Seams

- [MADR - Markdown Architectural Decision Records](https://adr.github.io/madr/) — MADR community, last updated 2024-06-01, accessed 2024-09-17
- [Architecture Decision Records - Thoughtworks](https://www.thoughtworks.com/radar/techniques/lightweight-architecture-decision-records) — Thoughtworks, accessed 2024-09-17

## Source Map

| Title | URL | Publisher | Last_Updated | Date_Accessed |
|-------|-----|-----------|--------------|---------------|
| MADR - Markdown Architectural Decision Records | https://adr.github.io/madr/ | MADR community | 2024-06-01 | 2024-09-17 |
| Architecture Decision Records | https://www.thoughtworks.com/radar/techniques/lightweight-architecture-decision-records | Thoughtworks | 2024-01-01 | 2024-09-17 |

**Last reviewed**: 2024-09-17