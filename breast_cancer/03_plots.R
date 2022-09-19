#install.packages("stringr")

set.seed(1234)
load("./breast_cancer/data/data2.rda")
S <- cov(data2)

library(gips)

load("./breast_cancer/data/my_sum.rda")
load("./breast_cancer/data/g_MAP.rda")

plot(g_MAP, type = 'both', logarithmic_x = TRUE)

# perm found by Kolodziejek:
string_python <- "(0, 1, 138, 148, 60, 51, 7, 144)(2, 10, 8, 88, 5, 101, 119, 3)(4, 46, 89)(6, 12, 137, 90, 116, 141, 142, 71, 145, 49, 135, 21, 56, 86, 123, 113, 83, 29)(9, 98, 38, 20, 100, 25, 36, 72)(11, 76, 99, 132, 121)(13, 18, 75, 146)(14, 70, 126, 109)(15, 91, 82, 33, 139, 26, 48, 136)(16, 97, 68)(17, 64, 133, 87, 106, 74, 107, 105, 81, 108, 122, 67)(19, 50, 134, 104, 37, 95, 24, 44)(22, 110, 23, 41, 66, 42, 130, 111)(30, 57, 65, 93, 80)(31, 32)(34, 92, 63, 85, 127, 147, 131, 102, 59, 149, 143, 128, 117, 69, 96, 120)(35, 84, 140)(43, 55, 118, 125, 103, 77, 78, 47)(45, 129, 114, 73, 115, 58, 112, 124, 94)"
string_new <- stringr::str_replace_all(string_python, pattern = "\\d+", function(number_str){return(as.character(1+as.numeric(number_str)))})
pem_kolodziejek <- gips_perm(string_new, 150)
g_kolodziejek <- gips(S, 58, was_mean_estimated = TRUE, perm = pem_kolodziejek)
abline(log_posteriori_of_gips(g_kolodziejek), 0, col = "green")

kolodziejek_sum <- summary(g_kolodziejek)
kolodziejek_sum$n0 # 30

compare_posteriories_of_perms(g_MAP, g_kolodziejek, print_output = FALSE)
# TODO(How many times more likely)


