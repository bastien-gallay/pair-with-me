# pair-with-me

Work one GitHub issue as an **adversarial pair**, not a delegation. The goal is
to reduce the **triple debt** — technical, cognitive, intent — and keep the
human the author of their own system instead of a reviewer of AI output they
can't defend.

The canonical protocol lives in [`SKILL.md`](SKILL.md). In one breath:

- **Spine:** adversarial dialogue — the human commits a position, the AI attacks
  it, the human revises. Human output always precedes the AI reveal.
- **Attention priority:** `intent > cognitive > technical` (technical debt is
  delegated to the project harness — lints, tests, mutation).
- **Test-first** with a real per-test `Red → Green → Refactor → Reflect` loop,
  not a single batch of red tests.
- **Two pauses** where the human commits the call and defends the final shape;
  interruption is **leverage-gated** and dialed by the depth choice.
- **Post-process retention** instead of in-process tricks: a visual before→after
  recap and a novelty ledger for spaced review — no planted falsehoods.
- **Async gates** that interrupt where it has leverage (continue-capped vs park).
- **Emit-now, store-later** measurement: one JSONL line per gate, no dashboard.

## Invoke

```text
/pair-with-me #<issue>
```

Or: "pair on this issue", "work this with me", "co-create a fix".

## Why it exists

Better AI artifacts to *read* do not reduce cognitive debt — only human
production *before* the reveal does. This protocol is the offloading fix turned
into a workflow. See `SKILL.md` §0 and §8 for the full rationale and decision
log.
