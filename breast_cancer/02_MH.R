set.seed(1234)
load("./breast_cancer/data/data2.rda")
S <- cov(data2)

#install.packages("gips")
#devtools::install_github("PrzeChoj/gips") # 1.0.0
library(gips)
set.seed(1234)

g <- gips(S, 58, was_mean_estimated = TRUE)

set.seed(1234)
g_MAP <- find_MAP(g, max_iter = 150000, optimizer = "MH")
my_sum <- summary(g_MAP)

my_sum$n0 # TODO()
my_sum$acceptance_rate # TODO()
my_sum$whole_optimization_time # TODO()

save(my_sum, file="./breast_cancer/data/my_sum.rda")
save(g_MAP, file="./breast_cancer/data/g_MAP.rda")


