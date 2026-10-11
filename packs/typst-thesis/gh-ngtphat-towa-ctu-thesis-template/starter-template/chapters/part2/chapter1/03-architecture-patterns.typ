== Architecture Patterns

=== Microservices Architecture

The system follows a microservices approach with separate services:

- *API Service*: Main e-commerce REST API
- *ML Service*: Image processing and similarity search
- *Gateway*: YARP reverse proxy for routing

Benefits of this approach include:

1. Independent deployment
2. Technology diversity
3. Service isolation
4. Scalability

The architecture follows this microservices approach.

=== Repository Pattern

The Repository pattern provides abstraction over data access:

```csharp
public interface IRepository<T> where T : class
{
    Task<T?> GetByIdAsync(Guid id);
    Task<IEnumerable<T>> GetAllAsync();
    Task<T> AddAsync(T entity);
    Task UpdateAsync(T entity);
    Task DeleteAsync(Guid id);
}
```

=== API Gateway Pattern

YARP (Yet Another Reverse Proxy) routes requests to appropriate services:

```json
{
  "Routes": {
    "api-route": {
      "ClusterId": "api-cluster",
      "Match": { "Path": "/api/{**catch-all}" }
    },
    "ml-route": {
      "ClusterId": "ml-cluster",
      "Match": { "Path": "/ml/{**catch-all}" }
    }
  }
}
```

Performance metrics are shown in @tab-gateway-performance:

#figure(
  table(
    columns: 3,
    [*Metric*], [*Without Gateway*], [*With Gateway*],
    [Avg Response Time], [45ms], [48ms],
    [Throughput (req/s)], [5000], [4800],
    [95th Percentile], [120ms], [125ms],
  ),
  caption: [API Gateway Performance Impact]
) <tab-gateway-performance>

The overhead is minimal (< 7%) while providing routing, load balancing, and centralized authentication.
