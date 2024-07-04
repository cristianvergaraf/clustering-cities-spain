library(psych)
library(writexl)
library(tidyverse)
library(psych)
library(GPArotation)
library(writexl)
library(openxlsx2)

### Funcion para exportar datos a excel

export_list_to_excel <- function(my_list, output_file) {
  # Create a new workbook
  
  wb <- wb_workbook()
  names_list <- names(my_list)
  
  # Iterate over the list elements
  for (i in seq_along(my_list)) {
    # Extract the current element
    current_element <- my_list[[i]]
    
    # Create a name sheet
    
    name_sheet = paste('fa',i,sep = "")
    
    fa_parameters = names_list[i]
    
    # Create a new sheet in the workbook
    wb$add_worksheet(sheet = name_sheet)
    
    wb$add_data(name_sheet, fa_parameters, startCol = 1, startRow = 1)
    
    wb$add_data(name_sheet, current_element, startCol = 1, startRow = 3, rowNames = TRUE)
    
  }
  
  # Save the workbook as an Excel file
  wb_save(wb, path = output_file)
}


# Funcion que a partir de la salida del objeto FA devuelve un data.frame

df_factors <- function(fa_result){
  t = fa_result$Vaccounted[3,]
  n = length(t)
  column_names <- paste0("F", 1:n)  # Generate column names
  order_t <- t[order(names(t))]
  df <- setNames(as.data.frame(matrix(order_t, nrow = 1, ncol = n)), column_names)
  return(df)
}


# funcion para crear un objeto de workbook para ir agregando los resultados de los FA

summarize_fa <- function(wb,df, n = i,it = iterations, pc = parameter_combinations){
  if (it == 1){
  wb$add_data("resultados", df[1,], startCol = 2, startRow = 2 + n, colNames = FALSE, rowNames = FALSE)
  }
  else{
    wb$add_data("resultados", df[1,], startCol = 2, startRow = ((pc+2)*(it-1)) + n, colNames = FALSE, rowNames = FALSE)
  }
    return(wb)
  
  
}

# Funcion que a partir una lista de parametros prueba todas las combinaciones, y devuelve los resultados 

factor_analysis_export <- function(data_list,data_names, n_factors, fm_methods, rotate_methods){
  # Generate all possible combinations of parameters
  parameter_combinations <- tidyr::expand_grid(n_factors = as.integer(n_factors),
                                               fm_methods = fm_methods,
                                               rotate_methods = rotate_methods)
  
  # Create an empty structures to save results
  loading_list <- list()
  result_df <- data.frame() 
  vector_names <-c()
  wb <- wb_workbook()
  wb$add_worksheet(sheet = "resultados")
  number_parameter_combinations = nrow(parameter_combinations)
  iterations = 0
  #data_names = paste("data",seq(length(data_list)), sep = "")
  
  for  (data in data_list) {
    iterations = iterations +  1
    
  # Iterate over the parameter combinations
    for (i in 1:nrow(parameter_combinations)) {
      # Extract the current parameter combination
      current_params <- parameter_combinations[i, ]
      n <- current_params$n_factors
      fm <- current_params$fm_methods
      rotate <- current_params$rotate_methods
    
      # Perform factor analysis with the current parameters
      
      fa_result <- fa(r = data, nfactors = n, fm = fm, rotate = rotate)
      
      variance_result <- df_factors(fa_result) #  Funcion propia. Devuelve un dataframe de un fila de la varianza. 
      # m = length(colnames(data)) 
    
      # Vamoso a crear un data frame 
      loadings_values <- data.frame(fa_result$loadings[])
      #resultados_n <- resultados[1:m,] # Esto en principio no es necesario. 
      
      
      # Resultados 1 es dataframe. Comunalidad, complexity, unicicidad
      complexity <- data.frame(comunality = fa_result$communality, complexity = fa_result$complexity, uniqueness = fa_result$uniquenesses
      )
      
      Parameters = paste("data = ", data_names[iterations],"nfactors =", n, "fm =", fm, "rotate =", rotate)
    
      # Este es el data.frame resultado de cada fa. 
      
      final <- cbind(loadings_values,complexity)  
      
      ### Esto se almacena en una lista y luego se exporta a un hoja de excel
      
      loading_list[[length(loading_list) + 1]] <- final 
      
      # Estamos creando una lista de nombres para darle a los elementos de la lista
      
      vector_names = c(vector_names,Parameters) 
      
      parameters_model <- data.frame(Parameters = paste("data = ", data_names[iterations],"nfactors =", n, "fm =", fm, "rotate =", rotate)) 
      
      # Este dataframe debe ir agregandose en cada iteracion en una hoja workbook
      res_var <- cbind(parameters_model,variance_result) 
      
      
      ## Le damos un nombre a cada elemento de la lista basado en el vector vecto_names
      names(loading_list) <- vector_names 
      
      wb <- summarize_fa(wb,res_var,i,iterations,number_parameter_combinations)
  
    } 
    
  
  }  
  
  # Esta es la salida de la loading list
  
  output_file <- "fa_results.xlsx"   
  export_list_to_excel(loading_list, output_file)
  
  wb_save(wb, path = "wb_test.xlsx")
  
  
} 




