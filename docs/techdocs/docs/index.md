# n8n Application Documentation

Welcome to the technical documentation for the **n8n workflow automation application**. This documentation serves developers, operators, and platform teams working with n8n in our infrastructure.

## Overview

**n8n** is an open-source, node-based workflow automation tool that allows you to connect APIs, databases, and services through a visual, low-code editor. This repository contains our deployment and operational framework for running n8n in production environments.

**Target Audiences:**
- **Developers**: Setting up local development environments and contributing to configurations
- **Platform Teams**: Deploying and managing n8n infrastructure
- **End Users**: Understanding capabilities and integration options

## Quick Start

For immediate access to key resources:

- **🚀 [Operations Guide](operations.md)** - Deployment, scaling, and maintenance procedures
- **⚙️ [Development Setup](development.md)** - Local development environment configuration
- **🏗️ [Architecture Overview](architecture.md)** - System design and component relationships
- **🔒 [Security Guide](security.md)** - Authentication, authorization, and hardening

## Version Support

| Component | Current Version | Support Status |
|-----------|----------------|----------------|
| n8n Core | 1.43.1+ | Active |
| Node.js | 18.x LTS | Recommended |
| PostgreSQL | 13+ | Production |
| SQLite | 3.x | Development |

## Navigation

### Core Documentation
- **[Architecture](architecture.md)** - Technical architecture, data flow, and system design
- **[Operations](operations.md)** - Deployment, monitoring, backup, and scaling
- **[Development](development.md)** - Local setup, testing, and contribution guidelines
- **[Security](security.md)** - Authentication methods, security hardening, and compliance

### Integration & APIs
- **[Dependencies](dependencies.md)** - Runtime dependencies and version requirements
- **[Integrations](integrations.md)** - Built-in nodes, custom integrations, and webhooks
- **[API Reference](api/index.md)** - REST API endpoints and usage examples
- **[Changelog](changelog.md)** - Version history and update procedures

## Disambiguation

This documentation covers the **n8n open-source workflow automation platform** as deployed in our infrastructure. We focus on:

- ✅ **Self-hosted n8n deployment** using Docker and Kubernetes
- ✅ **Operational procedures** for our specific environment
- ✅ **Custom configurations** and integrations
- ✅ **Development workflows** for our team

**Not covered here:**
- ❌ n8n Cloud (SaaS) specific features
- ❌ General n8n user tutorials (see official docs)
- ❌ Third-party hosting solutions

## Contributing

This documentation follows our ADR-004 decision to use Backstage TechDocs with a "seams" approach - linking to authoritative external sources rather than duplicating content.

When contributing:
1. Follow the [seams pattern](#seams) for external references
2. Include proper source attribution
3. Update review dates when making changes
4. Test documentation builds locally

## Seams

Primary authoritative sources for n8n information:

- [n8n Official Documentation](https://docs.n8n.io/) — Comprehensive user and developer guides
- [n8n GitHub Repository](https://github.com/n8n-io/n8n) — Source code and technical discussions
- [n8n Community Forum](https://community.n8n.io/) — User discussions and troubleshooting
- [n8n Docker Hub](https://hub.docker.com/r/n8nio/n8n) — Official container images and deployment notes

## Source Map

| Title | URL | Publisher | Last_Updated | Date_Accessed |
|-------|-----|-----------|--------------|---------------|
| n8n Official Website | https://n8n.io | n8n GmbH | 2024-09-01 | 2024-09-17 |
| n8n Documentation | https://docs.n8n.io/ | n8n GmbH | 2024-09-15 | 2024-09-17 |
| n8n GitHub Repository | https://github.com/n8n-io/n8n | n8n GmbH | 2024-09-16 | 2024-09-17 |
| n8n Installation Guide | https://docs.n8n.io/hosting/installation/ | n8n GmbH | 2024-08-20 | 2024-09-17 |
| n8n GitHub Releases | https://github.com/n8n-io/n8n/releases | n8n GmbH | 2024-09-11 | 2024-09-17 |

**Last reviewed**: 2024-09-17
