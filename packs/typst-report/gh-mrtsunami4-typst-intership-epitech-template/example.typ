#import "template.typ": internship_report, part_page

// Set up your report details here
#show: internship_report.with(
  title: "Optimizing Predictive Maintenance Algorithms",
  author: "Jane Doe",
  email: "jane.doe@epitech.eu",

  // University info
  university_name: "Epitech",
  // university_logo: "uni-logo.png",

  // Company info
  company_name: "AeroTech Industries",
  // company_logo: "company-logo.png",

  // Internship details
  dates: "January 2026 - July 2026",
  supervisors: (
    "Dr. Alan Turing (Academic Supervisor)",
    "Sarah Connor (Company Mentor)",
  ),

  // Frontmatter sections
  acknowledgements: [
    I would like to warmly thank my mentors for their valuable advice, as well as the entire engineering team at AeroTech for integrating me so kindly during these six months.
  ],

  abstract: [
    This report details a six-month internship at AeroTech Industries, focusing on the optimization of predictive maintenance algorithms for commercial aircraft. By implementing new Machine Learning techniques, false alerts were reduced by 14%. This document covers the technical context, the methodology used, and the results of the A/B testing phase.
  ],
)

// ==========================================
// PART 1: Technical Handover
// ==========================================

#part_page(
  "Part 1: Technical Handover",
  preamble: "This section is intended for a newcomer taking over the project. It describes the company context, the project's general architecture, and the work organization.",
)

= Company Context
AeroTech Industries is a leader in aerospace engineering. The team I joined is responsible for the digital twin platform used to monitor aircraft health in real-time.

= Project Architecture
The project follows a microservices architecture. Data is ingested via MQTT, processed by a Spark cluster, and stored in a time-series database.

== Anomaly Detection Model
To process time-series data from engine sensors, we opted for an architecture based on Random Forests combined with a Long Short-Term Memory (LSTM) network.

```python
import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler

def preprocess_sensor_data(df, window_size=50):
    # Remove extreme outliers
    df = df[(np.abs(df.temperature - df.temperature.mean()) <= (3 * df.temperature.std()))]

    # Normalize data
    scaler = StandardScaler()
    df['temp_scaled'] = scaler.fit_transform(df[['temperature']])

    # Create sliding windows for LSTM
    return df.rolling(window=window_size).mean()
```

== Key Terms

/ LSTM: Long Short-Term Memory — a recurrent neural network architecture well-suited for time-series forecasting.
/ MQTT: Message Queuing Telemetry Transport — a lightweight publish-subscribe messaging protocol for IoT devices.
/ ROC AUC: Receiver Operating Characteristic — Area Under Curve, a metric evaluating classifier performance across thresholds.
/ Digital Twin: A virtual replica of a physical system used for real-time monitoring and simulation.

= Methodology and Implementation
== Data Flow Diagram
The diagram below illustrates the data flow into the hybrid LSTM model.

#figure(
  block(
    width: 100%,
    height: 6cm,
    fill: rgb("#e2e8f0"),
    radius: 2pt,
    align(center + horizon)[
      #set text(fill: rgb("#555"), font: "DejaVu Sans")
      *ARCHITECTURE DIAGRAM PLACEHOLDER* \
      Replace this block with: \
      #raw("image(\"path/to/image.png\")", lang: "typ")
    ],
  ),
  caption: [Architecture diagram of the hybrid LSTM network developed for time-series analysis.],
)

= Results Analysis
== Performance Metrics

#figure(
  table(
    columns: (2fr, 1fr, 1fr),
    align: (left, center, center),
    [Approach], [Accuracy], [Gains vs. Baseline],
    [Static Rules], [78.2%], [0%],
    [Random Forest], [89.1%], [+10.9 pts],
    [Our Model], [94.5%], [+16.3 pts],
  ),
  caption: [Summary of performance metrics on the test set.],
  kind: table,
)

// ==========================================
// PART 2: Self-Assessment
// ==========================================

#part_page(
  "Part 2: Self-Assessment",
  preamble: "This section presents an argument to my supervisor regarding my performance, highlighting my strengths and areas for improvement.",
)

= Strengths
- *Technical Adaptability:* I was able to quickly master the complex Spark infrastructure used at AeroTech.
- *Problem Solving:* I successfully identified a bottleneck in the data ingestion pipeline that was causing 5% data loss.

= Areas for Improvement
- *Communication:* I need to improve my ability to explain technical concepts to non-technical stakeholders.
- *Time Management:* During the first month, I struggled with prioritizing tasks, though this improved significantly later.

// ==========================================
// PART 3: Dream Project Pitch
// ==========================================

#part_page(
  "Part 3: Dream Project Pitch",
  preamble: "This section is designed to convince senior management to entrust me with a high-impact project.",
)

= Context
With the rise of autonomous flight systems, there is a growing need for edge-computing anomaly detection.

= The Project: "EdgeGuard"
I propose developing a lightweight version of our LSTM model that can run directly on the aircraft's hardware (Edge AI), reducing latency and satellite bandwidth costs.

= Interest for the Company
Implementing EdgeGuard would reduce operational costs by 20% and provide real-time safety critical alerts without relying on ground connectivity.

// ==========================================
// CONCLUSION
// ==========================================

= Conclusion
This internship allowed me to apply theoretical Machine Learning concepts to critical industrial problems. The results obtained pave the way for a generalization of this approach to other aircraft sub-systems.
