#' a defunct ggplot2 theme developed for PDF and PNG for use at the
#' Wisconsin Department of Public Instruction
#' @description This was a custom ggplot2 theme developed for the Wisconsin
#' Department of Public Instruction. This function is now defunct.
#' @param base_size  numeric, specify the font size as a numeric value, default is 16
#' @param base_family character, specify the font family, this value is optional
#' @details All values are optional
#' @return This function is defunct.
#' @section Deprecation:
#' Defunct as of eeptools 1.3.0 (deprecated since 1.2.x). Use
#' \code{\link[ggplot2]{theme_bw}} instead.
#' @seealso \code{\link[ggplot2]{theme_bw}} from the ggplot2 package.
#' @author Jared E. Knowles
#' @export
theme_dpi <- function (base_size = 16, base_family = "") {
  .Defunct("ggplot2::theme_bw",
           msg = "theme_dpi() is defunct. Use ggplot2::theme_bw() instead.")
}

#' a defunct ggplot2 theme developed for PDF or SVG maps
#' @description This was a ggplot2 theme developed for the Wisconsin
#' Department of Public Instruction for making PDF maps. This function is now defunct.
#' @param base_size numeric, specify the font size, default is 14
#' @param base_family character, specify the font family, this value is optional
#' @return This function is defunct.
#' @section Deprecation:
#' Defunct as of eeptools 1.3.0 (deprecated since 1.2.x). Use
#' \code{\link[ggplot2]{theme_bw}} instead.
#' @seealso \code{\link[ggplot2]{theme_bw}} from the ggplot2 package.
#' @author Jared E. Knowles
#' @export
theme_dpi_map <- function(base_size = 14, base_family = "") {
  .Defunct("ggplot2::theme_bw",
           msg = "theme_dpi_map() is defunct. Use ggplot2::theme_bw() instead.")
}


#' an alternate defunct ggplot2 theme developed for PDF or SVG maps
#' @description This was an alternate ggplot2 theme developed for the Wisconsin
#' Department of Public Instruction for making PDF maps. This function is now defunct.
#' @param base_size numeric, specify the font size, default is 14
#' @param base_family character, specify the font family, this value is optional
#' @return This function is defunct.
#' @section Deprecation:
#' Defunct as of eeptools 1.3.0 (deprecated since 1.2.x). Use
#' \code{\link[ggplot2]{theme_bw}} instead.
#' @seealso \code{\link[ggplot2]{theme_bw}} from the ggplot2 package.
#' @author Jared E. Knowles
#' @export
theme_dpi_map2 <- function(base_size = 14, base_family = "") {
  .Defunct("ggplot2::theme_bw",
           msg = "theme_dpi_map2() is defunct. Use ggplot2::theme_bw() instead.")
}


#' a defunct ggplot2 theme developed for PNG or JPG maps
#' @description This was a ggplot2 theme developed for the Wisconsin
#' Department of Public Instruction for making PNG or JPG maps. This function is now defunct.
#' @param base_size numeric, specify the font size, default is 18
#' @param base_family character, specify the font family, this value is optional
#' @return This function is defunct.
#' @section Deprecation:
#' Defunct as of eeptools 1.3.0 (deprecated since 1.2.x). Use
#' \code{\link[ggplot2]{theme_bw}} instead.
#' @seealso \code{\link[ggplot2]{theme_bw}} from the ggplot2 package.
#' @author Jared E. Knowles
#' @export
theme_dpi_mapPNG <- function (base_size = 18, base_family = "") {
  .Defunct("ggplot2::theme_bw",
           msg = "theme_dpi_mapPNG() is defunct. Use ggplot2::theme_bw() instead.")
}
