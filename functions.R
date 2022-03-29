library("plotrix")
library(readxl)
library(dplyr)

clubs <- read_excel("clubs.xlsx")

drivers <- c("rocket","extramile", "bigtopper", "quarterback", "rock", "thorshammer", "apocalypse")
woods <- c('horizon', 'viper','bigdawg', 'hammerhead', 'guardian', 'sniper', 'cataclysm')
longirons <- c('grimreaper','backbone', 'goliath', 'saturn', 'b52', 'grizzly', 'tsunami')
shortirons <- c('apache', 'kingfisher', 'runner', 'thorn', 'hornet', 'claw', 'falcon')
wedges <- c('dart', 'firefly', 'boomerang', 'downinone', 'skewer', 'endbringer', 'rapier')
roughirons <- c('roughcutter', 'junglist', 'machete', 'offroader', 'razor', 'amazon', 'nirvana')
sandwedges <- c('castaway', 'desertstorm', 'malibu', 'sahara', 'sandlizard', 'houdini', 'spitfire')

CLUBNAMES <- list(drivers=drivers,
                  woods=woods,
                  longirons=longirons,
                  shortirons=shortirons,
                  wedges=wedges,
                  roughirons=roughirons,
                  sandwedges=sandwedges)

drawRings <- function() {
  plot(c(0,0), c(0,0), xlim = c(-7,7), ylim = c(-7,7), xlab = "", ylab = "")
  draw.ellipse(0,0, 5, 5, col = "gray95")
  draw.ellipse(0,0, 4, 4, col = "black")
  draw.ellipse(0,0, 3, 3, col = "blue")
  draw.ellipse(0,0, 2, 2, col = "orangered")
  draw.ellipse(0,0, 1, 1, col = "yellow") 
}

# Wind per ring = ( 1 + (( 100 - Accuracy) * 0.02 )) * TrajectoryCorr / (CurrYardage/Maxforclubtype) * RuleCorr
# TC = 1.45 for rough, 1.15 for sand
# RC = .9 for b52 & grizzly lvl 5+

windPerRing <- function(clubname, dist) {
  club_data <- clubs %>% filter(club == clubname)
  maxClub <- clubs %>% filter(club == paste(club_data$type, "max", sep = ""))
  TC <- ifelse(club_data$type == "roughiron", 1.45, ifelse(club_data$type == "sandwedge", 1.15, 1))
  wpr <- ( 1 + ( ( 100 - club_data$accuracy) * 0.02)) *
    TC / (dist / maxClub$power) * 1
  return(wpr)
}

clubMaxDist <- function(clubname) {
  output <- clubs %>% filter(club == clubname) %>% select(power)
  return(output[[1]])
}

clubMinDist <- function(clubname) {
  club_data <- clubs %>% filter(club == clubname)
  if(club_data$type == "wedge" |
     club_data$type == "roughiron" |
     club_data$type == "sandwedge") {
    return(0)
  }
  else {
    index <- which(clubs$club == paste(club_data$type, "max", sep = "")) + 1
   output <- clubs[index,]$power
    return(output)
  }
}

# rtype - changes the return type of the function t - returns club, l - returns level
# ctype - character vector of length 1
# cdefaults - integer vector of length 7 (coerced to integer if not already)
# returns a character vector of length 1 equivalent to the default club
club_default <- function(rtype ,ctype, cdefaults) {
  cdefaults <- as.integer(cdefaults)
  defaultindex <- 0
  if(ctype == "drivers") {
    defaultindex <- cdefaults[[1]]
  }
  else if(ctype == "woods") {
    defaultindex <- cdefaults[[2]]
  }
  else if(ctype == "longirons") {
    defaultindex <- cdefaults[[3]]
  }
  else if(ctype == "shortirons") {
    defaultindex <- cdefaults[[4]]
  }
  else if(ctype == "wedges") {
    defaultindex <- cdefaults[[5]]
  }
  else if(ctype == "roughirons") {
    defaultindex <- cdefaults[[6]]
  }
  else{
    defaultindex <- cdefaults[[7]]
  }
  
  if(rtype == "t") {
    return(CLUBNAMES[[ctype]][defaultindex])
  }
  else {
    return(defaultindex)
  }
  
  
}



