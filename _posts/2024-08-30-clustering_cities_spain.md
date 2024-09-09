---
layout: page
title: Finding pattern in Spanish cities
---

## Take home message 

* Classification of cities may be possible based on land use, spatial configuration and socioeconomic data

* Cities with more than 100000 do not show characteristic of monofuncionality, such characteristic may be found in smaller cities

### Classification of cities

Cities with more than 100.000 inhabitants can be classify in 5 different groups based on land use, spatial configuration and socioeconomic fetures. This groups are:

- Bid and diverse cities

- Small and monofunctional cities

- Embrionaries cities

- Transition

- Large and costal cities

#### Technical knowledge 

- Processing spatial data iteratively using Python (Geopandas).

- Cleaning data in Python (pandas, regex).

- Preprocesing data in Python: scaling features using MinMax, StandardScaler, and PowerTransfomer methods.

- Exploratory data analysis (Outliers, features distributions).

- Assessing multiple combinations of parameters to find optimal solution for  factor analysis.

- Evaluating the best combination of parameters to find optimal solution for hierarchical clustering using Silhouette as evaluation metric.

#### Objetive

Find groups of Spanish cities with more than 100,000 inhabitants based on land use, spatial configuration of patches, and socioeconomic data. 


### Figure 1. Flowchard describing the complete process to obtain cluster of cities.

![Figure 1](./figure1.png)


#### Spatial data

Using the Cadastre classification plug in we download the spatial and attribute data for Spanish cities with more than 100.000 inhabitants.

<h2> <a href = 'https://github.com/cristianvergaraf/clustering-cities-spain/blob/main/calculo_porcentaje_uso_ciudades.ipynb'> Classification </a> </h2>

Cities were classified using the tool of the cadastre plug in of QGIS in 12 diferent land uses.

#### Cleaning data

Socioeconomic data was obtained from X for each cities. Using python a new dataset with data of interest for each city was created. All different source of data were join using sql operations in pandas.

<h3>Exploratory data analysis</h3>

Features were <a href = 'https://github.com/cristianvergaraf/clustering-cities-spain/blob/main/escalar_variables.ipynb'>scaled </a> using three different methods, MinMax, StandardScaler, and PowerTransformation of the sklearn library in Python. Additionaly, a function applied to the features allowed to find outliers using the criterio of the 1.5 Interquartil range.

<h4><a href = "https://github.com/cristianvergaraf/clustering-cities-spain/blob/main/function_search_FA_parameters.R"> Factor Analysis</a></h4>


Factor analysis applied to reduce the dimensionality and get new variables that could explained most of the variance of the data, also this new variables could be interpreted to
facilitate the understanding of structure. Iterative factor analysis were made using the PSYCH library in R, a <a href = 'https://github.com/cristianvergaraf/clustering-cities-spain/blob/main/function_search_FA_parameters.R'> function </a> was created to test the combination of different parameters to find the optimal solution for the Factor analysis (number of factors, rotation, minres). Solution with best structure meaning high explanation, low communality.

### Cluster analysis

From the new factors different solutions were tested evaluation for different datasets. We tested removing few outliers, and differets number of clusters, linkage. We obtained aproximately 2000 combination of cluster. Many soluctions with high values of silhouette were meaningless since distribution of sample in the different cluster completly uneven. One of the optimal solution was chosen based on the interpretability of the clusters. 


