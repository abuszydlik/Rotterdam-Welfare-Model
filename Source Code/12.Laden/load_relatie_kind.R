#--------------------------------------------------------------------------------------------------
# BESCHRIJVING 
# Laad nieuwste versie van de data en schrijf dit weg naar een feather bestand met de tabelnaam
#
# WIJZIGINGSHISTORIE
# 10-07-2017, Medewerker4, initiele versie
# 23-08-2017, Medewerker4, verplaatsing naar cloud server
# 25-08-2017, Medewerker3, wegschrijven naar feather
# 22-06-2020, Medewerker4, naar lubridate as_date(), want dan geen expliciete timezone nodig
#--------------------------------------------------------------------------------------------------

tabel <- "relatie_kind"

read_feather(paste0(bronfolder, tabellen$file_def[tabellen$tabel == tabel])) %>%
  # DWH kolommen droppen
  select(-c(X_WEIFRA_RELATIE_KIND_ID, MTG_BRON, MTG_DATUM, MTG_LOB_ID, MTG_GELDIG_VAF, MTG_GELDIG_TEM)) %>%
  # Overige omzettingen
  set_names(tolower(names(.))) %>%
  rename(persoon_id = bsn) %>%
  mutate(dtaanvang = as_date(dtaanvang),
         dteinde = as_date(dteinde),
         dtopvoer = as_date(dtopvoer),
         dtafvoer = as_date(dtafvoer)) %>% 
  write_feather(paste0(datafolder, tabel, ".feather"))



