# Data frames, grouping, a linear model and a plot
df <- read.csv("../data/tensile.csv")
str(df)                                         # structure of the data frame

df$area_mm2 <- pi * df$diameter_mm^2 / 4        # new column
agg <- aggregate(yield_MPa ~ material, data = df,
                 FUN = function(y) c(n = length(y), mean = mean(y), sd = sd(y)))
print(agg)

# Is the difference between the two materials statistically significant?
tt <- t.test(yield_MPa ~ material, data = df)
cat(sprintf("Welch t-test: t = %.2f, p = %.4f\n", tt$statistic, tt$p.value))

# Linear regression: does yield strength depend on diameter?
fit <- lm(yield_MPa ~ diameter_mm, data = df[df$material == "Al6061", ])
cat(sprintf("slope = %.1f MPa/mm, R^2 = %.3f\n",
            coef(fit)[2], summary(fit)$r.squared))

pdf("yield_boxplot.pdf", width = 5, height = 4)
boxplot(yield_MPa ~ material, data = df, ylab = "Yield strength (MPa)")
invisible(dev.off())
