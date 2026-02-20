---
name: domain-name-search
description: Find and evaluate candidate domain names for projects, products, and brands. Use when a user asks for domain brainstorming, availability checks, or shortlists of purchasable domains.
---

# Domain Name Search

Generate concise, brand-fit domain candidates, then validate purchasability with Instant Domain Search.

## Workflow

1. Gather constraints: topic, style (professional/playful), TLD preferences, and hard exclusions.
2. Produce candidate domains that are easy to spell, pronounce, and remember.
3. For each candidate host, check purchasability at:
   - `https://instantdomainsearch.com/?q=<host>`
4. Capture relevant alternatives shown for that query (for example: close spellings, other TLDs, or suggested similar names) and keep the strongest options.
5. Keep only candidates and alternatives that appear purchasable based on that page unless the user asks to also show unavailable names.
6. Return a shortlist with:
   - Domain
   - Status: `Purchasable` or `Not purchasable`
   - Source: `Queried` or `Instant Domain Search alternative`
   - One-line naming rationale

## Output Style

- Prefer `.com` when available unless the user requests specific TLDs.
- Avoid trademark-like strings, hyphen-heavy names, and confusing spellings.
- Present final recommendations in a compact table.
- When the queried domain is unavailable, always present alternatives returned by Instant Domain Search before adding purely invented fallbacks.
