// Optional deterministic attractor background provider.
// The core theme remains blank unless this provider is assigned to
// `theme-config(background: ...)`.

#let provider(
  mode: "off",
  splines: 46,
  content-splines: 30,
  warmup: 520,
  tail-length: 1024,
  stride: 2,
  step-stride: 620,
  step-offset: 0,
) = {
  assert(mode in ("off", "cached", "compute"), message: "attractor mode must be off, cached, or compute")
  assert(splines >= 0, message: "attractor splines must be non-negative")
  assert(content-splines >= 0, message: "attractor content-splines must be non-negative")
  assert(warmup >= 0, message: "attractor warmup must be non-negative")
  assert(tail-length >= 1, message: "attractor tail-length must be positive")
  assert(stride >= 1, message: "attractor stride must be positive")
  (
    kind: "attractor",
    mode: mode,
    splines: splines,
    content-splines: content-splines,
    warmup: warmup,
    tail-length: tail-length,
    stride: stride,
    step-stride: step-stride,
    step-offset: step-offset,
  )
}
