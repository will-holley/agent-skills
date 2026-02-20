---
name: repo-readiness-report
description: Run Factory's repository readiness report for newly set up repositories. Use when a user says a new repo was created, initialized, or set up and wants an initial readiness check.
---

# Repo Readiness Report

Run a readiness check immediately after repository setup.

## Workflow

1. Ensure the working directory is the target repository root.
2. Check whether `droid` is installed with `command -v droid`.
3. If `droid` is not installed, install it:
   - `curl -fsSL https://app.factory.ai/cli | sh`
4. Run the readiness check:
   - `droid "/readiness-report"`
5. Return the readiness-report output summary to the user and highlight blocking issues first.
