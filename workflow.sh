# get raw data from amazon
curl https://d2xn1uj035lhvj.cloudfront.net/pricing/1.0/ec2/region/eu-west-2/ondemand/linux/index.json?timestamp=1542899708728 > amazon-prices.json

# extract instance type attributes and prices as csv
# probably would have been easier to do this in python, importing the json 
# manual: run extract-instance-info.xquery on raw data > instance-info.csv

# manual: run instance-types.R script to visualize
