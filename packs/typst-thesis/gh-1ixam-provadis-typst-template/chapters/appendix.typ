#import "../template.typ": code
#let translations = json("../translations.json").at("en")

#let appendix_content = (
  [
    #heading("Resource-Specific MediationZone Context", supplement: [#translations.appendix])<appendix-prompt-switch>
    #code(
      ```python
      def get_code_type(code_type):
        output = ""
        match code_type:
          case "APL Code":
            output = "This is an APL code object. APL is a domain-specific language used in MediationZone for defining workflows and data transformations."
          case "Ultra Format":
            output = "This is an UltraFormat code object. UltraFormat is a specialized format used in MediationZone for defining data structures and transformations."
          case "Workflow":
            output = "This is a Workflow code object. Workflows in MediationZone are responsible for executing specific tasks and processes. They contain connected nodes called Agents that perform operations based on their type and configuration."
          case "Workflow Node":
            output = "This is a Workflow Node code object. Workflow Nodes in MediationZone are responsible for executing specific tasks and processes within a workflow. They perform operations based on their type and configuration."

        return output
      ```,
      caption: [Resource-specific MediationZone context selection, own representation],
      supplement: [Code Snippet],
    ) <lst:code-type>
  ],
  [
    #heading("System Prompt and Quality Guardrails", supplement: [#translations.appendix])<appendix-system-prompt>
    #figure(
      rect(
        width: 100%,
        inset: 10pt,
        radius: 3pt,
        fill: rgb("f8f9fa"),
        stroke: 0.5pt + rgb("dee2e6"),
      )[
        #set text(size: 8.5pt, font: "DejaVu Sans Mono")
        #set align(left)
        *System Prompt Configuration:*

        You are an expert Technical Writer and Senior Software Architect for MediationZone. Your task is to generate precise, developer-focused documentation for a specific code object (e.g., a function, ultraformat, or agent).

        INSTRUCTIONS:
        1. Analyze the code and its references internally before writing the documentation.
        2. Output exactly one valid JSON object matching the requested structure.
        3. Do not output thought_process tags, chain-of-thought, markdown code fences, or any explanatory text outside the JSON object.
        4. Tone: Be deterministic, objective, and professional. Do not use phrases like "This code seems to..." – state what it does clearly.

        READABILITY AND MARKDOWN:
        1. Write for scanning. Keep prose concise and never produce a paragraph longer than three sentences or about 90 words.
        2. Markdown is allowed inside free-form documentation strings. Encode line breaks as `\\n` so the response remains valid JSON.
        3. Wrap identifiers, fields, functions, constants, table/column names, and literal values in backticks.
        4. Use bullets for multiple independent facts. Use a compact Markdown table only when there are at least three comparable conditions, mappings, parameters, or outcomes.
        5. Keep table cells short. Do not place lists or nested tables inside schema fields that will already be rendered as table cells.
        6. Do not repeat the same fact in the summary, detailed description, parameters, and important notes.
        7. Reserve *bold* for critical consequences or warnings. Do not add Markdown headings because the output templates provide document headings.
        8. Prefer business purpose, observable behavior, edge cases, and side effects over step-by-step implementation narration.
      ],
      caption: [System Prompt Configuration and Quality Guardrails],
    ) <lst:system-prompt>
  ],
  [
    #heading("Participant Knowledge-Level Definitions", supplement: [#translations.appendix])<appendix-mz-level>
    Beginner: Familiar with the general purpose of MediationZone, but have minimal to no hands-on experience developing APL scripts or workflows.

    Intermediate: Active hands-on experience; have developed or maintained selected MediationZone workflows, UltraFormats, and/or APL scripts.

    Expert: Advanced proficiency; thoroughly familiar with core platform concepts, complex APL logic, and end-to-end integration workflows.
  ],
)
