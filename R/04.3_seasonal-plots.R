library(here)
source(here('R', '01_load-data.R'))
source(here('R', '02_wrangle-data.R'))
source(here('R', '00_vis_custom.R'))


dat_c<-dat_c%>%
  mutate(TNTP=TN/TP)

# geometric means by year -----------------------------------------------

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
    geom_linerange(aes(ymax = gmean + se, ymin = ifelse(gmean - se < 0, 0, gmean - se)), color = "gray60", position = position_dodge2(width = 0.2)) + #keeps error bar from going below 0 and messing up scale  
    geom_point(position=position_dodge2(width = 0.2)) +
    geom_line(position=position_dodge2(width = 0.2)) +
    scale_x_continuous(breaks = c(2017, 2018, 2019, 2020, 2021, 2022, 2023)) +
    theme_classic() +
    scale_color_manual(values = c("blue", "red"))+
    theme(legend.position = "right", legend.title = element_blank(), axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) +
    labs(x = "",
         y = ylab)
  
  print(p)
}


##geom_hline represent state maximum criteria for each metric for the lake (blue) and river (red) or both (black)

Annual_plot(param = "CHLa_C",  ylab = chla_y_title) + geom_hline(yintercept = 11, color = "blue", linetype = "dashed")+geom_hline(yintercept = 6.6, color = "red", linetype = "dashed")

Annual_plot(param = "TKN",  ylab = TKN_y_title) + geom_hline(yintercept = 0.65, color = "red", linetype = "dashed")

Annual_plot(param = "TP",  ylab = phos_y_title) + geom_hline(yintercept = 0.105, color = "red", linetype = "dashed")

Annual_plot(param = "TNTP",  ylab = "TN to TP ratio")

Annual_plot(param = "ENTERO",  ylab =entero_y_title ) + geom_hline(yintercept = 130, color = "black", linetype = "dashed")

Annual_plot(param = "FECCOL",  ylab =fecal_y_title) + geom_hline(yintercept = 43, color = "black", linetype = "dashed")




### Geometric means by month
season_plot1 <- function(param, ylab) {
  
  gmean <- function(x) exp(mean(log(x), na.rm = TRUE))
  gmeansd <- function(x) exp(sd(log(x), na.rm = TRUE))
  se <- function(x) (sd(x, na.rm = T)/sqrt(length(x)))
  
  df <- dat_c %>%
    mutate( month=lubridate::month(sample_date, label = TRUE)) %>%
    arrange(month)%>%
    select( month, wbid, {{param}}) %>% 
    group_by(month, wbid)%>%
    summarise(gmean=gmean({{param}}), se=se({{param}}))
  
  ylab <- ylab
  
  p <- df %>% 
    ggplot(aes(x = month, y = gmean, color = wbid, group=wbid)) +
    stat_summary(fun.y=sum, geom="line", color="gray60", position=position_dodge2(width = 0.2))+
    geom_linerange(aes(ymax = gmean + se, ymin = ifelse(gmean - se < 0, 0, gmean - se)), color = "gray60", position = position_dodge2(width = 0.2)) + #keeps error bar from going below 0 and messing up scale  
    geom_point(stat='summary', size=2, position=position_dodge2(width = 0.2)) +
    theme_classic() +
    scale_color_manual(values = c("blue", "red"))+
    theme(legend.position = "right", legend.title = element_blank(), axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) + 
    labs(x = "",
         y = ylab)
  
  print(p)
}

season_plot1(param = CHLa_C,  ylab =chla_y_title ) + geom_hline(yintercept = 11, color = "blue", linetype = "dashed")+geom_hline(yintercept = 6.6, color = "red", linetype = "dashed")

season_plot1(param = ENTERO,  ylab =entero_y_title ) + geom_hline(yintercept = 130, color = "black", linetype = "dashed")

season_plot1(param = FECCOL,  ylab =fecal_y_title) + geom_hline(yintercept = 43, color = "black", linetype = "dashed")

season_plot1(param = TKN,  ylab =TKN_y_title) + geom_hline(yintercept = 0.65, color = "red", linetype = "dashed")

season_plot1(param = TP,  ylab =phos_y_title) + geom_hline(yintercept = 0.105, color = "red", linetype = "dashed")

