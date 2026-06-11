# J-Pop Semantic Inversion Analysis

## Overview

This project explores emotional expression in J-Pop lyrics through the concept of **Semantic Inversion**.

While analyzing various J-Pop songs, I observed that the literal meaning of words often differs from the emotion that the speaker is trying to convey. Love is used to express sadness, closeness is used to describe emotional distance, happiness is portrayed as something fragile, and loss is often expressed through beautiful imagery.

This project defines this phenomenon as **Semantic Inversion** and analyzes its patterns in J-Pop lyrics.

## Research Motivation

The project began after encountering the expression **愛し** being read as **カナシ** in the song **サクラキミワタシ** by **tuki.**

This observation led to a broader investigation of how J-Pop lyrics transform emotions through language and imagery.

## Research Topics

- Love as sadness
- Closeness as emotional distance
- Happiness as incompleteness
- Loss as beauty

## Methods

- Lyric analysis
- Manual emotional scoring
- Semantic categorization
- R visualization using `ggplot2`

## Results

Many lyrics showed relatively high **Surface Positivity** while simultaneously containing strong **Underlying Sadness**.

The analysis suggests that J-Pop speakers often reinterpret difficult emotions through opposite words, symbols, and imagery. This may function as a way of accepting and coping with painful emotions.

## Repository Contents

```text
report/
  J-Pop_Semantic_Inversion_Portfolio.pdf

data/
  J-Pop_semantic_inversion.csv

R/
  semantic_inversion_analysis.R

images/
  semantic_inversion_plot.png
