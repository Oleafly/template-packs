== System Overview

The system architecture follows a three-tier design:

1. *Presentation Layer*: Vue.js applications (Shop and Admin)
2. *Business Logic Layer*: ASP.NET Core APIs
3. *Data Layer*: PostgreSQL database

=== Component Diagram

The main components and their interactions are:

- User interfaces communicate via HTTP/REST
- APIs use Entity Framework Core for data access
- ML service provides image similarity search
- All external access goes through the API Gateway

=== Deployment Architecture

The system can be deployed using Docker:

```yaml
version: '3.8'
services:
  postgres:
    image: pgvector/pgvector:latest
    environment:
      POSTGRES_DB: ecommerce
      POSTGRES_PASSWORD: password
  
  api:
    build: ./src/Api
    depends_on:
      - postgres
    ports:
      - "5000:8080"
  
  gateway:
    build: ./src/Gateway
    depends_on:
      - api
    ports:
      - "8080:8080"
```
