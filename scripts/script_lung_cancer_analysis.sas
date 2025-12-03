/* ========================================================================== */
/* PROJECT: LUNG CANCER SURVIVAL ANALYSIS                                     */
/* DESCRIPTION: Data import, cleaning, Kaplan-Meier & Cox Regression.         */
/* ========================================================================== */

/* -------------------------------------------------------------------------- */
/* 1. DATA IMPORT                                                             */
/* Import the CSV file from the server directory into SAS work library        */
/* -------------------------------------------------------------------------- */
proc import datafile="/home/u64397623/lung_cancer.csv" 
    out=work.lung_cancer      /* Naming the output dataset 'lung_cancer' */
    dbms=csv 
    replace;
    getnames=yes;             /* Use the first row as variable names */
run;

/* -------------------------------------------------------------------------- */
/* 2. DATA QUALITY CHECK (QC)                                                 */
/* Verify data structure and variable types before analysis                   */
/* -------------------------------------------------------------------------- */

/* Print the first 10 observations to inspect the data */
proc print data=work.lung_cancer (obs=10);
run;

/* Check variable types (ensure 'Time' and 'Status' are numeric) */
proc contents data=work.lung_cancer;
run;

/* -------------------------------------------------------------------------- */
/* 3. KAPLAN-MEIER SURVIVAL ANALYSIS                                          */
/* Compare survival curves between groups (Males vs Females)                  */
/* -------------------------------------------------------------------------- */
proc lifetest data=work.lung_cancer plots=survival;
    /* Define Time variable and Censoring event (0 = Censored/Alive) */
    time Time * Status(0); 
    
    /* Stratify by Sex to visualize differences */
    strata Sex; 
run;

/* -------------------------------------------------------------------------- */
/* 4. COX PROPORTIONAL HAZARDS MODEL                                          */
/* Quantify the Hazard Ratio (Risk) and 95% Confidence Intervals              */
/* -------------------------------------------------------------------------- */
proc phreg data=work.lung_cancer;
    /* CLASS statement handles categorical variables.
       ref='1': Sets 'Male' (1) as the reference group for comparison */
    class Sex (ref='1'); 
    
    /* MODEL statement:
       /rl option requests 95% Risk Limits (Confidence Intervals) */
    model Time * Status(0) = Sex / rl; 
run;