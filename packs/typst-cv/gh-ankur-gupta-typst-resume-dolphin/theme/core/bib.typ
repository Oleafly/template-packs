#import "utils.typ": fill_instance_with_default

#let fill_items(filename, default) = {
  let items = yaml(filename)
  let filled_items = (:)
  for (key, value) in items {
    let filled_value = fill_instance_with_default(value, default: default)
    filled_items.insert(key, filled_value)
  }
  filled_items
}

#let filter_items_by_tag(items, function, tag: none) = {
  // Remember: we cannot sort based on date yet
    let items_filtered = if (tag == none) {
        items
    } else {
        let temp = (:)
        for (key, value) in items {
            if (value.tag == tag) {
                temp.insert(key, value)
            }
        }
        temp
  }
  items_filtered.values().map(function)
}
