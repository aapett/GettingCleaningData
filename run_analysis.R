library(tidyverse);library(stringr)
rm(list = ls())
setwd('c:/users/apett/Dropbox (Personal)/Coursera Data Science/C3/UCI HAR Dataset/analysis/')

###Load and Clean Data####

##load labels
features <- read.delim('../features.txt',sep = ' ', header = F)
activity_labels <- read.delim('../activity_labels.txt', sep = ' ', header = F)

##load and prepare training data
subjects.train <- read.delim('../train/subject_train.txt',header = F)
activity.train <- read.delim('../train/y_train.txt',header = F) %>% 
  left_join(activity_labels) %>% 
  select(-1)

data.train <- read_lines('../train/X_train.txt') %>% 
  str_replace('^\\s*','') %>% 
  enframe() %>% 
  separate(value, into = as.character(features$V2),sep = '[[:blank:]]+') %>% 
  bind_cols(subjects.train,activity.train) %>% 
  mutate(group = 'training') %>% 
  select(subject = V1, group, activity = V2, everything(),-name)

##load and prepare experiment data
subjects.exp <- read.delim('../test/subject_test.txt', header = F)
activity.exp <- read.delim('../test/y_test.txt', header = F)%>% 
  left_join(activity_labels) %>% 
  select(-1)

data.exp <- read_lines('../test/X_test.txt') %>% 
  str_replace('^\\s*','') %>% 
  enframe() %>% 
  separate(value, into = as.character(features$V2),sep = '[[:blank:]]+') %>% 
  bind_cols(subjects.exp,activity.exp) %>% 
  mutate(group = 'experiment') %>% 
  select(subject = V1, group, activity = V2, everything(),-name)

#cleanup tables that are no longer needed
rm(activity_labels,activity.exp,activity.train,features,subjects.exp,subjects.train)

###Final Data####

##merge training and experiment data, select mean and SD variables
data.all <- bind_rows(data.exp,data.train) %>% 
  select(subject, group, activity, matches('mean|std'),-matches('angle')) %>% 
  mutate_at(vars(matches('mean|std')), as.numeric)

#mean of each variable by subject and activity
stats.all <- data.all %>% 
  group_by(subject, activity) %>% 
  summarise_at(vars(matches('mean|std')),mean, na.rm = T)

#save data
write.csv(data.all,'subject_data.csv', row.names = F)
write.csv(stats.all,'subject_stats.csv', row.names = F)



