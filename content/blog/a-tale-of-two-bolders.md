---
title: "Field Note: A tale of two infrastructures bolders"
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
Asimi's first two design partners' projects are very different, and yet, both ran into the same wall.
The first, a 15-year-old Ruby on Rails (RoR) backend of a financial services app.
The second, a 3-month-old Django-based AI pipeline coded using agents.

Both have lots of tests which make asimi's guardrails crawl.

## The Common Bolder

Every asimi edict (AKA issue) is implemented using the swift-strike ritual.
In this ritual the judging step has a line: `given: !just test`.
This runs the just command which then reads the Justfile and runs the recipe.

In both projects, `just test` was too slow -
over 11 minutes in the older project and over 5 in the younger.
The ritual where taking too long and clearing this became the first priority.

## Caching it

One annoying thing the models are doing is piping the expensive output to
a `tail` commands. That's find, unless they came up short.
So they run the tests again and again.

A quick fix for this was to cache the output and let the model know where
it is. 
In a couple of the existing skills the models was directed to saving test 
output to test.out. It didn't always work and added unnecessary load on 
the model. Here's how we did it in the Django project:
```
now := `date +%Y%m%dT%H%M%S`
# Run the test suite > `./heaven/tests/test-<datetime>.out`
test:
    #!/usr/bin/env bash
    set -euo pipefail
    export outfile="heaven/tests/test-{{now}}.out"
    mkdir -p $(dirname $outfile) 
    echo ">>> storing test output to $outfile"
    uv run manage.py test 2>&1 | tee $outfile
    echo "<<< test output stored to $outfile"
```

This recipe pipes the output through the `tee` command.
`tee` displays its input on screen while also saving it to a file.
We've also added a header and footer line to communicate with the agent.

Now, when the agent pipes to a `tail` and needs more lines, the last
line tells it where to find it.
It works well and now tests run only once. This is nice,
but we have to do better. A <20 seconds test will free the CPU to
run more tasks in parallel and finish them faster.

## Falling into 20-year-old rot in a 3-month-old project

We're not the first to hit test-performance problems.
It's an age old problem and the solution is called Regression Test Selection (RTS).
It's about running only the tests that cover the changed lines.
Python already has a great tool for that
[pytest-testmon](https://github.com/tarpas/pytest-testmon).

Our project could use it. Their coding agents wrote over 2,600 tests and all of them
using the archaic framework - `unittest`.
The tool we needed is for `pytest` - like all modern Python testing tools.

Python's `unittest` module started in the last millennium and has been
part of the standard library since Python 2.1 in 2001.
It's a port of JUnit, which is itself a port of Smalltalk's SUnit, and it's not Pythonic.
I do remember using it before pytest came along (and the node test runner - RIP)
and it was painful.

`pytest` is flatter & better and has an ecosystem of plugins and tools.
Somehow, the agents missed it and went for deprecated framework.
The mistake was probably made once and has been propagating since.

Together with the partner we agreed the tests have to go.
They will be replaced by new tests using a new testing architecture.
I'm working with Asimi's Judge (刑部) and partner to adapt
the test pyramid to our case - an AI workflow - and rewrite all the tests.

## Where is my crystal ball?

For the Ruby On Rails project there's also a tool we can't use
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
As we dry the swamps, speeding very slow tests is the top priority.

Without it, every change and every fix will be slower to implement.
