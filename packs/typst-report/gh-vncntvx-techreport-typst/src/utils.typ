// 工具函数

/// 判断是否为标量类型
#let is-scalar(val) = type(val) not in (array, dictionary)

/// 递归合并字典，base 是默认参数，config 是用户设定的部分参数
///
/// #example(```
/// #let config = merge-dict(
///   (a: 1, b: (c: 2)),
///   (b: (c: 3))
/// )
/// // 结果: (a: 1, b: (c: 3))
/// ```)
#let merge-dict(base, config) = {
  if type(base) != dictionary or type(config) != dictionary {
    panic("merge-dict: 两个参数都必须是字典类型")
  }

  let result = base
  for (key, replacement) in config {
    if key in base {
      let source = base.at(key)
      if type(source) == dictionary and type(replacement) == dictionary {
        result.insert(key, merge-dict(source, replacement))
      } else if is-scalar(source) and is-scalar(replacement) {
        result.insert(key, replacement)
      }
    }
  }
  result
}
