#!/bin/bash

# Source .env file to load environment variables
source .env || {
  echo >&2 "Error: .env file not found!"
  exit 1
}

# Install Miniconda
MINICONDA_INSTALLER_SCRIPT=Miniconda3-4.5.4-Linux-x86_64.sh
MINICONDA_PREFIX=/usr/local
wget https://repo.continuum.io/miniconda/$MINICONDA_INSTALLER_SCRIPT
chmod +x $MINICONDA_INSTALLER_SCRIPT
./$MINICONDA_INSTALLER_SCRIPT -b -f -p $MINICONDA_PREFIX

# Set up Conda environment
conda install --channel defaults conda python=3.8 --yes
conda update --channel defaults --all --yes
conda install -c conda-forge mamba --yes
mamba create -n ego4d_vq2d python=3.8 --yes

# Install and Set up the AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" && aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
rm "awscliv2.zip"

# Install the Ego4D CLI
pip install ego4d