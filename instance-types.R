library(readr)
library(ggplot2)
library(ggrepel)

setwd("/Users/macbookdata/Desktop")

# combine from different partitions (forgot to write the skip at level to the experiment output, was just in the stdout)
data <- read.delim("instance-info.csv",sep = ",",header = FALSE,col.names = c("instancegroup","instancetype","vcpu","mem_gb","price_usd_hour"))

#data$vcpu_cat = cut(data$vcpu, seq(min(data$vcpu), max(data$vcpu), (max(data$vcpu)-min(data$vcpu))/6), include.lowest = TRUE)
data$vcpu_cat = cut(data$vcpu, c(1,4,8,16,64, 128), include.lowest = TRUE)

#lm(data=data, formula=price_usd_hour~mem_gb))
scatter.smooth(x=log(data$mem_gb), y=log(data$price_usd_hour), main="Dist ~ Speed")  # scatterplot
linearMod <- lm(log(price_usd_hour,base=10) ~ log(mem_gb,base=10), data=data)  # build linear regression model on full data
print(linearMod)
summary(linearMod)
nrow(data)
summary(data)

# cpu breaks = c(0.5,1,2,4,8,15.25,32,64,144,256,512,1024,1952)
ggplot(data, aes(mem_gb, price_usd_hour)) + 
  geom_point(aes(size=vcpu, color=vcpu_cat)) + 
  geom_label_repel(aes(label = instancegroup), box.padding   = 0.0035, point.padding = 0.005, label.size = 0.035, segment.color = 'grey50', alpha=.4) +
  scale_x_log10(breaks=fivenum(data$mem_gb)) + scale_y_log10(breaks=fivenum(data$price_usd_hour)) +
  ylab("Price US$/Hour") + xlab("Memory GB") +
  scale_colour_discrete(name="vCPU") + 
  scale_size(name="vCPU") + 
  #scale_size_discrete(name="vCPU") +
  #ggtitle("What's the cost of memory in Amazon EC2?")+
  theme_minimal()
  #scale_color_brewer(type="seq", palette = 4) + theme_minimal()
