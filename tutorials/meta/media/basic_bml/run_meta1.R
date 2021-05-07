# Read input and load libraries                  
dat <- read.table('data_meta1.txt', header=T)  
library(brms,BH)                                 
                                                 
# Set and run 4 chains                           
options(mc.cores = parallel::detectCores())      
fm <- brm(ef | se(se, sigma=FALSE) ~ 1+(1|Study),
          data=dat, chains = 4, iter=1000)       
                                                 
# Simple output display                          
plot(density(fixef(fm, summary = FALSE)),        
     xlim=c(-0.2,1.2))                           
abline(v=0, col="green3")                        
