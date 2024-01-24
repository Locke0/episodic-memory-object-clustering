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

conda install pytorch=1.8.1=py3.8_cuda10.2_cudnn7.6.5_0 torchvision=0.9.1=py38_cu102 torchaudio=0.8.1=py38 cudatoolkit=10.2 -c pytorch --yes
pip install -r requirements.txt

# Install detectron2
python -m pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cu102/torch1.8/index.html

mkdir -p $VQ2D_ROOT/dependencies
cd $VQ2D_ROOT/dependencies
git clone https://github.com/visionml/pytracking
cd pytracking
git checkout de9cb9bb4f8cad98604fe4b51383a1e66f1c45c0
git submodule update --init --recursive # Downloads the PreciseROIPooling library

# Install PyTracking dependencies
conda install matplotlib pandas tqdm --yes
pip install opencv-python visdom tb-nightly scikit-image tikzplotlib gdown
conda install cython --yes
pip install pycocotools lvis

# Install ninja-build
sudo apt-get install ninja-build

# Build Pytorch-Correlation-Sampler
cd $VQ2D_ROOT/dependencies
git clone https://github.com/ClementPinard/Pytorch-Correlation-extension
cd Pytorch-Correlation-extension
python setup.py install

# Other dependencies
sudo apt-get install libturbojpeg
pip install jpeg4py av imageio-ffmpeg

# Initialize PyTracking Env Setting Files
cd $VQ2D_ROOT/dependencies/pytracking/
python -c "from pytracking.evaluation.environment import create_default_local_file; create_default_local_file()"
python -c "from ltr.admin.environment import create_default_local_file; create_default_local_file()"

# Download pre-trained KYS tracker networks
mkdir $VQ2D_ROOT/pretrained_models/
cd $VQ2D_ROOT/pretrained_models/
gdown --id 1nJTBxpuBhN0WGSvG7Zm3yBc9JAC6LnEn