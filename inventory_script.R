# Task
#1. Merge Westminster and Pomona inventory files.
#2. Add a column beginning with the suffix 'L' followed by six numbers.
#3. Add "Classes" column and label as one of the following: 
        # 'Lab instrument hand held'
        # 'Lab instrument fixed'
        # 'Customer supplied'
        # 'Project'
#4. Add column for "Status". Leave blank for now.
rm(list=ls())
require(tidyr); require(dplyr)
setwd('C:/Users/salazae/Desktop/Inventory')
w <- read.csv('Westminster_inventory.csv', stringsAsFactors = FALSE)
p <- read.csv('Pomona_inventory.csv', stringsAsFactors = FALSE)

# rename columns so similar columns have the same column names.
w <- w %>% dplyr::rename(Item = Item.,
                         Calibration.Equipment = Calibration.Equipment..,
                         Funding.Source = funding.source,
                         Other.ID = Other.ID..s)

p <- p %>% dplyr::rename(Item = Item...Technical.ID.Number,
                         Old.Asset.Number = Old.Asset...Description.Test.Space,
                         Make = Make.Manufacturer,
                         Model = Model.Number,
                         Serial.Number = Serial.Number.Manufacturer.Serial.Number,
                         Description = Description..Description,
                         Calilbration.Date = Calibration.Date.Measurement.Point.and.Document,
                         Calibration.Equipment = Calibration.Equipment..,
                         Other.ID = Other.ID..s)

df <- bind_rows(w, p)

### add column with "L######" ###
ID <- "L######"
df <- cbind(ID, df)
df$ID <- as.character(df$ID)

# factor some of the variables (just to enable group analysis)
df$Make <- as.factor(df$Make)
df$Model <- as.factor(df$Model)
df$Description <- as.factor(df$Description)
df$Location <- as.factor(df$Location)
df$Responsible.Lab <- as.factor(df$Responsible.Lab)

# remove blank columns
df <- df %>% select(-c(X, X.1, X.2, X.3, X.4, Accountibility..Responsible.Group,
                       Color.Key, Project.Lead, Class))

#3. Add "Class" column and label as one of the following: 
        # 'Lab instrument hand held'
        # 'Lab instrument fixed'
        # 'Customer supplied'
        # 'Project'

df$Class <- "NA"

levels <- levels(df$Description)
write.csv(levels, "levels.csv")
write.csv(df, "df.csv")




