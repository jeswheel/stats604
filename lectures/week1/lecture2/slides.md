---
celltoolbar: Slideshow
jupytext:
  formats: ipynb,md:myst
  notebook_metadata_filter: all
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.15.1
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
  version: 4.2.2
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

# Lecture 2: Working with gene expression data

+++ {"slideshow": {"slide_type": "slide"}}

## Scientific Background

One of the most important challenges in all of science is **understanding the genetic architecture of complex traits**.

![mendelian trait](https://upload.wikimedia.org/wikipedia/commons/1/17/Punnett_square_mendel_flowers.svg)
(Wikipedia)

+++ {"slideshow": {"slide_type": "slide"}}

- The simplest traits behave like Mendel's peas.
- However, many traits have a much more complex "architecture", and are affected by thousands of genetic variants scattered throughout the genome.
- Height is one such example; schizophrenia is another.

![image-2.png](attachment:image-2.png)

+++ {"slideshow": {"slide_type": "slide"}}

## DNA, RNA, Proteins

How does genetic code translate into phenotype (observable trait)? This is called the **central dogma of molecular biology**:


![complex traits](https://cdn.kastatic.org/ka-perseus-images/53b7ece60303244264411d03bfbe55d36312b64e.png)

+++ {"slideshow": {"slide_type": "slide"}}

## GWAS
- If we have gene sequences from many different people ($X$), as well as corresponding trait information ($y$), we might try regression to understand the genetic architecture:

$$\underbrace{y}_{\text{height, disease status, etc.}} = \underbrace{\mathbf{X}}_{\text{genotype}}\cdot \beta + \epsilon$$

- This is called a **genomewide association study** (GWAS).
- GWAS can successfully pinpoint the genetic origins of some traits, especially if they have a "simple" architecture.
- However, it fails to explain heritability of many other 

+++ {"slideshow": {"slide_type": "slide"}}

## The central dogma

Notice in the above figure that there is a step (in fact, multiple steps) "between" the genetic code and the ultimate phenotype. In fact the process by which "your code" becomes "you" is quite complicated. It is known as the **central dogma of molecular biology**:

$$\text{DNA} \longrightarrow \text{RNA} \longrightarrow \text{protein}$$

+++ {"slideshow": {"slide_type": "slide"}}

### Cells

<img src="images/Animal_cell.png" width="80%" class="center">

+++ {"slideshow": {"slide_type": "slide"}}

### DNA, RNA, Proteins

<img src="images/central_dogma.jpg" width="30%" class="center">

+++ {"slideshow": {"slide_type": "slide"}}

### DNA, RNA, Proteins

<img src="images/protein_synthesis.png" width="65%" class="center">

+++ {"slideshow": {"slide_type": "notes"}}

Summarizing:

* Each cell has two full copies of your DNA (one from each parent).
* Some, **but not all**, genes will get transcribed to mRNA
  * The **amount** (*expression*) of mRNA can differ dramatically from gene to gene.
  * Gene expression varies from cell to cell.
  * Gene expression varies over time within a cell.
* The mRNA gets tranlsated to proteins:
  * The proteins "do stuff".
  * Structural: pores in the cell membrane, microfillaments, etc.
  * Chemical: catalyze reactions, etc.
  
**All of these steps together govern the final outcome.**

+++ {"slideshow": {"slide_type": "slide"}}

### Regulation

* The process of 
$\text{DNA} \longrightarrow \text{RNA} \longrightarrow \text{protein}$
is highly regulated.
* Gene expression can be upregulated or downregulated, e.g., via various feedback loops within the cell.
* Understanding how gene expression works is key to further understand how complex traits evolve and are governed.
    - Many diseases, including certain cancers, are driven by changes in gene expression.
    - By knowing which genes are turned on or off by a particular treatment, researchers can develop more targeted and effective drugs.

+++ {"slideshow": {"slide_type": "slide"}}

![image.png](attachment:image.png)

+++ {"slideshow": {"slide_type": "slide"}}

## 🤔 Discussion

- What is the point of this paper? Why is it in Science?
- Did you find it easy or hard to read?
- What is/are their main results? Do you find their conclusions convincing?
- How was the data collected? What are some potential limitations of the study design?

+++ {"slideshow": {"slide_type": "slide"}}

![image.png](attachment:image.png)

+++ {"slideshow": {"slide_type": "slide"}}

## Working with the GTEx data

- Most of the data is freely available at the [GTEx Portal](https://www.gtexportal.org/home/).
- For privacy reasons, access to the raw data controlled. We'll work with the summarized data.

+++ {"slideshow": {"slide_type": "slide"}}

### Individual-level phenotypes
(restricted due to privacy)

```{code-cell} r
---
slideshow:
  slide_type: fragment
---
library(tidyverse)
base_url <- "https://storage.googleapis.com/gtex_analysis_v8"
pheno_url <- str_c(base_url, "/annotations/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt")
download.file(pheno_url, "phenotypes.txt")
donors_df <- read_delim("phenotypes.txt") %>% print
```

```{code-cell} r
---
slideshow:
  slide_type: fragment
---
samples_url <- str_c(base_url, "/annotations/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt") 
download.file(samples_url, "samples.txt")
samples_df <- read_delim("samples.txt") %>% print
```

For this lab we'll focus on the RNA-seq samples:

```{code-cell} r
---
slideshow:
  slide_type: fragment
---
rnaseq_df <- samples_df %>% filter(SMAFRZE == "RNASEQ") %>% print
```

+++ {"slideshow": {"slide_type": "slide"}}

The `SMTSD` stands for 'Tissue Site Detail'. It tells us which tissue each of the samples was collected from:

```{code-cell} r
---
slideshow:
  slide_type: fragment
---
rnaseq_df %>% count(SMTSD) %>% top_n(5)
```

+++ {"slideshow": {"slide_type": "slide"}}

The first two components of the sample ID are the donor ID. So, to find e.g. all whole blood samples from the male subjects, we could use the query:

```{code-cell} r
rnaseq_df %>% 
    mutate(SUBJID = map_chr(SAMPID, \(s) str_c(str_split(s, "-", simplify = T)[1:2], collapse="-"))) %>% 
    left_join(donors_df) %>% 
    filter(SEX == 1, SMTSD == "Whole Blood") %>% 
    print
```

+++ {"slideshow": {"slide_type": "slide"}}

## Expression data
Expression data are expressed as [TPM](https://academic.oup.com/bioinformatics/article/26/4/493/243395?login=true) (transcripts per million). (Higher means more expression.)

```{code-cell} r
---
slideshow:
  slide_type: fragment
---
#  rna_seq <- str_c(base_url, '/rna_seq_data/GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct.gz')
#  download.file(rna_seq, 'gene_tpm.gct.gz')  # warning: large

rna_seq <- str_c(base_url, '/rna_seq_data/GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_median_tpm.gct.gz')
download.file(rna_seq, 'gene_tpm.gct.gz')
gene_tpm_df <- read_delim("gene_tpm.gct.gz", skip=2)
```

```{code-cell} r
---
slideshow:
  slide_type: slide
---
gene_tpm_df %>% head
```

+++ {"slideshow": {"slide_type": "slide"}}

##  Project 1

This project is designed to practice **exploratory data analysis**. Imagine that:

* You are the statistical collaborator to the lab that produced this data.
* The experiment just completed, and the data just became available.
* You have been given the data, and been asked to take a look at it.
* You will be presenting at group meeting in two weeks.

+++ {"slideshow": {"slide_type": "slide"}}

As you poke around this data set, keep an eye out for:
* Potential problems with the data.
* Anything odd or unexpected.
* Challenges the data will pose (possibly unanticipated).
* Anything especially interesting.
* Initial findings.
* Suggestions for future runs of the experiment.

+++ {"slideshow": {"slide_type": "slide"}}

Additional notes:

* Insightful data visualization is important.
* Fancy models (or any models) are not needed.
* The overall goal is *insight* -- into the data, into the experimental methodology, into the science.

+++ {"slideshow": {"slide_type": "slide"}}

## Deliverables
- An 8-10 page writeup describing the data, what analyses you performed, and your findings, due two weeks from yesterday.
- A brief (not to exceed 15m) presentation summarizing your results, given in class in two weeks.
- Groups of three students have been randomly assigned on Canvas.
- It's okay to divide up the work, as long as everyone does roughly an equal amount of work.
