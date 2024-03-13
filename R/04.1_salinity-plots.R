library(here)
source(here('R', '01_load-data.R'))
source(here('R', '02_wrangle-data.R'))
source(here('R', '03_summary-tbl.R'))
source(here('R', '00_vis_custom.R'))

# a variety of point plots with medians overlaid

# salinity gradient jitter ------------------------------------------------

ggplot(data = dat_c,
       aes(x = site_acronym,
           y = SALT,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  geom_point(data = dat_summary, aes(x = site_acronym, y = SALT_median), 
             color = "black", size = 3) +
  theme_bw() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black")) +
  labs(x = "",
       y = "Salinity, PSU")

# salinity gradient jitter with waterbody ---------------------------------

ggplot(data = dat_c,
       aes(x = site_acronym,
           y = SALT,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  facet_grid(~wbid, scales = "free", space = "free") +
  theme_bw() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black")) +
  labs(x = "",
       y = "Salinity, PSU")


# salinity gradient point -------------------------------------------------

ggplot(data = dat_c,
       aes(x = site_acronym,
           y = SALT,
           color = site_acronym)) +
  geom_point(alpha = 0.8) +
  geom_point(data = dat_summary, aes(x = site_acronym, y = SALT_median), 
             color = "black", size = 3) +
  theme_bw() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black")) +
  labs(x = "",
       y = "Salinity, PSU")

