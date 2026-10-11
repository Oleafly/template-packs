#import "../cleanthesis.typ": *

#abstract("Abstract")[
Modern kernels are asked to do two things at once: isolate workloads from one
another, and get out of their way. This placeholder abstract stands in for the
real one. It is long enough to show how the page sets, and short enough to fit
on a single page.

The first contribution looks at scheduling. We measure how the #glsshort("cfs")
behaves when the machine is oversubscribed, and show where its load-balancing
heuristics lose work-conserving behaviour on #glsshort("numa") hardware.

The second contribution is a memory-allocation path built on #glsshort("ebpf"),
which lets policy be changed without rebuilding the kernel. On our benchmarks it
matches the in-tree allocator at low load and improves tail latency under
pressure.

#v(4mm)
*Keywords:*
operating systems, kernel, scheduling, memory management, eBPF, NUMA
]
