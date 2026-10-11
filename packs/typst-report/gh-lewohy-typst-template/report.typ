#set text(
  font: "Pretendard Variable",
)
#show raw: it => [
  #set text(
    font: "JetBrainsMono NF",
    ligatures: true,
  )
  #set raw(tab-size: 4)

  #it
]


```cpp
#include <iostream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
```
