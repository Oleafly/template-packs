#import "../../macros/ml.typ": *

== Machine-learning notation

The machine-learning module collects common losses, risks, activations, and dataset/model notation.

=== Losses and risks

$KL lr([p || q])$, $CE lr([p, q])$, $MSE lr([y, y'])$, $NLL lr([theta; Dtrain])$, $Risk(f)$, and $EmpRisk(f)$.

=== Activations and logits

$softmax(z)$, $sigmoid(z)$, $relu(z)$, $gelu(z)$, and $logits(x)$.

=== Model and dataset shorthand

$ptheta(x)$, $qphi(z | x)$, $Dtrain$, and $Dtest$.
