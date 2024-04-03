library(here)
source(here('R', '01_load-data.R'))
source(here('R', '02_wrangle-data.R'))
source(here('R', '00_vis_custom.R'))


# geometric means over time -----------------------------------------------

Annual_plot <- function(param, ylab) {
  
  gmean <- function(x) exp(mean(log(x), na.rm = TRUE))
  gmeansd <- function(x) exp(sd(log(x), na.rm = TRUE))
  se <- function(x) (sd(x, na.rm = T)/sqrt(length(x)))
  
  df <- 
    dat_c %>% 
    mutate(year = lubridate::year(sample_date)) %>%
    select(year, wbid, {{param}}) %>% 
    group_by(year, wbid) %>% 
    summarise_all(list(~ gmean(.),
                       ~ se(.)))
  
  ylab <- ylab
  
  p <- df %>% 
    ggplot(aes(x = year, y = gmean, color = wbid)) +
    geom_linerange(aes(ymax = gmean + se, ymin = gmean - se), color = "gray60") +
    geom_point() +
    geom_line() +
    scale_x_continuous(breaks = c(2017, 2018, 2019, 2020, 2021, 2022, 2023)) +
    theme_bw() +
    scale_color_manual(values = c("blue", "red"))+
    theme(legend.position = "bottom",
          legend.title = element_blank(),
          axis.text = element_text(color = "black")) +
    labs(x = "",
         y = ylab)
  
  print(p)
}

Annual_plot(param = "CHLa_C",  ylab = chla_y_title) + geom_hline(yintercept = 11, color = "blue", linetype = "dashed")+geom_hline(yintercept = 6.6, color = "red", linetype = "dashed")




### CURRENT VERSION WITH SEASON
season_plot <- function(param, ylab) {
  
  gmean <- function(x) exp(mean(log(x), na.rm = TRUE))
  gmeansd <- function(x) exp(sd(log(x), na.rm = TRUE))
  se <- function(x) (sd(x, na.rm = T)/sqrt(length(x)))
  
  df <- dat_c %>%
    mutate(year = lubridate::year(sample_date), month=lubridate::month(sample_date)) %>%
    arrange(year, month)%>%
    select(year, month, wbid, {{param}}) %>% 
    mutate(season=if_else(month %in% c(1, 2, 12), "winter", if_else(month %in% c(3, 4, 5), "spring", if_else(month %in% c(6, 7, 8), "summer", "fall"))))%>%
    mutate(year_season = paste(year, season, sep = "_"))%>%
    group_by(year_season, wbid)%>%
    summarise(gmean=gmean({{param}}), se=se({{param}}))%>%
    mutate(year_season=factor(year_season, levels=c("2017_summer", "2017_fall", "2018_winter",  "2018_spring", "2018_summer", "2018_fall", "2019_winter",  "2019_spring", "2019_summer", "2019_fall","2020_winter",   "2020_spring", "2020_summer", "2020_fall", "2021_winter",  "2021_spring", "2021_summer", "2021_fall", "2022_winter",  "2022_spring", "2022_summer", "2022_fall",   "2023_winter",  "2023_spring", "2023_summer",  "2023_fall","2024_winter")))
  
  ylab <- ylab
  
  p <- df %>% 
    ggplot(aes(x = year_season, y = gmean, color = wbid)) +
    geom_linerange(aes(ymax = gmean + se, ymin = gmean - se), color = "gray60") +
    geom_point() +
    geom_line() +
    scale_x_discrete(breaks = c( "2017_summer", "2018_summer",  "2019_summer", "2020_summer",  "2021_summer", "2022_summer","2023_summer")) +
    theme_bw() +
    scale_color_manual(values = c("blue", "red"))+
    theme(legend.position = "bottom",
          legend.title = element_blank(),
          axis.text = element_text(color = "black")) +
    labs(x = "",
         y = ylab)
  
  print(p)
}

season_plot(param = CHLa_C,  ylab =chla_y_title ) + geom_hline(yintercept = 11, color = "blue", linetype = "dashed")+geom_hline(yintercept = 6.6, color = "red", linetype = "dashed")


##color coded by season
season_plot2 <- function(param, ylab) {
  
  gmean <- function(x) exp(mean(log(x), na.rm = TRUE))
  gmeansd <- function(x) exp(sd(log(x), na.rm = TRUE))
  se <- function(x) (sd(x, na.rm = T)/sqrt(length(x)))
  
  df <- dat_c %>%
    mutate(year = lubridate::year(sample_date), month=lubridate::month(sample_date)) %>%
    mutate(year2=if_else(month==12, year+1, year))%>%
    select(year2, month, wbid, {{param}}) %>% 
    mutate(season=if_else(month %in% c(1, 2, 12), "winter", if_else(month %in% c(3, 4, 5), "spring", if_else(month %in% c(6, 7, 8), "summer", "fall"))))%>%
    mutate(year_season = paste(year2, season, sep = "_"))%>%
    group_by(year_season, wbid, season, year2)%>%
    summarise(gmean=gmean({{param}}), se=se({{param}}))%>%
    mutate(season=factor(season, levels=c("winter", "spring", "summer", "fall")))%>%
    arrange(year2, season)%>%
    mutate(year_season=factor(year_season, levels=c("2017_summer", "2017_fall", "2018_winter",  "2018_spring", "2018_summer", "2018_fall", "2019_winter",  "2019_spring", "2019_summer", "2019_fall","2020_winter",   "2020_spring", "2020_summer", "2020_fall", "2021_winter",  "2021_spring", "2021_summer", "2021_fall", "2022_winter",  "2022_spring", "2022_summer", "2022_fall",   "2023_winter",  "2023_spring", "2023_summer",  "2023_fall","2024_winter")))
  
  ylab <- ylab
  
  p <- df %>% 
    ggplot(aes(x = year_season, y = gmean, color = season)) +
    geom_linerange(aes(ymax = gmean + se, ymin = gmean - se), color = "gray60") +
    geom_point() +
    scale_x_discrete(breaks = c( "2017_summer", "2018_summer",  "2019_summer", "2020_summer",  "2021_summer", "2022_summer","2023_summer")) +
    theme_bw() +
    scale_color_manual(values = c("lightskyblue1", "steelblue3", "royalblue2", "navy"))+
    theme(legend.position = "bottom",
          legend.title = element_blank(),
          axis.text = element_text(color = "black")) +
    labs(x = "",
         y = ylab)+
    facet_grid(wbid~., scales = "free_y")
  
  print(p)
}


season_plot2(param = CHLa_C,  ylab =chla_y_title ) + geom_hline(data=dat_c%>%filter(wbid=="Lake"), aes(yintercept = 11), color = "blue", linetype = "dashed")+geom_hline(data=dat_c%>%filter(wbid=="River"), aes(yintercept = 6.6), color = "red", linetype = "dashed")




