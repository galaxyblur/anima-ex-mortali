---
title: AI Is a Generator, Not an Oracle
description: Reframing AI reliability as a verification problem, not a probability problem
medium: prose
status: in-progress
threads:
  - frameworks-systems
date_created: "2026-02-21"
date_added: "2026-02-21"
---

We keep arguing about whether AI should be autopilot, copilot, or supervised human work.
That framing assumes the problem is *who produced the answer*. It isn't. The problem is *who decides the answer is acceptable*.

An LLM doesn't give us answers — it gives us candidates:

```
G(Spec) → C*
```

The mistake is treating `C*` as truth. What we need is a verifier:

```
V(C*) = true
```

`V` is derived from `Spec` — a machine-checkable definition of correctness:

```
Spec ⊢ C
```

The workflow changes: we don't generate and hope, we search until something satisfies the contract:

```
repeat:
  C* = G(Spec)
until Spec ⊢ C*
```

```js
function Search(Spec) {
  while (true) {
    C* = Generate(Spec)
    if (Spec.Verify(C*)) return C*
  }
}
```

We don't prevent wrong answers — we prevent wrong answers from being accepted:

```
accepted C ⇒ satisfies Spec
```

The model becomes interchangeable infrastructure. The risk disappears. What remains is only search cost — how long it takes to find a valid candidate.

Notice the loop has one input: `Spec`. The same artifact that defines correctness also drives generation — because a spec precise enough to verify is precise enough to generate from. If it isn't, it's not specific enough to be either.

Improving the spec has dual benefit: better candidates *and* stricter verification. The two compound.

This isn't new — but we never closed the loop. We wrote the candidate consistently. The spec and tests we wrote separately, inconsistently, and they drifted from each other. Most AI workflows today repeat the same mistake: faster candidates, same broken loop.

The difference here: spec and verification are one artifact. When the spec changes, the verifier changes with it. The TDD overhead disappears not because tests got easier to write, but because there's nothing to write separately.

Now the search is cheap and the loop is closed. The bottleneck shifts entirely to the contract.

We've turned AI reliability from a probability problem into a compute problem.
