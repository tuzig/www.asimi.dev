---
title: "Commit early, Amend often"
date: 2025-12-11T09:36:59+02:00
description: "A practical Git workflow for the AI coding agents era: worktrees for isolation, early commits for safety, amends for clean history, and hooks for guardrails."
author: 'Benny Daon'
draft: false
---

Git changed how we build software. Now coding agents are changing how we use git.

Before, it was just me, myself & I editing the code.
We didn't need protection back then. Today we do.

Don't get me wrong, I'm a big believer of coding agents, and yet, the LLMs can't be trusted.
In the early days, their follies made me lose a lot of changes and
spend many hours untangling changes.
Today I have a workflow that adds very little overhead while 
minimizing the blast radius of models' folly.

## Branches and worktrees

I use Asimi's `main` branch for:

- merging
- planning
- trivial work
- version release

Non-trivial changes go into their own branch and worktree. I have a `worktrees/` in the project root where they all live.
When I start working on a feature I create a new worktree:

```bash
git worktree add -b greatfeature worktrees/greatfeature
cd !$
just install
```

I'm lucky as this is all I need to get working on a new worktree. 
Many projects use a `.env` file so that needs to be copied over.
Thanks to [direnv](https://direnv.net/) I don't have `.env` files.
I load direnv in my `zshrc` and it loads/unloads env variable as I cd around.
It looks for the `.envrc` file in the cwd and if missing, searchs up the directory tree.
So a single `.envrc` at the project's root is accessible to all worktrees.


## Expanding commits

Coding agents should be protecting us from models' folly but they don't and
it's left to the user to ensure work isn't lost in the process.
To do that I commit early and I commit often.

When Asimi says a change is finished I review the changes (using nvim & fugitive).
If there are things I don't like I add TODO comments asking the agent to change.
When I finish my review, I commit the code.
If I added comments, I name the commit "WIP:feat: great new feature" and
then I ask the agent to handle the TODOs.

After reviewing the new batch of changes I don't add a new commit, but amend
the old one (be sure to stage your changes):

```bash
git commit --amend
```

This adds the staged changes to our last WIP commit and 
let me edit the commit message. If the commit is done I 
remove the WIP from the name and push.

This way, when the model got it completely wrong I can
always us `git reset --HARD` and start fresh.

## Rebasing trivial changes

When Asimi has 3-5 trivial issues in its backlog, I use a single prompt to 
ask it to handle them and commit each issue separately. 
Then I have time for coffee. When I get back I check git's log and test the program.
In some cases the change is not good. To remove these changes, I use `rebase -i`.
It lets me rewrite history and among other things, drop a commit.

After I weed out the bad changes I edit their issues to ensure we'll get it right the next time.
Then I review all the good changes in the batch using `git diff <the hash before the session>`.
If I find anything to improve I add TODO comment and ask Asimi to handle them.

After that I ensure `CHANGELOG.md` is synced and if not I edit it and run one more `git commit --amend`.

## Hooks and guardrails

git comes with 14 hooks we can customize. There are samples for all of them in the `.git/hooks`.
These samples are not trivial but your hooks can be.
I use a very simple hook script in `.git/hooks/pre-commit`:

```
#!/bin/sh
go fmt
go test ./...
```

(don't forget to `chmod +x pre-commit` so git can run the hook).
Now, before each commit the tests run and if they fail, the commit
doesn't happen (unless you use the `git commit -n` and skip the hooks).

## Your turn

This workflow evolved through trial and error (mostly error). Yours will too.
The important thing is to have *something* in place before the agent rewrites
half your codebase and you realize you forgot to commit.

Start with one habit: commit before every agent task. The rest will follow.

Got a workflow tip I'm missing? I'd love to hear it - [@daonb](https://x.com/daonb).


