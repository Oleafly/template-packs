#import "@preview/codelst:2.0.2": *

#let appendix = [
  #figure(
    table(
      columns: (auto, auto, auto, auto),
      inset: 8pt,
      align: center + horizon,
      [*Frage*], [*Ja (%)*], [*Nein (%)*], [*Unsicher (%)*],
      [Frage 1], [72], [18], [10],
      [Frage 2], [45], [37], [18],
      [Frage 3], [83], [12], [5],
      [Frage 4], [29], [56], [15],
      [Frage 5], [61], [23], [16],
    ),
    caption: [Umfrageergebnisse zur Digitalisierung im Mittelstand (n=250)]
  )

  #figure(
    sourcecode(`python
# Beispiel für einen einfachen Klassifikationsalgorithmus
import numpy as np
from sklearn.ensemble import RandomForestClassifier

def train_model(X_train, y_train):
    """
    Trainiert ein Random Forest Modell
    
    Args:
        X_train: Trainingsdaten
        y_train: Trainingslabels
        
    Returns:
        Trainiertes Modell
    """
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)
    return model
`),
    caption: [Implementation eines einfachen Machine-Learning-Modells]
  )
  
  #figure(
    table(
      columns: (auto),
      inset: 8pt,
      align: left,
      [*Interview-Leitfaden für qualitative Befragungen*],
      [1. Welche Herausforderungen sehen Sie bei der digitalen Transformation in Ihrem Unternehmen?],
      [2. Wie bewerten Sie den aktuellen Stand der Digitalisierung in Ihrer Branche?],
      [3. Welche Maßnahmen wurden bereits ergriffen, um die Digitalisierung voranzutreiben?],
      [4. Wie werden Mitarbeiter in den Transformationsprozess einbezogen?],
    ),
    caption: [Interview-Leitfaden für Führungskräfte-Befragungen]
  )
]