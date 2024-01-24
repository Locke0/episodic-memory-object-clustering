# Episodic Memory Object Clustering Project

## Overview

This repository contains code and resources for a project aimed at clustering distinct entities in egocentric videos ("episodic memory"). The primary goal is to develop a system that can analyze video content and identify separate entities or objects, allowing for meaningful clustering and classification.

For details on episodic memory, refer to this [page](https://ego4d-data.org/docs/benchmarks/episodic-memory/).

## Features

- **Entity Clustering:** The project leverages advanced computer vision and machine learning techniques to cluster entities within video frames.
  
- **AWS Integration:** AWS credentials are required for accessing cloud-based resources. Ensure to set up your AWS credentials in the `.env` file.

- **Ego4D Annotations:** The project utilizes Ego4D Annotations to enrich video data. The `download_data.sh` script facilitates the download of Ego4D Annotations and relevant benchmark repositories.

## Setup

### Prerequisites

- **Miniconda:** Install Miniconda to manage the project environment. Refer to the `scripts/setup_environment.sh` script for automated setup.

- **AWS CLI:** Set up the AWS CLI by running the `scripts/setup_environment.sh` script. AWS credentials are stored in the `.env` file.

- **Ego4D CLI:** Install the Ego4D CLI using `pip install ego4d` to access annotations and enhance video data.

### Environment Setup

```bash
./scripts/setup_environment.sh
```

Download Data and Annotations

```bash
./scripts/download_data.sh
```
### Usage

Environment Activation:

```bash
conda activate ego4d_vq2d

```

### License
This project is licensed under the MIT License.

### Acknowledgments
Ego4D: Special thanks to the Ego4D team for providing the dataset