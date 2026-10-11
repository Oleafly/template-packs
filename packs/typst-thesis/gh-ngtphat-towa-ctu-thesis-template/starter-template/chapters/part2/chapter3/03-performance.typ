== Performance Testing and Results

=== Load Testing Methodology

k6 load testing script:

```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '1m', target: 50 },   // Ramp up
    { duration: '3m', target: 50 },   // Stay at 50 users
    { duration: '1m', target: 200 },  // Spike test
    { duration: '1m', target: 0 },    // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% < 500ms
    http_req_failed: ['rate<0.01'],   // <1% errors
  },
};

export default function() {
  const res = http.get('http://localhost:8080/api/products');
  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time OK': (r) => r.timings.duration < 500,
  });
  sleep(1);
}
```

=== Performance Results

#figure(
  table(
    columns: 4,
    [*Endpoint*], [*Avg (ms)*], [*P95 (ms)*], [*P99 (ms)*],
    [GET /products], [42], [85], [120],
    [GET /products/:id], [18], [35], [48],
    [POST /orders], [125], [280], [450],
    [POST /cart/items], [32], [68], [95],
  ),
  caption: [API Response Time Metrics]
) <tab-response-times>

=== Database Performance

Query optimization results:

```sql
-- Before optimization
EXPLAIN ANALYZE 
SELECT * FROM products WHERE category_id = $1;
-- Execution time: 1247.283 ms

-- After adding index
CREATE INDEX idx_products_category ON products(category_id);
-- Execution time: 8.421 ms
```

Performance improvement: *99.3% faster*

=== Scalability Analysis

Horizontal scaling test results are shown in @tab-scaling:

#figure(
  table(
    columns: 4,
    [*Instances*], [*Users*], [*Throughput (req/s)*], [*Avg Response*],
    [1], [100], [1200], [85ms],
    [2], [200], [2300], [92ms],
    [3], [300], [3400], [95ms],
    [4], [400], [4500], [98ms],
  ),
  caption: [Horizontal Scaling Performance]
) <tab-scaling>

The system demonstrates near-linear scalability up to 4 instances.

=== Usability Testing

User testing with 15 participants revealed:

- *Task completion rate*: 93.3%
- *Average time to checkout*: 2min 15sec
- *System Usability Scale (SUS) score*: 78.5/100

User satisfaction ratings:

#figure(
  table(
    columns: 2,
    [*Aspect*], [*Rating (1-5)*],
    [Ease of use], [4.2],
    [Visual design], [4.5],
    [Performance], [4.7],
    [Navigation], [4.1],
    [Overall], [4.4],
  ),
  caption: [User Satisfaction Ratings]
) <tab-satisfaction>
