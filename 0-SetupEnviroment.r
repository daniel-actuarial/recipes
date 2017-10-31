## General options
options(OutDec= ",") # Change decimals
options(warn=-1) # Deactivate warnings
options(scipen=999) # Avoid scientific notation


## Use multiple cores
library(doParallel)
registerDoParallel(cores=4)


## Set clock
st <- Sys.time()
st0 <- st


## Install packages
install.packages("caret", dependencies = c("Depends", "Suggests"))


## Update packages

# list all packages where an update is available
old.packages()

# update all available packages
update.packages()

# update, without prompts for permission/clarification
update.packages(ask = FALSE)

# update only a specific package use install.packages()
install.packages("plotly")

