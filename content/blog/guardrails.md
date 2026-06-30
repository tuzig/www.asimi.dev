---
title: "The Gurdrails Trapezoid"
date: 2026-01-09T08:43:05+02:00
description: ""
tags: []
draft: true
---

I've been talking to quite a few smart tech leaders in fast growing startup and
they're all facing the same challenge.
They know they should use coding agents better but there's a blocker - 
their project has poor test coverage.
In the rush to MVP testing infrastructure is always neglected and technical debt accumulates, turning into code swamps.

In the world of coding agents tests turn into guardrails that minimize the blast radius of models' follies.
Given tests we can hard code guardrails hooks that validate generated code.
Guardrails are one honking great idea and we always needs more of those.

To keep the free flow of new guardrails we need to organize them all.
This reminded me of the Test Pyramid from Mike Cohn back in 2009.
Martin Fowler then popularized and refined the concept.
It set the stage for teams to move away from slow,
manual-heavy testing toward efficient automation.

At its core, the pyramid is a strategy for creating a **balanced test
portfolio**. It argues that not all tests are created equal. A good test suite
should be structured to maximize speed and reliability while minimizing cost.

At the bottom of the pyramid are unit tests.
They cover the smallest units of code, they're fast and focused.
At the top are the end-to-end tests requiring staged services and data fixtures. They are expensive to setup and slow and they cover the entire flow.

The middle of the pyramid is murky.
The middle is where projects differ and tests there come in many names.
I've seen: system, integration, functional, contract and more.
For example, in a micro-services architecture, per-service contract tests 
are key.

I've been using the pyramid in consulting projects for the past decade and its
been great. It helped me come up with a simple tests inventory every dev can understand.
It also raise three important questions:

- Is the base wide enough?
- What do we want for the middle?
- What do we have at the top?

When the project's pyramid is done choosing which test to write becomes easy.

It's been working great but there's one thing that irks me is the apex. 
It's not there.
There are always some end-to-end tests. 
Even in the worst case scenario, there are manual testing scripts ran by QA engineers.


## The Guardrails Trapezoid

Guardrails are tests and more. 
They are hard coded hooks and workflow stages that verify models' response.
They can be as simple as as linter or as complex as an end-to-end test.

Fowler emphasizes two main rules when applying this model
(and I replaced tests and pyramids):

1. **Write guardrails with different granularity:** Use the right tool for the job. Don't use a slow UI test to check basic logic that could be verified in a unit test.
2. **The higher the level, the fewer guardrails you should have:** As you move up the trapezoid, the cost and maintenance effort increase. You want a broad base of unit tests and only a few critical "smoke tests" at the UI level.

Regarding 2, Fowler later added:

> The pyramid is based on the assumption that broad-stack tests are expensive,
> slow, and brittle... If your high-level tests are fast, reliable, and cheap to
> modify—then lower-level tests aren't as vital."

I believe he took it too far.
We need many guardrails and of different kinds and the trapezoid is great for that.

And once you've figured out what makes the middle it's just implementation. 

