/// some common utilities

#let _clone-value(value) = {
  if type(value) == dictionary {
    let copied = (:)
    for (key, item) in value.pairs() {
      copied.insert(key, _clone-value(item))
    }
    return copied
  }

  if type(value) == array {
    let copied = ()
    for item in value {
      copied.push(_clone-value(item))
    }
    return copied
  }

  value
}

/// (Deeply) clone a dict.
/// - value (dict): the dict to be cloned
/// -> dict: the cloned dict
#let clone-dict(value) = {
  assert(
    type(value) == dictionary,
    message: "clone-dict only accepts a dictionary, found " + repr(type(value)),
  )
  _clone-value(value)
}

/// (Deeply) merge two dicts. The modded dict overrides the values of specified keys in the raw dict, inheriting the original part, add new keys.
/// - raw (dict): the original dict
/// - mod (dict | none): the dict to modify the original dict. If none, return the clone of the original dict.
/// -> dict: the merged dict
#let merge-dict(raw, mod) = {
  assert(
    type(raw) == dictionary,
    message: "`raw` must be a dictionary, found type " + repr(type(raw)),
  )
  let res = clone-dict(raw)
  if mod == none { return res }
  assert(
    type(mod) == dictionary,
    message: "`mod` must be a dictionary or none, found type " + repr(type(mod)),
  )

  for (key, mod_val) in mod.pairs() {
    if key in res {
      let res_val = res.at(key)
      if type(res_val) == dictionary and type(mod_val) == dictionary {
        res.at(key) = merge-dict(res_val, mod_val)
      } else {
        res.at(key) = _clone-value(mod_val)
      }
    } else {
      res.insert(key, _clone-value(mod_val))
    }
  }
  return res
}

/// (Deeply) modify a dict `res` according to dict `mod`. The modded dict overrides the values of specified keys in the raw dict, inheriting the original part, and should not add new keys. If `mod` is none, return the clone of the original dict.
/// - raw (dict): the original dict
/// - mod (dict | none): the dict to modify the original dict. If none, return the clone of the original dict.
/// -> dict: the modified dict
#let modify-dict(raw, mod) = {
  assert(
    type(raw) == dictionary,
    message: "`raw` must be a dictionary, found type " + repr(type(raw)),
  )
  let res = clone-dict(raw)
  if mod == none { return res }
  assert(
    type(mod) == dictionary,
    message: "`mod` must be a dictionary or none, found type " + repr(type(mod)),
  )

  for (key, mod_val) in mod.pairs() {
    if key in res {
      let res_val = res.at(key)
      if type(res_val) == dictionary and type(mod_val) == dictionary {
        res.at(key) = merge-dict(res_val, mod_val)
      } else {
        res.at(key) = _clone-value(mod_val)
      }
    } else {
      // Do not add new keys
      panic("modify-dict can't add new key of raw")
    }
  }
  return res
}

/// Merge named arguments into an arguments object.
/// Positional arguments are preserved.
#let merge-args(args, mod) = {
  assert(
    type(args) == arguments,
    message: "`args` must be arguments, found " + repr(type(args)),
  )
  arguments(..args.pos(), ..merge-dict(args.named(), mod))
}

/// Modify named arguments in an arguments object.
/// Positional arguments are preserved.
#let modify-args(args, mod) = {
  assert(
    type(args) == arguments,
    message: "`args` must be arguments, found " + repr(type(args)),
  )
  arguments(..args.pos(), ..modify-dict(args.named(), mod))
}
