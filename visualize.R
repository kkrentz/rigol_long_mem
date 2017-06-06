require(Bolstad2)

data_file <- paste(getwd(), "/some.csv", sep="")
data <- read.table(data_file, header=T, sep=",", skip = 0)

data$Second <- data$Second - min(data$Second)
print(sintegral(data$Second, data$Volt)$int * 1000)
data$Second <- data$Second * 1000
data$Volt <- data$Volt * 1000
x <- c()
y <- c()
n <- 500
for(i in seq(1, length(data$Second) - n, n + 1)) {
  x <- c(x, mean(data$Second[seq(i,i+n)]))
  y <- c(y, mean(data$Volt[seq(i,i+n)]))
}

par(mar=c(5.1, 4.1, 4.1, 2.1 - 2))
plot(range(x),
     c(0,50),
     type="n",
     xlab= expression(paste("time (in ms)")),
     ylab="current draw (in mA)",
     xaxt="n",
     cex.lab=1.2,
     cex.axis=1.2)
axis(1, cex.axis=1.2, at=seq(0,10,1))
lines(x, y)
