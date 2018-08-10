#' run2elev
#' @description Visualize a run/hike temporal elevation. 
#' @param data A run data frame returned by \code{import_run}.
#' @param color The color to draw the movement line in. 
#' @param smooth Logical T/F whether to add a smooth function.
#' @param smoothfactor Loess smoothing factor
#' @param smoothcolor Color to draw the smoothline in. 
#' @return A ggplot object.
#' @examples
#' data("alpine_skiing")
#' 
#' run2elev(data = alpine_skiing)
#'
#' run2elev(data = alpine_skiing,
#'          color = "black",
#'          smooth = TRUE,
#'          smoothfactor = 0.3,
#'          smoothcolor = "red") 
#'          
#' run2elev(data = alpine_skiing) + 
#' geom_hline(yintercept = mean(alpine_skiing$ele,na.rm = TRUE),
#'            color = "green")    
#' @section Integration into ggplot2:
#' You can simply add to a plot created by \code{run2elev} by using the usual \code{ggplot2}-syntax.
#' @export
run2elev <- function(data = alpine_skiing,
                     color = "black",
                     smooth = TRUE,
                     smoothfactor = 1,
                     smoothcolor = "red"
                    ){
  
  p <- 
    ggplot(data = data, 
           aes(x=time, 
               y=ele))+
    geom_point(color = color) + 
    geom_line(color = color) + 
    {if(smooth == T)geom_smooth(method = "loess",span = smoothfactor,color = smoothcolor)} +
    labs(title = 'runR-Elevationplot',
         subtitle = 'Location in meters above sealevel',
         x = 'Time',
         y = 'Elevation (in meters)')+
    {if(smooth == T)labs(caption = paste0('loess - smooth factor: ',smoothfactor))}+
    theme_minimal();p
  return(p)
}

#run2elev(color = "black",smooth = T,smoothfactor = 0.3) 


