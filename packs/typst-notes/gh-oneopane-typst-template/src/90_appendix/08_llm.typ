#import "../../macros/llm.typ": *

== Transformer and LLM notation

The LLM module collects attention, normalization, token, and sequence helpers.

=== Operators

$Attn lr([Q, K, V])$, $MHA(X)$, $FFN(X)$, $LayerNorm(x)$, $RMSNorm(x)$, $RoPE(q)$, $logits(x)$, and $tok("hello")$.

=== Helpers

#qkv($Q$, $K$, $V$)

#seq($x$) and #seq($x$, first: $0$, last: $T$)

#prefix($x$, $t$)

#causal-attn($Q$, $K$, $V$, $d_k$)
