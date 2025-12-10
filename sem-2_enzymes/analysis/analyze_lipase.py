import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
import csv
from io import StringIO
from scipy import stats
import itertools

"""
Analysis script for Lipase experiment data.
- Loads and cleans UE_Sonstiges_Ergebnisse-Lipase.csv and UE_Sonstiges_Ergebnisse-TN-Liste.csv
- Parses the block-structured Lipase results into tidy format
- Prepares for plotting and further analysis
"""

# Paths to data files (adjust if needed)
LIPASE_CSV = os.path.join('..', 'data', 'UE_Sonstiges_Ergebnisse-Lipase.csv')
TN_LIST_CSV = os.path.join('..', 'data', 'UE_Sonstiges_Ergebnisse-TN-Liste.csv')
PLOTS_DIR = 'plots'
OUT_DIR = 'out'


def load_clean_participant_list(path):
    """Load and clean the participant list CSV."""
    df = pd.read_csv(path, sep=',', encoding='utf-8', decimal=',', header=0)
    df.columns = [
        'Datum', 'Stdgang', 'Nummer', 'Gruppe', 'Alter', 'Geschlecht', 'Raucher',
        'Sportler', 'Brillenträger', 'Dioptrie li', 'Dioptrie re'
    ]
    df = df.dropna(how='all', subset=list(df.columns[1:]))
    df['Datum'] = pd.to_datetime(df['Datum'], format='%d.%m.%Y', errors='coerce').ffill()
    df['Stdgang'] = df['Stdgang'].ffill()

    # Clean 'Geschlecht'
    df['Geschlecht'] = df['Geschlecht'].replace({'w': 'female', 'm': 'male', 'd': 'diverse', 'wm': 'female/male'})

    # Clean 'Raucher'
    df['Raucher'] = df['Raucher'].replace({
        '1': 'Nichtraucher',
        'n': 'Nichtraucher',
        '0': 'Nichtraucher',
        '2': 'Gelegenheitsraucher',
        '3': 'Raucher',
        'j': 'Raucher',
        '4': 'Starker Raucher (>= 1 Packung/Tag)',
        '3-4': 'Raucher/Starker Raucher',
        'jn': 'Raucher/Nichtraucher',
        '1/2': 'Nichtraucher/Gelegenheitsraucher'
    }).fillna('Unbekannt')

    # Clean 'Sportler'
    df['Sportler'] = df['Sportler'].replace({
        '1': 'Kein Sport',
        '0': 'Kein Sport',
        '2': 'Gelegentlich',
        '3': 'Mindestens 1x pro Woche',
        '4': 'Beinahe täglich'
    }).fillna('Unbekannt')
    
    # Clean 'Brillenträger'
    df['Brillenträger'] = df['Brillenträger'].replace({
        'j': 'Ja', 'n': 'Nein'
    }).fillna('Unbekannt')

    df['Alter'] = pd.to_numeric(df['Alter'], errors='coerce')
    df = df.dropna(subset=['Alter'])
    df['Alter'] = df['Alter'].astype(int)

    return df


def load_clean_lipase_results(path):
    """Load and parse the block-structured Lipase results CSV into tidy format."""
    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    header = [h.strip() for h in lines[0].strip().split(',')]
    data = []
    current_meta = {}

    for line in lines[1:]:
        line = line.strip()
        if not line:
            continue
        
        # Use csv.reader to split line, respecting quotes
        reader = csv.reader(StringIO(line), delimiter=',', quotechar='"')
        values = next(reader)
        values = [v.strip().strip('"') for v in values]

        # A line is meta if it has a value in 'Datum' or 'Stdgang' column
        is_meta = bool(values[0] or values[1])

        if is_meta:
            # Update current_meta, forward filling from previous meta
            line_meta = dict(zip(header, values))
            for k, v in line_meta.items():
                current_meta[k] = v
            
            # A meta line can contain the first measurement
            if line_meta.get('gekocht') or line_meta.get('ungekocht'):
                data.append(current_meta.copy())
        else:
            # It's a measurement line. Values are in fixed columns relative to the header.
            zeit_idx = header.index('Zeit')
            
            # Check if there's a time value present at the expected position
            if len(values) > zeit_idx and values[zeit_idx]:
                measurement_row = current_meta.copy()
                measurement_row['Zeit'] = values[zeit_idx]
                measurement_row['gekocht'] = values[zeit_idx + 1] if len(values) > zeit_idx + 1 else ''
                measurement_row['ungekocht'] = values[zeit_idx + 2] if len(values) > zeit_idx + 2 else ''
                data.append(measurement_row)

    df = pd.DataFrame(data)

    if df.empty:
        return df

    # Clean and type-cast columns
    df['Datum'] = pd.to_datetime(df['Datum'], dayfirst=True, errors='coerce')
    
    # Forward fill essential metadata
    for col in ['Datum', 'Stdgang', 'Gruppe', 'Menge']:
        if col in df.columns:
            df[col] = df[col].replace('', np.nan).ffill()
    
    df.rename(columns={'gekocht': 'pH_gekocht', 'ungekocht': 'pH_ungekocht'}, inplace=True)

    for col in ['Zeit', 'pH_gekocht', 'pH_ungekocht']:
        df[col] = df[col].astype(str).str.replace(',', '.').replace('-', np.nan).replace(' ', '')
        df[col] = pd.to_numeric(df[col], errors='coerce')
        
    df = df.dropna(subset=['Zeit'])
    df = df.dropna(subset=['pH_gekocht', 'pH_ungekocht'], how='all')

    return df


def calculate_ph_drop(df):
    """Calculates the pH drop for each experimental group."""
    # Ensure Zeit is sorted within each group
    df = df.sort_values(by=['Stdgang', 'Gruppe', 'Zeit'])

    # Get initial and final measurements for each group
    initial_ph = df.loc[df.groupby(['Stdgang', 'Gruppe'])['Zeit'].idxmin()]
    final_ph = df.loc[df.groupby(['Stdgang', 'Gruppe'])['Zeit'].idxmax()]

    # Merge to get initial and final on the same row
    merged = pd.merge(
        initial_ph, final_ph,
        on=['Stdgang', 'Gruppe', 'Menge', 'Datum', 'Sonstiges'],
        suffixes=('_initial', '_final')
    )

    # Calculate drop
    merged['drop_gekocht'] = merged['pH_gekocht_initial'] - merged['pH_gekocht_final']
    merged['drop_ungekocht'] = merged['pH_ungekocht_initial'] - merged['pH_ungekocht_final']

    return merged[['Stdgang', 'Gruppe', 'Menge', 'drop_gekocht', 'drop_ungekocht']]


def perform_descriptive_analysis(ph_drops):
    """Calculates descriptive statistics and saves them to two separate CSV files."""
    if not os.path.exists(OUT_DIR):
        os.makedirs(OUT_DIR)

    # 1. Overall descriptive statistics
    overall_desc = ph_drops[['drop_gekocht', 'drop_ungekocht']].describe()
    # Convert to object type to allow mixed types in columns, then set count to int
    overall_desc_formatted = overall_desc.astype(object)
    overall_desc_formatted.loc['count'] = overall_desc_formatted.loc['count'].astype(int)
    overall_output_path = os.path.join(OUT_DIR, 'descriptive_statistics_overall.csv')
    overall_desc_formatted.to_csv(overall_output_path)
    print(f"\nOverall descriptive statistics saved to '{overall_output_path}'")

    # 2. Descriptive statistics by 'Menge' in a tidy format
    ph_drops_cleaned = ph_drops.copy()
    ph_drops_cleaned['Menge'] = pd.to_numeric(ph_drops_cleaned['Menge'], errors='coerce')
    ph_drops_cleaned.dropna(subset=['Menge'], inplace=True)
    
    menge_desc = ph_drops_cleaned.groupby('Menge')[['drop_gekocht', 'drop_ungekocht']].describe()
    
    # Tidy the data by stacking the top-level column index
    menge_desc_tidy = menge_desc.stack(0).reset_index()
    menge_desc_tidy.rename(columns={'level_1': 'Group'}, inplace=True)
    menge_desc_tidy['Group'] = menge_desc_tidy['Group'].str.replace('drop_', '')

    # Convert count to int
    menge_desc_tidy['count'] = menge_desc_tidy['count'].astype(int)
    
    menge_output_path = os.path.join(OUT_DIR, 'descriptive_statistics_mengen.csv')
    menge_desc_tidy.to_csv(menge_output_path, index=False)
    print(f"Descriptive statistics by Menge saved to '{menge_output_path}'")


def perform_statistical_analysis(ph_drops):
    """Performs statistical analysis and saves results to CSV."""
    if not os.path.exists(OUT_DIR):
        os.makedirs(OUT_DIR)
        
    analysis_results = []

    # 1. Paired T-test: Gekocht vs. Ungekocht
    
    # Drop rows with NaN in either column to ensure fair pairing
    paired_data = ph_drops[['drop_gekocht', 'drop_ungekocht']].dropna()

    if len(paired_data) > 1:
        t_stat, p_val = stats.ttest_rel(paired_data['drop_ungekocht'], paired_data['drop_gekocht'])
        analysis_results.append({
            'Test': 'Paired T-test',
            'Comparison': 'pH Drop (Ungekocht vs. Gekocht)',
            'Statistic': f't = {t_stat:.3f}',
            'p-value': f'{p_val:.3e}',
            'Significance': 'Yes' if p_val < 0.05 else 'No'
        })
    else:
        analysis_results.append({
            'Test': 'Paired T-test',
            'Comparison': 'pH Drop (Ungekocht vs. Gekocht)',
            'Statistic': 'Not enough data',
            'p-value': 'N/A',
            'Significance': 'N/A'
        })


    # 2. ANOVA: Effect of 'Menge' on pH drop for 'ungekocht'
    menge_groups = ph_drops[['Menge', 'drop_ungekocht']].dropna()
    menge_groups['Menge'] = pd.to_numeric(menge_groups['Menge'], errors='coerce').dropna()
    unique_mengen = sorted(menge_groups['Menge'].unique())
    
    if len(unique_mengen) > 1:
        grouped_data = [menge_groups['drop_ungekocht'][menge_groups['Menge'] == m] for m in unique_mengen]
        
        f_stat, p_val_anova = stats.f_oneway(*grouped_data)
        analysis_results.append({
            'Test': 'ANOVA',
            'Comparison': "Effect of 'Menge' on pH Drop (Ungekocht)",
            'Statistic': f'F = {f_stat:.3f}',
            'p-value': f'{p_val_anova:.3e}',
            'Significance': 'Yes' if p_val_anova < 0.05 else 'No'
        })

        # 3. Pairwise T-tests (post-hoc) if ANOVA is significant
        if p_val_anova < 0.05:
            pairs = list(itertools.combinations(unique_mengen, 2))
            num_comparisons = len(pairs)
            bonferroni_alpha = 0.05 / num_comparisons

            for m1, m2 in pairs:
                group1 = menge_groups['drop_ungekocht'][menge_groups['Menge'] == m1]
                group2 = menge_groups['drop_ungekocht'][menge_groups['Menge'] == m2]
                
                t_stat_pair, p_val_pair = stats.ttest_ind(group1, group2, nan_policy='omit')
                
                analysis_results.append({
                    'Test': 'Pairwise T-test (Bonferroni)',
                    'Comparison': f"'Menge' {m1} vs {m2}",
                    'Statistic': f't = {t_stat_pair:.3f}',
                    'p-value': f'{p_val_pair:.3e}',
                    'Significance': 'Yes' if p_val_pair < bonferroni_alpha else 'No'
                })
    else:
        analysis_results.append({
            'Test': 'ANOVA',
            'Comparison': "Effect of 'Menge' on pH Drop (Ungekocht)",
            'Statistic': 'Only one "Menge" group',
            'p-value': 'N/A',
            'Significance': 'N/A'
        })

    # Save results to CSV
    results_df = pd.DataFrame(analysis_results)
    results_df.to_csv(os.path.join(OUT_DIR, 'statistical_analysis.csv'), index=False)
    print(f"\nStatistical analysis saved to '{os.path.join(OUT_DIR, 'statistical_analysis.csv')}'")


def plot_average(df, plot_title, filename, group_by_col=None, plot_type='both', window_size=15):
    """Generates and saves a smoothed average plot."""
    plt.figure(figsize=(12, 7))

    if plot_type == 'both':
        # Assumes df is pre-averaged by time
        df_sorted = df.sort_values(by='Zeit').reset_index(drop=True)
        gekocht_smooth = df_sorted['pH_gekocht'].rolling(window=window_size, center=True, min_periods=1).mean()
        plt.plot(df_sorted['Zeit'], gekocht_smooth, marker='o', linestyle='-', label='Gekocht (Durchschnitt, geglättet)')
        
        ungekocht_smooth = df_sorted['pH_ungekocht'].rolling(window=window_size, center=True, min_periods=1).mean()
        plt.plot(df_sorted['Zeit'], ungekocht_smooth, marker='x', linestyle='--', label='Ungekocht (Durchschnitt, geglättet)')
    
    else:  # 'gekocht' or 'ungekocht'
        # Assumes df is the full lipase_df, and groups it by the group_by_col
        value_col = f'pH_{plot_type}'
        marker = 'o' if plot_type == 'gekocht' else 'x'
        linestyle = '-' if plot_type == 'gekocht' else '--'

        for name, group in df.groupby(group_by_col):
            avg_group_df = group.groupby('Zeit')[value_col].mean().reset_index()
            avg_group_df = avg_group_df.sort_values(by='Zeit').reset_index(drop=True)
            smooth_ph = avg_group_df[value_col].rolling(window=window_size, center=True, min_periods=1).mean()
            plt.plot(avg_group_df['Zeit'], smooth_ph, marker=marker, linestyle=linestyle, label=f'Menge {name}')

    plt.title(plot_title)
    plt.xlabel('Zeit (min)')
    plt.ylabel('Durchschnittlicher pH-Wert')
    plt.legend()
    plt.grid(True)
    plt.savefig(os.path.join(PLOTS_DIR, filename))
    plt.close()


def main():
    """Main function to run the analysis."""
    # Create plots directory if it doesn't exist
    for dir_path in [PLOTS_DIR, OUT_DIR]:
        if not os.path.exists(dir_path):
            os.makedirs(dir_path)

    # Load and clean data
    tn_df = load_clean_participant_list(TN_LIST_CSV)
    print("Participant Data:")
    print(tn_df.head())
    
    lipase_df = load_clean_lipase_results(LIPASE_CSV)
    print("\nLipase Results:")
    print(lipase_df.head())


    # --- Individual Group Plots ---
    # Use a list for groupby to avoid tuple unpacking issues with some linters
    for (stdgang, gruppe), group_df in lipase_df.groupby(['Stdgang', 'Gruppe']):
        plt.figure(figsize=(10, 6))
        
        plt.plot(group_df['Zeit'], group_df['pH_gekocht'], marker='o', linestyle='-', label='Gekocht')
        plt.plot(group_df['Zeit'], group_df['pH_ungekocht'], marker='x', linestyle='--', label='Ungekocht')

        plt.title(f'pH-Verlauf für {stdgang} - Gruppe {gruppe}')
        plt.xlabel('Zeit (min)')
        plt.ylabel('pH-Wert')
        plt.legend()
        plt.grid(True)
        
        # Sanitize filename
        filename = f"{stdgang}_Gruppe_{gruppe}.png".replace("/", "_")
        plt.savefig(os.path.join(PLOTS_DIR, filename))
        plt.close()

    if lipase_df.empty:
        print("\nLipase DataFrame is empty. Skipping plotting and analysis.")
        return

    # Calculate pH drops for analysis
    ph_drops = calculate_ph_drop(lipase_df)

    # --- Overall Average Plot ---
    avg_df_all = lipase_df.groupby('Zeit')[['pH_gekocht', 'pH_ungekocht']].mean().reset_index()
    plot_average(avg_df_all, 'Durchschnittlicher pH-Verlauf über alle Gruppen (geglättet)', "average_ph_verlauf.png")

    # --- Average Plots per "Menge" ---
    for menge, menge_df in lipase_df.groupby('Menge'):
        avg_menge_df = menge_df.groupby('Zeit')[['pH_gekocht', 'pH_ungekocht']].mean().reset_index()
        plot_title = f'Durchschnittlicher pH-Verlauf für Menge {menge} (geglättet)'
        filename = f"average_ph_verlauf_menge_{menge}.png"
        plot_average(avg_menge_df, plot_title, filename)

    # --- Comparative Plot for Gekocht by Menge ---
    plot_average(lipase_df,
                 'Vergleich pH-Verlauf (Gekocht) nach Menge',
                 "vergleich_gekocht_nach_menge.png",
                 group_by_col='Menge',
                 plot_type='gekocht')

    # --- Comparative Plot for Ungekocht by Menge ---
    plot_average(lipase_df,
                 'Vergleich pH-Verlauf (Ungekocht) nach Menge',
                 "vergleich_ungekocht_nach_menge.png",
                 group_by_col='Menge',
                 plot_type='ungekocht')

    print(f"\nPlots saved to '{PLOTS_DIR}' directory.")

    # --- Statistical and Descriptive Analysis ---
    perform_statistical_analysis(ph_drops)
    perform_descriptive_analysis(ph_drops)


if __name__ == '__main__':
    main() 