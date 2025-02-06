# ECG Arrhythmia Detection and Classification

## Overview
This project aims to detect and classify cardiac arrhythmias from ECG signals using machine learning techniques. The **MIT-BIH Arrhythmia Database** is used for training, and models such as **Logistic Regression** and **LSTM (Long Short-Term Memory) Networks** are implemented for classification.

## Features
- **Signal Preprocessing**:
  - Noise removal using **Notch filters (30Hz & 60Hz)**
  - **Moving Average filtering** for signal smoothing
  - **Z-score normalization** for amplitude standardization
- **Segmentation**:
  - Extraction of individual heartbeats based on R-peak annotations
- **Modeling**:
  - **Logistic Regression** as a baseline classifier
  - **LSTM-based deep learning model** for sequence classification
- **Performance Evaluation**:
  - **Confusion Matrix**
  - **ROC Curve Analysis**
  - **Accuracy & Loss Plots**

## Dataset
- **Source**: [MIT-BIH Arrhythmia Database](https://physionet.org/content/mitdb/1.0.0/)
- **Sampling Rate**: 360 Hz
- **Classes Considered**: 
  - N (Normal)
  - A (Atrial Premature Beat)
  - V (Premature Ventricular Contraction)
  - L (Left Bundle Branch Block)
  - R (Right Bundle Branch Block)
  - F (Fusion Beat)

## Installation
Clone the repository and install dependencies:
```sh
# Clone the repository
git clone https://github.com/yourusername/ecg-arrhythmia-detection.git
cd ecg-arrhythmia-detection

# Install dependencies
pip install -r requirements.txt
