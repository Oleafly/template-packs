== API Design and Implementation

The REST API follows OpenAPI 3.0 specifications.

=== Endpoint Structure

API endpoints follow RESTful conventions:

```
GET    /api/products           - List all products
GET    /api/products/{id}      - Get single product
POST   /api/products           - Create product (admin)
PUT    /api/products/{id}      - Update product (admin)
DELETE /api/products/{id}      - Delete product (admin)

POST   /api/cart/items         - Add to cart
GET    /api/cart               - Get cart contents
DELETE /api/cart/items/{id}    - Remove from cart

POST   /api/orders             - Place order
GET    /api/orders             - Get order history
GET    /api/orders/{id}        - Get order details
```

=== Request/Response Examples

Product creation request:

```json
POST /api/products
{
  "name": "Wireless Headphones",
  "description": "High-quality bluetooth headphones",
  "price": 79.99,
  "stockQuantity": 50,
  "categoryId": "123e4567-e89b-12d3-a456-426614174000"
}
```

Response:

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "name": "Wireless Headphones",
  "price": 79.99,
  "createdAt": "2026-01-01T14:23:00Z"
}
```

=== Error Handling

The API uses Problem Details (RFC 7807) for errors:

```csharp
app.UseExceptionHandler(errorApp =>
{
    errorApp.Run(async context =>
    {
        var problem = new ProblemDetails
        {
            Status = 500,
            Title = "An error occurred",
            Detail = "Please try again later"
        };
        await context.Response.WriteAsJsonAsync(problem);
    });
});
```

=== Authentication and Authorization

JWT bearer tokens authenticate API requests:

```csharp
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new()
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidIssuer = "ecommerce-api",
            ValidAudience = "ecommerce-client"
        };
    });
```
