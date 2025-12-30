+++
title = "What's in a coding agent harness?"
date = 2025-12-30T10:45:20+02:00
description = "A comparison of tools available in coding agents like Claude-Code, Codex, Cursor, Gemini, OpenCode, and Asimi"
draft = false
author = 'Benny Daon'
+++

Asimi version 0.4.0 is out and I've got time to post.
This one comes following a discussion about coding agents in one of the WhatsApp groups.
People didn't believe me they're that simple.

A "harness" is the collection of tools around an LLM that turns it into an agent that let it actually *do* things rather than just chat.

Coders need very few tools.
[Codex](https://github.com/openai/codex), the leanest of the agents, doesn't even have a tool for reading a file.
Instead it's doing what programmers did in the early 70s, when there were no vi and no display.
They used teletypewriters — a keyboard and a printer — and `ed` was their only tool.
To print lines they used `1,23p`. Today, ed has been reincarnated as sed, and Codex is using it
to read files just like Ken Thompson did back in the '70s. This approach saves tokens and keeps the tool interface minimal.

I've used the following prompt to ask [Codex](https://github.com/openai/codex), [Claude Code](https://docs.anthropic.com/en/docs/claude-code), [Cursor](https://www.cursor.com/), [Gemini CLI](https://github.com/google-gemini/gemini-cli), [OpenCode](https://github.com/opencode-ai/opencode) and Asimi.
If you have MCPs configured they should appear in the output as weel.

> Please help me better understand the harness of the coding agents we're using. What tools are available to you in this session? 


## Summary Comparison Table

<div class="wide-table">

| Tool Category | Capability | Claude Code | Codex | Cursor | Gemini | OpenCode | Asimi |
|---------------|------------|:-----------:|:-----:|:------:|:------:|:--------:|:-----:|
| **File Ops** | Read File | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| | Read Many Files | ✗ | ✗ | ✗ | ✗ | ✗ | ✓ |
| | Write File | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| | Edit/Replace | ✓ | ✓ (patch) | ✓ (patch) | ✓ | ✓ | ✓ |
| | List Directory | ✗ | ✗ | ✓ | ✓ | ✗ | ✓ |
| | Glob (find files) | ✓ | ✗ | ✓ | ✓ | ✓ | ✗ |
| | Grep | ✓ | ✗ | ✓ | ✓ | ✓ | ✗ |
| | Notebook Edit | ✓ | ✗ | ✓ | ✗ | ✗ | ✗ |
| **Shell** | Run Commands | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| | Kill Process | ✓ | ✗ | ✗ | ✗ | ✗ | ✗ |
| **Web** | Fetch URL | ✓ | ✗ | ✗ | ✓ | ✓ | ✗ |
| | Web Search | ✓ | ✗ | ✓ | ✓ | ✗ | ✗ |
| **Agents** | Sub-agents/Tasks | ✓ | ✗ | ✗ | ✓ | ✓ | ✗ |
| | Todo/Plan Tracking | ✓ | ✓ | ✓ | ✗ | ✓ | ✗ |
| **Memory** | Save Memory/Context | ✗ | ✗ | ✓ | ✓ | ✗ | ✗ |
| **Interaction** | Ask User Questions | ✓ | ✗ | ✗ | ✗ | ✗ | ✗ |
| | Plan Mode | ✓ | ✗ | ✗ | ✗ | ✗ | ✗ |
| **Special** | View Images | ✓ | ✓ | ✓ | ✗ | ✗ | ✗ |
| | Skills/Commands | ✓ | ✗ | ✗ | ✗ | ✓ | ✗ |
| | Parallel Execution | ✗ | ✓ | ✗ | ✗ | ✗ | ✗ |
| **Total** | **Tool Count** | 15 | 7 | 14 | 11 | 10 | 6 |

</div>

