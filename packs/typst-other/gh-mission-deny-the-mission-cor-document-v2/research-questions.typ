#import "glossary.typ": *

= Research Questions

// Cliffe: You've not mentioned that there are these separate "studies" yet, rename this to "LLM chatbots":
== Enhancing scenarios with interactive chatbots
+ What architecture and techniques are the most effective for the educational chatbot powered by LLMs.
  + Is RAG, CAG, or fine tuning more effective for feeding #acronym("llm")s resources about cybersecurity
  // Cliffe: What prompt engineering techniques are most effective?
  + What prompt engineering techniques are most effective?
+ How can roleplaying personalities make education bots more effective
  + What kind of prompting techniques help with roleplaying?
  + Which models work best for roleplaying in cybersecurity scenarios?
+ Determine what is the most efficient and effective way to run an AI powered assistant
  + What kind of hardware resources are required to run the models locally?
  + Can inference be done scalably using only CPUs?
  + What size of model is needed for an AI bot for this kind of chatbot?
  + Which #acronym("llm")s are most effective?

  Tutorial bots and threat actors (expand on)
/*
// Cliffe: remove "study" from heading
== Malware generation and obfscuation

+ What techniques are most effective at doing randomized malware generation for malware analysis labs?
  + Can techniques such as RAG and CAG and other context engineering techniques be used to enhance malware generation and obfuscation?
  + How can MCP servers be used to assist in malware generation?
  + Methodology for adding compile time and/or static analysis tools to enhance malware generation and obfuscation
  + To compare effectiveness of one-shot generation, single agent generation, and multi-agent generation
+ To what extent can the malware generation be automated? Partly or fully?
+ How can #acronym("llm")s be used to obfuscate existing malware in ways that make it more complex to analyze?
+ Which models are most effective for malware generation and obfuscation?
*/

== Insecure software and configuration generation
+ What kinds of insecure software and systems configurations can be generated?
// rephrase to be how do we design a solution around getting LLMs to generate and verify insecure software and configurations (mention APG (Automatic Problem Generation))
+ How independently can they be generated and verified?
+ What techniques are most effective for generation of insecure software and systems?
  + Which kinds of model are most effective for narrative content generation?
  + How can MCP servers be used to assist in generation of insecure software and systems?
  + What methodology is most effective for using static analysis tools to enhance generation of insecure software and systems?
  // Cliffe: tense has changed:
  + Compare single agent vs multi-agent systems

// Flesh this out more
// Compare against AiCEF paper
// Have a research question about desining a new system or apporach
== Narrative content generation
+ Which kinds of model are most effective for narrative content generation?
+ How can a solution to generate narrative content be developed?
+ What resources are needed for narrative content generation?
+ How can image and video generation models be used to create more engaging and realistic narratives?

// Cliffe: suggest you remove this section, this is really related to the above, and this list of RQ is getting too long -- remember you need to answer each of these questions:
/*
== Prompt generation
+ Can one model be used to create character sheets and prompts for the smaller hackerbot models?
+ Explore different meta-prompting techniques
+ Analyze performance of manually written prompts and character sheets vs meta-prompting
*/