#' a deprecated ggplot2 theme developed for PDF and PNG for use at the 
#' Wisconsin Department of Public Instruction
#' @description This is a custom ggplot2 theme developed for the Wisconsin 
#' Department of Public Instruction. This function is now deprecated.
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
theme_dpi <- function (base_size = 16, base_family = "") {
  .Deprecated("theme_bw")
  theme_bw(base_size = base_size, base_family = base_family)
  
  }

#' a deprecated ggplot2 theme developed for PDF or SVG maps
#' @description This is a deprecated ggplot2 theme developed for the Wisconsin 
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
theme_dpi_map <- function(base_size = 14, base_family = "") {
  .Deprecated("theme_bw")
  theme_bw(base_size = base_size, base_family = base_family)
}


#' an alternate deprecated ggplot2 theme developed for PDF or SVG maps
#' @description This is a deprecated ggplot2 theme developed for the Wisconsin 
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
theme_dpi_map2 <- function(base_size = 14, base_family = "") {
  .Deprecated("theme_bw")
  theme_bw(base_size = base_size, base_family = base_family)
}


#' an deprecated ggplot2 theme developed for PNG or JPG maps
#' @description This is a deprecated ggplot2 theme developed for the Wisconsin 
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
theme_dpi_mapPNG<-function (base_size = 18, base_family = "") {
  .Deprecated("theme_bw")
  theme_bw(base_size = base_size, base_family = base_family)
}
