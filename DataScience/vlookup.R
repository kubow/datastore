#FUNCTION PURPOSE: combine two files based on matching values from each file
#FUNCTION ARGUMENTS:
  #xfile = first file
  #yfile = second file
  #xcol = column to match from x
  #ycol = column to match from y
  #jointype = type of join with default to blank
  #filename = output file name

vlookup <- function(xfile, yfile, xcol, ycol, jointype = "", filename = "MatchedFile.csv"){

  #Read in files
  file1 <- read.csv(file=xfile)
  file2 <- read.csv(file=yfile)

  #Create variable for join type
  join <- jointype

  # Merge by columns
  if (join == "outer")
      {
      results <- merge(file1, file2, by.x = xcol, by.y = ycol, all = TRUE) #keeps all rows from x & y
      }
  else if (join == "left")
      {
      results <- merge(file1, file2, by.x = xcol, by.y = ycol, all.x = TRUE) #keeps all rows from x
      }
  else if (join == "right")
      {
    results <- merge(file1, file2, by.x = xcol, by.y = ycol, all.y = TRUE) #keeps all rows from y
      }
  else
      {
    results <- merge(file1, file2, by.x = xcol, by.y = ycol) #keeps only matching rows from x & y
      }

  #Write results to CSV
  write.csv(results, file = filename, row.names = FALSE)

}