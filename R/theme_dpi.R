#' a ggplot2 theme developed for PDF and PNG for use at the Wisconsin Department of Public Instruction
#' @description This is a custom ggplot2 theme developed for the Wisconsin 
#' Department of Public Instruction
#' @param base_size  numeric, specify the font size as a numeric value, default is 16
#' @param base_family character, specify the font family, this value is optional
#' @details All values are optional
#' @return A theme object which is a list of attributes applied to a ggplot2 object.
#' @source For more information see https://github.com/hadley/ggplot2/wiki/Themes
#' @seealso his uses \code{\link{unit}} from the grid package extensively. 
#' See also \code{\link{theme_bw}} from the ggplot2 package.
#' @author Jared E. Knowles
#' @import ggplot2
#' @export
#'
#' @examples
#' qplot(mpg, wt, data=mtcars) # standard
#' qplot(mpg, wt, data=mtcars) + theme_dpi()
theme_dpi <- function (base_size = 16, base_family = "") {
  .Deprecated("theme_bw")
  theme_bw(base_size = base_size, base_family = base_family)
  
  }

#' a ggplot2 theme developed for PDF or SVG maps
#' @description This is a custom ggplot2 theme developed for the Wisconsin 
#' Department of Public Instruction for making PDF maps
#' @param base_size numeric, specify the font size, default is 14
#' @param base_family character, specify the font family, this value is optional
#'
#' @return A theme object which is a list of attributes applied to a ggplot2 object.
#' @details All values are optional
#' @source For more information see https://github.com/hadley/ggplot2/wiki/Themes
#' @seealso his uses \code{\link{unit}} from the grid package extensively. 
#' See also \code{\link{theme_bw}} from the ggplot2 package.
#' @author Jared E. Knowles
#' @import ggplot2
#' @export
#'
#' @examples
#' # Data
#' crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
#' require(reshape) # for melt
#' crimesm <- melt(crimes, id = 1)
#' # No DPI theme
#' states_map <- map_data("state")
#' ggplot(crimes, aes(map_id = state)) + geom_map(aes(fill = Murder), map = states_map) + 
#'     expand_limits(x = states_map$long, y = states_map$lat)+ labs(title="USA Crime")
#' # Draw map
#' last_plot() + coord_map()
#' # DPI theme
#' ggplot(crimesm, aes(map_id = state)) + geom_map(aes(fill = value), map = states_map) + 
#'     expand_limits(x = states_map$long, y = states_map$lat) + facet_wrap( ~ variable)+theme_dpi_map()
theme_dpi_map <- function(base_size = 14, base_family = "") {
  .Deprecated("theme_bw")
  theme_bw(base_size = base_size, base_family = base_family)
}


#' an alternate ggplot2 theme developed for PDF or SVG maps
#' @description This is a custom ggplot2 theme developed for the Wisconsin 
#' Department of Public Instruction for making PDF maps
#' @param base_size numeric, specify the font size, default is 14
#' @param base_family character, specify the font family, this value is optional
#'
#' @return A theme object which is a list of attributes applied to a ggplot2 object.
#' @details All values are optional
#' @source For more information see https://github.com/hadley/ggplot2/wiki/Themes
#' @seealso his uses \code{\link{unit}} from the grid package extensively. 
#' See also \code{\link{theme_bw}} from the ggplot2 package.
#' @author Jared E. Knowles
#' @import ggplot2
#' @export
#' @examples
#' # Data
#' crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
#' require(reshape) # for melt
#' crimesm <- melt(crimes, id = 1)
#' # No DPI theme
#' states_map <- map_data("state")
#' ggplot(crimes, aes(map_id = state)) + geom_map(aes(fill = Murder), map = states_map) + 
#'     expand_limits(x = states_map$long, y = states_map$lat)+ labs(title="USA Crime")
#' # Draw map
#' last_plot() + coord_map()
#' # DPI theme
#' ggplot(crimesm, aes(map_id = state)) + geom_map(aes(fill = value), map = states_map) + 
#'     expand_limits(x = states_map$long, y = states_map$lat) + 
#'     facet_wrap( ~ variable) + theme_dpi_map2()
theme_dpi_map2 <- function(base_size = 14, base_family = "") {
  .Deprecated("theme_bw")
  theme_bw(base_size = base_size, base_family = base_family)
}


#' an alternate ggplot2 theme developed for PNG or JPG maps
#' @description This is a custom ggplot2 theme developed for the Wisconsin 
#' Department of Public Instruction for making PNG or JPG maps
#' @param base_size numeric, specify the font size, default is 18
#' @param base_family character, specify the font family, this value is optional
#'
#' @return A theme object which is a list of attributes applied to a ggplot2 object.
#' @details All values are optional
#' @source For more information see https://github.com/hadley/ggplot2/wiki/Themes
#' @seealso his uses \code{\link{unit}} from the grid package extensively. 
#' See also \code{\link{theme_bw}} from the ggplot2 package.
#' @author Jared E. Knowles
#' @import ggplot2
#' @export
#' @examples
#' # Data
#' crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
#' require(reshape) # for melt
#' crimesm <- melt(crimes, id = 1)
#' # No DPI theme
#' states_map <- map_data("state")
#' ggplot(crimes, aes(map_id = state)) + geom_map(aes(fill = Murder), map = states_map) + 
#'     expand_limits(x = states_map$long, y = states_map$lat)+ labs(title="USA Crime")
#' # Draw map
#' last_plot() + coord_map()
#' # DPI theme
#' ggplot(crimesm, aes(map_id = state)) + geom_map(aes(fill = value), map = states_map) + 
#'     expand_limits(x = states_map$long, y = states_map$lat) + 
#'     facet_wrap( ~ variable) + theme_dpi_mapPNG()
theme_dpi_mapPNG<-function (base_size = 18, base_family = "") {
  .Deprecated("theme_bw")
  theme_bw(base_size = base_size, base_family = base_family)
}
