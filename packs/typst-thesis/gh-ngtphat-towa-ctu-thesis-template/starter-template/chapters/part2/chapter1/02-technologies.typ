== Technology Stack Overview

This section describes the technologies used in the implementation.

=== Backend Technologies

The backend is built using modern .NET technologies:

==== ASP.NET Core 8.0

ASP.NET Core provides a high-performance, cross-platform framework for building web APIs. Key features include:

- Dependency injection built-in
- Middleware pipeline architecture
- High performance (capable of handling 7 million requests/second)
- Cross-platform support (Windows, Linux, macOS)

Example minimal API endpoint:

```csharp
app.MapGet("/api/products", async (IProductRepository repo) =>
{
    var products = await repo.GetAllAsync();
    return Results.Ok(products);
});
```

==== Entity Framework Core

Entity Framework Core (EF Core) serves as the Object-Relational Mapper (ORM). Example entity definition:

```csharp
public class Product
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public int StockQuantity { get; set; }
    public DateTime CreatedAt { get; set; }
}
```

==== PostgreSQL with pgvector

PostgreSQL was chosen for its robustness and the pgvector extension for vector similarity search. This enables image-based product search using machine learning embeddings.

=== Frontend Technologies

@tab-frontend-comparison compares various frontend frameworks:

#figure(
  table(
    columns: 4,
    [*Framework*], [*Performance*], [*Learning Curve*], [*Ecosystem*],
    [Vue.js], [High], [Low], [Good],
    [React], [High], [Medium], [Excellent],
    [Angular], [Medium], [High], [Good],
    [Svelte], [Very High], [Low], [Growing],
  ),
  caption: [Frontend Framework Comparison]
) <tab-frontend-comparison>

Vue.js was selected for its gentle learning curve and excellent documentation.

=== Machine Learning Stack

The ML service uses FastAPI and TensorFlow for image feature extraction:

```python
from fastapi import FastAPI
from tensorflow.keras.applications import ResNet50
import numpy as np

app = FastAPI()
model = ResNet50(weights='imagenet', include_top=False)

@app.post("/extract-features")
async def extract_features(image: UploadFile):
    # Load and preprocess image
    img_array = load_image(image)
    # Extract features
    features = model.predict(img_array)
    return {"features": features.tolist()}
```
