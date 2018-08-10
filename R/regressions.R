#' Interaction
#' @description ...
#' @param ... 
#' @param ...
#' @examples
#' \dontrun{
#' update_yaml("voteR",overwrite = FALSE)
#' }
#' @section Integration into ggplot2:
#' You can simply add to a plot created by \code{run2elev} by using the usual \code{ggplot2}-syntax.
#' @export
interact <- function(vars){
  string <- paste0(vars,collapse = "*")
  return(string)
}

# interact(c("a","b"))


### 

#' Bind covariates
#' @description ...
#' @param ... 
#' @param ...
#' @examples
#' \dontrun{
#' update_yaml("voteR",overwrite = FALSE)
#' }
#' @section Integration into ggplot2:
#' You can simply add to a plot created by \code{run2elev} by using the usual \code{ggplot2}-syntax.
#' @export
bindvars <- function(vars){
  cov <- paste0(vars %>% unlist(),collapse = " + ")
  return(cov)
}


#' Run regression 
#' @description ...
#' @param ... 
#' @param ...
#' @param ... Other parameters passed into the regression function
#' @examples
#' \dontrun{
#' reg(method = "lm",
#'     depvar = "mpg",
#'     covars = list(c("cyl","disp"),
#'                   c("drat","vs","am")),
#'     data = "mtcars",
#'     stepwise = T,
#'     stargazer = T)
#' }
#' @section Integration into ggplot2:
#' You can simply add to a plot created by \code{run2elev} by using the usual \code{ggplot2}-syntax.
#' @export
reg <- function(method = "lm",
                depvar = "1",
                covars = list(c("cyl","disp"),
                              c("drat","vs","am")),
                data,
                stepwise = FALSE,
                stargazer = FALSE,
                ...){
  


  if(stepwise == FALSE) len <- 1 else len <- length(covars) 
  
  models <- c()
  for(q in 1:len){
    
    cov <- bindvars(covars[1:q])
    
    modlabel <- paste0("mod_",depvar,"_",q)
    models[q] <- modlabel
    
# Estimate Model
  if(method == "lm"){
   eval(parse(text = paste0(modlabel," <<- lm(",depvar," ~ ",cov,",data = ",data,")")))
  } 
    
  if(method == "lmer"){
      eval(parse(text = paste0(modlabel," <<- lmer(",depvar," ~ ",cov,",data = ",data,")")))
    }  

  
  eval(parse(text  = paste0("print(summary(",modlabel,"))")))
  
  }
  
  modellist <<- eval(parse(text = paste0("list(",paste0(models,collapse = ","),")")))
  
  
  if(stargazer == TRUE){
    warning("Attention: Stargazer-support still in beta version")
    print(modelname)
    filename <- paste0(depvar)
    xx <- capture.output(stargazer::stargazer(modellist ,
                                              type = "html",
                                              out = paste0(filename,".html"),
                                              star.cutoffs = c(0.05,0.01,0.001)))
  }
}

# reg(method = "lm",
#     depvar = "mpg",
#     covars = list(c("cyl","disp"),
#                   c("drat","vs","am")),
#     data = "mtcars",
#     stepwise = T,
#     stargazer = T)




