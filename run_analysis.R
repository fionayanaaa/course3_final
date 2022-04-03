install.packages("dplyr")
library("dplyr")
# get training, testing data, and feature names
training <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
testing <-  read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
feature <-  read.table("./UCI HAR Dataset/features.txt", header = FALSE)
train_label <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
test_label  <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
# merge two data into one set
dat <- rbind(training, testing)
dat_label <- rbind(train_label, test_label)
dat_subject <- rbind(train_subject, test_subject)
# extract features and fill the dat column name using features
names <- pull(feature, V2)
colnames(dat) <- names
colnames(dat_label) <- "Activity"
colnames(dat_subject) <- "Subject"
# extra mean and std columns
dat_mean <- dat[, grep("mean", colnames(dat))]
dat_std  <- dat[, grep("std", colnames(dat))]
new_data <- cbind(dat_mean, dat_std)
# convert label from number to activity name
dat_label$Activity[dat_label$Activity == 1] <- "WALKING"
dat_label$Activity[dat_label$Activity == 2] <- "WALKING_UPSTAIRS"
dat_label$Activity[dat_label$Activity == 3] <- "WALKING_DOWNSTAIRS"
dat_label$Activity[dat_label$Activity == 4] <- "SITTING"
dat_label$Activity[dat_label$Activity == 5] <- "STANDING"
dat_label$Activity[dat_label$Activity == 6] <- "LAYING"
dat_clean <- cbind(new_data, dat_subject, dat_label)
# calculate subject and activity average
final_names <- colnames(dat_clean)
final_data <- data.frame(matrix(nrow = 0, ncol = length(final_names)))
colnames(final_data) <- final_names
for (i in 1:30) {
  for (j in c("STANDING", "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "LAYING")) {
    filter_data <- dat_clean[dat_clean$Subject == i & dat_clean$Activity == j, ]
    value_data <- filter_data[, 1:79]
    avg <- colMeans(value_data)
    avg <- data.frame(as.list(avg))
    label <- c(sprintf("Subject %d & %s", i, j))
    names(label) <- "Label"
    temp_row <- cbind(avg, label)
    final_data <- rbind(final_data, temp_row)
  }
}

write.table(final_data, "./output_data.txt", row.names = FALSE)
  

