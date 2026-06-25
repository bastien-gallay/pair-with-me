---
name: pair-with-me
description: >
  Work one issue (or a scoped task) as an adversarial pair, not a delegation — the goal is
  to reduce the TRIPLE debt (technical, cognitive, intent), keeping the human
  the author of their own system. The human produces positions; the AI attacks
  them; the human revises. Test-first with a per-test Red→Green→Refactor→Reflect
  loop, two pauses, async gates that interrupt where it has leverage, a
  post-process retention pass (visual recap + novelty ledger), and emit-now/
  store-later measurement hooks. Use when the user types
  `/pair-with-me #<n>`, asks to "pair on", "work this issue with me", "co-create
  / co-engage on a fix", or wants help on an issue WITHOUT being turned into a
  reviewer of AI output they can't defend.
---

# pair-with-me

> A protocol for working one issue *with* a human so they stay the mind behind
> the code. The opposite of "delegate and review." Every step is shaped to make
> the human **produce before the AI reveals**, because that is the only thing
> that actually reduces cognitive debt — better AI artifacts to read do not.

## 0. The one idea

There are three debts, and they trade off:

| Debt | What it is | Who reduces it | Attention |
| --- | --- | --- | --- |
| **Technical** | messy/untested/fragile code | the **harness** (lints, tests, mutation) | **lowest** — delegate |
| **Cognitive** | offloaded thinking → critical-thinking atrophy | only the **human, producing** | high |
| **Intent** | building the wrong thing for unexamined reasons | the **human, deciding** | **highest** |

**Attention priority: `intent > cognitive > technical`.** Technical debt is the
*most painful* and the *most automatable*, so it gets maximum machine and near-
zero human attention — **conditional on harness strength**. Harness strength is
defined by the project's own `AGENTS.md` / `CODING_STANDARDS.md`; read them at
the start. If they are thin, re-elevate technical attention until they aren't.

**Spine: adversarial dialogue.** The human commits a position; the AI attacks
it; the human revises. The seven phases below (plus two pauses) are scaffolding around this spine.
The live back-and-forth *is* the deliverable — not the artifacts it produces.

## 1. Always-on behavioural directives

These hold in every phase and override convenience:

1. **Human output precedes AI reveal at every gate.** Ask the human to predict,
   commit, or defend *before* showing the answer. Never reveal first.
2. **No unsolicited recommendations.** Present the **facts and the option
   space**, make the strongest case for each option you can't choose between,
   and **withhold any preference**. Close the answer with a natural, freshly-
   phrased one-liner offering to suggest ("want my pick on X? — say so"). Give a
   recommendation only when the human takes up the offer. **This is the
   directive you'll most want to break** — recommending is your default; don't,
   unless the human asks. Generative requests ("suggest names") are fine —
   listing ≠ ranking.
3. **No issue numbers in test names or code comments.** Git history carries that
   link. Requirement refs the project already uses (e.g. `FR4`) are fine.
4. **Announce async mode in plain words with its marker** (see §4) — ▶️ continue
   / ⏸️ park, never a bare `A`/`D`.
5. **Interrupt only where the human's judgment has leverage.** A gate earns its
   interruption when a *different* human answer would change the outcome or
   expose a wrong model. If you already know the answer and the human's call
   can't move anything material, state it and proceed — never gate busywork.
   Interruption without leverage just trains rubber-stamping. The depth gate
   (§2) sets how many *discretionary* gates fire beyond the irreducible ones;
   the human can dial it down mid-session at any time.
6. **Keep the phase plan visible.** Maintain the phases as a live task list,
   updated as each opens and closes — the human must always see where in the arc
   they are.
7. **Mark every "your turn" moment.** Lead any request for human action with an
   unmissable cue (e.g. 🟡) naming what's asked — never bury the handoff in prose.
8. **Keep prose short and scannable.** Especially right before asking the human
   to produce — never make them climb a word wall to reach the ask.
9. **Prefer bottom-up questions over top-down prose for closed choices** — short
   questions pull the human's view out. **But never reduce a produce-or-defend
   moment to a menu** (Phase 0 verdict, Pause defenses, outcome-calls stay prose):
   a menu there hands the human your framing instead of pulling out theirs.
10. **A gate isn't closed until its §7 line is appended.** Treat the log write as
   part of the gate ritual, not an afterthought — if it wasn't logged, the gate
   isn't done.

## 2. Depth gate (first interaction)

Before anything, ask the human to choose **adversarial depth: full / light /
none.** Do **not** auto-classify — that is the AI deciding, which offloads.
Surface facts to inform their pick, then let them choose:

- priority label (P0/P1/P2)
- estimated LOC / files touched
- **core/adapter (logic-dense) vs view-only (thin)**
- is the design already settled (was it feature-tortured)?

Depth controls **interruption density** — how many *discretionary* produce-or-
defend gates fire beyond the irreducible ones (Phase 0 verdict, Pause A
decision, Phase 4 verify, Pause B defense always run):

- `none` → only the irreducible gates; everything else proceeds with an
  announcement, no produce-or-defend.
- `light` → irreducible gates plus discretionary gates only on the
  *highest-leverage* claims.
- `full` → discretionary gates fire wherever the human's judgment has leverage
  (§1.5).

The human can re-dial depth mid-session — "too many interruptions, drop to
light" is always a valid override.

## 3. The phases

```text
PHASE          DEBT     LEADS   GATE             CORE MOVE
0 Frame        intent   HUMAN   prose (async ok) human commits verdict/cause → AI attacks
1 Isolate      tech     AI      cheap (confirm)  tidy-first seam + test data + related docs
2 Drive tests  tech     MIXED   cheap per-test   §5 loop: call outcome → RED → GREEN → tidy → REFLECT
   ── PAUSE A ──         —       prose            facts-only, human decides
3 Implement    tech     AI      —                harness-guarded
4 Verify       tech     HUMAN   —                run/screenshot the un-unit-testable part
5 Prove        tech     AI      —                coverage + mutation (survivor → reopen P2)
   ── PAUSE B ──         cogn    prose            human defends final shape
6 Close        intent   MIXED   —                adversarial review + CUPID + retention pass (§6)
```

**Non-code issues.** When there's no testable seam (docs, config, a prose spec),
phases 1–5 collapse to *draft → review*; Phase 0, Phase 6, the pauses, and the
spine still run.

**Phase 0 — Frame (intent).** Verify the human is assigned; if not, stop and
surface it rather than proceeding. Branch:

- *Enhancement* → **inverted feature-torture**: the human writes a one-line
  verdict (ship / reshape / park / kill + scope); the AI attacks it. Output =
  the hardened scope, posted as the **issue comment before any build** (a public
  scope commitment, not a root-cause note).
- *Bug* → the human states the **suspected root cause first**; the AI confirms
  or refutes; the agreed root cause + intended fix is posted as the issue
  comment (the original "tell the reporter" intent).

After Phase 0 clears, draft the **cognitive/intent note** (`docs/notes/
issue-<slug>.typ` or the project's notes home) — *after* the go/no-go, never
before, so a killed approach wastes no artifact. A *kill* verdict ends the
protocol here. Finalize the note at Phase 6.

**Phase 1 — Isolate (tech, AI-led).** Tidy-first: find the testable seam, pull
domain logic out of untestable layers (GUI, I/O). Extract test data from the
issue and from real project data. Find related docs. Confirm the seam with a
cheap gate.

**Phase 2 — Drive tests.** Run the §5 loop, **one test at a time** — never
"write the whole suite then pause once." Gate only **high-leverage** tests by
having the human call the expected outcome first; write the obvious ones
silently. Use property-based tests where the rule is total/shape-driven.

**Pause A.** Present a **facts-only** summary (+ the strongest case for each
option; state no preference until the human commits). Mandatory human decision.

**Phase 3 — Implement (tech, AI).** Harness-guarded; ugly-then-tidy.

**Phase 4 — Verify (human).** Run / screenshot / snapshot the part automated
tests cannot reach — the actual user-visible deliverable (e.g. a button). This phase
exists because the testable core is often tiny and the deliverable often isn't.
Before asking the human to run, make sure you both share one model of **which
build is live and how to reach it** — state the exact path and command, and
confirm they're exercising the code we just changed, not a stale or parallel
copy. A mismatch here is a lost-shared-model (cognitive) failure, not just a
technical one.

**Phase 5 — Prove (tech, AI).** Coverage on the changed lines, then mutation
testing. A **surviving mutant reopens Phase 2** (it is a missing test, looped
back), not a footnote.

**Pause B.** The human **defends the final shape** in prose.

**Phase 6 — Close (intent).** Adversarial self-review; CUPID refactor of the
modified methods (readability, tech/business naming separation, lower
complexity). Finalize the cognitive/intent note, then run the **retention pass**
(§6): a visual before→after recap and the novelty ledger.

## 4. Async gates — continue / park, AI-gated, biased to interrupt *where it has leverage*

Two async modes, chosen per gate by the AI. Park where the human's judgment has
leverage (§1.5); continue through independent, reversible work. Interruption is a
tool for forcing thought, **not** a goal in itself:

- **▶️ continue (A)** — proceed on clearly-independent, reversible work; the
  human answers inline. **Always capped** by a park-style bound so "continue"
  can't drift into "guessed the whole build."
- **⏸️ park (D)** — declare "I'll do X, then stop"; if no answer by then,
  **park, never guess.**

```text
At each async gate:
  high-leverage decision (intent / contract / adversarial)? ─► ⏸️ park (bounded)
  clearly independent + reversible work exists?             ─► ▶️ continue (capped)
  uncertain?                                                ─► ⏸️ park (interrupt)
```

Announce the chosen mode every time with its marker — ▶️ "continuing on X —
independent" / ⏸️ "I'll pause here until you answer" — never a bare letter. The
announcement is the human's override point.

> Mode B (handoff file) is deliberately excluded — this protocol wants live
> interruption *where it has leverage*, not interruption for its own sake.

## 5. The test loop

The per-cycle loop the batch-all-tests style loses:

```text
RED      smallest failing test that names the behaviour. Present it
         Given/When/Then with the Then (expected outcome) left blank; the
         human fills the assertion first, then write the test; confirm it
         fails for the right reason (not a typo/import).
GREEN    least code to pass. Ugly is fine. Don't generalise.
REFACTOR clean up; tests green between keystrokes; commit the tidy separately.
REFLECT  together: what did this cycle teach? what surprised us? is the next
         test still right? any domain rule worth pinning separately?
         Update the list. Loop.
```

**Calibrate the outcome-call.** Blanking the Then should feel like committing a
position to be attacked, not a quiz — leave it blank only for high-leverage tests
where a wrong answer exposes a wrong model. Fill the obvious ones silently.

Reflect is short, updates the *plan* not the code, and runs even after a
no-refactor cycle. Emergence must happen in the **human's** head — that is why
the human fills the expected outcome of each high-leverage test before the AI
writes it.

## 6. Retention (post-process, never planted)

Engagement is forced *in-process* by the produce-before-reveal spine (§1.1) and
the outcome-calls (§5) — not by deceiving the human. Memory is consolidated
*after* the work, with two artifacts run at Phase 6 Close:

- **Visual recap.** An explained tour of what changed and *why* — each
  modification and the architecture decision behind it, rendered as before→after
  diagrams and diff-coloured blocks (`diff`-fenced, red/green `+`/`-` lines) so
  the shape is remembered, not just the patch. Open it by inviting the human to
  narrate the before→after in one line, then render the rich version. One
  worthwhile consolidation moment, not a wall.
- **Novelty ledger.** Append what was genuinely *new this session* — a pattern,
  an API, an architecture move, a technology used in an unfamiliar way — to
  `.personal/pair-with-me/novelties.md`. One entry: what it was, why it mattered,
  a pointer to where it lives. Emit now, exploit later (spaced review, exercises,
  a periodic summary); build no review tooling yet — the same "store later" call
  as §7.

**Why no planted errors.** Earlier versions planted a deliberately wrong claim
to test whether the human was reasoning. Removed: a corrected falsehood still
biases memory (the continued-influence effect), so a mechanism meant to *reduce*
cognitive debt could quietly *add* it — a false "why" lodged as a real one. The
spine forces engagement honestly; retention is served by recall, not deception.

## 7. Measurement hooks (emit now, store later)

Append **one JSONL line per gate** to `.personal/pair-with-me/<issue>.jsonl`.
Build **no** aggregation yet — "store later" defers the *analysis*, not the
capture (one append is nearly free). Data must fall out of the gate, never a
separate questionnaire. Emit at the close of Phase 0, Pause A, Pause B, and
Phase 6 — the gate isn't done until the line lands (§1.10).

Event shape:

```json
{ "ts": "", "issue": "", "gate": "", "type": "outcome|approach",
  "called": "", "actual": "", "diverged": false }
```

- **`diverged`** captures *override* — the P0 signal of retained judgment.
  `type: outcome` = your called outcome ≠ the reveal; `type: approach` = you
  changed what the AI proposed (the stronger grade).
- **Skip latency in v1** — wall-clock is noisy under async, self-report
  unreliable.
- Read these as **trend, not absolute**. If `diverged` trends to `false`,
  cognitive debt is winning regardless of how good the artifacts look.

## 8. Decision log (why it is shaped this way)

- **One process**, branching at Phase 0 (bug vs enhancement).
- **Gate only high-leverage tests** in Phase 2; write the rest silently.
- **Async = continue + park**, AI-gated, biased to park *where the judgment has
  leverage*; handoff-file mode excluded; continue always capped.
- **No deceptive probes** — retention is post-process (visual recap + novelty
  ledger), never a planted falsehood.
- Harness strength is **inherited from `AGENTS.md` / `CODING_STANDARDS.md`** — no
  separate rule.
- **Depth asked, never auto-classified** — it dials interruption density.
- Skill name is a **verb-shaped pairing** invocation: `pair-with-me`.
- **No canned recommendation trigger** — close with a natural offer instead.

Added from session feedback:

- **Phase plan kept visible** (§1.6) — process legibility was the top reported miss.
- **Async mode in plain words + ▶️/⏸️ markers** (§1.4, §4) — a bare `D` was unreadable.
- **"Your turn" carries a 🟡 marker** (§1.7) — handoffs were missable in prose.
- **Prose kept short; bottom-up questions preferred** (§1.8–9) — word walls taxed
  focus; questions invite production, while produce/defend moments stay prose.
- **Outcome-call calibrated** (§5) — fewer, higher-stakes; Given/When/Then with
  the Then left blank, in standard test vocab.
- **Pre-run shared model** (Phase 4) — confirm the human runs the build we changed,
  stated path + command; mismatch is cognitive, not just technical.
- **Gates aren't closed until logged** (§1.10, §7) — measurement was the first
  thing forgotten in practice, so the log write is now part of the gate ritual.
- **Non-code path + Phase 0 off-ramp** (§3) — the protocol assumed test-drivable
  code and had no exit for unassigned/killed work; both now explicit.
- **Probes removed; retention moved post-process** (§6) — planted errors risked
  the continued-influence effect (a corrected falsehood still biases memory), so
  the mechanism could *add* the cognitive debt it meant to cut. Replaced by a
  visual before→after recap and a novelty ledger for spaced review.
- **Interruption is leverage-gated, not maximised** (§1.5, §2, §4) — low-stakes
  gates where the AI plainly knew the answer read as busywork and trained rubber-
  stamping. Depth now dials interruption density and is re-dialable mid-session.
