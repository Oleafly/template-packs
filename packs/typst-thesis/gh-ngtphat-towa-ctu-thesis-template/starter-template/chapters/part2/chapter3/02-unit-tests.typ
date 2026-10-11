== Unit and Integration Tests

=== Backend Unit Tests

Example product service test:

```csharp
public class ProductServiceTests
{
    [Fact]
    public async Task GetById_ExistingProduct_ReturnsProduct()
    {
        // Arrange
        var mockRepo = new Mock<IProductRepository>();
        var product = new Product 
        { 
            Id = Guid.NewGuid(), 
            Name = "Test Product" 
        };
        mockRepo.Setup(r => r.GetByIdAsync(product.Id))
            .ReturnsAsync(product);
        
        var service = new ProductService(mockRepo.Object);
        
        // Act
        var result = await service.GetByIdAsync(product.Id);
        
        // Assert
        Assert.NotNull(result);
        Assert.Equal("Test Product", result.Name);
    }
    
    [Fact]
    public async Task Create_ValidProduct_IncreasesCount()
    {
        // Test implementation
    }
}
```

=== Frontend Component Tests

Vue component testing with Vitest:

```typescript
import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import ProductCard from '@/components/ProductCard.vue'

describe('ProductCard', () => {
  it('displays product information', () => {
    const product = {
      id: '123',
      name: 'Test Product',
      price: 29.99,
      imageUrl: '/test.jpg'
    }
    
    const wrapper = mount(ProductCard, {
      props: { product }
    })
    
    expect(wrapper.text()).toContain('Test Product')
    expect(wrapper.text()).toContain('$29.99')
  })
  
  it('emits add-to-cart event when button clicked', async () => {
    const wrapper = mount(ProductCard, {
      props: { product: { /* ... */ } }
    })
    
    await wrapper.find('button').trigger('click')
    expect(wrapper.emitted('add-to-cart')).toBeTruthy()
  })
})
```

=== Integration Tests

API integration test example:

```csharp
public class ProductsApiTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;
    
    public ProductsApiTests(WebApplicationFactory<Program> factory)
    {
        _client = factory.CreateClient();
    }
    
    [Fact]
    public async Task GetProducts_ReturnsSuccessAndProducts()
    {
        // Act
        var response = await _client.GetAsync("/api/products");
        
        // Assert
        response.EnsureSuccessStatusCode();
        var products = await response.Content
            .ReadFromJsonAsync<List<Product>>();
        Assert.NotNull(products);
    }
}
```
