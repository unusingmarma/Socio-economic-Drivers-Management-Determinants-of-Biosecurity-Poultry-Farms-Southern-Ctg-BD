# Socio-economic Drivers and Management Determinants of Biosecurity in Commercial Poultry Farms of Southern Chattogram, Bangladesh

This repository contains the anonymized survey dataset, SPSS syntax, R analysis code, and GIS spatial layers for the research study evaluating farm-level biosecurity adoption in commercial poultry production systems across Southern Chattogram, Bangladesh.

## Repository Directory Structure

```text
├── data/
│   ├── PF_3.csv    # Anonymized farm-level survey dataset
│   └── data_dictionary.csv             # Variable codebook and definitions
│
├── spatial_data/
│   ├── poultry_farm_locations.geojson     # Farm locations of all farm types
│
├── scripts/
│   ├── spss/
│   │   ├── descriptive_nonparametric_tests.sps      # SPSS Syntax: Frequencies, means, SDs, Mann-Whitney U & Kruskal-Wallis tests
│   └── r/
│       ├── PF3.R              # R script: Regression modeling
│
└── outputs/
    ├── poultry_farm_location.pdf                        # Rendered publication map (.pdf)
    ├── regression.csv                         # Regression table
    ├── homoscedasticity test.csv                         # Homoscedasticity test results of the regression model
    └── multicolinearity test.csv                         # Multicolinearity test results of the regression model
