require("magrittr")
require("dplyr")
packages <- c("magrittr", "dplyr")
new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
sapply( packages, function(l){require(l,character.only = T)} )
rm(list=ls())


# Find all PIT players
master <- read.csv("resources/lahman/Master.csv")
pit.plyr.id <- read.csv("resources/lahman/Appearances.csv") %>%
    filter(teamID=="PIT") %>%
    distinct(playerID) %>%
    .$playerID

pit.plyr <- master %>% filter(playerID %in% pit.plyr.id) %>%
    arrange(desc(debut))

# TODO
# Provide a function to determin the position that a player appeared in a season


