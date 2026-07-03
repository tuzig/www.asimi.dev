---
title: "Giving a harness purpose"
date: 2026-01-14T09:00:00+02:00
description: "A coding agent walked into a Confucian school in Korea. What came back was an imperial court."
tags: ["asimi", "agents", "architecture", "philosophy"]
author: 'Benny Daon'
draft: false
---
Since version 0.5.0 Asimi has had a sandbox and superior UX, at least for me.
Mimicking ex/vi/vim/neovim paid off and my muscle memory is now fully engaged.
For over 30 years I've been using `:q` to exit, why stop now?

It was time to tackle the next big challenge: agents and orchestration.
I was using specialized agents since their beginning and I appreciate
their value. Still, orchestration was making me feel uneasy and I wasn't sure I
wanted it in Asimi.

The scope of orchestration is too limited for my taste.
It requires a written symphony and I don't have one. 
It ignores the user and focuses on the agents.

The metaphor I began with - an assembly line - was looking too rigid.
I needed another system and I knew it wouldn't come from software methodologies.
We never found the ideal Software Development LifeCycle.
Nor agile nor spec-driven-development are there. The answer had to come from elsewhere.

It eventually came from Kevin, our native guide in Andong, Korea. He picked us up from our hanok on the river bank across Hahoe Folk Village. He told us we're staying in a 16th century Confucian school. I studied a bit about Confucius in my BA, but I didn't remember much.

### "Harmonize. Confucians seek to Harmonize."

At the time I was building the sandbox so it didn't click.
Later, when the sandbox was done (it'll never be done) and I was battling the orchestrator, I remembered.
I remembered and wanted to learn more. Harmonize what?
I chatted with Kimi trying to understand what is being harmonized. 
Here's the answer from the latest KIMI (2.7):


In imperial Chinese political cosmology, the court understood the
universe through the **Three Realms** or **Three Powers** (`三才`,
*sān cái*): **`天`** *Tian* (Heaven), **`地`** *Di* (Earth), and
**`人`** *Ren* (Humanity/Ruler). The emperor stood at their
intersection, the *Son of Heaven* (`天子`), responsible for
maintaining harmony across all three.

| Realm | Meaning | Court Significance |
|---|---|---|
| **`天`** *Tian* — Heaven | The supreme moral and cosmic authority; source of the **Mandate of Heaven** (`天命`). | Legitimacy: the emperor ruled only so long as Heaven approved. Droughts, floods, or dynastic collapse were read as signs of lost heavenly favor. |
| **`地`** *Di* — Earth | The terrestrial realm: territory, agriculture, natural resources, and cosmic order on the material plane. | Prosperity: rituals ensured fertile soil, good harvests, and stable borders; the empire’s wellbeing depended on Earth responding to virtuous rule. |
| **`人`** *Ren* — Intent/Humanity | In this context primarily the ruler and his court, and by extension the people. The emperor embodied *ren* and mediated between Heaven and Earth. | Governance: through ritual, law, and moral example, the Son of Heaven translated heavenly will into earthly order; the court’s virtue kept the three realms in balance. |

**In short:** *Tian* granted authority, *Di* supplied the material empire, and *Ren*—centered in the ruler’s intent and virtue—performed the mediating work that bound them into a harmonious order.

---

This was something I can work with. It made my role very clear - I'm the Ruler - and I like it.
Gone are the days of co-piloting, I'm the ruler and the coding agent runs my imperial court.

I needed a metaphor for the realms so I started with the one master Kimi suggested:

- Intent - ruler's will that drives the court
- Earth -  The repo
- Heaven - test results, logs and incidents

This definition, while a bit over simplified,  naturally covers the production.
I didn't come up with the idea for Asimi to listen to logs and incident reports.
Kimi brought it up based on the above definition.

The 3 realms are the base of each minister's.
I've also further divided earth into three:

     1. The Capital — committed, unpushed changes
     2. The Middle Kingdom — staged changes
     3. The Borderlands — unstaged changes

It will likely change as Asimi integrates better with git and handles it under the hood.

### The 3 Departments and 6 Ministers  三省六部

Knowing what the court harmonizes was the foundation, next it was time to learn how the court does it.
Here's how master Qwen3.7 describes it:

**The Grand Design: Separation of Powers**

The 三省六部 (Sān Shěng Liù Bù — "Three Departments and Six Ministries") system was formalized under the Sui Dynasty (581–618) and perfected during the Tang Dynasty (618–907). Its genius lies in a deliberate separation of powers within the bureaucracy: no single official can draft, approve, and execute a policy alone. This was designed to protect the throne from ambitious ministers.
---

It sounds like dealing with the same problem our LLM agents are having.
Their sycophancy makes them ambitious. Not for power or money, but for the ruler's approval.

I've simplified the classic structure and probably twisted it a bit.
It'll get better, but for now there are 4 ministers in the system:

- Chancellor
- Sage 
- Forge
- Judge

The Court operates through Rituals with little or no orchestration.
Rituals are yaml-defined workflows where we weave ministers' commands with data and guardrails.

For example, the most common ritual, "swift-strike", goes like this:

- Forge: Implement the edict
- Guardrail: Run the tests
- Judge: Is new code covered by tests? Were any tests changed?
- Guardrail: Run the tests
- Sage: Review the new code is it up to imperial standards?

When the judge or sage reject a change it goes back to the forge for improvements,
and the ritual repeats until both the judge and forge seal the edict.
No single minister can ship code alone — not even the Forge.

And that, I realized, is the point. A harness without purpose is just a loop
with tools bolted on. The model fetches, edits, runs tests, and fetches again —
an eager servant with no court to answer to. It'll do whatever pleases you,
and that's exactly the problem. The Three Realms gave the harness a *why*: not
to execute tasks, but to harmonize intent, code, and truth. The ministers gave
it a *how*: separation of powers that keeps the model's ambition in check. And
the rituals gave it a *when*: a rhythm of forge, test, judge, and review that
flows without a conductor waving a baton.

I didn't set out to build a Confucian coding agent. But I set out to build one
that wouldn't let me down, and this is where the road led. The harness has
purpose now, and the purpose is harmony.
