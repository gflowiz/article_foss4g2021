test_that("multiplication works", {

  pl1 = sf::st_polygon(list(rbind(c(0,0),c(1,0),c(1,1),c(0,0)))) * 3
  pl2 = sf::st_polygon(list(rbind(c(0,0),c(1,1),c(0,1),c(0,0)))) * 3
  pl3 = sf::st_polygon(list(rbind(c(1,0),c(2,0),c(2,1),c(1,0)))) * 3
  pl4 = sf::st_polygon(list(rbind(c(1,0),c(1,1),c(2,1),c(1,0)))) * 3
  s = sf::st_sf(group = c("a","a","b","b"), geom = sf::st_sfc(pl1, pl2, pl3,pl4))

  centroids <- s %>% dplyr::group_by(group) %>% dplyr::summarise() %>% sf::st_centroid()

  p <- cbind(sf::st_coordinates(centroids), centroids)

  expect_equal(prepare_nodes(s, group), p)
})
