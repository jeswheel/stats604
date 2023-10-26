library(tidyverse)

codebook <- read_tsv("data/Codebook.txt")
study1 <- read_tsv("data/Study 1 .txt")
study2 <- read_tsv("data/Study 2.txt")

study1 %>% filter(!when64) %>% aov(feelold ~ dad + kalimba, data=.) %>% summary

study2 %>% filter(!potato) %>% aov(aged365 ~ dad + when64, data=.) %>% summary
# without controlling for father's age
study2 %>% filter(!potato) %>% aov(aged365 ~ when64, data=.) %>% summary

# We generated random samples with each observation independently drawn from a
# normal distribution, performed sets of  analyses on each sample, and observed
# how often at least one  of  the  resulting  p values  in  each  sample  was
# below  standard significance levels.

# The table reports the percentage of 15,000 simulated samples in which at least
# one of a  # set of analyses was significant. Observations were drawn
# independently from a normal distribution. Baseline is a two-condition design
# with 20 observations per cell.

# Situation A were  obtained by conducting three t tests, one on each of two
# dependent variables and a third on the  average of these two variables.

ttp <- function(...) { t.test(...)$p.value }

sim.situation <- function(s) {
  replicate(15000, s()) %>% ecdf %>% map_dbl(c(.1, .05, .01), .)
}


situation_A <- function() {
  r <- 0.5
  X <- rnorm(n=40)
  Y <- rnorm(n=40) 
  Z <- r * X + sqrt(1 - r^2) * Y
  v1 <- X
  v2 <- Z
  v3 <- (v1 + v2) / 2
  list(v1, v2, v3) %>% map_dbl(ttp) %>% min
}

res.A <- sim.situation(situation_A)

# Situation B were obtained by conducting one  t test after  collecting 20
# observations per cell and another after collecting an additional 10
# observations per cell.
situation_B <- function() {
  X <- rnorm(n=60) 
  min(ttp(X[1:20], X[31:50]), ttp(X[1:30], X[31:60]))
}

res.B <- sim.situation(situation_B)

# Results for Situation C were obtained by conducting a  t test, an analysis of
# covariance with a  gender main effect, and an analysis of covariance with a
# gender interaction (each observation was  assigned a 50% probability of being
# female
situation_C <- function() {
  X <- rnorm(n=40)
  T <- c(rep(0, 20), rep(1, 20))
  G <- runif(n=40) < 0.5
  f <- function(s) {
    v <- anova(lm(as.formula(s)))[c(1,3), 5]
    min(v[!is.na(v)])
  }
  paste("X ~ ", c("T", "T + G", "T * G")) %>% map_dbl(f) %>% min
}

res.C <- sim.situation(situation_C)

results_tbl <- matrix(c(res.A, res.B, res.C), byrow=T, nrow=3) %>% 
  as_tibble %>% setNames(c("p<.1", "p<.05", "p<.01")) %>% 
  mutate(scenario=c("Two correlated variables", "Additional data", "Gender interaction")) %>% 
  dplyr::select(scenario, everything())

library(kableExtra)
kbl(results_tbl, booktabs=T, digits=3, 
    caption="Likelihood of obtaining a false-positive result") %>% 
  add_header_above(c(" ", "Significance Level" = 3))
