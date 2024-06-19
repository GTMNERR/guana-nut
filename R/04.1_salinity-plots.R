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

# salinity gradient jitter with boxplot ------------------------------------------------

ggplot(data = dat_c,
       aes(x = site_acronym,
           y = SALT,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  geom_boxplot(alpha=0.5) +
  theme_classic() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) +
  labs(x = "",
       y = "Salinity, PSU")


###Other metrics-----

##TKN
ggplot(data = dat_c,
       aes(x = site_acronym,
           y = TKN,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  geom_boxplot(alpha=0.5) +
  theme_classic() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) +
  labs(x = "",
       y = "Total Kjeldahl Nitrogen, mg/L")

##CHL
ggplot(data = dat_c,
       aes(x = site_acronym,
           y = CHLa_C,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  geom_boxplot(alpha=0.5) +
  theme_classic() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) +
  labs(x = "",
       y = "Chlorophyll a, μg/L")



##TP
ggplot(data = dat_c,
       aes(x = site_acronym,
           y = TP,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  geom_boxplot(alpha=0.5) +
  theme_classic() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) +
  labs(x = "",
       y = phos_y_title)



##ENTERO
ggplot(data = dat_c,
       aes(x = site_acronym,
           y = ENTERO,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  geom_boxplot(alpha=0.5) +
  theme_classic() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) +
  labs(x = "",
       y = entero_y_title)

##FECAL
ggplot(data = dat_c,
       aes(x = site_acronym,
           y = FECCOL,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  geom_boxplot(alpha=0.5) +
  theme_classic() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) +
  labs(x = "",
       y = fecal_y_title)

##NO23F
ggplot(data = dat_c,
       aes(x = site_acronym,
           y = NO23F,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  geom_boxplot(alpha=0.5) +
  theme_classic() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) +
  labs(x = "",
       y = "Nitrate/Nitrite, mg/L")

##TN
ggplot(data = dat_c,
       aes(x = site_acronym,
           y = TN,
           color = site_acronym)) +
  geom_jitter(width = 0.2, alpha = 0.8) +
  geom_boxplot(alpha=0.5) +
  theme_classic() +
  theme(legend.position = "none",
        axis.text = element_text(color = "black"), axis.title = element_text(size = 12), axis.text.x= element_text(size=10), axis.text.y= element_text(size=10)) +
  labs(x = "",
       y = nitro_y_title)
