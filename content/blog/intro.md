+++
title = 'Introducing Asimi'
date = 2025-12-07T12:41:42+02:00
draft = false
author = 'Benny Daon'
+++

Once upon a time, startups lived in blue or red oceans. Most are still there,
but the tsunami of LLMs is turning all markets into whitewater rapids. At the
front of that tsunami sits the developer-tools market, where the pace of change
is seven times faster than it was two years ago.

Developers have already udapted and are used to trying new tools and happy to live on
the edge. In the previous millennium, we'd call the tools we have today *alpha version*: a
version whose interface wasn’t quite settled. Today we all use alpha versions.

And these alphas are ridiculously powerful. There are days when I finish seven
or eight days’ worth of work in a single day. Days that end with me collapsed
on the couch, happy that I’ve finally ran out of tokens. There’s no doubt that
coding agents are on a completely different level from any tools I’ve seen in
the last thirty years.

It completly changed the way I program - it’s been three months since I last
wrote code myself. I design, supervise, and
review—but I leave the actual coding to the agent. **Read Only Programming.**

From Atari BASIC all the way to today’s Python and Go, programming stayed
fundamentally the same. Not anymore. This is a totally new era, and I find
myself thinking a lot about how I’ll be programming five years from now. I’m
pretty sure the agent I’ll use will be open source and model-provider-agnostic. I’m
also pretty sure it will come with a structured methodology, helping me
keep things clean and orderly. It’ll likely use a model based on open weights
that deeply understands my style and my projects.

Until that rosy future arrives, I had to use the prototypes available today.
Don’t get me wrong—they’re very powerful. But safe? To get the most out of
them, I need to run them in "You Only Live Once" mode. Claude Code calls this
`--dangerously-skip-permissions`. And on top of that, the interface was
designed by web developers who have never written a vim macro. They reinvented
an interface instead of adapting one that has served us beautifully for 50
years.

I no longer have to suffer as in the last six weeks, I’m using an agent I built
myself, **Asimi**. I use it mostly to develop itself and it's much better.
It's written in Go and open source, and currently runs only in the terminal.
Its `vi` inspired interface lets me use the same
commands I learned from vi back in the Unix V.2 days. I don’t need a mouse to
navigate, I use `:` to enter commands and more.

I’m also less worried about host access as Asimi comes with a sandbox.
With Asimi, the LLM commands run in an isolated OS with no access to the host
OS. It’s not that I solved the problem—LLM security is an endless process and
there’s always room to improve.

Besides that, Asimi is *fast*. I’m writing it in Go and using the podman and
git libraries to avoid spawning processes. In my measurements, Asimi
adds ~5ms overhead when running a command, compared to roughly 200ms in
Claude Code.

Asimi version 0.2.1 can connect to a local LLM, an Anthropic account, and
OpenRouter. The init command generates a Justfile and a Dockerfile for the
sandbox.

## Try it

Ready to try it? Check out the [quick start](/#install).



