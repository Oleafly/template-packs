#let glossary = (
  (
    key: "work-stealing",
    short: "work-stealing",
    description: [
      A load-balancing scheme in which each worker owns a local run queue and,
      on emptying it, steals a batch of tasks from a randomly chosen peer,
      keeping the common case contention-free.
    ],
  ),
  (
    key: "reactor",
    short: "reactor",
    plural: "reactors",
    description: [
      The half of an asynchronous runtime that bridges to the kernel's
      readiness-notification facility: it registers non-blocking file
      descriptors and fires a callback when one becomes ready.
    ],
  ),
  (
    key: "epoll",
    short: `epoll`,
    description: [
      The Linux system call for readiness-based IO multiplexing: one thread
      blocks until the kernel reports which of a large set of file descriptors
      are ready.
    ],
  ),
)

#let abbreviations = (
  (
    key: "cpu",
    short: "CPU",
    long: "central processing unit",
  ),
  (
    key: "io",
    short: "IO",
    long: "input/output",
  ),
  (
    key: "faas",
    short: "FaaS",
    long: "function as a service",
    description: [
      An execution model in which users deploy individual functions that the
      platform runs on demand, scaling and billing per invocation.
    ],
  ),
)
