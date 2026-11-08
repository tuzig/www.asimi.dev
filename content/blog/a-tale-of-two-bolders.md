---
title: "A tale of two infrastructures"
date: 2026-11-08T08:30:04+02:00
description: "A tale of Asimi's first two partner projects"
author: 'Benny Daon'
tags: ["field-notes"]
---

When I set out to develop Asimi I wanted a tool for 
mature startups where the years of moving fast and breaking things took their toll.
Some call it technical debt, some, like Uncle Bob Martin, software rot.
I came to think of it as the software swamps.

## Entering the swamps
Asimi's first two design partners' projects are very different, and yet, both ran into the same boulder.
The first, a 15-year-old Ruby on Rails (RoR) backend of a financial services app.
The second, a 3-month-old Django-based AI pipeline coded using agents.

Both have lots of tests and both got asimi stuck in the guardrails.
In one cases completly failing to deliver and in the other slowing to a crawl.

## The Common Bolder
As part of the project-init ritual (= workflow),
the Forge (工部) collects all the scripts as recipes into a `./Justfile`.
In addition to the collected script, the generated Justfile
creates some mandatory recipes Asimi uses in its rituals:

- `just lint`
- `just test`
- `just run`
- `just install`
- `just build-sandbox`
- ...

In both projects, `just test` was too slow -
it took over 11 minutes in the older project and over 5 in the younger.
Asimi is especially susceptible to this, as the tests also run
as a hard-coded guardrail for every change.

## Falling into 20-year-old rot in a 3-month-old project

We're not the first to hit test-performance problems.
The solution is called Regression Test Selection (RTS) and it's about running only the tests that cover the changed lines.
Python already has a great tool for that
[pytest-testmon](https://github.com/tarpas/pytest-testmon) but
we couldn't use it.

The agents wrote over 2,600 tests and all of them
using the arcane framework - `unittest`.
The tool we needed is for `pytest` - like all modern Python testing tools.

Python's `unittest` module started in the last millennium and has been
part of the standard library since Python 2.1 in 2001.
It's a port of JUnit, which is itself a port of Smalltalk's SUnit, and it's not Pythonic.
I do remember using it, but that was well over a decade ago.

`pytest` is better and has an ecosystem of plugins and tools.
Somehow, the agents missed it and went for deprecated framework.
The mistake was probably made once and has been propagating since.

Together with the partner we agreed the tests have to go.
They will be replaced by new tests using a new testing architecture.
I'm working with Asimi's Judge (刑部) and partner to adapt
the test pyramid to our case - an AI workflow.

## Where is my crystal ball?

In the Ruby On Rails project we also a tool we can use
- Crystalball.
Again, our testing framework is wrong.
Ruby has RSpec and minitest as testing frameworks and
Crystalball is for RSpec while the project uses minitest.

Here we won't rewrite the tests as `minitest` is a legitimate
framework (or at least as legitimate as RSpec).
Instead we've developed our own Crystalball for `minitest`, following
[Crystalball](https://github.com/toptal/crystalball)'s approach - a pretty simple tool
that took a couple of iterations to get right.

## Closing thoughts

I was spoiled, working on a Go project and its fast tools.
In Ruby and Python the basic tools are painfully slow.
This pain made me understand why [DHH buried his Rails creation](https://youtu.be/vDjW_dRyKXY?si=crrNG3sfQmEZovAe) .
Interpreted languages are wrong for agents.

The good news is that once a Django/RoR project has good black-box tests,
rewriting the implementation is doable.
