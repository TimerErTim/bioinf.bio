import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
import csv
from io import StringIO

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


def load_clean_participant_list(path):
    """Load and clean the participant list CSV."""
    df = pd.read_csv(path, sep=',', encoding='utf-8', decimal=',', header=0)
    df.columns = [
        'Datum', 'Stdgang', 'Nummer', 'Gruppe', 'Alter', 'Geschlecht', 'Raucher',
        'Sportler', 'Brillenträger', 'Dioptrie li', 'Dioptrie re'
    ]
    df = df.dropna(how='all', subset=df.columns[1:])
    df['Datum'] = pd.to_datetime(df['Datum'], format='%d.%m.%Y', errors='coerce').fillna(method='ffill')
    df['Stdgang'] = df['Stdgang'].fillna(method='ffill')

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


def main():
    """Main function to run the analysis."""
    # Create plots directory if it doesn't exist
    if not os.path.exists(PLOTS_DIR):
        os.makedirs(PLOTS_DIR)

    # Load and clean data
    tn_df = load_clean_participant_list(TN_LIST_CSV)
    print("Participant Data:")
    print(tn_df.head())
    
    lipase_df = load_clean_lipase_results(LIPASE_CSV)
    print("\nLipase Results:")
    print(lipase_df.head())


    # Analysis and plotting
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

    print(f"\nPlots saved to '{PLOTS_DIR}' directory.")


if __name__ == '__main__':
    main() 