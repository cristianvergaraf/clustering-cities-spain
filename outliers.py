import numpy as np
import pandas as pd


def outliers_iqr(df):
    '''
    Esta función calcula valores atipicos a partir de la regla del 
    limite inferior = q1 - 1.5 Rango Intecuartilico
    limite superior = q3 + 1.5 Rango intecuartilico 

    '''
    
    # Calculate lower and upper bounds for each column
    lower_bounds = df.apply(lambda x: x.quantile(0.25) - 1.5 * (x.quantile(0.75) - x.quantile(0.25)))
    upper_bounds = df.apply(lambda x: x.quantile(0.75) + 1.5 * (x.quantile(0.75) - x.quantile(0.25)))

    # Define the compare function
    '''
        Esta función por medio del metodo where the numpy aplica la condición logica sobre cada elemento de una array
    devolviendo atipico si una de las opciones son verdaderas o típico en el caso contrario
    '''
    
    def compare(x, lower_range, upper_range):
        return np.where((x < lower_range) | (x > upper_range), 'atipico', 'tipico')

    # Apply the compare function to each column
    result = df.apply(lambda x: compare(x, lower_bounds[x.name], upper_bounds[x.name]))

    return result


def count_outliers(df):
    '''
    Esta función a partir de un dataframe
    suma el número de valores atípicos por característa (columna)
    '''
    counts = df.apply(lambda column: (column == 'atipico').sum())
    return pd.DataFrame({'Outliers_Count': counts})


def count_outliers_wide(df):
    '''
    Esta función a partir de un dataframe suma el número de valores
    atípicos por observación (fila)
    '''
    counts = df.apply(lambda row: (row == 'atipico').sum(), axis = 1)
    df =  pd.DataFrame({'Outliers_Count': counts})
    #df = df.drop("Ciudades", axis = 1)
    return df
    

def read_csv_file(file_path):
    '''
    Esta función a parir de un path permite leer un archivo csv, tomando 
    la columna Ciudades como índice
    '''
    df =  pd.read_csv(file_path, encoding = 'ISO-8859-1', index_col = [0])
    df = df.set_index('Ciudades')
    return df

def lista_observaciones(df):
    """ Esta función a partir de un dataframe 

    Args:
        dataframe

    Returns:
        Dataframe indicando si las observaciones son clasificadas como atípicos, o típicos.
    """
    column_names_list = []
    column_ciudades_list = []
    df = df.reset_index()
    for column in df.columns:
        column_names_list.append(column)
        column_ciudades_list.append(list(df[df[column] == 'atipico']['Ciudades']))
        
    
    df_metricas = pd.DataFrame({'Variables':column_names_list,'Ciudades_outliers':column_ciudades_list})
    df_metricas = df_metricas.query('Variables != "Ciudades"')
    return df_metricas

