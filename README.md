# DJA_FallRotation

Code for Charles' rotation project at David Anderson's Lab. Created by Jingyue (Charles) Xu at Caltech in October, 2023.

## Setup

### Cloning the repository

Open your system's Command Prompt or terminal in Visual Studio Code. Navigate to your desired directory by typing:
```bash
cd replace/with/your/path
```

If you don't have git in your system, install it [here](https://git-scm.com/downloads).

To clone the repository through HTTPS, type:
```bash
git clone https://github.com/CharlesXu-Jingyue/DJA_FallRotation.git
```
Please request access by contacting at CharlesXu@Caltech.edu if you need to.

### Setting up the environment

If you are using Conda to manage your environments, you can set up the environment by typing:
```bash
conda env create -f environment.yml
```
directly in your command prompt/terminal. If not, then I recommand using [it](https://www.anaconda.com/download/).

#### Installing the ssm package

You can refer to the ssm [documentation](https://github.com/lindermanlab/ssm) for install instructions. You can try cloning the repository in the current folder/repository; if you clone it to somewhere else, you should add its path to your environment by executing:
```python
import sys
sys.path.append('replace/with/path/to/ssm')
```

## Data

The 'DJA_HangryMice/data' folder contains most of the necessary processed data files in .mat format. Some important ones are:
- M1_fasted_unreg_preprocessed.mat: Unregistered dataset for EG-1, on fasted day, without drinking, processed for clustering/GLM
- M2_fasted_unreg_male1_preprocessed.mat: Unregistered dataset for EG1-4, on fasted day, without drinking, first male intruder only, processed for clustering/GLM
- EG1-1_fasted_unreg_preprocessed_use.mat: Unregistered dataset for EG-1, on fasted day, processed for clustering/GLM
- EG1-4_fasted_unreg_male1_preprocessed_use.mat: Unregistered dataset for EG1-4, on fasted day, first male intruder only, processed for clustering/GLM
- EG1-4_fasted_unreg_preprocessed.mat: Unregistered dataset for EG1-4, on fasted day, full session, processed for clustering/GLM
- EG1-1_fasted_unreg_rSLDS.mat: Unregistered dataset for EG1-1, on fasted day, processed for rSLDS
- EG1-4_fasted_unreg_male1_rSLDS.mat: Unregistered dataset for EG1-4, on fasted day, first male intruder only, processed for rSLDS
- EG1-4_fasted_unreg_rSLDS.mat: Unregistered dataset for EG1-4, on fasted day, full session, processed for rSLDS
- There is currently no coregistered dataset for EG1-1 that has been processed
- EG1-4_fasted_preprocessed.mat: Coregistered dataset for EG1-4, on fasted day, full session, processed for clustering/GLM
- EG1-4_fasted_rSLDS.mat: Coregistered dataset for EG1-4, on fasted day, full session, processed for rSLDS
- EG1-4_fed_preprocessed.mat: Coregistered dataset for EG1-4, on fed day, processed for clustering/GLM
- There is currently no coregistered dataset for EG1-4, on fed day, processed for rSLDS

## Code

- tuning_raster_pie_fasted.ipynb: Includes behavior-averaged activity, clustering, and counting (pie charts)
- GLM_fasted.ipynb: Includes OLM/ridge GLM fitting, beta weights clustering, GLM predicted activity
- rSLDS_HangryMice_fasted.ipynb: Includes PLS, rSLDS fitting and plotting
- cell-coupled_glm.ipynb: Includes cell-coupled GLM, with connectivity matrix