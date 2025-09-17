# Changelog

This document provides version history and upgrade procedures for the n8n-application deployment. For comprehensive release notes, see the official n8n GitHub releases.

## Current Version Status

| Component | Current Version | Latest Available | Status |
|-----------|----------------|------------------|--------|
| **n8n Core** | 1.43.1 | 1.43.1 | ✅ Current |
| **Node.js** | 18.17.1 | 18.18.0 | 🔄 Update Available |
| **PostgreSQL** | 15.4 | 15.4 | ✅ Current |
| **Redis** | 7.0.12 | 7.2.1 | 🔄 Update Available |

## Release History

### Version 1.43.x Series (Current)

#### 1.43.1 (2024-09-11)
**Status**: Current Production Version

**Key Features**:
- Enhanced webhook security with improved validation
- Better error handling for large workflow executions
- Improved Node.js 18.x compatibility
- Updated npm dependencies with security patches

**Breaking Changes**: None

**Upgrade Notes**:
- Automatic database migration (backup recommended)
- No configuration changes required
- Compatible with existing workflows

**Security Fixes**:
- CVE-2024-45490: Fixed prototype pollution vulnerability
- CVE-2024-45491: Resolved XSS issue in workflow descriptions

#### 1.43.0 (2024-08-28)
**Key Features**:
- New AI nodes for GPT-4 and Claude integration
- Enhanced workflow debugging tools
- Improved performance for large datasets
- Better mobile UI responsiveness

**Upgrade Path**:
```bash
# Update container image
docker pull n8nio/n8n:1.43.0

# Update Helm deployment
helm upgrade n8n ./ops/helm/n8n --set image.tag=1.43.0
```

### Version 1.42.x Series (Maintenance)

#### 1.42.3 (2024-08-15)
**Status**: Maintenance (Security fixes only)

**Security Fixes**:
- Updated Express.js to 4.18.2
- Patched CSRF vulnerability in webhook endpoints
- Fixed JWT token validation issue

#### 1.42.0 (2024-07-20)
**Key Features**:
- New credential encryption system
- Enhanced RBAC with custom roles
- Improved queue management for scaling
- Better error reporting and logging

**Breaking Changes**:
- Credential storage format updated (automatic migration)
- API endpoint changes for user management
- Environment variable naming changes for some configurations

### Version 1.41.x Series (End of Life)

#### 1.41.2 (2024-07-05)
**Status**: End of Life (Upgrade Required)

**Final Security Update**:
- Critical security patches backported
- Last update for 1.41.x series
- Upgrade to 1.42+ recommended immediately

## Upgrade Procedures

### Pre-Upgrade Checklist

**Before upgrading any n8n version**:

- [ ] **Backup Database**: Full PostgreSQL backup
- [ ] **Export Workflows**: Download workflow definitions
- [ ] **Document Configuration**: Record current environment variables
- [ ] **Test Environment**: Verify upgrade in staging first
- [ ] **Maintenance Window**: Schedule appropriate downtime
- [ ] **Rollback Plan**: Prepare rollback procedures

### Standard Upgrade Process

#### Docker Deployment

```bash
# 1. Backup current state
docker exec postgres pg_dump -U n8n n8n > backup-$(date +%Y%m%d).sql

# 2. Stop current container
docker stop n8n

# 3. Pull new image
docker pull n8nio/n8n:1.43.1

# 4. Start with new image
docker run -d \
  --name n8n \
  --restart unless-stopped \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  -e DB_TYPE=postgresdb \
  -e DB_POSTGRESDB_HOST=postgres \
  n8nio/n8n:1.43.1

# 5. Verify upgrade
curl http://localhost:5678/healthz
```

#### Kubernetes Deployment

```bash
# 1. Backup database
kubectl exec postgres-pod -- pg_dump -U n8n n8n > backup-$(date +%Y%m%d).sql

# 2. Update Helm chart
helm upgrade n8n ./ops/helm/n8n \
  --set image.tag=1.43.1 \
  --set upgrade.backup=true

# 3. Monitor rollout
kubectl rollout status deployment/n8n

# 4. Verify health
kubectl get pods -l app=n8n
kubectl logs -l app=n8n --tail=50
```

### Database Migration

n8n performs automatic database migrations during startup:

```bash
# Manual migration (if needed)
docker exec n8n-container n8n db:migrate

# Check migration status
docker exec n8n-container n8n db:migrate:status

# Revert last migration (emergency only)
docker exec n8n-container n8n db:migrate:revert
```

**Migration Monitoring**:
```sql
-- Check migration status in PostgreSQL
SELECT * FROM migrations ORDER BY timestamp DESC LIMIT 5;

-- Verify table structure
\d+ workflow_entity
\d+ execution_entity
```

### Rollback Procedures

#### Emergency Rollback

If upgrade fails or causes issues:

```bash
# 1. Stop current version
docker stop n8n

# 2. Restore database backup
docker exec postgres psql -U n8n -d n8n < backup-20240917.sql

# 3. Start previous version
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  n8nio/n8n:1.42.3  # Previous working version

# 4. Verify functionality
curl http://localhost:5678/healthz
```

#### Kubernetes Rollback

```bash
# Rollback Helm deployment
helm rollback n8n 1  # Rollback to previous revision

# Check rollback status
kubectl rollout status deployment/n8n

# Verify pods are healthy
kubectl get pods -l app=n8n
```

## Version Compatibility Matrix

### Node.js Compatibility

| n8n Version | Node.js Min | Node.js Max | Recommended |
|-------------|-------------|-------------|-------------|
| 1.43.x | 18.10.0 | 18.x.x | 18.17.1 |
| 1.42.x | 16.15.0 | 18.x.x | 18.16.0 |
| 1.41.x | 16.15.0 | 18.x.x | 16.20.0 |
| 1.40.x | 16.15.0 | 16.x.x | 16.19.0 |

### Database Compatibility

| n8n Version | PostgreSQL | MySQL | SQLite |
|-------------|------------|-------|--------|
| 1.43.x | 13+ | 8.0+ | 3.35+ |
| 1.42.x | 12+ | 8.0+ | 3.35+ |
| 1.41.x | 11+ | 5.7+ | 3.31+ |

### Breaking Changes Summary

#### Version 1.42.0 Breaking Changes

**Credential Storage**:
- **Impact**: Credential encryption format changed
- **Action**: Automatic migration during upgrade
- **Risk**: Low (automatic handling)

**API Changes**:
- **Impact**: User management endpoints restructured
- **Action**: Update custom integrations using `/users` API
- **Risk**: Medium (requires integration updates)

**Environment Variables**:
```bash
# Changed in 1.42.0
# OLD
N8N_USER_FOLDER=/home/node/.n8n

# NEW
N8N_CONFIG_FILES=/home/node/.n8n
```

#### Version 1.41.0 Breaking Changes

**Webhook Security**:
- **Impact**: Stricter webhook validation
- **Action**: Review webhook configurations
- **Risk**: Medium (some webhooks may need updates)

**Node.js Requirement**:
- **Impact**: Minimum Node.js version increased to 16.15.0
- **Action**: Update Node.js in custom deployments
- **Risk**: High (deployment may fail with old Node.js)

## Security Updates

### Critical Security Patches

#### September 2024
- **CVE-2024-45490**: Prototype pollution in workflow execution
  - **Affected**: All versions < 1.43.1
  - **Severity**: High
  - **Fixed**: 1.43.1

- **CVE-2024-45491**: Cross-site scripting in workflow descriptions
  - **Affected**: All versions < 1.43.1
  - **Severity**: Medium
  - **Fixed**: 1.43.1

#### August 2024
- **CVE-2024-42367**: CSRF vulnerability in webhook endpoints
  - **Affected**: All versions < 1.42.3
  - **Severity**: High
  - **Fixed**: 1.42.3

### Security Upgrade Priority

| Severity | Response Time | Action Required |
|----------|---------------|-----------------|
| **Critical** | 24 hours | Immediate upgrade |
| **High** | 72 hours | Priority upgrade |
| **Medium** | 1 week | Scheduled upgrade |
| **Low** | Next maintenance | Regular upgrade |

## Feature Deprecations

### Deprecated Features

#### Version 1.43.x
- **Legacy OAuth1 nodes**: Will be removed in 1.45.0
  - **Alternative**: Use OAuth2 or API key authentication
  - **Timeline**: 6 months notice

- **Old credential format**: Deprecated in favor of encrypted storage
  - **Migration**: Automatic during upgrade
  - **Timeline**: Removed in 1.44.0

#### Version 1.42.x
- **SQLite in production**: Not recommended for production use
  - **Alternative**: PostgreSQL or MySQL
  - **Support**: Continued for development only

### Removed Features

#### Version 1.42.0
- **HTTP basic auth for webhooks**: Removed due to security concerns
  - **Alternative**: Use API key or OAuth authentication
- **Legacy workflow export format**: Removed in favor of new JSON format

## Update Notifications

### Automated Update Checking

Enable update notifications:

```bash
# Environment variable to enable update checks
N8N_VERSION_NOTIFICATIONS_ENABLED=true
N8N_VERSION_NOTIFICATIONS_ENDPOINT=https://api.n8n.io/api/versions
```

### Monitoring for Updates

**Weekly Update Check Script**:
```bash
#!/bin/bash
# check-n8n-updates.sh

CURRENT_VERSION=$(docker exec n8n n8n --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
LATEST_VERSION=$(curl -s https://api.github.com/repos/n8n-io/n8n/releases/latest | jq -r '.tag_name' | sed 's/n8n@//')

if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
    echo "Update available: $CURRENT_VERSION → $LATEST_VERSION"
    # Send notification to operations team
fi
```

## Upgrade Planning

### Recommended Update Schedule

**Production Environment**:
- **Security updates**: Apply within 72 hours
- **Minor updates**: Monthly maintenance window
- **Major updates**: Quarterly after thorough testing

**Staging Environment**:
- **All updates**: Apply immediately for testing
- **Pre-production testing**: 1 week before production

### Testing Procedures

**Pre-upgrade Testing**:
1. **Backup Verification**: Restore backup in test environment
2. **Workflow Testing**: Execute critical workflows
3. **Integration Testing**: Verify external API connections
4. **Performance Testing**: Compare execution times
5. **Security Testing**: Validate authentication and authorization

## Seams

For comprehensive version information and detailed release notes:

- [n8n GitHub Releases](https://github.com/n8n-io/n8n/releases) — Official release notes and download links
- [n8n Changelog](https://github.com/n8n-io/n8n/blob/master/CHANGELOG.md) — Detailed change log with commit references
- [n8n Upgrade Guide](https://docs.n8n.io/hosting/installation/updating/) — Official upgrade procedures and best practices
- [n8n Breaking Changes](https://github.com/n8n-io/n8n/blob/master/BREAKING-CHANGES.md) — Breaking changes documentation
- [n8n Security Advisories](https://github.com/n8n-io/n8n/security/advisories) — Security vulnerability reports and fixes

## Source Map

| Title | URL | Publisher | Last_Updated | Date_Accessed |
|-------|-----|-----------|--------------|---------------|
| n8n GitHub Releases | https://github.com/n8n-io/n8n/releases | n8n GmbH | 2024-09-11 | 2024-09-17 |
| n8n Official Changelog | https://github.com/n8n-io/n8n/blob/master/CHANGELOG.md | n8n GmbH | 2024-09-11 | 2024-09-17 |
| n8n Upgrade Documentation | https://docs.n8n.io/hosting/installation/updating/ | n8n GmbH | 2024-08-20 | 2024-09-17 |
| n8n Breaking Changes | https://github.com/n8n-io/n8n/blob/master/BREAKING-CHANGES.md | n8n GmbH | 2024-08-15 | 2024-09-17 |
| n8n Security Advisories | https://github.com/n8n-io/n8n/security/advisories | n8n GmbH | 2024-09-10 | 2024-09-17 |

**Last reviewed**: 2024-09-17