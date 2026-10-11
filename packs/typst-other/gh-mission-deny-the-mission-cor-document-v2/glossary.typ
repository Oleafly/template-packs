// Acronym definitions for the document
// With individual acronym linking to specific glossary entries

#let acronyms = (
  "llm": ("LLM", "Large Language Model"),
  "ai": ("AI", "Artificial Intelligence"),
  "dl": ("DL", "Deep Learning"),
  "cot": ("CoT", "Chain of Thought"),
  "lora": ("LoRA", "Low Rank Adapter"),
  "qlora": ("QLoRA", "Quantized Low Rank Adapter"),
  "gpt": ("GPT", "Generative Pretrained Transformer"),
  "llama": ("LLaMA", "Large Language Model Meta AI"),
  "moe": ("MoE", "Mixture of Experts"),
  "rnn": ("RNN", "Recurrent Neural Network"),
  "lstm": ("LSTM", "Long Short Term Memory"),
  "mha": ("MHA", "Multi-Head Attention"),
  "mla": ("MLA", "Multi-Head Latent Attention"),
  "gqa": ("GQA", "Group Query Attention"),
  "mqa": ("MQA", "Multi-Query Attention"),
  "cuda": ("CUDA", "Compute Unified Device Architecture"),
  "opencl": ("OpenCL", "Open Compute Library"),
  "llada": ("LLaDA", "Large Language Diffusion with Masking"),
  "rag": ("RAG", "Retrieval Augmented Generation"),
  "cag": ("CAG", "Cache Augmented Generation"),
  "ann": ("ANN", "Artificial Neural Network"),
  "alice": ("ALICE", "Artificial Linguistic Internet Computer Entity"),
  "ner": ("NER", "Named Entity Recognition"),
  "mcp": ("MCP", "Model Context Protocol"),
  "lru": ("LRU", "Linear Recurrent Unit"),
  "aicef": ("AiCEF", "AI-assisted Cyber Exercise Content generation Framework"),
  "vae": ("VAE", "Variational Autoencoders"),
  "gan": ("GAN", "Generative Adversarial Networks"),
  "cpu": ("CPU", "Central Processing Unit"),
  "gpu": ("GPU", "Graphics Processing Unit"),
  "gpgpu": ("GPGPU", "General-purpose computing on graphics processing units"),
  "npu": ("NPU", "Neural Processing Unit"),
  "ram": ("RAM", "Random Access Memory"),
  "vram": ("VRAM", "Video Random Access Memory"),
  "hbm": ("HBM", "High Bandwidth Memory"),
  "api": ("API", "Application Programming Interface"),
  "ctf": ("CTF", "Capture The Flag"),
  "koth": ("KoTH", "King of The Hill"),
  "vm": ("VM", "Virtual Machine"),
  "irc": ("IRC", "Internet Relay Chat"),
  "dep": ("DEP", "Data Execution Prevention"),
  "aslr": ("ASLR", "Address Space Layout Randomisation"),
  "rop": ("ROP", "Return Oriented Programming"),
  "sql": ("SQL", "Structured Query Language"),
  "sqli": ("SQLi", "Structured Query Language injection"),
  "apg": ("APG", "Automated Problem Generation"),
  "iac": ("IaC", "Infrastructure as Code")
)

// Function to create a clickable acronym that links to specific glossary entry
#let clickable-acronym(key, display-text) = {
  if key in acronyms {
    // Map each key to its corresponding label
    let target = if key == "llm" { <glossary-llm> }
    else if key == "ai" { <glossary-ai> }
    else if key == "dl" { <glossary-dl> }
    else if key == "cot" { <glossary-cot> }
    else if key == "lora" { <glossary-lora> }
    else if key == "qlora" { <glossary-qlora> }
    else if key == "gpt" { <glossary-gpt> }
    else if key == "llama" { <glossary-llama> }
    else if key == "moe" { <glossary-moe> }
    else if key == "rnn" { <glossary-rnn> }
    else if key == "lstm" { <glossary-lstm> }
    else if key == "mha" { <glossary-mha> }
    else if key == "mla" { <glossary-mla> }
    else if key == "gqa" { <glossary-gqa> }
    else if key == "mqa" { <glossary-mqa> }
    else if key == "cuda" { <glossary-cuda> }
    else if key == "opencl" { <glossary-opencl> }
    else if key == "llada" { <glossary-llada> }
    else if key == "rag" { <glossary-rag> }
    else if key == "cag" { <glossary-cag> }
    else if key == "ann" { <glossary-ann> }
    else if key == "alice" { <glossary-alice> }
    else if key == "ner" { <glossary-ner> }
    else if key == "mcp" { <glossary-mcp> }
    else if key == "lru" { <glossary-lru> }
    else if key == "aicef" { <glossary-aicef> }
    else if key == "vae" { <glossary-vae> }
    else if key == "gan" { <glossary-gan> }
    else if key == "cpu" { <glossary-cpu> }
    else if key == "gpu" { <glossary-gpu> }
    else if key == "gpgpu" { <glossary-gpgpu> }
    else if key == "npu" { <glossary-npu> }
    else if key == "ram" { <glossary-ram> }
    else if key == "vram" { <glossary-vram> }
    else if key == "hbm" { <glossary-hbm> }
    else if key == "api" { <glossary-api> }
    else if key == "ctf" { <glossary-ctf> }
    else if key == "koth" { <glossary-koth> }
    else if key == "vm" { <glossary-vm> }
    else if key == "irc" { <glossary-irc> }
    else if key == "dep" { <glossary-dep> }
    else if key == "aslr" { <glossary-aslr> }
    else if key == "rop" { <glossary-rop> }
    else if key == "sql" { <glossary-sql> }
    else if key == "sqli" { <glossary-sqli> }
    else if key == "apg" { <glossary-apg> }
    else if key == "iac" { <glossary-iac> }
    else { <glossary-section> }

    link(target, text(fill: blue, display-text))
  } else {
    text[Unknown acronym: #key]
  }
}

// Function to display full form with short form in parentheses (clickable to specific entry)
#let acrfull(key) = {
  if key in acronyms {
    let (short, full) = acronyms.at(key)
    clickable-acronym(key, [#full (#short)])
  } else {
    text[Unknown acronym: #key]
  }
}

// Function to display short form only (clickable to specific entry)
#let acrshort(key) = {
  if key in acronyms {
    let (short, full) = acronyms.at(key)
    clickable-acronym(key, [#short])
  } else {
    text[Unknown acronym: #key]
  }
}

// Function to display full form only (clickable to specific entry)
#let acrlong(key) = {
  if key in acronyms {
    let (short, full) = acronyms.at(key)
    clickable-acronym(key, [#full])
  } else {
    text[Unknown acronym: #key]
  }
}

// Alias for consistency with previous version
#let acronym = acrfull

// Plain versions without hyperlinks
#let acrfull-plain(key) = {
  if key in acronyms {
    let (short, full) = acronyms.at(key)
    text[#full (#short)]
  } else {
    text[Unknown acronym: #key]
  }
}

#let acrshort-plain(key) = {
  if key in acronyms {
    let (short, full) = acronyms.at(key)
    text[#short]
  } else {
    text[Unknown acronym: #key]
  }
}

#let acrlong-plain(key) = {
  if key in acronyms {
    let (short, full) = acronyms.at(key)
    text[#full]
  } else {
    text[Unknown acronym: #key]
  }
}

#let acronym-plain = acrfull-plain

// Function to generate glossary with individual labels for each acronym
#let printglossary() = {
  [
    = Acronyms <glossary-section>

    // Individual entries with labels for direct linking
    #if "aicef" in acronyms {
      let (short, full) = acronyms.at("aicef")
      par[#text(weight: "bold")[#short:] #full <glossary-aicef>]
    }
    #if "alice" in acronyms {
      let (short, full) = acronyms.at("alice")
      par[#text(weight: "bold")[#short:] #full <glossary-alice>]
    }
    #if "ai" in acronyms {
      let (short, full) = acronyms.at("ai")
      par[#text(weight: "bold")[#short:] #full <glossary-ai>]
    }
    #if "ann" in acronyms {
      let (short, full) = acronyms.at("ann")
      par[#text(weight: "bold")[#short:] #full <glossary-ann>]
    }
    #if "apg" in acronyms {
      let (short, full) = acronyms.at("apg")
      par[#text(weight: "bold")[#short:] #full <glossary-apg>]
    }
    #if "api" in acronyms {
      let (short, full) = acronyms.at("api")
      par[#text(weight: "bold")[#short:] #full <glossary-api>]
    }
    #if "aslr" in acronyms {
      let (short, full) = acronyms.at("aslr")
      par[#text(weight: "bold")[#short:] #full <glossary-aslr>]
    }
    #if "cag" in acronyms {
      let (short, full) = acronyms.at("cag")
      par[#text(weight: "bold")[#short:] #full <glossary-cag>]
    }
    #if "cot" in acronyms {
      let (short, full) = acronyms.at("cot")
      par[#text(weight: "bold")[#short:] #full <glossary-cot>]
    }
    #if "cpu" in acronyms {
      let (short, full) = acronyms.at("cpu")
      par[#text(weight: "bold")[#short:] #full <glossary-cpu>]
    }
    #if "ctf" in acronyms {
      let (short, full) = acronyms.at("ctf")
      par[#text(weight: "bold")[#short:] #full <glossary-ctf>]
    }
    #if "cuda" in acronyms {
      let (short, full) = acronyms.at("cuda")
      par[#text(weight: "bold")[#short:] #full <glossary-cuda>]
    }
    #if "dep" in acronyms {
      let (short, full) = acronyms.at("dep")
      par[#text(weight: "bold")[#short:] #full <glossary-dep>]
    }
    #if "dl" in acronyms {
      let (short, full) = acronyms.at("dl")
      par[#text(weight: "bold")[#short:] #full <glossary-dl>]
    }
    #if "gan" in acronyms {
      let (short, full) = acronyms.at("gan")
      par[#text(weight: "bold")[#short:] #full <glossary-gan>]
    }
    #if "gpgpu" in acronyms {
      let (short, full) = acronyms.at("gpgpu")
      par[#text(weight: "bold")[#short:] #full <glossary-gpgpu>]
    }
    #if "gpt" in acronyms {
      let (short, full) = acronyms.at("gpt")
      par[#text(weight: "bold")[#short:] #full <glossary-gpt>]
    }
    #if "gpu" in acronyms {
      let (short, full) = acronyms.at("gpu")
      par[#text(weight: "bold")[#short:] #full <glossary-gpu>]
    }
    #if "gqa" in acronyms {
      let (short, full) = acronyms.at("gqa")
      par[#text(weight: "bold")[#short:] #full <glossary-gqa>]
    }
    #if "hbm" in acronyms {
      let (short, full) = acronyms.at("hbm")
      par[#text(weight: "bold")[#short:] #full <glossary-hbm>]
    }
    #if "iac" in acronyms {
      let (short, full) = acronyms.at("iac")
      par[#text(weight: "bold")[#short:] #full <glossary-iac>]
    }
    #if "irc" in acronyms {
      let (short, full) = acronyms.at("irc")
      par[#text(weight: "bold")[#short:] #full <glossary-irc>]
    }
    #if "koth" in acronyms {
      let (short, full) = acronyms.at("koth")
      par[#text(weight: "bold")[#short:] #full <glossary-koth>]
    }
    #if "llada" in acronyms {
      let (short, full) = acronyms.at("llada")
      par[#text(weight: "bold")[#short:] #full <glossary-llada>]
    }
    #if "llama" in acronyms {
      let (short, full) = acronyms.at("llama")
      par[#text(weight: "bold")[#short:] #full <glossary-llama>]
    }
    #if "llm" in acronyms {
      let (short, full) = acronyms.at("llm")
      par[#text(weight: "bold")[#short:] #full <glossary-llm>]
    }
    #if "lora" in acronyms {
      let (short, full) = acronyms.at("lora")
      par[#text(weight: "bold")[#short:] #full <glossary-lora>]
    }
    #if "lru" in acronyms {
      let (short, full) = acronyms.at("lru")
      par[#text(weight: "bold")[#short:] #full <glossary-lru>]
    }
    #if "lstm" in acronyms {
      let (short, full) = acronyms.at("lstm")
      par[#text(weight: "bold")[#short:] #full <glossary-lstm>]
    }
    #if "mcp" in acronyms {
      let (short, full) = acronyms.at("mcp")
      par[#text(weight: "bold")[#short:] #full <glossary-mcp>]
    }
    #if "mha" in acronyms {
      let (short, full) = acronyms.at("mha")
      par[#text(weight: "bold")[#short:] #full <glossary-mha>]
    }
    #if "mla" in acronyms {
      let (short, full) = acronyms.at("mla")
      par[#text(weight: "bold")[#short:] #full <glossary-mla>]
    }
    #if "moe" in acronyms {
      let (short, full) = acronyms.at("moe")
      par[#text(weight: "bold")[#short:] #full <glossary-moe>]
    }
    #if "mqa" in acronyms {
      let (short, full) = acronyms.at("mqa")
      par[#text(weight: "bold")[#short:] #full <glossary-mqa>]
    }
    #if "ner" in acronyms {
      let (short, full) = acronyms.at("ner")
      par[#text(weight: "bold")[#short:] #full <glossary-ner>]
    }
    #if "npu" in acronyms {
      let (short, full) = acronyms.at("npu")
      par[#text(weight: "bold")[#short:] #full <glossary-npu>]
    }
    #if "opencl" in acronyms {
      let (short, full) = acronyms.at("opencl")
      par[#text(weight: "bold")[#short:] #full <glossary-opencl>]
    }
    #if "qlora" in acronyms {
      let (short, full) = acronyms.at("qlora")
      par[#text(weight: "bold")[#short:] #full <glossary-qlora>]
    }
    #if "rag" in acronyms {
      let (short, full) = acronyms.at("rag")
      par[#text(weight: "bold")[#short:] #full <glossary-rag>]
    }
    #if "ram" in acronyms {
      let (short, full) = acronyms.at("ram")
      par[#text(weight: "bold")[#short:] #full <glossary-ram>]
    }
    #if "rnn" in acronyms {
      let (short, full) = acronyms.at("rnn")
      par[#text(weight: "bold")[#short:] #full <glossary-rnn>]
    }
    #if "rop" in acronyms {
      let (short, full) = acronyms.at("rop")
      par[#text(weight: "bold")[#short:] #full <glossary-rop>]
    }
    #if "sql" in acronyms {
      let (short, full) = acronyms.at("sql")
      par[#text(weight: "bold")[#short:] #full <glossary-sql>]
    }
    #if "sqli" in acronyms {
      let (short, full) = acronyms.at("sqli")
      par[#text(weight: "bold")[#short:] #full <glossary-sqli>]
    }
    #if "vae" in acronyms {
      let (short, full) = acronyms.at("vae")
      par[#text(weight: "bold")[#short:] #full <glossary-vae>]
    }
    #if "vm" in acronyms {
      let (short, full) = acronyms.at("vm")
      par[#text(weight: "bold")[#short:] #full <glossary-vm>]
    }
    #if "vram" in acronyms {
      let (short, full) = acronyms.at("vram")
      par[#text(weight: "bold")[#short:] #full <glossary-vram>]
    }
  ]
}

// Alternative: Print glossary without any hyperlinks or anchors (plain version)
#let printplainglossary() = {
  heading(level: 1)[Acronyms]

  for key in acronyms.keys().sorted() {
    let (short, full) = acronyms.at(key)
    par[#text(weight: "bold")[#short:] #full]
  }
}
