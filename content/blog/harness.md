+++
title = "What's in a coder harness?"
date = 2025-12-29T15:45:20+02:00
description = ""
draft = false
author = 'Benny Daon'
+++

Asimi version 0.4.0 is out and I've got time to post.
This ones comes following a discussion about coding agents in one of the whatsapp groups.
People didn't believe me they're that simple.

Coders need very few tools.
Codex, the leanest of the agents, doesn't even have a tool for reading a file.
Instead he's doing what programmers did in the early 70s, when there where no vi and no display.
The used teletypewriters - a keyboard and a printer - and `ed` was their only tool.
To print lines they used `1,23p`. Today, ed has been reincarnated as sed, and codex is using it
to read file just like Ken Thompson did back in the '70s

I've used the following prompt to ask codex, claude-code, gemini, opencode and Asimi for:

> Please help me better understand the harness of this coding agents we're  using. What tools are available to you in this session? 


## Summary Comparison Table

| Tool Category | Capability | Claude-Code | Codex | Gemini | OpenCode | Asimi |
|---------------|------------|:-----------:|:-----:|:------:|:--------:|:-----:|
| **File Ops** | Read File | ✓ | ✓ | ✓ | ✓ | ✓ |
| | Read Many Files | ✗ | ✗ | ✗ | ✗ | ✓ |
| | Write File | ✓ | ✓ | ✓ | ✓ | ✓ |
| | Edit/Replace | ✓ | ✓ (patch) | ✓ | ✓ | ✓ |
| | List Directory | ✗ | ✗ | ✓ | ✗ | ✓ |
| | Glob (find files) | ✓ | ✗ | ✓ | ✓ | ✗ |
| | Grep (search content) | ✓ | ✗ | ✓ | ✓ | ✗ |
| | Notebook Edit | ✓ | ✗ | ✗ | ✗ | ✗ |
| **Shell** | Run Commands | ✓ | ✓ | ✓ | ✓ | ✓ |
| | Kill Process | ✓ | ✗ | ✗ | ✗ | ✗ |
| **Web** | Fetch URL | ✓ | ✗ | ✓ | ✓ | ✗ |
| | Web Search | ✓ | ✗ | ✓ | ✗ | ✗ |
| | Browser Automation | ✗ | ✗ | ✓ | ✗ | ✗ |
| **Agents** | Sub-agents/Tasks | ✓ | ✗ | ✓ | ✓ | ✗ |
| | Todo/Plan Tracking | ✓ | ✓ | ✗ | ✓ | ✗ |
| **Memory** | Save Memory/Context | ✗ | ✗ | ✓ | ✗ | ✗ |
| **Interaction** | Ask User Questions | ✓ | ✗ | ✗ | ✗ | ✗ |
| | Plan Mode | ✓ | ✗ | ✗ | ✗ | ✗ |
| **Special** | View Images | ✓ | ✓ | ✗ | ✗ | ✗ |
| | Skills/Commands | ✓ | ✗ | ✗ | ✓ | ✗ |
| | Parallel Execution | ✗ | ✓ | ✗ | ✗ | ✗ |


### Tool Count Summary

| Agent | Total Tools |
|-------|:-----------:|
| Claude-Code | ~15 |
| Codex | ~7 |
| Gemini | ~12+ (many browser tools) |
| OpenCode | ~10 |
| Asimi | 6 |

