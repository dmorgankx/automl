# Automated machine learning in kdb+

## Introduction

The automated machine learning library described here is built largely on the tools available within the machine learning toolkit. The purpose of this framework is to provide users with the ability to automate the process of applying machine learning techniques to real-world problems. In the absence of expert machine learning engineers this handles the following processes within a traditional workflow.

- Data preprocessing
- Feature engineering and feature selection
- Model selection
- Hyperparameter Tuning
- Report generation and model persistence

Each of these steps is outlined in depth within the documentation for this platform [here](https://code.kx.com/q/ml/automl/). This allows users to understand the processes by which decisions are being made and the transformations which their data undergo during the production of the output models.

At present the machine learning frameworks supported for this are based on:

1. One-to-one feature to target non time-series
2. FRESH based feature extraction and model production

The problems which can be solved by this framework will be expanded over time as will the available functionality.

## Requirements

The following requirements cover all those needed to run the libraries in the current build of the toolkit.

- embedPy
- ML-Toolkit

A number of Python dependencies also exist for the running of embedPy functions within both the the machine-learning utilities and FRESH libraries. Install of the requirements can be completed as follows

pip:
```bash
pip install -r requirements.txt
```

or via conda:
```bash
conda install --file requirements.txt
```

**Note**: 

The following are optional additions packages which a user can install in order to allow for a larger range of functionality but which are **not** necessarily required

1. Tensorflow and Keras are required for the application of the some default deep learning models within this platform. Given the large memory requirements of tensorflow the platform will operate without tensorflow by not running the deep learning models. Installing Tensorflow and Keras will allow these models and custom keras models to be run.
2. PyTorch from v0.2.0 it is possible for a user to define their own PyTorch models. PyTorch is however not a necessary requirement for any other functionality within the framework and thus is not explicitly required.
3. From v0.2.0 the default report generation mechanism will use Latex through pylatex. This should be installed separately by a user as it also requires the installation of MikTex and modifications to a users PATH. Failure of this report generation or the lack of the appropriate Python package will result in the report generation defaulting to the v0.1.0 report generation method `reportlab` 

## Installation

Place the library file in `$QHOME` and load into a q instance using `automl/automl.q`

This will load all the functions contained within the `.ml` namespace  
```q
$q automl/automl.q
q).automl.loadfile`:init.q
```

## Documentation

Documentation for all sections of the automated machine learning library are available [here](https://code.kx.com/q/ml/automl/).

## Status

Automated machine learning in kdb+ is still in development and is available here as a beta release, further functionality and improvements will be made to the library in the coming months.

Any issues with the framework should be raised in the issues section of this repository. Functionality suggestions or more general questions should be submitted via email to ai@kx.com

