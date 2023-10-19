# ## False-positive psychology

# Load csv-data files from online links:
fppsy <- readr::read_csv(file = "http://rpository.com/ds4psy/data/falsePosPsy_all.csv")
fppsy

# ### Reproduction

lm(feelold ~ kalimba, data=fppsy) %>% summary

# ## Fluctuating female vote

library(tidyverse)
library(multiverse)
data(durante)

nrow(durante)
table(durante$Relationship)

library(forcats)
cleaned <- durante %>% mutate(
  Relationship = factor(Relationship,
    labels = c("single", "dating", "engaged", "married")
  )
)
table(cleaned$Relationship)
(139 + 135) / nrow(cleaned) # 54.5% single

cleaned <- cleaned %>%
  mutate(ComputedCycleLength = StartDateofLastPeriod - StartDateofPeriodBeforeLast) %>%
  mutate(NextMenstrualOnset = StartDateofLastPeriod + ComputedCycleLength) %>%
  mutate(CycleDay = pmax(1, pmin(28, 28 - (NextMenstrualOnset - DateTesting)))) %>%
  mutate(Fertility = cut(CycleDay, breaks=c(0, 7, 15, 17, 26, Inf) - .5,
                         labels=c("excluded", "low", "medium", "high", "excluded"))
  )

table(cleaned$Fertility)  # low and high are within 1 each

# relationship status -- close match on engaged, others are off a bit
cleaned <- filter(cleaned, Fertility %in% c("low", "high")) 
cleaned$Relationship %>% table %>% prop.table

cleaned <- mutate(cleaned, InRelationship = Relationship %in% c("engaged", "married"))
table(cleaned$InRelationship)  # perfectmatch

cleaned <- mutate(cleaned, Rel = (Rel1+Rel2+Rel3)/3)

# Finding 1
aov(Rel~InRelationship*Fertility, data=cleaned) %>% summary

# Finding 2
glm(Vote ~ InRelationship*Fertility, data=cleaned, family="binomial") %>% summary
