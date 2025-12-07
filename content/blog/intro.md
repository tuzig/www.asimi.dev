+++
title = 'Introducing Asimi'
date = 2025-12-07T12:41:42+02:00
draft = false
+++

I'm developing Asimi, a coding agent for the terminal because all the rest fight against 30 years of terminal conventions and DevOps best practices.

Claude Code (CC) and its clones are a wonder. 
It grew on me and changed the way I program.
I stopped writing code and I let it code for me.
After over 40 years, programming changed, no longer writing code but planning, monitoring and reviewing.

It allows me to work faster than ever before and in some sessions I get 10X velocity.
But the more I use it the more its thorns are pricking me. 

The biggest one is the broken permissions and the `--dangerously-skip-permissions` bypass.
I refuse to follow the herd and hide it with an alias.
Every time I run CC I type it myself and it takes its toll.

Good tools should never have this option nor the "you only live once" mode.
It removes all responsibility from the tool developer and which leads to bad practices.

Another big thorn is the quirky UI.
Mouse based scrolling? Slash commands? 
I've been developing in terminal since 1989 and it was and still is CTRL-B/F and the colon.

I've been using the vi/vim/neovim interface for over 30 years and it's all there.
CC, codex, gemini-cli, qwen, opencode and the rest are reinventing wheels.
We just need to stretch the vim interface a bit and get that muscle memory back to work.

Another thorn is CC being unopinionated, making me curate the right 
opinions in the form of roles, skills and custom commands.
I understand their reason for it – they're an AI company and not
a devtools one – but that's not what I need.
I need a tool that works out of the box and for that it requires strong opinions. 

Here are some more thorns whose pain have been driving me to develop Asimi:

- flickering screen - My eyes are my most important tool
- Single provider support - Whenever there's a new SOTA release I have to change my tool
- JSON-based config - Config files need comments and a format that's easy to write
- popups and modals - This is one complication TUIs can do without

Don't get me wrong, CC still does an amazing job, but it's a prototype.
As the market evolves, open source, opinionanted, multi-provider agents will replace
the prototypes. It's the only way for the devs to get the experience they deserve.

## What's in 0.2.1?

Asimi has been eating its own dog food since version 0.1.0, well over a month now, and it rarely breaks. 
I use my Claude Pro/Max license and openrouter account as a fallback. 
I've tested Asimi with Kimi, Qwen3, GPT-5.1 and more and while they work for heavy work I rely Anthropic top end models.

I managed to squeeze in quite a bit for the first public release.
The vi interface is in with six modes: Insert, Normal and Command are vim compatible. 
No more `/`, just good old `:` and your fingers stay on the home row where they belong.
We also added a Scroll mode - Just hit CTRL-B and forget the mouse. For selecting sessions and models we added
a Select mode. Lastly, we've added Help, in case you get stuck.

The sandbox is working beautifully 🪬🪬🪬 Podman runs the agent's shell in its own container, so the model's blast radius is limited to the mapped project directory. You can use configuration to map additional directories which I used for
Asimi's langchaingo fork. The config let's you set a list of commands that can only run on the host - like `gh`.

The `:init` command sets up a Dockerfile and a Justfile to get you started. 
After years of looking for a place for projects' scripts, a Justfile is a blessing.
Use `just -l` to check the recipes asimi prepare for you and feel free to append your own.

Multiple providers are supported out of the box. Ollama for local models, Claude Pro/Max for Anthropic fans, and any OpenAI API v1 compatible service like OpenRouter. Switch models, keep your workflow.

Session management lets you pick up where you left off with `:resume`, and `:context` tries to show you exactly how many tokens you're burning. 
History is saved in a user's sqlite file in `~/.local/share/asimi/asimi.sqlite`.

All config lives in `.agents/` using TOML.

## What's on the drawing board?

The thing I most looking for is adding [sub-agents and roles](https://github.com/afittestide/asimi-cli/issues/24).
It will make Asimi better by splitting the work & responsibility. 
I've been following the work done by BMAD and other and I'm itching to try my theory.

The thing Asimi most needs is MCP support. 
With MCPs security is a big challenge and a fundamental design questions.
If you'd like to help here's the [issue](https://github.com/afittestide/asimi-cli/issues/56).

We've've been spending a lot of cycles  about Asimi's roles and play book 
Next up is [MCP support](https://github.com/afittestide/asimi-cli/issues/56) for the Model Context Protocol –
because standards matter.
Then comes [sub-agents and roles](https://github.com/afittestide/asimi-cli/issues/24) so you can delegate tasks to specialized agents with an orchestrator keeping things sane.

Got ideas? [Join the discussion](https://github.com/afittestide/asimi-cli/discussions) and let's talk.

## Try it

Ready to try it? Check out the [quick start](/#install). Asimi should work with your ollama, openrouter account or Claude Pro/Max subscription.


