Repo: GettingCleaningData
Author: aapett
Purpose: For course 3 in the Data Specialization track on Coursera.com, 
for the purposes of loading and tidying a dataset and then performing some simple statistics on the cleaned data.

Files:
run_analysis.R  	-- R script that: 	
	1.) Loads in the training, test, subject, and activity data. As well as variable names
	2.) Removes leading whitespace from each line of training and test data
	3.) Converts training and test data to a tibble
	4.) Separates each variable into a seperate column
	5.) Merges subject and activity information with training and test tables.
	6.) Adds the variable names as a header row to training and test tables
	7.) Binds Training and Test tables together.
	8.) Removes all columns except subject, activity, group, and the std and means for each exp variable. 
	9.) Finds the means for each variable by subject and activity.
	10.) Outputs subject_data.csv and subject_stats.csv
subject_data.csv	-- 	Table containg a clean, tidy copy of the training and experimental data.
						Contains only the mean and standard deviation for each variable.
subject_stats.csv	--	Table contains the means of each variable in subject_data.csv grouped by subject and activity.
CodeBook.md			--	Describes the the variables listed in subject_data and subject_stats
README.md			--	This README, describes files located within GettingCleaningData repository.