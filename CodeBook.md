# Steps I have taken to clean the data
## Step 1
First, I loaded train/test_X, train/test_y, train/test_subject to R data frames.
I also loaded the feature file to R data frame.
Then, I combined train_X and test_X, train_label and test_label, train_subject and test_subject by rbind command to get the merged dataset "dat"

## Step 2
Then I extracted the 561 feature names from the feature data frame and set them as the names of overall merged set "dat".

## Step 3
Then I extracted two subsets based on column names containing "mean" and "std", and combined them together to form "new_data"

## Step 4
Then I mapped activity number with its label name such as "WALKING" to get the first required dataset "dat_clean".

## Step 5
Then I created an empty data frame using colmun names of "dat_clean"

## Step 6
I used a nested for loop to loop through all subjects and activities, and calculate the column average of each conditions. After rbinding all the average sets, we can the tidy_data set "final_data".
