# API Reference

This document provides an overview of the n8n REST API endpoints, authentication methods, and integration patterns for programmatic access to n8n functionality.

## API Overview

The n8n REST API provides programmatic access to workflow management, execution control, user management, and system administration. The API follows RESTful conventions and uses JSON for data exchange.

**Base URL**: `https://n8n.example.com/api/v1`

**API Versioning**: Current API version is v1. Future versions will maintain backward compatibility.

## Authentication

### API Key Authentication

**Recommended method for programmatic access**:

```bash
# Generate API key in n8n UI: Settings > API Keys
API_KEY="your_api_key_here"

# Use in requests
curl -H "Authorization: Bearer $API_KEY" \
  https://n8n.example.com/api/v1/workflows
```

### Session Authentication

**For web applications using n8n UI**:

```bash
# Login to get session cookie
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "password"}' \
  -c cookies.txt \
  https://n8n.example.com/api/v1/login

# Use session cookie for subsequent requests
curl -b cookies.txt \
  https://n8n.example.com/api/v1/workflows
```

## Core API Endpoints

### Workflows

```mermaid
graph LR
    Client[API Client] --> Workflows[/api/v1/workflows]
    Workflows --> Create[POST - Create]
    Workflows --> List[GET - List All]
    Workflows --> Get[GET /:id - Get One]
    Workflows --> Update[PATCH /:id - Update]
    Workflows --> Delete[DELETE /:id - Delete]
    Workflows --> Activate[POST /:id/activate]
    Workflows --> Execute[POST /:id/execute]
```

#### List Workflows
```http
GET /api/v1/workflows
Authorization: Bearer {api_key}

Response:
{
  "data": [
    {
      "id": "1",
      "name": "Data Processing Workflow",
      "active": true,
      "createdAt": "2024-09-17T10:00:00.000Z",
      "updatedAt": "2024-09-17T15:30:00.000Z",
      "tags": ["automation", "data"]
    }
  ]
}
```

#### Get Workflow
```http
GET /api/v1/workflows/{id}
Authorization: Bearer {api_key}

Response:
{
  "data": {
    "id": "1",
    "name": "Data Processing Workflow",
    "active": true,
    "nodes": [...],
    "connections": {...},
    "settings": {...}
  }
}
```

#### Create Workflow
```http
POST /api/v1/workflows
Authorization: Bearer {api_key}
Content-Type: application/json

{
  "name": "New Workflow",
  "nodes": [
    {
      "id": "webhook-1",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "httpMethod": "POST",
        "path": "new-webhook"
      }
    }
  ],
  "connections": {}
}
```

#### Execute Workflow
```http
POST /api/v1/workflows/{id}/execute
Authorization: Bearer {api_key}
Content-Type: application/json

{
  "data": {
    "input": "data"
  }
}

Response:
{
  "data": {
    "executionId": "exec-123",
    "startedAt": "2024-09-17T16:00:00.000Z",
    "status": "running"
  }
}
```

### Executions

Monitor and manage workflow executions:

#### List Executions
```http
GET /api/v1/executions
Authorization: Bearer {api_key}
?workflowId=1&status=success&limit=10

Response:
{
  "data": [
    {
      "id": "exec-123",
      "workflowId": "1",
      "status": "success",
      "startedAt": "2024-09-17T16:00:00.000Z",
      "stoppedAt": "2024-09-17T16:00:15.000Z",
      "duration": 15000
    }
  ],
  "pagination": {
    "page": 1,
    "perPage": 10,
    "total": 100
  }
}
```

#### Get Execution Details
```http
GET /api/v1/executions/{executionId}
Authorization: Bearer {api_key}

Response:
{
  "data": {
    "id": "exec-123",
    "workflowData": {...},
    "executionData": {
      "resultData": {
        "runData": {...}
      }
    },
    "status": "success"
  }
}
```

#### Stop Execution
```http
POST /api/v1/executions/{executionId}/stop
Authorization: Bearer {api_key}

Response:
{
  "data": {
    "status": "stopped"
  }
}
```

### Users and Authentication

#### List Users
```http
GET /api/v1/users
Authorization: Bearer {api_key}

Response:
{
  "data": [
    {
      "id": "user-1",
      "email": "admin@example.com",
      "firstName": "Admin",
      "lastName": "User",
      "role": "owner",
      "isActive": true
    }
  ]
}
```

#### Create User
```http
POST /api/v1/users
Authorization: Bearer {api_key}
Content-Type: application/json

{
  "email": "newuser@example.com",
  "firstName": "New",
  "lastName": "User",
  "role": "member",
  "password": "secure_password"
}
```

### Credentials

Manage external service credentials:

#### List Credentials
```http
GET /api/v1/credentials
Authorization: Bearer {api_key}

Response:
{
  "data": [
    {
      "id": "cred-1",
      "name": "Slack API",
      "type": "slackApi",
      "createdAt": "2024-09-17T10:00:00.000Z"
    }
  ]
}
```

#### Create Credential
```http
POST /api/v1/credentials
Authorization: Bearer {api_key}
Content-Type: application/json

{
  "name": "New API Credential",
  "type": "httpBasicAuth",
  "data": {
    "user": "api_user",
    "password": "api_password"
  }
}
```

## Webhook Endpoints

### Webhook Execution

Execute workflows via webhooks:

```http
POST /webhook/{workflowId}
Content-Type: application/json

{
  "data": "your webhook payload"
}

Response:
{
  "executionId": "exec-456",
  "status": "success",
  "data": {...}
}
```

### Test Webhooks

Temporary webhook URLs for testing:

```http
POST /webhook-test/{sessionId}
Content-Type: application/json

{
  "test": true,
  "data": "test payload"
}
```

### Form Webhooks

HTML form submissions:

```http
POST /form/{workflowPath}
Content-Type: application/x-www-form-urlencoded

name=John&email=john@example.com&message=Hello
```

## Error Handling

### HTTP Status Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 200 | OK | Request successful |
| 201 | Created | Resource created successfully |
| 400 | Bad Request | Invalid request data |
| 401 | Unauthorized | Authentication required |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource not found |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Server error |

### Error Response Format

```json
{
  "error": {
    "code": "WORKFLOW_NOT_FOUND",
    "message": "Workflow with ID '123' not found",
    "details": {
      "workflowId": "123",
      "timestamp": "2024-09-17T16:00:00.000Z"
    }
  }
}
```

### Common Error Codes

| Code | Description | Resolution |
|------|-------------|------------|
| `INVALID_API_KEY` | API key is invalid or expired | Generate new API key |
| `WORKFLOW_NOT_FOUND` | Workflow ID does not exist | Check workflow ID |
| `EXECUTION_FAILED` | Workflow execution failed | Check execution logs |
| `RATE_LIMIT_EXCEEDED` | Too many requests | Implement request throttling |
| `CREDENTIAL_NOT_FOUND` | Credential ID does not exist | Verify credential configuration |

## Rate Limiting

**Default Limits**:
- 1000 requests per hour per API key
- 100 webhook executions per minute
- 10 concurrent workflow executions

**Rate Limit Headers**:
```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 950
X-RateLimit-Reset: 1695046800
```

**Rate Limit Exceeded Response**:
```json
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Rate limit exceeded. Try again in 60 seconds.",
    "retryAfter": 60
  }
}
```

## SDKs and Client Libraries

### Official Libraries

**JavaScript/TypeScript**:
```bash
npm install n8n-api-client
```

```javascript
import { N8nApiClient } from 'n8n-api-client';

const client = new N8nApiClient({
  baseUrl: 'https://n8n.example.com',
  apiKey: 'your_api_key'
});

// List workflows
const workflows = await client.workflows.list();

// Execute workflow
const execution = await client.workflows.execute('workflow-id', {
  data: { input: 'value' }
});
```

**Python**:
```bash
pip install n8n-python-client
```

```python
from n8n_client import N8nClient

client = N8nClient(
    base_url='https://n8n.example.com',
    api_key='your_api_key'
)

# List workflows
workflows = client.workflows.list()

# Execute workflow
execution = client.workflows.execute('workflow-id', {
    'data': {'input': 'value'}
})
```

### Community Libraries

- **Go**: `github.com/community/go-n8n-client`
- **PHP**: `composer require community/n8n-php-client`
- **Ruby**: `gem install n8n-ruby-client`

## API Usage Examples

### Automated Workflow Management

**Deploy workflows from CI/CD**:
```bash
#!/bin/bash
# deploy-workflows.sh

API_KEY="your_api_key"
N8N_URL="https://n8n.example.com"

for workflow_file in workflows/*.json; do
  workflow_name=$(basename "$workflow_file" .json)
  
  curl -X POST \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d @"$workflow_file" \
    "$N8N_URL/api/v1/workflows"
    
  echo "Deployed: $workflow_name"
done
```

### Monitoring and Alerting

**Check execution status**:
```python
import requests
import time

def monitor_executions(api_key, n8n_url):
    headers = {'Authorization': f'Bearer {api_key}'}
    
    while True:
        response = requests.get(
            f'{n8n_url}/api/v1/executions',
            headers=headers,
            params={'status': 'error', 'limit': 10}
        )
        
        if response.json().get('data'):
            # Send alert for failed executions
            send_alert(response.json()['data'])
        
        time.sleep(60)  # Check every minute
```

### Bulk Operations

**Mass workflow activation**:
```javascript
async function activateAllWorkflows(client) {
  const workflows = await client.workflows.list();
  
  for (const workflow of workflows.data) {
    if (!workflow.active) {
      await client.workflows.activate(workflow.id);
      console.log(`Activated: ${workflow.name}`);
    }
  }
}
```

## Security Best Practices

### API Key Management

**Best Practices**:
- Rotate API keys quarterly
- Use separate keys for different environments
- Store keys securely (environment variables, secret managers)
- Monitor API key usage and access patterns

**Key Rotation Procedure**:
1. Generate new API key
2. Update applications with new key
3. Test functionality with new key
4. Revoke old API key
5. Monitor for any failures

### Request Security

**HTTPS Only**:
- Always use HTTPS for API requests
- Validate SSL certificates
- Use certificate pinning for critical applications

**Input Validation**:
- Validate all input data
- Sanitize user-provided content
- Use parameterized queries for database operations

## Performance Optimization

### Efficient API Usage

**Pagination**:
```http
GET /api/v1/workflows?page=1&limit=50
```

**Filtering**:
```http
GET /api/v1/executions?workflowId=123&status=success&startedAfter=2024-09-17
```

**Field Selection**:
```http
GET /api/v1/workflows?fields=id,name,active
```

### Caching Strategies

**Client-side Caching**:
- Cache workflow definitions locally
- Implement cache invalidation based on update timestamps
- Use ETags for conditional requests

**Request Optimization**:
- Batch multiple operations when possible
- Use webhooks instead of polling for real-time updates
- Implement exponential backoff for retries

## Seams

For comprehensive API documentation and examples:

- [n8n API Documentation](https://docs.n8n.io/api/) — Complete API reference with interactive examples
- [n8n OpenAPI Specification](https://n8n.example.com/api/v1/docs) — Machine-readable API specification
- [n8n Webhook Documentation](https://docs.n8n.io/webhooks/) — Webhook endpoint configuration and usage
- [n8n Community Forum](https://community.n8n.io/c/api/) — API discussions and community examples
- [n8n GitHub API Examples](https://github.com/n8n-io/n8n/tree/master/packages/cli/test/integration) — Integration test examples

## Source Map

| Title | URL | Publisher | Last_Updated | Date_Accessed |
|-------|-----|-----------|--------------|---------------|
| n8n API Documentation | https://docs.n8n.io/api/ | n8n GmbH | 2024-09-05 | 2024-09-17 |
| n8n REST API Reference | https://docs.n8n.io/api/rest/ | n8n GmbH | 2024-09-01 | 2024-09-17 |
| n8n Webhook Guide | https://docs.n8n.io/webhooks/ | n8n GmbH | 2024-08-25 | 2024-09-17 |
| n8n Community API Forum | https://community.n8n.io/c/api/ | n8n Community | 2024-09-16 | 2024-09-17 |
| n8n GitHub Repository | https://github.com/n8n-io/n8n | n8n GmbH | 2024-09-16 | 2024-09-17 |

**Last reviewed**: 2024-09-17