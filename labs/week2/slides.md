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

# Lecture 2a: Overview of study designs; Experiments

+++ {"slideshow": {"slide_type": "slide"}}

### Outline

* Polio
* Overview of study designs
* Mammograms

+++ {"slideshow": {"slide_type": "slide"}}

## Polio

+++ {"slideshow": {"slide_type": "slide"}}

### Brief facts

+++ {"slideshow": {"slide_type": "fragment"}}

* Viral disease that may cause paralysis

+++ {"slideshow": {"slide_type": "fragment"}}

* Range of symptoms and severity
  * ~70% asymptomatic
  * ~25% mild symptoms (sore throat, low fever)
  * ~5% meningitis (head/neck/back pain, vomiting, fever)
  * <1% paralysis

+++ {"slideshow": {"slide_type": "fragment"}}

* Highly contagious, often transmitted fecal-oral

+++ {"slideshow": {"slide_type": "fragment"}}

* Seasonal (summer, autumn)

+++ {"slideshow": {"slide_type": "slide"}}

### Brief history

+++ {"slideshow": {"slide_type": "fragment"}}

* Endemic for much of human history

+++ {"slideshow": {"slide_type": "fragment"}}

* Epidemics began around 1900 in Europe and the US

+++ {"slideshow": {"slide_type": "fragment"}}

* Vaccines developed around 1950

+++ {"slideshow": {"slide_type": "slide"}}

### Testing the vaccine

+++ {"slideshow": {"slide_type": "fragment"}}

* Does the vaccine work?  How could we find out?

+++ {"slideshow": {"slide_type": "fragment"}}

* One idea: Give everyone the vaccine, see if the rate of Polio goes down.

+++ {"slideshow": {"slide_type": "fragment"}}

* We need controls.  But who should get the vaccine, and who shouldn't?

+++ {"slideshow": {"slide_type": "slide"}}

### Randomize or not?

+++ {"slideshow": {"slide_type": "fragment"}}

* Why randomize?

+++ {"slideshow": {"slide_type": "fragment"}}

* Why *not* randomize?

+++ {"slideshow": {"slide_type": "slide"}}

### The Salk Vaccine Trial (Randomized Experiment)

The Randomized Controlled Double-Blind Experiment

|  <i></i>   |    Size |  Rate |
| ---------- | ------: | ----: |
| Treatment  | 200,000 |    28 |
| Control    | 200,000 |    71 |
| No Consent | 350,000 |    46 |

Rate is cases per 100,000.

+++ {"slideshow": {"slide_type": "slide"}}

### The Salk Vaccine Trial (NFIP Study)

| <i></i>                 |    Size |  Rate |
| ----------------------- | ------: | ----: |
| Grade 2 (vaccine)       | 225,000 |    25 |
| Grade 1 and 3 (control) | 725,000 |    54 |
| Grade 2 (no Consent)    | 125,000 |    44 |

Rate is cases per 100,000.

+++ {"slideshow": {"slide_type": "slide"}}

### Discussion Question -- Working backwards

Can we use the result of the NFIP study to (nearly) reproduce the results of the randomized experiment?  

In both studies, the rate of polio among people receive the vaccine is about 28 (25).  In both studies, the rate of polio among the no-consent group is about 46 (44).  The difference is in the control group.  In the experiment, the rate is 71; in NFIP it's 54.  That's because the NFIP study includes people who would not have given consent, had you had asked them.  

Use simple algebra to estimate the rate of polio among the NFIP controls, just among those would would have given consent if you had asked them.  What assumption(s) do you need to do this?

+++ {"slideshow": {"slide_type": "slide"}}

### Method of Comparison
* To know if a treatment works, we need something to compare it to.
* In an experiment, we want the treatment group and the control group to be as similar as possible -- except for treatment.
* Randomization ensures that people in the treatment and control groups are similar.
* Double-blinding ensures that people in the treatment and control groups are evaluated similarly.
* **The only difference between the treatment and control groups should be the treatment!**

+++ {"slideshow": {"slide_type": "slide"}}

## Overview of study designs

+++ {"slideshow": {"slide_type": "slide"}}

### Types of Studies
<img src="images/studies1.png" width="80%">

+++ {"slideshow": {"slide_type": "slide"}}

### Types of Studies

+++ {"slideshow": {"slide_type": "fragment"}}

* In an **experiment**, the researcher decides who will get treatment and who will get control.

+++ {"slideshow": {"slide_type": "fragment"}}

* In an **observational study**, the researcher does not decide who will get treatment and who will get control.  
  * Often the subjects decide themselves.  
  * Sometimes some other external factor decides.

+++ {"slideshow": {"slide_type": "fragment"}}

* **Natural Experiments** are somewhere "in between" experiments and observational studies  
  * The researcher *does not* decide who gets treatment and who gets control  
  * The subjects also *do not* decide whether they will get treatment or control  
  * Instead, treatment is determined by some external factor  
  * Critically, *the researcher can argue that the external factor is essentially random*  
  * "Nature performs an experiment for us"

+++ {"slideshow": {"slide_type": "slide"}}

### Confounding

* Key problem with observational studies: Confounding.  
* Confounder: A variable that  
  1. is associated with treatment  
  2. has an effect on response.  
* When confounders are present, it's hard to say whether any observed difference in response between the treatment group and the control group is due to treatment, or due to the confounders.

+++ {"slideshow": {"slide_type": "slide"}}

## Mammograms

+++ {"slideshow": {"slide_type": "slide"}}

### Background
* Breast cancer is one of the most common malignancies among women in the U.S.  
* If detected early enough, chances of successful treatment are much better.  
* Do mammogram screening programs speed up detection by enough to matter?

+++ {"slideshow": {"slide_type": "slide"}}

### HIP Trial
* First large-scale trial was run by the Health Insurance Plan of Greater New York, starting in 1963.  
* The subjects (all members of the plan) were 62,000 women age 40 to 64.  
* Divided at random into treatment and control groups, each of size ~31,000.
* In the treatment group, people were encouraged to come in for annual screening, including examination by a doctor and X-rays.  About 20,200 people in the treatment group did come in for the screening; but 10,800 refused.  
* The control group was offered usual health care.  
* Both treatment and control groups were followed for many years.  Results for the first 5 years are shown in the table below.

+++ {"slideshow": {"slide_type": "slide"}}

### Results
<img src="images/hiptable.png" width="80%">

+++ {"slideshow": {"slide_type": "slide"}}

### Discussion questions

+++ {"slideshow": {"slide_type": "fragment"}}

* Does screening save lives?  Which numbers in the table prove your point?

+++ {"slideshow": {"slide_type": "fragment"}}

* Why is the death rate from all other causes in the whole treatment group ("examined" and "refused" combined) about the same as the rate in the control group?

+++ {"slideshow": {"slide_type": "fragment"}}

* Breast cancer (like polio, but unlike most other diseases) affects the rich more than the poor.  Do we see evidence of this in the table?  Where?

+++ {"slideshow": {"slide_type": "fragment"}}

* The death rate (from all causes) among women who accepted screening is about half the death rate among women who refused.  Did screening cut the death rate in half?  If not, what explains the difference in death rates?

+++ {"slideshow": {"slide_type": "slide"}}

### Discussion questions

+++ {"slideshow": {"slide_type": "fragment"}}

* To show that screening reduces the risk from breast cancer, someone wants to compare 1.1 and 1.5.  Is this a good comparison?  Is it biased against screening?  For screening?

+++ {"slideshow": {"slide_type": "fragment"}}

* Someone claims that encouraging women to come in for breast cancer screening increases their health consciousness, so these women take better care of themselves and live longer for that reason.  Is the table consistent or inconsistent with the claim?  Explain briefly.

+++ {"slideshow": {"slide_type": "fragment"}}

* In the first year of the HIP trial, 67 breast cancers were detected in the "examined" group, 12 in the "refused" group, and 58 in the control group.  True or false, and explain briefly: screening causes breast cancer.
