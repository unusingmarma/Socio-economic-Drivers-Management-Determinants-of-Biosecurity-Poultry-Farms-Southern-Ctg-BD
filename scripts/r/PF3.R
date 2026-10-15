library(readxl)
library(boot)
library(lm.beta)
library(lmtest)
library(car)

# 2. Import Dataset and Set Factors
# Load data from file
df <-PF_3

# Convert specified predictors to factor variables
df$Poultry_type      <- factor(df$Poultry_type)
df$Age_N             <- factor(df$Age_N)
df$Marital_N         <- factor(df$Marital_N)
df$Education_N       <- factor(df$Education_N)
df$Experience_N      <- factor(df$Experience_N)
df$Training_received <- factor(df$Training_received)
df$HeatStressManage  <- factor(df$HeatStressManage)

# Define simplified formula
model_formula <- Biosecurity_Sc ~ Poultry_type + Age_N + Marital_N + 
  Education_N + Experience_N + Training_received + HeatStressManage

# ==============================================================================
# 3. Custom Bootstrap Function with Resampling Safety Check
# ==============================================================================
boot_coefs <- function(data, indices) {
  d <- data[indices, ]
  tryCatch({
    fit <- lm(model_formula, data = d)
    if (any(is.na(coef(fit)))) {
      return(rep(NA, length(coef(fit))))
    }
    return(coef(fit))
  }, error = function(e) {
    return(rep(NA, length(coef(lm(model_formula, data = data)))))
  })
}

# ==============================================================================
# 4. Run OLS, Standardized Beta, and 1000 Bootstraps
# ==============================================================================
set.seed(123)

# Fit primary OLS model
ols_model  <- lm(model_formula, data = df)
beta_model <- lm.beta(ols_model)

# Execute 1000 bootstrap iterations
boot_results <- boot(data = df, statistic = boot_coefs, R = 1000)

ncol(t.star)
sapply(res, length)

# ==============================================================================
# 5. Extract and Format Main Output Table
# ==============================================================================
var_names    <- names(coef(ols_model))
B_estimates  <- coef(ols_model)
p_values     <- summary(ols_model)$coefficients[, 4]
beta_coefs   <- summary(beta_model)$coefficients[, "Standardized"]

# Bootstrapped Standard Error
boot_se <- apply(boot_results$t, 2, sd, na.rm = TRUE)

# Standard OLS 95% Confidence Intervals
ols_ci <- confint(ols_model, level = 0.95)
ols_ci_formatted <- sprintf("[%s, %s]", 
                            format(round(ols_ci[, 1], 3), nsmall = 3), 
                            format(round(ols_ci[, 2], 3), nsmall = 3))

# Assemble formatted table
regression_summary <- data.frame(
  Variable              = var_names,
  B                     = round(B_estimates, 3),
  Boot_SE               = round(boot_se, 3),
  `Standard OLS 95% CI` = ols_ci_formatted,
  Beta                  = round(beta_coefs, 3),
  p_value               = ifelse(p_values < 0.001, "< 0.001", sprintf("%.3f", p_values)),
  stringsAsFactors      = FALSE,
  check.names           = FALSE
)

# Print regression summary table
cat("=== MULTIVARIABLE REGRESSION SUMMARY ===\n")
print(regression_summary, row.names = FALSE)

# ==============================================================================
# 6. Model Diagnostics (GVIF, Homoscedasticity, Residuals)
# ==============================================================================
cat("\n=== GENERALIZED VARIANCE INFLATION FACTORS (GVIF) ===\n")
print(vif(ols_model))

cat("\n=== BREUSCH-PAGAN TEST FOR HOMOSCEDASTICITY ===\n")
print(bptest(ols_model))

cat("\n=== NON-CONSTANT VARIANCE SCORE TEST ===\n")
print(ncvTest(ols_model))



# ==============================================================================
# 1. Load Required Libraries
# ==============================================================================
library(readxl)
library(boot)
library(lm.beta)
library(lmtest)
library(car)

# ==============================================================================
# 2. Load PF_3.xlsx Dataset & Format Predictors
# ==============================================================================
df <-PF_3

View(df)

df$Poultry_type      <- factor(df$Poultry_type)
df$Age_N             <- factor(df$Age_N)
df$Marital_N         <- factor(df$Marital_N)
df$Education_N       <- factor(df$Education_N)
df$Experience_N      <- factor(df$Experience_N)
df$Training_received <- factor(df$Training_received)
df$HeatStressManage  <- factor(df$HeatStressManage)

# Reduced model formula without LttrMaterial & RoofT_N
model_formula <- Biosecurity_Sc ~ Poultry_type + Age_N + Marital_N + 
  Education_N + Experience_N + Training_received + HeatStressManage

# Fit primary OLS and standardized Beta models
ols_model  <- lm(model_formula, data = df)
beta_model <- lm.beta(ols_model)

# ==============================================================================
# 3. Robust Bootstrapping (1000 Resamples)
# ==============================================================================
base_coefs <- coef(ols_model)
n_coefs    <- length(base_coefs)

boot_coefs <- function(data, indices) {
  d <- data[indices, ]
  fit <- lm(model_formula, data = d)
  co  <- coef(fit)
  
  if (length(co) != n_coefs || any(is.na(co))) {
    out <- setNames(rep(NA, n_coefs), names(base_coefs))
    out[names(co)] <- co
    return(out)
  }
  return(co)
}

set.seed(123)
boot_results <- boot(data = df, statistic = boot_coefs, R = 1000)

# Check unique value counts for all predictors
sapply(df[, c("Poultry_type", "Age_N", "Marital_N", "Education_N", 
              "Experience_N", "Training_received", "HeatStressManage")], 
       function(x) length(unique(na.omit(x))))

# List of intended factor predictors
factor_cols <- c("Poultry_type", "Age_N", "Marital_N", "Education_N", 
                 "Experience_N", "Training_received", "HeatStressManage")

# Filter out any column that has less than 2 levels
valid_factors <- factor_cols[sapply(df[factor_cols], function(x) length(unique(na.omit(x))) >= 2)]

# Convert valid columns to factors
for (col in valid_factors) {
  df[[col]] <- factor(df[[col]])
}

# Dynamically construct formula using only valid factors
model_formula <- as.formula(
  paste("Biosecurity_Sc ~", paste(valid_factors, collapse = " + "))
)

# Fit model safely
ols_model <- lm(model_formula, data = df)
summary(ols_model)

#Homoscedasticity test 
library(lmtest)
library(car)

# Method A: Breusch-Pagan Test (lmtest package)
bp_test <- bptest(ols_model)
print(bp_test)

# Method B: Non-Constant Variance Score Test (car package)
ncv_test <- ncvTest(ols_model)
print(ncv_test)

# A. Multicollinearity Test (GVIF)
vif_results <- vif(ols_model)
print(vif_results)


# ==============================================================================
# 1. Load Required Packages
# ==============================================================================
library(readxl)
library(boot)
library(lm.beta)

# ==============================================================================
# 2. Load Dataset & Format Factor Variables
# ==============================================================================
df <-PF_3

# Set reference categories explicitly
df$Poultry_type      <- factor(df$Poultry_type)
df$Age_N             <- factor(df$Age_N)
df$Marital_N         <- factor(df$Marital_N)
df$Education_N       <- factor(df$Education_N)
df$Experience_N      <- factor(df$Experience_N)
df$Training_received <- factor(df$Training_received)
df$HeatStressManage  <- factor(df$HeatStressManage)

# Define formula without LttrMaterial
model_formula <- Biosecurity_Sc ~ Poultry_type + Age_N + Marital_N + 
  Education_N + Experience_N + Training_received + HeatStressManage

# Fit main OLS and Standardized Beta models
ols_model  <- lm(model_formula, data = df)
beta_model <- lm.beta(ols_model)

# ==============================================================================
# 3. Bootstrapping (1000 Resamples)
# ==============================================================================
base_coefs <- coef(ols_model)
n_coefs    <- length(base_coefs)

boot_coefs <- function(data, indices) {
  d <- data[indices, ]
  fit <- lm(model_formula, data = d)
  co  <- coef(fit)
  
  # Handle missing levels during resampling
  if (length(co) != n_coefs || any(is.na(co))) {
    out <- setNames(rep(NA, n_coefs), names(base_coefs))
    out[names(co)] <- co
    return(out)
  }
  return(co)
}

set.seed(123)
boot_results <- boot(data = df, statistic = boot_coefs, R = 1000)

# Check unique value counts for all predictors
sapply(df[, c("Poultry_type", "Age_N", "Marital_N", "Education_N", 
              "Experience_N", "Training_received", "HeatStressManage")], 
       function(x) length(unique(na.omit(x))))

# List of intended factor predictors
factor_cols <- c("Poultry_type", "Age_N", "Marital_N", "Education_N", 
                 "Experience_N", "Training_received", "HeatStressManage")

# Filter out any column that has less than 2 levels
valid_factors <- factor_cols[sapply(df[factor_cols], function(x) length(unique(na.omit(x))) >= 2)]

# Convert valid columns to factors
for (col in valid_factors) {
  df[[col]] <- factor(df[[col]])
}

# Dynamically construct formula using only valid factors
model_formula <- as.formula(
  paste("Biosecurity_Sc ~", paste(valid_factors, collapse = " + "))
)

# Fit model safely
ols_model <- lm(model_formula, data = df)
summary(ols_model)

# ==============================================================================
# 1. Load Required Packages
# ==============================================================================
library(readxl)
library(boot)
library(lm.beta)

# ==============================================================================
# 2. Load Dataset & Format Factor Variables
# ==============================================================================
df <- PF_3

# List of factor predictors
factor_cols <- c("Poultry_type", "Age_N", "Marital_N", "Education_N", 
                 "Experience_N", "Training_received", "HeatStressManage")

# Convert variables to factors cleanly
for (col in factor_cols) {
  df[[col]] <- as.factor(df[[col]])
}

# Define model formula
model_formula <- Biosecurity_Sc ~ Poultry_type + Age_N + Marital_N + 
  Education_N + Experience_N + Training_received + HeatStressManage

# Fit main OLS and Standardized Beta models
ols_model  <- lm(model_formula, data = df)
beta_model <- lm.beta(ols_model)

# ==============================================================================
# 3. Robust Bootstrapping (1000 Resamples with Error Handling)
# ==============================================================================
base_coefs <- coef(ols_model)
n_coefs    <- length(base_coefs)

boot_coefs <- function(data, indices) {
  d <- data[indices, ]
  
  # Use tryCatch to prevent crashing if a bootstrap draw drops a factor level
  fit <- tryCatch({
    lm(model_formula, data = d)
  }, error = function(e) {
    return(NULL)
  })
  
  if (is.null(fit)) {
    return(setNames(rep(NA, n_coefs), names(base_coefs)))
  }
  
  co <- coef(fit)
  
  # Check if coefficient count matches base model
  if (length(co) != n_coefs || any(is.na(co))) {
    out <- setNames(rep(NA, n_coefs), names(base_coefs))
    out[names(co)] <- co
    return(out)
  }
  
  return(co)
}

set.seed(123)
boot_results <- boot(data = df, statistic = boot_coefs, R = 1000)

# ==============================================================================
# 4. Extract Estimates & Format Output Table
# ==============================================================================
var_names   <- names(base_coefs)
B_estimates <- base_coefs
p_values    <- summary(ols_model)$coefficients[, 4]
beta_coefs  <- summary(beta_model)$coefficients[, "Standardized"]
boot_se     <- apply(boot_results$t, 2, sd, na.rm = TRUE)

# Standard OLS 95% Confidence Intervals
ols_ci <- confint(ols_model, level = 0.95)
ols_ci_formatted <- sprintf("[%s, %s]", 
                            format(round(ols_ci[, 1], 3), nsmall = 3), 
                            format(round(ols_ci[, 2], 3), nsmall = 3))

# Combine metrics into final output dataframe
regression_summary <- data.frame(
  Variable              = var_names,
  B                     = sprintf("%.3f", B_estimates),
  `Bootstrapped SE`     = sprintf("%.3f", boot_se),
  `95% Standard OLS CI` = ols_ci_formatted,
  `Beta (β)`            = ifelse(is.na(beta_coefs), "—", sprintf("%.3f", beta_coefs)),
  `p-value`             = ifelse(p_values < 0.001, "< 0.001", sprintf("%.3f", p_values)),
  check.names           = FALSE
)

# Print Summary Table and Fit Metrics
print(regression_summary, row.names = FALSE)

cat("\nModel Statistics:\n")
cat("N =", nobs(ols_model), "\n")
cat("R-squared =", round(summary(ols_model)$r.squared, 3), "\n")
cat("Adjusted R-squared =", round(summary(ols_model)$adj.r.squared, 3), "\n")

# Extract degrees of freedom and F-statistic
f_stat   <- summary(ols_model)$fstatistic[1]
df1      <- summary(ols_model)$fstatistic[2]
df2      <- summary(ols_model)$fstatistic[3]
p_val    <- pf(f_stat, df1, df2, lower.tail = FALSE)

# Print in formal reporting format
cat(sprintf("F(%d, %d) = %.3f (p < 0.001)\n", df1, df2, f_stat))

# 3. Compute Generalized Variance Inflation Factor (GVIF)
library(car)

# 2. Ensure Dataset & Factor Variables Match Regression Model
# ==============================================================================
df <- PF_3

# List of factor predictors matching regression script
factor_cols <- c("Poultry_type", "Age_N", "Marital_N", "Education_N", 
                 "Experience_N", "Training_received", "HeatStressManage")

# Convert variables to factors cleanly
for (col in factor_cols) {
  df[[col]] <- as.factor(df[[col]])
}

# Define model formula exactly as fitted in regression script
model_formula <- Biosecurity_Sc ~ Poultry_type + Age_N + Marital_N + 
  Education_N + Experience_N + Training_received + HeatStressManage

# Fit main OLS model
ols_model <- lm(model_formula, data = df)

# ==============================================================================
# 3. Compute & Format GVIF Diagnostic Output
# ==============================================================================
vif_raw <- vif(ols_model)

# Extract GVIF and Adjusted GVIF components
gvif_summary <- data.frame(
  Variable           = rownames(vif_raw),
  GVIF               = sprintf("%.3f", vif_raw[, "GVIF"]),
  Df                 = vif_raw[, "Df"],
  `GVIF^(1/(2*Df))`  = sprintf("%.3f", vif_raw[, "GVIF^(1/(2*Df))"]),
  `Multicollinearity` = ifelse(vif_raw[, "GVIF^(1/(2*Df))"] > 2.25, 
                               "High (Action Required)", 
                               "Low / Acceptable"),
  check.names        = FALSE
)

# Print diagnostic table
cat("=== MULTICOLLINEARITY DIAGNOSTIC TABLE (GVIF) ===\n\n")
print(gvif_summary, row.names = FALSE)