#' prepare_nodes
#'
#' Prepare nodes data
#'
#' @note Does not work using the formula notation involving \code{~} defined in \link[stats]{aggregate}.
#'
#' @param x object of class \link{sf}
#' @param vars variables to group by
#' @details
#' @examples
#' pl1 = sf::st_polygon(list(rbind(c(0,0),c(1,0),c(1,1),c(0,0)))) * 3
#' pl2 = sf::st_polygon(list(rbind(c(0,0),c(1,1),c(0,1),c(0,0)))) * 3
#' pl3 = sf::st_polygon(list(rbind(c(1,0),c(2,0),c(2,1),c(1,0)))) * 3
#' pl4 = sf::st_polygon(list(rbind(c(1,0),c(1,1),c(2,1),c(1,0)))) * 3
#' s = sf::st_sf(group = c("a","a","b","b"), geom = sf::st_sfc(pl1, pl2, pl3,pl4))
#' prepare_nodes(s)
prepare_nodes <- function(x, vars) {
  require(sf)
  require(dplyr)

  pt_centroid <- x %>%
    dplyr::group_by({{vars}})%>%
    dplyr::summarise() %>%
    sf::st_centroid()

  pts <- sf::st_coordinates(pt_centroid)

  nodes <- cbind(pts, pt_centroid)

  return(nodes)
}

