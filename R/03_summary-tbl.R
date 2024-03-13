
se <- function(x) (sd(x, na.rm = T)/sqrt(length(x)))

# Geometric means and std errors of Entero, DO, TN/TKN, TP, and CHL 

dat_summary <- 
dat_c %>% 
  select(site_acronym, ENTERO, SALT, DO, TN, TKN, TP, CHLa_C) %>% 
  group_by(site_acronym) %>% 
  summarise_all(list(~ mean(., na.rm = T), 
                     ~ sd(., na.rm = T),
                     ~ median(., na.rm = T), 
                     ~ se(.)))