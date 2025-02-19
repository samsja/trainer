#!/usr/bin/env bash

set -e

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

main() {
    # Check if sudo is installed
    if ! command -v sudo &> /dev/null; then
        apt update
        apt install sudo -y
    fi

    log_info "Updating apt..."
    sudo apt update

    log_info "Installing cmake python3-dev..."
    sudo apt install nvtop tmux cmake python3-dev htop  -y


    log_info "Installing gsutil..."
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt-get update -y
    sudo apt-get install -y google-cloud-cli


    log_info "Cloning repository..."
    git clone git@github.com:samsja/trainer.git
    
    log_info "Entering project directory..."
    cd prime-rl
    
    log_info "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    
    log_info "Sourcing uv environment..."
    if ! command -v uv &> /dev/null; then
        source $HOME/.local/bin/env
    fi
    
    log_info "Creating virtual environment..."
    uv venv --python 3.10
    
    log_info "Activating virtual environment..."
    source .venv/bin/activate
    
    log_info "Installing dependencies..."
    uv sync
        
    log_info "Updating git submodules..."
    git submodule update --init --recursive
    
    log_info "Downloading data..."
    mkdir -p datasets
    uv run python scripts/subset_data.py --dataset_name PrimeIntellect/fineweb-edu --data_world_size 1 --data_rank 0 --max_shards 128
    mv fineweb-edu/ datasets/fineweb-edu/

    log_info "Installation completed! You can double check that everything is install correctly by running"
}

main
