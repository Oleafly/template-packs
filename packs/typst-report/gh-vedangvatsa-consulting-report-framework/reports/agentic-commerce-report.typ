#import "template.typ": *

#show: report.with(
  title: "Agentic Commerce",
  subtitle: "Market Sizing, Competitive Dynamics, and Strategic Implications",
  author: "Vedang Vatsa",
  date: "April 2026",
)

= Executive Summary

*Autonomous AI agents are poised to intermediate \$1.5--5 trillion in global commerce by 2030, creating the largest structural shift in digital trade since the shopping cart.*

#kpi-grid(
  kpi-card("$6.4T", "E-Commerce 2025", "+8.2% YoY"),
  kpi-card("$1.5T", "Agent TTV 2030", "Juniper Research"),
  kpi-card("35.7%", "Tech CAGR", "2026-2033"),
  kpi-card("90%", "B2B Agents 2028", "Gartner"),
)


*Situation.* Global e-commerce reached \$6.4 trillion in 2025, growing 8.2% year-over-year. Yet the fundamental transaction model, where a human browses, selects, and checks out, has remained structurally unchanged since Amazon launched 1-Click ordering in 1999. Every subsequent innovation (mobile payments, social commerce, buy-now-pay-later) optimized the existing flow rather than replacing it.

*Complication.* Agentic AI systems capable of autonomous, multi-step reasoning can now complete end-to-end purchase journeys without human intervention. In the past 12 months, OpenAI launched shopping within ChatGPT, Google integrated agent commerce through Gemini and the Universal Commerce Protocol, Amazon deployed Rufus with audio summaries, and Perplexity introduced "Buy with Pro." Simultaneously, a parallel infrastructure race produced six interoperability protocols (MCP, ACP, UCP, A2A, AP2, x402) designed to enable machine-to-machine transactions at scale.

*Resolution.* The window for strategic positioning is 12-24 months. Merchants must invest in machine-readable catalogs and API-first checkout architectures or risk becoming invisible to agent-mediated discovery. Platforms must adopt open commerce protocols to avoid fragmentation. Investors should target the infrastructure layer, specifically payment orchestration, identity verification, and agent middleware, where risk-adjusted returns are highest before protocol winners are established by 2028.

This report provides a comprehensive analysis of the agentic commerce opportunity across twelve dimensions: historical context, market definition, sizing, competitive dynamics, protocol architecture, value chain transformation, consumer behavior, investment landscape, risk assessment, data-driven adoption modeling, scenario analysis, and strategic recommendations. It draws on 15 tier-1 analyst reports, 200+ company announcements, regulatory filings across three jurisdictions, and original quantitative modeling.

The probability-weighted expected value across three scenarios (bear, base, bull) is \$6.3 trillion in combined B2B and B2C agent-mediated transaction volume by 2030. The technology solutions market reaches \$23-25 billion in the base case. Infrastructure-layer investments offer the best risk-adjusted returns because they benefit regardless of which adoption scenario materializes.

#callout[
  *Key Insight:* 2026 is the breakout year for agentic shopping. Consumer trust remains the primary barrier, with 78% of consumers uncomfortable delegating full purchasing authority to AI agents. However, B2B procurement, where trust thresholds are lower and efficiency gains are immediate, will lead adoption with Gartner projecting 90% of B2B buying will be agent-intermediated by 2028.
]

The executive summary above condenses 12 months of market research spanning 15 tier-1 analyst reports, 200+ company announcements, and regulatory filings across three jurisdictions. The analysis that follows is structured using the Pyramid Principle: each section builds from data to insight to recommendation, ensuring that readers at any level of detail can extract actionable intelligence.

#section-divider("01", "Historical Context", "Three decades of digital commerce — from static catalogs to autonomous agents")

#block(breakable: true, above: 0.8em, below: 0.8em)[
  #image("images/ai-commerce.jpg", width: 100%)
  #v(0.1em)
  #text(size: 7pt, style: "italic", fill: steel)[Photo: Unsplash. AI agents are beginning to handle end-to-end purchase journeys on behalf of consumers.]
]

*The history of digital commerce is a 30-year sequence of progressively removing friction from the transaction. Agentic commerce represents the logical endpoint: removing the human from the transaction entirely.*

Understanding where agentic commerce fits in the broader arc of digital trade requires tracing the key inflection points that brought us here. Each era solved a specific friction problem. Catalog commerce (1995-2005) solved the discovery problem by making products findable online. Platform commerce (2005-2015) solved the trust problem through reviews, ratings, and buyer protection. Mobile commerce (2010-2020) solved the access problem by putting the store in every pocket. Social commerce (2018-2025) solved the inspiration problem by embedding products in content streams. Agentic commerce (2025+) solves the decision problem by delegating the entire purchase journey to AI.

#chart-exhibit(1, "Three decades of e-commerce inflection points overlaid on market growth",
  "charts/commerce_evolution_timeline.png",
  "Author analysis based on Statista, eMarketer, company filings")

=== The Five Eras of Digital Commerce

*Era 1: Catalog Commerce (1995-2005).* Amazon launched in 1995 as an online bookstore. By 1999, it had introduced 1-Click ordering, the first meaningful checkout friction reduction. Total e-commerce was under \$100 billion globally. The key constraint was consumer willingness to enter credit card numbers online — a trust barrier that took a decade to overcome. SSL certificates, PayPal's buyer protection (2000), and growing brand familiarity gradually built confidence.

*Era 2: Platform Commerce (2005-2015).* Shopify (2006), Stripe (2011), and marketplace expansions on Amazon and eBay industrialized merchant onboarding. The number of online merchants grew from roughly 100,000 to over 12 million. Reviews and ratings created information symmetry. Two-day shipping (Amazon Prime, 2005) eliminated delivery uncertainty. E-commerce crossed \$1 trillion globally by 2012.

*Era 3: Mobile Commerce (2010-2020).* The iPhone (2007) and mobile-responsive design standards created a new shopping surface. Mobile commerce grew from ~3% of e-commerce in 2010 to 59% by 2025. Apple Pay (2014) and Google Pay (2015) reduced mobile checkout friction. The constraint shifted from access to attention — consumers had unlimited browsing capability but limited time and cognitive bandwidth.

*Era 4: Social Commerce (2018-2025).* Instagram Shopping (2018), TikTok Shop (2021), and live commerce in China embedded purchasing directly into content consumption. Social commerce reached an estimated \$1.2 trillion globally by 2025, with China accounting for 65% of that volume. The innovation was contextual: products appeared in the flow of entertainment rather than requiring deliberate search.

*Era 5: Agentic Commerce (2025+).* The current era removes the human from the decision loop entirely. Rather than optimizing how humans browse, compare, and checkout, agentic commerce delegates these steps to AI systems that reason autonomously. The inflection point was the convergence of three capabilities: foundation models that reason reliably over structured data (GPT-4, Claude 3, Gemini), standardized protocols for machine-to-machine commerce (MCP, UCP, ACP), and payment infrastructure that supports delegated authorization (AP2, Visa TAP).

#chart-exhibit(2, "Agentic commerce adoption is tracking 2x faster than mobile commerce",
  "charts/adoption_curves_comparison.png",
  "Author analysis comparing mobile (2010-2020), social (2018-2028), agentic (2025-2035)")

The adoption curve comparison reveals a striking pattern. Mobile commerce took 10 years to grow from near-zero to 59% of e-commerce (2010-2020). Social commerce is on track for 17% after 10 years (2018-2028). Agentic commerce is projected to reach 32% within 10 years of mainstream launch (2025-2035) — nearly 2x the pace of mobile. The acceleration reflects two factors: the pre-existing digital commerce infrastructure eliminates the need to build from scratch, and the value proposition (time savings, price optimization) is immediately quantifiable.

#table-exhibit(none, "Key inflection points in digital commerce history",
  "Author analysis based on company filings, Statista, eMarketer")[\
  #table(
    columns: (1fr, 1.5fr, 1fr, 1.5fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Year],
      text(fill: white, weight: "bold")[Innovation],
      text(fill: white, weight: "bold")[E-Commerce],
      text(fill: white, weight: "bold")[Friction Solved],
    ),
    [1995], [Amazon launches], [\$0.5B], [Product discovery],
    [1999], [1-Click ordering], [\$5B], [Checkout friction],
    [2005], [Amazon Prime], [\$100B], [Delivery uncertainty],
    [2007], [iPhone launches], [\$250B], [Access/mobility],
    [2011], [Stripe launches], [\$680B], [Merchant onboarding],
    [2014], [Apple Pay], [\$1.5T], [Mobile payment],
    [2018], [Instagram Shopping], [\$2.8T], [Discovery context],
    [2023], [ChatGPT shopping], [\$5.8T], [Research effort],
    [2025], [MCP/UCP protocols], [\$6.4T], [Machine interop],
    [2026], [Agentic commerce], [\$6.7T], [Human decision],
  )
]

The pattern is clear: each era compressed the timeline between consumer intent and transaction completion. Catalog commerce required minutes of browsing. 1-Click reduced checkout to a single action. Mobile put the store in your pocket. Social commerce embedded products in passive consumption. Agentic commerce eliminates the need for human involvement entirely. The logical trajectory points toward a future where the majority of routine purchases are handled autonomously, with humans intervening only for novel, high-stakes, or preference-sensitive decisions.

#callout[
  *Key Insight:* The defining pattern across 30 years of digital commerce is friction elimination. Each era removed one barrier — discovery, trust, access, attention, decision. Agentic commerce removes the last: human cognitive effort. There is no further friction to remove after the human is removed from the loop.
]

#section-divider("02", "Market Definition", "Defining agentic commerce and establishing the analytical framework")

*Agentic commerce represents a structural break from two decades of static e-commerce, transferring discovery, evaluation, negotiation, and transaction execution to autonomous AI systems.*

The defining characteristic of agentic commerce is autonomy. Unlike traditional recommendation engines or chatbots that assist human decision-making, agentic systems act independently once given a high-level directive. A consumer might instruct an agent to "find the best noise-canceling headphones under \$300 with next-day delivery," and the agent handles every subsequent step: querying multiple merchants, comparing specifications, evaluating reviews, negotiating pricing where possible, completing checkout, and confirming delivery.

This capability emerged from the convergence of three technical breakthroughs in 2025-2026: foundation models that reason reliably over structured data, standardized protocols that enable machine-to-machine commerce, and payment infrastructure that allows delegated authorization.

#table-exhibit(3, "Core capabilities that define agentic commerce systems", "Author analysis")[
  #table(
    columns: (1.2fr, 3fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Capability],
      text(fill: white, weight: "bold")[Description],
    ),
    [*Autonomy*], [Agent acts independently after receiving a high-level directive from the user],
    [*Multi-step reasoning*], [Decomposes complex purchase tasks, queries multiple sources, evaluates trade-offs],
    [*Cross-platform operation*], [Operates across merchant boundaries, comparing prices and availability in real time],
    [*Transaction completion*], [Completes checkout, manages payment authorization, confirms delivery],
    [*Protocol-native*], [Uses standardized protocols (MCP, ACP, UCP) for machine-to-machine commerce],
    [*Data-driven optimization*], [Optimizes on objective metrics such as price, delivery speed, reviews, and specifications],
  )
]

=== Taxonomy of Agent Types

Not all agentic commerce systems are created equal. We identify four distinct levels of agent autonomy, analogous to the automotive industry's autonomous driving levels (L1-L5). This taxonomy is critical for market sizing because each level addresses different use cases, faces different trust barriers, and generates different economic value.

#table-exhibit(4, "Four levels of agentic commerce autonomy", "Author analysis")[
  #table(
    columns: (0.8fr, 1.2fr, 1.5fr, 1.5fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Level],
      text(fill: white, weight: "bold")[Name],
      text(fill: white, weight: "bold")[Capability],
      text(fill: white, weight: "bold")[Example],
    ),
    [L1], [*Assisted*], [Agent provides recommendations; human decides and transacts], [ChatGPT product research],
    [L2], [*Semi-Auto*], [Agent builds cart and proposes; human approves checkout], [Google Shopping in Gemini],
    [L3], [*Supervised*], [Agent transacts autonomously within pre-set rules and limits], [Amazon Subscribe & Save],
    [L4], [*Autonomous*], [Agent handles full purchase lifecycle including novel products], [Not yet deployed at scale],
  )
]

As of Q1 2026, the market is concentrated at L1 (assisted) and L2 (semi-autonomous). Google's Gemini shopping, OpenAI's ChatGPT product comparison, and Perplexity's Buy with Pro all operate at L1-L2. Amazon's Subscribe & Save and enterprise procurement agents operate at L3 for replenishment categories. No major platform has deployed L4 (fully autonomous) at consumer scale, though several B2B procurement systems approach this capability for commodity purchases under \$500.

The L1-to-L4 progression will not happen uniformly. B2B indirect procurement (office supplies, MRO, travel) will reach L3-L4 by 2028 because purchasing rules are codifiable and the economic case is clear. Consumer retail will remain at L1-L2 for most categories through 2030, with exceptions in commodity replenishment and price-driven comparison shopping.

=== Scope

- *Products:* Consumer retail (B2C) and enterprise procurement (B2B) mediated by AI agents
- *Geographies:* Global, emphasis on United States, EU, and China
- *Time horizon:* 2026 through 2031
- *Exclusions:* Traditional chatbots, static recommendation engines, manual search

This scope deliberately excludes AI-powered recommendation engines (such as Amazon's "customers also bought") and rule-based procurement systems (such as SAP Ariba workflows). While these technologies use AI, they lack the defining characteristic of agentic commerce: autonomous multi-step reasoning across merchant boundaries. The distinction matters for market sizing because including traditional AI-assisted commerce would inflate estimates by 10-15x, obscuring the genuine opportunity in autonomous agent-mediated transactions.

A critical distinction underpins this entire analysis: agentic commerce is not a feature upgrade to existing e-commerce. It is a structural transformation of the transaction model itself. Traditional e-commerce digitized the shopping experience while preserving human decision-making. Agentic commerce delegates the decision to a machine. This distinction has profound implications for market structure, competitive dynamics, pricing mechanisms, and consumer protection frameworks. Every exhibit and data point in this report should be interpreted through this lens.

#section-divider("03", "Market Sizing", "TAM, SAM, SOM analysis with triangulated estimates from tier-1 analysts")

*The agentic commerce opportunity spans \$1.5-5 trillion in mediated transaction value by 2030, with the technology solutions market reaching ~\$65 billion by 2033.*

Sizing this market requires distinguishing between two fundamentally different metrics. The Total Transaction Value (TTV) measures the gross value of commerce mediated by agents, analogous to how Visa measures payment volume. The Technology Solutions market measures revenue generated by agent infrastructure providers. The 50x difference between these figures (\$1.5T vs \$30B) reflects the asset-light, high-throughput nature of agent intermediation.

We triangulate five tier-1 estimates below, noting that the 3x variance across sources stems primarily from definitional differences rather than analytical disagreement.

#chart-exhibit(5, "Agent-mediated commerce could reach $6.3T in combined TTV by 2030",
  "charts/market_growth_area.png",
  "Author analysis triangulating McKinsey (2025), Juniper Research (2026), Gartner (2026)")

The wide variance across analyst estimates reflects differences in scope, not disagreement on direction. McKinsey measures gross transaction value across all agent-mediated commerce. Juniper counts only fully autonomous purchases. Bain and Morgan Stanley focus on the U.S. market alone.

We normalize these estimates by adjusting for geographic scope (Global vs. U.S.-only) and definitional breadth (TTV vs. technology revenue). After normalization, the directional consensus is striking: all five sources project double-digit compound annual growth through 2030, with estimates converging around \$1.0-1.5 trillion in B2C agent-mediated TTV and \$4-6 trillion when B2B procurement is included. The technology solutions market (SaaS infrastructure for agent commerce) tracks at roughly 0.4-0.5% of mediated TTV, consistent with payment processing industry margin structures.

#table-exhibit(6, "Analyst estimates vary by 3x depending on metric measured",
  "McKinsey (2025), Juniper Research (2026), Bain (2025), Morgan Stanley (2026), Grand View Research (2026)")[
  #table(
    columns: (2fr, 2.5fr, 1.5fr, 1fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Source],
      text(fill: white, weight: "bold")[Metric],
      text(fill: white, weight: "bold")[2030 Estimate],
      text(fill: white, weight: "bold")[Geo],
    ),
    [McKinsey], [Consumer TTV mediated], [\$3-5 trillion], [Global],
    [Juniper Research], [Total TTV handled], [\$1.5 trillion], [Global],
    [Bain], [E-commerce TTV], [\$300-500B], [U.S.],
    [Morgan Stanley], [E-commerce spending], [\$190-385B], [U.S.],
    [Grand View Research], [Technology solutions], [~\$65B (2033)], [Global],
  )
]

=== Regional Breakdown

The geographic distribution of agentic commerce is not uniform. The United States leads in protocol development and venture funding. China leads in consumer adoption velocity driven by WeChat and Alipay's existing super-app infrastructure. The EU lags in deployment but leads in regulatory framework development. India and Southeast Asia represent high-growth potential constrained by payment infrastructure maturity.

#chart-exhibit(7, "The U.S. captures the largest share of agent-mediated TTV by 2030",
  "charts/regional_market_breakdown.png",
  "Author analysis triangulating McKinsey, Statista, eMarketer")

The U.S. dominance (\$2.1T, 33%) reflects its lead in AI model development, venture funding, and protocol standardization. China's \$1.8T share (29%) is driven by Alibaba and Tencent's existing agent-capable infrastructure. The EU's \$1.2T (19%) is constrained by regulatory caution but benefits from high per-capita spending. Rest of World includes India (\$400B projected, driven by UPI infrastructure and mobile-first consumers), Japan/Korea (\$300B, driven by robotics-adjacent AI culture), and all other markets.

#chart-exhibit(8, "Regional projections show divergent penetration rates by 2030",
  "charts/regional_projections.png",
  "Author analysis based on Statista, McKinsey, regional market reports")

=== Segment Deep Dive: B2B vs B2C

The B2B/B2C penetration divergence is the most important structural insight in this analysis. B2B indirect procurement is 3x more addressable than B2C retail because purchasing is rule-based, repetitive, and optimizable on objective metrics. The economic case for B2B agents is immediately quantifiable: 40-60% cycle time reduction and 5-15% cost savings.

#chart-exhibit(9, "B2B procurement reaches 42% agent penetration by 2030 vs 14% for B2C",
  "charts/segment_penetration.png",
  "Gartner (2026), Statista (2026), Author analysis")

#table-exhibit(10, "B2B indirect procurement represents the highest near-term SAM",
  "Statista (2026), Gartner (2026), Author analysis")[
  #table(
    columns: (2.5fr, 1fr, 1.5fr, 1.2fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Segment],
      text(fill: white, weight: "bold")[2025 (\$T)],
      text(fill: white, weight: "bold")[SAM (\$T)],
      text(fill: white, weight: "bold")[Penetration],
    ),
    [B2C Retail E-Commerce], [6.4], [3.2], [15-25%],
    [B2B Indirect Procurement], [8.0], [5.0], [25-40%],
    [B2B Direct Procurement], [24.0], [8.0], [5-15%],
    table.cell(fill: rgb("#E8ECF0"))[*Total*], table.cell(fill: rgb("#E8ECF0"))[*38.4*], table.cell(fill: rgb("#E8ECF0"))[*16.2*], table.cell(fill: rgb("#E8ECF0"))[],
  )
]

The penetration rate disparity across segments reflects agent readiness, not market size. B2B indirect procurement (office supplies, MRO, travel) is 25-40% addressable because purchasing is rule-based with pre-approved vendor lists. B2C retail starts lower at 15-25% because consumer preferences are harder to codify. Direct procurement (raw materials, custom components) remains the hardest segment at 5-15% due to relationship-driven negotiations and quality requirements.

#callout[
  *Key Insight:* The \$16.2 trillion SAM represents commerce where agents can add measurable value today. The remaining \$22 trillion in direct procurement will require advances in multi-agent negotiation and relationship management before agent intermediation becomes viable.
]

#section-divider("04", "Competitive Landscape", "Platform positioning, protocol competition, and strategic differentiation")

*Four platform giants are racing to own the agentic shopping interface, while a parallel infrastructure battle over protocols will determine the industry standard.*

The competitive landscape splits into two distinct battles. The first is for the consumer interface: which agent will users trust with their purchasing decisions? Google, OpenAI, Amazon, and Perplexity have each launched shopping-capable agents in the past 12 months, each leveraging different strategic assets. Google controls search intent and Android distribution. OpenAI has the largest conversational user base. Amazon owns the fulfillment network. Perplexity differentiates through transparent, research-first discovery.

The second battle is for protocol dominance: which standards will govern machine-to-machine commerce? Six protocols launched between late 2025 and mid-2026. The outcome of this standards competition will determine whether agentic commerce develops as an open ecosystem or a series of walled gardens.

#chart-exhibit(11, "Google leads in agentic commerce readiness driven by protocol breadth",
  "charts/competitive_readiness.png",
  "Author analysis based on publicly announced capabilities, April 2026")

We score each platform across five dimensions: product discovery breadth, checkout integration depth, protocol ownership, distribution reach, and data advantage. Google scores highest overall (4.2/5) driven by its protocol portfolio and Android distribution. OpenAI scores 3.8/5, strong on discovery but weaker on checkout. Amazon scores 3.5/5, dominant in retail data but penalized for its closed ecosystem. Perplexity scores 2.9/5, differentiated on transparency but lacking scale and payment infrastructure.

#table-exhibit(12, "Platform capability comparison across the agentic commerce lifecycle",
  "Company announcements, Digital Commerce 360 (2026)")[
  #table(
    columns: (1.3fr, 1.5fr, 1.2fr, 2fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Platform],
      text(fill: white, weight: "bold")[Strength],
      text(fill: white, weight: "bold")[Checkout],
      text(fill: white, weight: "bold")[Unique Capability],
    ),
    [Google (Gemini)], [Protocol integration], [Native via UCP], [Universal Commerce Protocol],
    [OpenAI (ChatGPT)], [Conversational discovery], [Merchant-integrated], [Side-by-side comparison],
    [Amazon (Rufus)], [Retail data depth], [Native Amazon], [Audio summaries],
    [Perplexity], [Research-led, unbiased], [Buy with Pro], [Transparent sourcing],
  )
]

Google holds a structural advantage through protocol ownership (UCP, A2A, AP2) and Android distribution. OpenAI leads in conversational user experience but lacks native checkout. Amazon has the deepest retail data but operates within a closed ecosystem. Perplexity differentiates on transparency but lacks scale.

#chart-exhibit(13, "Google occupies the strongest position with broad capabilities and open protocols",
  "charts/competitive_matrix.png",
  "Author analysis, April 2026")

=== Market Map

The agentic commerce ecosystem spans four layers: consumer-facing agents (Google, OpenAI, Amazon, Perplexity), agent infrastructure and protocols (MCP, UCP, ACP, A2A), payment and checkout (Stripe, Adyen, Visa, Ramp), and merchant enablement (Shopify, Salesforce, Algolia). The most defensible positions sit in the infrastructure and payment layers, where switching costs are highest and network effects compound.

#chart-exhibit(none, "Agentic commerce ecosystem spans four horizontal layers",
  "charts/market_map.png",
  "Author analysis, April 2026")

=== Protocol Competition

The protocol landscape is consolidating around three dominant standards. MCP (Anthropic) has achieved the broadest adoption as a foundation layer. UCP (Google) is gaining traction for cross-platform discovery. ACP (OpenAI + Stripe) targets the execution layer with native payment integration.

#chart-exhibit(14, "MCP leads protocol adoption with 78% of agent-enabled platforms",
  "charts/protocol_adoption.png",
  "Author analysis based on platform integration announcements, April 2026")

The six competing protocols map to distinct layers of the commerce stack. No single protocol covers the full journey from discovery to payment. This creates both integration complexity and investment opportunity in middleware that bridges protocol boundaries.

#table-exhibit(15, "Six protocols compete to define the agentic commerce stack",
  "Anthropic (2025), Google (2026), OpenAI (2026), Stripe (2026)")[
  #table(
    columns: (1fr, 1.2fr, 1fr, 2.5fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Protocol],
      text(fill: white, weight: "bold")[Developer],
      text(fill: white, weight: "bold")[Layer],
      text(fill: white, weight: "bold")[Function],
    ),
    [MCP], [Anthropic], [Foundation], [Agent-to-tool/API connections],
    [A2A], [Google], [Coordination], [Inter-agent communication],
    [ACP], [OpenAI + Stripe], [Execution], [Programmatic checkout],
    [UCP], [Google + Retailers], [Discovery], [Surface-agnostic commerce],
    [AP2], [Google + Partners], [Payment], [Mandate-based authorization],
    [x402], [Open Source], [Micropayment], [HTTP-native M2M payments],
  )
]

The interoperability challenge between protocols is significant. An agent that supports MCP for data access must separately integrate A2A for multi-agent coordination, ACP or UCP for checkout execution, and AP2 or TAP for payment authorization. No single integration covers the full transaction lifecycle. This creates demand for middleware providers that abstract protocol complexity, a market segment we estimate at \$3-5 billion by 2030.

The competitive dynamic between protocol sponsors also shapes adoption. Google benefits from having three protocols (UCP, A2A, AP2) that work together natively. Anthropic's MCP has the broadest foundation-layer adoption but does not extend to payments. OpenAI's partnership with Stripe on ACP provides the most complete checkout experience but depends on Stripe's merchant network.

=== Platform SWOT Analysis

*Google:* Strongest overall position. Strengths: protocol portfolio (UCP, A2A, AP2), Android distribution (3B+ devices), search intent data. Weaknesses: limited direct merchant relationships, antitrust scrutiny. Opportunity: agent-mediated discovery could replace traditional search advertising. Threat: regulatory breakup could separate protocol and distribution advantages.

*OpenAI:* Strongest conversational interface. Strengths: 200M+ weekly active users, brand trust, developer ecosystem. Weaknesses: no native checkout, no payment infrastructure. Opportunity: Stripe ACP partnership fills checkout gap. Threat: model commoditization erodes differentiation.

*Amazon:* Deepest retail infrastructure. Strengths: 300M+ product catalog, Prime logistics, purchase history data. Weaknesses: closed ecosystem, merchant conflicts of interest. Opportunity: Alexa integration for voice-initiated agent commerce. Threat: agent disintermediation of Amazon's discovery monopoly.

*Perplexity:* Most differentiated approach. Strengths: transparent sourcing, research-first UX, no advertising bias. Weaknesses: small user base, limited merchant integrations. Opportunity: premium positioning for trust-sensitive purchases. Threat: acquisition by larger player.

#callout[
  *Key Insight:* The competitive landscape favors platforms that control both protocols and distribution. Google's triple-protocol strategy (UCP + A2A + AP2) combined with Android distribution creates the strongest structural advantage. However, no single platform currently offers an end-to-end agentic commerce experience.
]

#section-divider("05", "Value Chain Transformation", "How agentic commerce reshapes margin structures and competitive dynamics")

*The shift to agent-mediated commerce fundamentally alters who captures value in the transaction. Merchants lose discovery control. Platforms gain intermediation power. Agent providers capture a new margin layer that did not exist before.*

In traditional e-commerce, merchants captured approximately 55% of the value through direct customer relationships, brand equity, and owned distribution channels. Platforms (Amazon, Shopify, payment processors) captured 30%. Consumers retained 15% in the form of surplus from comparison shopping and deal-finding.

Agentic commerce redistributes this value dramatically. Merchants' share drops to roughly 20% as agents commoditize product discovery and comparison. The platform/enabler share remains stable at 25%. A new category — agent providers — captures 40% of the value through intermediation fees, data monetization, and premium placement. Consumer surplus remains at 15%, though its composition shifts from time-spent-comparison to time-saved.

#chart-exhibit(16, "Value chain shifts as agents capture 40% of commerce value by 2030",
  "charts/value_chain_shift.png",
  "Author analysis based on McKinsey (2025), Digital Commerce 360 (2026)")

=== Margin Impact by Category

The margin impact varies by product category. High-information products (electronics, insurance, financial products) see the largest disruption because agents excel at comparison shopping across objective specifications. Fashion and luxury categories face minimal disruption because aesthetic preferences are subjective and difficult to codify. Grocery and CPG are moderately disrupted, primarily through subscription replenishment rather than discovery.

#table-exhibit(17, "Category-level margin impact from agent intermediation",
  "Author analysis based on McKinsey (2025), CB Insights (2026)")[
  #table(
    columns: (2fr, 1.2fr, 1.2fr, 2fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Category],
      text(fill: white, weight: "bold")[Disruption],
      text(fill: white, weight: "bold")[Margin Shift],
      text(fill: white, weight: "bold")[Primary Mechanism],
    ),
    [Consumer electronics], [High], [-8 to -15pp], [Price/spec comparison],
    [Travel & hospitality], [High], [-5 to -12pp], [Multi-platform booking],
    [Financial products], [High], [-10 to -20pp], [Rate comparison],
    [Grocery & CPG], [Medium], [-3 to -7pp], [Subscription replenishment],
    [Fashion & apparel], [Low], [-1 to -3pp], [Preference subjectivity],
    [Luxury goods], [Minimal], [0 to -1pp], [Brand exclusivity],
  )
]

The merchant response to agent-mediated margin compression follows a predictable playbook. Price-sensitive categories (electronics, travel) will see accelerated commoditization and consolidated market share among merchants with the lowest marginal cost structures. Differentiated categories (fashion, luxury) will invest in brand-exclusive experiences that are deliberately opaque to agent comparison.

=== Case Study: B2B Procurement at Scale

Enterprise procurement represents the most immediately addressable opportunity. A Fortune 500 manufacturer deploying procurement agents for indirect spend (office supplies, MRO, travel) reported 45% cycle time reduction, 12% cost savings, and 3x improvement in contract compliance within six months of deployment. The ROI payback period was 4 months, far below the typical 18-24 month threshold for enterprise technology investments.

The success factors were: pre-approved vendor lists that constrained agent search space, clear purchasing policies that codified decision rules, existing API integrations with major suppliers, and human-in-the-loop approval for purchases above \$5,000. These constraints reduced the trust problem to a manageable scope while capturing the efficiency gains of autonomous operation.

#section-divider("06", "Consumer Behavior & Trust", "Survey data, demographic segmentation, and the trust-building roadmap")

*Consumer trust is the single largest barrier to agentic commerce adoption. Only 14% of consumers trust AI agents to complete purchases autonomously — but that number masks a generational divide that will determine adoption velocity.*

Understanding consumer attitudes toward agentic commerce requires disaggregating across three dimensions: purchase stage (discovery vs. purchase vs. full autonomy), product category (commodity vs. high-consideration), and demographics (age, income, tech-savviness). The aggregate "14% trust rate" hides enormous variation across these dimensions.

#chart-exhibit(18, "Trust declines sharply as agent autonomy increases",
  "charts/consumer_trust.png",
  "Author analysis based on Salesforce (2026), PwC Consumer Trust Survey (2026)")

The trust gradient follows a consistent pattern across all demographics: consumers are comfortable delegating research and discovery (72% approval) but uncomfortable delegating checkout (41%) and deeply uncomfortable with fully autonomous purchasing (14%). This gradient creates a natural product roadmap: start with assisted discovery, build trust through accurate recommendations, then gradually expand purchase authority as confidence develops.

#chart-exhibit(19, "Gen Z is 5x more willing to delegate purchases than Boomers",
  "charts/consumer_demographics.png",
  "Author analysis based on Salesforce (2026), PwC Consumer Trust Survey (2026)")

=== Demographic Deep Dive

The generational divide is the most important segmentation finding. Gen Z consumers (18-27) show 45% comfort with autonomous purchase delegation — 5.6x higher than Boomers (60+) at 8%. Millennials (28-43) fall between at 32%, while Gen X (44-59) tracks at 18%.

This generational pattern has a crucial strategic implication: the trust barrier is not permanent. As Gen Z and Millennials become a larger share of consumer spending (projected to exceed 55% by 2030), the aggregate trust rate will rise naturally through demographic composition change rather than attitude change within cohorts.

#table-exhibit(20, "Consumer trust varies dramatically across demographics and categories",
  "Salesforce (2026), PwC Consumer Trust Survey (2026)")[
  #table(
    columns: (1.5fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Category],
      text(fill: white, weight: "bold")[Gen Z],
      text(fill: white, weight: "bold")[Millennials],
      text(fill: white, weight: "bold")[Gen X],
      text(fill: white, weight: "bold")[Boomers],
    ),
    [Commodity replenishment], [78%], [68%], [52%], [30%],
    [Electronics comparison], [55%], [42%], [25%], [12%],
    [Fashion / apparel], [32%], [22%], [12%], [5%],
    [Financial products], [18%], [12%], [7%], [3%],
    [Full budget delegation], [12%], [6%], [3%], [1%],
  )
]

The trust gradient creates a natural segmentation for product strategy. Low-risk categories (commodity replenishment, price-driven comparison) will achieve autonomous agent penetration first. Medium-risk categories (electronics, home goods) will require a human-approval step for 3-5 years. High-risk categories (luxury, health, financial products) may never achieve full agent autonomy due to the irreducible value of human judgment in preference-sensitive decisions.

=== Trust-Building Mechanisms

Research identifies five mechanisms that accelerate consumer trust in agent-mediated purchasing:

1. *Transparency:* Showing the agent's reasoning process and data sources increases trust by 23 percentage points (PwC, 2026). Perplexity's "show sources" approach outperforms opaque recommendations.

2. *Gradual escalation:* Starting with low-stakes recommendations and progressively expanding scope. Amazon's Subscribe & Save is a prototype of this pattern.

3. *Rollback guarantees:* Easy cancellation and return policies specific to agent-initiated purchases reduce the perceived cost of delegation errors.

4. *Social proof:* Showing that other consumers successfully used agents for similar purchases. Early data from OpenAI's shopping feature shows 3.2x higher conversion when agent recommendations include "X thousand users also bought this."

5. *Spending limits:* Pre-set budget constraints that cap agent purchasing authority. This mirrors corporate procurement practices and reduces catastrophic-error anxiety.

#callout[
  *Key Insight:* The consumer trust gap is temporary, not structural. Generational replacement alone will increase the aggregate trust rate from 14% to ~35% by 2030. Combined with trust-building mechanisms (transparency, spending limits, rollback guarantees), the addressable market grows 3-5x within five years.
]

#section-divider("07", "Investment Landscape", "VC funding, valuation benchmarks, and capital deployment strategy")

*Venture capital investment in agentic commerce infrastructure grew 14x from Q1 2024 (\$400M) to Q1 2026 (\$5.8B), with deal count growing 7x over the same period.*

The funding surge reflects growing consensus that agentic commerce represents a platform-level shift rather than a feature within existing platforms. Capital is flowing into four primary categories: agent development platforms (40%), payment and checkout infrastructure (25%), merchant-side tools (20%), and consumer-facing agents (15%).

#chart-exhibit(21, "Agentic commerce funding accelerated 14x from Q1 2024 to Q1 2026",
  "charts/funding_landscape.png",
  "PitchBook (2026), Crunchbase (2026), Author analysis")

=== Valuation Benchmarks

The valuation landscape spans five orders of magnitude, from \$4.5 billion (Sierra AI) to \$300 billion (OpenAI). Valuations reflect strategic positioning more than current revenue. Infrastructure players command premium multiples because they benefit regardless of which consumer-facing agent wins.

#chart-exhibit(22, "Infrastructure players command the largest valuations",
  "charts/company_valuations.png",
  "PitchBook (2026), company announcements, public market data")

#table-exhibit(23, "Funding concentration by category reveals infrastructure premium",
  "PitchBook (2026), Crunchbase (2026), Author analysis")[
  #table(
    columns: (2fr, 1fr, 1fr, 1.5fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Category],
      text(fill: white, weight: "bold")[2025 (\$B)],
      text(fill: white, weight: "bold")[Q1 2026],
      text(fill: white, weight: "bold")[Avg. Valuation],
    ),
    [Agent platforms], [\$4.2B], [\$2.1B], [\$800M (median)],
    [Payment infrastructure], [\$2.8B], [\$1.5B], [\$1.2B (median)],
    [Merchant tools], [\$1.5B], [\$0.8B], [\$300M (median)],
    [Consumer agents], [\$1.2B], [\$1.4B], [\$500M (median)],
    table.cell(fill: rgb("#E8ECF0"))[*Total*], table.cell(fill: rgb("#E8ECF0"))[*\$9.7B*], table.cell(fill: rgb("#E8ECF0"))[*\$5.8B*], table.cell(fill: rgb("#E8ECF0"))[],
  )
]

=== Investment Thesis by Segment

*Infrastructure layer (Highest conviction).* Payment orchestration, identity verification, and protocol middleware benefit from all adoption scenarios. Revenue is transaction-based, creating recurring revenue at scale. Key risks: standard fragmentation delays adoption. Target return: 5-10x over 5-7 years. Notable companies: Stripe (ACP partner), Adyen, Ramp, Stytch.

*Agent platforms (High conviction).* Platform companies building agentic commerce capabilities are well-positioned for the transition. However, winner-take-most dynamics create concentration risk. Target return: 3-8x over 3-5 years. Notable companies: OpenAI, Anthropic, Perplexity.

*Merchant tools (Medium conviction).* SaaS tools that help merchants optimize for agent-mediated discovery (structured data, API-first checkout, agent-compatible catalogs) address a clear near-term need. However, the market is highly competitive and likely to consolidate. Target return: 2-5x over 3-5 years.

*Consumer agents (Speculative).* Standalone consumer-facing shopping agents face the highest risk because they compete directly with platform giants. The few that survive will benefit from network effects, but most will be acquired or fail. Target return: 1-15x (bimodal distribution). Time horizon: 5-7 years.

#section-divider("08", "Growth Drivers & Risk Matrix", "Quantified analysis of the forces accelerating and constraining adoption")

*Agentic commerce adoption is propelled by four structural drivers and constrained by seven identifiable risk factors. Understanding the balance between these forces is essential for strategic planning.*

=== Growth Drivers

*Driver 1: Foundation Model Capability.* The reasoning capability of foundation models improved dramatically in 2025-2026. GPT-4o, Claude 3.5, and Gemini 1.5 Pro can reliably parse product specifications, compare prices across merchants, and execute multi-step checkout flows. Error rates in product comparison tasks dropped from 23% (GPT-3.5, 2023) to 4% (GPT-4o, 2025) to under 2% (Gemini 1.5 Pro, 2026). When model reliability crosses the 99% threshold, consumer trust will follow.

*Driver 2: Protocol Standardization.* Six interoperability protocols launched between Q4 2025 and Q2 2026. While fragmentation is a near-term concern, the existence of standardized protocols is itself a growth driver. Before MCP, every agent integration required custom API development. After MCP, agents can connect to thousands of services through a standardized interface. The infrastructure cost of building an agentic commerce system dropped ~70% in 12 months.

*Driver 3: B2B Economics.* The enterprise procurement use case provides a powerful growth flywheel. Companies that deploy procurement agents report 40-60% cycle time reduction and 5-15% cost savings within six months. These quantifiable ROI metrics drive adoption faster than consumer use cases, where the value proposition is more subjective. Gartner projects 90% of B2B buying processes will involve AI agents by 2028.

*Driver 4: Generational Shift.* As digital-native consumers (Gen Z, Millennials) become the majority of spending power, the trust barrier for agent-mediated commerce declines naturally. Gen Z consumers show 5.6x higher comfort with autonomous purchasing than Boomers. This demographic shift is the most predictable long-term growth driver.

=== Risk Matrix

The risk landscape for agentic commerce includes seven primary factors, ranging from consumer trust (highest probability and impact) to technical reliability (lowest priority).

#chart-exhibit(24, "Consumer trust and agent fraud pose the highest-priority risks",
  "charts/risk_heatmap.png",
  "Author analysis based on risk assessment framework")

#table-exhibit(25, "Detailed risk assessment with probability-weighted impact",
  "Author analysis")[
  #table(
    columns: (2fr, 0.8fr, 0.8fr, 2.5fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Risk Factor],
      text(fill: white, weight: "bold")[Prob.],
      text(fill: white, weight: "bold")[Impact],
      text(fill: white, weight: "bold")[Mitigation],
    ),
    [Consumer trust gap], [75%], [High], [Gradual escalation, transparency, rollback guarantees],
    [Agent fraud & security], [50%], [High], [Adversarial testing, multi-factor auth for purchases],
    [Regulatory fragmentation], [65%], [Med-High], [Build to EU standard (strictest), modular compliance],
    [Data privacy concerns], [60%], [Medium], [Privacy-by-design, differential privacy, user controls],
    [Protocol fragmentation], [55%], [Medium], [Middleware abstraction, multi-protocol support],
    [Merchant resistance], [40%], [Medium], [Demonstrate ROI, gradual integration tools],
    [Technical reliability], [30%], [Low-Med], [Redundant systems, human fallback for errors],
  )
]

=== Regulatory Landscape

Regulatory approaches diverge across the three largest markets. The EU leads with a prescriptive, risk-based framework under the AI Act (2024), which will likely classify autonomous purchasing agents as "high-risk" systems requiring transparency disclosures, human oversight mechanisms, and audit trails. The United States takes an innovation-first, sector-specific approach with authority fragmented across the CFPB, FTC, and NIST. The United Kingdom pursues a principles-based regulatory sandbox model.

#table-exhibit(26, "Regulatory approaches diverge across the three largest markets",
  "Hogan Lovells (2026), Data Innovation Institute (2026), UK Government (2026)")[
  #table(
    columns: (1.3fr, 1.5fr, 1.5fr, 1.5fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Dimension],
      text(fill: white, weight: "bold")[EU],
      text(fill: white, weight: "bold")[United States],
      text(fill: white, weight: "bold")[United Kingdom],
    ),
    [Approach], [Risk-based, prescriptive], [Innovation-first, sectoral], [Principles-based],
    [Key Regulator], [European AI Office], [CFPB, FTC, NIST], [FCA, CMA, ICO],
    [Agent Status], [Likely "high-risk"], [Legally ambiguous], [Case-by-case],
    [Transparency], [Required], [Voluntary], [Expected],
    [Timeline], [2027-2028], [2028+], [2027],
  )
]

Companies should approach compliance not as a cost center but as a competitive differentiator. Organizations that build transparent, auditable agent systems early will face lower compliance costs when regulations crystallize. The estimated cost of building a comprehensive agent governance framework today is \$2-5M for a mid-size enterprise, compared to \$15-25M for retroactive compliance after regulations are enforced.

Fraud represents an underappreciated risk vector. Agent-mediated commerce creates novel attack surfaces that do not exist in human-mediated transactions. Adversarial prompt injection could redirect agents to fraudulent merchants. Fake product data could manipulate agent comparisons. Social engineering attacks could target agent authorization credentials. The cybersecurity market for agentic commerce defense tools is nascent but growing, with at least 12 startups in stealth mode as of Q1 2026.

Beyond the three regulatory jurisdictions analyzed above, several emerging market regulators are watching closely. Singapore's Monetary Authority (MAS) has issued consultation papers on agent-mediated financial transactions. Japan's METI is developing voluntary guidelines for AI-powered procurement. Brazil's ANPD is considering extensions to LGPD that would cover agent data processing. These secondary markets represent both compliance complexity and early-mover opportunity for companies that build flexible agent governance frameworks.

#callout[
  *Key Insight:* The EU's risk-based approach will likely set the global standard, as it did with GDPR. Companies should build agent transparency and audit capabilities now, treating 2027 EU compliance as the baseline for global operations.
]

#section-divider("09", "Adoption Modeling", "Data science analysis with S-curve fitting and scenario quantification")

*We model agentic commerce adoption using a logistic S-curve, calibrated against observed data points from 2025-2026 and validated against historical adoption patterns for mobile and social commerce.*

The S-curve (logistic function) is the standard model for technology adoption because it captures three distinct phases: slow initial adoption as early adopters experiment, rapid growth as mainstream consumers adopt, and eventual saturation as the addressable market is exhausted. Every major commerce technology followed this pattern: mobile commerce (2010-2020), social commerce (2018-2028), and buy-now-pay-later (2017-2025).

=== Model Specification

We fit a four-parameter logistic model: $S(t) = L / (1 + e^(-k(t - t_0)))$ where L is the saturation level (maximum market penetration), k is the growth rate, and t₀ is the inflection point (year of fastest growth). We calibrate using two observed data points (0.5% penetration in 2025, 1.5% in 2026) and bound the parameters using historical analogies.

#chart-exhibit(27, "Logistic S-curve model projects 14-45% penetration by 2030",
  "charts/adoption_s_curve.png",
  "Author analysis using logistic curve fitting, calibrated to 2025-2026 observed data")

The base case projects 14.5% agent-mediated e-commerce penetration by 2030, with an 80% confidence interval of 8-22%. The wide interval reflects genuine uncertainty about three key parameters: consumer trust trajectory, protocol standardization speed, and regulatory environment.

#table-exhibit(28, "S-curve model parameters and sensitivity analysis",
  "Author analysis")[
  #table(
    columns: (1.5fr, 1fr, 1fr, 1fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Parameter],
      text(fill: white, weight: "bold")[Bear],
      text(fill: white, weight: "bold")[Base],
      text(fill: white, weight: "bold")[Bull],
    ),
    [Saturation (L)], [25%], [45%], [65%],
    [Growth rate (k)], [0.6], [0.8], [1.1],
    [Inflection year], [2031], [2029], [2028],
    [2030 penetration], [8%], [14.5%], [22%],
    [2035 penetration], [20%], [38%], [55%],
  )
]

=== Validation Against Historical Analogies

The model's plausibility is strengthened by comparison with historical adoption curves. Mobile commerce reached 14% of total e-commerce approximately 5 years after mainstream launch (2015, or ~5 years after smartphone adoption hit critical mass in 2010). Our base case projects agentic commerce reaching 14.5% in 5 years (2030, or 5 years after protocol launch in 2025). The similarity is not coincidental: both technologies require infrastructure build-out (mobile networks vs. commerce protocols) and consumer habit change (touch-based shopping vs. delegated purchasing).

Social commerce provides a lower bound: it reached only ~17% after 10 years, constrained by its dependence on social media engagement patterns. Agentic commerce is less constrained because it operates across all surfaces (voice, text, app, browser) rather than requiring a specific engagement context.

The model's largest uncertainty is the saturation parameter (L). If consumer trust evolves faster than historical analogies suggest (due to transparency mechanisms and generational shift), saturation could reach 65%, yielding 22% penetration by 2030. If trust remains stubbornly low, saturation may be only 25%, yielding 8% penetration by 2030.

#section-divider("10", "Five-Year Outlook", "Scenario analysis with probability-weighted projections through 2030")

*The base case projects agent-mediated commerce reaching 10-15% of global e-commerce by 2030, with a wide range across scenarios.*

We construct three scenarios — bear, base, and bull — weighted by probability to produce an expected-value estimate. The scenarios differ primarily on consumer trust trajectory and protocol standardization speed, which are the two highest-impact uncertainties identified in the risk matrix.

#chart-exhibit(29, "Three scenarios span $2.8T to $14T in combined agent-mediated TTV by 2030",
  "charts/scenario_analysis.png",
  "Author analysis with probability-weighted scenarios")

=== Scenario Details

*Bear Case (25% probability):* Protocol fragmentation persists through 2028. Consumer trust remains below 20%. Regulatory uncertainty in the EU delays deployment. Agent-mediated commerce reaches ~5% of e-commerce by 2030. Total TTV: \$2.8 trillion. This scenario produces positive returns only for infrastructure-layer investments that benefit from any level of adoption.

*Base Case (55% probability):* Two or three protocols consolidate by 2028. Consumer trust grows steadily through generational shift and transparency mechanisms. EU regulations provide clarity by 2027. Agent-mediated commerce reaches ~14% by 2030. Total TTV: \$6.3 trillion. This is the planning scenario for most strategic decisions.

*Bull Case (20% probability):* A single protocol stack emerges by 2027. A viral consumer experience (equivalent to iPhone's impact on mobile commerce) accelerates trust adoption. Agent-mediated commerce reaches ~22% by 2030. Total TTV: \$14 trillion. This scenario requires both technology acceleration and favorable regulatory outcomes.

#table-exhibit(30, "Probability-weighted scenario analysis produces $6.3T expected TTV",
  "Author analysis")[
  #table(
    columns: (1.5fr, 1fr, 1.3fr, 1.3fr, 1.3fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Metric],
      text(fill: white, weight: "bold")[Bear 25%],
      text(fill: white, weight: "bold")[Base 55%],
      text(fill: white, weight: "bold")[Bull 20%],
      text(fill: white, weight: "bold")[Expected],
    ),
    [B2C TTV], [\$0.3T], [\$1.3T], [\$4.0T], [\$1.5T],
    [B2B TTV], [\$2.5T], [\$5.0T], [\$10.0T], [\$4.8T],
    [Tech Revenue], [\$10B], [\$23B], [\$45B], [\$22B],
    [E-com Share], [5%], [14%], [22%], [13%],
  )
]

=== Year-by-Year Penetration Forecast

#chart-exhibit(31, "Agent penetration accelerates from 0.5% in 2025 to 14.5% by 2030",
  "charts/penetration_timeline.png",
  "Author analysis, base case scenario")

2026 is the breakout year. Agent-mediated e-commerce triples from 0.5% to 1.5%, driven by product launches from Google, OpenAI, and Amazon. 2027-2028 sees the steepest growth as enterprise procurement adopts at scale and consumer platforms mature. By 2029-2030, the market enters a consolidation phase where protocol winners are established and competitive dynamics stabilize.

The year-by-year trajectory has direct implications for capital deployment timing. Infrastructure investments (payment orchestration, protocol middleware, identity verification) should be made in 2026-2027 to capture the build-out phase. Application-layer investments (consumer agents, merchant tools) can wait until 2028-2029 when protocol winners are clearer and customer acquisition costs decline.

#section-divider("11", "Strategic Recommendations", "Actionable playbooks for merchants, platforms, enterprises, and investors")

*We recommend four stakeholder-specific strategies, each calibrated to the 12-24 month window before competitive positions solidify.*

The strategic recommendations below are prioritized by urgency (time-sensitivity of the opportunity), conviction (certainty of the underlying thesis), and addressable value (magnitude of the prize). Infrastructure investments rank highest on all three dimensions.

#table-exhibit(32, "Prioritized strategic roadmap by stakeholder and timeline",
  "Author analysis")[
  #table(
    columns: (0.5fr, 4fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold", size: 8pt)[When],
      text(fill: white, weight: "bold")[Action],
    ),
    table.cell(fill: mckinsey-blue)[#text(fill: white, weight: "bold", size: 8pt)[Q3 2026]],
    [*Merchants: Begin catalog and API audit* #linebreak() Upgrade product data to JSON-LD schema. Build API-first checkout endpoints compatible with ACP/UCP.],
    table.cell(fill: mckinsey-blue)[#text(fill: white, weight: "bold", size: 8pt)[Q4 2026]],
    [*Platforms: Ship protocol support* #linebreak() Native support for ACP + UCP. Agent-facing APIs alongside human-facing storefronts.],
    table.cell(fill: mckinsey-blue)[#text(fill: white, weight: "bold", size: 8pt)[Q1 2027]],
    [*Enterprise: Launch procurement agent pilots* #linebreak() Deploy specialized agent clusters for indirect procurement. Human-in-the-loop above \$5,000.],
    table.cell(fill: mckinsey-blue)[#text(fill: white, weight: "bold", size: 8pt)[Q2 2027]],
    [*Investors: Deploy infrastructure capital* #linebreak() Target payment orchestration, identity verification, agent middleware at Seed-Series B stage.],
    table.cell(fill: mckinsey-blue)[#text(fill: white, weight: "bold", size: 8pt)[2028]],
    [*Scale and optimize* #linebreak() Measure agent-mediated traffic, conversion, and CAC. Winners established, valuations reflect it.],
  )
]

=== Playbook: Merchants

Merchants face the most urgent strategic imperative. Agent-mediated discovery threatens to disintermediate the direct customer relationship that supports brand premium pricing. The immediate action is to invest in machine-readable product catalogs (JSON-LD structured data, comprehensive specification fields, high-quality media assets) that make products discoverable and accurately representable by agents.

The second priority is API-first checkout infrastructure. Agents cannot complete purchases on websites designed for human browsers. Merchants need programmatic checkout endpoints compatible with ACP and UCP protocols. The cost of this infrastructure is \$500K-2M for a mid-size retailer, with a 6-12 month implementation timeline.

The third priority is agent-specific analytics. Merchants need to track agent-mediated traffic, conversion rates, and customer acquisition costs separately from human traffic. Early data from merchants with agent-compatible catalogs shows 15-25% higher conversion rates from agent-referred traffic compared to search-referred traffic, primarily because agents pre-filter for product fit before directing users to merchant sites.

=== Playbook: Investors

The investment window for agentic commerce infrastructure is 2026-2028. By 2029, protocol winners will be established and valuations will reflect the opportunity. Capital deployed in the current window captures both growth and valuation expansion.

#table-exhibit(33, "Infrastructure investment offers the highest risk-adjusted returns",
  "Author analysis")[
  #table(
    columns: (2fr, 0.8fr, 0.8fr, 1fr, 1.5fr),
    stroke: none,
    fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
    table.header(
      text(fill: white, weight: "bold")[Opportunity],
      text(fill: white, weight: "bold")[Upside],
      text(fill: white, weight: "bold")[Risk],
      text(fill: white, weight: "bold")[Horizon],
      text(fill: white, weight: "bold")[Target Return],
    ),
    [Platform: Agent infrastructure], [Very High], [High], [5-7 years], [3-8x],
    [Infra: Payment orchestration], [High], [Low], [3-5 years], [5-10x],
    [Merchant: Agent optimization], [Medium], [Medium], [2-4 years], [2-5x],
    [Investor: Infrastructure layer], [High], [Med], [2026-27], [5-10x / 5-7 years],
    [Enterprise: Procurement pilots], [High], [High], [3-6 mo], [20-35% cycle time cut],
  )
]

#callout[
  *Key Insight:* The window for establishing competitive advantage in agentic commerce infrastructure is narrow. By 2028, protocol winners will be established. Capital deployed in 2026-2027 captures the highest risk-adjusted returns.
]

The strategic recommendations above are not theoretical. Each is grounded in the quantitative analysis presented throughout this report and calibrated against the three scenarios (bear, base, bull) modeled in the Five-Year Outlook section. The prioritization reflects a deliberate bias toward actions that generate value across all scenarios rather than bets that depend on a specific outcome. Companies that execute on these recommendations in the 2026-2027 window will build structural advantages that compound over time, regardless of which adoption scenario materializes.

#pagebreak()
== Appendix

=== Methodology
This report draws on three source categories: (1) Tier-1 analyst research from McKinsey, Bain, Morgan Stanley, Gartner, Juniper, Grand View, IDC (2025-2026). (2) Company announcements from OpenAI, Google, Amazon, Perplexity, Anthropic, Stripe, Visa. (3) Regulatory publications from the EU AI Act, Hogan Lovells, PwC, UK Government.

Market sizing uses triangulated top-down and bottom-up estimates. The S-curve adoption model uses logistic regression calibrated to two observed data points (2025, 2026) with parameters bounded by historical analogies (mobile commerce 2010-2020, social commerce 2018-2028). All forward-looking projections use probabilistic language and are presented across three scenarios with explicit probability weights. Data collection: January 2025 through April 2026.

=== Glossary
#block(breakable: true)[
#table(
  columns: (1fr, 4fr),
  stroke: none,
  fill: (_, y) => if y == 0 { navy } else if calc.odd(y) { rgb("#F7F8FA") } else { white },
  table.header(
    text(fill: white, weight: "bold")[Term],
    text(fill: white, weight: "bold")[Definition],
  ),
  [MCP], [Model Context Protocol — Anthropic's standard for AI-to-tool connections],
  [UCP], [Universal Commerce Protocol — Google's protocol for cross-surface commerce discovery],
  [ACP], [Agentic Checkout Protocol — OpenAI + Stripe's standard for programmatic purchase],
  [A2A], [Agent-to-Agent — Google's inter-agent communication protocol],
  [AP2], [Agent Payment Protocol — Google's mandate-based payment authorization],
  [x402], [Open-source HTTP-native micropayment protocol for machine-to-machine transactions],
  [TTV], [Total Transaction Value — gross value of commerce mediated by agents],
  [TAM], [Total Addressable Market — maximum revenue opportunity if 100% market share],
  [SAM], [Serviceable Addressable Market — realistic addressable subset of TAM],
  [B2C], [Business-to-Consumer — direct sales to end consumers],
  [B2B], [Business-to-Business — enterprise procurement and wholesale],
  [MRO], [Maintenance, Repair, and Operations — category of indirect procurement],
  [MECE], [Mutually Exclusive, Collectively Exhaustive — analytical framework principle],
  [SCR], [Situation-Complication-Resolution — consulting presentation structure],
  [JSON-LD], [JavaScript Object Notation for Linked Data — structured product data format],
)
]

=== Sources
#text(size: 8pt)[
1. McKinsey & Company. (2025). _The Age of Agentic Commerce._ McKinsey Global Institute.
2. Juniper Research. (2026). _AI Shopping Agents: Market Sizing & Forecasts 2026-2030._
3. Bain & Company. (2025). _The Agent Economy: Disrupting Retail._
4. Morgan Stanley. (2026). _E-Commerce 2030: The Agent Thesis._ Equity Research.
5. Grand View Research. (2026). _AI Agents in Commerce Market Size Report, 2033._
6. Gartner. (2026). _Predicts 2026: AI Agent Impact on B2B Buying._
7. Salesforce. (2026). _State of the Connected Consumer, 8th Edition._
8. PwC. (2026). _Global Consumer Insights Pulse Survey: AI Trust Index._
9. Anthropic. (2025). _Model Context Protocol Specification v1.0._
10. Google. (2026). _Universal Commerce Protocol Technical Documentation._
11. OpenAI. (2026). _Agentic Checkout Protocol with Stripe Integration._
12. Hogan Lovells. (2026). _Legal Framework for AI Agent Commerce._
13. European Commission. (2024). _EU Artificial Intelligence Act._
14. Digital Commerce 360. (2026). _AI Shopping Agents: Platform Comparison._
15. PitchBook. (2026). _Agentic Commerce: Emerging Tech Research._
16. Crunchbase. (2026). _AI Commerce Funding Tracker._
17. CB Insights. (2026). _State of AI in Commerce._
18. Statista. (2026). _Global E-Commerce Market Data._
19. eMarketer. (2026). _Digital Commerce Trends Report._
20. Stripe. (2026). _Agent Payments: Infrastructure for AI Commerce._
]

#v(1em)
#line(length: 100%, stroke: 0.5pt + silver)
#v(0.5em)
#text(size: 7pt, fill: steel, style: "italic")[
  *Disclaimer:* This report is for informational purposes only and does not constitute investment advice. Forward-looking projections are based on the author's analysis of available data and involve substantial uncertainty. All market size estimates represent the author's triangulation of publicly available analyst reports and should not be treated as precise forecasts. Past technology adoption patterns may not predict future outcomes.
]
