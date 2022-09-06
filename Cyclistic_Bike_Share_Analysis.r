
Google Data Analytics Capstone Project
About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members. Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs. Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

For the analysis I will follow 6 steps of Data Analysis which are Ask,Prepare,Process,Analyze,Share and Act.

Phase1: Ask
Business Task
Cyclistic, a bike share company wants to understand how their annual members(who purchase annual memberships) and casual riders(who purchase single-ride or full-day passes) use bike-share offering differently.Based on the insights of the analysis company may launch some marketing strategies aimed at converting casual riders into annual members.

Key Stakeholders
Lily Moreno,The director of marketing and my manager
Other members of Cyclistic marketing analytics team
Cyclistic executive team
Phase2: Prepare
Data is good first party public data and is located at https://divvy-tripdata.s3.amazonaws.com/index.html.The data has been made available by Motivate International Inc. under this https://ride.divvybikes.com/data-license-agreement. Data is reliable,original,comprehensive,current and cited. Data is organized by months,some are by quarters,some are by years.

for the analysis I will take consideration of data of June2021-July2022 period.I will download the data and store it appropriately.

add Codeadd Markdown
# load all the relevant libraries for my analysis
​
library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)  #helps visualize data
library(janitor) #helps cleaning dirty data
library(dplyr)
​
── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

✔ ggplot2 3.3.6     ✔ purrr   0.3.4
✔ tibble  3.1.7     ✔ dplyr   1.0.9
✔ tidyr   1.2.0     ✔ stringr 1.4.0
✔ readr   2.1.2     ✔ forcats 0.5.1

── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()


Attaching package: ‘lubridate’


The following objects are masked from ‘package:base’:

    date, intersect, setdiff, union



Attaching package: ‘janitor’


The following objects are masked from ‘package:stats’:

    chisq.test, fisher.test


add Codeadd Markdown
# Assign all the source files which are stored monthly to their respective variables
​
jun_2021 <- read.csv("../input/cyclistic-bike-share/202106-divvy-tripdata.csv")
jul_2021 <- read.csv("../input/cyclistic-bike-share/202107-divvy-tripdata.csv")
aug_2021 <- read.csv("../input/cyclistic-bike-share/202108-divvy-tripdata.csv")
sep_2021 <- read.csv("../input/cyclistic-bike-share/202109-divvy-tripdata.csv")
oct_2021 <- read.csv("../input/cyclistic-bike-share/202110-divvy-tripdata.csv")
nov_2021 <- read.csv("../input/cyclistic-bike-share/202111-divvy-tripdata.csv")
dec_2021 <- read.csv("../input/cyclistic-bike-share/202112-divvy-tripdata.csv")
jan_2022 <- read.csv("../input/cyclistic-bike-share/202201-divvy-tripdata.csv")
feb_2022 <- read.csv("../input/cyclistic-bike-share/202202-divvy-tripdata.csv")
mar_2022 <- read.csv("../input/cyclistic-bike-share/202203-divvy-tripdata.csv")
apr_2022 <- read.csv("../input/cyclistic-bike-share/202204-divvy-tripdata.csv")
may_2022 <- read.csv("../input/cyclistic-bike-share/202205-divvy-tripdata.csv")
​
add Codeadd Markdown
# Combine all the source files and assign them to one variable
​
bike_rides <- rbind(jun_2021,jul_2021,aug_2021,sep_2021,oct_2021,nov_2021,dec_2021,jan_2022,feb_2022,mar_2022,apr_2022,may_2022)
​
add Codeadd Markdown
Phase3: Process
I am using R for the analysis.In this phase I will check possible errors like NA in the dataset,remove any empty row or colums,do the necessary manipulation and transform the data so that I can work with it effectively and draw meaningful insights.

add Codeadd Markdown
# lets see the data
str(bike_rides)
summary(bike_rides)
head(bike_rides)
# remove empty rows and empty columns
​
bike_rides <- janitor::remove_empty(bike_rides,which = c("cols"))
bike_rides <- janitor::remove_empty(bike_rides,which = c("rows"))
'data.frame':	5860776 obs. of  13 variables:
 $ ride_id           : chr  "99FEC93BA843FB20" "06048DCFC8520CAF" "9598066F68045DF2" "B03C0FE48C412214" ...
 $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
 $ started_at        : chr  "6/13/2021 14:31" "6/4/2021 11:18" "6/4/2021 9:49" "6/3/2021 19:56" ...
 $ ended_at          : chr  "6/13/2021 14:34" "6/4/2021 11:24" "6/4/2021 9:55" "6/3/2021 20:21" ...
 $ start_station_name: chr  "" "" "" "" ...
 $ start_station_id  : chr  "" "" "" "" ...
 $ end_station_name  : chr  "" "" "" "" ...
 $ end_station_id    : chr  "" "" "" "" ...
 $ start_lat         : num  41.8 41.8 41.8 41.8 41.8 ...
 $ start_lng         : num  -87.6 -87.6 -87.6 -87.6 -87.6 ...
 $ end_lat           : num  41.8 41.8 41.8 41.8 41.8 ...
 $ end_lng           : num  -87.6 -87.6 -87.6 -87.6 -87.6 ...
 $ member_casual     : chr  "member" "member" "member" "member" ...
   ride_id          rideable_type       started_at          ended_at        
 Length:5860776     Length:5860776     Length:5860776     Length:5860776    
 Class :character   Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character   Mode  :character  
                                                                            
                                                                            
                                                                            
                                                                            
 start_station_name start_station_id   end_station_name   end_station_id    
 Length:5860776     Length:5860776     Length:5860776     Length:5860776    
 Class :character   Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character   Mode  :character  
                                                                            
                                                                            
                                                                            
                                                                            
   start_lat       start_lng         end_lat         end_lng      
 Min.   :41.64   Min.   :-87.84   Min.   :41.39   Min.   :-88.97  
 1st Qu.:41.88   1st Qu.:-87.66   1st Qu.:41.88   1st Qu.:-87.66  
 Median :41.90   Median :-87.64   Median :41.90   Median :-87.64  
 Mean   :41.90   Mean   :-87.65   Mean   :41.90   Mean   :-87.65  
 3rd Qu.:41.93   3rd Qu.:-87.63   3rd Qu.:41.93   3rd Qu.:-87.63  
 Max.   :45.64   Max.   :-73.80   Max.   :42.17   Max.   :-87.49  
                                  NA's   :5036    NA's   :5036    
 member_casual     
 Length:5860776    
 Class :character  
 Mode  :character  
                   
                   
                   
                   
A data.frame: 6 × 13
ride_id	rideable_type	started_at	ended_at	start_station_name	start_station_id	end_station_name	end_station_id	start_lat	start_lng	end_lat	end_lng	member_casual
<chr>	<chr>	<chr>	<chr>	<chr>	<chr>	<chr>	<chr>	<dbl>	<dbl>	<dbl>	<dbl>	<chr>
1	99FEC93BA843FB20	electric_bike	6/13/2021 14:31	6/13/2021 14:34					41.80	-87.59	41.80	-87.60	member
2	06048DCFC8520CAF	electric_bike	6/4/2021 11:18	6/4/2021 11:24					41.79	-87.59	41.80	-87.60	member
3	9598066F68045DF2	electric_bike	6/4/2021 9:49	6/4/2021 9:55					41.80	-87.60	41.79	-87.59	member
4	B03C0FE48C412214	electric_bike	6/3/2021 19:56	6/3/2021 20:21					41.78	-87.58	41.80	-87.60	member
5	B9EEA89F8FEE73B7	electric_bike	6/4/2021 14:05	6/4/2021 14:09					41.80	-87.59	41.79	-87.59	member
6	62B943CEAAA420BA	electric_bike	6/3/2021 19:32	6/3/2021 19:38					41.78	-87.58	41.78	-87.58	member
add Codeadd Markdown
#lets convert started_date and ended_date to ymd_hms format and separate the dates into month, day, year and day of the week and make new columns
​
bike_rides$started_at <- lubridate::ymd_hms(bike_rides$started_at)
bike_rides$ended_at <- lubridate::ymd_hms(bike_rides$ended_at)
bike_rides$month <- format(as.Date(bike_rides$started_at), "%m")
bike_rides$day <- format(as.Date(bike_rides$started_at), "%d")
bike_rides$year <- format(as.Date(bike_rides$started_at), "%Y")
bike_rides$day_of_week <- format(as.Date(bike_rides$started_at), "%A")
Warning message:
“ 729595 failed to parse.”
Warning message:
“ 729595 failed to parse.”
add Codeadd Markdown
#getting the ride length in seconds:
​
bike_rides$ride_length <- difftime(bike_rides$ended_at,bike_rides$started_at)
​
# Inspect the structure of the columns
​
str(bike_rides)
'data.frame':	5860776 obs. of  18 variables:
 $ ride_id           : chr  "99FEC93BA843FB20" "06048DCFC8520CAF" "9598066F68045DF2" "B03C0FE48C412214" ...
 $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
 $ started_at        : POSIXct, format: NA NA ...
 $ ended_at          : POSIXct, format: NA NA ...
 $ start_station_name: chr  "" "" "" "" ...
 $ start_station_id  : chr  "" "" "" "" ...
 $ end_station_name  : chr  "" "" "" "" ...
 $ end_station_id    : chr  "" "" "" "" ...
 $ start_lat         : num  41.8 41.8 41.8 41.8 41.8 ...
 $ start_lng         : num  -87.6 -87.6 -87.6 -87.6 -87.6 ...
 $ end_lat           : num  41.8 41.8 41.8 41.8 41.8 ...
 $ end_lng           : num  -87.6 -87.6 -87.6 -87.6 -87.6 ...
 $ member_casual     : chr  "member" "member" "member" "member" ...
 $ month             : chr  NA NA NA NA ...
 $ day               : chr  NA NA NA NA ...
 $ year              : chr  NA NA NA NA ...
 $ day_of_week       : chr  NA NA NA NA ...
 $ ride_length       : 'difftime' num  NA NA NA NA ...
  ..- attr(*, "units")= chr "secs"
add Codeadd Markdown
# Remove "bad" data
# The dataframe includes a few hundred entries when bikes were taken out of docks and checked for quality by Divvy or ride_length was negative
# We will create a new version of the dataframe since data is being removed
​
bike_rides_v2 <- bike_rides[!(bike_rides$start_station_name == "HQ QR" | bike_rides$ride_length<0),]
​
str(bike_rides_v2)
'data.frame':	5860642 obs. of  18 variables:
 $ ride_id           : chr  NA NA NA NA ...
 $ rideable_type     : chr  NA NA NA NA ...
 $ started_at        : POSIXct, format: NA NA ...
 $ ended_at          : POSIXct, format: NA NA ...
 $ start_station_name: chr  NA NA NA NA ...
 $ start_station_id  : chr  NA NA NA NA ...
 $ end_station_name  : chr  NA NA NA NA ...
 $ end_station_id    : chr  NA NA NA NA ...
 $ start_lat         : num  NA NA NA NA NA NA NA NA NA NA ...
 $ start_lng         : num  NA NA NA NA NA NA NA NA NA NA ...
 $ end_lat           : num  NA NA NA NA NA NA NA NA NA NA ...
 $ end_lng           : num  NA NA NA NA NA NA NA NA NA NA ...
 $ member_casual     : chr  NA NA NA NA ...
 $ month             : chr  NA NA NA NA ...
 $ day               : chr  NA NA NA NA ...
 $ year              : chr  NA NA NA NA ...
 $ day_of_week       : chr  NA NA NA NA ...
 $ ride_length       : 'difftime' num  NA NA NA NA ...
  ..- attr(*, "units")= chr "secs"
add Codeadd Markdown
Type Markdown and LaTeX:  α2 
add Codeadd Markdown
# creating a new dataframe excluding all NA and ride_length greater than 0
​
bike_rides_new <- bike_rides_v2 %>% filter(ride_length > 0) %>% drop_na()
add Codeadd Markdown
Now the dataset is clean, so we will move to the next phase.

add Codeadd Markdown
Phase4: Analyze
Now lets analyze the cleaned dataset to get meaningful insights.

add Codeadd Markdown
# Descriptive analysis on ride_length (all figures in seconds) 
# calculate mean,median,max and min of ride_length
​
mean(bike_rides_new$ride_length) #straight average (total ride length / rides)
median(bike_rides_new$ride_length) #midpoint number in the ascending array of ride lengths
max(bike_rides_new$ride_length) #longest ride
min(bike_rides_new$ride_length) #shortest ride
Time difference of 1112.815 secs
Time difference of 663 secs
Time difference of 2946429 secs
Time difference of 1 secs
add Codeadd Markdown
# Compare members and casual users
​
aggregate(bike_rides_new$ride_length ~ bike_rides_new$member_casual, FUN = mean)
aggregate(bike_rides_new$ride_length ~ bike_rides_new$member_casual, FUN = median)
aggregate(bike_rides_new$ride_length ~ bike_rides_new$member_casual, FUN = max)
aggregate(bike_rides_new$ride_length ~ bike_rides_new$member_casual, FUN = min)
A data.frame: 2 × 2
bike_rides_new$member_casual	bike_rides_new$ride_length
<chr>	<drtn>
casual	1592.7811 secs
member	756.1706 secs
A data.frame: 2 × 2
bike_rides_new$member_casual	bike_rides_new$ride_length
<chr>	<drtn>
casual	894 secs
member	536 secs
A data.frame: 2 × 2
bike_rides_new$member_casual	bike_rides_new$ride_length
<chr>	<drtn>
casual	2946429 secs
member	89996 secs
A data.frame: 2 × 2
bike_rides_new$member_casual	bike_rides_new$ride_length
<chr>	<drtn>
casual	1 secs
member	1 secs
add Codeadd Markdown
Analysis: Mean,Median and Max value of ride_length for casual_members are more than annual members.

add Codeadd Markdown
# See the average ride time by each day for members vs casual users
aggregate(bike_rides_new$ride_length ~ bike_rides_new$member_casual + bike_rides_new$day_of_week, FUN = mean)
​
# Notice that the days of the week are out of order. Let's fix that.
bike_rides_new$day_of_week <- ordered(bike_rides_new$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
​
A data.frame: 14 × 3
bike_rides_new$member_casual	bike_rides_new$day_of_week	bike_rides_new$ride_length
<chr>	<chr>	<drtn>
casual	Friday	1482.6374 secs
member	Friday	740.1896 secs
casual	Monday	1654.0191 secs
member	Monday	737.9171 secs
casual	Saturday	1749.9880 secs
member	Saturday	848.8262 secs
casual	Sunday	1836.3367 secs
member	Sunday	852.0340 secs
casual	Thursday	1426.7485 secs
member	Thursday	721.4847 secs
casual	Tuesday	1358.8280 secs
member	Tuesday	708.3965 secs
casual	Wednesday	1365.6010 secs
member	Wednesday	716.0490 secs
add Codeadd Markdown
Analysis: In all days of the week casual members have more mean ride_length than annual members.

add Codeadd Markdown
Type Markdown and LaTeX:  α2 
add Codeadd Markdown
# Now, let's run the average ride time by each day for members vs casual users
​
aggregate(bike_rides_new$ride_length ~ bike_rides_new$member_casual + bike_rides_new$day_of_week, FUN = mean)
​
A data.frame: 14 × 3
bike_rides_new$member_casual	bike_rides_new$day_of_week	bike_rides_new$ride_length
<chr>	<ord>	<drtn>
casual	Sunday	1836.3367 secs
member	Sunday	852.0340 secs
casual	Monday	1654.0191 secs
member	Monday	737.9171 secs
casual	Tuesday	1358.8280 secs
member	Tuesday	708.3965 secs
casual	Wednesday	1365.6010 secs
member	Wednesday	716.0490 secs
casual	Thursday	1426.7485 secs
member	Thursday	721.4847 secs
casual	Friday	1482.6374 secs
member	Friday	740.1896 secs
casual	Saturday	1749.9880 secs
member	Saturday	848.8262 secs
add Codeadd Markdown
add Codeadd Markdown
# analyze ridership data by type and weekday
​
bike_rides_new %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%      # creates weekday field using wday()
  group_by(member_casual, weekday) %>%                      # groups by usertype and weekday
  summarize(number_of_rides = n()                           # calculates the number of rides and average duration 
            ,average_duration = mean(ride_length)) %>%      # calculates the average duration
  arrange(member_casual, weekday)                           # sorts
`summarise()` has grouped output by 'member_casual'. You can override using the
`.groups` argument.
A grouped_df: 14 × 4
member_casual	weekday	number_of_rides	average_duration
<chr>	<ord>	<int>	<drtn>
casual	Sun	400455	1836.3367 secs
casual	Mon	266525	1654.0191 secs
casual	Tue	238581	1358.8280 secs
casual	Wed	236745	1365.6010 secs
casual	Thu	266746	1426.7485 secs
casual	Fri	306714	1482.6374 secs
casual	Sat	469554	1749.9880 secs
member	Sun	349702	852.0340 secs
member	Mon	422120	737.9171 secs
member	Tue	463122	708.3965 secs
member	Wed	447635	716.0490 secs
member	Thu	452289	721.4847 secs
member	Fri	411782	740.1896 secs
member	Sat	394312	848.8262 secs
add Codeadd Markdown
# Let's visualize the number of rides by rider type
bike_rides_new %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")+
  labs(title = "Number of Rides Vs Weekday by user type")
`summarise()` has grouped output by 'member_casual'. You can override using the
`.groups` argument.

add Codeadd Markdown
Analysis: On weekends(Saturday and Sunday) casual members have more number of rides. On the other hand on weekdays(Monday-Friday) annual members have more number of rides.

add Codeadd Markdown
# Let's create a visualization for average duration
bike_rides_new %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")+
  labs(title = "Average Duration Vs Weekday by user type")
​
`summarise()` has grouped output by 'member_casual'. You can override using the
`.groups` argument.
Don't know how to automatically pick scale for object of type difftime. Defaulting to continuous.


add Codeadd Markdown
Analysis: Casual members have more average duration of rides than annual members in all days of the week.

add Codeadd Markdown
​
#lets check the bike type usage by user type:
​
bike_rides_new %>%
    filter(rideable_type=="classic_bike" | rideable_type=="electric_bike") %>%
    group_by(member_casual,rideable_type) %>%
    summarise(totals=n(), .groups="drop")  %>%
​
ggplot()+
    geom_col(aes(x=member_casual,y=totals,fill=rideable_type), position = "dodge") + 
    labs(title = "Bike type usage by both users",x="User type",y=NULL, fill="Bike type")

add Codeadd Markdown
Analysis: Classics bike used more than electric bikes by both the members.

add Codeadd Markdown
#And their usage by both users on each day of the week:
​
bike_rides_new %>%
    filter(rideable_type=="classic_bike" | rideable_type=="electric_bike") %>%
    mutate(weekday = wday(started_at, label = TRUE)) %>% 
    group_by(member_casual,rideable_type,weekday) %>%
    summarise(totals=n(), .groups="drop") %>%
​
ggplot(aes(x=weekday,y=totals, fill=rideable_type)) +
  geom_col(, position = "dodge") + 
  facet_wrap(~member_casual) +
  labs(title = "Bike type usage by both users on different days of the week",x="User type",y=NULL)
 

add Codeadd Markdown
Analysis: Classic bikes widely used by annual members.

add Codeadd Markdown
Phase5 : Share
Sharing my analysis:

The casual members have more average duration of rides in all days of the week and have more number of rides on weekends which implies casual members use bike sharing as leisure activity or they use it for tourism purpose.

The Annual members use bike-share more on weekdays widely using classic bikes which implies they use bike sharing as commute or pragmatic use.

I would share my analysis with the stakeholders. I would suggest that in order to convert the casual to the annual users it would be interesting to focus on some promotional offers on weekends for annual members.

add Codeadd Markdown
Thanks for reading and I hope you liked it!!!

