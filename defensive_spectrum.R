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

# Get the position that a player appeared in a season
Get.Position <- function(x)
{
    # Select columns correspond to defensive positions
    x[,10:17] %>% apply(1, function(i){
        names(i)[which.max(i)]
    })
}

# Get fielders (not pitcher, and number of games played larger than 0)
pit.fielder <- read.csv("resources/lahman/Appearances.csv") %>%
    filter(teamID=="PIT", G_p==0, G_all!=0)

# Add position to pit fielders
pos <- Get.Position(pit.fielder)
pit.fielder <- cbind(pit.fielder,pos)

# Extract year, team, player and position only
pit.fielder <- pit.fielder %>%
    mutate(position=toupper(substr(pos,3,length(pos)))) %>%
    select(playerID, teamID, position, yearID) %>%
    arrange(playerID, yearID)



