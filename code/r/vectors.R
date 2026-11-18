# Vectors, vectorisation and missing values
x <- c(276.4, 281.9, 268.7, 273.5, 279.2)   # c() combines values into a vector
x[1]                     # first element (index 1)
x[2:4]                   # elements 2 to 4
x[-1]                    # all except the first!
x[x > 275]               # logical indexing
mean(x); sd(x); range(x)
x - mean(x)              # recycling: the scalar is used for every element

y <- c(1.2, NA, 3.4)     # NA = "not available" (a missing measurement)
mean(y)                  # NA: the result is unknown
mean(y, na.rm = TRUE)    # 2.3: ignore missing values

materials <- factor(c("steel", "Al", "steel", "Ti", "Al"))
table(materials)         # counts per category
