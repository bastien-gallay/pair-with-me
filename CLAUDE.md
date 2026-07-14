# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A single-skill repository. It packages **one** Claude Code skill — `pair-with-me`
— and nothing else. There is no application, no build, no test suite. The
"product" is the protocol prose itself: `SKILL.md` is the deliverable, and the
other files exist only to install, lint, and iterate on it.

## Files that matter

- **`skills/pair-with-me/SKILL.md`** — the canonical protocol and the only file with real content.
  YAML frontmatter (`name`, `description`) drives skill discovery/triggering; the
  body is the protocol Claude executes when invoked. Editing this file *is* the
  work. It is structured as numbered sections §0–§8 (the one idea → always-on
  directives → depth gate → phases → async gates → test loop → probes →
  measurement → decision log); cross-references like "§1.10" or "§6" are load-
  bearing — keep them consistent when you move content.
- **`README.md`** — human-facing summary; must stay in sync with `SKILL.md`'s
  spine but is not itself executed.
- **`install.sh`** — symlinks (default) or copies the repo into
  `~/.claude/skills/pair-with-me`. Symlink is the intended mode so edits to
  `SKILL.md` propagate live without reinstalling.
- **`FEEDBACK.md`** — append-only intake for raw session notes, newest first,
  above the `<!-- No open feedback -->` sentinel.
- **`feedback/`** — archived feedback batches as `YYYY-MM-DD-reviewed.md`, written
  *after* a batch has been folded into `SKILL.md`.

## The iteration loop (this repo's actual workflow)

This repo is improved by dogfooding the skill, then folding what's learned back
into the protocol:

1. Real sessions surface friction → capture verbatim in `FEEDBACK.md`.
2. Fold the change into `SKILL.md` (usually a new always-on directive in §1 or a
   phase tweak in §3), then add a one-line entry under §8 "Added from session
   feedback" explaining *why*.
3. Move the consumed notes from `FEEDBACK.md` into `feedback/<date>-reviewed.md`.

§8 is the decision log — when you change protocol behaviour, record the rationale
there rather than letting the reasoning live only in git history.

## Conventions

- **Markdown is linted with markdownlint** against `.markdownlint.jsonc`. Two
  rules are deliberately disabled: `MD013` (line length — prose hard-wraps at 80
  but the ASCII phase/loop tables run wider on purpose) and `MD033` (inline HTML
  — the `<issue>` / `<slug>` / `<n>` placeholders trip it). Keep prose wrapped at
  ~80 columns to match the existing style; let the tables run wide.
- `.impeccable/` is gitignored (local tooling artifacts), as is `.DS_Store`.
