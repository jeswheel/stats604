---
celltoolbar: Slideshow
jupytext:
  formats: ipynb,md:myst
  notebook_metadata_filter: all
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.15.0
kernelspec:
  display_name: R
  language: R
  name: ir
language_info:
  codemirror_mode: r
  file_extension: .r
  mimetype: text/x-r-source
  name: R
  pygments_lexer: r
  version: 4.2.1
rise:
  auto_select: none
  autolaunch: true
  center: false
  controls: false
  enable_chalkboard: true
  progress: false
  scroll: true
  slideNumber: false
  theme: simple
  transition: none
toc-showtags: true
---

+++ {"slideshow": {"slide_type": "slide"}}

# STATS 604
## Project 4: Weather prediction

+++ {"slideshow": {"slide_type": "slide"}}

### Outline

* Project goals
* Getting started

+++ {"slideshow": {"slide_type": "slide"}}

## Project goals

+++ {"slideshow": {"slide_type": "slide"}}

### Overview

* Predict the {minimum, average, and maximum} daily temperature (in Fahrenheit) as well as whether there will be measurable {rain, snowfall} four days into the future for each of 21 cities.
* Predictions should be made four days in the future starting on Monday, December 4 and ending Thursday, December 7. (inclusive).
  - i.e. on December 4, the model predicts the min/max/avg temp in each city for 12/5, 12/6, 12/7, and 12/8.
  - ...
  - on December 7, predict for 12/8&mdash;12/11.
* Predictions will be obtained by running a containerized version of your predictor off of Dockerhub (see below).
* You will make a total of (5 outcomes) x (21 cities) x (4 days) x (5 days) = 2,100 predictions.
* Goal: minimize MSE (continuous predictions) + 0/1 loss (binary predictions).

+++ {"slideshow": {"slide_type": "slide"}}

## Grading/groups
- Unlike previous projects, working in groups is *optional* for the final project.
- You may work in groups of up to three students (form your own groups on Canvas).
- Final group selections must be made by next Tuesday.
- Grade will be based on writeup, presentation, predictive accuracy, and code quality/reproducibility.

+++ {"slideshow": {"slide_type": "slide"}}

### The cities:

    Ann Arbor       KARB
    Anchorage       PANC
	Boise           KBOI
	Chicago         KORD
	Denver          KDEN
	Detroit         KDTW
	Honolulu        PHNL
	Houston         KIAH
	Miami           KMIA
	Minneapolis     KMIC
	Oklahoma City   KOKC
	Nashville       KBNA
	New York        KJFK
	Phoenix         KPHX
	Portland ME     KPWM
	Portland OR     KPDX
	Salt Lake City  KSLC
	San Diego       KSAN
	San Francisco   KSFO
	Seattle         KSEA
	Washington DC   KDCA
    
(These are all airports where you can get up-to-the-minute weather.)

+++ {"slideshow": {"slide_type": "slide"}}

### Project timeline

* Tuesday, Nov 21: Project check-in/lightning talks.
* Sunday, Dec 3: Model finalized, code committed to Github, Docker image uploaded to Dockerhub.
* Monday, Dec 4: Writeup due. We start running your code to record predictions.
* Tuesday, Dec 5: Presentations
* Monday, Dec 11: Watch party (attendance optional).

+++ {"slideshow": {"slide_type": "slide"}}

### Data and analysis

* Any publicly available data you want.
* Any methods you want.
* **Except**:
    - Readily available weather predictions/forecasts ([example](https://forecast.weather.gov/MapClick.php?lat=42.22389&lon=-83.74))
    - Off-the-shelf weather prediction models (e.g. [this](https://www.mmm.ucar.edu/models/wrf#:~:text=The%20Weather%20Research%20and%20Forecasting,computation%20and%20system%20extensibility), [this](https://blog.research.google/2023/11/metnet-3-state-of-art-neural-weather.html#:~:text=Today%20we%20present%20a%20new,direction%2C%20and%20dew%20point) or [this](https://www.ncei.noaa.gov/products/weather-climate-models/north-american-mesoscale#:~:text=The%20North%20American%20Mesoscale%20Forecast,parameters%2C%20including%20temperature%2C%20precipitation)).
    - If you are unclear what falls into this category, ask. Your analysis should be original.

+++ {"slideshow": {"slide_type": "slide"}}

### Reproducibility

* Write report in markdown
* Compose all analyses in a notebook environment
* Track changes using git
* Collaborate via a github repo
* Organize code into a coherent workflow
  * Use makefiles
  * Cache intermediate outputs  
* Save entire analysis in docker image
* Docker image can also be run to make live predictions

+++ {"slideshow": {"slide_type": "slide"}}

### Docker image

* Docker image should be uploaded to Dockerhub, and shared with me and Jesse
* Should include:
  * Raw data (exactly as downloaded from the internet)
  * All code, including to:
    * Download raw data
    * Fit models
    * Download current weather conditions and make predictions
  * Intermediate outputs, e.g.,
    * Cleaned/processed data
    * Fitted models

+++ {"slideshow": {"slide_type": "slide"}}

### Running the Docker image
* The command  `docker run yourdockerhubname/yourimagename predict` should output that day's predictions to the screen, and then quit.
  
* The output should be a JSON-formatted version of the following data structure:
```
    {city: {date: {'max': x, 'min': y, 'avg': z, 'snow': bool, 'rain': bool}}}
```
(see example in this folder).

* Every day we will run this and record the results.
* `docker run yourdockerhubname/yourimagename train` should reproducibly train your model, including downloading all data.

+++ {"slideshow": {"slide_type": "slide"}}

### Computational resources

* Your docker image should be no larger than 5GB
* `train` should run in under 48 hours.
* `predict` should run in under 5 minutes.
* The machine we will run your code on has:
  * 12 cores
  * 64GB RAM
  * Nvidia GPU with 24Gb VRAM (usage optional)
  * MWireless connection
