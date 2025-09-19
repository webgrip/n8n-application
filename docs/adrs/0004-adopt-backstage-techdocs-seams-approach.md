# ADR 004 – Adopt Backstage TechDocs & Seams Approach

* **Status**: Accepted
* **Deciders**: WebGrip Engineering Team
* **Date**: 2024-09-17
* **Tags**: Documentation::Strategy, TechDocs, Backstage
* **Version**: 1.0.0

---

## Context and Problem Statement

The n8n-application project needs comprehensive, maintainable documentation that serves multiple audiences: developers, operators, and platform teams. Our current documentation is minimal and scattered, making it difficult for team members to understand system architecture, operational procedures, and development practices.

We need a documentation strategy that:
- Provides canonical information without duplicating external sources
- Integrates with our Backstage developer portal
- Remains current and accurate over time
- Supports both newcomers and experienced team members

## Decision Drivers

| # | Driver (why this matters)                                      |
| - | -------------------------------------------------------------- |
| 1 | Enable efficient onboarding of new team members (< 2 hours)   |
| 2 | Provide single source of truth for operational procedures     |
| 3 | Integrate seamlessly with Backstage developer portal          |
| 4 | Minimize maintenance overhead through strategic linking        |
| 5 | Support multiple user personas (dev, ops, platform teams)     |
| 6 | Ensure documentation stays current and accurate                |
| 7 | Enable rich content with diagrams and interactive elements    |

## Considered Options

1. **Internal Wiki** – Confluence or similar knowledge management platform
2. **GitHub Wiki** – Built-in GitHub wiki functionality
3. **Standalone Documentation Site** – Custom documentation website
4. **Backstage TechDocs with Seams** – MkDocs-based docs with strategic external linking

## Decision Outcome

### Chosen Option

**Backstage TechDocs with Seams Approach**

### Rationale

TechDocs provides the best balance of functionality, maintainability, and integration with our existing toolchain. The "seams" approach (linking to authoritative external sources rather than duplicating content) significantly reduces maintenance burden while ensuring accuracy.

Key advantages:
- **Native Backstage Integration**: Seamless experience within our developer portal
- **Git-based Workflow**: Documentation changes follow same review process as code
- **MkDocs Ecosystem**: Rich plugin support for diagrams, search, and analytics
- **Seams Strategy**: Links to authoritative sources reduce duplication and staleness
- **Version Control**: Full history and change tracking through Git

### Positive Consequences

* Unified developer experience through Backstage integration
* Documentation stays in sync with code through co-location
* Rich content support with Mermaid diagrams and Material theme
* Reduced maintenance through strategic external linking
* Clear ownership and review process through Git workflows
* Mobile-friendly and searchable interface

### Negative Consequences / Trade-offs

* Requires MkDocs knowledge for advanced customization
* External link dependencies may break over time
* Limited offline access compared to fully self-contained docs
* Additional build step in CI/CD pipeline

### Risks & Mitigations

* **Risk**: External links becoming stale or broken
  * **Mitigation**: Quarterly link validation process, preference for stable canonical URLs
* **Risk**: Documentation becomes too sparse due to over-reliance on external sources
  * **Mitigation**: Balance seams with sufficient local context and decision rationale
* **Risk**: MkDocs build failures blocking deployments
  * **Mitigation**: Documentation build as separate pipeline, clear error handling

## Validation

* **Immediate proof** – TechDocs site builds successfully and renders in Backstage
* **Ongoing guardrails** – Quarterly documentation review process, automated link checking

## Compliance, Security & Privacy Impact

No significant compliance impact. All documentation will remain public-facing with no sensitive information. External links will be to public, authoritative sources only.

## Notes

* **Related Decisions**: ADR-001 (Docker development), ADR-002 (Kubernetes deployment)
* **Supersedes / Amends**: N/A
* **Follow-ups / TODOs**: Implement quarterly link validation, establish documentation review cadence

---

### Revision Log

| Version | Date       | Author              | Change           |
| ------- | ---------- | ------------------- | ---------------- |
| 1.0.0   | 2024-09-17 | WebGrip Engineering | Initial creation |