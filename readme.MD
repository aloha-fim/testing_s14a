CSCI S14A - Building Interactive Web Applications for Data Analysis

# Real Estate Computer Vision

**Zoom Link**: https://harvard.zoom.us/j/92432478740?pwd=ZlcweVpDcWtJMytuUFhTbmdsZW4vdz09

**Github Repo**: https://github.com/Harvard-DCE-BIWADA/real-estate-cv.git

**Website Location**: http://68.183.152.127:5000/

### Lead Instructor
Professor Zona Kostic

### Teaching Fellow
Frederec Im - fri998@g.harvard.edu / frederec.im@gmail.com

### Team Members

Tiffany Valdecantos - tiv001@g.harvard.edu <br>
Ibraheem Abdul-Malik - ibraheem4@gmail.com <br>
Jean Raymond - jrr872@g.harvard.edu <br>

## Project

We will evaluate and data engineer common real estate features to predict real estate prices within the Boston metropolitan area.  We will then leverage computer vision techniques such as transformers and convolutional neural networks to analyze images to complement the real estate features available.  The goal is to improve prediction sale price for real estate properties through enhance image classification.

The main components of the app are:

1. **User Request Form** - User will enter features needed for model such as #bathrooms, #bedrooms, etc. and address (API used to process address to get lat/long).
2. **Image Upload** - User will upload image to be run through Vision Transformer for classification
3. **Results Display** - Features are input into model to predict sales price displayed together with image classification


# References & Citations

​What Image Features Boost Housing Market Predictions? JOURNAL OF LATEX CLASS FILES, VOL., NO., AUGUST

https://medium.com/intelligentmachines/implementation-of-class-activation-map-cam-with-pytorch-c32f7e414923

https://jacobgil.github.io/pytorch-gradcam-book/HuggingFace.html