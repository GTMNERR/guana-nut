
## :: means look in this package to use this function, 
## %>%  pass the left hand side of the operator to the first argument 
## of the right hand side of the operator

##WORKS
dat <- readxl::read_xlsx(here::here('data', 'Guana_masterdata_2021_08_23.xlsx'), 
                        sheet = 'Sheet1') %>% 
  janitor::clean_names()

# data dictionary with site-specific information
dict <- readr::read_csv(here::here('data', 'guana_data_dictionary.csv')) %>%
  janitor::clean_names()


# inspect the data file
head(dat)
str(dat)
dplyr::glimpse(dat) # this one is my favorite to use

## remove dup samples
## cleaning up data, selecting columns we want 
# removing wind and secchi, all component toupper (not sure why)
dat2 <- dat %>%
  dplyr::filter(station_code != "GTMOLNUT_dup") %>%  # remove the 'duplicate' station that was only sampled for a short while
  dplyr::select(unit,
                station_code,
                sample_date,
                component_short,
                component_long,
                result,
                remark,
                flag) %>%
  dplyr::filter(!(component_short %in% c("WIND_D", "SECCHI"))) %>% # remove wind direction and secchi
  dplyr::mutate(component_long = toupper(component_long),
                component_short = toupper(component_short))

# CAUTION: rewrites over dat2 dataframe created in previous lines
# keeps 'data' as ORIGINAL dat that you read in
dat2 <- dplyr::left_join(dat2, dict, by = "station_code")

# make sure both short and long have the same number of entries (~69)
# should be the same number of entries!
unique(dat2$component_short) # will pull out all the unique component names
unique(dat2$component_long) # will pull out the unique component names

##check for duplicates
janitor::get_dupes(dat2)

##check dat for NA or BLANKS ?? I have quite a few??
View(dat2 %>% dplyr::filter(is.na(result)))

## remove NA files
dat2 <- dat2 %>% dplyr::filter(result != "NA")



##rewrite data2, formatting time and sample and char

dat2 <- dat2 %>%
  dplyr::mutate(sample_date = as.POSIXct(sample_date,
                                          format = "%m/%d/%Y %H:%M",
                                          tz = 'America/Regina'),
                result = as.numeric(result),
                month = month(sample_date),
                day = day(sample_date),
                year = as.character(year(sample_date)), # set year as a character
                site = factor(site,
                              levels = c("MICKLERS",
                                         "DEPGL1",
                                         "DEPGL2",
                                         "LAKE MIDDLE",
                                         "DEPGL4",
                                         "LAKE SOUTH",
                                         "RIVER NORTH",
                                         "DEPGR1",
                                         "GUANA RIVER",
                                         "DEPGR3")),
                site_friendly = factor(site_friendly,
                                       levels = c("Micklers",
                                                  "GL1",
                                                  "GL2",
                                                  "Lake Middle",
                                                  "GL4",
                                                  "Lake South",
                                                  "River North",
                                                  "GR1",
                                                  "Guana River",
                                                  "GR3"))
                )

## Load Coloring Script
## Load plotting script