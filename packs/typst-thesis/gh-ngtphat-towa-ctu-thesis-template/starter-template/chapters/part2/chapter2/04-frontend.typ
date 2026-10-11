== Frontend Implementation

The frontend uses Vue.js 3 with the Composition API and TypeScript.

=== Component Architecture

The application follows a component-based architecture:

```
src/
├── components/
│   ├── ProductCard.vue
│   ├── ShoppingCart.vue
│   └── OrderSummary.vue
├── views/
│   ├── ProductList.vue
│   ├── ProductDetail.vue
│   └── Checkout.vue
├── stores/
│   ├── cart.ts
│   └── auth.ts
└── services/
    └── api.ts
```

=== Sample Component

Product card component with TypeScript:

```typescript
<script setup lang="ts">
import { computed } from 'vue'
import { useCartStore } from '@/stores/cart'

interface Product {
  id: string
  name: string
  price: number
  imageUrl: string
}

const props = defineProps<{ product: Product }>()
const cartStore = useCartStore()

const formattedPrice = computed(() => 
  `$${props.product.price.toFixed(2)}`
)

const addToCart = () => {
  cartStore.addItem(props.product)
}
</script>

<template>
  <Card>
    <template #header>
      <img :src="product.imageUrl" :alt="product.name" />
    </template>
    <template #title>{{ product.name }}</template>
    <template #content>
      <p class="price">{{ formattedPrice }}</p>
    </template>
    <template #footer>
      <Button @click="addToCart">Add to Cart</Button>
    </template>
  </Card>
</template>
```

=== State Management

Pinia stores manage application state:

```typescript
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useCartStore = defineStore('cart', () => {
  const items = ref<CartItem[]>([])
  
  const total = computed(() => 
    items.value.reduce((sum, item) => 
      sum + item.price * item.quantity, 0
    )
  )
  
  const addItem = (product: Product) => {
    const existing = items.value.find(i => i.id === product.id)
    if (existing) {
      existing.quantity++
    } else {
      items.value.push({ ...product, quantity: 1 })
    }
  }
  
  return { items, total, addItem }
})
```

=== Performance Optimization

Optimization techniques employed:

1. *Lazy loading*: Routes loaded on demand
2. *Virtual scrolling*: For large product lists
3. *Image optimization*: WebP format with lazy loading
4. *Code splitting*: Vendor and app bundles separated

Build size comparison:

#figure(
  table(
    columns: 3,
    [*Bundle*], [*Before*], [*After Optimization*],
    [Vendor], [450 KB], [280 KB],
    [App], [320 KB], [180 KB],
    [Total], [770 KB], [460 KB],
  ),
  caption: [Bundle Size Optimization Results]
) <tab-bundle-size>
