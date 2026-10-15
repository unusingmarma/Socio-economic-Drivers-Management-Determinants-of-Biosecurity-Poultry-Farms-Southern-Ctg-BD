* Encoding: UTF-8.
SET TLook=None Small=0.0001 SUMMARY=None THREADS=AUTO TFit=Both DIGITGROUPING=No LEADZERO=No TABLERENDER=light. 
* Custom Tables. 
CTABLES 
  /VLABELS VARIABLES=Poultry_type Age_N Sex_N Marital_N Education_N Job_N_N Experience_N 
    Training_received FarmLoc FlrTyp_N LttrMaterial Roof RoofT_N FeedTyp FeedSupplyFr HeatStressManage 
    SellingChannel Biosecurity_Sc 
    DISPLAY=NAME 
  /TABLE Poultry_type + Age_N + Sex_N + Marital_N + Education_N + Job_N_N + Experience_N + 
    Training_received + FarmLoc + FlrTyp_N + LttrMaterial + Roof + RoofT_N + FeedTyp + FeedSupplyFr + 
    HeatStressManage + SellingChannel BY Biosecurity_Sc [COUNT F40.0, MEAN, STDDEV] 
  /CATEGORIES VARIABLES=Poultry_type Age_N Sex_N Marital_N Education_N Job_N_N Experience_N 
    Training_received FarmLoc FlrTyp_N LttrMaterial Roof FeedTyp FeedSupplyFr HeatStressManage 
    SellingChannel ORDER=A KEY=VALUE EMPTY=INCLUDE 
  /CATEGORIES VARIABLES=RoofT_N ORDER=A KEY=VALUE EMPTY=EXCLUDE 
  /CRITERIA CILEVEL=95.

SET TLook=None Small=0.0001 SUMMARY=None THREADS=AUTO Printback=On TFit=Both DIGITGROUPING=No LEADZERO=No TABLERENDER=light.  
EXAMINE VARIABLES=Biosecurity_Sc 
  /PLOT BOXPLOT STEMLEAF HISTOGRAM NPPLOT 
  /COMPARE GROUPS 
  /STATISTICS DESCRIPTIVES 
  /CINTERVAL 95 
  /MISSING LISTWISE 
  /NOTOTAL.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (Poultry_type) KRUSKAL_WALLIS(COMPARE=PAIRWISE) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (Age_N) KRUSKAL_WALLIS(COMPARE=PAIRWISE) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (Sex_N) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (Marital_N) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (Education_N) KRUSKAL_WALLIS(COMPARE=PAIRWISE) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (Job_N_N) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (Experience_N) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (Training_received) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (FarmLoc) KRUSKAL_WALLIS(COMPARE=PAIRWISE) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (FlrTyp_N) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (LttrMaterial) KRUSKAL_WALLIS(COMPARE=PAIRWISE) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (Roof) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (RoofT_N) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (FeedTyp) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (FeedSupplyFr) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (HeatStressManage) KRUSKAL_WALLIS(COMPARE=PAIRWISE) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (Biosecurity_Sc) GROUP (SellingChannel) KRUSKAL_WALLIS(COMPARE=PAIRWISE) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE 
  /CRITERIA ALPHA=0.05  CILEVEL=95.

CROSSTABS 
  /TABLES=K_Antibiotic K_AMR K_AMRLearning P_RxProvider P_AntibioticProvidingPoultry P_Dosemaintain 
    P_WPMaintain BY Poultry_type 
  /FORMAT=AVALUE TABLES 
  /STATISTICS=CHISQ 
  /CELLS=COUNT 
  /COUNT ROUND CELL.



DATASET ACTIVATE DataSet1.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Poultry_type Age_N Sex_N Marital_N Education_N Job_N_N Experience_N 
    Training_received FarmLoc FlrTyp_N LttrMaterial Roof RoofT_N FeedTyp FeedSupplyFr HeatStressManage 
    SellingChannel Biosecurity_Sc 
    DISPLAY=NAME
  /TABLE Poultry_type [C] + Age_N [C] + Sex_N [C] + Marital_N [C] + Education_N [C] + Job_N_N [C] + 
    Experience_N [C] + Training_received [C] + FarmLoc [C] + FlrTyp_N [C] + LttrMaterial [C] + Roof [C] 
    + RoofT_N [C] + FeedTyp [C] + FeedSupplyFr [C] + HeatStressManage [C] + SellingChannel [C] BY 
    Biosecurity_Sc [S][COUNT F40.0, MEAN, STDDEV]
  /CATEGORIES VARIABLES=Poultry_type Age_N Sex_N Marital_N Education_N Job_N_N Experience_N 
    Training_received FarmLoc FlrTyp_N LttrMaterial Roof FeedTyp FeedSupplyFr HeatStressManage 
    SellingChannel ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=RoofT_N ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95.

DATASET ACTIVATE DataSet1. 
 
SAVE OUTFILE='C:\Users\User\Desktop\Poultry Farm Survey Paper\Dataset\20250806_Data '+ 
    'analysis_Mehedi_UM.sav' 
  /COMPRESSED. 
* Custom Tables. 
CTABLES 
  /VLABELS VARIABLES=Challenge_DOCPrice Challenge_FeedPrice Challenge_ManagementCost 
    Challenge_UnstableMarket Challenge_DiseasePersist Challenge_NoTraining Challenge_LessTechSupp 
    Challenge_Middleman Challenge_HeatMismanagement Challenge_Capital 
    DISPLAY=NAME 
  /TABLE Challenge_DOCPrice [COUNT F40.0] + Challenge_FeedPrice [COUNT F40.0] + 
    Challenge_ManagementCost [COUNT F40.0] + Challenge_UnstableMarket [COUNT F40.0] + 
    Challenge_DiseasePersist [COUNT F40.0] + Challenge_NoTraining [COUNT F40.0] + 
    Challenge_LessTechSupp [COUNT F40.0] + Challenge_Middleman [COUNT F40.0] + 
    Challenge_HeatMismanagement [COUNT F40.0] + Challenge_Capital [COUNT F40.0] 
  /CATEGORIES VARIABLES=Challenge_DOCPrice Challenge_FeedPrice Challenge_ManagementCost 
    Challenge_UnstableMarket Challenge_DiseasePersist Challenge_NoTraining Challenge_LessTechSupp 
    Challenge_Middleman Challenge_HeatMismanagement Challenge_Capital ORDER=A KEY=VALUE EMPTY=INCLUDE 
  /CRITERIA CILEVEL=95.

* Custom Tables. 
CTABLES 
  /VLABELS VARIABLES=Challenge_DOCPrice Challenge_FeedPrice Challenge_ManagementCost 
    Challenge_UnstableMarket Challenge_DiseasePersist Challenge_NoTraining Challenge_LessTechSupp 
    Challenge_Middleman Challenge_HeatMismanagement Challenge_Capital Poultry_type 
    DISPLAY=NAME 
  /TABLE Challenge_DOCPrice [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + Challenge_FeedPrice [C][COUNT 
    F40.0, COLPCT.COUNT PCT40.1] + Challenge_ManagementCost [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    Challenge_UnstableMarket [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + Challenge_DiseasePersist 
    [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + Challenge_NoTraining [C][COUNT F40.0, COLPCT.COUNT 
    PCT40.1] + Challenge_LessTechSupp [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + Challenge_Middleman 
    [C][COUNT F40.0, COLPCT.COUNT PCT40.1] + Challenge_HeatMismanagement [C][COUNT F40.0, COLPCT.COUNT 
    PCT40.1] + Challenge_Capital [C][COUNT F40.0, COLPCT.COUNT PCT40.1] BY Poultry_type [C] 
  /CATEGORIES VARIABLES=Challenge_DOCPrice Challenge_FeedPrice Challenge_ManagementCost 
    Challenge_UnstableMarket Challenge_DiseasePersist Challenge_NoTraining Challenge_LessTechSupp 
    Challenge_Middleman Challenge_HeatMismanagement Challenge_Capital Poultry_type ORDER=A KEY=VALUE 
    EMPTY=INCLUDE 
  /CRITERIA CILEVEL=95.
