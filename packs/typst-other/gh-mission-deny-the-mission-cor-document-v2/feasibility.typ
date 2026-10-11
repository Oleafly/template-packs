#import "glossary.typ": *

= Project Feasibility and Resources
// Cliffe: This section needs a little bit of organisation, to make it clearer.

// Cliffe: if it's "trivial", why should anyone care? (Don't say it that way.) It's not trivial, in terms of actually designing an approach and evaluating it.
Generating narrative content should be more or less trivial for current machine learning algorithms. It's well within the capabilities of current LLMs.

Integrating AI into hackerbot is well under way. The main concerns are over resource consumption and how well smaller models are able to perform the tasks required. More thorough testing of small model capabilties is required. This is largely an infrastructure problem and won't get in the way of proving it to be possible. Small models capable of running on limited infrastructure such as Gemma 1B and LFM2 1.2B have been found, and initial tests on inference speed and output quality are positive.

Generating malware and obfuscating malware is more complicated. This requires the use of powerful #acronym("llm")s that require lots of computational resources. The problem being that cloud hosting is made difficult by the nature of generating malware and potentially requiring uncensored models.

The feasibility of generating insecure software and system configurations is difficult to determine. It highly depends on the performance of frontier #acronym("llm")s and surrounding tooling. Medium sized uncensored models are capable of generating code for malware, but it is unclear how similar this malware is to malware found in real cyber attacks. Techniques using agentic AI and AI agents will need to be tested and iterated upon.