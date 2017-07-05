#This code will fill populate the missing values in the Area variable 
#with an appropriate values (Birmingham, Coventry, Dudley, Sandwell, 
#Solihull, Walsall or Wolverhampton
library(tidyr)

dirty_frame = read.csv("dirty_data.csv")
colnames(dirty_frame)
head(dirty_frame)

data_filled=fill(dirty_data, Area, .direction = c("down"))
data_filled

#This code will Remove special characters, padding (the white space before and after the text) 
#from Street 1 and Street 2 variables

data_filled$Street = gsub("[^A-Za-z ]", " ",data_filled$Street)
data_filled$Street = gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", data_filled$Street, perl=TRUE)
data_filled$Street

data_filled$`Street 2` = gsub("[^A-Za-z ]", " ", data_filled$`Street 2`)
data_filled$`Street 2` = gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", data_filled$`Street 2`, perl=TRUE)
data_filled$`Street 2` 

data_filled$Street = gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", data_filled$Street, perl=TRUE)
data_filled$`Street 2` =  gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", data_filled$`Street 2`, perl=TRUE)

## This Code will Make sure the first letters of street names are capitalized and the street denominations are following the same standard 
##(for example, all streets are indicated as âstr.â, avenues 

library('gsubfn')

patterns     <- c("Lane", "Road", "Avenue", "Green", "Hospital", "Village", "Center", "Drive", "Circle", "Park","Street")
replacements <- c("Lan.",  "Rd.", "Ave.", "Gr.","Hosp.","Vil.","Ctr.", "Dr.", "Cr.","Pk.","Str.")

data_filled$Street = gsubfn("\\b\\w+\\b", as.list(setNames(replacements, patterns)), data_filled$Street)
data_filled$`Street 2` =  gsubfn("\\b\\w+\\b", as.list(setNames(replacements, patterns)), data_filled$`Street 2`)

data_filled$Street
data_filled$`Street 2` 


#  If the value in Street 2 duplicates the value in Street 1, 
# this code will remove the value in Street 2


i = 1

while(i < nrow(data_filled )) 
{
  if(data_filled$Street[i] == data_filled$`Street 2` [i]) 
  {
    data_filled$`Street 2` [i] = ""
  }
  i = i+1
}


# This code will remove the “Strange HTML column”
columns = 1:4
data_filled = subset(data_filled[,1:4])
head(data_filled)


