#!/usr/bin/env python3
"""
Tactile Sensitivity Analysis Script
Analyzes surface sensitivity (tactile perception) data from compass experiments
measuring the resolving power of mechanical touch receptors on different body parts.
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats as stats
from pathlib import Path
import warnings
warnings.filterwarnings('ignore')

# Set style for better plots
plt.style.use('seaborn-v0_8')
sns.set_palette("husl")

class TactileSensitivityAnalyzer:
    """Analyzer for tactile sensitivity experimental data"""
    
    def __init__(self, data_dir="../data", output_dir="out"):
        self.data_dir = Path(data_dir)
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)
        
        # Body regions measured in the experiment (German -> English mapping)
        self.body_regions_de = ['Handrücken', 'Fingerkuppe', 'Unterarm', 'Rücken', 'Handfläche']
        self.body_regions_en = ['Hand Back', 'Fingertip', 'Forearm', 'Back', 'Palm']
        self.region_mapping = dict(zip(self.body_regions_de, self.body_regions_en))
        
        # Use English names throughout analysis
        self.body_regions = self.body_regions_en
        
        # Load data
        self.load_data()
        
    def load_data(self):
        """Load and merge participant and measurement data"""
        print("Loading data...")
        
        # Load participant data
        participants = pd.read_csv(self.data_dir / "UE_Sinne_Ergebnisse-TN-Liste.csv")
        
        # Load tactile sensitivity measurements
        measurements = pd.read_csv(self.data_dir / "UE_Sinne_Ergebnisse-Berührung.csv")
        
        # Merge datasets
        self.data = pd.merge(measurements, participants, 
                           on=['Datum', 'Stdgang', 'Person'], 
                           how='left')
        
        # Clean and preprocess data
        self.preprocess_data()
        
    def preprocess_data(self):
        """Clean and preprocess the data"""
        print("Preprocessing data...")
        
        # Convert comma decimal separators to dots and convert to numeric for German column names
        for region in self.body_regions_de:
            self.data[region] = self.data[region].astype(str).str.replace(',', '.')
            self.data[region] = pd.to_numeric(self.data[region], errors='coerce')
        
        # Rename German body region columns to English
        self.data = self.data.rename(columns=self.region_mapping)
        
        # Clean gender column
        self.data['Geschlecht'] = self.data['Geschlecht'].str.lower()
        self.data = self.data[self.data['Geschlecht'].isin(['m', 'w'])]
        
        # Remove rows with all NaN values for body regions (now using English names)
        self.data = self.data.dropna(subset=self.body_regions, how='all')
        
        # Create age groups
        self.data['Altersgruppe'] = pd.cut(self.data['Alter'], 
                                         bins=[0, 20, 25, 30, 100], 
                                         labels=['<20', '20-25', '25-30', '>30'])
        
        print(f"Data loaded: {len(self.data)} participants")
        print(f"Gender distribution: {self.data['Geschlecht'].value_counts().to_dict()}")
        
    def descriptive_statistics(self):
        """Calculate descriptive statistics for each body region"""
        print("\nCalculating descriptive statistics...")
        
        stats_dict = {}
        
        for region in self.body_regions:
            region_data = self.data[region].dropna()
            
            if len(region_data) > 0:
                stats_dict[region] = {
                    'n': len(region_data),
                    'mean': region_data.mean(),
                    'median': region_data.median(),
                    'std': region_data.std(),
                    'min': region_data.min(),
                    'max': region_data.max(),
                    'q25': region_data.quantile(0.25),
                    'q75': region_data.quantile(0.75)
                }
        
        # Create descriptive statistics DataFrame
        self.desc_stats = pd.DataFrame(stats_dict).T
        
        # Save to CSV
        self.desc_stats.to_csv(self.output_dir / "descriptive_statistics.csv")
        
        print("Descriptive statistics saved to descriptive_statistics.csv")
        return self.desc_stats
        
    def compare_body_regions(self):
        """Compare tactile sensitivity between body regions using t-tests"""
        print("\nComparing body regions with t-tests...")
        
        # Prepare data for analysis
        region_data = []
        for region in self.body_regions:
            values = self.data[region].dropna()
            region_data.append(values)
        
        # Perform pairwise t-tests
        results = []
        
        for i in range(len(self.body_regions)):
            for j in range(i+1, len(self.body_regions)):
                region1 = self.body_regions[i]
                region2 = self.body_regions[j]
                
                data1 = region_data[i]
                data2 = region_data[j]
                
                if len(data1) > 0 and len(data2) > 0:
                    # Perform independent t-test
                    t_stat, p_value = stats.ttest_ind(data1, data2)
                    
                    # Cohen's d for effect size
                    pooled_std = np.sqrt(((len(data1)-1)*data1.var() + (len(data2)-1)*data2.var()) / (len(data1)+len(data2)-2))
                    cohens_d = (data1.mean() - data2.mean()) / pooled_std
                    
                    results.append({
                        'Region 1': region1,
                        'Region 2': region2,
                        'Mean 1': data1.mean(),
                        'Mean 2': data2.mean(),
                        't-statistic': t_stat,
                        'p-value': p_value,
                        'Cohen\'s d': cohens_d,
                        'Significant': p_value < 0.05
                    })
        
        self.region_comparisons = pd.DataFrame(results)
        self.region_comparisons.to_csv(self.output_dir / "region_comparisons.csv", index=False)
        
        print("Region comparisons saved to region_comparisons.csv")
        return self.region_comparisons
        
    def compare_genders(self):
        """Compare tactile sensitivity between genders"""
        print("\nComparing genders...")
        
        results = []
        
        for region in self.body_regions:
            male_data = self.data[self.data['Geschlecht'] == 'm'][region].dropna()
            female_data = self.data[self.data['Geschlecht'] == 'w'][region].dropna()
            
            if len(male_data) > 1 and len(female_data) > 1:
                # Perform independent t-test
                t_stat, p_value = stats.ttest_ind(male_data, female_data)
                
                # Cohen's d for effect size
                pooled_std = np.sqrt(((len(male_data)-1)*male_data.var() + (len(female_data)-1)*female_data.var()) / (len(male_data)+len(female_data)-2))
                cohens_d = (male_data.mean() - female_data.mean()) / pooled_std
                
                results.append({
                    'Body Region': region,
                    'Male Mean': male_data.mean(),
                    'Female Mean': female_data.mean(),
                    'Male N': len(male_data),
                    'Female N': len(female_data),
                    't-statistic': t_stat,
                    'p-value': p_value,
                    'Cohen\'s d': cohens_d,
                    'Significant': p_value < 0.05
                })
        
        self.gender_comparisons = pd.DataFrame(results)
        self.gender_comparisons.to_csv(self.output_dir / "gender_comparisons.csv", index=False)
        
        print("Gender comparisons saved to gender_comparisons.csv")
        return self.gender_comparisons
        
    def create_visualizations(self):
        """Create comprehensive visualizations"""
        print("\nCreating visualizations...")
        
        # 1. Box plot comparing body regions
        plt.figure(figsize=(12, 8))
        
        # Prepare data for plotting
        plot_data = []
        for region in self.body_regions:
            values = self.data[region].dropna()
            for value in values:
                plot_data.append({'Body Region': region, 'Distance (mm)': value})
        
        plot_df = pd.DataFrame(plot_data)
        
        sns.boxplot(data=plot_df, x='Body Region', y='Distance (mm)')
        plt.title('Tactile Sensitivity by Body Region\n(Two-Point Discrimination Threshold)', fontsize=14, fontweight='bold')
        plt.xlabel('Body Region', fontsize=12)
        plt.ylabel('Distance (mm)', fontsize=12)
        plt.xticks(rotation=45)
        plt.tight_layout()
        plt.savefig(self.output_dir / "body_regions_boxplot.png", dpi=300, bbox_inches='tight')
        plt.show()
        
        # 2. Gender comparison plots
        fig, axes = plt.subplots(2, 3, figsize=(15, 10))
        axes = axes.flatten()
        
        for i, region in enumerate(self.body_regions):
            if i < len(axes):
                male_data = self.data[self.data['Geschlecht'] == 'm'][region].dropna()
                female_data = self.data[self.data['Geschlecht'] == 'w'][region].dropna()
                
                # Create gender comparison data
                gender_data = []
                for value in male_data:
                    gender_data.append({'Gender': 'Male', 'Distance (mm)': value})
                for value in female_data:
                    gender_data.append({'Gender': 'Female', 'Distance (mm)': value})
                
                if gender_data:
                    gender_df = pd.DataFrame(gender_data)
                    sns.boxplot(data=gender_df, x='Gender', y='Distance (mm)', ax=axes[i])
                    axes[i].set_title(f'{region}', fontweight='bold')
                    axes[i].set_xlabel('')
        
        # Remove empty subplot
        if len(self.body_regions) < len(axes):
            fig.delaxes(axes[-1])
            
        plt.suptitle('Gender Comparison of Tactile Sensitivity by Body Region', fontsize=16, fontweight='bold')
        plt.tight_layout()
        plt.savefig(self.output_dir / "gender_comparison.png", dpi=300, bbox_inches='tight')
        plt.show()
        
        # 3. Correlation heatmap between body regions
        plt.figure(figsize=(10, 8))
        
        correlation_data = self.data[self.body_regions].corr()
        mask = np.triu(np.ones_like(correlation_data, dtype=bool))
        
        sns.heatmap(correlation_data, mask=mask, annot=True, cmap='coolwarm', center=0,
                   square=True, linewidths=0.5, cbar_kws={"shrink": .5})
        plt.title('Correlation Between Body Regions\n(Tactile Sensitivity)', fontsize=14, fontweight='bold')
        plt.tight_layout()
        plt.savefig(self.output_dir / "correlation_heatmap.png", dpi=300, bbox_inches='tight')
        plt.show()
        
        # 4. Distribution plots
        fig, axes = plt.subplots(2, 3, figsize=(15, 10))
        axes = axes.flatten()
        
        for i, region in enumerate(self.body_regions):
            if i < len(axes):
                data = self.data[region].dropna()
                if len(data) > 0:
                    axes[i].hist(data, bins=15, alpha=0.7, edgecolor='black')
                    axes[i].axvline(data.mean(), color='red', linestyle='--', linewidth=2, label=f'Mean: {data.mean():.1f}mm')
                    axes[i].axvline(data.median(), color='orange', linestyle='--', linewidth=2, label=f'Median: {data.median():.1f}mm')
                    axes[i].set_title(f'{region}', fontweight='bold')
                    axes[i].set_xlabel('Distance (mm)')
                    axes[i].set_ylabel('Frequency')
                    axes[i].legend()
        
        # Remove empty subplot
        if len(self.body_regions) < len(axes):
            fig.delaxes(axes[-1])
            
        plt.suptitle('Distribution of Tactile Sensitivity Measurements', fontsize=16, fontweight='bold')
        plt.tight_layout()
        plt.savefig(self.output_dir / "distributions.png", dpi=300, bbox_inches='tight')
        plt.show()
        
    def generate_report(self):
        """Generate a comprehensive text report"""
        print("\nGenerating comprehensive report...")
        
        report_lines = []
        report_lines.append("TACTILE SENSITIVITY ANALYSIS REPORT")
        report_lines.append("=" * 50)
        report_lines.append("")
        
        # Overview
        report_lines.append("1. OVERVIEW")
        report_lines.append("-" * 20)
        report_lines.append(f"Total participants analyzed: {len(self.data)}")
        gender_counts = self.data['Geschlecht'].value_counts()
        report_lines.append(f"Male participants: {gender_counts.get('m', 0)}")
        report_lines.append(f"Female participants: {gender_counts.get('w', 0)}")
        report_lines.append("")
        
        # Descriptive Statistics
        report_lines.append("2. DESCRIPTIVE STATISTICS (mm)")
        report_lines.append("-" * 35)
        for region in self.body_regions:
            if region in self.desc_stats.index:
                stats = self.desc_stats.loc[region]
                report_lines.append(f"\n{region}:")
                report_lines.append(f"  N: {stats['n']:.0f}")
                report_lines.append(f"  Mean: {stats['mean']:.2f} ± {stats['std']:.2f} mm")
                report_lines.append(f"  Median: {stats['median']:.2f} mm")
                report_lines.append(f"  Range: {stats['min']:.2f} - {stats['max']:.2f} mm")
        
        report_lines.append("")
        
        # Body Region Comparisons
        report_lines.append("3. BODY REGION COMPARISONS")
        report_lines.append("-" * 30)
        report_lines.append("Significant differences (p < 0.05):")
        
        significant_comparisons = self.region_comparisons[self.region_comparisons['Significant']]
        if len(significant_comparisons) > 0:
            for _, row in significant_comparisons.iterrows():
                report_lines.append(f"  {row['Region 1']} vs {row['Region 2']}: p = {row['p-value']:.4f}")
        else:
            report_lines.append("  No significant differences found.")
        
        report_lines.append("")
        
        # Gender Comparisons
        report_lines.append("4. GENDER COMPARISONS")
        report_lines.append("-" * 25)
        report_lines.append("Significant gender differences (p < 0.05):")
        
        significant_gender = self.gender_comparisons[self.gender_comparisons['Significant']]
        if len(significant_gender) > 0:
            for _, row in significant_gender.iterrows():
                report_lines.append(f"  {row['Body Region']}: p = {row['p-value']:.4f}")
                report_lines.append(f"    Male mean: {row['Male Mean']:.2f} mm")
                report_lines.append(f"    Female mean: {row['Female Mean']:.2f} mm")
        else:
            report_lines.append("  No significant gender differences found.")
        
        report_lines.append("")
        
        # Interpretation
        report_lines.append("5. INTERPRETATION")
        report_lines.append("-" * 20)
        
        # Find most and least sensitive regions
        if hasattr(self, 'desc_stats'):
            most_sensitive = self.desc_stats['mean'].idxmin()
            least_sensitive = self.desc_stats['mean'].idxmax()
            
            report_lines.append(f"Most sensitive region: {most_sensitive} ({self.desc_stats.loc[most_sensitive, 'mean']:.2f} mm)")
            report_lines.append(f"Least sensitive region: {least_sensitive} ({self.desc_stats.loc[least_sensitive, 'mean']:.2f} mm)")
            report_lines.append("")
            
            report_lines.append("DISCUSSION:")
            report_lines.append("The results show varying tactile sensitivity across different body regions.")
            report_lines.append("This variation is consistent with the known distribution of mechanoreceptors:")
            report_lines.append("- Fingertips typically have the highest density of receptors (smallest threshold)")
            report_lines.append("- Back and forearm typically have lower receptor density (larger threshold)")
            report_lines.append("- The results reflect the functional importance of different body parts")
            report_lines.append("  for tactile discrimination tasks.")
        
        # Save report
        report_text = "\n".join(report_lines)
        with open(self.output_dir / "analysis_report.txt", 'w', encoding='utf-8') as f:
            f.write(report_text)
        
        print("Analysis report saved to analysis_report.txt")
        return report_text
        
    def run_complete_analysis(self):
        """Run the complete analysis pipeline"""
        print("Starting complete tactile sensitivity analysis...")
        print("=" * 50)
        
        # Run all analyses
        self.descriptive_statistics()
        self.compare_body_regions()
        self.compare_genders()
        self.create_visualizations()
        self.generate_report()
        
        print("\n" + "=" * 50)
        print("Analysis complete! Results saved to 'out' directory:")
        print("- descriptive_statistics.csv")
        print("- region_comparisons.csv")
        print("- gender_comparisons.csv")
        print("- body_regions_boxplot.png")
        print("- gender_comparison.png")
        print("- correlation_heatmap.png")
        print("- distributions.png")
        print("- analysis_report.txt")

def main():
    """Main function to run the analysis"""
    # Create analyzer instance
    analyzer = TactileSensitivityAnalyzer()
    
    # Run complete analysis
    analyzer.run_complete_analysis()

if __name__ == "__main__":
    main()