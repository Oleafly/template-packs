#import "glossary.typ": *

= Studies

== Enhancing scenarios with interactive chatbots
/*
The first DSR study aims to make interactive chatbots for cyber simulations more capable and realistic using deep learning and LLMs; and to handle complex scenarios. This study follows a Design Science Research (DSR) methodology, focusing on the design and evaluation of an AI-driven solution as a research project. The new chatbot shall be given capabilities that allow it to act as participants in exercises similar to act as particpants in table top role playing with the additional integration of real technology. It will also be used in LLM security exercises that involve manipulating AIs to get responses from the prompt. 

Custom benchmarks will be developed and used to determine which LLM is most suitable to use. This will need to be based on criteria such as the quality of the output, the time it takes to generate responses, and the size and resource consumption of the model. In order to evaluate response quality metrics will be needed. Some of these can be existing benchmarks of LLMs, but for the purpose of this study there will also need to be metrics for this specific application. 

Some testing will be needed to compare the different LLMs that meet the resource criteria. This testing will cover a broad spectrum of model sizes and types, ranging from massive frontier models in the 1T parameter class down to highly optimized small language models around the 1B parameter mark. Testing across this range will help determine the performance-to-resource ratio necessary for various simulation types, from heavy-duty centralized servers to edge-based local deployments. Some candidate models for this include Qwen3 1.5B parameter, LFM 1.2B parameter, and Ministral 3 3B. It may also be worth exploring different quantized versions of the model, as quantization significantly reduces memory requirements at the cost of output quality. Model loading parameters such as context length will also need to be determined, as this can significantly effect both model performance and memory requirements. There are technologies such as Flash Attention and KV quantization that will also be considered.

Different models will have to be compared to determine which are the most suitable for the task at hand. This will involve looking at existing model benchmarks for things such as instruction following and technical accuracy. It will also involve testing and evaluating the models responses manually. Prompts used by the software will need to be determined as part of this evaluation.

For the purposes of this research area an existing chatbot will be used as a starting point; specifically hackerbot will be used.
*/

The high level stages for this study are broken down into the following practical work packages:

=== Design a chatbot
// put a paragraph here summarizing the above then add bulletpoints for different techniques
The first DSR study is about designing, implementing, and evaluating educational chatbots using language models. These chatbots will work within lab environments used to teach students cybersecurity concepts and technqiues; they will roleplay different characters, provide support, and be used to demonstrate attacks against AI agents and models such as prompt injection. This will involve looking at different models, context engineering, and prompt engineering techniques. Making the chatbot secure against potential attacks from students and attackers working with the platform is something that will need to be discussed. Getting the system to work at scale within reasonable resource constraints is an important part of this study.

- Evaluate LLM techniques
  - Techniques including TransMLA, Quantization, and fine tuning wil be explored to increase model generation speed and output quality
  - Evaluate context engineering methods such as CAG and RAG
  - Model Selection and Optimization:
    - Benchmark a diverse range of models, from 1T parameter frontier models to 1B parameter mobile-optimized models, using technical cyber security datasets to assess base knowledge.
    - Test various quantization levels (4-bit, 8-bit) to find the "sweet spot" between inference speed and conversational fidelity.
    - Fine-tune a subset of models on technical dialogue datasets if base models fail to maintain character or technical accuracy.
    - Comparison metrics include
      - Prompt injection vulnerability
      - Instruction following
      - Knowledge of cyber-security
      - Helpfulness to students
      - Tool calling accuracy
      - Role playing ability
- Design a "role-play" engine that can inject scenario-specific context (narrative, technical environment, character traits) into the system prompt.
  - Design integration points for real-time technical feedback, enabling the bot to acknowledge student actions within the simulation.
    

=== Software Development and Integration:
// Paragraph here talking about existing solutions summarising the paragraphs above
  - Implementation of a new software artifact that is a  chatbot based on hackerbot using the LLM techniques developed during the design phase
  - Using an exisiting chatbot framework such as the orginal hackerbot or something like zeroclaw or openclaw an educational chatbot will be developed and SecGen refactored to generate the correct configuration
  - Refactor the existing Hackerbot codebase to support a modular backend, allowing for easy switching between different LLM providers (e.g., local Ollama/vLLM instances vs. remote APIs).
// Diagram here about hackerbot architecture
#figure(
  image("diagrams/Hacktivity network diagram 1.drawio.svg"),
  caption: [Current Hackerbot network]
)

#figure(
  image("diagrams/Hacktivity diagram 2 - hackerbot LLM access.drawio.svg"),
  caption: [Network architecture for hackerbot accessing LLMs]
)

=== Evaluation and Testing:
Once an optimal configuration has been found it can be tested on the students to compare its performance against the old hackerbot system. This will involve looking at student enjoyment, immersion, and frustration using quantitative and qualitative analysis techniques. This will involve getting students to say which system they preferred, rate the two systems, and give descriptive written answers on what they felt the strengths and weaknesses of the new system is compared to the old one. Statistical analysis can be used on binary and rating scale answers. Thematic analysis will be done on written answers.
// Phase that happens at the end to evaluate the product
// Explain more about design science research
  - *Automated Evaluation:* Run a standardized set of "jailbreak" and "technical hint" prompts against different configurations to measure safety and helpfulness.
  - *Response Analysis:* Perform thematic analysis on the AI-generated responses themselves. This involves coding the output for technical accuracy, persona consistency, and pedagogical utility (e.g., whether the bot provides hints that lead to discovery vs. simply giving away the answer).
  - *Student Pilot:* Deploy the optimized system to a small group of students. Record technical logs (latency, error rates) and qualitative interactions.
  - *Comparative Analysis:* Use surveys and interviews to compare the new system against the legacy Hackerbot, focusing on immersion, realism, and educational impact.
  - *Thematic Analysis:* Code written student feedback to identify recurring themes in user experience and technical shortcomings.

//The effectiveness of different prompt engineering techniques, context engineering techniques, and models will be performed by using the same set of prompts across multiple configurations of the system and comparing the quality of responses. The responses will be evaluated based on the criteria of technical accuracy and helpfulness. The effectiveness of jailbreak prompts will also be tested to determine how easily abused the system is by students with malicious intentions. The system must be useful in an educational context, so giving away too many answers would also be a problem and should be measured as well.

== Scenario Generation

=== Generating narrative content and instructions

#acrshort("llm")s and image generation models will be used to create realistic companies, characters, names, and stories called narrative content for the randomized scenarios being generated. As part of this the models will need to be fed a precise prompt along with details about the lab. Additionally the language model might be used to generate prompts and characters for the hackerbot model to follow when interacting with the student.

This will require a system to be designed and implemented. As part of the design phase the working of SecGen will be analyzed in detail so that extensions can be built to work with the existing systems. In particular the new components aim to be capable of generating parts of scenario files which are currently set statically and manually. This will involve adding additional functions to the parts of the system that take scenario files and turn them into built scenarios, or it may involve generating scenario files before they are processed by the current system.

==== Design content generation system
+ *Problem Identification:* Current SecGen scenarios use static narrative content, reducing realism and replayability. Manual creation is time-consuming and limits scenario diversity.
+ *Design & Build:* 
  - Analyze SecGen scenario file structure to identify narrative insertion points (company names, character backgrounds, mission briefings)
  - Develop LLM integration module that accepts scenario metadata and generates contextually appropriate narrative elements
  - Create initial prompt templates for 3
+ *Demonstrate:* Generate 30 narrative sets (10 per type) for existing scenario templates
+ *Evaluate:*
  - Benchmark different LLMs to determine there effectiveness in generating narative content and the inference speed
    - Look at achievable tokens per second, prompt processing speed, and batch sizes
    - Compare image model generation speeds, quality, and resource consumption
    - Grade responses from LLMs based on their appropriateness and quality of narrative content

==== Implement narrative content generation system
+ Setup inference infrastructure (local and cloud proxies)
+ Develop system for generating narrative content
+ Test actually generating VMs with auto generated narrative content

==== Evaluation and testing
- *Automated evaluation:* Unit and integration tests to make sure API calls are successful and narrative content is being filled out
- *Response Analysis:* Perform thematic analysis on the generated content to make sure it is appropriate, engaging, and realistic
- *Student pilot:* Deploy to a limited number of users to test the system. Record technical events, logs, performance, and qualitative interactions with the students
- *Comparative analysis:* Use interviews and surveys to compare the new version against the old SecGen focusing on realism, engagement, and variety of scenarios
- *Thematic Analysis:* Code written student feedback to identify recurring themes in user experience

/*
*Stop Conditions:*
- Success: Student validation shows significant improvement, system integrated into SecGen production
- Iterative refinement: Up to 2 additional cycles if specific fixable issues identified
- Pivot: If fundamental LLM limitations prevent coherent narrative generation, explore hybrid approach (LLM-assisted human authoring) or template-based generation with LLM variation
*/

=== Generating insecure software and system configurations

Along with the ability to create software LLMs can be used to produce #acrfull("iac") files and commands used to configure a system. The idea here is to use an #acrshort("llm") to generate part or all of a lab including the vulnerable software used or the insecure configuration. This would allow for novel insecure labs to be generated without needing extensive configuration with XML or complicated software for randomization. It would allow for a greater variety of labs and challenges to be generated than would otherwise be possible while reducing the amount of time spent by staff on developing new labs.

This part is likely to require the use of advanced frontier models and/or fine-tuned models for this specific purpose. As part of this process the labs generated will need to be tested either automatically or manually to make sure they are both built correctly and are indeed vulnerable. Part of this could involve asking the model to generate a solution script designed to exploit the vulnerability in the lab and retrieve any flags therein. An automated testing system could then use this solution on an instance of the generated lab to ensure it is vulnerable. If the lab is found to not be solvable by the script then the model could be prompted to fix the lab, or a human signalled for manual intervention. This could involve a separate LLM agent configured specifically for debugging broken labs. These different approaches will need to be tested, evaluated, and refined before being compared.

==== Design the system
+ *Compare prompting strategies*: zero-shot, one-shot, and few-shot techniques
+ *Compare single agent vs multi-agent approaches:*: There are single agent systems like Codex and multi-agent systems like Claude Code or OpenCode
+ *Explore MCP and skills:*: Different add ons and sources of information can be used to provide context, commands, and tools for an LLM to work with
+ *Investigate context engineering techniques:* These include RAG and agentic exploration
+ *Testing parts of the system independently:* Here different approaches will be tried and capabilities will be determined
+ *Examine model and requirements:* What kinds of model are needed? How much resources will they require?

==== Implement system into existing infrastructure
Once a design has been chosen the system will need to be built and integrated into the existing framework of SecGen or other parts of the Hacktivity system. The system may in part be based on existing open source frameworks and tools such as OpenCode, OpenClaw, or MicroClaw.

==== Testing and evaluating the generated systems
The systems generated by the APG system will be evaluated for how novel, relevant, and educational they are. In addition the length of time required to generate the content and the resources consume will be measured. If the resources required are too high different model architectures will be considered along with tweaks to the inference infrastructure and software such as comparing llama.cpp, ik_llama.cpp, ktransfomers, and SGLang. Advanced techniques such as CPU GPU hybrid inference with expert offloading or KV Cache quantization may be attempted.



/*

*Cycle 1: Single Vulnerability Type and Exploit Validation*
+ *Problem Identification:* Creating diverse vulnerable applications manually is time-intensive and limits scenario variety. Existing vulnerable apps (WebGoat, DVWA) become overly familiar to students.
+ *Design & Build:*
  - Focus on one well-defined vulnerability class: SQL injection in web applications
  - Develop LLM prompting strategy to generate vulnerable PHP/Python web apps with intentional SQLi flaws
  - Implement dual-agent system: Generator creates vulnerable code, Exploiter creates proof-of-concept exploit script
  - Build automated testing pipeline: deploy generated app in Docker, run exploit script, verify flag capture
+ *Demonstrate:* Generate 15 vulnerable web applications with varying SQLi contexts (login forms, search functions, user profiles)
+ *Evaluate:*
  - *Buildability:* Docker build success rate, application starts without crashes (target: at least 90%)
  - *Exploitability:* Automated exploit success rate (target: at least 80%)
  - *Vulnerability correctness:* Manual verification by security expert that vulnerability matches intended type and is realistic
  - *Difficulty assessment:* Expert panel rates whether vulnerability difficulty is appropriate for target student level (undergraduate cyber security course)
+ *Refinement Criteria:* Proceed if buildability and exploitability thresholds met
+ *Expected Duration:* 5-6 weeks

*Cycle 2: Multi-Vulnerability and Infrastructure-as-Code Generation*
+ *Design & Build:*
  - Expand to 3 additional vulnerability types: XSS, insecure deserialization, path traversal
  - Implement IaC generation: LLM creates Terraform/Ansible configurations with intentional security misconfigurations (open S3 buckets, overly permissive firewall rules)
  - Develop Debugger agent that analyzes failed builds/exploits and attempts repairs
  - Create validation suite that checks for unintended vulnerabilities (security scanning with OWASP ZAP)
+ *Demonstrate:* Generate 30 labs: 20 web app vulnerabilities (5 per type), 10 IaC misconfigurations
+ *Evaluate:*
  - *Technical metrics:* Same as Cycle 1, plus deployment success rate for IaC (target: at least 85%)
  - *Unintended vulnerabilities:* Security scan to ensure no critical unintended flaws (would confuse students)
  - *Debugger effectiveness:* Percentage of failed builds/exploits recovered by Debugger agent vs. requiring human intervention
  - *Diversity assessment:* Code similarity analysis to ensure generated samples are sufficiently distinct (cosine similarity less than 0.7)
+ *Refinement Criteria:* 
  - Debugger recovers at least 60% of failures
  - No more than 10% of samples have critical unintended vulnerabilities
  - Diversity threshold met
+ *Iteration Decision:* If specific vulnerability types consistently fail, focus on successful types and iterate separately on problematic ones
+ *Expected Duration:* 5-7 weeks

*Cycle 3: Student Learning Validation and Cost-Effectiveness*
+ *Design & Build:*
  - Generate complete lab set for one course module: 25 labs across 4 vulnerability types, including instructions and learning objectives
  - Implement difficulty progression (scaffolded learning from simple to complex)
  - Create instructor dashboard showing generated lab metadata and solutions
+ *Demonstrate:* Deploy to live course with 30-40 students. Split design: 50% students get AI-generated labs, 50% get traditional hand-crafted labs (randomized assignment)
+ *Evaluate:*
  - *Learning outcomes:* Compare student performance on post-lab assessments between groups (t-test, equivalence testing)
  - *Student experience:* Survey on lab quality, clarity, realism (both groups)
  - *Instructor experience:* Interview with course instructor on lab variety, preparation time saved
  - *Cost analysis:* 
    - Time to generate 25 labs (LLM approach) vs. estimated manual creation time
    - Computational costs (API calls, infrastructure)
    - Instructor review/fixing time for AI-generated labs
+ *Success Criteria:*
  - Learning outcomes equivalent or better (non-inferiority margin: -5% on assessment scores)
  - Total approach (generation + review) costs less than 50% of manual creation time
  - Instructor willing to adopt for future course iterations
+ *Iteration Decision:* If learning outcomes equivalent but students report quality issues, return to Cycle 2 for quality refinement. If outcomes worse, investigate pedagogical issues with AI-generated content.
+ *Expected Duration:* 8-10 weeks (full semester integration)

*Stop Conditions:*
- Success: Learning equivalence demonstrated, cost savings achieved, instructor adoption → scale to additional vulnerability types and courses
- Partial success: Works for some vulnerability types but not others → document scope limitations, use hybrid approach
- Failure: Consistently generates non-working or pedagogically inappropriate labs → explore AI-assisted manual creation (LLM suggests vulnerabilities, human implements) or abandon automated generation for this application
*/