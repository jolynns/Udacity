# R Script for section 2 Visualizing Data
# data from PDF questions

# create a data set of petals
Petals <- c(15, 16, 17,
            16, 21, 22,
            15, 16, 15,
            17, 16, 22,
            14, 13, 14,
            14, 15, 15,
            14, 15, 16,
            10, 19, 15,
            15, 22, 24,
            25, 15, 16)

# Find the most frequent variable
tt = table(Petals)
MostFreq <- names(tt[tt==max(tt)])
print(paste0("The most frequent petal count is: ", MostFreq))

# Find the frequency of flowers with 15 petals

PetalFreq <- length(which(Petals==15))
print(paste0("The frequency of flowers with 15 petals is: ", PetalFreq))

# Find the proportion of flowers with 15 petals

TotalSample <- length(Petals)
PetalProp <- PetalFreq/TotalSample
print(paste0("The proportion of flowers with 15 petals is: ", PetalProp))

# Find the percentage of flowers with 15 petals

PetalPerc <- PetalProp * 100
print(paste0("The percentage of flowers with 15 petals is: ", PetalPerc, "%"))

# Create a historgram with a bin size of 2
hist(Petals, breaks = (length(Petals)/2))

# Create a historgram with a bin size of 5
hist(Petals, breaks = (length(Petals)/5))

# Viewing the histogram you can see a positive skew to the data

# Find the most frequent variable
tt = table(Petals)
MostFreq <- names(tt[tt==max(tt)])
print(paste0("The most frequent petal count is: ", MostFreq))

# Most flowers have around 15 petals
