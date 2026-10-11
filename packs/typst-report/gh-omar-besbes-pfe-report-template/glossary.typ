#let glossary-dictionary = (
// ==================== Software Architecture & Design Terms ====================
  (
    key: "event-driven-architecture",
    short: "EDA",
    plural: "EDAs",
    long: "Event-Driven Architecture",
    longplural: "Event-Driven Architectures",
    description: [
      #link("https://en.wikipedia.org/wiki/Event-driven_architecture")[EDA] is a software design approach where system components communicate by producing and consuming events asynchronously.
    ],
    group: "Software Architecture & Design Terms"
  ),
  (
    key: "event-sourcing",
    short: "ES",
    long: "Event Sourcing",
    description: [
      #link("https://martinfowler.com/eaaDev/EventSourcing.html")[ES] is a software design pattern where changes to an application's state are stored as a sequence of events, rather than overwriting the current state in a database.
    ],
    group: "Software Architecture & Design Terms"
  ),
  (
    key: "ioc",
    short: "IoC",
    long: "Inversion of Control",
    description: [
      #link("https://en.wikipedia.org/wiki/Inversion_of_control")[IoC] is a design principle where frameworks call user code instead of the other way around, improving decoupling & modularity.
    ],
    group: "Software Architecture & Design Terms"
  ),
  (
    key: "facade",
    short: "Facade",
    plural: "Facades",
    description: [
      In software engineering, a #link("https://refactoring.guru/design-patterns/facade")[Facade] is a design pattern that provides a simplified, higher-level interface to a set of complex subsystems.
    ],
    group: "Software Architecture & Design Terms"
  ),
  (
    key: "strategy",
    short: "Strategy",
    plural: "Strategies",
    description: [
      The #link("https://en.wikipedia.org/wiki/Strategy_pattern")[Strategy pattern] defines a family of algorithms, encapsulates each one, and makes them interchangeable.
    ],
    group: "Software Architecture & Design Terms"
  ),
  (
    key: "builder",
    short: "Builder",
    plural: "Builders",
    description: [
      The #link("https://en.wikipedia.org/wiki/Builder_pattern")[Builder pattern] separates the construction of a complex object from its representation, enabling step-by-step assembly and allowing the same construction process to create different representations.
    ],
    group: "Software Architecture & Design Terms"
  ),
  (
    key: "adapter",
    short: "Adapter",
    plural: "Adapters",
    description: [
      The #link("https://en.wikipedia.org/wiki/Adapter_pattern")[Adapter pattern] converts the interface of a class into another interface clients expect, allowing otherwise incompatible components to work together.
    ],
    group: "Software Architecture & Design Terms"
  ),
  (
    key: "factory",
    short: "Factory",
    plural: "Factories",
    description: [
      The #link("https://en.wikipedia.org/wiki/Factory_method_pattern")[Factory Method] defines an interface for creating objects but lets subclasses decide which class to instantiate, decoupling object creation from usage.
    ],
    group: "Software Architecture & Design Terms"
  ),
  (
    key: "singleton",
    short: "Singleton",
    plural: "Singletons",
    description: [
      The #link("https://en.wikipedia.org/wiki/Singleton_pattern")[Singleton pattern] ensures that a class has only one instance and provides a global access point to it.
    ],
    group: "Software Architecture & Design Terms"
  ),
// ==================== Technology & Infrastructure Terms ====================
  (
    key: "v8",
    short: "V8",
    long: "V8 JavaScript Engine",
    description: [
      #link("https://v8.dev/")[V8] is Google’s high-performance JavaScript and WebAssembly engine. It compiles JavaScript (and WebAssembly) directly to machine code for execution.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "sql",
    short: "SQL",
    long: "Structured Query Language",
    description: [
      #link("https://en.wikipedia.org/wiki/SQL")[SQL] is a standardized programming language used to define, manage and query relational databases.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "docker",
    short: "Docker",
    description: [
      #link("https://www.docker.com/")[Docker] is an open-source platform that enables developers to build, package, and run applications inside lightweight, portable containers.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "gitlab",
    short: "GitLab",
    description: [
      #link("https://about.gitlab.com/")[GitLab] is a DevOps platform that provides Git-based version control with built-in CI/CD and project management tools.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "ci",
    short: "CI",
    long: "Continuous Integration",
    description: [
      CI is the practice of frequently merging code changes and validating them with automated builds and tests.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "ci-cd",
    short: "CI/CD",
    long: "Continuous Integration / Continuous Delivery",
    description: [
      #link("https://en.wikipedia.org/wiki/CI/CD")[CI/CD] is the practice of automating software integration, testing, and delivery.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "minio",
    short: "MinIO",
    description: [
      #link("https://www.min.io/")[MinIO] is an open-source, high-performance, S3-compatible object storage system optimized for cloud-native environments.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "ffi",
    short: "FFI",
    long: "Foreign Function Interface",
    description: [
      A #link("https://en.wikipedia.org/wiki/Foreign_function_interface")[FFI] is a mechanism that allows code written in one programming language to call functions or use libraries written in another language.
    ],
    group: "Technology & Infrastructure Terms"
  ),
    (
    key: "grpc",
    short: "gRPC",
    description: [
      #link("https://grpc.io/")[gRPC] is a modern, open-source remote procedure call (RPC) framework for efficient, strongly typed communication between services.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "postgres",
    short: "PostgreSQL",
    plural: "PostgreSQL databases",
    description: [
      #link("https://www.postgresql.org/")[PostgreSQL] is a powerful, open-source relational database management system (RDBMS) known for reliability, extensibility, and standards compliance.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "http",
    short: "HTTP",
    long: "Hypertext Transfer Protocol",
    description: [
      #link("https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol")[HTTP] is the protocol used by web clients and servers, to exchange resources such as HTML pages, JSON data, or files.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "deno",
    short: "Deno",
    description: [
      #link("https://deno.land/")[Deno] is a modern runtime for JavaScript and TypeScript built on the V8 engine and Rust with built-in tooling.
    ],
    group: "Technology & Infrastructure Terms"
  ),  
  (
    key: "youtrack",
    short: "YouTrack",
    description: [
      #link("https://www.jetbrains.com/youtrack/")[YouTrack] is a project management and issue tracking tool developed by JetBrains with strong agile workflow support.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "json",
    short: "JSON",
    long: "JavaScript Object Notation",
    description: [
      #link("https://en.wikipedia.org/wiki/JSON")[JSON] is a lightweight, text-based data interchange format that represents data as key–value pairs and ordered lists.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "html",
    short: "HTML",
    long: "Hypertext Markup Language",
    description: [
      HTML is the standard markup language for creating the structure of web pages.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "css",
    short: "CSS",
    long: "Cascading Style Sheets",
    description: [
      CSS is the stylesheet language used to control the look and layout of HTML elements on web pages.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "svelte",
    short: "Svelte",
    description: [
      #link("https://svelte.dev/")[Svelte] is a modern JavaScript framework that compiles declarative UI components into efficient, framework-free JavaScript, HTML, and CSS at build time.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "monorepo",
    short: "monorepo",
    description: [
      A #link("https://monorepo.tools/")[monorepo] is a single version-controlled repository that stores the code for multiple projects or components together, simplifying dependency management and cross-project changes.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "moon",
    short: "Moon",
    description: [
      #link("https://moonrepo.dev/")[Moon] is a Rust-based tool for managing monorepos: it handles version consistency, task orchestration, incremental builds, and dependency graphs across projects in a workspace.
    ],
    group: "Technology & Infrastructure Terms"
  ),
  (
    key: "node",
    short: "Node.js",
    description: [
      #link("https://nodejs.org/")[Node.js] is an open-source runtime that lets you run JavaScript on the server side, built on Google’s V8 engine for fast, scalable network applications.
    ],
    group: "Technology & Infrastructure Terms"
  ),
)