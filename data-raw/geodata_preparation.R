# File preparation for geodata
library(here)
#remotes::install_github("jimhester/archive")
# library(archive)
library(sf)
library(dplyr)
url <- "ftp://Admin_Express_ext:Dahnoh0eigheeFok@ftp3.ign.fr/ADMIN-EXPRESS-COG_2-0__SHP__FRA_WGS84G_2019-09-24.7z.001"

# Due to technical issues the file was downloaded and extracted manually.
# Extract centroids
communes <- sf::read_sf(
  here::here("data-raw/COMMUNE_CARTO.shp"))

pt_centroid <- communes %>% sf::st_centroid()

pts <- sf::st_coordinates(pt_centroid)

nodes <- cbind(pts, pt_centroid) %>%
  dplyr::transmute(INSEE_COM = INSEE_COM,
                   lon = X,
                   lat = Y)

# Export to CSV
nodes %>%
  sf::st_drop_geometry() %>%
  readr::write_csv(file = here::here("data", "nodes_coordinates.csv"))

# Export to geojson
nodes %>%
  sf::st_write(here::here("data", "nodes_coordinates.geojson"))



dep <- arabesqueFOSS4G2021::prepare_nodes(communes, "INSEE_DEP")
dep
# Export to CSV
nodes %>%
  sf::st_drop_geometry() %>%
  readr::write_csv(file = here::here("data", "departements_nodes_coordinates.csv"))

# Export to geojson
nodes %>%
  sf::st_write(here::here("data", "departements_nodes_coordinates.geojson"))
