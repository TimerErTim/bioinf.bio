# Tactile Sensitivity Analysis

This directory contains a comprehensive Python script for analyzing tactile sensitivity data from compass experiments measuring the resolving power of mechanical touch receptors.

## Overview

The experiment measures two-point discrimination thresholds on different body regions:
- **Handrücken** (Hand back)
- **Fingerkuppe** (Fingertip) 
- **Unterarm** (Forearm)
- **Rücken** (Back)
- **Handfläche** (Palm)

## Requirements

Install the required Python packages:

```bash
pip install -r requirements.txt
```

## Usage

Run the complete analysis:

```bash
python tactile_sensitivity_analysis.py
```

## Output Files

The script generates the following files in the `out/` directory:

### Data Files
- `descriptive_statistics.csv` - Mean, median, std dev, etc. for each body region
- `region_comparisons.csv` - T-test results comparing all body regions
- `gender_comparisons.csv` - T-test results comparing males vs females

### Visualizations
- `body_regions_boxplot.png` - Box plots showing sensitivity by body region
- `gender_comparison.png` - Gender comparison plots for all body regions
- `correlation_heatmap.png` - Correlation matrix between body regions
- `distributions.png` - Distribution histograms for each body region

### Report
- `analysis_report.txt` - Comprehensive text report with interpretation

## Analysis Features

The script performs:

1. **Descriptive Statistics** - Basic statistical measures for each body region
2. **Body Region Comparisons** - Pairwise t-tests between all body regions
3. **Gender Comparisons** - T-tests comparing male vs female sensitivity
4. **Visualizations** - Multiple plots for data exploration
5. **Statistical Report** - Comprehensive interpretation of results

## Data Sources

The analysis uses data from:
- `../data/UE_Sinne_Ergebnisse-TN-Liste.csv` - Participant information
- `../data/UE_Sinne_Ergebnisse-Berührung.csv` - Tactile sensitivity measurements 