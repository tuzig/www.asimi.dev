---
title: "Giving a harness purpose"
date: 2026-01-14T09:00:00+02:00
description: "A coding agent walked into a Confucian school in Korea. What came back was an imperial court."
tags: ["asimi", "agents", "architecture", "philosophy"]
author: 'Benny Daon'
draft: false
---
Since version 0.5.0 Asimi has had a sandbox and superior UX based on vim.
Mimicking ex/vi/vim/neovim paid off and my muscle memory is now fully engaged.
For over 30 years I've been using `:q` to exit, why stop now?

It was time to tackle the next big challenge: agents and orchestration.
I was using specialized agents since they entered the stage and I appreciate
their value. Still, orchestration was making me feel uneasy and I wasn't sure I
wanted it in Asimi.

The scope of orchestration is too limited for my taste.
It requires a written symphony and I don't have one. 
It ignores the user and focuses on the agents.

The metaphor I began with - an assembly line - was too rigid.
I needed another system and I knew it wouldn't come from software methodologies.
We never found the ideal Software Development LifeCycle.
Neither agile nor spec-driven-development are there. The answer had to come from elsewhere.

It eventually came from Kevin, our native guide in Andong, Korea. He picked us
up from our hanok on the river bank across Hahoe Folk Village. He told us we're
staying in a 16th century Confucian school. I studied a bit about Confucius in
my BA, but I didn't remember much.

### "Harmonize. Confucians seek to Harmonize."

At the time I was building the sandbox so it didn't click.
Only when the sandbox was done (it'll never be done) and I was looking for a replacement to orchestrating I recalled Kevin and his Confucians.
I remembered and wanted to learn more. Harmonize what?
I chatted with Kimi trying to understand what is being harmonized. 
Here's the answer from the latest Kimi (2.7):


In imperial Chinese political cosmology, the court understood the
universe through the **Three Realms** or **Three Powers** (`三才`):

| Realm | Meaning | Court Significance |
|---|---|---|
| **`天`** *Tian* — Heaven | The supreme moral and cosmic authority; source of the **Mandate of Heaven** (`天命`). | Legitimacy: the emperor ruled only so long as Heaven approved. Droughts, floods, or dynastic collapse were read as signs of lost heavenly favor. |
| **`地`** *Di* — Earth | The terrestrial realm: territory, agriculture, natural resources, and cosmic order on the material plane. | Prosperity: rituals ensured fertile soil, good harvests, and stable borders; the empire’s wellbeing depended on Earth responding to virtuous rule. |
| **`人`** *Ren* — Intent/Humanity | In this context primarily the ruler and his court, and by extension the people. The emperor embodied *ren* and mediated between Heaven and Earth. | Governance: through ritual, law, and moral example, the Son of Heaven translated heavenly will into earthly order; the court’s virtue kept the three realms in balance. |

**In short:** *Tian* granted authority, *Di* supplied the material empire, and *Ren*—centered in the ruler’s intent and virtue—performed the mediating work that bound them into a harmonious order.

---

This cosmology, with the son of heaven (aka the user) at its center was just what I was looking for.
The best thing about it - it's already wired in the models.
The system was used for over a thousand years and most of the classical Chinese text were written by Confucian ministers.
The minister-agents system prompt need only the couple of classic Chinese characters for its role.
When the model encounter these characters, all that classic learning kicks in and the agent
becomes an imperial minister aiming to harmonize the realms.

Next, I needed a metaphor for the realms so I started with the one master Kimi suggested:

- Intent - ruler's will that drives the court
- Earth -  The repo
- Heaven - test results, logs and incidents

This definition, while a bit over simplified, naturally covers production.
I didn't come up with the idea for Asimi to listen to logs and incident reports.
Kimi brought it up based on the cosmology and I liked it.
It extends Asimi's reach making production part of the foundation. 

We've also further divided earth into three:

     1. The Capital — committed, unpushed changes
     2. The Middle Kingdom — staged changes
     3. The Borderlands — unstaged changes

It will likely change as Asimi integrates better with git and handles it under the hood.

### The 3 Departments and 6 Ministers  三省六部

Knowing what the court harmonizes was the foundation, next it was time to learn how the court does it.
Here's how master Qwen3.7 describes it:

**The Grand Design: Separation of Powers**

The 三省六部 system was formalized under the Sui Dynasty (581–618) and perfected during the Tang Dynasty (618–907). Its genius lies in a deliberate separation of powers within the bureaucracy: no single official can draft, approve, and execute a policy alone. This was designed to protect the throne from ambitious ministers.

---

It sounds like dealing with the same problem our LLM agents are having.
Their sycophancy makes them ambitious. Not for power or money, but for the ruler's approval.

I've simplified the classic structure and twisted it a bit.
For now, there are 4 ministers in the system, each with his own storage and tools and
all are driven by my edicts.

### Workflow

Asimi let's me work old-style by chatting directly to the forge.
This happens quite rarely.
Usually I chat with the "Sage" and he drafts the edict.
Based on my prompt it either tracks down a bug or look for ways to implement a new feature.
It's not unlike planning mode in other coding-agent.
The big difference is what happens with the plan.
The plan is stored in Asimi's DB as an edict with its own number.
It can be read, edited, implemented or cancelled using the ":edicts" command.

After I approve the edict I'm asked if I want to run a swift-strike ritual on it.
If I approve a yaml-defined workflow starts:

```yaml

- name: swift-strike
  description: A tight loop for implementing edicts
  inputs:
    edict_id:
      type: string
      required: true
  max_retries: 3
  background:
    - the edict details
  steps:
    - name: forging
      minister: forge
      act: |
        Implement the changes for the edict:

        {{ .edict }}

        Focus on minimal, targeted changes to fulfill the intent.
    - name: judging
      minister: judge
      given:
        - "!just test"
        - the manifests
      act: |
        If any tests were changed, you need to verify that were not weakened
        and that non trivial changes are justified by the edict.
        {{ .manifests }}
        ...
        When judgement is done, call record_verdict
      then:
        - the verdicts are passed
        - record the judge's seal
      on_failure: goto
      on_failure_target: forging
    - name: censoring
      minister: sage
      given:
        - the manifests
        - the verdicts
      act: |
        Review the code changes for the edict. 
        ## Edict
        {{ .edict }}
        ## Manifests
        {{ .manifests }}
        ## Verdicts
        {{ .verdicts }}
      then:
        - the precedent is approved
        - record the sage's seal
      on_failure: goto
      on_failure_target: forging
  then:
    - the edict awaits ruler's seal
```

In a nut shell:

- Forge: Implement the edict
- Guardrail: Run the tests
- Judge: Is new code covered by tests? Were any tests changed?
- Guardrail: Judge approved
- Sage: Review the new code is it up to imperial standards?

When the judge or sage reject a change it goes back to the forge for improvements,
and the ritual repeats until both the judge and sage seal the edict.
No single minister can ship code alone — not even the Forge.

And that, I realized, is the point. A harness without purpose is just a loop
with tools bolted on. The model fetches, edits, runs tests, and fetches again —
an eager servant with no court to answer to. It'll do whatever pleases you,
and that's exactly the problem. The Three Realms gave the harness a *why*: not
to execute tasks, but to harmonize intent, code, and truth. The ministers gave
it a *how*: separation of powers that keeps the model's ambition in check. And
the rituals gave it a *when*: a rhythm of forge, test, judge, and review that
flows without a conductor waving a baton.

I set out to build a coding agent that won't let me down.
My path led me to a Confucian system with a clear purpose: Harmony.
