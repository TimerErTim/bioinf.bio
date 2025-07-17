#!/bin/bash

# Stop the script if any command fails
set -e

# Get the directory where the script is located to run from anywhere
SCRIPT_DIR=$(dirname "$0")

ANALYSIS_DIR="$SCRIPT_DIR/analysis"
PROTOCOL_DIR="$SCRIPT_DIR/protocol"
VENV_DIR="$ANALYSIS_DIR/.venv"

# 1. Set up Python virtual environment in the analysis directory
echo "--- Setting up Python virtual environment... ---"
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment at $VENV_DIR"
    python3 -m venv "$VENV_DIR"
else
    echo "Virtual environment already exists."
fi

# 2. Install dependencies using pip from the virtual environment
echo "--- Installing dependencies... ---"
"$VENV_DIR/bin/pip" install -r "$ANALYSIS_DIR/requirements.txt"

# 3. Run the analysis script to generate plots
echo "--- Running analysis script... ---"
"$VENV_DIR/bin/python" "$ANALYSIS_DIR/analyze_lipase.py"

# 4. Copy plots to the protocol's assets folder
PLOT_SOURCE_DIR="$ANALYSIS_DIR/plots"
PLOT_DEST_DIR="$PROTOCOL_DIR/assets/plots"
echo "--- Copying plots to $PLOT_DEST_DIR... ---"
mkdir -p "$PLOT_DEST_DIR"
cp -r "$PLOT_SOURCE_DIR"/* "$PLOT_DEST_DIR/"
cp -r "$ANALYSIS_DIR/out"/* "$PROTOCOL_DIR/assets/"

# 5. Compile the Typst protocol
echo "--- Compiling Typst protocol... ---"
cd "$PROTOCOL_DIR"
typst compile "PHS2_SS2025_Tim-Peko_Lipase.typ" --root "$SCRIPT_DIR"/../../
echo "Protocol compiled: PHS2_SS2025_Tim-Peko_Lipase.pdf"

echo "--- Build finished successfully! ---"


