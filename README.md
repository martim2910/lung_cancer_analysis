# Survival Analysis in SAS: Lung Cancer Study

## Project Overview
This project is a statistical analysis of survival data from patients with advanced lung cancer. The primary objective was to investigate the prognostic value of **Sex** on patient survival time using industry-standard methodologies.

**Context:** Developed as a self-directed learning project to master **SAS programming** and **Survival Analysis** techniques (Kaplan-Meier, Cox Regression) applied to Clinical Trials.

## Tech Stack & Methodology
* **Language:** SAS (SAS OnDemand for Academics)
* **Key Procedures:**
    * `PROC IMPORT`: Data ingestion and cleaning.
    * `PROC LIFETEST`: Kaplan-Meier estimation and Log-Rank testing.
    * `PROC PHREG`: Cox Proportional Hazards modeling for Hazard Ratio estimation.
* **Statistical Concepts:** Right-censoring, Stratification, Hypothesis Testing, 95% Confidence Intervals.

## Key Findings

### 1. Survival Probability (Kaplan-Meier)
The analysis compared survival times between **Males (Stratum 1)** and **Females (Stratum 2)**.
* **Observation:** The survival curve for females remains consistently higher than males over the 1000-day follow-up period.
* **Median Survival:**
    * Females: **426 days**
    * Males: **270 days**
* **Log-Rank Test:** The difference is statistically significant (p-value = **0.0013**).

<img width="482" height="356" alt="Kaplan-Meier Lung Cancer Graphic" src="https://github.com/user-attachments/assets/f858a07c-3818-4dd1-94d5-8d73208cfc2a" />



### 2. Risk Quantification (Cox Regression)
A Cox Proportional Hazards model was fitted to quantify the impact of sex on the hazard rate.
* **Hazard Ratio (HR):** **0.588**
* **95% CI:** [0.424 – 0.817]
* **Conclusion:** Female patients demonstrated a **41.2% reduction in the risk of death** compared to male patients (p=0.0015). The confidence interval does not cross 1.0, confirming the robustness of the result.

<img width="942" height="129" alt="image" src="https://github.com/user-attachments/assets/69372859-00d0-4a28-a6bd-7389198be564" />


##  Code Structure
The analysis follows the standard SAS procedural workflow:

```sas
/* 1. Kaplan-Meier Analysis */
proc lifetest data=work.lung_cancer plots=survival;
   time Time * Status(0); 
   strata Sex; 
run;

/* 2. Cox Proportional Hazards Model */
proc phreg data=work.lung_cancer;
   class Sex (ref='1'); /* Reference: Male */
   model Time * Status(0) = Sex / rl; 
run;
```

##  Motivation
Although my academic background is heavily focused on **R** and Statistical Theory, I recognized that **SAS** is the standard for regulatory submissions in the Pharmaceutical Industry. I undertook this project to:
1.  Bridge the gap in my undergraduate curriculum regarding Clinical Biostatistics.
2.  Demonstrate the ability to adapt to new syntax and environments (`DATA steps`, `PROCs`) independently.

---
*Author: Martim Luzio*
*License: MIT*
