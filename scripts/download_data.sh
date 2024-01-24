#!/bin/bash

# Set AWS credentials
source .env || {
  echo >&2 "Error: .env file not found!"
  exit 1
}

# Download Ego4D Annotations to ego4d_data/
# TODO: Update version to v1.0.5 after fixing 403 Forbidden error
ego4d --output_directory="/content/ego4d_data/" --datasets annotations --version v1 -y

# Clone the VQ2D Benchmark Repo
git clone https://github.com/EGO4D/episodic-memory
