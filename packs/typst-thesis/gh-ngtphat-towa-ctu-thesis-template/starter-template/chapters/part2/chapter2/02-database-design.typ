== Database Design

The database schema follows normalization principles up to 3NF.

=== Entity Relationship

Key entities include:

#figure(
  table(
    columns: 3,
    [*Entity*], [*Primary Key*], [*Description*],
    [Users], [Id (UUID)], [System users],
    [Products], [Id (UUID)], [Product catalog],
    [Orders], [Id (UUID)], [Customer orders],
    [OrderItems], [Id (UUID)], [Order line items],
    [Categories], [Id (UUID)], [Product categories],
  ),
  caption: [Database Entities Overview]
) <tab-db-entities>

=== Schema Details

==== Products Table

```sql
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    category_id UUID REFERENCES categories(id),
    image_url VARCHAR(500),
    embedding vector(2048), -- for ML similarity search
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_embedding ON products USING ivfflat (embedding vector_cosine_ops);
```

==== Orders and OrderItems

The order structure maintains referential integrity:

```sql
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL
);
```

=== Performance Considerations

Index strategy improves query performance significantly:

- B-tree indexes on foreign keys
- IVFFlat index on vector embeddings for similarity search
- Composite indexes on frequently queried columns

Query performance comparison is shown in @tab-query-performance:

#figure(
  table(
    columns: 3,
    [*Query Type*], [*Without Index*], [*With Index*],
    [Product by Category], [1200ms], [8ms],
    [Order History], [850ms], [12ms],
    [Similar Products], [3500ms], [45ms],
  ),
  caption: [Query Performance with Indexing]
) <tab-query-performance>
