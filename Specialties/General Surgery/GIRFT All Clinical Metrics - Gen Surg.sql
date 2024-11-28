/*
	
	Script Title: GIRFT All Clinical Metrics - General Surgery
	Author: Adam Ross
	Version: 1.0
	Description: This script generates the figures for the All Clinical metrics section 
	of the Model Hospital dashboard. It covers the following Classes:

	- Appendicitis and appendicectomy
	- Cholecystitis, pancreatitis and emergency cholecystectomy
	- Elective cholecystectomy
	- Oesophago-gastric cancer
	- Colorectal cancer
	- Rectal cancer
	- Liver resection for cancer
	- Bariatric surgery (Not required)
	- Anti-reflux surgery (Not required)
	- Incisional hernia repair
	- Inguinal hernia repair
	- Emergency laparotomy
	- Diverticulitis
	- Crohn's disease
	- Ulcerative colitis (Not required)
	- Bowel obstruction
	- Large bowel obstruction
	- Small bowel obstruction
	- Undifferentiated abdominal or pelvic pain
	- Other general surgery

*/

-- SQL Code Begins

-- ========================================
-- Step 1: Drop Temporary Tables if They Exist
-- ========================================

IF OBJECT_ID('tempdb..#Spells_With_Variables') IS NOT NULL
    DROP TABLE #Spells_With_Variables;

IF OBJECT_ID('tempdb..#CodeGroup_Other') IS NOT NULL
    DROP TABLE #CodeGroup_Other;

IF OBJECT_ID('tempdb..#CodeGroup_AbdominalPain_4') IS NOT NULL
    DROP TABLE #CodeGroup_AbdominalPain_4;

IF OBJECT_ID('tempdb..#CodeGroup_AbdominalPain_4_1') IS NOT NULL
    DROP TABLE #CodeGroup_AbdominalPain_4_1;

IF OBJECT_ID('tempdb..#CodeGroup_Appendicitis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Appendicitis_3;

IF OBJECT_ID('tempdb..#CodeGroup_AdverseIncidentGenS_3') IS NOT NULL
    DROP TABLE #CodeGroup_AdverseIncidentGenS_3;

IF OBJECT_ID('tempdb..#CodeGroup_BenignLiverCancer_4') IS NOT NULL
    DROP TABLE #CodeGroup_BenignLiverCancer_4;

IF OBJECT_ID('tempdb..#CodeGroup_BiliaryColic_4') IS NOT NULL
    DROP TABLE #CodeGroup_BiliaryColic_4;

IF OBJECT_ID('tempdb..#CodeGroup_BowelObstruct_4') IS NOT NULL
    DROP TABLE #CodeGroup_BowelObstruct_4;

IF OBJECT_ID('tempdb..#CodeGroup_LaparoscopicCholecystectomy_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_LaparoscopicCholecystectomy_3_4;

IF OBJECT_ID('tempdb..#CodeGroup_ColorectalCancer_3_1') IS NOT NULL
    DROP TABLE #CodeGroup_ColorectalCancer_3_1;

IF OBJECT_ID('tempdb..#CodeGroup_ColorectalCancer_3_2') IS NOT NULL
    DROP TABLE #CodeGroup_ColorectalCancer_3_2;

IF OBJECT_ID('tempdb..#CodeGroup_ColorectalCancer_3_3') IS NOT NULL
    DROP TABLE #CodeGroup_ColorectalCancer_3_3;

IF OBJECT_ID('tempdb..#CodeGroup_ColorectalCancer_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_ColorectalCancer_3_4;

IF OBJECT_ID('tempdb..#CodeGroup_ComplicationGenS_3') IS NOT NULL
    DROP TABLE #CodeGroup_ComplicationGenS_3;

IF OBJECT_ID('tempdb..#CodeGroup_ComplicationGenS_4') IS NOT NULL
    DROP TABLE #CodeGroup_ComplicationGenS_4;

IF OBJECT_ID('tempdb..#CodeGroup_Diag_code_1') IS NOT NULL
    DROP TABLE #CodeGroup_Diag_code_1;

IF OBJECT_ID('tempdb..#CodeGroup_Diag_code_3') IS NOT NULL
    DROP TABLE #CodeGroup_Diag_code_3;

IF OBJECT_ID('tempdb..#CodeGroup_Diag_code_4') IS NOT NULL
    DROP TABLE #CodeGroup_Diag_code_4;

IF OBJECT_ID('tempdb..#CodeGroup_Diverticulitis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Diverticulitis_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICD_1') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICD_1;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICD_2') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICD_2;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICD_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICD_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICD_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICD_4;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICDAll_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICDAll_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapInICD_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapInICD_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapStomaConditions_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapStomaConditions_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapStomaConditions_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapStomaConditions_4;

IF OBJECT_ID('tempdb..#CodeGroup_FemoralHernia_3') IS NOT NULL
    DROP TABLE #CodeGroup_FemoralHernia_3;

IF OBJECT_ID('tempdb..#CodeGroup_HiatusHernia_3') IS NOT NULL
    DROP TABLE #CodeGroup_HiatusHernia_3;

IF OBJECT_ID('tempdb..#CodeGroup_HospitalAcqCond_3') IS NOT NULL
    DROP TABLE #CodeGroup_HospitalAcqCond_3;

IF OBJECT_ID('tempdb..#CodeGroup_GallStones_3') IS NOT NULL
    DROP TABLE #CodeGroup_GallStones_3;

IF OBJECT_ID('tempdb..#CodeGroup_Pancreatitis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Pancreatitis_3;

IF OBJECT_ID('tempdb..#CodeGroup_Pancreatitis_4') IS NOT NULL
    DROP TABLE #CodeGroup_Pancreatitis_4;

IF OBJECT_ID('tempdb..#CodeGroup_PerianalAbcess_3') IS NOT NULL
    DROP TABLE #CodeGroup_PerianalAbcess_3;

IF OBJECT_ID('tempdb..#CodeGroup_SmallIntestineCancer_3') IS NOT NULL
    DROP TABLE #CodeGroup_SmallIntestineCancer_3;

IF OBJECT_ID('tempdb..#CodeGroup_UnlikelyNonSpec_3') IS NOT NULL
    DROP TABLE #CodeGroup_UnlikelyNonSpec_3;

IF OBJECT_ID('tempdb..#CodeGroup_UnlikelyNonSpec_4') IS NOT NULL
    DROP TABLE #CodeGroup_UnlikelyNonSpec_4;

IF OBJECT_ID('tempdb..#CodeGroup_Abdominal_Organ_1') IS NOT NULL
    DROP TABLE #CodeGroup_Abdominal_Organ_1;

IF OBJECT_ID('tempdb..#CodeGroup_Abdominal_Organ_3') IS NOT NULL
    DROP TABLE #CodeGroup_Abdominal_Organ_3;

IF OBJECT_ID('tempdb..#CodeGroup_Abdominal_Organ_Specific_3') IS NOT NULL
    DROP TABLE #CodeGroup_Abdominal_Organ_Specific_3;

IF OBJECT_ID('tempdb..#CodeGroup_AnastomosisColon_4') IS NOT NULL
    DROP TABLE #CodeGroup_AnastomosisColon_4;

IF OBJECT_ID('tempdb..#CodeGroup_App_AbdomenOther_3') IS NOT NULL
    DROP TABLE #CodeGroup_App_AbdomenOther_3;

IF OBJECT_ID('tempdb..#CodeGroup_App_AbdomenOther_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_AbdomenOther_4;

IF OBJECT_ID('tempdb..#CodeGroup_App_ConversionOpen_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_ConversionOpen_4;

IF OBJECT_ID('tempdb..#CodeGroup_App_EndoOtherBodyCavity_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_EndoOtherBodyCavity_4;

IF OBJECT_ID('tempdb..#CodeGroup_App_LapApproach_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_LapApproach_4;

IF OBJECT_ID('tempdb..#CodeGroup_App_Laparotomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_Laparotomy_4;

IF OBJECT_ID('tempdb..#CodeGroup_App_LapAssist_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_LapAssist_4;

IF OBJECT_ID('tempdb..#CodeGroup_App_MinimalAccess_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_MinimalAccess_4;

IF OBJECT_ID('tempdb..#CodeGroup_App_Robotic_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_Robotic_4;

IF OBJECT_ID('tempdb..#CodeGroup_App_Bilateral_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_Bilateral_4;

IF OBJECT_ID('tempdb..#CodeGroup_Append_3') IS NOT NULL
    DROP TABLE #CodeGroup_Append_3;

IF OBJECT_ID('tempdb..#CodeGroup_Chemotherapy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Chemotherapy_3;

IF OBJECT_ID('tempdb..#CodeGroup_LaparoscopicCholecystectomy_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_LaparoscopicCholecystectomy_2_4;

IF OBJECT_ID('tempdb..#CodeGroup_ColonicStent_4') IS NOT NULL
    DROP TABLE #CodeGroup_ColonicStent_4;

IF OBJECT_ID('tempdb..#CodeGroup_DefEMLap_4') IS NOT NULL
    DROP TABLE #CodeGroup_DefEMLap_4;

IF OBJECT_ID('tempdb..#CodeGroup_EMLap_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLap_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLap_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLap_4;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapExOPTFC_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExOPTFC_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapExOPTFC_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExOPTFC_4;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapFollow_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapFollow_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapFollow_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapFollow_4;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapHernia_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapHernia_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapHernia_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapHernia_4;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapHerniaProcs_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapHerniaProcs_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapHerniaProcs_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapHerniaProcs_4;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapIncisional_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapIncisional_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapIncisional_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapIncisional_4;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapStoma_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapStoma_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapStoma_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapStoma_4;

IF OBJECT_ID('tempdb..#CodeGroup_ExenterationPelvis_4') IS NOT NULL
    DROP TABLE #CodeGroup_ExenterationPelvis_4;

IF OBJECT_ID('tempdb..#CodeGroup_Gastrointestinal_1') IS NOT NULL
    DROP TABLE #CodeGroup_Gastrointestinal_1;

IF OBJECT_ID('tempdb..#CodeGroup_Gastrointestinal_Specific_3') IS NOT NULL
    DROP TABLE #CodeGroup_Gastrointestinal_Specific_3;

IF OBJECT_ID('tempdb..#CodeGroup_IleocaecalResection_4') IS NOT NULL
    DROP TABLE #CodeGroup_IleocaecalResection_4;

IF OBJECT_ID('tempdb..#CodeGroup_IleorectalAnastom_4') IS NOT NULL
    DROP TABLE #CodeGroup_IleorectalAnastom_4;

IF OBJECT_ID('tempdb..#CodeGroup_LeftHemicolectomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_LeftHemicolectomy_3;

IF OBJECT_ID('tempdb..#CodeGroup_LocalExcColorectCancer_3') IS NOT NULL
    DROP TABLE #CodeGroup_LocalExcColorectCancer_3;

IF OBJECT_ID('tempdb..#CodeGroup_LocalExcColorectCancer_4') IS NOT NULL
    DROP TABLE #CodeGroup_LocalExcColorectCancer_4;

IF OBJECT_ID('tempdb..#CodeGroup_NerveStimPelvicFloor_4') IS NOT NULL
    DROP TABLE #CodeGroup_NerveStimPelvicFloor_4;

IF OBJECT_ID('tempdb..#CodeGroup_ImagingTestsDrugsTherapy_2') IS NOT NULL
    DROP TABLE #CodeGroup_ImagingTestsDrugsTherapy_2;

IF OBJECT_ID('tempdb..#CodeGroup_NoProc_1_1') IS NOT NULL
    DROP TABLE #CodeGroup_NoProc_1_1;

IF OBJECT_ID('tempdb..#CodeGroup_NoProc_1_2') IS NOT NULL
    DROP TABLE #CodeGroup_NoProc_1_2;

IF OBJECT_ID('tempdb..#CodeGroup_OtherColonExcision_3') IS NOT NULL
    DROP TABLE #CodeGroup_OtherColonExcision_3;

IF OBJECT_ID('tempdb..#CodeGroup_PelvicFloor_4') IS NOT NULL
    DROP TABLE #CodeGroup_PelvicFloor_4;

IF OBJECT_ID('tempdb..#CodeGroup_PeranalSurgery_4') IS NOT NULL
    DROP TABLE #CodeGroup_PeranalSurgery_4;

IF OBJECT_ID('tempdb..#CodeGroup_PerianalProcCrohnDisease_4') IS NOT NULL
    DROP TABLE #CodeGroup_PerianalProcCrohnDisease_4;

IF OBJECT_ID('tempdb..#CodeGroup_Proc_code_1') IS NOT NULL
    DROP TABLE #CodeGroup_Proc_code_1;

IF OBJECT_ID('tempdb..#CodeGroup_Proc_code_3') IS NOT NULL
    DROP TABLE #CodeGroup_Proc_code_3;

IF OBJECT_ID('tempdb..#CodeGroup_Proc_code_4') IS NOT NULL
    DROP TABLE #CodeGroup_Proc_code_4;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForDefEMLaparoscopy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForDefEMLaparoscopy_3;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForDefEMLaparoscopy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForDefEMLaparoscopy_4;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForDefEMLaparotomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForDefEMLaparotomy_3;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForDefEMLaparotomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForDefEMLaparotomy_4;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForEMLaparotomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForEMLaparotomy_3;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForEMLaparotomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForEMLaparotomy_4;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForNonDefEMLaparoscopy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForNonDefEMLaparoscopy_3;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForNonDefEMLaparoscopy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForNonDefEMLaparoscopy_4;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForNonDefEMLaparotomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForNonDefEMLaparotomy_3;

IF OBJECT_ID('tempdb..#CodeGroup_ProcForNonDefEMLaparotomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForNonDefEMLaparotomy_4;

IF OBJECT_ID('tempdb..#CodeGroup_ProcLargeBowelObstruct_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcLargeBowelObstruct_3;

IF OBJECT_ID('tempdb..#CodeGroup_ProcLargeBowelObstruct_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcLargeBowelObstruct_4;

IF OBJECT_ID('tempdb..#CodeGroup_ProcPerianalAbcess_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcPerianalAbcess_4;

IF OBJECT_ID('tempdb..#CodeGroup_ProcSmallBowelObstruct_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcSmallBowelObstruct_3;

IF OBJECT_ID('tempdb..#CodeGroup_ProcSmallBowelObstruct_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcSmallBowelObstruct_4;

IF OBJECT_ID('tempdb..#CodeGroup_ProcUlcerColitis_4_1') IS NOT NULL
    DROP TABLE #CodeGroup_ProcUlcerColitis_4_1;

IF OBJECT_ID('tempdb..#CodeGroup_ProcUlcerColitis_4_2') IS NOT NULL
    DROP TABLE #CodeGroup_ProcUlcerColitis_4_2;

IF OBJECT_ID('tempdb..#CodeGroup_Radiotherapy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Radiotherapy_3;

IF OBJECT_ID('tempdb..#CodeGroup_RectalExcision_3') IS NOT NULL
    DROP TABLE #CodeGroup_RectalExcision_3;

IF OBJECT_ID('tempdb..#CodeGroup_RectalSurgery_4') IS NOT NULL
    DROP TABLE #CodeGroup_RectalSurgery_4;

IF OBJECT_ID('tempdb..#CodeGroup_Rectopexy_4_1') IS NOT NULL
    DROP TABLE #CodeGroup_Rectopexy_4_1;

IF OBJECT_ID('tempdb..#CodeGroup_Rectopexy_4_2') IS NOT NULL
    DROP TABLE #CodeGroup_Rectopexy_4_2;

IF OBJECT_ID('tempdb..#CodeGroup_RectoVaginalFistula_4') IS NOT NULL
    DROP TABLE #CodeGroup_RectoVaginalFistula_4;

IF OBJECT_ID('tempdb..#CodeGroup_ResectionSmallBowel_3') IS NOT NULL
    DROP TABLE #CodeGroup_ResectionSmallBowel_3;

IF OBJECT_ID('tempdb..#CodeGroup_SigmoidColectomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_SigmoidColectomy_3;

IF OBJECT_ID('tempdb..#CodeGroup_StomaReversal_4') IS NOT NULL
    DROP TABLE #CodeGroup_StomaReversal_4;

IF OBJECT_ID('tempdb..#CodeGroup_Strictureplasty_4') IS NOT NULL
    DROP TABLE #CodeGroup_Strictureplasty_4;

IF OBJECT_ID('tempdb..#CodeGroup_SubTotalColonExcision_3') IS NOT NULL
    DROP TABLE #CodeGroup_SubTotalColonExcision_3;

IF OBJECT_ID('tempdb..#CodeGroup_EMLapExOPTFC') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExOPTFC;

IF OBJECT_ID('tempdb..#CodeGroup_MainSpec_1') IS NOT NULL
    DROP TABLE #CodeGroup_MainSpec_1;

IF OBJECT_ID('tempdb..#CodeGroup_TFC_Code_1') IS NOT NULL
    DROP TABLE #CodeGroup_TFC_Code_1;

IF OBJECT_ID('tempdb..#CodeGroup_CancelClinical_4') IS NOT NULL
    DROP TABLE #CodeGroup_CancelClinical_4;

IF OBJECT_ID('tempdb..#CodeGroup_CancelNonClinical_4') IS NOT NULL
    DROP TABLE #CodeGroup_CancelNonClinical_4;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Ulcerative_colitis') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Ulcerative_colitis;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Stoma_creation') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Stoma_creation;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Anti_reflux') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Anti_reflux;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Hartmanns') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Hartmanns;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Obesity') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Obesity;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Crohns_disease') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Crohns_disease;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Lateral_branch_of_abdominal_aorta') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Lateral_branch_of_abdominal_aorta;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Incisional_hernia_repair') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Incisional_hernia_repair;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Haemorrhoids') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Haemorrhoids;

IF OBJECT_ID('tempdb..#CodeGroup_POD_EM') IS NOT NULL
    DROP TABLE #CodeGroup_POD_EM;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Proctocolectomy_with_ileo_anal_pouch') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Proctocolectomy_with_ileo_anal_pouch;

IF OBJECT_ID('tempdb..#CodeGroup_Cholecystitis_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cholecystitis_4;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Proctocolectomy_with_ileostomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Proctocolectomy_with_ileostomy;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Colectomy_and_ileo_rectal_anastomosis') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Colectomy_and_ileo_rectal_anastomosis;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Right_hemicolectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Right_hemicolectomy;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Extended_right_hemicolectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Extended_right_hemicolectomy;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Transverse_colectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Transverse_colectomy;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Subtotal_colectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Subtotal_colectomy;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Ventral_hernia_repair') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Ventral_hernia_repair;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Incisional_hernia') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Incisional_hernia;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Cholecystectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Cholecystectomy;

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Cancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Cancer;

-- ========================================
-- Step 2: Variable Declarations
-- ========================================

DECLARE @QuarterEndDate DATE = '2024-06-30'; -- Adjust as needed
DECLARE @MonthsBack INT = 12;

-- Corrected Calculation for MetricStartDate (First day of the month 12 months prior)
DECLARE @MetricStartDate DATE = DATEADD(YEAR, -1, DATEADD(DAY, 1, EOMONTH(@QuarterEndDate)));

-- Define the start and end dates for Metric GS7100
DECLARE @GS7100_StartDate DATE = '2024-06-01';
DECLARE @GS7100_EndDate DATE = '2024-06-30';

-- Define the start and end dates for Metric GS7105
DECLARE @GS7105_StartDate DATE = '2024-06-01';
DECLARE @GS7105_EndDate DATE = '2024-06-30';

-- Define the start and end dates for Metric GS7124
DECLARE @GS7124_StartDate DATE = '2023-03-01';
DECLARE @GS7124_EndDate DATE = '2024-03-31';

/* Dates for Q1 2024/25 (July 1, 2023 to June 30, 2024) */
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

/* Dates for Q4 2023/24 (April 1, 2023 to March 31, 2024) */
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

/* Dates for Q4 2018/19 (April 1, 2018 to March 31, 2019) */
DECLARE @Q4_2018_19_StartDate DATE = '2018-04-01';
DECLARE @Q4_2018_19_EndDate DATE = '2019-03-31';

/* Date for June 2021 */
DECLARE @June_2021_StartDate DATE = '2021-06-01';
DECLARE @June_2021_EndDate DATE = '2021-06-30';

-- Determine the earliest Admission_Date needed for all metrics
DECLARE @OverallStartDate DATE =
        (
            SELECT MIN(dt)
            FROM
            (
                VALUES
                    (@MetricStartDate),
                    (@GS7100_StartDate),
                    (@GS7124_StartDate),
                    (@Q1_2024_25_StartDate),
                    (@Q4_2023_24_StartDate),
					(@Q4_2018_19_StartDate),
					(@June_2021_StartDate)
            ) AS Dates (dt)
        );

-- Determine the latest Admission_Date needed for all metrics
DECLARE @OverallEndDate DATE =
        (
            SELECT MAX(dt)
            FROM
            (
                VALUES
                    (@QuarterEndDate),
                    (@GS7100_EndDate),
                    (@GS7124_EndDate),
                    (@Q1_2024_25_EndDate),
                    (@Q4_2023_24_EndDate),
					(@Q4_2018_19_EndDate),
					(@June_2021_EndDate)
            ) AS Dates (dt)
        );

-- ========================================
-- Step 3: Create and Populate Temporary Tables
-- ========================================

/* -----------------------
   Code Group: Other
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Other') IS NOT NULL
    DROP TABLE #CodeGroup_Other;

CREATE TABLE #CodeGroup_Other
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Other
(
    Code
)
VALUES
('Other');



/* -----------------------
   Code Group: AbdominalPain_4 (ICD10 Codes)
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_AbdominalPain_4') IS NOT NULL
    DROP TABLE #CodeGroup_AbdominalPain_4;

CREATE TABLE #CodeGroup_AbdominalPain_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AbdominalPain_4
(
    Code
)
VALUES
('R104'),
('R100'),
('R101'),
('R102'),
('R103');



/* -----------------------
   Code Group: AbdominalPain_4_1
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_AbdominalPain_4_1') IS NOT NULL
    DROP TABLE #CodeGroup_AbdominalPain_4_1;

CREATE TABLE #CodeGroup_AbdominalPain_4_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AbdominalPain_4_1
(
    Code
)
VALUES
('R104');



/* -----------------------
   Code Group: Appendicitis_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Appendicitis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Appendicitis_3;

CREATE TABLE #CodeGroup_Appendicitis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Appendicitis_3
(
    Code
)
VALUES
('K35'),
('K36'),
('K37');



/* -----------------------
   Code Group: AdverseIncidentGenS_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_AdverseIncidentGenS_3') IS NOT NULL
    DROP TABLE #CodeGroup_AdverseIncidentGenS_3;

CREATE TABLE #CodeGroup_AdverseIncidentGenS_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AdverseIncidentGenS_3
(
    Code
)
VALUES
('Y70'),
('Y73'),
('Y74'),
('Y78'),
('Y80'),
('Y81'),
('Y82'),
('Y83'),
('Y84'),
('Y88');



/* -----------------------
   Code Group: BenignLiverCancer_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_BenignLiverCancer_4') IS NOT NULL
    DROP TABLE #CodeGroup_BenignLiverCancer_4;

CREATE TABLE #CodeGroup_BenignLiverCancer_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_BenignLiverCancer_4
(
    Code
)
VALUES
('D134');



/* -----------------------
   Code Group: BiliaryColic_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_BiliaryColic_4') IS NOT NULL
    DROP TABLE #CodeGroup_BiliaryColic_4;

CREATE TABLE #CodeGroup_BiliaryColic_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_BiliaryColic_4
(
    Code
)
VALUES
('K805');



/* -----------------------
   Code Group: BowelObstruct_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_BowelObstruct_4') IS NOT NULL
    DROP TABLE #CodeGroup_BowelObstruct_4;

CREATE TABLE #CodeGroup_BowelObstruct_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_BowelObstruct_4
(
    Code
)
VALUES
('K561'),
('K562'),
('K565'),
('K566'),
('K315');



/* -----------------------
   Code Group: LaparoscopicCholecystectomy_3_4 (OPCS Codes)
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_LaparoscopicCholecystectomy_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_LaparoscopicCholecystectomy_3_4;

CREATE TABLE #CodeGroup_LaparoscopicCholecystectomy_3_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_LaparoscopicCholecystectomy_3_4
(
    Code
)
VALUES
('J182');



/* -----------------------
   Code Group: ColorectalCancer_3_1
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ColorectalCancer_3_1') IS NOT NULL
    DROP TABLE #CodeGroup_ColorectalCancer_3_1;

CREATE TABLE #CodeGroup_ColorectalCancer_3_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ColorectalCancer_3_1
(
    Code
)
VALUES
('C21');



/* -----------------------
   Code Group: ColorectalCancer_3_2
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ColorectalCancer_3_2') IS NOT NULL
    DROP TABLE #CodeGroup_ColorectalCancer_3_2;

CREATE TABLE #CodeGroup_ColorectalCancer_3_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ColorectalCancer_3_2
(
    Code
)
VALUES
('C18');



/* -----------------------
   Code Group: ColorectalCancer_3_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ColorectalCancer_3_3') IS NOT NULL
    DROP TABLE #CodeGroup_ColorectalCancer_3_3;

CREATE TABLE #CodeGroup_ColorectalCancer_3_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ColorectalCancer_3_3
(
    Code
)
VALUES
('C20');



/* -----------------------
   Code Group: ColorectalCancer_3_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ColorectalCancer_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_ColorectalCancer_3_4;

CREATE TABLE #CodeGroup_ColorectalCancer_3_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ColorectalCancer_3_4
(
    Code
)
VALUES
('C19');



/* -----------------------
   Code Group: ComplicationGenS_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ComplicationGenS_3') IS NOT NULL
    DROP TABLE #CodeGroup_ComplicationGenS_3;

CREATE TABLE #CodeGroup_ComplicationGenS_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ComplicationGenS_3
(
    Code
)
VALUES
('K91'),
('T80'),
('T81'),
('T82'),
('T83'),
('T88'),
('Y60'),
('Y61'),
('Y62'),
('Y63'),
('Y64'),
('Y65'),
('Y66'),
('Y67'),
('Y68'),
('Y69'),
('Y70'),
('Y71'),
('Y72'),
('Y73'),
('Y74');



/* -----------------------
   Code Group: ComplicationGenS_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ComplicationGenS_4') IS NOT NULL
    DROP TABLE #CodeGroup_ComplicationGenS_4;

CREATE TABLE #CodeGroup_ComplicationGenS_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ComplicationGenS_4
(
    Code
)
VALUES
('T851'),
('T855');



/* -----------------------
   Code Group: Diag_code_1
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Diag_code_1') IS NOT NULL
    DROP TABLE #CodeGroup_Diag_code_1;

CREATE TABLE #CodeGroup_Diag_code_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Diag_code_1
(
    Code
)
VALUES
('C'),
('K'),
('O'),
('S'),
('N'),
('T'),
('Y');



/* -----------------------
   Code Group: Diag_code_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Diag_code_3') IS NOT NULL
    DROP TABLE #CodeGroup_Diag_code_3;

CREATE TABLE #CodeGroup_Diag_code_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Diag_code_3
(
    Code
)
VALUES
('B99'),
('D00'),
('D13'),
('D30'),
('D41'),
('D48'),
('D73'),
('E34'),
('E66'),
('I71'),
('I72'),
('I79'),
('R10'),
('R16'),
('R17'),
('R18'),
('R69');



/* -----------------------
   Code Group: Diag_code_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Diag_code_4') IS NOT NULL
    DROP TABLE #CodeGroup_Diag_code_4;

CREATE TABLE #CodeGroup_Diag_code_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Diag_code_4
(
    Code
)
VALUES
('D001'),
('E340');



/* -----------------------
   Code Group: Diverticulitis_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Diverticulitis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Diverticulitis_3;

CREATE TABLE #CodeGroup_Diverticulitis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Diverticulitis_3
(
    Code
)
VALUES
('K57');



/* -----------------------
   Code Group: EMLapExICD_1
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICD_1') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICD_1;

CREATE TABLE #CodeGroup_EMLapExICD_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapExICD_1
(
    Code
)
VALUES
('O'),
('S');



/* -----------------------
   Code Group: EMLapExICD_2
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICD_2') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICD_2;

CREATE TABLE #CodeGroup_EMLapExICD_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapExICD_2
(
    Code
)
VALUES
('N0'),
('N1'),
('N2'),
('N3'),
('N4'),
('N7'),
('N8'),
('N9');



/* -----------------------
   Code Group: EMLapExICD_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICD_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICD_3;

CREATE TABLE #CodeGroup_EMLapExICD_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapExICD_3
(
    Code
)
VALUES
('C21'),
('C22'),
('C23'),
('C24'),
('C25'),
('C51'),
('C52'),
('C53'),
('C54'),
('C55'),
('C57'),
('C60'),
('C61'),
('C62'),
('C64'),
('C65'),
('C66'),
('C67'),
('C68'),
('D30'),
('D41'),
('D73'),
('I71'),
('I72'),
('K70'),
('K71'),
('K72'),
('K73'),
('K74'),
('K75'),
('K76'),
('K77'),
('K85'),
('K86'),
('N50'),
('N51'),
('R16'),
('R17'),
('R18');



/* -----------------------
   Code Group: EMLapExICD_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICD_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICD_4;

CREATE TABLE #CodeGroup_EMLapExICD_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapExICD_4
(
    Code
)
VALUES
('C261'),
('I790');



/* -----------------------
   Code Group: EMLapExICDAll_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapExICDAll_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExICDAll_3;

CREATE TABLE #CodeGroup_EMLapExICDAll_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapExICDAll_3
(
    Code
)
VALUES
('K35'),
('K36'),
('K37'),
('K38');



/* -----------------------
   Code Group: EMLapInICD_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapInICD_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapInICD_3;

CREATE TABLE #CodeGroup_EMLapInICD_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapInICD_3
(
    Code
)
VALUES
('S31'),
('S35'),
('S36');



/* -----------------------
   Code Group: EMLapStomaConditions_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapStomaConditions_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapStomaConditions_3;

CREATE TABLE #CodeGroup_EMLapStomaConditions_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapStomaConditions_3
(
    Code
)
VALUES
('K65'),
('K57'),
('K56'),
('K60');



/* -----------------------
   Code Group: EMLapStomaConditions_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapStomaConditions_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapStomaConditions_4;

CREATE TABLE #CodeGroup_EMLapStomaConditions_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapStomaConditions_4
(
    Code
)
VALUES
('K314'),
('K382'),
('K315'),
('K400'),
('K403'),
('K410'),
('K413'),
('K420'),
('K430'),
('K433'),
('K436'),
('K440'),
('K450'),
('K460'),
('K316'),
('K383'),
('K632'),
('N822'),
('N823'),
('N824');



/* -----------------------
   Code Group: FemoralHernia_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_FemoralHernia_3') IS NOT NULL
    DROP TABLE #CodeGroup_FemoralHernia_3;

CREATE TABLE #CodeGroup_FemoralHernia_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_FemoralHernia_3
(
    Code
)
VALUES
('K41');



/* -----------------------
   Code Group: HiatusHernia_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_HiatusHernia_3') IS NOT NULL
    DROP TABLE #CodeGroup_HiatusHernia_3;

CREATE TABLE #CodeGroup_HiatusHernia_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_HiatusHernia_3
(
    Code
)
VALUES
('K44');



/* -----------------------
   Code Group: HospitalAcqCond_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_HospitalAcqCond_3') IS NOT NULL
    DROP TABLE #CodeGroup_HospitalAcqCond_3;

CREATE TABLE #CodeGroup_HospitalAcqCond_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_HospitalAcqCond_3
(
    Code
)
VALUES
('Y95');



/* -----------------------
   Code Group: GallStones_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_GallStones_3') IS NOT NULL
    DROP TABLE #CodeGroup_GallStones_3;

CREATE TABLE #CodeGroup_GallStones_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_GallStones_3
(
    Code
)
VALUES
('K80');



/* -----------------------
   Code Group: Pancreatitis_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Pancreatitis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Pancreatitis_3;

CREATE TABLE #CodeGroup_Pancreatitis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Pancreatitis_3
(
    Code
)
VALUES
('K85');



/* -----------------------
   Code Group: Pancreatitis_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Pancreatitis_4') IS NOT NULL
    DROP TABLE #CodeGroup_Pancreatitis_4;

CREATE TABLE #CodeGroup_Pancreatitis_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Pancreatitis_4
(
    Code
)
VALUES
('K860'),
('K861');



/* -----------------------
   Code Group: PerianalAbcess_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_PerianalAbcess_3') IS NOT NULL
    DROP TABLE #CodeGroup_PerianalAbcess_3;

CREATE TABLE #CodeGroup_PerianalAbcess_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PerianalAbcess_3
(
    Code
)
VALUES
('K61');



/* -----------------------
   Code Group: SmallIntestineCancer_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_SmallIntestineCancer_3') IS NOT NULL
    DROP TABLE #CodeGroup_SmallIntestineCancer_3;

CREATE TABLE #CodeGroup_SmallIntestineCancer_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_SmallIntestineCancer_3
(
    Code
)
VALUES
('C17');



/* -----------------------
   Code Group: UnlikelyNonSpec_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_UnlikelyNonSpec_3') IS NOT NULL
    DROP TABLE #CodeGroup_UnlikelyNonSpec_3;

CREATE TABLE #CodeGroup_UnlikelyNonSpec_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UnlikelyNonSpec_3
(
    Code
)
VALUES
('B99'),
('O81'),
('O83'),
('O84'),
('R69'),
('T08'),
('T09'),
('T10'),
('T11'),
('T12'),
('T13'),
('T14');



/* -----------------------
   Code Group: UnlikelyNonSpec_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_UnlikelyNonSpec_4') IS NOT NULL
    DROP TABLE #CodeGroup_UnlikelyNonSpec_4;

CREATE TABLE #CodeGroup_UnlikelyNonSpec_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UnlikelyNonSpec_4
(
    Code
)
VALUES
('O801'),
('O802'),
('O803'),
('O804'),
('O805'),
('O806'),
('O807'),
('O808'),
('O809'),
('O821'),
('O822'),
('O823'),
('O824'),
('O825'),
('O826'),
('O827'),
('O828'),
('O829'),
('T009'),
('T019'),
('T029'),
('T039'),
('T049'),
('T059'),
('T068');

/* -----------------------
   Code Group: Abdominal_Organ_1 (OPCS Codes)
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Abdominal_Organ_1') IS NOT NULL
    DROP TABLE #CodeGroup_Abdominal_Organ_1;

CREATE TABLE #CodeGroup_Abdominal_Organ_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Abdominal_Organ_1
(
    Code
)
VALUES
('J'); -- All codes starting with 'J' (Adjust as needed)


/* -----------------------
   Code Group: Abdominal_Organ_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Abdominal_Organ_3') IS NOT NULL
    DROP TABLE #CodeGroup_Abdominal_Organ_3;

CREATE TABLE #CodeGroup_Abdominal_Organ_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Abdominal_Organ_3
(
    Code
)
VALUES
('T08'),
('T09'),
('T10'),
('T11'),
('T12'),
('T13'),
('T14'),
('T15'),
('T16'),
('T17'),
('T18'),
('T19'),
('T20'),
('T21'),
('T22'),
('T23'),
('T24'),
('T25'),
('T26'),
('T27'),
('T28'),
('T29'),
('T30'),
('T31'),
('T32'),
('T33'),
('T34'),
('T35'),
('T36'),
('T37'),
('T38'),
('T39'),
('T40'),
('T41'),
('T42'),
('T43'),
('T44'),
('T45'),
('T46'),
('T47'),
('T48'),
('T97'),
('T98');


/* -----------------------
   Code Group: Abdominal_Organ_Specific_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Abdominal_Organ_Specific_3') IS NOT NULL
    DROP TABLE #CodeGroup_Abdominal_Organ_Specific_3;

CREATE TABLE #CodeGroup_Abdominal_Organ_Specific_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Abdominal_Organ_Specific_3
(
    Code
)
VALUES
('J09'),
('J13'),
('J17'),
('J25'),
('J43'),
('J45'),
('J51'),
('J53'),
('J67'),
('J73'),
('J74'),
('T11'),
('T43');


/* -----------------------
   Code Group: AnastomosisColon_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_AnastomosisColon_4') IS NOT NULL
    DROP TABLE #CodeGroup_AnastomosisColon_4;

CREATE TABLE #CodeGroup_AnastomosisColon_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AnastomosisColon_4
(
    Code
)
VALUES
('G721'),
('G724');


/* -----------------------
   Code Group: App_AbdomenOther_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_AbdomenOther_3') IS NOT NULL
    DROP TABLE #CodeGroup_App_AbdomenOther_3;

CREATE TABLE #CodeGroup_App_AbdomenOther_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_AbdomenOther_3
(
    Code
)
VALUES
('Y51'),
('Y52'),
('Y53');


/* -----------------------
   Code Group: App_AbdomenOther_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_AbdomenOther_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_AbdomenOther_4;

CREATE TABLE #CodeGroup_App_AbdomenOther_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_AbdomenOther_4
(
    Code
)
VALUES
('Y501'),
('Y503'),
('Y508'),
('Y509');


/* -----------------------
   Code Group: App_ConversionOpen_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_ConversionOpen_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_ConversionOpen_4;

CREATE TABLE #CodeGroup_App_ConversionOpen_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_ConversionOpen_4
(
    Code
)
VALUES
('Y714'),
('Y715');


/* -----------------------
   Code Group: App_EndoOtherBodyCavity_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_EndoOtherBodyCavity_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_EndoOtherBodyCavity_4;

CREATE TABLE #CodeGroup_App_EndoOtherBodyCavity_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_EndoOtherBodyCavity_4
(
    Code
)
VALUES
('Y763'),
('Y764');


/* -----------------------
   Code Group: App_LapApproach_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_LapApproach_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_LapApproach_4;

CREATE TABLE #CodeGroup_App_LapApproach_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_LapApproach_4
(
    Code
)
VALUES
('Y752'),
('Y755');


/* -----------------------
   Code Group: App_Laparotomy_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_Laparotomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_Laparotomy_4;

CREATE TABLE #CodeGroup_App_Laparotomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_Laparotomy_4
(
    Code
)
VALUES
('Y502');


/* -----------------------
   Code Group: App_LapAssist_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_LapAssist_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_LapAssist_4;

CREATE TABLE #CodeGroup_App_LapAssist_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_LapAssist_4
(
    Code
)
VALUES
('Y751');


/* -----------------------
   Code Group: App_MinimalAccess_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_MinimalAccess_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_MinimalAccess_4;

CREATE TABLE #CodeGroup_App_MinimalAccess_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_MinimalAccess_4
(
    Code
)
VALUES
('Y754'),
('Y758'),
('Y759');


/* -----------------------
   Code Group: App_Robotic_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_Robotic_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_Robotic_4;

CREATE TABLE #CodeGroup_App_Robotic_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_Robotic_4
(
    Code
)
VALUES
('Y753');


/* -----------------------
   Code Group: App_Bilateral_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_App_Bilateral_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_Bilateral_4;

CREATE TABLE #CodeGroup_App_Bilateral_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_Bilateral_4
(
    Code
)
VALUES
('T191'),
('Z941');


/* -----------------------
   Code Group: Append_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Append_3') IS NOT NULL
    DROP TABLE #CodeGroup_Append_3;

CREATE TABLE #CodeGroup_Append_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Append_3
(
    Code
)
VALUES
('H01'),
('H02');


/* -----------------------
   Code Group: Chemotherapy_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Chemotherapy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Chemotherapy_3;

CREATE TABLE #CodeGroup_Chemotherapy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Chemotherapy_3
(
    Code
)
VALUES
('X70'),
('X71'),
('X72'),
('X73'),
('X74');


/* -----------------------
   Code Group: LaparoscopicCholecystectomy_2_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_LaparoscopicCholecystectomy_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_LaparoscopicCholecystectomy_2_4;

CREATE TABLE #CodeGroup_LaparoscopicCholecystectomy_2_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_LaparoscopicCholecystectomy_2_4
(
    Code
)
VALUES
('J183');


/* -----------------------
   Code Group: ColonicStent_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ColonicStent_4') IS NOT NULL
    DROP TABLE #CodeGroup_ColonicStent_4;

CREATE TABLE #CodeGroup_ColonicStent_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ColonicStent_4
(
    Code
)
VALUES
('H214'),
('H243'),
('H244'),
('H273'),
('H274'),
('H314'),
('H315');


/* -----------------------
   Code Group: DefEMLap_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_DefEMLap_4') IS NOT NULL
    DROP TABLE #CodeGroup_DefEMLap_4;

CREATE TABLE #CodeGroup_DefEMLap_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_DefEMLap_4
(
    Code
)
VALUES
('H188'),
('H189'),
('Y752'),
('Y755');


/* -----------------------
   Code Group: EMLap_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLap_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLap_3;

CREATE TABLE #CodeGroup_EMLap_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLap_3
(
    Code
)
VALUES
('G01'),
('G27'),
('G28'),
('G29'),
('G31'),
('G32'),
('G33'),
('G35'),
('G36'),
('G38'),
('G49'),
('G51'),
('G52'),
('G53'),
('G58'),
('G61'),
('G63'),
('G69'),
('G70'),
('G71'),
('G72'),
('G73'),
('G75'),
('G76'),
('G78'),
('H04'),
('H05'),
('H06'),
('H07'),
('H08'),
('H09'),
('H10'),
('H11'),
('H12'),
('H13'),
('H16'),
('H17'),
('H19'),
('H29'),
('H33'),
('H66'),
('T28'),
('T30'),
('T34'),
('T36'),
('T42');


/* -----------------------
   Code Group: EMLap_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLap_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLap_4;

CREATE TABLE #CodeGroup_EMLap_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLap_4
(
    Code
)
VALUES
('L703'),
('T463');


/* -----------------------
   Code Group: EMLapExOPTFC_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapExOPTFC_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExOPTFC_3;

CREATE TABLE #CodeGroup_EMLapExOPTFC_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapExOPTFC_3
(
    Code
)
VALUES
('T28'),
('T30'),
('T34'),
('T36'),
('T41'),
('T42');


/* -----------------------
   Code Group: EMLapExOPTFC_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapExOPTFC_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExOPTFC_4;

CREATE TABLE #CodeGroup_EMLapExOPTFC_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapExOPTFC_4
(
    Code
)
VALUES
('L703'),
('T463');


/* -----------------------
   Code Group: EMLapFollow_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapFollow_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapFollow_3;

CREATE TABLE #CodeGroup_EMLapFollow_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapFollow_3
(
    Code
)
VALUES
('T36');


/* -----------------------
   Code Group: EMLapFollow_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapFollow_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapFollow_4;

CREATE TABLE #CodeGroup_EMLapFollow_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapFollow_4
(
    Code
)
VALUES
('T411'),
('T418'),
('T419');


/* -----------------------
   Code Group: EMLapHernia_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapHernia_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapHernia_3;

CREATE TABLE #CodeGroup_EMLapHernia_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapHernia_3
(
    Code
)
VALUES
('G27'),
('G28'),
('G29'),
('G35'),
('G36'),
('G38'),
('G49'),
('G52'),
('G58'),
('G69'),
('H04'),
('H05'),
('H06'),
('H07'),
('H08'),
('H09'),
('H10'),
('H11'),
('H29'),
('H33'),
('H66');


/* -----------------------
   Code Group: EMLapHernia_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapHernia_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapHernia_4;

CREATE TABLE #CodeGroup_EMLapHernia_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapHernia_4
(
    Code
)
VALUES
('G633'),
('G784');


/* -----------------------
   Code Group: EMLapHerniaProcs_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapHerniaProcs_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapHerniaProcs_3;

CREATE TABLE #CodeGroup_EMLapHerniaProcs_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapHerniaProcs_3
(
    Code
)
VALUES
('T20'),
('T21'),
('T22'),
('T23'),
('T24'),
('T25'),
('T26'),
('T27'),
('T97'),
('T98');


/* -----------------------
   Code Group: EMLapHerniaProcs_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapHerniaProcs_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapHerniaProcs_4;

CREATE TABLE #CodeGroup_EMLapHerniaProcs_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapHerniaProcs_4
(
    Code
)
VALUES
('G234');


/* -----------------------
   Code Group: EMLapIncisional_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapIncisional_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapIncisional_3;

CREATE TABLE #CodeGroup_EMLapIncisional_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapIncisional_3
(
    Code
)
VALUES
('T41');


/* -----------------------
   Code Group: EMLapIncisional_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapIncisional_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapIncisional_4;

CREATE TABLE #CodeGroup_EMLapIncisional_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapIncisional_4
(
    Code
)
VALUES
('T463');


/* -----------------------
   Code Group: EMLapStoma_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapStoma_3') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapStoma_3;

CREATE TABLE #CodeGroup_EMLapStoma_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapStoma_3
(
    Code
)
VALUES
('G74');


/* -----------------------
   Code Group: EMLapStoma_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_EMLapStoma_4') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapStoma_4;

CREATE TABLE #CodeGroup_EMLapStoma_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapStoma_4
(
    Code
)
VALUES
('H141'),
('H151'),
('H152');


/* -----------------------
   Code Group: ExenterationPelvis_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ExenterationPelvis_4') IS NOT NULL
    DROP TABLE #CodeGroup_ExenterationPelvis_4;

CREATE TABLE #CodeGroup_ExenterationPelvis_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ExenterationPelvis_4
(
    Code
)
VALUES
('X141'),
('X142'),
('X143'),
('X148'),
('X149');


/* -----------------------
   Code Group: Gastrointestinal_1
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Gastrointestinal_1') IS NOT NULL
    DROP TABLE #CodeGroup_Gastrointestinal_1;

CREATE TABLE #CodeGroup_Gastrointestinal_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Gastrointestinal_1
(
    Code
)
VALUES
('G'),
('H'); -- All codes starting with 'G' and 'H' (Adjust as needed)


/* -----------------------
   Code Group: Gastrointestinal_Specific_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Gastrointestinal_Specific_3') IS NOT NULL
    DROP TABLE #CodeGroup_Gastrointestinal_Specific_3;

CREATE TABLE #CodeGroup_Gastrointestinal_Specific_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Gastrointestinal_Specific_3
(
    Code
)
VALUES
('G80'),
('G16'),
('G19'),
('G45'),
('G55'),
('G65'),
('H22'),
('H25'),
('H28'),
('H68'),
('H69'),
('H70');

/* -----------------------
   Code Group: IleocaecalResection_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_IleocaecalResection_4') IS NOT NULL
    DROP TABLE #CodeGroup_IleocaecalResection_4;

CREATE TABLE #CodeGroup_IleocaecalResection_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_IleocaecalResection_4
(
    Code
)
VALUES
('G721'),
('H071'),
('H072'),
('H073'),
('H074'),
('H078'),
('H079');


/* -----------------------
   Code Group: IleorectalAnastom_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_IleorectalAnastom_4') IS NOT NULL
    DROP TABLE #CodeGroup_IleorectalAnastom_4;

CREATE TABLE #CodeGroup_IleorectalAnastom_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_IleorectalAnastom_4
(
    Code
)
VALUES
('G724'),
('H051'),
('H101'),
('H112'),
('H113');


/* -----------------------
   Code Group: LeftHemicolectomy_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_LeftHemicolectomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_LeftHemicolectomy_3;

CREATE TABLE #CodeGroup_LeftHemicolectomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_LeftHemicolectomy_3
(
    Code
)
VALUES
('H09');


/* -----------------------
   Code Group: LocalExcColorectCancer_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_LocalExcColorectCancer_3') IS NOT NULL
    DROP TABLE #CodeGroup_LocalExcColorectCancer_3;

CREATE TABLE #CodeGroup_LocalExcColorectCancer_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_LocalExcColorectCancer_3
(
    Code
)
VALUES
('H12');


/* -----------------------
   Code Group: LocalExcColorectCancer_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_LocalExcColorectCancer_4') IS NOT NULL
    DROP TABLE #CodeGroup_LocalExcColorectCancer_4;

CREATE TABLE #CodeGroup_LocalExcColorectCancer_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_LocalExcColorectCancer_4
(
    Code
)
VALUES
('H201'),
('H231'),
('H261'),
('H341'),
('H402'),
('H412');


/* -----------------------
   Code Group: NerveStimPelvicFloor_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_NerveStimPelvicFloor_4') IS NOT NULL
    DROP TABLE #CodeGroup_NerveStimPelvicFloor_4;

CREATE TABLE #CodeGroup_NerveStimPelvicFloor_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_NerveStimPelvicFloor_4
(
    Code
)
VALUES
('A701'),
('A704');


/* -----------------------
   Code Group: ImagingTestsDrugsTherapy_2
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ImagingTestsDrugsTherapy_2') IS NOT NULL
    DROP TABLE #CodeGroup_ImagingTestsDrugsTherapy_2;

CREATE TABLE #CodeGroup_ImagingTestsDrugsTherapy_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ImagingTestsDrugsTherapy_2
(
    Code
)
VALUES
('U0'),
('U1'),
('U2'),
('U3'),
('U4'),
('U5'),
('X6'),
('X7'),
('X8'),
('X9');


/* -----------------------
   Code Group: NoProc_1_1
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_NoProc_1_1') IS NOT NULL
    DROP TABLE #CodeGroup_NoProc_1_1;

CREATE TABLE #CodeGroup_NoProc_1_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_NoProc_1_1
(
    Code
)
VALUES
('U');


/* -----------------------
   Code Group: NoProc_1_2
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_NoProc_1_2') IS NOT NULL
    DROP TABLE #CodeGroup_NoProc_1_2;

CREATE TABLE #CodeGroup_NoProc_1_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_NoProc_1_2
(
    Code
)
VALUES
('X');


/* -----------------------
   Code Group: OtherColonExcision_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_OtherColonExcision_3') IS NOT NULL
    DROP TABLE #CodeGroup_OtherColonExcision_3;

CREATE TABLE #CodeGroup_OtherColonExcision_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OtherColonExcision_3
(
    Code
)
VALUES
('H11');


/* -----------------------
   Code Group: PelvicFloor_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_PelvicFloor_4') IS NOT NULL
    DROP TABLE #CodeGroup_PelvicFloor_4;

CREATE TABLE #CodeGroup_PelvicFloor_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PelvicFloor_4
(
    Code
)
VALUES
('Z112');


/* -----------------------
   Code Group: PeranalSurgery_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_PeranalSurgery_4') IS NOT NULL
    DROP TABLE #CodeGroup_PeranalSurgery_4;

CREATE TABLE #CodeGroup_PeranalSurgery_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PeranalSurgery_4
(
    Code
)
VALUES
('H411'),
('H414'),
('H415');


/* -----------------------
   Code Group: PerianalProcCrohnDisease_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_PerianalProcCrohnDisease_4') IS NOT NULL
    DROP TABLE #CodeGroup_PerianalProcCrohnDisease_4;

CREATE TABLE #CodeGroup_PerianalProcCrohnDisease_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PerianalProcCrohnDisease_4
(
    Code
)
VALUES
('H414'),
('H444'),
('H532'),
('H548'),
('H549'),
('H551'),
('H552'),
('H553'),
('H554'),
('H556'),
('H557'),
('H558'),
('H559'),
('H562'),
('H564'),
('H568'),
('H581'),
('H582'),
('H583');


/* -----------------------
   Code Group: Proc_code_1
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Proc_code_1') IS NOT NULL
    DROP TABLE #CodeGroup_Proc_code_1;

CREATE TABLE #CodeGroup_Proc_code_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Proc_code_1
(
    Code
)
VALUES
('G'),
('H'),
('T'),
('J'); -- All codes starting with these letters


/* -----------------------
   Code Group: Proc_code_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Proc_code_3') IS NOT NULL
    DROP TABLE #CodeGroup_Proc_code_3;

CREATE TABLE #CodeGroup_Proc_code_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Proc_code_3
(
    Code
)
VALUES
('C48'),
('X14'),
('L70'),
('Y50'),
('Y51'),
('Y52'),
('Y53'),
('Y71'),
('Y74'),
('Y75'),
('Y76'),
('X70'),
('X71'),
('X72'),
('X73'),
('X74'),
('X65'),
('X67'),
('X68'),
('X69');


/* -----------------------
   Code Group: Proc_code_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Proc_code_4') IS NOT NULL
    DROP TABLE #CodeGroup_Proc_code_4;

CREATE TABLE #CodeGroup_Proc_code_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Proc_code_4
(
    Code
)
VALUES
('A701'),
('A704'),
('C221'),
('K210'),
('K219'),
('K220'),
('K440'),
('K441'),
('K449'),
('L703'),
('M193'),
('P134'),
('P253'),
('P788'),
('Z112'),
('Z378'),
('Z941');


/* -----------------------
   Code Group: ProcForDefEMLaparoscopy_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForDefEMLaparoscopy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForDefEMLaparoscopy_3;

CREATE TABLE #CodeGroup_ProcForDefEMLaparoscopy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForDefEMLaparoscopy_3
(
    Code
)
VALUES
('J08'),
('T42');


/* -----------------------
   Code Group: ProcForDefEMLaparoscopy_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForDefEMLaparoscopy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForDefEMLaparoscopy_4;

CREATE TABLE #CodeGroup_ProcForDefEMLaparoscopy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForDefEMLaparoscopy_4
(
    Code
)
VALUES
('H188'),
('H189'),
('Y752'),
('Y755');


/* -----------------------
   Code Group: ProcForDefEMLaparotomy_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForDefEMLaparotomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForDefEMLaparotomy_3;

CREATE TABLE #CodeGroup_ProcForDefEMLaparotomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForDefEMLaparotomy_3
(
    Code
)
VALUES
('G04'),
('G05'),
('G06'),
('G07'),
('G08'),
('G09'),
('G10'),
('G11'),
('G23'),
('G24'),
('G25'),
('G26'),
('G29'),
('G30'),
('G31'),
('G32'),
('G33'),
('G34'),
('G35'),
('G36'),
('G40'),
('G50'),
('G51'),
('G52'),
('G59'),
('G60'),
('G61'),
('G68'),
('G70'),
('G71'),
('G72'),
('G73'),
('G74'),
('G75'),
('G76'),
('H12'),
('H13'),
('H14'),
('H15'),
('H16'),
('H17'),
('H32'),
('H34'),
('H35'),
('H36'),
('H40'),
('H42'),
('H47'),
('H66'),
('J01'),
('J02'),
('J03'),
('J04'),
('J06'),
('J07'),
('J08'),
('J16'),
('J19'),
('J20'),
('J21'),
('J26'),
('J27'),
('J28'),
('J29'),
('J30'),
('J31'),
('J32'),
('J33'),
('J34'),
('J35'),
('J52'),
('J54'),
('J55'),
('J56'),
('J57'),
('J58'),
('J59'),
('J60'),
('J61'),
('J62'),
('J68'),
('J69'),
('J70'),
('T15'),
('T16'),
('T17'),
('T19'),
('T20'),
('T21'),
('T22'),
('T23'),
('T24'),
('T27'),
('T28'),
('T33'),
('T34'),
('T42');


/* -----------------------
   Code Group: ProcForDefEMLaparotomy_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForDefEMLaparotomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForDefEMLaparotomy_4;

CREATE TABLE #CodeGroup_ProcForDefEMLaparotomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForDefEMLaparotomy_4
(
    Code
)
VALUES
('G132'),
('G138'),
('G139'),
('G218'),
('G219'),
('G382'),
('G383'),
('G384'),
('G385'),
('G386'),
('G387'),
('G388'),
('G389'),
('G412'),
('G418'),
('G419'),
('G488'),
('G489'),
('G532'),
('G533'),
('G534'),
('G535'),
('G536'),
('G538'),
('G539'),
('G578'),
('G579'),
('G632'),
('G633'),
('G634'),
('G638'),
('G639'),
('G678'),
('G679'),
('G782'),
('G783'),
('G784'),
('G785'),
('G786'),
('G788'),
('G789'),
('G828'),
('G829'),
('H188'),
('H189'),
('H192'),
('H193'),
('H194'),
('H198'),
('H199'),
('H308'),
('H309'),
('H412'),
('H413'),
('H418'),
('H419'),
('H621'),
('H622'),
('H623'),
('H625'),
('H628'),
('H629'),
('J051'),
('J052'),
('J058'),
('J059'),
('J148'),
('J149'),
('J231'),
('J233'),
('J238'),
('J239'),
('J361'),
('J368'),
('J369'),
('J378'),
('J379'),
('J658'),
('J659'),
('J721'),
('J722'),
('J724'),
('J725'),
('J728'),
('J729'),
('T295'),
('T301'),
('T361'),
('T362'),
('T363'),
('T365'),
('T368'),
('T369'),
('T371'),
('T372'),
('T374'),
('T378'),
('T379'),
('T381'),
('T382'),
('T384'),
('T388'),
('T389'),
('T391'),
('T392'),
('T398'),
('T399'),
('T412'),
('T413'),
('T414'),
('T415'),
('T418'),
('T419'),
('T488'),
('T489');

/* -----------------------
   Code Group: ProcForEMLaparotomy_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForEMLaparotomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForEMLaparotomy_3;

CREATE TABLE #CodeGroup_ProcForEMLaparotomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForEMLaparotomy_3
(
    Code
)
VALUES
('G71'),
('G72'),
('G73'),
('G74'),
('G75'),
('G76'),
('G78'),
('H04'),
('H05'),
('H06'),
('H07'),
('H08'),
('H09'),
('H10'),
('H11'),
('H12'),
('H13'),
('H16'),
('H17'),
('H19'),
('H29'),
('H33'),
('H66'),
('T28'),
('T30'),
('T34'),
('T36'),
('T41'),
('T42');

/* -----------------------
   Code Group: ProcForEMLaparotomy_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForEMLaparotomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForEMLaparotomy_4;

CREATE TABLE #CodeGroup_ProcForEMLaparotomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForEMLaparotomy_4
(
    Code
)
VALUES
('H141'),
('H151'),
('H152'),
('L703'),
('T463');

/* -----------------------
   Code Group: ProcForNonDefEMLaparoscopy_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForNonDefEMLaparoscopy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForNonDefEMLaparoscopy_3;

CREATE TABLE #CodeGroup_ProcForNonDefEMLaparoscopy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForNonDefEMLaparoscopy_3
(
    Code
)
VALUES
('J09'),
('J51'),
('J73');

/* -----------------------
   Code Group: ProcForNonDefEMLaparoscopy_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForNonDefEMLaparoscopy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForNonDefEMLaparoscopy_4;

CREATE TABLE #CodeGroup_ProcForNonDefEMLaparoscopy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForNonDefEMLaparoscopy_4
(
    Code
)
VALUES
('Y752'),
('Y755');

/* -----------------------
   Code Group: ProcForNonDefEMLaparotomy_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForNonDefEMLaparotomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForNonDefEMLaparotomy_3;

CREATE TABLE #CodeGroup_ProcForNonDefEMLaparotomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForNonDefEMLaparotomy_3
(
    Code
)
VALUES
('J09'),
('J51'),
('J63'),
('J73');

/* -----------------------
   Code Group: ProcForNonDefEMLaparotomy_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcForNonDefEMLaparotomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcForNonDefEMLaparotomy_4;

CREATE TABLE #CodeGroup_ProcForNonDefEMLaparotomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcForNonDefEMLaparotomy_4
(
    Code
)
VALUES
('G131'),
('G381'),
('G411'),
('G531'),
('G631'),
('G781'),
('H191'),
('H561'),
('J053'),
('J141'),
('J142'),
('J232'),
('J362'),
('J371'),
('J372'),
('J373'),
('J374'),
('J651'),
('J723'),
('T302'),
('T303'),
('T304'),
('T309');

/* -----------------------
   Code Group: ProcLargeBowelObstruct_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcLargeBowelObstruct_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcLargeBowelObstruct_3;

CREATE TABLE #CodeGroup_ProcLargeBowelObstruct_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcLargeBowelObstruct_3
(
    Code
)
VALUES
('G74'),
('H05'),
('H06'),
('H07'),
('H08'),
('H09'),
('H10'),
('H11'),
('H13'),
('H14'),
('H15'),
('H17');

/* -----------------------
   Code Group: ProcLargeBowelObstruct_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcLargeBowelObstruct_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcLargeBowelObstruct_4;

CREATE TABLE #CodeGroup_ProcLargeBowelObstruct_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcLargeBowelObstruct_4
(
    Code
)
VALUES
('H214'),
('H244'),
('H274'),
('H333'),
('H334'),
('H335'),
('H336'),
('H338'),
('H339');

/* -----------------------
   Code Group: ProcPerianalAbcess_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcPerianalAbcess_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcPerianalAbcess_4;

CREATE TABLE #CodeGroup_ProcPerianalAbcess_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcPerianalAbcess_4
(
    Code
)
VALUES
('H582');

/* -----------------------
   Code Group: ProcSmallBowelObstruct_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcSmallBowelObstruct_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcSmallBowelObstruct_3;

CREATE TABLE #CodeGroup_ProcSmallBowelObstruct_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcSmallBowelObstruct_3
(
    Code
)
VALUES
('G49'),
('G50'),
('G58'),
('G59'),
('G69'),
('G70');

/* -----------------------
   Code Group: ProcSmallBowelObstruct_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcSmallBowelObstruct_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcSmallBowelObstruct_4;

CREATE TABLE #CodeGroup_ProcSmallBowelObstruct_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcSmallBowelObstruct_4
(
    Code
)
VALUES
('G536'),
('G538'),
('G638'),
('G762'),
('G763');

/* -----------------------
   Code Group: ProcUlcerColitis_4_1
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcUlcerColitis_4_1') IS NOT NULL
    DROP TABLE #CodeGroup_ProcUlcerColitis_4_1;

CREATE TABLE #CodeGroup_ProcUlcerColitis_4_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcUlcerColitis_4_1
(
    Code
)
VALUES
('H041');

/* -----------------------
   Code Group: ProcUlcerColitis_4_2
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ProcUlcerColitis_4_2') IS NOT NULL
    DROP TABLE #CodeGroup_ProcUlcerColitis_4_2;

CREATE TABLE #CodeGroup_ProcUlcerColitis_4_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcUlcerColitis_4_2
(
    Code
)
VALUES
('G725'),
('H042');

/* -----------------------
   Code Group: Radiotherapy_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Radiotherapy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Radiotherapy_3;

CREATE TABLE #CodeGroup_Radiotherapy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Radiotherapy_3
(
    Code
)
VALUES
('X65'),
('X67'),
('X68'),
('X69');

/* -----------------------
   Code Group: RectalExcision_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_RectalExcision_3') IS NOT NULL
    DROP TABLE #CodeGroup_RectalExcision_3;

CREATE TABLE #CodeGroup_RectalExcision_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_RectalExcision_3
(
    Code
)
VALUES
('H33');

/* -----------------------
   Code Group: RectalSurgery_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_RectalSurgery_4') IS NOT NULL
    DROP TABLE #CodeGroup_RectalSurgery_4;

CREATE TABLE #CodeGroup_RectalSurgery_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_RectalSurgery_4
(
    Code
)
VALUES
('H404'),
('H408'),
('H409');

/* -----------------------
   Code Group: Rectopexy_4_1
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Rectopexy_4_1') IS NOT NULL
    DROP TABLE #CodeGroup_Rectopexy_4_1;

CREATE TABLE #CodeGroup_Rectopexy_4_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Rectopexy_4_1
(
    Code
)
VALUES
('H353');

/* -----------------------
   Code Group: Rectopexy_4_2
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Rectopexy_4_2') IS NOT NULL
    DROP TABLE #CodeGroup_Rectopexy_4_2;

CREATE TABLE #CodeGroup_Rectopexy_4_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Rectopexy_4_2
(
    Code
)
VALUES
('H352');

/* -----------------------
   Code Group: RectoVaginalFistula_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_RectoVaginalFistula_4') IS NOT NULL
    DROP TABLE #CodeGroup_RectoVaginalFistula_4;

CREATE TABLE #CodeGroup_RectoVaginalFistula_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_RectoVaginalFistula_4
(
    Code
)
VALUES
('P134'),
('P253');

/* -----------------------
   Code Group: ResectionSmallBowel_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ResectionSmallBowel_3') IS NOT NULL
    DROP TABLE #CodeGroup_ResectionSmallBowel_3;

CREATE TABLE #CodeGroup_ResectionSmallBowel_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ResectionSmallBowel_3
(
    Code
)
VALUES
('G49'),
('G58'),
('G69');

/* -----------------------
   Code Group: SigmoidColectomy_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_SigmoidColectomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_SigmoidColectomy_3;

CREATE TABLE #CodeGroup_SigmoidColectomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_SigmoidColectomy_3
(
    Code
)
VALUES
('H10');

/* -----------------------
   Code Group: StomaReversal_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_StomaReversal_4') IS NOT NULL
    DROP TABLE #CodeGroup_StomaReversal_4;

CREATE TABLE #CodeGroup_StomaReversal_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_StomaReversal_4
(
    Code
)
VALUES
('G753'),
('H143'),
('H154');

/* -----------------------
   Code Group: Strictureplasty_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Strictureplasty_4') IS NOT NULL
    DROP TABLE #CodeGroup_Strictureplasty_4;

CREATE TABLE #CodeGroup_Strictureplasty_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Strictureplasty_4
(
    Code
)
VALUES
('G782');

/* -----------------------
   Code Group: SubTotalColonExcision_3
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_SubTotalColonExcision_3') IS NOT NULL
    DROP TABLE #CodeGroup_SubTotalColonExcision_3;

CREATE TABLE #CodeGroup_SubTotalColonExcision_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_SubTotalColonExcision_3
(
    Code
)
VALUES
('H29');

/* -----------------------
   Code Group: EMLapExOPTFC
----------------------- */
-- Since this code group has code type 'Other' and codes '501,502,503', we can create a table accordingly.

IF OBJECT_ID('tempdb..#CodeGroup_EMLapExOPTFC') IS NOT NULL
    DROP TABLE #CodeGroup_EMLapExOPTFC;

CREATE TABLE #CodeGroup_EMLapExOPTFC
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EMLapExOPTFC
(
    Code
)
VALUES
('501'),
('502'),
('503');

/* -----------------------
   Code Group: FY_2014_onwards
----------------------- */
-- This seems to be a date '2014-04-01 00:00:00.000'

DECLARE @FY_2014_onwards DATETIME = '2014-04-01 00:00:00.000';

/* -----------------------
   Code Group: MainSpec_1
----------------------- */
-- Code Type: Other, Codes: '100,171'

IF OBJECT_ID('tempdb..#CodeGroup_MainSpec_1') IS NOT NULL
    DROP TABLE #CodeGroup_MainSpec_1;

CREATE TABLE #CodeGroup_MainSpec_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_MainSpec_1
(
    Code
)
VALUES
('100'),
('171');

/* -----------------------
   Code Group: TFC_Code_1
----------------------- */
-- Code Type: Other, Codes: '100,104,105,106,171,213'

IF OBJECT_ID('tempdb..#CodeGroup_TFC_Code_1') IS NOT NULL
    DROP TABLE #CodeGroup_TFC_Code_1;

CREATE TABLE #CodeGroup_TFC_Code_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_TFC_Code_1
(
    Code
)
VALUES
('100'),
('104'),
('105'),
('106'),
('171'),
('213');

/* -----------------------
   Code Group: CancelClinical_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_CancelClinical_4') IS NOT NULL
    DROP TABLE #CodeGroup_CancelClinical_4;

CREATE TABLE #CodeGroup_CancelClinical_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_CancelClinical_4
(
    Code
)
VALUES
('Z530');

/* -----------------------
   Code Group: CancelNonClinical_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_CancelNonClinical_4') IS NOT NULL
    DROP TABLE #CodeGroup_CancelNonClinical_4;

CREATE TABLE #CodeGroup_CancelNonClinical_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_CancelNonClinical_4
(
    Code
)
VALUES
('Z538'),
('Z539'),
('Z531'),
('Z532');

/* -----------------------
   Code Group: ALL.Ulcerative_colitis
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Ulcerative_colitis') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Ulcerative_colitis;

CREATE TABLE #CodeGroup_ALL_Ulcerative_colitis
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Ulcerative_colitis
(
    Code
)
VALUES
('K51');

/* -----------------------
   Code Group: ALL.Stoma_Creation
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Stoma_creation') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Stoma_creation;

CREATE TABLE #CodeGroup_ALL_Stoma_creation
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Stoma_creation
(
    Code
)
VALUES
('G741'),
('G742'),
('G743'),
('G748'),
('G749'),
('H041'),
('H052'),
('H053'),
('H064'),
('H074'),
('H084'),
('H085'),
('H094'),
('H095'),
('H104'),
('H105'),
('H114'),
('H115'),
('H141'),
('H144'),
('H148'),
('H149'),
('H151'),
('H152'),
('H157'),
('H158'),
('H159'),
('H331'),
('H335'),
('H336');

/* -----------------------
   Code Group: ALL.Anti_Reflux
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Anti_reflux') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Anti_reflux;

CREATE TABLE #CodeGroup_ALL_Anti_reflux
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Anti_reflux
(
    Code
)
VALUES
('K210'),
('K219'),
('K440'),
('K441'),
('K449'),
('P788');

/* -----------------------
   Code Group: ALL.Hartmanns
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Hartmanns') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Hartmanns;

CREATE TABLE #CodeGroup_ALL_Hartmanns
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Hartmanns
(
    Code
)
VALUES
('H335');

/* -----------------------
   Code Group: ALL.Obesity
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Obesity') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Obesity;

CREATE TABLE #CodeGroup_ALL_Obesity
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Obesity
(
    Code
)
VALUES
('E66');

/* -----------------------
   Code Group: ALL.Crohns_disease
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Crohns_disease') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Crohns_disease;

CREATE TABLE #CodeGroup_ALL_Crohns_disease
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Crohns_disease
(
    Code
)
VALUES
('K50');

/* -----------------------
   Code Group: ALL.Lateral_branch_of_abdominal_aorta
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Lateral_branch_of_abdominal_aorta') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Lateral_branch_of_abdominal_aorta;

CREATE TABLE #CodeGroup_ALL_Lateral_branch_of_abdominal_aorta
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Lateral_branch_of_abdominal_aorta
(
    Code
)
VALUES
('Z378');

/* -----------------------
   Code Group: ALL_Incisional_hernia_repair
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Incisional_hernia_repair') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Incisional_hernia_repair;

CREATE TABLE #CodeGroup_ALL_Incisional_hernia_repair
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Incisional_hernia_repair
(
    Code
)
VALUES
('T251'),
('T252'),
('T253'),
('T258'),
('T259'),
('T261'),
('T262'),
('T263'),
('T268'),
('T269'),
('T282'),
('T283'),
('T288'),
('T289'),
('T321'),
('T322'),
('T323'),
('T324'),
('T328'),
('T329');

/* -----------------------
   Code Group: ALL_Haemorrhoids
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Haemorrhoids') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Haemorrhoids;

CREATE TABLE #CodeGroup_ALL_Haemorrhoids
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Haemorrhoids
(
    Code
)
VALUES
('K640'),
('K641'),
('K642'),
('K643'),
('K644'),
('K645'),
('K648'),
('K649');

/* -----------------------
   Code Group: POD_EM
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_POD_EM') IS NOT NULL
    DROP TABLE #CodeGroup_POD_EM;

CREATE TABLE #CodeGroup_POD_EM
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_POD_EM
(
    Code
)
VALUES
('EM');

/* -----------------------
   Code Group: ALL_Proctocolectomy_with_ileo_anal_pouch
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Proctocolectomy_with_ileo_anal_pouch') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Proctocolectomy_with_ileo_anal_pouch;

CREATE TABLE #CodeGroup_ALL_Proctocolectomy_with_ileo_anal_pouch
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Proctocolectomy_with_ileo_anal_pouch
(
    Code
)
VALUES
('H042'),
('H043');

/* -----------------------
   Code Group: Cholecystitis_4
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Cholecystitis_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cholecystitis_4;

CREATE TABLE #CodeGroup_Cholecystitis_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cholecystitis_4
(
    Code
)
VALUES
('K800'),
('K801'),
('K804'),
('K810'),
('K811'),
('K818'),
('K819'),
('K850'),
('K851'),
('K852'),
('K853'),
('K858'),
('K859');

/* -----------------------
   Code Group: ALL_Proctocolectomy_with_ileostomy
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Proctocolectomy_with_ileostomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Proctocolectomy_with_ileostomy;

CREATE TABLE #CodeGroup_ALL_Proctocolectomy_with_ileostomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Proctocolectomy_with_ileostomy
(
    Code
)
VALUES
('H041'),
('H048'),
('H049');

/* -----------------------
   Code Group: ALL_Colectomy_and_ileo_rectal_anastomosis
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Colectomy_and_ileo_rectal_anastomosis') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Colectomy_and_ileo_rectal_anastomosis;

CREATE TABLE #CodeGroup_ALL_Colectomy_and_ileo_rectal_anastomosis
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Colectomy_and_ileo_rectal_anastomosis
(
    Code
)
VALUES
('H051'),
('H112'),
('H114');

/* -----------------------
   Code Group: ALL_Right_hemicolectomy
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Right_hemicolectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Right_hemicolectomy;

CREATE TABLE #CodeGroup_ALL_Right_hemicolectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Right_hemicolectomy
(
    Code
)
VALUES
('H071'),
('H072'),
('H073'),
('H074'),
('H075'),
('H078'),
('H079');

/* -----------------------
   Code Group: ALL_Extended_right_hemicolectomy
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_ALL_Extended_right_hemicolectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Extended_right_hemicolectomy;

CREATE TABLE #CodeGroup_ALL_Extended_right_hemicolectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Extended_right_hemicolectomy
(
    Code
)
VALUES
('H061'),
('H062'),
('H063'),
('H064'),
('H065'),
('H068'),
('H069');

/* -----------------------
   Code Group: ALL_Transverse_colectomy
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Transverse_colectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Transverse_colectomy;

CREATE TABLE #CodeGroup_ALL_Transverse_colectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Transverse_colectomy
(
    Code
)
VALUES
('H081'),
('H082'),
('H083'),
('H084'),
('H085'),
('H088'),
('H089');

/* -----------------------
   Code Group: ALL_Subtotal_colectomy
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Subtotal_colectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Subtotal_colectomy;

CREATE TABLE #CodeGroup_ALL_Subtotal_colectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Subtotal_colectomy
(
    Code
)
VALUES
('H052'),
('H053'),
('H058'),
('H059');

/* -----------------------
   Code Group: ALL_Ventral_hernia_repair
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Ventral_hernia_repair') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Ventral_hernia_repair;

CREATE TABLE #CodeGroup_ALL_Ventral_hernia_repair
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Ventral_hernia_repair
(
    Code
)
VALUES
('T271'),
('T272'),
('T273'),
('T278'),
('T279');

/* -----------------------
   Code Group: ALL_Incisional_hernia
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Incisional_hernia') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Incisional_hernia;

CREATE TABLE #CodeGroup_ALL_Incisional_hernia
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Incisional_hernia
(
    Code
)
VALUES
('K430'),
('K431'),
('K432');

/* -----------------------
   Code Group: ALL_Cholecystectomy
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Cholecystectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Cholecystectomy;

CREATE TABLE #CodeGroup_ALL_Cholecystectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Cholecystectomy
(
    Code
)
VALUES
('J181'),
('J182'),
('J183'),
('J184'),
('J185'),
('J188'),
('J189');

/* -----------------------
   Code Group: ALL_Cancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Cancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Cancer;

CREATE TABLE #CodeGroup_ALL_Cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Cancer
(
    Code
)
VALUES
('C');

/* -----------------------
   Code Group: ALL_Appendectomy
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Appendectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Appendectomy;

CREATE TABLE #CodeGroup_ALL_Appendectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Appendectomy
(
    Code
)
VALUES
('H012'),
('H013');

/* -----------------------
   Code Group: ALL_OvarianCancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_OvarianCancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_OvarianCancer;

CREATE TABLE #CodeGroup_ALL_OvarianCancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_OvarianCancer
(
    Code
)
VALUES
('C56');

/* -----------------------
   Code Group: ALL_FallopianCancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_FallopianCancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_FallopianCancer;

CREATE TABLE #CodeGroup_ALL_FallopianCancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_FallopianCancer
(
    Code
)
VALUES
('C570');


/* -----------------------
   Code Group: ALL_RevisionOperations
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_RevisionOperations') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_RevisionOperations;

CREATE TABLE #CodeGroup_ALL_RevisionOperations
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_RevisionOperations
(
    Code
)
VALUES
('Y713'),
('Y716'),
('Y717');

/* -----------------------
   Code Group: ALL_ColonCancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_ColonCancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_ColonCancer;

CREATE TABLE #CodeGroup_ALL_ColonCancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_ColonCancer
(
    Code
)
VALUES
('C180'),
('C181'),
('C182'),
('C183'),
('C184'),
('C185'),
('C186'),
('C187'),
('C188'),
('C189');

/* -----------------------
   Code Group: ALL_AnteriorResection
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_AnteriorResection') IS NOT NULL
    DROP TABLE #CodeGroup_AnteriorResection;

CREATE TABLE #CodeGroup_AnteriorResection
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AnteriorResection
(
    Code
)
VALUES
('H333'),
('H334'),
('H336');

/* -----------------------
   Code Group: ALL_Oesophago_gastric_cancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_Oesophago_gastric_cancer') IS NOT NULL
    DROP TABLE #CodeGroup_Oesophago_gastric_cancer;

CREATE TABLE #CodeGroup_Oesophago_gastric_cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Oesophago_gastric_cancer
(
    Code
)
VALUES
('C150'),
('C151'),
('C152'),
('C153'),
('C154'),
('C155'),
('C158'),
('C159'),
('C160'),
('C161'),
('C162'),
('C163'),
('C164'),
('C165'),
('C166'),
('C168'),
('C169');

/* -----------------------
   Code Group: ALL_Panproctocolectomy
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Panproctocolectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Panproctocolectomy;

CREATE TABLE #CodeGroup_ALL_Panproctocolectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Panproctocolectomy
(
    Code
)
VALUES
('H041'),
('H042'),
('H043'),
('H048'),
('H049');

/* -----------------------
   Code Group: ALL_Abdominoperineal_Resection
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Abdominoperineal_Resection') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Abdominoperineal_Resection;

CREATE TABLE #CodeGroup_ALL_Abdominoperineal_Resection
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Abdominoperineal_Resection
(
    Code
)
VALUES
('H331');

/* -----------------------
   Code Group: ALL_Sigmoid_Colectomy
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Sigmoid_Colectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Sigmoid_Colectomy;

CREATE TABLE #CodeGroup_ALL_Sigmoid_Colectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Sigmoid_Colectomy
(
    Code
)
VALUES
('H101'),
('H102'),
('H103'),
('H104'),
('H105'),
('H106'),
('H108'),
('H109');

/* -----------------------
   Code Group: ALL_Left_Hemicolectomy
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Left_Hemicolectomy') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Left_Hemicolectomy;

CREATE TABLE #CodeGroup_ALL_Left_Hemicolectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Left_Hemicolectomy
(
    Code
)
VALUES
('H091'),
('H092'),
('H093'),
('H094'),
('H095'),
('H096'),
('H098'),
('H099');

/* -----------------------
   Code Group: ALL_Other_Colon_Resections
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Other_Colon_Resections') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Other_Colon_Resections;

CREATE TABLE #CodeGroup_ALL_Other_Colon_Resections
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Other_Colon_Resections
(
    Code
)
VALUES
('H111'),
('H112'),
('H113'),
('H114'),
('H115'),
('H116'),
('H118'),
('H119'),
('H291'),
('H292'),
('H293'),
('H294'),
('H298'),
('H299'),
('H501'),
('H502'),
('H503'),
('H508'),
('H509');

/* -----------------------
   Code Group: ALL_Rectosigmoid_Cancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Rectosigmoid_Cancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Rectosigmoid_Cancer;

CREATE TABLE #CodeGroup_ALL_Rectosigmoid_Cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Rectosigmoid_Cancer
(
    Code
)
VALUES
('C19X');

/* -----------------------
   Code Group: ALL_Rectal_Cancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Rectal_Cancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Rectal_Cancer;

CREATE TABLE #CodeGroup_ALL_Rectal_Cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Rectal_Cancer
(
    Code
)
VALUES
('C20X');

/* -----------------------
   Code Group: ALL_Liver_Resection
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Liver_Resection') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Liver_Resection;

CREATE TABLE #CodeGroup_ALL_Liver_Resection
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Liver_Resection
(
    Code
)
VALUES
('J021'),
('J022'),
('J023'),
('J024'),
('J025'),
('J026'),
('J027'),
('J028'),
('J029'),
('J035');

/* -----------------------
   Code Group: ALL_Excision_Lesion_Liver
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Excision_Lesion_Liver') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Excision_Lesion_Liver;

CREATE TABLE #CodeGroup_ALL_Excision_Lesion_Liver
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Excision_Lesion_Liver
(
    Code
)
VALUES
('J031');

/* -----------------------
   Code Group: Whipple_Pancreaticoduodenectomy
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_Whipple_Pancreaticoduodenectomy') IS NOT NULL
    DROP TABLE #CodeGroup_Whipple_Pancreaticoduodenectomy;

CREATE TABLE #CodeGroup_Whipple_Pancreaticoduodenectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Whipple_Pancreaticoduodenectomy
(
    Code
)
VALUES
('J562');

/* -----------------------
   Code Group: ALL_Primary_liver_cell_cancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Primary_liver_cell_cancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Primary_liver_cell_cancer;

CREATE TABLE #CodeGroup_ALL_Primary_liver_cell_cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Primary_liver_cell_cancer
(
    Code
)
VALUES
('C220');

/* -----------------------
   Code Group: ALL_Other_Primary_liver_cancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Other_Primary_liver_cancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Other_Primary_liver_cancer;

CREATE TABLE #CodeGroup_ALL_Other_Primary_liver_cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Other_Primary_liver_cancer
(
    Code
)
VALUES
('C222'),
('C223'),
('C224'),
('C227'),
('C229');

/* -----------------------
   Code Group: ALL_Secondary_liver_cancer
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_ALL_Secondary_liver_cancer') IS NOT NULL
    DROP TABLE #CodeGroup_ALL_Secondary_liver_cancer;

CREATE TABLE #CodeGroup_ALL_Secondary_liver_cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ALL_Secondary_liver_cancer
(
    Code
)
VALUES
('C787');

/* -----------------------
   Code Group: Revision of Urinary Diversion
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_RevisionOfUrinaryDiversion') IS NOT NULL
    DROP TABLE #CodeGroup_RevisionOfUrinaryDiversion;

CREATE TABLE #CodeGroup_RevisionOfUrinaryDiversion
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_RevisionOfUrinaryDiversion
(
    Code
)
VALUES
('M193');

/* -----------------------
   Code Group: Mesh Procedures
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_MeshProcedures') IS NOT NULL
    DROP TABLE #CodeGroup_MeshProcedures;

CREATE TABLE #CodeGroup_MeshProcedures
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_MeshProcedures
(
    Code
)
VALUES
('T251'),
('T271');

/* -----------------------
   Code Group: Primary inguinal hernia repair
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_Primary_inguinal_hernia_repair') IS NOT NULL
    DROP TABLE #CodeGroup_Primary_inguinal_hernia_repair;

CREATE TABLE #CodeGroup_Primary_inguinal_hernia_repair
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Primary_inguinal_hernia_repair
(
    Code
)
VALUES
('T201'),
('T202'),
('T203'),
('T204'),
('T208'),
('T209');

/* -----------------------
   Code Group: Recurrent inguinal hernia repair
----------------------- */

IF OBJECT_ID('tempdb..#CodeGroup_Recurrent_inguinal_hernia_repair') IS NOT NULL
    DROP TABLE #CodeGroup_Recurrent_inguinal_hernia_repair;

CREATE TABLE #CodeGroup_Recurrent_inguinal_hernia_repair
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Recurrent_inguinal_hernia_repair
(
    Code
)
VALUES
('T211'),
('T212'),
('T213'),
('T214'),
('T218'),
('T219');

/* -----------------------
   Code Group: Haemorrhoid_surgery
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Haemorrhoid_surgery') IS NOT NULL
    DROP TABLE #CodeGroup_Haemorrhoid_surgery;

CREATE TABLE #CodeGroup_Haemorrhoid_surgery
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Haemorrhoid_surgery (Code)
VALUES
('H511'),
('H512'),
('H513'),
('H518'),
('H519'),
('H521'),
('H522'),
('H523'),
('H524'),
('H528'),
('H529');

/* -----------------------
   Code Group: Ligation_of_artery
----------------------- */
IF OBJECT_ID('tempdb..#CodeGroup_Ligation_of_artery') IS NOT NULL
    DROP TABLE #CodeGroup_Ligation_of_artery;

CREATE TABLE #CodeGroup_Ligation_of_artery
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Ligation_of_artery (Code)
VALUES
('L703');

-- ========================================
-- Step 4: Create the #Spells_With_Variables Table
-- ========================================

-- Step 4.1: Create the #Spells_With_Variables Table

IF OBJECT_ID('tempdb..#Spells_With_Variables') IS NOT NULL
    DROP TABLE #Spells_With_Variables;

CREATE TABLE #Spells_With_Variables
(
    -- Basic Spell Information
    Spell_Number VARCHAR(20),
    Episode_Number VARCHAR(50),
    Sector VARCHAR(10),
    Org_Code_Provider VARCHAR(10),
    National_POD VARCHAR(10),
    Admission_Sub_Type VARCHAR(10),
    Admission_Date DATE,
    Discharge_Date DATE,
    Age INT,
    Spell_LOS INT,
    Method_Of_Discharge_Code VARCHAR(10),
    POD_Derived VARCHAR(50),
    PAS_Number VARCHAR(50),
    TRETSPEF VARCHAR(10),
    MAINSPEF VARCHAR(10),
    SpellDominantProcedure_Current VARCHAR(50), -- Increased from VARCHAR(10) to VARCHAR(50)
    Diagnosis_Code_Primary VARCHAR(20),
                                                -- Variables from Recipes
    GenS_UnlikelyNonSpec VARCHAR(50),
    GenS_UlcerativeColitis VARCHAR(50),
    GenS_TreatmentFunction VARCHAR(50),
    GenS_Strictureplasty VARCHAR(50),
    GenS_StomaReversal VARCHAR(50),
    GenS_StomaCreation VARCHAR(50),
    GenS_ResectionSmallBowel VARCHAR(50),
    GenS_Reflux VARCHAR(50),
    GenS_RectoVaginalFistula VARCHAR(50),
    GenS_Rectopexy VARCHAR(50),
    GenS_RectalExcision VARCHAR(50),
    GenS_Radiotherapy VARCHAR(50),
    GenS_ProcUndiffAbdom VARCHAR(50),
    GenS_ProcUlcerColitis VARCHAR(50),
    GenS_ProcSmallBowelObstruct VARCHAR(50),
    GenS_ProcPerianalAbcess VARCHAR(50),
    GenS_ProcLargeBowelObstruct VARCHAR(50),
    GenS_ProcDiverticulitis VARCHAR(50),
    GenS_PerianalProcCrohnDisease VARCHAR(50),
    GenS_PerianalAbcess VARCHAR(50),
    GenS_PelvicFloor VARCHAR(50),
    GenS_Pancreatitis VARCHAR(50),
    GenS_OtherColonicResection VARCHAR(50),
    GenS_Obesity VARCHAR(50),
    GenS_NoProc VARCHAR(50),
    GenS_NerveStimPelvicFloor VARCHAR(50),
    GenS_MinimalAccess VARCHAR(50),
    GenS_MainSpecialty VARCHAR(50),
    GenS_LateralAorta VARCHAR(50),
    GenS_IncisionalHerniaRepair VARCHAR(50),
    GenS_ImagingTestDrugsTherapy VARCHAR(50),
    GenS_IleorectalAnastom VARCHAR(50),
    GenS_IleocaecalResection VARCHAR(50),
    GenS_HospitalAcqCond VARCHAR(50),
    GenS_HiatusHernia VARCHAR(50),
    GenS_Haemorrhoids VARCHAR(50),
    GenS_GeneralSurgery VARCHAR(50),
    GenS_FemoralHernia VARCHAR(50),
    GenS_EMLaparotomyLaparoscopy VARCHAR(100),
    GenS_EMLaparotomy_NELA VARCHAR(50),
    GenS_Diverticulitis VARCHAR(50),
    GenS_CrohnDisease VARCHAR(50),
    GenS_ComplicationGenS VARCHAR(50),
    GenS_ColorectalCancer VARCHAR(50),
    GenS_LocalExcColorectCancer VARCHAR(50),
    GenS_ColonicStent VARCHAR(50),
    GenS_Colectomy VARCHAR(50),
    GenS_Cholecystitis VARCHAR(50),
    GenS_ColonicResection_Cancer VARCHAR(50),
    GenS_Cholecystectomy VARCHAR(50),
    GenS_Chemotherapy VARCHAR(50),
    GenS_Cancer VARCHAR(50),
    GenS_ResectionCrohns VARCHAR(50),
    GenS_BowelObstruct VARCHAR(50),
    GenS_Bilateral VARCHAR(50),
    GenS_BenignLiverTumour VARCHAR(50),
    GenS_Appendicitis VARCHAR(50),
    GenS_Appendectomy VARCHAR(50),
    GenS_AdvIncidentGenS VARCHAR(50),
    GenS_AbdomPain VARCHAR(50),
    GenS_AgeGroup VARCHAR(50),
    GenS_Cancel VARCHAR(50),
                                                --Flags
    Read30 BIT
        DEFAULT 0,
    Read90 BIT
        DEFAULT 0,
    Mort BIT
        DEFAULT 0,
    Mort30 BIT
        DEFAULT 0,
    Mort90 BIT
        DEFAULT 0,
    Mort180 BIT
        DEFAULT 0,
    Mort1yr BIT
        DEFAULT 0,
    GenS_FLAG_DiagTreatPeriod INT
        DEFAULT 0,
    GenS_FLAG_AdmTreatPeriod INT
        DEFAULT 0,
    GenS_FLAG_PreOpRadiotherapy12wks BIT
        DEFAULT 0,
    GenS_FLAG_StomaRev18mths BIT
        DEFAULT 0,
    GenS_FLAG_NoProc_Spell BIT
        DEFAULT 0,
    GenS_FLAG_BowelProc_Spell BIT
        DEFAULT 0,
    GenS_FLAG_ThProcUndiffAbdom_Spell BIT
        DEFAULT 0,
    GenS_FLAG_ThProcDiverticulitis_Spell BIT
        DEFAULT 0,
    GenS_FLAG_ComplicationGenS_Spell BIT
        DEFAULT 0,
    GenS_FLAG_AdvIncidentGenS_Spell BIT
        DEFAULT 0,
    GenS_FLAG_Complication30 BIT
        DEFAULT 0,
    GenS_FLAG_Complication30_Return BIT
        DEFAULT 0,
    GenS_SurgOnAdm BIT
        DEFAULT 0,
    GenS_Read3SS BIT
        DEFAULT 0,
    GenS_FLAG_CholePrior BIT
        DEFAULT 0,
    GenS_FLAG_CholeTreat14 BIT
        DEFAULT 0,
    GenS_FLAG_CholeReop30 BIT
        DEFAULT 0,
    GenS_FLAG_FirstDiagObstruction BIT
        DEFAULT 0,
    GenS_FLAG_DiagTreat BIT
        DEFAULT 0,
    GenS_FLAG_DiagTreatLarge BIT
        DEFAULT 0,
    GenS_FLAG_DiagTreatSmall BIT
        DEFAULT 0,
    GenS_FLAG_CholeTreat14_DC BIT
        DEFAULT 0,
    GenS_FLAG_OPFU90 BIT
        DEFAULT 0
);

-- Step 4.2: Populate the #Spells_With_Variables Table with Initial Data

INSERT INTO #Spells_With_Variables
(
    Spell_Number,
    Episode_Number,
    Sector,
    Org_Code_Provider,
    National_POD,
    Admission_Sub_Type,
    Admission_Date,
    Discharge_Date,
    Age,
    Spell_LOS,
    Method_Of_Discharge_Code,
    POD_Derived,
    PAS_Number,
    TRETSPEF,
    MAINSPEF,
    SpellDominantProcedure_Current,
    Diagnosis_Code_Primary
)
SELECT ips.Spell_Number,
       ipe.Episode_Number,
       ips.Sector,
       ips.Org_Code_Provider,
       ips.National_POD,
       ips.Admission_Sub_Type,
       ips.Admission_Date,
       ips.Discharge_Date,
       ips.Age_On_Admission AS Age,
       ips.Length_Of_Stay AS Spell_LOS,
       ips.Method_Of_Discharge_Code,
       -- POD_Derived
       CASE
           WHEN ips.National_POD IN ( 'DC', 'EL' ) THEN
               ips.National_POD
           WHEN ips.National_POD LIKE '%RA%' THEN
               'RA'
           WHEN ips.Admission_Sub_Type = 'EMR' THEN
               'EM'
           ELSE
               'Other'
       END AS POD_Derived,
       ips.PAS_Number,
       ips.Admission_Treatment_Function_Code AS TRETSPEF,
       ipe.Main_Specialty_Code AS MAINSPEF,
       ips.Spell_Dominant_Procedure_Code AS SpellDominantProcedure_Current,
       ips.Spell_Primary_Diagnosis_Code AS Diagnosis_Code_Primary
FROM [PAS_IP_Spell_Frozen] ips
    LEFT JOIN [PAS_IP_Episode_Frozen] ipe
        ON ips.Spell_Number = ipe.Spell_Number
           AND ips.Sector = ipe.Sector
WHERE ips.Admission_Date
BETWEEN @OverallStartDate AND @OverallEndDate;

-- Update GenS_UnlikelyNonSpec
UPDATE SWV
SET GenS_UnlikelyNonSpec = 'Unlikely or non-specific diagnosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_UnlikelyNonSpec_3
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_UnlikelyNonSpec_4
                 )
          )
);

-- Update GenS_UlcerativeColitis
-- Priority 1: Ulcerative colitis primary diagnosis
UPDATE SWV
SET GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Ulcerative_colitis
              )
);

-- Priority 2: Ulcerative colitis secondary diagnosis
UPDATE SWV
SET GenS_UlcerativeColitis = 'Ulcerative colitis secondary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 2 AND 20
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Ulcerative_colitis
              )
);

-- Update GenS_TreatmentFunction
UPDATE SWV
SET GenS_TreatmentFunction = 'General surgery'
FROM #Spells_With_Variables SWV
WHERE SWV.TRETSPEF IN
      (
          SELECT Code FROM #CodeGroup_TFC_Code_1
      );

-- Update GenS_Strictureplasty
UPDATE SWV
SET GenS_Strictureplasty = 'Strictureplasty'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Strictureplasty_4
              )
);

-- Update GenS_StomaReversal
UPDATE SWV
SET GenS_StomaReversal = 'Stoma reversal'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_StomaReversal_4
              )
);

-- Update GenS_StomaCreation
UPDATE SWV
SET GenS_StomaCreation = 'Stoma creation'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Stoma_creation
              )
);

-- Update GenS_ResectionSmallBowel
UPDATE SWV
SET GenS_ResectionSmallBowel = 'Resection of the small bowel'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ResectionSmallBowel_3
              )
);

-- Update GenS_Reflux
-- Priority 1: Anti-reflux primary diagnosis
UPDATE SWV
SET GenS_Reflux = 'Anti-reflux primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Anti_reflux
              )
);

-- Priority 2: Anti-reflux secondary diagnosis
UPDATE SWV
SET GenS_Reflux = 'Anti-reflux secondary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Reflux IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 2 AND 20
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Anti_reflux
              )
);

UPDATE SWV
SET GenS_RectoVaginalFistula = 'Recto-vaginal fistula'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_RectoVaginalFistula_4
              )
);

-- Priority 1: Other excision
UPDATE SWV
SET GenS_Rectopexy = 'Other excision'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Rectopexy_4_1
              )
);

-- Priority 2: Ventral mesh
UPDATE SWV
SET GenS_Rectopexy = 'Ventral mesh'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Rectopexy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Rectopexy_4_2
              )
);

-- Priority 1: Hartmann's
UPDATE SWV
SET GenS_RectalExcision = 'Hartmann''s'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Hartmanns
              )
);

-- Priority 2: Rectal excision
UPDATE SWV
SET GenS_RectalExcision = 'Rectal excision'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_RectalExcision IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_RectalExcision_3
              )
);

-- Priority 3: Perianal surgery
UPDATE SWV
SET GenS_RectalExcision = 'Perianal surgery'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_RectalExcision IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_PeranalSurgery_4
              )
);

UPDATE SWV
SET GenS_Radiotherapy = CASE
                            WHEN LEFT(SWV.SpellDominantProcedure_Current, 3)IN
                                 (
                                     SELECT Code FROM #CodeGroup_Radiotherapy_3
                                 ) THEN
                                'Radiotherapy dominant procedure'
                            WHEN EXISTS
                                 (
                                     SELECT 1
                                     FROM [PAS_IP_Episode_Frozen] ipe
                                         INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                                             ON ipe.Episode_Number = ipp.Episode_Number
                                                AND ipe.Sector = ipp.Sector
                                     WHERE ipe.Spell_Number = SWV.Spell_Number
                                           AND ipe.Sector = SWV.Sector
                                           AND LEFT(ipp.Procedure_Code, 3)IN
                                               (
                                                   SELECT Code FROM #CodeGroup_Radiotherapy_3
                                               )
                                 ) THEN
                                'Radiotherapy secondary procedure'
                            ELSE
                                GenS_Radiotherapy -- Retain existing value if none of the conditions match
                        END
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Radiotherapy IS NULL;

-- Recipe 7: Update GenS_ProcUndiffAbdom
-- Priority 1: Therapeutic procedure
UPDATE SWV
SET GenS_ProcUndiffAbdom = 'Therapeutic procedure'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp.Procedure_Code, 1)IN
              (
                  SELECT Code FROM #CodeGroup_Gastrointestinal_1
              )
              OR LEFT(ipp.Procedure_Code, 1)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_1
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_3
                 )
          )
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AbdominalPain_4
              )
);

-- Priority 2: Diagnostic procedure only
UPDATE SWV
SET GenS_ProcUndiffAbdom = 'Diagnostic procedure only'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ProcUndiffAbdom IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 1
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Gastrointestinal_Specific_3
              )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_Specific_3
                 )
              OR LEFT(ipp.Procedure_Code, 2)IN
                 (
                     SELECT Code FROM #CodeGroup_ImagingTestsDrugsTherapy_2
                 )
          )
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AbdominalPain_4
              )
);
-- Priority 3: No procedure
UPDATE SWV
SET GenS_ProcUndiffAbdom = 'No procedure'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ProcUndiffAbdom IS NULL
      AND SWV.SpellDominantProcedure_Current IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AbdominalPain_4
              )
);

-- Priority 1: Colectomy and ileostomy
UPDATE SWV
SET GenS_ProcUlcerColitis = 'Colectomy and ileostomy'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ProcUlcerColitis_4_1
              )
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Ulcerative_colitis
              )
);

-- Priority 2: Pouch surgery
UPDATE SWV
SET GenS_ProcUlcerColitis = 'Pouch surgery'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ProcUlcerColitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ProcUlcerColitis_4_2
              )
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Ulcerative_colitis
              )
);

UPDATE SWV
SET GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcSmallBowelObstruct_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcSmallBowelObstruct_4
                 )
          )
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_BowelObstruct_4
              )
);

UPDATE SWV
SET GenS_ProcPerianalAbcess = 'Procedure for perianal abscess'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ProcPerianalAbcess_4
              )
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_PerianalAbcess_3
              )
);

-- Recipe 11: Update GenS_ProcLargeBowelObstruct
UPDATE SWV
SET GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_4
                 )
          )
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_BowelObstruct_4
              )
);

-- Recipe 12: Update GenS_ProcDiverticulitis
-- Priority 1: Therapeutic procedure
UPDATE SWV
SET GenS_ProcDiverticulitis = 'Therapeutic procedure'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipp.Procedure_Code, 1)IN
              (
                  SELECT Code FROM #CodeGroup_Gastrointestinal_1
              )
              OR LEFT(ipp.Procedure_Code, 1)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_1
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_3
                 )
          )
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Diverticulitis_3
              )
);

-- Priority 2: Diagnostic procedure only
UPDATE SWV
SET GenS_ProcDiverticulitis = 'Diagnostic procedure only'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ProcDiverticulitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Gastrointestinal_Specific_3
              )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_Specific_3
                 )
              OR LEFT(ipp.Procedure_Code, 2)IN
                 (
                     SELECT Code FROM #CodeGroup_ImagingTestsDrugsTherapy_2
                 )
          )
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Diverticulitis_3
              )
);

-- Priority 3: No procedure
UPDATE SWV
SET GenS_ProcDiverticulitis = 'No procedure'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ProcDiverticulitis IS NULL
      AND SWV.SpellDominantProcedure_Current IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Diverticulitis_3
              )
);

-- Recipe 13: Update GenS_PerianalProcCrohnDisease
UPDATE SWV
SET GenS_PerianalProcCrohnDisease = 'Perianal procedure for Crohn''s disease'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_PerianalProcCrohnDisease_4
              )
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Crohns_disease
              )
);

-- Recipe 14: Update GenS_PerianalAbcess
-- Priority 1: Perianal abscess primary diagnosis
UPDATE SWV
SET GenS_PerianalAbcess = 'Perianal abscess primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_PerianalAbcess_3
              )
);

-- Priority 2: Perianal abscess secondary diagnosis
UPDATE SWV
SET GenS_PerianalAbcess = 'Perianal abscess secondary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_PerianalAbcess IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 2 AND 20
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_PerianalAbcess_3
              )
);

-- Recipe 15: Update GenS_PelvicFloor
UPDATE SWV
SET GenS_PelvicFloor = 'Body_PelvicFloor'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_PelvicFloor_4
              )
);

-- Recipe 16: Update GenS_Pancreatitis
-- Priority 1: Acute gallstone pancreatitis
UPDATE SWV
SET GenS_Pancreatitis = 'Acute gallstone pancreatitis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd1
            ON ipe.Episode_Number = ipd1.Episode_Number
               AND ipe.Sector = ipd1.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd2
            ON ipe.Episode_Number = ipd2.Episode_Number
               AND ipe.Sector = ipd2.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd1.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Pancreatitis_3
              )
          AND LEFT(ipd2.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_GallStones_3
              )
);

-- Priority 2: Acute pancreatitis
UPDATE SWV
SET GenS_Pancreatitis = 'Acute pancreatitis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Pancreatitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Pancreatitis_3
              )
);

-- Priority 3: Chronic pancreatitis
UPDATE SWV
SET GenS_Pancreatitis = 'Chronic pancreatitis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Pancreatitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Pancreatitis_4
              )
);

-- Recipe 17: Update GenS_OtherColonicResection
-- Priority 1: Rectal surgery
UPDATE SWV
SET GenS_OtherColonicResection = 'Rectal surgery'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_RectalSurgery_4
              )
);

-- Priority 2: Exenteration of pelvis
UPDATE SWV
SET GenS_OtherColonicResection = 'Exenteration of pelvis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ExenterationPelvis_4
              )
);

-- Priority 3: Other anastomosis of colon
UPDATE SWV
SET GenS_OtherColonicResection = 'Other anastomosis of colon'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AnastomosisColon_4
              )
);

-- Priority 4: Other total colon excision
UPDATE SWV
SET GenS_OtherColonicResection = 'Other total colon excision'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OtherColonExcision_3
              )
);

-- Priority 5: Subtotal colon excision
UPDATE SWV
SET GenS_OtherColonicResection = 'Subtotal colon excision'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_SubTotalColonExcision_3
              )
);

-- Recipe 18: Update GenS_Obesity
-- Priority 1: Primary Obesity
UPDATE SWV
SET GenS_Obesity = 'Primary Obesity'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Obesity
              )
);

-- Priority 2: Obesity comorbidity
UPDATE SWV
SET GenS_Obesity = 'Obesity comorbidity'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Obesity IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 2 AND 20
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Obesity
              )
);

-- Recipe 19: Update GenS_NoProc
UPDATE SWV
SET GenS_NoProc = 'No Procedure'
FROM #Spells_With_Variables SWV
WHERE SWV.SpellDominantProcedure_Current IS NULL;

-- Recipe 20: Update GenS_NerveStimPelvicFloor
UPDATE SWV
SET GenS_NerveStimPelvicFloor = 'Nerve stimulation of the pelvic floor'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp1
            ON ipe.Episode_Number = ipp1.Episode_Number
               AND ipe.Sector = ipp1.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp2
            ON ipe.Episode_Number = ipp2.Episode_Number
               AND ipe.Sector = ipp2.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp1.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_NerveStimPelvicFloor_4
              )
          AND LEFT(ipp2.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_PelvicFloor_4
              )
);

-- Recipe 21: Update GenS_MinimalAccess
-- Priority 1: Conversion to open approach
UPDATE SWV
SET GenS_MinimalAccess = 'Conversion to open approach'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_ConversionOpen_4
              )
);

-- Recipe 22: Update GenS_MinimalAccess
-- Priority 2: Laparoscopically assisted
UPDATE SWV
SET GenS_MinimalAccess = 'Laparoscopically assisted'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_MinimalAccess IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_LapAssist_4
              )
);

-- Recipe 23: Update GenS_MinimalAccess
-- Priority 3: Laparoscopic approach
UPDATE SWV
SET GenS_MinimalAccess = 'Laparoscopic approach'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_MinimalAccess IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_LapApproach_4
              )
);

-- Recipe 24: Update GenS_MinimalAccess
-- Priority 4: Robotic approach
UPDATE SWV
SET GenS_MinimalAccess = 'Robotic approach'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_MinimalAccess IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_Robotic_4
              )
);

-- Recipe 25: Update GenS_MinimalAccess
-- Priority 5: Other minimal access approach
UPDATE SWV
SET GenS_MinimalAccess = 'Other minimal access approach'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_MinimalAccess IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_MinimalAccess_4
              )
);

-- Recipe 26: Update GenS_MinimalAccess
-- Priority 6: Laparotomy
UPDATE SWV
SET GenS_MinimalAccess = 'Laparotomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_MinimalAccess IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_Laparotomy_4
              )
);

-- Recipe 27: Update GenS_MinimalAccess
-- Priority 7: Approach to organ through abdomen
UPDATE SWV
SET GenS_MinimalAccess = 'Approach to organ through abdomen'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_MinimalAccess IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_AbdomenOther_4
              )
);

-- Recipe 28: Update GenS_MinimalAccess
-- Priority 8: Approach to organ other cavity
UPDATE SWV
SET GenS_MinimalAccess = 'Approach to organ other cavity'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_MinimalAccess IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_App_AbdomenOther_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_App_EndoOtherBodyCavity_4
                 )
          )
);

-- Recipe 29: Update GenS_MainSpecialty
UPDATE SWV
SET GenS_MainSpecialty = 'General surgery'
FROM #Spells_With_Variables SWV
WHERE SWV.MAINSPEF IN
      (
          SELECT Code FROM #CodeGroup_MainSpec_1
      );

-- Recipe 30: Update GenS_LateralAorta
UPDATE SWV
SET GenS_LateralAorta = 'Body_LateralAorta'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Lateral_branch_of_abdominal_aorta
              )
);

-- Recipe 31: Update GenS_IncisionalHerniaRepair
UPDATE SWV
SET GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        LEFT JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Incisional_hernia_repair
              )
              OR
              (
                  LEFT(ipp.Procedure_Code, 4)IN
                  (
                      SELECT Code FROM #CodeGroup_ALL_Ventral_hernia_repair
                  )
                  AND LEFT(ipd.Diagnosis_Code, 4)IN
                      (
                          SELECT Code FROM #CodeGroup_ALL_Incisional_hernia
                      )
              )
          )
);

-- Recipe 32: Update GenS_ImagingTestDrugsTherapy
UPDATE SWV
SET GenS_ImagingTestDrugsTherapy = 'ImagingTestDrugsTherapy'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 2)IN
              (
                  SELECT Code FROM #CodeGroup_ImagingTestsDrugsTherapy_2
              )
);


-- Recipe 33: Update GenS_IleorectalAnastom
UPDATE SWV
SET GenS_IleorectalAnastom = 'Ileorectal anastomosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_IleorectalAnastom_4
              )
);

-- Recipe 34: Update GenS_IleocaecalResection
UPDATE SWV
SET GenS_IleocaecalResection = 'Ileocaecal resection'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_IleocaecalResection_4
              )
);

-- Recipe 35: Update GenS_HospitalAcqCond
UPDATE SWV
SET GenS_HospitalAcqCond = 'Hospital acquired condition'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_HospitalAcqCond_3
              )
);


-- Recipe 36: Update GenS_HiatusHernia
-- Priority 1: Hiatus hernia primary diagnosis
UPDATE SWV
SET GenS_HiatusHernia = 'Hiatus hernia primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_HiatusHernia_3
              )
);

-- Priority 2: Hiatus hernia secondary diagnosis
UPDATE SWV
SET GenS_HiatusHernia = 'Hiatus hernia secondary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_HiatusHernia IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 2 AND 20
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_HiatusHernia_3
              )
);

-- Recipe 37: Update GenS_Haemorrhoids
-- Priority 1: Haemorrhoids primary diagnosis
UPDATE SWV
SET GenS_Haemorrhoids = 'Haemorrhoids primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Haemorrhoids
              )
);

-- Priority 2: Haemorrhoids secondary diagnosis
UPDATE SWV
SET GenS_Haemorrhoids = 'Haemorrhoids secondary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Haemorrhoids IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 2 AND 20
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Haemorrhoids
              )
);

-- Recipe 38: Update GenS_GeneralSurgery
-- Priority 1: Gastrointestinal procedure
UPDATE SWV
SET GenS_GeneralSurgery = 'Gastrointestinal procedure'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Gastrointestinal_Specific_3
              )
              OR LEFT(ipp.Procedure_Code, 1)IN
                 (
                     SELECT Code FROM #CodeGroup_Gastrointestinal_1
                 )
          )
);

-- Priority 2: Abdominal organ procedure
UPDATE SWV
SET GenS_GeneralSurgery = 'Abdominal organ procedure'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_GeneralSurgery IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Abdominal_Organ_Specific_3
              )
              OR LEFT(ipp.Procedure_Code, 1)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_1
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_3
                 )
          )
);

-- Recipe 39: Update GenS_FemoralHernia
-- Priority 1: Femoral hernia primary diagnosis
UPDATE SWV
SET GenS_FemoralHernia = 'Femoral hernia primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_FemoralHernia_3
              )
);

-- Priority 2: Femoral hernia secondary diagnosis
UPDATE SWV
SET GenS_FemoralHernia = 'Femoral hernia secondary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_FemoralHernia IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 2 AND 20
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_FemoralHernia_3
              )
);

-- Recipe 40: Update GenS_EMLaparotomyLaparoscopy
-- Priority 1: EM Laparotomy - Conversion from laparoscopy to laparotomy
UPDATE SWV
SET GenS_EMLaparotomyLaparoscopy = 'EM Laparotomy - Conversion from laparoscopy to laparotomy'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp1
            ON ipe.Episode_Number = ipp1.Episode_Number
               AND ipe.Sector = ipp1.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp2
            ON ipe.Episode_Number = ipp2.Episode_Number
               AND ipe.Sector = ipp2.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp1.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND ipp2.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp1.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcForEMLaparotomy_3
              )
              OR LEFT(ipp1.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcForEMLaparotomy_4
                 )
          )
          AND LEFT(ipp2.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_ConversionOpen_4
              )
);

-- Priority 2: EM Laparotomy - Laparoscopically assisted
UPDATE SWV
SET GenS_EMLaparotomyLaparoscopy = 'EM Laparotomy - Laparoscopically assisted'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_EMLaparotomyLaparoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp1
            ON ipe.Episode_Number = ipp1.Episode_Number
               AND ipe.Sector = ipp1.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp2
            ON ipe.Episode_Number = ipp2.Episode_Number
               AND ipe.Sector = ipp2.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp1.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND ipp2.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp1.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcForEMLaparotomy_3
              )
              OR LEFT(ipp1.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcForEMLaparotomy_4
                 )
          )
          AND LEFT(ipp2.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_LapAssist_4
              )
);

-- Priority 3: EM Laparoscopy - Definitive (therapeutic)
UPDATE SWV
SET GenS_EMLaparotomyLaparoscopy = 'EM Laparoscopy - Definitive (therapeutic)'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_EMLaparotomyLaparoscopy IS NULL
      AND SWV.GenS_MinimalAccess NOT IN ( 'Other' )
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcForDefEMLaparotomy_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcForDefEMLaparotomy_4
                 )
          )
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcForDefEMLaparoscopy_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcForDefEMLaparoscopy_4
                 )
          )
          AND LEFT(ipp.Procedure_Code, 4) NOT IN
              (
                  SELECT Code FROM #CodeGroup_App_Laparotomy_4
              )
);

-- Priority 4: EM Laparoscopy - Non-definitive (diagnostic)
UPDATE SWV
SET GenS_EMLaparotomyLaparoscopy = 'EM Laparoscopy - Non-definitive (diagnostic)'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_EMLaparotomyLaparoscopy IS NULL
      AND SWV.GenS_MinimalAccess NOT IN ( 'Other' )
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcForNonDefEMLaparotomy_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcForNonDefEMLaparotomy_4
                 )
          )
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcForNonDefEMLaparoscopy_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcForNonDefEMLaparoscopy_4
                 )
          )
          AND LEFT(ipp.Procedure_Code, 4) NOT IN
              (
                  SELECT Code FROM #CodeGroup_App_Laparotomy_4
              )
);

-- Priority 5: EM Laparotomy - Definitive (therapeutic)
UPDATE SWV
SET GenS_EMLaparotomyLaparoscopy = 'EM Laparotomy - Definitive (therapeutic)'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_EMLaparotomyLaparoscopy IS NULL
      AND SWV.GenS_MinimalAccess NOT IN ( 'Other' )
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcForDefEMLaparotomy_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcForDefEMLaparotomy_4
                 )
          )
);

-- Priority 6: EM Laparotomy - Non-definitive (diagnostic)
UPDATE SWV
SET GenS_EMLaparotomyLaparoscopy = 'EM Laparotomy - Non-definitive (diagnostic)'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_EMLaparotomyLaparoscopy IS NULL
      AND SWV.GenS_MinimalAccess NOT IN ( 'Other' )
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcForNonDefEMLaparotomy_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcForNonDefEMLaparotomy_4
                 )
          )
);

-- Update GenS_EMLaparotomy_NELA to 'Yes' where inclusion criteria are met

UPDATE SWV
SET GenS_EMLaparotomy_NELA = 'EMLaparotomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_EMLaparotomy_NELA IS NULL
      AND
      (
          -- Condition 1
          EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 1 -- Positions 1-1
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_EMLap_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_EMLap_4
                 )
          )
)
          OR
          -- Condition 2
          (
              EXISTS
(
    -- First part of Condition 2
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp1
            ON ipe.Episode_Number = ipp1.Episode_Number
               AND ipe.Sector = ipp1.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND ipp1.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 1 -- Positions 1-1
          AND
          (
              LEFT(ipp1.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_EMLapHerniaProcs_3
              )
              OR LEFT(ipp1.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_EMLapHerniaProcs_4
                 )
          )
)
              AND EXISTS
(
    -- Second part of Condition 2
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe2
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp2
            ON ipe2.Episode_Number = ipp2.Episode_Number
               AND ipe2.Sector = ipp2.Sector
    WHERE ipe2.Spell_Number = SWV.Spell_Number
          AND ipe2.Sector = SWV.Sector
          AND ipp2.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24 -- Positions 1-24
          AND
          (
              LEFT(ipp2.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_EMLapHernia_3
              )
              OR LEFT(ipp2.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_EMLapHernia_4
                 )
          )
)
          )
          OR
          -- Condition 3
          (
              EXISTS
(
    -- First part of Condition 3
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe3
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp3
            ON ipe3.Episode_Number = ipp3.Episode_Number
               AND ipe3.Sector = ipp3.Sector
    WHERE ipe3.Spell_Number = SWV.Spell_Number
          AND ipe3.Sector = SWV.Sector
          AND ipp3.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 1 -- Positions 1-1
          AND
          (
              LEFT(ipp3.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_EMLapStomaConditions_3
              )
              OR LEFT(ipp3.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_EMLapStomaConditions_4
                 )
          )
)
              AND NOT EXISTS
(
    -- Exclusion within Condition 3
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe4
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp4
            ON ipe4.Episode_Number = ipp4.Episode_Number
               AND ipe4.Sector = ipp4.Sector
    WHERE ipe4.Spell_Number = SWV.Spell_Number
          AND ipe4.Sector = SWV.Sector
          AND ipp4.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24 -- Positions 1-24
          AND LEFT(ipp4.Procedure_Code, 4)IN
              (
                  SELECT Code
                  FROM #CodeGroup_App_LapAssist_4
                  UNION ALL
                  SELECT Code
                  FROM #CodeGroup_App_LapApproach_4
                  UNION ALL
                  SELECT Code
                  FROM #CodeGroup_App_Robotic_4
                  UNION ALL
                  SELECT Code
                  FROM #CodeGroup_App_MinimalAccess_4
              )
)
              AND EXISTS
(
    -- Second part of Condition 3
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe5
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp5
            ON ipe5.Episode_Number = ipp5.Episode_Number
               AND ipe5.Sector = ipp5.Sector
    WHERE ipe5.Spell_Number = SWV.Spell_Number
          AND ipe5.Sector = SWV.Sector
          AND ipp5.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24 -- Positions 1-24
          AND
          (
              LEFT(ipp5.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_EMLapStoma_3
              )
              OR LEFT(ipp5.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_EMLapStoma_4
                 )
          )
)
          )
          OR
          -- Condition 4
          (
              (
                  -- First part of Condition 4
                  EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe6
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp6
            ON ipe6.Episode_Number = ipp6.Episode_Number
               AND ipe6.Sector = ipp6.Sector
    WHERE ipe6.Spell_Number = SWV.Spell_Number
          AND ipe6.Sector = SWV.Sector
          AND ipp6.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 1 -- Positions 1-1
          AND LEFT(ipp6.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Incisional_hernia_repair
              )
)
                  OR
                  (
                      -- Second part of Condition 4
                      EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe7
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp7
            ON ipe7.Episode_Number = ipp7.Episode_Number
               AND ipe7.Sector = ipp7.Sector
    WHERE ipe7.Spell_Number = SWV.Spell_Number
          AND ipe7.Sector = SWV.Sector
          AND ipp7.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 1 -- Positions 1-1
          AND LEFT(ipp7.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Ventral_hernia_repair
              )
)
                      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe8
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd8
            ON ipe8.Episode_Number = ipd8.Episode_Number
               AND ipe8.Sector = ipd8.Sector
    WHERE ipe8.Spell_Number = SWV.Spell_Number
          AND ipe8.Sector = SWV.Sector
          AND ipd8.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 1 -- Positions 1-1
          AND LEFT(ipd8.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Incisional_hernia
              )
)
                  )
              )
              AND EXISTS
(
    -- Third part of Condition 4
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe9
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp9
            ON ipe9.Episode_Number = ipp9.Episode_Number
               AND ipe9.Sector = ipp9.Sector
    WHERE ipe9.Spell_Number = SWV.Spell_Number
          AND ipe9.Sector = SWV.Sector
          AND ipp9.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24 -- Positions 1-24
          AND
          (
              LEFT(ipp9.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_EMLapIncisional_3
              )
              OR LEFT(ipp9.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_EMLapIncisional_4
                 )
          )
)
          )
      );

-- Recipe 42: Update GenS_Diverticulitis
-- Priority 1: Diverticulitis primary diagnosis
UPDATE SWV
SET GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Diverticulitis_3
              )
);

-- Priority 2: Diverticulitis secondary diagnosis
UPDATE SWV
SET GenS_Diverticulitis = 'Diverticulitis secondary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Diverticulitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 2 AND 20
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Diverticulitis_3
              )
);

-- Recipe 43: Update GenS_CrohnDisease
-- Priority 1: Crohn's disease primary diagnosis
UPDATE SWV
SET GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Crohns_disease
              )
);

-- Priority 2: Crohn's disease secondary diagnosis
UPDATE SWV
SET GenS_CrohnDisease = 'Crohn''s disease secondary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 2 AND 20
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Crohns_disease
              )
);

-- Recipe 44: Update GenS_ComplicationGenS
UPDATE SWV
SET GenS_ComplicationGenS = 'Complication of surgery GenS'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ComplicationGenS_3
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ComplicationGenS_4
                 )
          )
);

-- Recipe 45: Update GenS_ColorectalCancer
-- Priority 1: Anal cancer
UPDATE SWV
SET GenS_ColorectalCancer = 'Anal cancer'
FROM #Spells_With_Variables SWV
WHERE LEFT(SWV.Diagnosis_Code_Primary, 3)IN
      (
          SELECT Code FROM #CodeGroup_ColorectalCancer_3_1
      );

-- Priority 2: Colon cancer
UPDATE SWV
SET GenS_ColorectalCancer = 'Colon cancer'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ColorectalCancer IS NULL
      AND LEFT(SWV.Diagnosis_Code_Primary, 3)IN
          (
              SELECT Code FROM #CodeGroup_ColorectalCancer_3_2
          );

-- Priority 3: Rectal cancer
UPDATE SWV
SET GenS_ColorectalCancer = 'Rectal cancer'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ColorectalCancer IS NULL
      AND LEFT(SWV.Diagnosis_Code_Primary, 3)IN
          (
              SELECT Code FROM #CodeGroup_ColorectalCancer_3_3
          );

-- Priority 4: Rectosigmoid cancer
UPDATE SWV
SET GenS_ColorectalCancer = 'Rectosigmoid cancer'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ColorectalCancer IS NULL
      AND LEFT(SWV.Diagnosis_Code_Primary, 3)IN
          (
              SELECT Code FROM #CodeGroup_ColorectalCancer_3_4
          );

-- Recipe 46: Update GenS_LocalExcColorectCancer
UPDATE SWV
SET GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ColorectalCancer IS NOT NULL
      AND SWV.GenS_ColorectalCancer NOT IN ( 'Other' )
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_LocalExcColorectCancer_3
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_LocalExcColorectCancer_4
                 )
          )
);

-- Recipe 47: Update GenS_ColonicStent
UPDATE SWV
SET GenS_ColonicStent = 'Colonic stent'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ColonicStent_4
              )
);

-- Recipe 48: Update GenS_Colectomy

-- Priority 1: Proctocolectomy with ileo-anal pouch
UPDATE SWV
SET GenS_Colectomy = 'Proctocolectomy with ileo-anal pouch'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Proctocolectomy_with_ileo_anal_pouch
              )
);

-- Priority 2: Proctocolectomy with ileostomy
UPDATE SWV
SET GenS_Colectomy = 'Proctocolectomy with ileostomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Proctocolectomy_with_ileostomy
              )
);

-- Priority 3: Colectomy with ileo-rectal anastomosis
UPDATE SWV
SET GenS_Colectomy = 'Colectomy with ileo-rectal anastomosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Colectomy_and_ileo_rectal_anastomosis
              )
);

-- Priority 4: Right hemicolectomy
UPDATE SWV
SET GenS_Colectomy = 'Right hemicolectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Right_hemicolectomy
              )
);

-- Priority 5: Extended right hemicolectomy
UPDATE SWV
SET GenS_Colectomy = 'Extended right hemicolectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Extended_right_hemicolectomy
              )
);

-- Priority 6: Sigmoid colectomy
UPDATE SWV
SET GenS_Colectomy = 'Sigmoid colectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_SigmoidColectomy_3
              )
);

-- Priority 7: Left hemicolectomy
UPDATE SWV
SET GenS_Colectomy = 'Left hemicolectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_LeftHemicolectomy_3
              )
);

-- Priority 8: Transverse colectomy
UPDATE SWV
SET GenS_Colectomy = 'Transverse colectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Transverse_colectomy
              )
);

-- Priority 9: Other subtotal colectomy
UPDATE SWV
SET GenS_Colectomy = 'Other subtotal colectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Subtotal_colectomy
              )
);


-- Recipe 49: Update GenS_Cholecystitis
-- Priority 1: Biliary colic
UPDATE SWV
SET GenS_Cholecystitis = 'Biliary colic'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_BiliaryColic_4
              )
);

-- Priority 2: Cholecystitis
UPDATE SWV
SET GenS_Cholecystitis = 'Cholecystitis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Cholecystitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Cholecystitis_4
              )
);

-- Update GenS_Cholecystectomy
UPDATE SWV
SET GenS_Cholecystectomy = 'Cholecystectomy'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Cholecystectomy
              )
);

-- Update GenS_Chemotherapy
UPDATE SWV
SET GenS_Chemotherapy = CASE
    WHEN LEFT(SWV.SpellDominantProcedure_Current,3) IN
         (
             SELECT Code FROM #CodeGroup_Chemotherapy_3
         ) THEN 'Chemotherapy dominant procedure'

    WHEN EXISTS
         (
             SELECT 1
             FROM [PAS_IP_Episode_Frozen] ipe
             INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                 ON ipe.Episode_Number = ipp.Episode_Number
                    AND ipe.Sector = ipp.Sector
             WHERE ipe.Spell_Number = SWV.Spell_Number
                   AND ipe.Sector = SWV.Sector
                   AND ipp.Coded_Clinical_Entry_Seq = 1
                   AND LEFT(ipp.Procedure_Code,3) IN
                       (
                           SELECT Code FROM #CodeGroup_Chemotherapy_3
                       )
         ) THEN 'Chemotherapy dominant procedure'

    WHEN EXISTS
         (
             SELECT 1
             FROM [PAS_IP_Episode_Frozen] ipe
             INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                 ON ipe.Episode_Number = ipp.Episode_Number
                    AND ipe.Sector = ipp.Sector
             WHERE ipe.Spell_Number = SWV.Spell_Number
                   AND ipe.Sector = SWV.Sector
                   AND ipp.Coded_Clinical_Entry_Seq BETWEEN 1 AND 24
                   AND LEFT(ipp.Procedure_Code,3) IN
                       (
                           SELECT Code FROM #CodeGroup_Chemotherapy_3
                       )
         ) THEN 'Chemotherapy secondary procedure'

    ELSE GenS_Chemotherapy -- Keep existing value if none of the conditions match
END
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Chemotherapy IS NULL;

UPDATE SWV
SET GenS_Cancer = CASE
                      WHEN EXISTS
                           (
                               SELECT 1
                               FROM [PAS_IP_Diagnosis_Normalised] ipd
                               WHERE ipd.Episode_Number = SWV.Episode_Number
                                     AND ipd.Sector = SWV.Sector
                                     AND LEFT(ipd.Diagnosis_Code, 4)IN
                                         (
                                             SELECT Code FROM #CodeGroup_Oesophago_gastric_cancer
                                         )
                           ) THEN
                          'Oesophago-gastric cancer'
                      WHEN EXISTS
                           (
                               SELECT 1
                               FROM [PAS_IP_Diagnosis_Normalised] ipd
                               WHERE ipd.Episode_Number = SWV.Episode_Number
                                     AND ipd.Sector = SWV.Sector
                                     AND
                                     (
                                         LEFT(ipd.Diagnosis_Code, 4)IN
                                         (
                                             SELECT Code FROM #CodeGroup_ALL_Primary_liver_cell_cancer
                                         )
                                         OR LEFT(ipd.Diagnosis_Code, 4)IN
                                            (
                                                SELECT Code FROM #CodeGroup_ALL_Other_Primary_liver_cancer
                                            )
                                         OR LEFT(ipd.Diagnosis_Code, 4)IN
                                            (
                                                SELECT Code FROM #CodeGroup_ALL_Secondary_liver_cancer
                                            )
                                     )
                           ) THEN
                          'Cancer of the liver'
                      WHEN EXISTS
                           (
                               SELECT 1
                               FROM [PAS_IP_Diagnosis_Normalised] ipd
                               WHERE ipd.Episode_Number = SWV.Episode_Number
                                     AND ipd.Sector = SWV.Sector
                                     AND LEFT(ipd.Diagnosis_Code, 1) = 'C'
                           ) THEN
                          'Cancer diagnosis'
                      ELSE
                          GenS_Cancer -- Keep existing value if none of the conditions match
                  END
FROM #Spells_With_Variables SWV;

-- Adjusted Recipe for GenS_ResectionCrohns
UPDATE SWV
SET GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
FROM #Spells_With_Variables SWV
WHERE (
          -- Procedure Conditions
          SWV.GenS_Colectomy IS NOT NULL
          AND SWV.GenS_Colectomy <> 'Other'
          OR SWV.GenS_RectalExcision IS NOT NULL
             AND SWV.GenS_RectalExcision <> 'Other'
          OR SWV.GenS_OtherColonicResection IS NOT NULL
             AND SWV.GenS_OtherColonicResection <> 'Other'
          OR EXISTS
(
    -- Ileocaecal Resection
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp_icr
    WHERE ipp_icr.Episode_Number = SWV.Episode_Number
          AND ipp_icr.Sector = SWV.Sector
          AND ipp_icr.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp_icr.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_IleocaecalResection_4
              )
)
          OR EXISTS
(
    -- Resection of Small Bowel
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp_sbr
    WHERE ipp_sbr.Episode_Number = SWV.Episode_Number
          AND ipp_sbr.Sector = SWV.Sector
          AND ipp_sbr.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp_sbr.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ResectionSmallBowel_3
              )
)
      )
      AND EXISTS
(
    -- Diagnosis Condition: Crohn's disease as primary diagnosis
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd_cd
    WHERE ipd_cd.Episode_Number = SWV.Episode_Number
          AND ipd_cd.Sector = SWV.Sector
          AND ipd_cd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd_cd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Crohns_disease
              )
)
      AND
      (
          -- Exclusions: Ensure GenS_ColorectalCancer and GenS_Cancer are NULL or 'Dummy'
          SWV.GenS_ColorectalCancer IS NULL
          OR SWV.GenS_ColorectalCancer = 'Dummy'
      )
      AND
      (
          SWV.GenS_Cancer IS NULL
          OR SWV.GenS_Cancer = 'Dummy'
      );

-- Update GenS_BowelObstruct
UPDATE SWV
SET GenS_BowelObstruct = 'Bowel obstruction'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_BowelObstruct_4
              )
);

-- Adjusted Recipe for GenS_Bilateral
UPDATE SWV
SET GenS_Bilateral = 'Bilateral procedure'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp_bilateral
    WHERE ipp_bilateral.Episode_Number = SWV.Episode_Number
          AND ipp_bilateral.Sector = SWV.Sector
          AND ipp_bilateral.Procedure_Code = 'Z941'
);

-- Update GenS_BenignLiverTumour
UPDATE SWV
SET GenS_BenignLiverTumour = 'Benign liver tumour'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_BenignLiverCancer_4
              )
);

-- Update GenS_Appendicitis
UPDATE SWV
SET GenS_Appendicitis = 'Appendicitis'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Appendicitis_3
              )
);

-- Update GenS_Appendectomy
UPDATE SWV
SET GenS_Appendectomy = 'Appendectomy'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = SWV.Episode_Number
          AND ipp.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Appendectomy
              )
);

-- Update GenS_AdvIncidentGenS
UPDATE SWV
SET GenS_AdvIncidentGenS = 'Adverse incident in general surgery'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AdverseIncidentGenS_3
              )
);

-- Adjusted Recipe for GenS_AbdomPain

-- Step 1: Exclusions
UPDATE SWV
SET GenS_AbdomPain = 'Excluded'
FROM #Spells_With_Variables SWV
WHERE (
          EXISTS
(
    -- Bowel Obstruction
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd_excl1
    WHERE ipd_excl1.Episode_Number = SWV.Episode_Number
          AND ipd_excl1.Sector = SWV.Sector
          AND ipd_excl1.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND LEFT(ipd_excl1.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_BowelObstruct_4
              )
)
          OR SWV.GenS_ColorectalCancer IS NOT NULL
             AND SWV.GenS_ColorectalCancer <> 'Dummy'
          OR SWV.GenS_Cancer IS NOT NULL
             AND SWV.GenS_Cancer <> 'Dummy'
          OR EXISTS
(
    -- Crohn's disease
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd_excl2
    WHERE ipd_excl2.Episode_Number = SWV.Episode_Number
          AND ipd_excl2.Sector = SWV.Sector
          AND ipd_excl2.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND LEFT(ipd_excl2.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Crohns_disease
              )
)
          OR EXISTS
(
    -- Cholecystitis
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd_excl3
    WHERE ipd_excl3.Episode_Number = SWV.Episode_Number
          AND ipd_excl3.Sector = SWV.Sector
          AND ipd_excl3.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND LEFT(ipd_excl3.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Cholecystitis_4
              )
)
          OR EXISTS
(
    -- Pancreatitis
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd_excl4
    WHERE ipd_excl4.Episode_Number = SWV.Episode_Number
          AND ipd_excl4.Sector = SWV.Sector
          AND ipd_excl4.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND
          (
              LEFT(ipd_excl4.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Pancreatitis_3
              )
              OR LEFT(ipd_excl4.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_Pancreatitis_4
                 )
          )
)
          OR EXISTS
(
    -- Appendicitis
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd_excl5
    WHERE ipd_excl5.Episode_Number = SWV.Episode_Number
          AND ipd_excl5.Sector = SWV.Sector
          AND ipd_excl5.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND LEFT(ipd_excl5.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Appendicitis_3
              )
)
      );

-- Step 2: Assign 'Non-specific abdominal or pelvic pain' (Priority 2)
UPDATE SWV
SET GenS_AbdomPain = 'Non-specific abdominal or pelvic pain'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_AbdomPain IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd_nsap
    WHERE ipd_nsap.Episode_Number = SWV.Episode_Number
          AND ipd_nsap.Sector = SWV.Sector
          AND ipd_nsap.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND LEFT(ipd_nsap.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AbdominalPain_4_1
              )
);

-- Step 3: Assign 'Specific abdominal or pelvic pain' (Priority 3)
UPDATE SWV
SET GenS_AbdomPain = 'Specific abdominal or pelvic pain'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_AbdomPain IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd_sap
    WHERE ipd_sap.Episode_Number = SWV.Episode_Number
          AND ipd_sap.Sector = SWV.Sector
          AND ipd_sap.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND LEFT(ipd_sap.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AbdominalPain_4
              )
);


-- Update GenS_AgeGroup
UPDATE SWV
SET GenS_AgeGroup = CASE
                        WHEN SWV.Age < 18 THEN
                            'Under 18'
                        WHEN SWV.Age
                             BETWEEN 18 AND 30 THEN
                            '18-30'
                        WHEN SWV.Age
                             BETWEEN 31 AND 50 THEN
                            '31-50'
                        WHEN SWV.Age
                             BETWEEN 51 AND 70 THEN
                            '51-70'
                        WHEN SWV.Age > 70 THEN
                            'Over 70'
                        ELSE
                            'Unknown'
                    END
FROM #Spells_With_Variables SWV;

-- Adjusted Recipe for GenS_Cancel

-- Priority 1: Clinical Reason
UPDATE SWV
SET GenS_Cancel = 'Clinical reason'
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_CancelClinical_4
              )
);

-- Priority 2: Non-Clinical Reason
UPDATE SWV
SET GenS_Cancel = 'Non-clinical reason'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Cancel IS NULL
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = SWV.Episode_Number
          AND ipd.Sector = SWV.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_CancelNonClinical_4
              )
);

-- Update Read30 flag
UPDATE SWV
SET Read30 = 1
FROM #Spells_With_Variables SWV
    LEFT JOIN [M0026_Readmissions] ram
        ON swv.Spell_Number = ram.Parent_Spell_Number
           AND swv.Sector = ram.Parent_Sector_Code
WHERE ram.M0026b_Readmission_Numerator_Less_30_Day = 1;

-- Update Read90 flag
UPDATE SWV
SET Read90 = 1
FROM #Spells_With_Variables SWV
    LEFT JOIN [M0026_Readmissions] ram
        ON swv.Spell_Number = ram.Parent_Spell_Number
           AND swv.Sector = ram.Parent_Sector_Code
WHERE ram.M0026n_Readmission_Numerator_Less_90_Day = 1;

-- Update Mort flag (In-hospital death)
UPDATE SWV
SET Mort = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
WHERE ips.Method_Of_Discharge_Code IN ( '4', '5' );

UPDATE SWV
SET Mort30 = NULL,
    Mort90 = NULL,
    Mort180 = NULL,
    Mort1yr = NULL
FROM #Spells_With_Variables SWV;

-- Update GenS_FLAG_DiagTreatPeriod
UPDATE SWV
SET GenS_FLAG_DiagTreatPeriod = DATEDIFF(DAY, ips.Discharge_Date, RA.Admission_Date)
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
    -- Join Return Admission
    INNER JOIN
    (
        SELECT RA.Patient_PAS_ID,
               MIN(RA.Admission_Date) AS Admission_Date
        FROM [PAS_IP_Spell_Frozen] RA
            INNER JOIN [PAS_IP_Episode_Frozen] RE
                ON RA.Spell_Number = RE.Spell_Number
                   AND RA.Sector = RE.Sector
            INNER JOIN [PAS_IP_Procedure_Normalised] RPP
                ON RE.Episode_Number = RPP.Episode_Number
                   AND RE.Sector = RPP.Sector
        WHERE RA.National_POD IN ( 'EL', 'DC' ) -- Elective or Day Case
              AND
              (
                  LEFT(RPP.Procedure_Code, 3)IN
                  (
                      SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_3
                  )
                  OR LEFT(RPP.Procedure_Code, 4)IN
                     (
                         SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_4
                     )
                  OR LEFT(RPP.Procedure_Code, 3)IN
                     (
                         SELECT Code FROM #CodeGroup_ProcSmallBowelObstruct_3
                     )
                  OR LEFT(RPP.Procedure_Code, 4)IN
                     (
                         SELECT Code FROM #CodeGroup_ProcSmallBowelObstruct_4
                     )
              )
        GROUP BY RA.Patient_PAS_ID
    ) RA
        ON RA.Patient_PAS_ID = ips.Patient_PAS_ID
           AND RA.Admission_Date
           BETWEEN ips.Discharge_Date AND DATEADD(DAY, 90, ips.Discharge_Date)
WHERE SWV.GenS_BowelObstruct = 'Bowel obstruction'
      AND SWV.POD_Derived = 'EM'
      AND SWV.GenS_FLAG_DiagTreat = 1
      AND SWV.GenS_FLAG_DiagTreatLarge = 1;

-- Update GenS_FLAG_AdmTreatPeriod
UPDATE SWV
SET GenS_FLAG_AdmTreatPeriod = DATEDIFF(DAY, ips.Admission_Date, EarliestProcDate.Procedure_Date)
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
    -- Subquery to find earliest procedure date per spell
    INNER JOIN
    (
        SELECT ipe.Spell_Number,
               ipe.Sector,
               MIN(ipp.Procedure_Date) AS Procedure_Date
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                ON ipe.Episode_Number = ipp.Episode_Number
                   AND ipe.Sector = ipp.Sector
        WHERE (
                  LEFT(ipp.Procedure_Code, 3)IN
                  (
                      SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_3
                  )
                  OR LEFT(ipp.Procedure_Code, 4)IN
                     (
                         SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_4
                     )
                  OR LEFT(ipp.Procedure_Code, 3)IN
                     (
                         SELECT Code FROM #CodeGroup_ProcSmallBowelObstruct_3
                     )
                  OR LEFT(ipp.Procedure_Code, 4)IN
                     (
                         SELECT Code FROM #CodeGroup_ProcSmallBowelObstruct_4
                     )
              )
        GROUP BY ipe.Spell_Number,
                 ipe.Sector
    ) AS EarliestProcDate
        ON ips.Spell_Number = EarliestProcDate.Spell_Number
           AND ips.Sector = EarliestProcDate.Sector
WHERE SWV.GenS_BowelObstruct = 'Bowel obstruction'
      AND SWV.POD_Derived = 'EM'
      AND
      (
          SWV.GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction'
          OR SWV.GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'
      )
      AND EarliestProcDate.Procedure_Date IS NOT NULL;

-- Update GenS_FLAG_PreOpRadiotherapy12wks
UPDATE SWV
SET GenS_FLAG_PreOpRadiotherapy12wks = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE (
          SWV.GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
          AND SWV.POD_Derived IN ( 'DC', 'EL' )
      )
      -- Return Admission Criteria
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] RA
        INNER JOIN [PAS_IP_Episode_Frozen] RE
            ON RA.Spell_Number = RE.Spell_Number
               AND RA.Sector = RE.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] RPP
            ON RE.Episode_Number = RPP.Episode_Number
               AND RE.Sector = RPP.Sector
    WHERE RA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND RA.Discharge_Date
          BETWEEN DATEADD(DAY, -84, ips.Admission_Date) AND ips.Admission_Date
          AND SWV.GenS_Radiotherapy = 'Radiotherapy dominant procedure'
);

-- Update GenS_FLAG_StomaRev18mths
UPDATE SWV
SET GenS_FLAG_StomaRev18mths = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE (
          SWV.GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
          AND SWV.POD_Derived IN ( 'DC', 'EL' )
      )
      AND SWV.GenS_StomaCreation = 'Stoma creation'
      -- Return Admission Criteria
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] RA
    WHERE RA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND RA.Admission_Date
          BETWEEN ips.Discharge_Date AND DATEADD(DAY, 548, ips.Discharge_Date)
          AND RA.Spell_Number IN
              (
                  SELECT ipe.Spell_Number
                  FROM [PAS_IP_Episode_Frozen] ipe
                      INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                          ON ipe.Episode_Number = ipp.Episode_Number
                             AND ipe.Sector = ipp.Sector
                  WHERE ipe.Spell_Number = RA.Spell_Number
                        AND ipe.Sector = RA.Sector
                        AND SWV.GenS_StomaReversal = 'Stoma reversal'
              )
);

-- Update GenS_FLAG_NoProc_Spell
UPDATE SWV
SET GenS_FLAG_NoProc_Spell = 1
FROM #Spells_With_Variables SWV
WHERE NOT EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
);

-- Update GenS_FLAG_BowelProc_Spell
UPDATE SWV
SET GenS_FLAG_BowelProc_Spell = CASE
                                    WHEN EXISTS
                                         (
                                             SELECT 1
                                             FROM [PAS_IP_Episode_Frozen] ipe
                                                 INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                                                     ON ipe.Episode_Number = ipp.Episode_Number
                                                        AND ipe.Sector = ipp.Sector
                                             WHERE ipe.Spell_Number = SWV.Spell_Number
                                                   AND ipe.Sector = SWV.Sector
                                                   AND
                                                   (
                                                       LEFT(ipp.Procedure_Code, 3)IN
                                                       (
                                                           SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_3
                                                       )
                                                       OR LEFT(ipp.Procedure_Code, 4)IN
                                                          (
                                                              SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_4
                                                          )
                                                       OR LEFT(ipp.Procedure_Code, 3)IN
                                                          (
                                                              SELECT Code FROM #CodeGroup_ProcSmallBowelObstruct_3
                                                          )
                                                       OR LEFT(ipp.Procedure_Code, 4)IN
                                                          (
                                                              SELECT Code FROM #CodeGroup_ProcSmallBowelObstruct_4
                                                          )
                                                   )
                                         ) THEN
                                        1
                                    ELSE
                                        0
                                END
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_BowelObstruct = 'Bowel obstruction';

-- Update GenS_FLAG_ThProcUndiffAbdom_Spell
UPDATE SWV
SET GenS_FLAG_ThProcUndiffAbdom_Spell = 1
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_AbdomPain <> 'Other'
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AbdominalPain_4
              )
          AND
          (
              LEFT(ipp.Procedure_Code, 1)IN
              (
                  SELECT Code FROM #CodeGroup_Gastrointestinal_1
              )
              OR LEFT(ipp.Procedure_Code, 1)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_1
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_3
                 )
          )
);

-- Update GenS_FLAG_ThProcDiverticulitis_Spell
UPDATE SWV
SET GenS_FLAG_ThProcDiverticulitis_Spell = 1
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Diverticulitis <> 'Other'
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Diverticulitis_3
              )
          AND
          (
              LEFT(ipp.Procedure_Code, 1)IN
              (
                  SELECT Code FROM #CodeGroup_Gastrointestinal_1
              )
              OR LEFT(ipp.Procedure_Code, 1)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_1
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Abdominal_Organ_3
                 )
          )
);

-- Update GenS_FLAG_ComplicationGenS_Spell
UPDATE SWV
SET GenS_FLAG_ComplicationGenS_Spell = 1
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ComplicationGenS_3
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ComplicationGenS_4
                 )
          )
);

-- Update GenS_FLAG_AdvIncidentGenS_Spell
UPDATE SWV
SET GenS_FLAG_AdvIncidentGenS_Spell = 1
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AdverseIncidentGenS_3
              )
);

-- Update GenS_FLAG_Complication30
UPDATE SWV
SET GenS_FLAG_Complication30 = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE SWV.GenS_GeneralSurgery <> 'Other'
      -- Return Admission Criteria
      AND EXISTS
(
    SELECT TOP 1
           1
    FROM [PAS_IP_Spell_Frozen] RA
        INNER JOIN [PAS_IP_Episode_Frozen] RE
            ON RA.Spell_Number = RE.Spell_Number
               AND RA.Sector = RE.Sector
        INNER JOIN #Spells_With_Variables SWV_Return
            ON RA.Spell_Number = SWV_Return.Spell_Number
               AND RA.Sector = SWV_Return.Sector
    WHERE RA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND RA.Admission_Date
          BETWEEN ips.Discharge_Date AND DATEADD(DAY, 30, ips.Discharge_Date)
          AND SWV_Return.GenS_ComplicationGenS = 'Complication of surgery GenS'
          AND SWV_Return.POD_Derived = 'EM'
);

-- Update GenS_FLAG_Complication30_Return
UPDATE SWV_Return
SET GenS_FLAG_Complication30_Return = 1
FROM #Spells_With_Variables SWV_Return
    INNER JOIN [PAS_IP_Spell_Frozen] RA
        ON SWV_Return.Spell_Number = RA.Spell_Number
           AND SWV_Return.Sector = RA.Sector
-- Return Admission Criteria
WHERE SWV_Return.GenS_ComplicationGenS = 'Complication of surgery GenS'
      AND SWV_Return.POD_Derived = 'EM'
      AND EXISTS
(
    SELECT TOP 1
           1
    FROM #Spells_With_Variables SWV_Index
        INNER JOIN [PAS_IP_Spell_Frozen] ips
            ON SWV_Index.Spell_Number = ips.Spell_Number
               AND SWV_Index.Sector = ips.Sector
    WHERE SWV_Index.GenS_GeneralSurgery <> 'Other'
          AND RA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND RA.Admission_Date
          BETWEEN ips.Discharge_Date AND DATEADD(DAY, 30, ips.Discharge_Date)
);

-- Update GenS_SurgOnAdm
UPDATE SWV
SET GenS_SurgOnAdm = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT ipe.Spell_Number,
               ipe.Sector,
               MIN(ipp.Procedure_Date) AS Procedure_Date
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                ON ipe.Episode_Number = ipp.Episode_Number
                   AND ipe.Sector = ipp.Sector
        GROUP BY ipe.Spell_Number,
                 ipe.Sector
    ) AS EarliestProc
        ON SWV.Spell_Number = EarliestProc.Spell_Number
           AND SWV.Sector = EarliestProc.Sector
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
WHERE SWV.GenS_GeneralSurgery <> 'Other'
      AND EarliestProc.Procedure_Date = ips.Admission_Date
      AND EarliestProc.Procedure_Date IS NOT NULL;

-- Update GenS_Read3SS
UPDATE SWV
SET GenS_Read3SS = 1
FROM #Spells_With_Variables SWV
WHERE SWV.Read30 = 1
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] RA
    WHERE RA.PAS_Number = SWV.PAS_Number
          AND RA.Admission_Date
          BETWEEN SWV.Discharge_Date AND DATEADD(DAY, 3, SWV.Discharge_Date)
          AND DATEDIFF(DAY, RA.Admission_Date, RA.Discharge_Date) <= 1
          AND RA.Admission_Date > SWV.Discharge_Date
);

-- Update GenS_FLAG_CholePrior
UPDATE SWV
SET GenS_FLAG_CholePrior = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE (
          SWV.GenS_Cholecystitis <> 'Other'
          OR SWV.GenS_Pancreatitis <> 'Other'
      )
      AND SWV.POD_Derived = 'EM'
      -- Prior Admission Criteria
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] PA
        INNER JOIN #Spells_With_Variables SWV_Prior
            ON PA.Spell_Number = SWV_Prior.Spell_Number
               AND PA.Sector = SWV_Prior.Sector
    WHERE PA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND PA.Discharge_Date
          BETWEEN DATEADD(DAY, -365, ips.Admission_Date) AND ips.Admission_Date
          AND
          (
              SWV_Prior.GenS_Cholecystitis <> 'Other'
              OR SWV_Prior.GenS_Pancreatitis <> 'Other'
          )
          AND SWV_Prior.POD_Derived = 'EM'
);

-- Update GenS_FLAG_CholeTreat14
UPDATE SWV
SET GenS_FLAG_CholeTreat14 = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE (
          SWV.GenS_Cholecystitis <> 'Other'
          OR SWV.GenS_Pancreatitis <> 'Other'
      )
      AND SWV.POD_Derived = 'EM'
      -- Cholecystectomy within 14 days
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] RA
        INNER JOIN #Spells_With_Variables SWV_Return
            ON RA.Spell_Number = SWV_Return.Spell_Number
               AND RA.Sector = SWV_Return.Sector
    WHERE RA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND RA.Admission_Date
          BETWEEN ips.Admission_Date AND DATEADD(DAY, 14, ips.Admission_Date)
          AND SWV_Return.GenS_Cholecystectomy = 'Cholecystectomy'
);

-- Update GenS_FLAG_CholeReop30
UPDATE SWV
SET GenS_FLAG_CholeReop30 = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE SWV.GenS_Cholecystectomy = 'Cholecystectomy'
      -- Reoperation within 30 days
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] RA
        INNER JOIN #Spells_With_Variables SWV_Return
            ON RA.Spell_Number = SWV_Return.Spell_Number
               AND RA.Sector = SWV_Return.Sector
    WHERE RA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND RA.Admission_Date
          BETWEEN ips.Discharge_Date AND DATEADD(DAY, 30, ips.Discharge_Date)
          AND SWV_Return.GenS_Cholecystectomy = 'Cholecystectomy'
);

-- Update GenS_FLAG_FirstDiagObstruction
UPDATE SWV
SET GenS_FLAG_FirstDiagObstruction = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
WHERE SWV.GenS_BowelObstruct = 'Bowel obstruction'
      AND SWV.POD_Derived = 'EM'
      AND NOT EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] PA
        INNER JOIN #Spells_With_Variables SWV_Prior
            ON PA.Spell_Number = SWV_Prior.Spell_Number
               AND PA.Sector = SWV_Prior.Sector
    WHERE PA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND PA.Discharge_Date
          BETWEEN DATEADD(DAY, -365, ips.Admission_Date) AND ips.Admission_Date
          AND SWV_Prior.GenS_BowelObstruct = 'Bowel obstruction'
          AND SWV_Prior.POD_Derived = 'EM'
);

-- Update GenS_FLAG_DiagTreat
UPDATE SWV
SET GenS_FLAG_DiagTreat = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE SWV.GenS_BowelObstruct = 'Bowel obstruction'
      AND SWV.POD_Derived = 'EM'
      -- Return Admission Criteria
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] RA
        INNER JOIN #Spells_With_Variables SWV_Return
            ON RA.Spell_Number = SWV_Return.Spell_Number
               AND RA.Sector = SWV_Return.Sector
    WHERE RA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND RA.Admission_Date
          BETWEEN ips.Discharge_Date AND DATEADD(DAY, 90, ips.Discharge_Date)
          AND
          (
              SWV_Return.GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction'
              OR SWV_Return.GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'
          )
);

-- Update GenS_FLAG_CholeTreat14_DC
UPDATE SWV
SET GenS_FLAG_CholeTreat14_DC = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE (
          SWV.GenS_Cholecystitis <> 'Other'
          OR SWV.GenS_Pancreatitis <> 'Other'
      )
      AND SWV.POD_Derived = 'EM'
      -- Cholecystectomy within 14 days as Day Case
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] RA
        INNER JOIN #Spells_With_Variables SWV_Return
            ON RA.Spell_Number = SWV_Return.Spell_Number
               AND RA.Sector = SWV_Return.Sector
    WHERE RA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND RA.Admission_Date
          BETWEEN ips.Admission_Date AND DATEADD(DAY, 14, ips.Admission_Date)
          AND SWV_Return.GenS_Cholecystectomy = 'Cholecystectomy'
          AND SWV_Return.POD_Derived = 'DC'
);

-- Update GenS_FLAG_OPFU90
UPDATE SWV
SET GenS_FLAG_OPFU90 = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE SWV.GenS_Cholecystectomy <> 'Other'
      -- Outpatient Follow-up within 90 days
      AND EXISTS
(
    SELECT 1
    FROM [PAS_OP_Appointment] opa
    WHERE opa.PAS_Number = ips.PAS_Number
          AND opa.Appointment_Date
          BETWEEN ips.Discharge_Date AND DATEADD(DAY, 90, ips.Discharge_Date)
          AND
          (
              opa.Main_Specialty_Code IN
              (
                  SELECT Code FROM #CodeGroup_MainSpec_1
              )
              OR opa.Treatment_Function_Code IN
                 (
                     SELECT Code FROM #CodeGroup_TFC_Code_1
                 )
          )
);

UPDATE #Spells_With_Variables
SET GenS_ColonicResection_Cancer = CASE
    WHEN (
        (
            GenS_Colectomy NOT IN ('Other')
            OR GenS_RectalExcision NOT IN ('Other')
            OR GenS_OtherColonicResection NOT IN ('Other')
        )
        AND GenS_ColorectalCancer NOT IN ('Other')
    ) THEN 'Resection for colorectal cancer'
    ELSE 'Other'
END;

-- Update GenS_FLAG_DiagTreatLarge
UPDATE SWV
SET GenS_FLAG_DiagTreatLarge = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
-- Index Admission Criteria
WHERE SWV.GenS_BowelObstruct = 'Bowel obstruction'
      AND SWV.POD_Derived = 'EM'
      -- Return Admission Criteria
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] RA
        INNER JOIN [PAS_IP_Episode_Frozen] RE
            ON RA.Spell_Number = RE.Spell_Number
               AND RA.Sector = RE.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] RPP
            ON RE.Episode_Number = RPP.Episode_Number
               AND RE.Sector = RPP.Sector
    WHERE RA.Patient_PAS_ID = ips.Patient_PAS_ID
          AND RA.Admission_Date
          BETWEEN ips.Discharge_Date AND DATEADD(DAY, 90, ips.Discharge_Date)
          AND RA.National_POD IN ( 'EL', 'DC' ) -- Elective or Day Case
          AND
          (
              LEFT(RPP.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_3
              )
              OR LEFT(RPP.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ProcLargeBowelObstruct_4
                 )
          )
);


/* -------------------------------------------------------------------
	Appendicitis and appendicectomy
 ------------------------------------------------------------------- */

-- Define the start and end dates for Metric GS7100
DECLARE @GS7100_StartDate DATE = '2024-06-01';
DECLARE @GS7100_EndDate DATE = '2024-06-30';

/* Number of emergency appendicectomy procedures (monthly) 

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM'

*/

-- Metric GS7100: Number of Emergency Appendicectomy Procedures in June 2024

DECLARE @GS7100_Count INT;

SELECT @GS7100_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @GS7100_StartDate
      AND Admission_Date <= @GS7100_EndDate;

SELECT 'Metric GS7100 - Number of Emergency Appendicectomy Procedures' AS Metric,
       @GS7100_Count AS Rate;

/* Minimal access rate for emergency appendicectomy (12mths to qtr end) 

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM'

*/

-- Numerator
DECLARE @GS7101_Numerator INT;

SELECT @GS7101_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @MetricStartDate
      AND Admission_Date <= @QuarterEndDate;

-- Denominator
DECLARE @GS7101_Denominator INT;

SELECT @GS7101_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @MetricStartDate
      AND Admission_Date <= @QuarterEndDate;

-- Calculate Rate
DECLARE @GS7101_Rate FLOAT;

SET @GS7101_Rate = CAST(@GS7101_Numerator AS FLOAT) / NULLIF(@GS7101_Denominator, 0);

SELECT 'Metric GS7101 - Minimal Access Rate' AS Metric,
       @GS7101_Rate AS Rate,
       @GS7101_Numerator AS Numerator,
       @GS7101_Denominator AS Denominator;

/* Length of stay less than 2 day rate for emergency appendicectomy (12mths to qtr end) 
Metric ID: GS7102

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND Spell_LOS < 2

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM'

*/

-- Numerator
DECLARE @GS7102_Numerator INT;

SELECT @GS7102_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND Spell_LOS < 2
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @MetricStartDate
      AND Admission_Date <= @QuarterEndDate;

-- Denominator
DECLARE @GS7102_Denominator INT;

SELECT @GS7102_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @MetricStartDate
      AND Admission_Date <= @QuarterEndDate;

-- Calculate Rate
DECLARE @GS7102_Rate FLOAT;

SET @GS7102_Rate = CAST(@GS7102_Numerator AS FLOAT) / NULLIF(@GS7102_Denominator, 0);

SELECT 'Metric GS7102 - Length of Stay Less Than 2 Days Rate' AS Metric,
       @GS7102_Rate AS Rate,
       @GS7102_Numerator AS Numerator,
       @GS7102_Denominator AS Denominator;

/* Average length of stay for emergency laparoscopic appendicectomy (12mths to qtr end) 
Metric ID: GS7103

Sum(Spell_LOS)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

*/

DECLARE @GS7103_AverageLOS FLOAT;
DECLARE @GS7103_Count INT;

SELECT @GS7103_AverageLOS = AVG(CAST(Spell_LOS AS FLOAT)),
       @GS7103_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @MetricStartDate
      AND Admission_Date <= @QuarterEndDate;

SELECT 'Metric GS7103 - Average Length of Stay' AS Metric,
       @GS7103_AverageLOS AS Rate,
       NULL AS Numerator,
       @GS7103_Count AS Denominator;

/* Average length of stay for emergency open appendicectomy (12mths to qtr end) 
Metric ID: GS7104

Sum(Spell_LOS)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')


*/

DECLARE @GS7104_AverageLOS FLOAT;
DECLARE @GS7104_Count INT;

SELECT @GS7104_AverageLOS = AVG(CAST(Spell_LOS AS FLOAT)),
       @GS7104_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @MetricStartDate
      AND Admission_Date <= @QuarterEndDate;

SELECT 'Metric GS7104 - Average Length of Stay' AS Metric,
       @GS7104_AverageLOS AS Rate,
       NULL AS Numerator,
       @GS7104_Count AS Denominator;


/* Adverse outcome rate following emergency laparoscopic appendicectomy (12mths to qtr end) 
Metric ID: GS7105

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

*/

-- Numerator
DECLARE @GS7105_Numerator INT;

SELECT @GS7105_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND
      (
          (
              GenS_FLAG_ComplicationGenS_Spell = 1
              AND GenS_FLAG_Complication30_Return <> 1
          )
          OR GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR GenS_FLAG_Complication30 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @GS7105_StartDate
      AND Admission_Date <= @GS7105_EndDate;

-- Denominator
DECLARE @GS7105_Denominator INT;

SELECT @GS7105_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @GS7105_StartDate
      AND Admission_Date <= @GS7105_EndDate;

-- Calculate Rate
DECLARE @GS7105_Rate FLOAT;

SET @GS7105_Rate = CAST(@GS7105_Numerator AS FLOAT) / NULLIF(@GS7105_Denominator, 0);

SELECT 'Metric GS7105 - Adverse Outcome Rate' AS Metric,
       @GS7105_Rate AS Rate,
       @GS7105_Numerator AS Numerator,
       @GS7105_Denominator AS Denominator;

/* Adverse outcome rate following emergency open appendicectomy (12mths to qtr end) 
Metric ID: GS7106

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

*/

-- Numerator
DECLARE @GS7106_Numerator INT;

SELECT @GS7106_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND
      (
          (
              GenS_FLAG_ComplicationGenS_Spell = 1
              AND GenS_FLAG_Complication30_Return <> 1
          )
          OR GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR GenS_FLAG_Complication30 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @GS7105_StartDate -- Using the same dates as GS7105
      AND Admission_Date <= @GS7105_EndDate;

-- Denominator
DECLARE @GS7106_Denominator INT;

SELECT @GS7106_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @GS7105_StartDate
      AND Admission_Date <= @GS7105_EndDate;

-- Calculate Rate
DECLARE @GS7106_Rate FLOAT;

SET @GS7106_Rate = CAST(@GS7106_Numerator AS FLOAT) / NULLIF(@GS7106_Denominator, 0);

SELECT 'Metric GS7106 - Adverse Outcome Rate' AS Metric,
       @GS7106_Rate AS Rate,
       @GS7106_Numerator AS Numerator,
       @GS7106_Denominator AS Denominator;



/* Emergency readmission within 30 days following emergency appendicectomy (12mths to qtr end) 
Metric ID: GS7107

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM' 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_Appendectomy = 'Appendectomy' 
AND POD_Derived = 'EM'

*/

-- Numerator
DECLARE @GS7107_Numerator INT;

SELECT @GS7107_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @GS7105_StartDate -- Using the same dates as GS7105
      AND Admission_Date <= @GS7105_EndDate;

-- Denominator
DECLARE @GS7107_Denominator INT;

SELECT @GS7107_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Appendectomy = 'Appendectomy'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date >= @GS7105_StartDate
      AND Admission_Date <= @GS7105_EndDate;

-- Calculate Rate
DECLARE @GS7107_Rate FLOAT;

SET @GS7107_Rate = CAST(@GS7107_Numerator AS FLOAT) / NULLIF(@GS7107_Denominator, 0);

SELECT 'Metric GS7107 - Emergency Readmission Rate' AS Metric,
       @GS7107_Rate AS Rate,
       @GS7107_Numerator AS Numerator,
       @GS7107_Denominator AS Denominator;


/* -------------------------------------------------------------------
	Cholecystitis, pancreatitis and emergency cholecystectomy
 ------------------------------------------------------------------- */

/* Median length of stay for emergency patients with cholecystitis (with or without procedure) (12mths to qtr end) 
Metric ID: GS7108

Median(Spell_LOS)
GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived = 'EM'

COUNT(Spells)
GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived = 'EM'

Date: Q1 2024/25

*/

DECLARE @GS7108_Count INT;

SELECT @GS7108_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7108_MedianLOS FLOAT;

WITH OrderedLOS
AS (SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          AND
          (
              GenS_Cholecystitis <> 'Other'
              OR GenS_Pancreatitis <> 'Other'
          )
          AND POD_Derived = 'EM'
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date
          BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate)
SELECT @GS7108_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7108_Count + 1) / 2, (@GS7108_Count + 2) / 2 );

SELECT 'Metric GS7108 - Median Length of Stay' AS Metric,
       @GS7108_MedianLOS AS Rate,
       NULL AS Numerator,
       @GS7108_Count AS Denominator;

/* Minimal access rate for emergency cholecystectomy (12mths to qtr end) 
Metric ID: GS7109

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND POD_Derived = 'EM' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND POD_Derived = 'EM'

Date: Q1 2024/25

*/

-- Numerator
DECLARE @GS7109_Numerator INT;

SELECT @GS7109_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND POD_Derived = 'EM'
      AND GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7109_Denominator INT;

SELECT @GS7109_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7109_Rate FLOAT;

SET @GS7109_Rate = CASE
                       WHEN @GS7109_Denominator > 0 THEN
                           CAST(@GS7109_Numerator AS FLOAT) / @GS7109_Denominator
                       ELSE
                           NULL
                   END;


SELECT 'Metric GS7109 - Minimal Access Rate' AS Metric,
       @GS7109_Rate AS Rate,
       @GS7109_Numerator AS Numerator,
       @GS7109_Denominator AS Denominator;


/* Average length of stay for emergency laparoscopic cholecystectomy (12mths to qtr end) 
Metric ID: GS7110

SUM(Spell_LOS)
GenS_Cholecystectomy = 'Cholecystectomy' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived = 'EM'

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived = 'EM'

Date: Q1 2024/25

*/

DECLARE @GS7110_TotalLOS FLOAT;
DECLARE @GS7110_Count INT;
DECLARE @GS7110_AverageLOS FLOAT;

SELECT @GS7110_TotalLOS = SUM(Spell_LOS),
       @GS7110_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

SET @GS7110_AverageLOS = CASE
                             WHEN @GS7110_Count > 0 THEN
                                 @GS7110_TotalLOS / @GS7110_Count
                             ELSE
                                 NULL
                         END;

SELECT 'Metric GS7110 - Average Length of Stay' AS Metric,
       @GS7110_AverageLOS AS Rate,
       @GS7110_TotalLOS AS Numerator,
       @GS7110_Count AS Denominator;


/* Emergency reoperation within 30 days following emergency cholecystectomy (12mths to qtr end) 
Metric ID: GS7112

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND POD_Derived = 'EM' 
AND Mort = 0 AND GenS_FLAG_CholeReop30 = 1

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND POD_Derived = 'EM' 
AND Mort = 0

Date: Q4 2023/24

*/

-- Metric GS7112: Emergency Reoperation Within 30 Days Following Emergency Cholecystectomy

-- Numerator
DECLARE @GS7112_Numerator INT;

SELECT @GS7112_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND POD_Derived = 'EM'
      AND Mort = 0
      AND GenS_FLAG_CholeReop30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7112_Denominator INT;

SELECT @GS7112_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND POD_Derived = 'EM'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7112_Rate FLOAT;

SET @GS7112_Rate = CASE
                       WHEN @GS7112_Denominator > 0 THEN
                           CAST(@GS7112_Numerator AS FLOAT) / @GS7112_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7112 - Emergency Reoperation Rate' AS Metric,
       @GS7112_Rate AS Rate,
       @GS7112_Numerator AS Numerator,
       @GS7112_Denominator AS Denominator;


/* Emergency readmission within 30 days following emergency admission for cholecystitis (with or without procedure) (12mths to qtr end) 
Metric ID: GS7113

Count(Spells)
GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived = 'EM' 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived = 'EM' 
AND Mort = 0

Date: Q4 2023/24

*/

-- Metric GS7113: Emergency Readmission Within 30 Days Following Emergency Admission for Cholecystitis

-- Numerator
DECLARE @GS7113_Numerator INT;

SELECT @GS7113_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived = 'EM'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7113_Denominator INT;

SELECT @GS7113_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived = 'EM'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7113_Rate FLOAT;

SET @GS7113_Rate = CASE
                       WHEN @GS7113_Denominator > 0 THEN
                           CAST(@GS7113_Numerator AS FLOAT) / @GS7113_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7113 - Emergency Readmission Rate' AS Metric,
       @GS7113_Rate AS Rate,
       @GS7113_Numerator AS Numerator,
       @GS7113_Denominator AS Denominator;


/* Emergency readmission within 30 days following emergency laparoscopic cholecystectomy (12mths to qtr end) 
Metric ID: GS7114

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived = 'EM' 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived = 'EM' 
AND Mort = 0

Date: Q4 2023/24

*/

-- Metric GS7114: Emergency Readmission Within 30 Days Following Emergency Laparoscopic Cholecystectomy

-- Numerator
DECLARE @GS7114_Numerator INT;

SELECT @GS7114_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND POD_Derived = 'EM'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7114_Denominator INT;

SELECT @GS7114_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND POD_Derived = 'EM'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7114_Rate FLOAT;

SET @GS7114_Rate = CASE
                       WHEN @GS7114_Denominator > 0 THEN
                           CAST(@GS7114_Numerator AS FLOAT) / @GS7114_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7114 - Emergency Readmission Rate' AS Metric,
       @GS7114_Rate AS Rate,
       @GS7114_Numerator AS Numerator,
       @GS7114_Denominator AS Denominator;


/* Adverse outcome rate following emergency cholecystectomy (12mths to qtr end) 
Metric ID: GS7116

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND POD_Derived = 'EM' 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 
AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND POD_Derived = 'EM'

Date: Q4 2023/24

*/

-- Metric GS7116: Adverse Outcome Rate Following Emergency Cholecystectomy

-- Numerator
DECLARE @GS7116_Numerator INT;

SELECT @GS7116_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND POD_Derived = 'EM'
      AND
      (
          (
              GenS_FLAG_ComplicationGenS_Spell = 1
              AND ISNULL(GenS_FLAG_Complication30_Return, 0) <> 1
          )
          OR GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR GenS_FLAG_Complication30 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7116_Denominator INT;

SELECT @GS7116_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7116_Rate FLOAT;

SET @GS7116_Rate = CASE
                       WHEN @GS7116_Denominator > 0 THEN
                           CAST(@GS7116_Numerator AS FLOAT) / @GS7116_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7116 - Adverse Outcome Rate' AS Metric,
       @GS7116_Rate AS Rate,
       @GS7116_Numerator AS Numerator,
       @GS7116_Denominator AS Denominator;


/* Cholecystectomy during first emergency admission for cholecystitis or biliary colic (excluding for acute pancreatitis) (12mths to qtr end) 
Metric ID: GS7117

Count(Spells)
GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other')  
AND GenS_FLAG_CholePrior != 1 
AND POD_Derived = 'EM' 
AND GenS_Cholecystectomy = 'Cholecystectomy'

Count(Spells)
GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other')  
AND GenS_FLAG_CholePrior != 1 
AND POD_Derived = 'EM'

date: Q1 2024/25

*/

-- Metric GS7117: Cholecystectomy During First Emergency Admission (Excluding Acute Pancreatitis)

-- Numerator
DECLARE @GS7117_Numerator INT;

SELECT @GS7117_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND ISNULL(GenS_FLAG_CholePrior, 0) != 1
      AND POD_Derived = 'EM'
      AND GenS_Cholecystectomy = 'Cholecystectomy'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7117_Denominator INT;

SELECT @GS7117_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND ISNULL(GenS_FLAG_CholePrior, 0) != 1
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7117_Rate FLOAT;

SET @GS7117_Rate = CASE
                       WHEN @GS7117_Denominator > 0 THEN
                           CAST(@GS7117_Numerator AS FLOAT) / @GS7117_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7117 - Cholecystectomy During First Emergency Admission Rate' AS Metric,
       @GS7117_Rate AS Rate,
       @GS7117_Numerator AS Numerator,
       @GS7117_Denominator AS Denominator;



/* Cholecystectomy within 14 days following first emergency admission for cholecystitis or biliary colic (excluding for acute pancreatitis) (12mths to qtr end) 
Metric ID: GS7118

Count(Spells)
GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other')  
AND GenS_FLAG_CholePrior != 1 
AND POD_Derived = 'EM' 
AND GenS_FLAG_CholeTreat14 = 1

Count(Spells)
GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other')  
AND GenS_FLAG_CholePrior != 1 
AND POD_Derived = 'EM'

Date: Q1 2024/25

*/

-- Metric GS7118: Cholecystectomy Within 14 Days Following First Emergency Admission (Excluding Acute Pancreatitis)

-- Numerator
DECLARE @GS7118_Numerator INT;

SELECT @GS7118_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND ISNULL(GenS_FLAG_CholePrior, 0) != 1
      AND POD_Derived = 'EM'
      AND GenS_FLAG_CholeTreat14 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7118_Denominator INT;

SELECT @GS7118_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND ISNULL(GenS_FLAG_CholePrior, 0) != 1
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7118_Rate FLOAT;

SET @GS7118_Rate = CASE
                       WHEN @GS7118_Denominator > 0 THEN
                           CAST(@GS7118_Numerator AS FLOAT) / @GS7118_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7118 - Cholecystectomy Within 14 Days Rate' AS Metric,
       @GS7118_Rate AS Rate,
       @GS7118_Numerator AS Numerator,
       @GS7118_Denominator AS Denominator;


/* Cholecystectomy during first emergency admission for acute pancreatitis (12mths to qtr end) 
Metric ID: GS7119

Count(Spells)
GenS_Pancreatitis IN ('Acute gallstone pancreatitis','Acute pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other')  
AND GenS_FLAG_CholePrior != 1 
AND POD_Derived = 'EM' 
AND GenS_Cholecystectomy = 'Cholecystectomy'

Count(Spells)
GenS_Pancreatitis IN ('Acute gallstone pancreatitis','Acute pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other')  
AND GenS_FLAG_CholePrior != 1 
AND POD_Derived = 'EM'

Date: Q1 2024/25

*/

-- Metric GS7119: Cholecystectomy During First Emergency Admission for Acute Pancreatitis

-- Numerator
DECLARE @GS7119_Numerator INT;

SELECT @GS7119_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis IN ( 'Acute gallstone pancreatitis', 'Acute pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND ISNULL(GenS_FLAG_CholePrior, 0) != 1
      AND POD_Derived = 'EM'
      AND GenS_Cholecystectomy = 'Cholecystectomy'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7119_Denominator INT;

SELECT @GS7119_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis IN ( 'Acute gallstone pancreatitis', 'Acute pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND ISNULL(GenS_FLAG_CholePrior, 0) != 1
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7119_Rate FLOAT;

SET @GS7119_Rate = CASE
                       WHEN @GS7119_Denominator > 0 THEN
                           CAST(@GS7119_Numerator AS FLOAT) / @GS7119_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7119 - Cholecystectomy During First Admission for Acute Pancreatitis Rate' AS Metric,
       @GS7119_Rate AS Rate,
       @GS7119_Numerator AS Numerator,
       @GS7119_Denominator AS Denominator;


/* Cholecystectomy within 14 days following first emergency admission for acute pancreatitis (including gallstone pancreatitis) (12mths to qtr end) 
Metric ID: GS7120

Count(Spells)
GenS_Pancreatitis IN ('Acute gallstone pancreatitis','Acute pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other')  
AND GenS_FLAG_CholePrior != 1 AND POD_Derived = 'EM' 
AND GenS_FLAG_CholeTreat14 = 1

Count(Spells)
GenS_Pancreatitis IN ('Acute gallstone pancreatitis','Acute pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other')  
AND GenS_FLAG_CholePrior != 1 AND POD_Derived = 'EM'

Date: Q4 2023/24

*/

-- Metric GS7120: Cholecystectomy Within 14 Days Following First Emergency Admission for Acute Pancreatitis

-- Numerator
DECLARE @GS7120_Numerator INT;

SELECT @GS7120_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis IN ( 'Acute gallstone pancreatitis', 'Acute pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND ISNULL(GenS_FLAG_CholePrior, 0) != 1
      AND POD_Derived = 'EM'
      AND GenS_FLAG_CholeTreat14 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7120_Denominator INT;

SELECT @GS7120_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis IN ( 'Acute gallstone pancreatitis', 'Acute pancreatitis' )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND ISNULL(GenS_FLAG_CholePrior, 0) != 1
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7120_Rate FLOAT;

SET @GS7120_Rate = CASE
                       WHEN @GS7120_Denominator > 0 THEN
                           CAST(@GS7120_Numerator AS FLOAT) / @GS7120_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7120 - Cholecystectomy Within 14 Days for Acute Pancreatitis Rate' AS Metric,
       @GS7120_Rate AS Rate,
       @GS7120_Numerator AS Numerator,
       @GS7120_Denominator AS Denominator;


/* -------------------------------------------------------------------
	Elective cholecystectomy
 ------------------------------------------------------------------- */

/* Cholecystectomy in 14 days of diagnosis - rate for elective patients with gallstone pancreatitis (12mths to qtr end) 
Metric ID: GS7121

Count(Spells)
GenS_Pancreatitis IN ('Acute gallstone pancreatitis') 
AND POD_Derived IN ('EL','DC') 
AND (GenS_Cholecystectomy = 'Cholecystectomy'  OR GenS_FLAG_CholeTreat14 = 1)

Count(Spells)
GenS_Pancreatitis IN ('Acute gallstone pancreatitis') 
AND POD_Derived IN ('EL','DC')

Date: Q4 2023/24

*/

-- Metric GS7121: Cholecystectomy Within 14 Days of Diagnosis for Elective Patients with Gallstone Pancreatitis

-- Numerator
DECLARE @GS7121_Numerator INT;

SELECT @GS7121_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis = 'Acute gallstone pancreatitis'
      AND POD_Derived IN ( 'EL', 'DC' )
      AND
      (
          GenS_Cholecystectomy = 'Cholecystectomy'
          OR GenS_FLAG_CholeTreat14 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7121_Denominator INT;

SELECT @GS7121_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Pancreatitis = 'Acute gallstone pancreatitis'
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7121_Rate FLOAT;

SET @GS7121_Rate = CASE
                       WHEN @GS7121_Denominator > 0 THEN
                           CAST(@GS7121_Numerator AS FLOAT) / @GS7121_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7121 - Cholecystectomy Within 14 Days for Elective Patients Rate' AS Metric,
       @GS7121_Rate AS Rate,
       @GS7121_Numerator AS Numerator,
       @GS7121_Denominator AS Denominator;


/* Minimal access rate for elective cholecystectomy (excluding for acute pancreatitis) (12mths to qtr end) 
Metric ID: GS7122

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived IN ('EL','DC') 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived IN ('EL','DC')

Date: Q1 2024/25

*/

/* Numerator */
DECLARE @GS7122_Numerator INT;

SELECT @GS7122_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND
      (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived IN ( 'EL', 'DC' )
      AND GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND Org_Code_Provider = 'RPA'
      AND Sector = 'MED'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

/* Denominator */
DECLARE @GS7122_Denominator INT;

SELECT @GS7122_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND
      (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Org_Code_Provider = 'RPA'
      AND Sector = 'MED'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

/* Calculate Rate */
DECLARE @GS7122_Rate FLOAT;

SET @GS7122_Rate = CASE
                       WHEN @GS7122_Denominator > 0 THEN
                           CAST(@GS7122_Numerator AS FLOAT) / @GS7122_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7122 - Minimal Access Rate for Elective Cholecystectomy' AS Metric,
       @GS7122_Rate AS Rate,
       @GS7122_Numerator AS Numerator,
       @GS7122_Denominator AS Denominator;

/* Daycase rate for elective cholecystectomy (excluding for acute pancreatitis) (12mths to qtr end) 
Metric ID: GS7123

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived IN ('DC')

Date: Q1 2024/25

*/

-- Metric GS7123: Day Case Rate for Elective Cholecystectomy (Excluding Acute Pancreatitis)

-- Numerator (Since only the numerator is specified, we'll assume denominator is total elective cholecystectomies excluding acute pancreatitis)

DECLARE @GS7123_Numerator INT;

SELECT @GS7123_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND
      (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived = 'DC' -- Day Case
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7123_Denominator INT;

SELECT @GS7123_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND
      (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived IN ( 'EL', 'DC' ) -- All elective admissions including day cases
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7123_Rate FLOAT;

SET @GS7123_Rate = CASE
                       WHEN @GS7123_Denominator > 0 THEN
                           CAST(@GS7123_Numerator AS FLOAT) / @GS7123_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7123 - Day Case Rate for Elective Cholecystectomy' AS Metric,
       @GS7123_Rate AS Rate,
       @GS7123_Numerator AS Numerator,
       @GS7123_Denominator AS Denominator;


/* Average length of stay for elective open cholecystectomy (excluding for acute pancreatitis) (12mths to qtr end) 
Metric ID: GS7124

Sum(Spell_LOS)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived IN ('EL','DC')

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived IN ('EL','DC')

Date: Q4 2018/19

*/

-- Metric GS7124: Average Length of Stay for Elective Open Cholecystectomy (Excluding for Acute Pancreatitis)

DECLARE @GS7124_TotalLOS FLOAT;
DECLARE @GS7124_Count INT;
DECLARE @GS7124_AverageLOS FLOAT;

SELECT @GS7124_TotalLOS = SUM(Spell_LOS),
       @GS7124_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND 
	  (
          GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR GenS_MinimalAccess  IS NULL
      )
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2018_19_StartDate AND @Q4_2018_19_EndDate;

SET @GS7124_AverageLOS = CASE
                             WHEN @GS7124_Count > 0 THEN
                                 @GS7124_TotalLOS / @GS7124_Count
                             ELSE
                                 NULL
                         END;

SELECT 'Metric GS7124 - Average Length of Stay' AS Metric,
       @GS7124_AverageLOS AS Rate,
       @GS7124_TotalLOS AS Numerator,
       @GS7124_Count AS Denominator;


/* Emergency reoperation within 30 days following elective cholecystectomy (excluding for acute pancreatitis) (12mths to qtr end) 
Metric ID: GS7125

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived IN ('EL','DC') AND Mort = 0 AND GenS_FLAG_CholeReop30 = 1

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived IN ('EL','DC') 
AND Mort = 0

Date: Q4 2023/24

*/

-- Metric GS7125: Emergency Reoperation Within 30 Days Following Elective Cholecystectomy

-- Numerator
DECLARE @GS7125_Numerator INT;

SELECT @GS7125_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Mort = 0
      AND GenS_FLAG_CholeReop30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7125_Denominator INT;

SELECT @GS7125_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7125_Rate FLOAT;

SET @GS7125_Rate = CASE
                       WHEN @GS7125_Denominator > 0 THEN
                           CAST(@GS7125_Numerator AS FLOAT) / @GS7125_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7125 - Emergency Reoperation Rate' AS Metric,
       @GS7125_Rate AS Rate,
       @GS7125_Numerator AS Numerator,
       @GS7125_Denominator AS Denominator;


/* Emergency readmission within 30 days following elective cholecystectomy (excluding for acute pancreatitis) (12mths to qtr end) 
Metric ID: GS7126

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived IN ('EL','DC') 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived IN ('EL','DC') 
AND Mort = 0

Date: Q4 2023/24

*/

-- Metric GS7126: Emergency Readmission Within 30 Days Following Elective Cholecystectomy

-- Numerator
DECLARE @GS7126_Numerator INT;

SELECT @GS7126_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7126_Denominator INT;

SELECT @GS7126_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7126_Rate FLOAT;

SET @GS7126_Rate = CASE
                       WHEN @GS7126_Denominator > 0 THEN
                           CAST(@GS7126_Numerator AS FLOAT) / @GS7126_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7126 - Emergency Readmission Rate' AS Metric,
       @GS7126_Rate AS Rate,
       @GS7126_Numerator AS Numerator,
       @GS7126_Denominator AS Denominator;

/* Adverse outcome rate following elective cholecystectomy (excluding for acute pancreatitis) (12mths to qtr end) 
Metric ID: GS7127

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived IN ('EL','DC') 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 
AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)

Count(Spells)
GenS_Cholecystectomy = 'Cholecystectomy'  
AND GenS_Pancreatitis NOT IN ('Acute pancreatitis','Acute gallstone pancreatitis') 
AND (GenS_Cholecystitis <> 'Other' OR GenS_Pancreatitis <> 'Other') 
AND POD_Derived IN ('EL','DC')

Date: Q4 2023/24

*/

-- Metric GS7127: Adverse Outcome Rate Following Elective Cholecystectomy

-- Numerator
DECLARE @GS7127_Numerator INT;

SELECT @GS7127_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived IN ( 'EL', 'DC' )
      AND
      (
          (
              GenS_FLAG_ComplicationGenS_Spell = 1
              AND ISNULL(GenS_FLAG_Complication30_Return, 0) <> 1
          )
          OR GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR GenS_FLAG_Complication30 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7127_Denominator INT;

SELECT @GS7127_Denominator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy = 'Cholecystectomy'
      AND (
          GenS_Pancreatitis NOT IN ( 'Acute pancreatitis', 'Acute gallstone pancreatitis' )
          OR GenS_Pancreatitis IS NULL
      )
      AND
      (
          GenS_Cholecystitis <> 'Other'
          OR GenS_Pancreatitis <> 'Other'
      )
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7127_Rate FLOAT;

SET @GS7127_Rate = CASE
                       WHEN @GS7127_Denominator > 0 THEN
                           CAST(@GS7127_Numerator AS FLOAT) / @GS7127_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7127 - Adverse Outcome Rate' AS Metric,
       @GS7127_Rate AS Rate,
       @GS7127_Numerator AS Numerator,
       @GS7127_Denominator AS Denominator;


/* -------------------------------------------------------------------
	Oesophago-gastric cancer
 ------------------------------------------------------------------- */

/* Number of elective admissions for gastrectomy (monthly) 
Metric ID: GS7129

Count(Spells)
NCIP_Procedure_Main = 'Gastrectomy | age 17+ | elective'

Date: Jun 2021

*/

-- Metric GS7129: Number of Elective Admissions for Gastrectomy in June 2021

DECLARE @GS7129_Count INT;

SELECT @GS7129_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cholecystectomy IN
      (
          SELECT Code FROM #CodeGroup_ALL_Cholecystectomy
      )
      AND Age >= 17
      AND Diagnosis_Code_Primary NOT IN
          (
              SELECT Code FROM #CodeGroup_ALL_Obesity
          )
      AND Diagnosis_Code_Primary NOT IN
          (
              SELECT Code FROM #CodeGroup_ALL_OvarianCancer
          )
      AND Diagnosis_Code_Primary NOT IN
          (
              SELECT Code FROM #CodeGroup_ALL_FallopianCancer
          )
      AND GenS_Cholecystectomy NOT IN
          (
              SELECT Code FROM #CodeGroup_ALL_RevisionOperations
          )
      AND POD_Derived IN ( 'EL', 'DC', 'RA' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @June_2021_StartDate AND @June_2021_EndDate;

SELECT 'Metric GS7129 - Number of Elective Admissions for Gastrectomy' AS Metric,
       @GS7129_Count AS Rate;

/* Hospital acquired condition rate for patients during elective admission for oesophago-gastric cancer (12mths to qtr end) 
Metric ID: GS7132

Count(Spells)
GenS_Cancer = 'Oesophago-gastric cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_Radiotherapy <> 'Radiotherapy dominant procedure' 
AND GenS_Chemotherapy <> 'Chemotherapy dominant procedure' 
AND GenS_HospitalAcqCond = 'Hospital acquired condition'

Count(Spells)
GenS_Cancer = 'Oesophago-gastric cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_Radiotherapy <> 'Radiotherapy dominant procedure' 
AND GenS_Chemotherapy <> 'Chemotherapy dominant procedure'

Date: Q1 2024/25

*/

-- Metric GS7132: Hospital Acquired Condition Rate During Elective Admission for Oesophago-gastric Cancer

-- Numerator
DECLARE @GS7132_Numerator INT;

SELECT @GS7132_Numerator = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_Cancer = 'Oesophago-gastric cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND
      (
          GenS_Radiotherapy <> 'Radiotherapy dominant procedure'
          OR GenS_Radiotherapy IS NULL
      )
      AND
      (
          GenS_Chemotherapy <> 'Chemotherapy dominant procedure'
          OR GenS_Chemotherapy IS NULL
      )
      AND GenS_HospitalAcqCond = 'Hospital acquired condition'
      AND Org_Code_Provider = 'RPA'
      AND Sector = 'MED'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;



-- Denominator
DECLARE @GS7132_Denominator INT;

SELECT @GS7132_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Cancer = 'Oesophago-gastric cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND
      (
          GenS_Radiotherapy <> 'Radiotherapy dominant procedure'
		  OR GenS_Radiotherapy IS NULL
      )
      AND
      (
          GenS_Chemotherapy <> 'Chemotherapy dominant procedure'
		  OR GenS_Chemotherapy IS NULL
      )
      AND Org_Code_Provider = 'RPA'
      AND Sector = 'MED'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7132_Rate FLOAT;

SET @GS7132_Rate = CASE
                       WHEN @GS7132_Denominator > 0 THEN
                           CAST(@GS7132_Numerator AS FLOAT) / @GS7132_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7132 - Hospital Acquired Condition Rate' AS Metric,
       @GS7132_Rate AS Rate,
       @GS7132_Numerator AS Numerator,
       @GS7132_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Colorectal cancer
 ------------------------------------------------------------------- */

/* Anterior resection rate for elective resection for colorectal cancer (12mths to qtr end) 
Metric ID: GS7137

Count(Spells)
NCIP_Procedure_Main = 'Colorectal cancer resection | age 17+ | elective'  
AND NCIP_Procedure_Subgroup = 'Anterior resection'

Count(Spells)
NCIP_Procedure_Main = 'Colorectal cancer resection | age 17+ | elective'

Date: Q1 2024/25

*/

-- Metric GS7137: Anterior Resection Rate for Elective Resection for Colorectal Cancer

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Denominator: All spells where GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
DECLARE @GS7137_Denominator INT;

SELECT @GS7137_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #Spells_With_Variables s
WHERE s.GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND s.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND s.Org_Code_Provider = 'rpa'
      AND s.Sector = 'med';

-- Numerator: Spells from Denominator where there is a procedure in #CodeGroup_AnteriorResection
DECLARE @GS7137_Numerator INT;

SELECT @GS7137_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #Spells_With_Variables s
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON s.Spell_Number = ipe.Spell_Number
           AND s.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
WHERE s.GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_AnteriorResection
          )
      AND ipp.Coded_Clinical_Entry_Seq
      BETWEEN 1 AND 24
      AND s.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND s.Org_Code_Provider = 'rpa'
      AND s.Sector = 'med';

-- Calculate Rate
DECLARE @GS7137_Rate FLOAT;

SET @GS7137_Rate = CASE
                       WHEN @GS7137_Denominator > 0 THEN
                           CAST(@GS7137_Numerator AS FLOAT) / @GS7137_Denominator
                       ELSE
                           NULL
                   END;

-- Output the Results
SELECT 'Metric GS7137 - Anterior Resection Rate' AS Metric,
       @GS7137_Rate AS Rate,
       @GS7137_Numerator AS Numerator,
       @GS7137_Denominator AS Denominator;

/* Emergency admission rate for resection for colorectal cancer (12mths to qtr end) 
Metric ID: GS7138

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived = 'EM'

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'

Date: Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7138_Numerator INT;

SELECT @GS7138_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7138_Denominator INT;

SELECT @GS7138_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7138_Rate FLOAT;

SET @GS7138_Rate = CASE
                       WHEN @GS7138_Denominator > 0 THEN
                           CAST(@GS7138_Numerator AS FLOAT) / @GS7138_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7138 - Emergency Admission Rate' AS Metric,
       @GS7138_Rate AS Rate,
       @GS7138_Numerator AS Numerator,
       @GS7138_Denominator AS Denominator;


/* Insertion of stoma rate for elective anterior resection for colorectal cancer (12mths to qtr end) 
Metric ID: GS7140

Count(Spells)
NCIP_Procedure_Main = 'Colorectal cancer resection | age 17+ | elective' 
AND NCIP_Procedure_Subgroup = 'Anterior resection' 
AND GenS_StomaCreation = 'Stoma creation'

Count(Spells)
NCIP_Procedure_Main = 'Colorectal cancer resection | age 17+ | elective' 
AND NCIP_Procedure_Subgroup = 'Anterior resection'

Date: Q1 2024/25

*/

-- Metric GS7140: Insertion of Stoma Rate for Elective Anterior Resection for Colorectal Cancer

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Denominator: Spells where GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
-- and procedure codes include codes from #CodeGroup_AnteriorResection

DECLARE @GS7140_Denominator INT;

-- Step 1: Create a temporary table for Denominator Spells
IF OBJECT_ID('tempdb..#DenominatorSpells') IS NOT NULL
    DROP TABLE #DenominatorSpells;

SELECT DISTINCT
       s.Spell_Number
INTO #DenominatorSpells
FROM #Spells_With_Variables s
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON s.Spell_Number = ipe.Spell_Number
           AND s.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
WHERE s.GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_AnteriorResection
          )
      AND ipp.Coded_Clinical_Entry_Seq
      BETWEEN 1 AND 24
      AND s.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND s.Org_Code_Provider = 'rpa'
      AND s.Sector = 'med';

-- Step 2: Calculate Denominator
SELECT @GS7140_Denominator = COUNT(DISTINCT Spell_Number)
FROM #DenominatorSpells;

-- Numerator: Spells from Denominator where GenS_StomaCreation = 'Stoma creation'

DECLARE @GS7140_Numerator INT;

SELECT @GS7140_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #DenominatorSpells ds
    INNER JOIN #Spells_With_Variables s
        ON ds.Spell_Number = s.Spell_Number
WHERE s.GenS_StomaCreation = 'Stoma creation';

-- Calculate Rate
DECLARE @GS7140_Rate FLOAT;

SET @GS7140_Rate = CASE
                       WHEN @GS7140_Denominator > 0 THEN
                           CAST(@GS7140_Numerator AS FLOAT) / @GS7140_Denominator
                       ELSE
                           NULL
                   END;

-- Output the Results
SELECT 'Metric GS7140 - Insertion of Stoma Rate' AS Metric,
       @GS7140_Rate AS Rate,
       @GS7140_Numerator AS Numerator,
       @GS7140_Denominator AS Denominator;

-- Clean up temporary table
DROP TABLE #DenominatorSpells;

/* 18 month stoma reversal rate following elective resection for colorectal cancer (excluding abdominoperineal resection) (12mths to qtr end) 
Metric ID: GS7141

Count(Spells)
NCIP_Procedure_Main = 'Colorectal cancer resection | age 17+ | elective' 
AND NCIP_Procedure_Subgroup <> 'Abdominoperineal resection' 
AND GenS_FLAG_StomaRev18mths = 1

Count(Spells)
NCIP_Procedure_Main = 'Colorectal cancer resection | age 17+ | elective' 
AND NCIP_Procedure_Subgroup <> 'Abdominoperineal resection'

Date: Q3 2022/23

*/


-- Metric GS7141: 18-Month Stoma Reversal Rate Following Elective Resection for Colorectal Cancer (Excluding Abdominoperineal Resection)

-- Adjusted Date Range for Denominator
DECLARE @Surgery_StartDate DATE = '2022-01-01';
DECLARE @Surgery_EndDate DATE = '2022-12-31';

-- Denominator: Spells where GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
-- and procedure codes DO NOT include codes from #CodeGroup_ALL_Abdominoperineal_Resection

DECLARE @GS7141_Denominator INT;

-- Step 1: Create a temporary table for Denominator Spells
IF OBJECT_ID('tempdb..#DenominatorSpells') IS NOT NULL
    DROP TABLE #DenominatorSpells;

SELECT DISTINCT
       s.Spell_Number,
       s.Discharge_Date
INTO #DenominatorSpells
FROM #Spells_With_Variables s
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON s.Spell_Number = ipe.Spell_Number
           AND s.Sector = ipe.Sector
WHERE s.GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND s.Admission_Date
      BETWEEN @Surgery_StartDate AND @Surgery_EndDate
      AND s.Org_Code_Provider = 'rpa'
      AND s.Sector = 'med'
      AND NOT EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp_excl
    WHERE ipp_excl.Episode_Number = ipe.Episode_Number
          AND ipp_excl.Sector = ipe.Sector
          AND ipp_excl.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp_excl.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Abdominoperineal_Resection
              )
);

-- Step 2: Calculate Denominator
SELECT @GS7141_Denominator = COUNT(DISTINCT Spell_Number)
FROM #DenominatorSpells;

-- Numerator: Spells from Denominator where GenS_FLAG_StomaRev18mths = 1

DECLARE @GS7141_Numerator INT;

SELECT @GS7141_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #DenominatorSpells ds
    INNER JOIN #Spells_With_Variables s
        ON ds.Spell_Number = s.Spell_Number
WHERE s.GenS_FLAG_StomaRev18mths = 1;

-- Calculate Rate
DECLARE @GS7141_Rate FLOAT;

SET @GS7141_Rate = CASE
                       WHEN @GS7141_Denominator > 0 THEN
                           CAST(@GS7141_Numerator AS FLOAT) / @GS7141_Denominator
                       ELSE
                           NULL
                   END;

-- Output the Results
SELECT 'Metric GS7141 - 18-Month Stoma Reversal Rate' AS Metric,
       @GS7141_Rate AS Rate,
       @GS7141_Numerator AS Numerator,
       @GS7141_Denominator AS Denominator;

-- Clean up temporary table
DROP TABLE #DenominatorSpells;

/* -------------------------------------------------------------------
	Colon cancer
 ------------------------------------------------------------------- */

/* Number of elective resection for colon cancer procedures (monthly) 
Metric ID: GS7142

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer'

Jun 2024

*/

-- Date Range: June 2024
DECLARE @June_2024_StartDate DATE = '2024-06-01';
DECLARE @June_2024_EndDate DATE = '2024-06-30';

-- Count
DECLARE @GS7142_Count INT;

SELECT @GS7142_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @June_2024_StartDate AND @June_2024_EndDate;

SELECT 'Metric GS7142 - Number of Elective Resections for Colon Cancer' AS Metric,
       @GS7142_Count AS [Count];


/* Median length of stay for elective resection for colon cancer (12mths to qtr end) 
Metric ID: GS7143

Median(Spell_LOS)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer'

COUNT(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer'



Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @GS7143_Count INT;

SELECT @GS7143_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7143_MedianLOS FLOAT;

WITH OrderedLOS
AS (SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
          AND POD_Derived IN ( 'DC', 'EL' )
          AND GenS_ColorectalCancer = 'Colon cancer'
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date
          BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate)
SELECT @GS7143_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7143_Count + 1) / 2, (@GS7143_Count + 2) / 2 );

SELECT 'Metric GS7143 - Median Length of Stay' AS Metric,
       @GS7143_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7143_Count AS Denominator;


/* Hospital acquired condition rate for patients during an elective admission for colon cancer (12mths to qtr end) 
Metric ID: GS7144

Count(Spells)
POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer' 
AND GenS_Radiotherapy <> 'Radiotherapy dominant procedure' 
AND GenS_Chemotherapy <> 'Chemotherapy dominant procedure' 
AND GenS_HospitalAcqCond = 'Hospital acquired condition'

Count(Spells)
POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer' 
AND GenS_Radiotherapy <> 'Radiotherapy dominant procedure' 
AND GenS_Chemotherapy <> 'Chemotherapy dominant procedure'

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7144_Numerator INT;

SELECT @GS7144_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND
      (
          GenS_Radiotherapy <> 'Radiotherapy dominant procedure'
          OR GenS_Radiotherapy IS NULL
      )
      AND
      (
          GenS_Chemotherapy <> 'Chemotherapy dominant procedure'
          OR GenS_Chemotherapy IS NULL
      )
      AND GenS_HospitalAcqCond = 'Hospital acquired condition'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7144_Denominator INT;

SELECT @GS7144_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND
      (
          GenS_Radiotherapy <> 'Radiotherapy dominant procedure'
          OR GenS_Radiotherapy IS NULL
      )
      AND
      (
          GenS_Chemotherapy <> 'Chemotherapy dominant procedure'
          OR GenS_Chemotherapy IS NULL
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7144_Rate FLOAT;

SET @GS7144_Rate = CASE
                       WHEN @GS7144_Denominator > 0 THEN
                           CAST(@GS7144_Numerator AS FLOAT) / @GS7144_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7144 - Hospital Acquired Condition Rate' AS Metric,
       @GS7144_Rate AS Rate,
       @GS7144_Numerator AS Numerator,
       @GS7144_Denominator AS Denominator;


/* Emergency readmission within 30 days following elective resection for colon cancer (12mths to qtr end) 
Metric ID: GS7145

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer' 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer' 
AND Mort = 0

Q4 2023/24

*/

DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7145_Numerator INT;

SELECT @GS7145_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7145_Denominator INT;

SELECT @GS7145_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7145_Rate FLOAT;

SET @GS7145_Rate = CASE
                       WHEN @GS7145_Denominator > 0 THEN
                           CAST(@GS7145_Numerator AS FLOAT) / @GS7145_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7145 - Emergency Readmission Rate' AS Metric,
       @GS7145_Rate AS Rate,
       @GS7145_Numerator AS Numerator,
       @GS7145_Denominator AS Denominator;


/* Adverse outcome rate following elective resection for colon cancer (12mths to qtr end) 
Metric ID: GS7146

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer' 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 
AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer'

Q4 2023/24

*/

-- Date Range: Q4 2023/24
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7146_Numerator INT;

SELECT @GS7146_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND
      (
          (
              GenS_FLAG_ComplicationGenS_Spell = 1
              AND ISNULL(GenS_FLAG_Complication30_Return, 0) <> 1
          )
          OR GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR GenS_FLAG_Complication30 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7146_Denominator INT;

SELECT @GS7146_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7146_Rate FLOAT;

SET @GS7146_Rate = CASE
                       WHEN @GS7146_Denominator > 0 THEN
                           CAST(@GS7146_Numerator AS FLOAT) / @GS7146_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7146 - Adverse Outcome Rate' AS Metric,
       @GS7146_Rate AS Rate,
       @GS7146_Numerator AS Numerator,
       @GS7146_Denominator AS Denominator;


/* Average length of stay for elective local excision for colon cancer (12mths to qtr end) 
Metric ID: GS7147

Sum(Spell_LOS)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer'

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer'

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Calculate Total LOS and Count
DECLARE @GS7147_TotalLOS FLOAT;
DECLARE @GS7147_Count INT;

SELECT @GS7147_TotalLOS = SUM(Spell_LOS),
       @GS7147_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Average LOS
DECLARE @GS7147_AverageLOS FLOAT;

SET @GS7147_AverageLOS = CASE
                             WHEN @GS7147_Count > 0 THEN
                                 @GS7147_TotalLOS / @GS7147_Count
                             ELSE
                                 NULL
                         END;

SELECT 'Metric GS7147 - Average Length of Stay' AS Metric,
       @GS7147_AverageLOS AS Average_LOS,
       @GS7147_TotalLOS AS Total_LOS,
       @GS7147_Count AS [Count];


/* Emergency readmission within 30 days following elective local excision for colon cancer (12mths to qtr end) 
Metric ID: GS7148

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer' 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer' 
AND Mort = 0

Q4 2023/24

*/

-- Date Range: Q4 2023/24
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7148_Numerator INT;

SELECT @GS7148_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7148_Denominator INT;

SELECT @GS7148_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7148_Rate FLOAT;

SET @GS7148_Rate = CASE
                       WHEN @GS7148_Denominator > 0 THEN
                           CAST(@GS7148_Numerator AS FLOAT) / @GS7148_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7148 - Emergency Readmission Rate' AS Metric,
       @GS7148_Rate AS Rate,
       @GS7148_Numerator AS Numerator,
       @GS7148_Denominator AS Denominator;


/* Adverse outcome rate following elective local excision for colon cancer (12mths to qtr end) 
Metric ID: GS7149

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer' 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 
AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer = 'Colon cancer'

Q42023

*/

DECLARE @Q4_2023_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7149_Numerator INT;

SELECT @GS7149_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND
      (
          (
              GenS_FLAG_ComplicationGenS_Spell = 1
              AND ISNULL(GenS_FLAG_Complication30_Return, 0) <> 1
          )
          OR GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR GenS_FLAG_Complication30 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_StartDate AND @Q4_2023_EndDate;

-- Denominator
DECLARE @GS7149_Denominator INT;

SELECT @GS7149_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer = 'Colon cancer'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_StartDate AND @Q4_2023_EndDate;

-- Calculate Rate
DECLARE @GS7149_Rate FLOAT;

SET @GS7149_Rate = CASE
                       WHEN @GS7149_Denominator > 0 THEN
                           CAST(@GS7149_Numerator AS FLOAT) / @GS7149_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7149 - Adverse Outcome Rate' AS Metric,
       @GS7149_Rate AS Rate,
       @GS7149_Numerator AS Numerator,
       @GS7149_Denominator AS Denominator;


/* -------------------------------------------------------------------
	Rectal cancer
 ------------------------------------------------------------------- */

/* Number of elective resection for rectal cancer procedures (monthly) 
Metric ID: GS7150

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer')

Jun 2024

*/

-- Date Range: June 2024
DECLARE @June_2024_StartDate DATE = '2024-06-01';
DECLARE @June_2024_EndDate DATE = '2024-06-30';

-- Count
DECLARE @RectalCancer_Count INT;

SELECT @RectalCancer_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @June_2024_StartDate AND @June_2024_EndDate;

SELECT 'Number of Elective Resection for Rectal Cancer Procedures' AS Metric,
       @RectalCancer_Count AS [Count];

/* Median length of stay for elective resection for rectal cancer (12mths to qtr end) 
Metric ID: GS7151

Median(Spell_LOS)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer')

COUNT(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer')

Q1 2024/25


*/

-- Date Range: Q1 2024/25 (April to June 2024)
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @RectalCancer_LOS_Count INT;

SELECT @RectalCancer_LOS_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @RectalCancer_MedianLOS FLOAT;

WITH OrderedLOS
AS (SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
          AND POD_Derived IN ( 'DC', 'EL' )
          AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date
          BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate)
SELECT @RectalCancer_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@RectalCancer_LOS_Count + 1) / 2, (@RectalCancer_LOS_Count + 2) / 2 );

SELECT 'Median Length of Stay for Elective Resection for Rectal Cancer' AS Metric,
       @RectalCancer_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @RectalCancer_LOS_Count AS Denominator;


/* Hospital acquired condition rate for patients during an elective for rectal cancer (12mths to qtr end) 
Metric ID:

Count(Spells)
POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer') 
AND GenS_Radiotherapy <> 'Radiotherapy dominant procedure' 
AND GenS_Chemotherapy <> 'Chemotherapy dominant procedure' 
AND GenS_HospitalAcqCond = 'Hospital acquired condition'

Count(Spells)
POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer') 
AND GenS_Radiotherapy <> 'Radiotherapy dominant procedure' 
AND GenS_Chemotherapy <> 'Chemotherapy dominant procedure'

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @RectalCancer_HAC_Numerator INT;

SELECT @RectalCancer_HAC_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND
      (
          GenS_Radiotherapy <> 'Radiotherapy dominant procedure'
          OR GenS_Radiotherapy IS NULL
      )
      AND
      (
          GenS_Chemotherapy <> 'Chemotherapy dominant procedure'
          OR GenS_Chemotherapy IS NULL
      )
      AND GenS_HospitalAcqCond = 'Hospital acquired condition'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @RectalCancer_HAC_Denominator INT;

SELECT @RectalCancer_HAC_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND
      (
          GenS_Radiotherapy <> 'Radiotherapy dominant procedure'
          OR GenS_Radiotherapy IS NULL
      )
      AND
      (
          GenS_Chemotherapy <> 'Chemotherapy dominant procedure'
          OR GenS_Chemotherapy IS NULL
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @RectalCancer_HAC_Rate FLOAT;

SET @RectalCancer_HAC_Rate = CASE
                                 WHEN @RectalCancer_HAC_Denominator > 0 THEN
                                     CAST(@RectalCancer_HAC_Numerator AS FLOAT) / @RectalCancer_HAC_Denominator
                                 ELSE
                                     NULL
                             END;

SELECT 'Hospital Acquired Condition Rate for Elective Admission for Rectal Cancer' AS Metric,
       @RectalCancer_HAC_Rate AS Rate,
       @RectalCancer_HAC_Numerator AS Numerator,
       @RectalCancer_HAC_Denominator AS Denominator;


/* Emergency readmission within 30 days following elective resection for rectal cancer (12mths to qtr end) 
Metric ID:

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer') 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer') 
AND Mort = 0

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-04-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @RectalCancer_Readmit_Numerator INT;

SELECT @RectalCancer_Readmit_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @RectalCancer_Readmit_Denominator INT;

SELECT @RectalCancer_Readmit_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @RectalCancer_Readmit_Rate FLOAT;

SET @RectalCancer_Readmit_Rate
    = CASE
          WHEN @RectalCancer_Readmit_Denominator > 0 THEN
              CAST(@RectalCancer_Readmit_Numerator AS FLOAT) / @RectalCancer_Readmit_Denominator
          ELSE
              NULL
      END;

SELECT 'Emergency Readmission Within 30 Days Following Elective Resection for Rectal Cancer' AS Metric,
       @RectalCancer_Readmit_Rate AS Rate,
       @RectalCancer_Readmit_Numerator AS Numerator,
       @RectalCancer_Readmit_Denominator AS Denominator;


/* Adverse outcome rate following elective resection for rectal cancer (12mths to qtr end) 
Metric ID:

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer') 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 
AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)

Count(Spells)
GenS_ColonicResection_Cancer = 'Resection for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer')

Q1 2024/25

*/

-- Date Range: Q4 2023/24
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @RectalCancer_Adverse_Numerator INT;

SELECT @RectalCancer_Adverse_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND
      (
          (
              GenS_FLAG_ComplicationGenS_Spell = 1
              AND ISNULL(GenS_FLAG_Complication30_Return, 0) <> 1
          )
          OR GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR GenS_FLAG_Complication30 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @RectalCancer_Adverse_Denominator INT;

SELECT @RectalCancer_Adverse_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @RectalCancer_Adverse_Rate FLOAT;

SET @RectalCancer_Adverse_Rate
    = CASE
          WHEN @RectalCancer_Adverse_Denominator > 0 THEN
              CAST(@RectalCancer_Adverse_Numerator AS FLOAT) / @RectalCancer_Adverse_Denominator
          ELSE
              NULL
      END;

SELECT 'Adverse Outcome Rate Following Elective Resection for Rectal Cancer' AS Metric,
       @RectalCancer_Adverse_Rate AS Rate,
       @RectalCancer_Adverse_Numerator AS Numerator,
       @RectalCancer_Adverse_Denominator AS Denominator;


/* Average length of stay for elective local excision for rectal cancer (including TEMS/TAMIS) (12mths to qtr end) 
Metric ID:

Sum(Spell_LOS)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer')

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer')

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Calculate Total LOS and Count
DECLARE @RectalCancer_LocalExc_TotalLOS FLOAT;
DECLARE @RectalCancer_LocalExc_Count INT;

SELECT @RectalCancer_LocalExc_TotalLOS = SUM(Spell_LOS),
       @RectalCancer_LocalExc_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Average LOS
DECLARE @RectalCancer_LocalExc_AverageLOS FLOAT;

SET @RectalCancer_LocalExc_AverageLOS = CASE
                                            WHEN @RectalCancer_LocalExc_Count > 0 THEN
                                                @RectalCancer_LocalExc_TotalLOS / @RectalCancer_LocalExc_Count
                                            ELSE
                                                NULL
                                        END;

SELECT 'Average Length of Stay for Elective Local Excision for Rectal Cancer' AS Metric,
       @RectalCancer_LocalExc_AverageLOS AS Average_LOS,
       @RectalCancer_LocalExc_TotalLOS AS Total_LOS,
       @RectalCancer_LocalExc_Count AS [Count];


/* Emergency readmission within 30 days following elective local excision for rectal cancer (including TEMS/TAMIS) (12mths to qtr end) 
Metric ID:

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer') 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer') 
AND Mort = 0

Q4 2023/24

*/

-- Date Range: Q4 2023/24 (January to March 2024)
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @RectalCancer_LocalExc_Readmit_Numerator INT;

SELECT @RectalCancer_LocalExc_Readmit_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @RectalCancer_LocalExc_Readmit_Denominator INT;

SELECT @RectalCancer_LocalExc_Readmit_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @RectalCancer_LocalExc_Readmit_Rate FLOAT;

SET @RectalCancer_LocalExc_Readmit_Rate
    = CASE
          WHEN @RectalCancer_LocalExc_Readmit_Denominator > 0 THEN
              CAST(@RectalCancer_LocalExc_Readmit_Numerator AS FLOAT) / @RectalCancer_LocalExc_Readmit_Denominator
          ELSE
              NULL
      END;

SELECT 'Emergency Readmission Within 30 Days Following Elective Local Excision for Rectal Cancer' AS Metric,
       @RectalCancer_LocalExc_Readmit_Rate AS Rate,
       @RectalCancer_LocalExc_Readmit_Numerator AS Numerator,
       @RectalCancer_LocalExc_Readmit_Denominator AS Denominator;


/* Adverse outcome rate following elective local excision for rectal cancer (including TEMS/TAMIS) (12mths to qtr end) 
Metric ID:

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer') 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 
AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)

Count(Spells)
GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer' 
AND POD_Derived IN ('DC','EL') 
AND GenS_ColorectalCancer IN ('Anal cancer','Rectal cancer','Rectosigmoid cancer')

Q4 2023/24

*/

DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @RectalCancer_LocalExc_Adverse_Numerator INT;

SELECT @RectalCancer_LocalExc_Adverse_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND
      (
          (
              GenS_FLAG_ComplicationGenS_Spell = 1
              AND ISNULL(GenS_FLAG_Complication30_Return, 0) <> 1
          )
          OR GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR GenS_FLAG_Complication30 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @RectalCancer_LocalExc_Adverse_Denominator INT;

SELECT @RectalCancer_LocalExc_Adverse_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_LocalExcColorectCancer = 'Local excision for colorectal cancer'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND GenS_ColorectalCancer IN ( 'Anal cancer', 'Rectal cancer', 'Rectosigmoid cancer' )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @RectalCancer_LocalExc_Adverse_Rate FLOAT;

SET @RectalCancer_LocalExc_Adverse_Rate
    = CASE
          WHEN @RectalCancer_LocalExc_Adverse_Denominator > 0 THEN
              CAST(@RectalCancer_LocalExc_Adverse_Numerator AS FLOAT) / @RectalCancer_LocalExc_Adverse_Denominator
          ELSE
              NULL
      END;

SELECT 'Adverse Outcome Rate Following Elective Local Excision for Rectal Cancer' AS Metric,
       @RectalCancer_LocalExc_Adverse_Rate AS Rate,
       @RectalCancer_LocalExc_Adverse_Numerator AS Numerator,
       @RectalCancer_LocalExc_Adverse_Denominator AS Denominator;


/* -------------------------------------------------------------------
	Liver resection for cancer
 ------------------------------------------------------------------- */

/* Hospital acquired condition rate for patients during elective admission for liver cancer (12mths to qtr end) 
Metric ID:

Count(Spells)
GenS_Cancer = 'Cancer of the liver' 
AND POD_Derived IN ('DC','EL') 
AND GenS_Radiotherapy <> 'Radiotherapy dominant procedure' 
AND GenS_Chemotherapy <> 'Chemotherapy dominant procedure' 
AND GenS_HospitalAcqCond = 'Hospital acquired condition'

Count(Spells)
GenS_Cancer = 'Cancer of the liver' 
AND POD_Derived IN ('DC','EL') 
AND GenS_Radiotherapy <> 'Radiotherapy dominant procedure' 
AND GenS_Chemotherapy <> 'Chemotherapy dominant procedure'

Q1 2024/25

*/

-- Date Range: Q1 2024/25 (12 months to quarter end)
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @LiverCancer_HAC_Numerator INT;

SELECT @LiverCancer_HAC_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Cancer = 'Cancer of the liver'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND
      (
          GenS_Radiotherapy IS NULL
          OR GenS_Radiotherapy <> 'Radiotherapy dominant procedure'
      )
      AND
      (
          GenS_Chemotherapy IS NULL
          OR GenS_Chemotherapy <> 'Chemotherapy dominant procedure'
      )
      AND GenS_HospitalAcqCond = 'Hospital acquired condition'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @LiverCancer_HAC_Denominator INT;

SELECT @LiverCancer_HAC_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Cancer = 'Cancer of the liver'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND
      (
          GenS_Radiotherapy IS NULL
          OR GenS_Radiotherapy <> 'Radiotherapy dominant procedure'
      )
      AND
      (
          GenS_Chemotherapy IS NULL
          OR GenS_Chemotherapy <> 'Chemotherapy dominant procedure'
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @LiverCancer_HAC_Rate FLOAT;

SET @LiverCancer_HAC_Rate = CASE
                                WHEN @LiverCancer_HAC_Denominator > 0 THEN
                                    CAST(@LiverCancer_HAC_Numerator AS FLOAT) / @LiverCancer_HAC_Denominator
                                ELSE
                                    NULL
                            END;

SELECT 'Hospital Acquired Condition Rate for Elective Admission for Liver Cancer' AS Metric,
       @LiverCancer_HAC_Rate AS Rate,
       @LiverCancer_HAC_Numerator AS Numerator,
       @LiverCancer_HAC_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Incisional hernia repair
 ------------------------------------------------------------------- */

-- Create Temporary Table for Eligible Spells

IF OBJECT_ID('tempdb..#IncisionalHerniaRepairElectiveSpells') IS NOT NULL
    DROP TABLE #IncisionalHerniaRepairElectiveSpells;

WITH SpellsWithProcedure
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Incisional_hernia_repair
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ALL_Ventral_hernia_repair
                 )
          )),
     SpellsWithDiagnosis
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipd.Coded_Clinical_Entry_Seq = 1
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Incisional_hernia
              )),
     EligibleSpells
AS (SELECT DISTINCT
           s.Spell_Number
    FROM SpellsWithProcedure s
        INNER JOIN SpellsWithDiagnosis d
            ON s.Spell_Number = d.Spell_Number
        INNER JOIN #Spells_With_Variables swv
            ON s.Spell_Number = swv.Spell_Number
    WHERE swv.Age >= 17
          AND swv.POD_Derived IN ( 'EL', 'DC', 'RA' )),
     SpellsToExcludeProcedure
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND
          (
              LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_RevisionOperations
              )
              OR LEFT(ipp.Procedure_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_RevisionOfUrinaryDiversion
                 )
          )),
     SpellsToExcludeDiagnosis
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipd.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_OvarianCancer
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ALL_FallopianCancer
                 )
          ))
SELECT e.Spell_Number
INTO #IncisionalHerniaRepairElectiveSpells
FROM EligibleSpells e
    LEFT JOIN SpellsToExcludeProcedure ep
        ON e.Spell_Number = ep.Spell_Number
    LEFT JOIN SpellsToExcludeDiagnosis ed
        ON e.Spell_Number = ed.Spell_Number
WHERE ep.Spell_Number IS NULL
      AND ed.Spell_Number IS NULL;

/* Number of elective laparoscopic incisional hernia repair procedures (monthly)
Metric ID: GS7177

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')


*/

-- Date Range: May 2024
DECLARE @May_2024_StartDate DATE = '2024-05-01';
DECLARE @May_2024_EndDate DATE = '2024-05-31';

-- Count
DECLARE @GS7177_Denominator INT;

SELECT @GS7177_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #IncisionalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Admission_Date
      BETWEEN @May_2024_StartDate AND @May_2024_EndDate
      AND
      (
          swv.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR swv.GenS_MinimalAccess IS NULL
      )
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

SELECT 'Number of Elective Laparoscopic Incisional Hernia Repair Procedures' AS Metric,
       @GS7177_Denominator AS [Count];


/* Number of elective open incisional hernia repair procedures (monthly) 
Metric ID:

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Jun 2024

*/

-- Date Range: May 2024
DECLARE @May_2024_StartDate DATE = '2024-06-01';
DECLARE @May_2024_EndDate DATE = '2024-06-30';

-- Count
DECLARE @IncisionalHernia_Open_Count INT;

SELECT @IncisionalHernia_Open_Count = COUNT(DISTINCT s.Spell_Number)
FROM #IncisionalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Admission_Date
      BETWEEN @May_2024_StartDate AND @May_2024_EndDate
      AND
      (
          swv.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR swv.GenS_MinimalAccess IS NULL
      )
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

SELECT 'Number of Elective Open Incisional Hernia Repair Procedures' AS Metric,
       @IncisionalHernia_Open_Count AS [Count];

/* Emergency admission rate for incisional hernia repair (12mths to qtr end) 
Metric ID:

Count(Spells)
GenS_IncisionalHerniaRepair = 'Incisional hernia repair' 
AND POD_Derived = 'EM'

Count(Spells)
GenS_IncisionalHerniaRepair = 'Incisional hernia repair'

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @IncisionalHernia_EM_Numerator INT;

SELECT @IncisionalHernia_EM_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @IncisionalHernia_EM_Denominator INT;

SELECT @IncisionalHernia_EM_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @IncisionalHernia_EM_Rate FLOAT;

SET @IncisionalHernia_EM_Rate
    = CASE
          WHEN @IncisionalHernia_EM_Denominator > 0 THEN
              CAST(@IncisionalHernia_EM_Numerator AS FLOAT) / @IncisionalHernia_EM_Denominator
          ELSE
              NULL
      END;

SELECT 'Emergency Admission Rate for Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_EM_Rate AS Rate,
       @IncisionalHernia_EM_Numerator AS Numerator,
       @IncisionalHernia_EM_Denominator AS Denominator;


/* Minimal access rate for elective incisional hernia repair (12mths to qtr end) 
Metric ID:

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective'

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @IncisionalHernia_MinAcc_Numerator INT;

SELECT @IncisionalHernia_MinAcc_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #IncisionalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Denominator
DECLARE @IncisionalHernia_MinAcc_Denominator INT;

SELECT @IncisionalHernia_MinAcc_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #IncisionalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Calculate Rate
DECLARE @IncisionalHernia_MinAcc_Rate FLOAT;

SET @IncisionalHernia_MinAcc_Rate
    = CASE
          WHEN @IncisionalHernia_MinAcc_Denominator > 0 THEN
              CAST(@IncisionalHernia_MinAcc_Numerator AS FLOAT) / @IncisionalHernia_MinAcc_Denominator
          ELSE
              NULL
      END;

SELECT 'Minimal Access Rate for Elective Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_MinAcc_Rate AS Rate,
       @IncisionalHernia_MinAcc_Numerator AS Numerator,
       @IncisionalHernia_MinAcc_Denominator AS Denominator;

/* Use of mesh rate for elective incisional hernia repair (12mths to qtr end) 
Metric ID:

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND NCIP_Procedure_Subgroup IN ('Incisional natural mesh','Incisional synthetic mesh')

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Denominator: All elective incisional hernia repair spells
DECLARE @IncisionalHernia_Mesh_Denominator INT;

SELECT @IncisionalHernia_Mesh_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND SWV.Age >= 17
      AND SWV.POD_Derived IN ( 'EL', 'DC', 'RA' )
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Numerator: Spells where mesh was used
DECLARE @IncisionalHernia_Mesh_Numerator INT;

WITH MeshSpells
AS (SELECT DISTINCT
           SWV.Spell_Number
    FROM #Spells_With_Variables SWV
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON SWV.Spell_Number = ipe.Spell_Number
               AND SWV.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
          AND SWV.Age >= 17
          AND SWV.POD_Derived IN ( 'EL', 'DC', 'RA' )
          AND SWV.Org_Code_Provider = 'rpa'
          AND SWV.Sector = 'med'
          AND SWV.Admission_Date
          BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_MeshProcedures
              )
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24)
SELECT @IncisionalHernia_Mesh_Numerator = COUNT(DISTINCT Spell_Number)
FROM MeshSpells;

-- Calculate Rate
DECLARE @IncisionalHernia_Mesh_Rate FLOAT;

SET @IncisionalHernia_Mesh_Rate
    = CASE
          WHEN @IncisionalHernia_Mesh_Denominator > 0 THEN
              CAST(@IncisionalHernia_Mesh_Numerator AS FLOAT) / @IncisionalHernia_Mesh_Denominator
          ELSE
              NULL
      END;

SELECT 'Use of Mesh Rate for Elective Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_Mesh_Rate AS Rate,
       @IncisionalHernia_Mesh_Numerator AS Numerator,
       @IncisionalHernia_Mesh_Denominator AS Denominator;


/* Daycase rate for elective laparoscopic incisional hernia repair (12mths to qtr end) 
Metric ID:

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND POD_Derived IN ('DC') 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')


Q4 2021/22

*/

-- Date Range: Q4 2021/22 (January to March 2022)
DECLARE @Q4_2021_22_StartDate DATE = '2021-04-01';
DECLARE @Q4_2021_22_EndDate DATE = '2022-03-31';

-- Count
DECLARE @IncisionalHernia_Lap_DayCase_Count INT;

SELECT @IncisionalHernia_Lap_DayCase_Count = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND SWV.POD_Derived = 'DC'
      AND SWV.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q4_2021_22_StartDate AND @Q4_2021_22_EndDate;

-- Count
DECLARE @IncisionalHernia_Lap_Count INT;

SELECT @IncisionalHernia_Lap_Count = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND SWV.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q4_2021_22_StartDate AND @Q4_2021_22_EndDate;

-- Calculate Rate
DECLARE @IncisionalHernia_Rate FLOAT;

SET @IncisionalHernia_Rate = CASE
                                 WHEN @IncisionalHernia_Lap_Count > 0 THEN
                                     CAST(@IncisionalHernia_Lap_DayCase_Count AS FLOAT) / @IncisionalHernia_Lap_Count
                                 ELSE
                                     NULL
                             END;

SELECT 'Day Case Rate for Elective Laparoscopic Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_Rate AS Rate,
       @IncisionalHernia_Lap_DayCase_Count AS [Numerator],
       @IncisionalHernia_Lap_Count AS [Denominator];

/* Daycase rate for elective open incisional hernia repair (12mths to qtr end) 
Metric ID:

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND POD_Derived IN ('DC') AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @IncisionalHernia_Open_DayCase_Numerator INT;

SELECT @IncisionalHernia_Open_DayCase_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND SWV.POD_Derived = 'DC'
      AND
      (
          SWV.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR SWV.GenS_MinimalAccess IS NULL
      )
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @IncisionalHernia_Open_DayCase_Denominator INT;

SELECT @IncisionalHernia_Open_DayCase_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND
      (
          SWV.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR SWV.GenS_MinimalAccess IS NULL
      )
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @IncisionalHernia_Open_DayCase_Rate FLOAT;

SET @IncisionalHernia_Open_DayCase_Rate
    = CASE
          WHEN @IncisionalHernia_Open_DayCase_Denominator > 0 THEN
              CAST(@IncisionalHernia_Open_DayCase_Numerator AS FLOAT) / @IncisionalHernia_Open_DayCase_Denominator
          ELSE
              NULL
      END;

SELECT 'Day Case Rate for Elective Open Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_Open_DayCase_Rate AS Rate,
       @IncisionalHernia_Open_DayCase_Numerator AS Numerator,
       @IncisionalHernia_Open_DayCase_Denominator AS Denominator;

/* Median length of stay for elective laparoscopic incisional hernia repair (12mths to qtr end) 
Metric ID:

Median(Spell_LOS)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

COUNT(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Q4 2021/22

*/

DECLARE @Q4_2021_22_StartDate DATE = '2021-04-01';
DECLARE @Q4_2021_22_EndDate DATE = '2022-03-31';

-- Count of Spells
DECLARE @IncisionalHernia_Lap_LOS_Count INT;

SELECT @IncisionalHernia_Lap_LOS_Count = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND SWV.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q4_2021_22_StartDate AND @Q4_2021_22_EndDate;

-- Calculate Median Spell_LOS
DECLARE @IncisionalHernia_Lap_MedianLOS FLOAT;

WITH OrderedLOS
AS (SELECT SWV.Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY SWV.Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY SWV.Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables SWV
    WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
          AND SWV.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          AND SWV.Org_Code_Provider = 'rpa'
          AND SWV.Sector = 'med'
          AND SWV.Admission_Date
          BETWEEN @Q4_2021_22_StartDate AND @Q4_2021_22_EndDate)
SELECT @IncisionalHernia_Lap_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@IncisionalHernia_Lap_LOS_Count + 1) / 2, (@IncisionalHernia_Lap_LOS_Count + 2) / 2 );

SELECT 'Median Length of Stay for Elective Laparoscopic Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_Lap_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @IncisionalHernia_Lap_LOS_Count AS Denominator;

/* Median length of stay for elective open incisional hernia repair (12mths to qtr end) 
Metric ID:

Median(Spell_LOS)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

COUNT(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @IncisionalHernia_Open_LOS_Count INT;

SELECT @IncisionalHernia_Open_LOS_Count = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND
      (
          SWV.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR SWV.GenS_MinimalAccess IS NULL
      )
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @IncisionalHernia_Open_MedianLOS FLOAT;

WITH OrderedLOS
AS (SELECT SWV.Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY SWV.Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY SWV.Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables SWV
    WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
          AND
          (
              SWV.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach',
                                              'Robotic approach'
                                            )
              OR SWV.GenS_MinimalAccess IS NULL
          )
          AND SWV.Org_Code_Provider = 'rpa'
          AND SWV.Sector = 'med'
          AND SWV.Admission_Date
          BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate)
SELECT @IncisionalHernia_Open_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@IncisionalHernia_Open_LOS_Count + 1) / 2, (@IncisionalHernia_Open_LOS_Count + 2) / 2 );

SELECT 'Median Length of Stay for Elective Open Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_Open_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @IncisionalHernia_Open_LOS_Count AS Denominator;


/* Emergency readmission within 30 days following elective laparoscopic incisional hernia repair (12mths to qtr end) 
Metric ID:

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND Mort = 0 
AND Read30 = 'Y'

Q4 2021/22

*/

-- Date Range: Q4 2021/22 (January to March 2022)
DECLARE @Q4_2021_22_StartDate DATE = '2021-04-01';
DECLARE @Q4_2021_22_EndDate DATE = '2022-03-31';

-- Count
DECLARE @IncisionalHernia_Lap_Readmit_Count INT;

SELECT @IncisionalHernia_Lap_Readmit_Count = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND SWV.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND SWV.Mort = 0
      AND SWV.Read30 = 1
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q4_2021_22_StartDate AND @Q4_2021_22_EndDate;

-- Count
DECLARE @IncisionalHernia_Lap_Readmit_Denominator INT;

SELECT @IncisionalHernia_Lap_Readmit_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND SWV.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND SWV.Mort = 0
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q4_2021_22_StartDate AND @Q4_2021_22_EndDate;

-- Calculate Rate
DECLARE @IncisionalHernia_Lap_Readmit_Rate FLOAT;

SET @IncisionalHernia_Lap_Readmit_Rate
    = CASE
          WHEN @IncisionalHernia_Lap_Readmit_Denominator > 0 THEN
              CAST(@IncisionalHernia_Lap_Readmit_Count AS FLOAT) / @IncisionalHernia_Lap_Readmit_Denominator
          ELSE
              NULL
      END;

SELECT 'Emergency Readmission Within 30 Days Following Elective Laparoscopic Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_Lap_Readmit_Count AS [Numerator],
       @IncisionalHernia_Lap_Readmit_Denominator AS [Denominator];



/* Emergency readmission within 30 days following elective open incisional hernia repair (12mths to qtr end) 

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND Mort = 0

Q4 2023/24

*/

-- Date Range: Q4 2023/24 (January to March 2024)
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @IncisionalHernia_Open_Readmit_Numerator INT;

SELECT @IncisionalHernia_Open_Readmit_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND
      (
          SWV.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR SWV.GenS_MinimalAccess IS NULL
      )
      AND SWV.Mort = 0
      AND SWV.Read30 = 1
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @IncisionalHernia_Open_Readmit_Denominator INT;

SELECT @IncisionalHernia_Open_Readmit_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND
      (
          SWV.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR SWV.GenS_MinimalAccess IS NULL
      )
      AND SWV.Mort = 0
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @IncisionalHernia_Open_Readmit_Rate FLOAT;

SET @IncisionalHernia_Open_Readmit_Rate
    = CASE
          WHEN @IncisionalHernia_Open_Readmit_Denominator > 0 THEN
              CAST(@IncisionalHernia_Open_Readmit_Numerator AS FLOAT) / @IncisionalHernia_Open_Readmit_Denominator
          ELSE
              NULL
      END;

SELECT 'Emergency Readmission Within 30 Days Following Elective Open Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_Open_Readmit_Rate AS Rate,
       @IncisionalHernia_Open_Readmit_Numerator AS Numerator,
       @IncisionalHernia_Open_Readmit_Denominator AS Denominator;



/* Adverse outcome rate following elective incisional hernia repair (12mths to qtr end) 
Metric ID:

Count(Spells)
NCIP_Procedure_Main = 'Incisional hernia repair | age 17+ | elective' 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 
AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)


Q4 2023/24

*/

-- Date Range: Q4 2023/24 (January to March 2024)
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @IncisionalHernia_Adverse_Numerator INT;

SELECT @IncisionalHernia_Adverse_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND
      (
          (
              SWV.GenS_FLAG_ComplicationGenS_Spell = 1
              AND ISNULL(SWV.GenS_FLAG_Complication30_Return, 0) <> 1
          )
          OR SWV.GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR SWV.GenS_FLAG_Complication30 = 1
      )
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @IncisionalHernia_Adverse_Denominator INT;

SELECT @IncisionalHernia_Adverse_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_IncisionalHerniaRepair = 'Incisional hernia repair'
      AND SWV.Org_Code_Provider = 'rpa'
      AND SWV.Sector = 'med'
      AND SWV.Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @IncisionalHernia_Adverse_Rate FLOAT;

SET @IncisionalHernia_Adverse_Rate
    = CASE
          WHEN @IncisionalHernia_Adverse_Denominator > 0 THEN
              CAST(@IncisionalHernia_Adverse_Numerator AS FLOAT) / @IncisionalHernia_Adverse_Denominator
          ELSE
              NULL
      END;

SELECT 'Adverse Outcome Rate Following Elective Incisional Hernia Repair' AS Metric,
       @IncisionalHernia_Adverse_Rate AS Rate,
       @IncisionalHernia_Adverse_Numerator AS Numerator,
       @IncisionalHernia_Adverse_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Inguinal hernia repair
 ------------------------------------------------------------------- */

-- Create Temporary Table for Eligible Spells

IF OBJECT_ID('tempdb..#PrimaryInguinalHerniaRepairElectiveSpells') IS NOT NULL
    DROP TABLE #PrimaryInguinalHerniaRepairElectiveSpells;

WITH SpellsWithProcedure
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Primary_inguinal_hernia_repair
              )),
     EligibleSpells
AS (SELECT DISTINCT
           s.Spell_Number
    FROM SpellsWithProcedure s
        INNER JOIN #Spells_With_Variables swv
            ON s.Spell_Number = swv.Spell_Number
    WHERE swv.Age >= 17
          AND swv.POD_Derived IN ( 'EL', 'DC', 'RA' )),
     SpellsToExcludeProcedure
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_RevisionOperations
              )),
     SpellsToExcludeDiagnosis
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipd.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_OvarianCancer
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ALL_FallopianCancer
                 )
          ))
SELECT e.Spell_Number
INTO #PrimaryInguinalHerniaRepairElectiveSpells
FROM EligibleSpells e
    LEFT JOIN SpellsToExcludeProcedure ep
        ON e.Spell_Number = ep.Spell_Number
    LEFT JOIN SpellsToExcludeDiagnosis ed
        ON e.Spell_Number = ed.Spell_Number
WHERE ep.Spell_Number IS NULL
      AND ed.Spell_Number IS NULL;

/* Number of elective primary inguinal hernia repair procedures
Metric ID: GS7189

Denominator:
Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective'

Jun 2024

*/

-- Date Range: June 2024
DECLARE @June_2024_StartDate DATE = '2024-06-01';
DECLARE @June_2024_EndDate DATE = '2024-06-30';

-- Count
DECLARE @GS7189_Count INT;

SELECT @GS7189_Count = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Admission_Date
      BETWEEN @June_2024_StartDate AND @June_2024_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

SELECT 'Metric GS7189 - Number of Elective Primary Inguinal Hernia Repair Procedures' AS Metric,
       @GS7189_Count AS [Count];

/* Daycase rate for elective primary inguinal hernia repair (12mths to qtr end) 
Metric ID: GS7190

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND POD_Derived = 'DC'

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective'

Q1 2024/25

*/

-- Metric GS7190: Day Case Rate for Elective Primary Inguinal Hernia Repair

-- Date Range: Q1 2024/25 (April to June 2024)
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7190_Numerator INT;

SELECT @GS7190_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.POD_Derived = 'DC'
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Denominator
DECLARE @GS7190_Denominator INT;

SELECT @GS7190_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Calculate Rate
DECLARE @GS7190_Rate FLOAT;

SET @GS7190_Rate = CASE
                       WHEN @GS7190_Denominator > 0 THEN
                           CAST(@GS7190_Numerator AS FLOAT) / @GS7190_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7190 - Day Case Rate for Elective Primary Inguinal Hernia Repair' AS Metric,
       @GS7190_Rate AS Rate,
       @GS7190_Numerator AS Numerator,
       @GS7190_Denominator AS Denominator;

/* Daycase rate for elective laparoscopic unilateral primary inguinal hernia repair (12mths to qtr end) 
Metric ID: GS7191

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND GenS_Bilateral <> 'Bilateral' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived = 'DC'

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND GenS_Bilateral <> 'Bilateral' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Q3 2023/24

*/

-- Metric GS7191: Day Case Rate for Elective Laparoscopic Unilateral Primary Inguinal Hernia Repair

-- Date Range: Q3 2023/24 (October to December 2023)
DECLARE @Q3_2023_24_StartDate DATE = '2023-01-01';
DECLARE @Q3_2023_24_EndDate DATE = '2023-12-31';

-- Numerator
DECLARE @GS7191_Numerator INT;

SELECT @GS7191_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.GenS_Bilateral <> 'Bilateral'
      AND swv.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND swv.POD_Derived = 'DC'
	  AND swv.Age >= '17'
      AND swv.Admission_Date
      BETWEEN @Q3_2023_24_StartDate AND @Q3_2023_24_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Denominator
DECLARE @GS7191_Denominator INT;

SELECT @GS7191_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.GenS_Bilateral <> 'Bilateral'
      AND swv.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND swv.Admission_Date
      BETWEEN @Q3_2023_24_StartDate AND @Q3_2023_24_EndDate
	  AND swv.Age >= '17'
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Calculate Rate
DECLARE @GS7191_Rate FLOAT;

SET @GS7191_Rate = CASE
                       WHEN @GS7191_Denominator > 0 THEN
                           CAST(@GS7191_Numerator AS FLOAT) / @GS7191_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7191 - Day Case Rate for Elective Laparoscopic Unilateral Primary Inguinal Hernia Repair' AS Metric,
       @GS7191_Rate AS Rate,
       @GS7191_Numerator AS Numerator,
       @GS7191_Denominator AS Denominator;

/* Daycase rate for elective laparoscopic bilateral primary inguinal hernia repair (12mths to qtr end) 
Metric ID: GS7192

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND GenS_Bilateral = 'Bilateral' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived = 'DC'

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND GenS_Bilateral = 'Bilateral' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Q1 2024/25

*/

-- Metric GS7192: Day Case Rate for Elective Laparoscopic Bilateral Primary Inguinal Hernia Repair

-- Date Range: Q1 2024/25 (April to June 2024)
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7192_Numerator INT;

SELECT @GS7192_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.GenS_Bilateral = 'Bilateral procedure'
      AND swv.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND swv.POD_Derived = 'DC'
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Denominator
DECLARE @GS7192_Denominator INT;

SELECT @GS7192_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.GenS_Bilateral = 'Bilateral procedure'
      AND swv.GenS_MinimalAccess IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Calculate Rate
DECLARE @GS7192_Rate FLOAT;

SET @GS7192_Rate = CASE
                       WHEN @GS7192_Denominator > 0 THEN
                           CAST(@GS7192_Numerator AS FLOAT) / @GS7192_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7192 - Day Case Rate for Elective Laparoscopic Bilateral Primary Inguinal Hernia Repair' AS Metric,
       @GS7192_Rate AS Rate,
       @GS7192_Numerator AS Numerator,
       @GS7192_Denominator AS Denominator;



/* Daycase rate for elective open unilateral primary inguinal hernia repair (12mths to qtr end) 
Metric ID: GS7193

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND GenS_Bilateral <> 'Bilateral' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived = 'DC'

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND GenS_Bilateral <> 'Bilateral' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Q1 2024/25

*/

-- Metric GS7193: Day Case Rate for Elective Open Unilateral Primary Inguinal Hernia Repair

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7193_Numerator INT;

SELECT @GS7193_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE (
          swv.GenS_Bilateral <> 'Bilateral procedure'
          OR swv.GenS_Bilateral IS NULL
      )
      AND
      (
          swv.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR swv.GenS_MinimalAccess IS NULL
      )
      AND swv.POD_Derived = 'DC'
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Denominator
DECLARE @GS7193_Denominator INT;

SELECT @GS7193_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE (
          swv.GenS_Bilateral <> 'Bilateral procedure'
          OR swv.GenS_Bilateral IS NULL
      )
      AND
      (
          swv.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR swv.GenS_MinimalAccess IS NULL
      )
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Calculate Rate
DECLARE @GS7193_Rate FLOAT;

SET @GS7193_Rate = CASE
                       WHEN @GS7193_Denominator > 0 THEN
                           CAST(@GS7193_Numerator AS FLOAT) / @GS7193_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7193 - Day Case Rate for Elective Open Unilateral Primary Inguinal Hernia Repair' AS Metric,
       @GS7193_Rate AS Rate,
       @GS7193_Numerator AS Numerator,
       @GS7193_Denominator AS Denominator;

/* Daycase rate for elective open bilateral primary inguinal hernia repair (12mths to qtr end) 
Metric ID: GS7194

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND GenS_Bilateral = 'Bilateral' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived = 'DC'

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND GenS_Bilateral = 'Bilateral' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Q1 2024/25

*/

-- Metric GS7194: Day Case Rate for Elective Open Bilateral Primary Inguinal Hernia Repair

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7194_Numerator INT;

SELECT @GS7194_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.GenS_Bilateral = 'Bilateral procedure'
      AND
      (
          swv.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR swv.GenS_MinimalAccess IS NULL
      )
      AND swv.POD_Derived = 'DC'
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Denominator
DECLARE @GS7194_Denominator INT;

SELECT @GS7194_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.GenS_Bilateral = 'Bilateral procedure'
      AND
      (
          swv.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR swv.GenS_MinimalAccess IS NULL
      )
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Calculate Rate
DECLARE @GS7194_Rate FLOAT;

SET @GS7194_Rate = CASE
                       WHEN @GS7194_Denominator > 0 THEN
                           CAST(@GS7194_Numerator AS FLOAT) / @GS7194_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7194 - Day Case Rate for Elective Open Bilateral Primary Inguinal Hernia Repair' AS Metric,
       @GS7194_Rate AS Rate,
       @GS7194_Numerator AS Numerator,
       @GS7194_Denominator AS Denominator;


/* Emergency readmission within 30 days following elective primary inguinal hernia repair (12mths to qtr end) 
Metric ID: GS7195

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
NCIP_Procedure_Main = 'Primary inguinal hernia repair | age 17+ | elective' 
AND Mort = 0

Q4 2023/24

*/

-- Metric GS7195: Emergency Readmission Within 30 Days Following Elective Primary Inguinal Hernia Repair

-- Date Range: Q4 2023/24 (January to March 2024)
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7195_Numerator INT;

SELECT @GS7195_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Mort = 0
      AND swv.Read30 = 1
      AND swv.Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Denominator
DECLARE @GS7195_Denominator INT;

SELECT @GS7195_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #PrimaryInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Mort = 0
      AND swv.Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Calculate Rate
DECLARE @GS7195_Rate FLOAT;

SET @GS7195_Rate = CASE
                       WHEN @GS7195_Denominator > 0 THEN
                           CAST(@GS7195_Numerator AS FLOAT) / @GS7195_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7195 - Emergency Readmission Within 30 Days Following Elective Primary Inguinal Hernia Repair' AS Metric,
       @GS7195_Rate AS Rate,
       @GS7195_Numerator AS Numerator,
       @GS7195_Denominator AS Denominator;

------------

-- Create Temporary Table for Eligible Spells

IF OBJECT_ID('tempdb..#RecurrentInguinalHerniaRepairElectiveSpells') IS NOT NULL
    DROP TABLE #RecurrentInguinalHerniaRepairElectiveSpells;

WITH SpellsWithProcedure
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Recurrent_inguinal_hernia_repair
              )),
     EligibleSpells
AS (SELECT DISTINCT
           s.Spell_Number
    FROM SpellsWithProcedure s
        INNER JOIN #Spells_With_Variables swv
            ON s.Spell_Number = swv.Spell_Number
    WHERE swv.Age >= 17
          AND swv.POD_Derived IN ( 'EL', 'DC', 'RA' )),
     SpellsToExcludeProcedure
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_RevisionOperations
              )),
     SpellsToExcludeDiagnosis
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
        INNER JOIN [PAS_IP_Episode_Frozen] ipe
            ON s.Spell_Number = ipe.Spell_Number
               AND s.Sector = ipe.Sector
        INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipd.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_OvarianCancer
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ALL_FallopianCancer
                 )
          ))
SELECT e.Spell_Number
INTO #RecurrentInguinalHerniaRepairElectiveSpells
FROM EligibleSpells e
    LEFT JOIN SpellsToExcludeProcedure ep
        ON e.Spell_Number = ep.Spell_Number
    LEFT JOIN SpellsToExcludeDiagnosis ed
        ON e.Spell_Number = ed.Spell_Number
WHERE ep.Spell_Number IS NULL
      AND ed.Spell_Number IS NULL;

/* Number of elective recurrent inguinal hernia repair procedures (monthly) 
Metric ID: GS7196

Count(Spells)
NCIP_Procedure_Main = 'Recurrent inguinal hernia repair | age 17+ | elective'

Jun 2024

*/

-- Metric GS7196: Number of Elective Recurrent Inguinal Hernia Repair Procedures

-- Date Range: June 2024
DECLARE @June_2024_StartDate DATE = '2024-06-01';
DECLARE @June_2024_EndDate DATE = '2024-06-30';

-- Count
DECLARE @GS7196_Count INT;

SELECT @GS7196_Count = COUNT(DISTINCT s.Spell_Number)
FROM #RecurrentInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Admission_Date
      BETWEEN @June_2024_StartDate AND @June_2024_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

SELECT 'Metric GS7196 - Number of Elective Recurrent Inguinal Hernia Repair Procedures' AS Metric,
       @GS7196_Count AS [Count];

/* Daycase rate for elective open recurrent inguinal hernia repair (12mths to qtr end) 
Metric ID: GS7198

Count(Spells)
NCIP_Procedure_Main = 'Recurrent inguinal hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach') 
AND POD_Derived = 'DC'

Count(Spells)
NCIP_Procedure_Main = 'Recurrent inguinal hernia repair | age 17+ | elective' 
AND GenS_MinimalAccess NOT IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Q1 2024/25

*/

-- Metric GS7198: Day Case Rate for Elective Open Recurrent Inguinal Hernia Repair

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7198_Numerator INT;

SELECT @GS7198_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #RecurrentInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE (
          swv.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR swv.GenS_MinimalAccess IS NULL
      )
      AND swv.POD_Derived = 'DC'
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Denominator
DECLARE @GS7198_Denominator INT;

SELECT @GS7198_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #RecurrentInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE (
          swv.GenS_MinimalAccess NOT IN ( 'Laparoscopic approach', 'Other minimal access approach', 'Robotic approach' )
          OR swv.GenS_MinimalAccess IS NULL
      )
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Calculate Rate
DECLARE @GS7198_Rate FLOAT;

SET @GS7198_Rate = CASE
                       WHEN @GS7198_Denominator > 0 THEN
                           CAST(@GS7198_Numerator AS FLOAT) / @GS7198_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7198 - Day Case Rate for Elective Open Recurrent Inguinal Hernia Repair' AS Metric,
       @GS7198_Rate AS Rate,
       @GS7198_Numerator AS Numerator,
       @GS7198_Denominator AS Denominator;



/* Emergency readmission within 30 days following elective recurrent inguinal hernia repair (12mths to qtr end) 
Metric ID: GS7199

Count(Spells)
NCIP_Procedure_Main = 'Recurrent inguinal hernia repair | age 17+ | elective' 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
NCIP_Procedure_Main = 'Recurrent inguinal hernia repair | age 17+ | elective' 
AND Mort = 0

Q4 2023/24

*/

-- Metric GS7199: Emergency Readmission Within 30 Days Following Elective Recurrent Inguinal Hernia Repair

-- Date Range: Q4 2023/24 (January to March 2024)
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7199_Numerator INT;

SELECT @GS7199_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #RecurrentInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Mort = 0
      AND swv.Read30 = 1
      AND swv.Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Denominator
DECLARE @GS7199_Denominator INT;

SELECT @GS7199_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #RecurrentInguinalHerniaRepairElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Mort = 0
      AND swv.Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med';

-- Calculate Rate
DECLARE @GS7199_Rate FLOAT;

SET @GS7199_Rate = CASE
                       WHEN @GS7199_Denominator > 0 THEN
                           CAST(@GS7199_Numerator AS FLOAT) / @GS7199_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7199 - Emergency Readmission Within 30 Days Following Elective Recurrent Inguinal Hernia Repair' AS Metric,
       @GS7199_Rate AS Rate,
       @GS7199_Numerator AS Numerator,
       @GS7199_Denominator AS Denominator;



/* -------------------------------------------------------------------
	Emergency laparotomy
 ------------------------------------------------------------------- */

/* Number of emergency laparotomy procedures (monthly) 
Metric ID: GS7200

Count(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy'

Jun 2024

*/

-- Metric GS7200: Number of Emergency Laparotomy Procedures

-- Date Range: June 2024
DECLARE @June_2024_StartDate DATE = '2024-06-01';
DECLARE @June_2024_EndDate DATE = '2024-06-30';

-- Count
DECLARE @GS7200_Count INT;

SELECT @GS7200_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @June_2024_StartDate AND @June_2024_EndDate;

SELECT 'Metric GS7200 - Number of Emergency Laparotomy Procedures' AS Metric,
       @GS7200_Count AS [Count];


/* Laparoscopically assisted rate for emergency laparotomy (12mths to qtr end) 
Metric ID: GS7201

Count(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy' AND GenS_MinimalAccess = 'Laparoscopically assisted'

Count(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy'

Q1 2024/25

*/

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Metric GS7201: Laparoscopically Assisted Rate for Emergency Laparotomy

-- Date Range: Q1 2024/25

-- Numerator
DECLARE @GS7201_Numerator INT;

SELECT @GS7201_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND GenS_MinimalAccess = 'Laparoscopically assisted'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
	  AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7201_Denominator INT;

SELECT @GS7201_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
	  AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7201_Rate FLOAT;

SET @GS7201_Rate = CASE
                       WHEN @GS7201_Denominator > 0 THEN
                           CAST(@GS7201_Numerator AS FLOAT) / @GS7201_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7201 - Laparoscopically Assisted Rate for Emergency Laparotomy' AS Metric,
       @GS7201_Rate AS Rate,
       @GS7201_Numerator AS Numerator,
       @GS7201_Denominator AS Denominator;


/* Conversion from laparoscopy rate for emergency laparotomy (12mths to qtr end) 
Metric ID: GS7202

Count(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy' 
AND GenS_MinimalAccess = 'Conversion to open approach'

Count(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy'

Q1 2024/25

*/

-- Metric GS7202: Conversion from Laparoscopy Rate for Emergency Laparotomy

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';


-- Numerator
DECLARE @GS7202_Numerator INT;

SELECT @GS7202_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND GenS_MinimalAccess = 'Conversion to open approach'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
	  AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7202_Denominator INT;

SELECT @GS7202_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
	  AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7202_Rate FLOAT;

SET @GS7202_Rate = CASE
                       WHEN @GS7202_Denominator > 0 THEN
                           CAST(@GS7202_Numerator AS FLOAT) / @GS7202_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7202 - Conversion from Laparoscopy Rate for Emergency Laparotomy' AS Metric,
       @GS7202_Rate AS Rate,
       @GS7202_Numerator AS Numerator,
       @GS7202_Denominator AS Denominator;


/* Median length of stay for emergency laparotomy (12mths to qtr end) 
Metric ID: GS7203

Median(Spell_LOS)
GenS_EMLaparotomy_NELA = 'EMLaparotomy'

COUNT(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy'

Q1 2024/25

*/

-- Metric GS7203: Median Length of Stay for Emergency Laparotomy

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @GS7203_Count INT;

SELECT @GS7203_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
	  AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7203_MedianLOS FLOAT;

WITH OrderedLOS AS (
    SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
		  AND POD_Derived = 'EM'
          AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
)
SELECT @GS7203_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7203_Count + 1) / 2, (@GS7203_Count + 2) / 2 );

SELECT 'Metric GS7203 - Median Length of Stay for Emergency Laparotomy' AS Metric,
       @GS7203_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7203_Count AS Denominator;


/* Emergency readmission within 30 days following emergency laparotomy (12mths to qtr end) 
Metric ID: GS7204

Count(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy' AND Mort = 0 AND Read30 = 'Y'

Count(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy' AND Mort = 0

Q4 2023/24

*/

-- Metric GS7204: Emergency Readmission Within 30 Days Following Emergency Laparotomy

-- Date Range: Q4 2023/24 
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7204_Numerator INT;

SELECT @GS7204_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
	  AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7204_Denominator INT;

SELECT @GS7204_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
	  AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7204_Rate FLOAT;

SET @GS7204_Rate = CASE
                       WHEN @GS7204_Denominator > 0 THEN
                           CAST(@GS7204_Numerator AS FLOAT) / @GS7204_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7204 - Emergency Readmission Within 30 Days Following Emergency Laparotomy' AS Metric,
       @GS7204_Rate AS Rate,
       @GS7204_Numerator AS Numerator,
       @GS7204_Denominator AS Denominator;


/* Adverse outcome rate following emergency laparotomy (12mths to qtr end) 
Metric ID: GS7205

Count(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy' 
AND ((GenS_FLAG_ComplicationGenS_Spell = 1 
AND GenS_FLAG_Complication30_Return <> 1) OR GenS_FLAG_AdvIncidentGenS_Spell = 1 OR GenS_FLAG_Complication30 = 1)

Count(Spells)
GenS_EMLaparotomy_NELA = 'EMLaparotomy'

Q4 2023/24

*/

-- Metric GS7205: Adverse Outcome Rate Following Emergency Laparotomy

-- Date Range: Q4 2023/24
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7205_Numerator INT;

SELECT @GS7205_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND (
          (GenS_FLAG_ComplicationGenS_Spell = 1 AND ISNULL(GenS_FLAG_Complication30_Return, 0) <> 1)
          OR GenS_FLAG_AdvIncidentGenS_Spell = 1
          OR GenS_FLAG_Complication30 = 1
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
	  AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7205_Denominator INT;

SELECT @GS7205_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_EMLaparotomy_NELA = 'EMLaparotomy'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
	  AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7205_Rate FLOAT;

SET @GS7205_Rate = CASE
                       WHEN @GS7205_Denominator > 0 THEN
                           CAST(@GS7205_Numerator AS FLOAT) / @GS7205_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7205 - Adverse Outcome Rate Following Emergency Laparotomy' AS Metric,
       @GS7205_Rate AS Rate,
       @GS7205_Numerator AS Numerator,
       @GS7205_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Diverticulitis
 ------------------------------------------------------------------- */

/* Number of emergency admissions for patents with diverticulitis (monthly) 
Metric ID: GS7206

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM'

Jun 2024

*/

-- Metric GS7206: Number of Emergency Admissions for Patients with Diverticulitis

-- Date Range: June 2024
DECLARE @June_2024_StartDate DATE = '2024-06-01';
DECLARE @June_2024_EndDate DATE = '2024-06-30';

-- Count
DECLARE @GS7206_Count INT;

SELECT @GS7206_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @June_2024_StartDate AND @June_2024_EndDate;

SELECT 'Metric GS7206 - Number of Emergency Admissions for Patients with Diverticulitis' AS Metric,
       @GS7206_Count AS [Count];


/* No procedure rate for emergency patents with diverticulitis (12mths to qtr end) 
Metric ID: GS7207

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM' 
AND GenS_ProcDiverticulitis = 'No procedure' 
AND GenS_FLAG_NoProc_Spell = 1 

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM'

Q1 2024/25

*/

-- Metric GS7207: No Procedure Rate for Emergency Patients with Diverticulitis

-- Date Range: Q1 2024/25 (April to June 2024)
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7207_Numerator INT;

SELECT @GS7207_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND POD_Derived = 'EM'
      AND GenS_ProcDiverticulitis = 'No procedure'
      AND GenS_FLAG_NoProc_Spell = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7207_Denominator INT;

SELECT @GS7207_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7207_Rate FLOAT;

SET @GS7207_Rate = CASE
                       WHEN @GS7207_Denominator > 0 THEN
                           CAST(@GS7207_Numerator AS FLOAT) / @GS7207_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7207 - No Procedure Rate for Emergency Patients with Diverticulitis' AS Metric,
       @GS7207_Rate AS Rate,
       @GS7207_Numerator AS Numerator,
       @GS7207_Denominator AS Denominator;


/* Diagnostic procedure rate for emergency patients with diverticulitis (12mths to qtr end) 
Metric ID: GS7208

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM' 
AND GenS_ProcDiverticulitis = 'Diagnostic procedure only' 
AND GenS_FLAG_ThProcDiverticulitis_Spell = 0

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM'

Q1 2024/25

*/

-- Metric GS7208: Diagnostic Procedure Rate for Emergency Patients with Diverticulitis

-- Numerator
DECLARE @GS7208_Numerator INT;

SELECT @GS7208_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND POD_Derived = 'EM'
      AND GenS_ProcDiverticulitis = 'Diagnostic procedure only'
      AND GenS_FLAG_ThProcDiverticulitis_Spell = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator (Same as GS7207)
-- Using @GS7207_Denominator

-- Calculate Rate
DECLARE @GS7208_Rate FLOAT;

SET @GS7208_Rate = CASE
                       WHEN @GS7207_Denominator > 0 THEN
                           CAST(@GS7208_Numerator AS FLOAT) / @GS7207_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7208 - Diagnostic Procedure Rate for Emergency Patients with Diverticulitis' AS Metric,
       @GS7208_Rate AS Rate,
       @GS7208_Numerator AS Numerator,
       @GS7207_Denominator AS Denominator;

/* Therapeutic procedure rate for emergency patients with diverticulitis (12mths to qtr end) 
Metric ID: GS7209

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM' 
AND GenS_ProcDiverticulitis = 'Therapeutic procedure'

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM'

Q1 2024/25

*/

-- Metric GS7209: Therapeutic Procedure Rate for Emergency Patients with Diverticulitis

-- Numerator
DECLARE @GS7209_Numerator INT;

SELECT @GS7209_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND POD_Derived = 'EM'
      AND GenS_ProcDiverticulitis = 'Therapeutic procedure'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator (Same as GS7207)
-- Using @GS7207_Denominator

-- Calculate Rate
DECLARE @GS7209_Rate FLOAT;

SET @GS7209_Rate = CASE
                       WHEN @GS7207_Denominator > 0 THEN
                           CAST(@GS7209_Numerator AS FLOAT) / @GS7207_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7209 - Therapeutic Procedure Rate for Emergency Patients with Diverticulitis' AS Metric,
       @GS7209_Rate AS Rate,
       @GS7209_Numerator AS Numerator,
       @GS7207_Denominator AS Denominator;


/* Length of stay greater than 3 days for emergency patents receiving no procedure for diverticulitis 
(12mths to qtr end) 
Metric ID: GS7210

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM' 
AND GenS_ProcDiverticulitis = 'No procedure' 
AND GenS_FLAG_NoProc_Spell = 1 AND Spell_LOS > 3

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM' 
AND GenS_ProcDiverticulitis = 'No procedure' 
AND GenS_FLAG_NoProc_Spell = 1

Q1 2024/25

*/

-- Metric GS7210: Length of Stay > 3 Days for No Procedure Diverticulitis Patients

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7210_Numerator INT;

SELECT @GS7210_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND POD_Derived = 'EM'
      AND GenS_ProcDiverticulitis = 'No procedure'
      AND GenS_FLAG_NoProc_Spell = 1
      AND Spell_LOS > 3
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7210_Denominator INT;

SELECT @GS7210_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND POD_Derived = 'EM'
      AND GenS_ProcDiverticulitis = 'No procedure'
      AND GenS_FLAG_NoProc_Spell = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7210_Rate FLOAT;

SET @GS7210_Rate = CASE
                       WHEN @GS7210_Denominator > 0 THEN
                           CAST(@GS7210_Numerator AS FLOAT) / @GS7210_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7210 - LOS > 3 Days for No Procedure Diverticulitis Patients' AS Metric,
       @GS7210_Rate AS Rate,
       @GS7210_Numerator AS Numerator,
       @GS7210_Denominator AS Denominator;


/* Median length of stay for emergency patents receiving a diagnostic procedure for diverticulitis 
(12mths to qtr end) 
Metric ID: GS7211

Median(Spell_LOS)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM' 
AND GenS_ProcDiverticulitis = 'Diagnostic procedure only' 
AND GenS_FLAG_ThProcDiverticulitis_Spell = 0

COUNT(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM' 
AND GenS_ProcDiverticulitis = 'Diagnostic procedure only' 
AND GenS_FLAG_ThProcDiverticulitis_Spell = 0

Q1 2024/25

*/

-- Metric GS7211: Median LOS for Diagnostic Procedure Diverticulitis Patients

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @GS7211_Count INT;

SELECT @GS7211_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND POD_Derived = 'EM'
      AND GenS_ProcDiverticulitis = 'Diagnostic procedure only'
      AND GenS_FLAG_ThProcDiverticulitis_Spell = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7211_MedianLOS FLOAT;

WITH OrderedLOS AS (
    SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
          AND POD_Derived = 'EM'
          AND GenS_ProcDiverticulitis = 'Diagnostic procedure only'
          AND GenS_FLAG_ThProcDiverticulitis_Spell = 0
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
)
SELECT @GS7211_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7211_Count + 1) / 2, (@GS7211_Count + 2) / 2 );

SELECT 'Metric GS7211 - Median LOS for Diagnostic Procedure Diverticulitis Patients' AS Metric,
       @GS7211_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7211_Count AS Denominator;


/* Median length of stay for emergency patents receiving a therapeutic procedure for diverticulitis 
(12mths to qtr end) 
Metric ID: GS7212

Median(Spell_LOS)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM' 
AND GenS_ProcDiverticulitis = 'Therapeutic procedure'

COUNT(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND POD_Derived = 'EM' 
AND GenS_ProcDiverticulitis = 'Therapeutic procedure'

Q1 2024/25

*/

-- Metric GS7212: Median LOS for Therapeutic Procedure Diverticulitis Patients

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @GS7212_Count INT;

SELECT @GS7212_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND POD_Derived = 'EM'
      AND GenS_ProcDiverticulitis = 'Therapeutic procedure'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7212_MedianLOS FLOAT;

WITH OrderedLOS AS (
    SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
          AND POD_Derived = 'EM'
          AND GenS_ProcDiverticulitis = 'Therapeutic procedure'
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
)
SELECT @GS7212_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7212_Count + 1) / 2, (@GS7212_Count + 2) / 2 );

SELECT 'Metric GS7212 - Median LOS for Therapeutic Procedure Diverticulitis Patients' AS Metric,
       @GS7212_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7212_Count AS Denominator;


/* Emergency readmission within 30 days following elective or emergency therapeutic procedure for patients with diverticulitis 
(12mths to qtr end) 
Metric ID: GS7213

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND GenS_ProcDiverticulitis = 'Therapeutic procedure' 
AND Mort = 0 AND Read30 = 'Y'

Count(Spells)
GenS_Diverticulitis = 'Diverticulitis primary diagnosis' 
AND GenS_ProcDiverticulitis = 'Therapeutic procedure' 
AND Mort = 0

Q4 2023/24

*/

-- Metric GS7213: Emergency Readmission Within 30 Days for Therapeutic Procedure Diverticulitis Patients

-- Date Range: Q4 2023/24 
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7213_Numerator INT;

SELECT @GS7213_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND GenS_ProcDiverticulitis = 'Therapeutic procedure'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7213_Denominator INT;

SELECT @GS7213_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_Diverticulitis = 'Diverticulitis primary diagnosis'
      AND GenS_ProcDiverticulitis = 'Therapeutic procedure'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7213_Rate FLOAT;

SET @GS7213_Rate = CASE
                       WHEN @GS7213_Denominator > 0 THEN
                           CAST(@GS7213_Numerator AS FLOAT) / @GS7213_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7213 - Emergency Readmission Within 30 Days for Therapeutic Procedure Diverticulitis Patients' AS Metric,
       @GS7213_Rate AS Rate,
       @GS7213_Numerator AS Numerator,
       @GS7213_Denominator AS Denominator;


/* -------------------------------------------------------------------
	Crohn's disease
 ------------------------------------------------------------------- */

/* Number of elective resection procedures for Crohn's disease (monthly) 
Metric ID: GS7214

Count(Spells)
GenS_ResectionCrohns = 'Resection for Crohns disease' AND POD_Derived IN ('DC','EL')

Jun 2024

*/

-- Metric GS7214: Number of Elective Resection Procedures for Crohn's Disease

-- Date Range: June 2024
DECLARE @June_2024_StartDate DATE = '2024-06-01';
DECLARE @June_2024_EndDate DATE = '2024-06-30';

-- Count
DECLARE @GS7214_Count INT;

SELECT @GS7214_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ResectionCrohns = 'Resection for Crohns disease'
      AND POD_Derived IN ('DC', 'EL')
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @June_2024_StartDate AND @June_2024_EndDate;

SELECT 'Metric GS7214 - Number of Elective Resection Procedures for Crohn''s Disease' AS Metric,
       @GS7214_Count AS [Count];

/* Median length of stay for elective resection for Crohn's disease (12mths to qtr end) 
Metric ID: GS7215

Median(Spell_LOS)
GenS_ResectionCrohns = 'Resection for Crohns disease' AND POD_Derived IN ('DC','EL')

Q1 2019/20

*/

-- Metric GS7215: Median Length of Stay for Elective Resection for Crohn's Disease

-- Date Range: Q1 2019/20 (April to June 2019)
DECLARE @Q1_2019_20_StartDate DATE = '2018-07-01';
DECLARE @Q1_2019_20_EndDate DATE = '2019-06-30';

-- Count of Spells
DECLARE @GS7215_Count INT;

SELECT @GS7215_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
      AND POD_Derived IN ('DC', 'EL')
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2019_20_StartDate AND @Q1_2019_20_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7215_MedianLOS FLOAT;

WITH OrderedLOS AS (
    SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
          AND POD_Derived IN ('DC', 'EL')
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date BETWEEN @Q1_2019_20_StartDate AND @Q1_2019_20_EndDate
)
SELECT @GS7215_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7215_Count + 1) / 2, (@GS7215_Count + 2) / 2 );

SELECT 'Metric GS7215 - Median Length of Stay for Elective Resection for Crohn''s Disease' AS Metric,
       @GS7215_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7215_Count AS Denominator;

/* Emergency readmission within 30 days following elective resection for Crohn's disease 
(12mths to qtr end) 
Metric ID: GS7216

Count(Spells)
GenS_ResectionCrohns = 'Resection for Crohns disease' 
AND POD_Derived IN ('DC','EL') 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_ResectionCrohns = 'Resection for Crohns disease' 
AND POD_Derived IN ('DC','EL') 
AND Mort = 0

Q1 2019/20

*/

-- Metric GS7216: Emergency Readmission Within 30 Days Following Elective Resection for Crohn's Disease

-- Date Range: Q1 2019/20 
DECLARE @Q1_2019_20_StartDate DATE = '2018-07-01';
DECLARE @Q1_2019_20_EndDate DATE = '2019-06-30';

-- Numerator
DECLARE @GS7216_Numerator INT;

SELECT @GS7216_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
      AND POD_Derived IN ('DC', 'EL')
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2019_20_StartDate AND @Q1_2019_20_EndDate;

-- Denominator
DECLARE @GS7216_Denominator INT;

SELECT @GS7216_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
      AND POD_Derived IN ('DC', 'EL')
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2019_20_StartDate AND @Q1_2019_20_EndDate;

-- Calculate Rate
DECLARE @GS7216_Rate FLOAT;

SET @GS7216_Rate = CASE
                       WHEN @GS7216_Denominator > 0 THEN
                           CAST(@GS7216_Numerator AS FLOAT) / @GS7216_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7216 - Emergency Readmission Within 30 Days Following Elective Resection for Crohn''s Disease' AS Metric,
       @GS7216_Rate AS Rate,
       @GS7216_Numerator AS Numerator,
       @GS7216_Denominator AS Denominator;

/* Length of stay greater than 3 days for emergency patents receiving no procedure for Crohn's disease 
(12mths to qtr end) 
Metric ID: GS7217

Count(Spells)
GenS_CrohnDisease = 'Crohn's disease primary diagnosis' 
AND POD_Derived IN ('EM') 
AND GenS_NoProc = 'NoProc' 
AND GenS_FLAG_NoProc_Spell = 1 
AND Spell_LOS > 3

Count(Spells)
GenS_CrohnDisease = 'Crohn's disease primary diagnosis' 
AND POD_Derived IN ('EM') 
AND GenS_NoProc = 'NoProc' 
AND GenS_FLAG_NoProc_Spell = 1

Q1 2024/25

*/

-- Metric GS7217: LOS > 3 Days for Emergency Patients Receiving No Procedure for Crohn's Disease

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7217_Numerator INT;

SELECT @GS7217_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND POD_Derived = 'EM'
      AND GenS_NoProc = 'No Procedure'
      AND GenS_FLAG_NoProc_Spell = 1
      AND Spell_LOS > 3
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7217_Denominator INT;

SELECT @GS7217_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND POD_Derived = 'EM'
      AND GenS_NoProc = 'No Procedure'
      AND GenS_FLAG_NoProc_Spell = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7217_Rate FLOAT;

SET @GS7217_Rate = CASE
                       WHEN @GS7217_Denominator > 0 THEN
                           CAST(@GS7217_Numerator AS FLOAT) / @GS7217_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7217 - LOS > 3 Days for No Procedure Emergency Patients with Crohn''s Disease' AS Metric,
       @GS7217_Rate AS Rate,
       @GS7217_Numerator AS Numerator,
       @GS7217_Denominator AS Denominator;

/* Number of emergency resection procedures for Crohn's disease (monthly) 
Metric ID: GS7218

Count(Spells)
GenS_ResectionCrohns = 'Resection for Crohns disease' 
AND POD_Derived IN ('EM')

Jul 2023

*/

-- Metric GS7218: Number of Emergency Resection Procedures for Crohn's Disease

-- Date Range: July 2023
DECLARE @July_2023_StartDate DATE = '2023-07-01';
DECLARE @July_2023_EndDate DATE = '2023-07-31';

-- Count
DECLARE @GS7218_Count INT;

SELECT @GS7218_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @July_2023_StartDate AND @July_2023_EndDate;

SELECT 'Metric GS7218 - Number of Emergency Resection Procedures for Crohn''s Disease' AS Metric,
       @GS7218_Count AS [Count];

/* Median length of stay for emergency resection for Crohn's disease (12mths to qtr end) 
Metric ID: GS7219

Median(Spell_LOS)
GenS_ResectionCrohns = 'Resection for Crohns disease' 
AND POD_Derived IN ('EM')

COUNT(Spells)
GenS_ResectionCrohns = 'Resection for Crohns disease' 
AND POD_Derived IN ('EM')

*/

-- Metric GS7219: Median Length of Stay for Emergency Resection for Crohn's Disease

-- Date Range: 
DECLARE @Q3_2019_20_StartDate DATE = '2019-01-01';
DECLARE @Q3_2019_20_EndDate DATE = '2019-12-31';

-- Count of Spells
DECLARE @GS7219_Count INT;

SELECT @GS7219_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q3_2019_20_StartDate AND @Q3_2019_20_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7219_MedianLOS FLOAT;

WITH OrderedLOS AS (
    SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
          AND POD_Derived = 'EM'
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date BETWEEN @Q3_2019_20_StartDate AND @Q3_2019_20_EndDate
)
SELECT @GS7219_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7219_Count + 1) / 2, (@GS7219_Count + 2) / 2 );

SELECT 'Metric GS7219 - Median Length of Stay for Emergency Resection for Crohn''s Disease' AS Metric,
       @GS7219_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7219_Count AS Denominator;


/* Emergency readmission within 30 days following emergency resection for Crohn's disease 
(12mths to qtr end) 
Metric ID: GS7220

Count(Spells)
GenS_ResectionCrohns = 'Resection for Crohns disease' 
AND POD_Derived IN ('EM') 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_ResectionCrohns = 'Resection for Crohns disease' 
AND POD_Derived IN ('EM') 
AND Mort = 0

Q3 2019/20

*/

-- Metric GS7220: Emergency Readmission Within 30 Days Following Emergency Resection for Crohn's Disease

-- Date Range: Q3 2019/20 
DECLARE @Q3_2019_20_StartDate DATE = '2019-01-01';
DECLARE @Q3_2019_20_EndDate DATE = '2019-12-31';

-- Numerator
DECLARE @GS7220_Numerator INT;

SELECT @GS7220_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
      AND POD_Derived = 'EM'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q3_2019_20_StartDate AND @Q3_2019_20_EndDate;

-- Denominator
DECLARE @GS7220_Denominator INT;

SELECT @GS7220_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ResectionCrohns = 'Resection surgery for Crohn''s disease'
      AND POD_Derived = 'EM'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q3_2019_20_StartDate AND @Q3_2019_20_EndDate;

-- Calculate Rate
DECLARE @GS7220_Rate FLOAT;

SET @GS7220_Rate = CASE
                       WHEN @GS7220_Denominator > 0 THEN
                           CAST(@GS7220_Numerator AS FLOAT) / @GS7220_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7220 - Emergency Readmission Within 30 Days Following Emergency Resection for Crohn''s Disease' AS Metric,
       @GS7220_Rate AS Rate,
       @GS7220_Numerator AS Numerator,
       @GS7220_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Ulcerative colitis
 ------------------------------------------------------------------- */

/* Number of elective colectomy and ileostomy procedures for patients with ulcerative colitis (monthly) 
Metric ID: 

Count(Spells)
GenS_ProcUlcerColitis = 'Colectomy and ileostomy' 
AND POD_Derived IN ('EL','DC')

Dec 2021

*/

DECLARE @Dec_2021_StartDate DATE = '2021-12-01';
DECLARE @Dec_2021_EndDate DATE = '2021-12-31';

-- Count
DECLARE @Ulc_Col_Count INT;

SELECT @Ulc_Col_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ProcUlcerColitis = 'Colectomy and ileostomy'
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Org_Code_Provider = 'RPA'
      AND Sector = 'MED'
      AND Admission_Date
      BETWEEN @Dec_2021_StartDate AND @Dec_2021_EndDate;

SELECT 'Number of elective colectomy and ileostomy procedures for patients with ulcerative colitis' AS Metric,
       @Ulc_Col_Count AS [Count];

/* Number of elective Ileoanal pouch procedures for patients with ulcerative colitis
Metric ID: GS7225

Count(Spells)
GenS_ProcUlcerColitis = 'Pouch surgery' 
AND POD_Derived IN ('EL','DC')

May 2019

*/

DECLARE @May_2019_StartDate DATE = '2019-05-01';
DECLARE @May_2019_EndDate DATE = '2019-05-31';

-- Count
DECLARE @GS7225_Count INT;

SELECT @GS7225_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ProcUlcerColitis = 'Pouch surgery'
      AND POD_Derived IN ( 'EL', 'DC' )
      AND Org_Code_Provider = 'RPA'
      AND Sector = 'MED'
      AND Admission_Date
      BETWEEN @May_2019_StartDate AND @May_2019_EndDate;

SELECT 'Metric GS7225 - Number of elective Ileoanal pouch procedures for patients with ulcerative colitis' AS Metric,
       @GS7225_Count AS [Count];

/* -------------------------------------------------------------------
	Bowel obstruction
 ------------------------------------------------------------------- */

/* Number of emergency admissions for bowel obstruction (monthly) 
Metric ID: GS7229

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM'

Jun 2024

*/

-- Metric GS7229: Number of Emergency Admissions for Bowel Obstruction

-- Date Range: June 2024
DECLARE @June_2024_StartDate DATE = '2024-06-01';
DECLARE @June_2024_EndDate DATE = '2024-06-30';

-- Count
DECLARE @GS7229_Count INT;

SELECT @GS7229_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @June_2024_StartDate AND @June_2024_EndDate;

SELECT 'Metric GS7229 - Number of Emergency Admissions for Bowel Obstruction' AS Metric,
       @GS7229_Count AS [Count];

/* Median length of stay for emergency patents receiving no procedure for bowel obstruction 
(12mths to qtr end) 
Metric ID: GS7230

Median(Spell_LOS)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' AND GenS_ProcLargeBowelObstruct = 'Other' 
AND GenS_ProcSmallBowelObstruct = 'Other' 
AND GenS_FLAG_BowelProc_Spell = 0

COUNT(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_ProcLargeBowelObstruct = 'Other' 
AND GenS_ProcSmallBowelObstruct = 'Other' 
AND GenS_FLAG_BowelProc_Spell = 0

Q1 2024/25

*/

-- Metric GS7230: Median LOS for No Procedure Bowel Obstruction Patients

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @GS7230_Count INT;

SELECT @GS7230_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND
      (
          (
              GenS_ProcLargeBowelObstruct = 'Other'
              OR GenS_ProcLargeBowelObstruct IS NULL
          )
          AND
          (
              GenS_ProcSmallBowelObstruct = 'Other'
              OR GenS_ProcSmallBowelObstruct IS NULL
          )
      )
      AND GenS_FLAG_BowelProc_Spell = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7230_MedianLOS FLOAT;

WITH OrderedLOS
AS (SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_BowelObstruct = 'Bowel obstruction'
          AND POD_Derived = 'EM'
          AND
          (
              (
                  GenS_ProcLargeBowelObstruct = 'Other'
                  OR GenS_ProcLargeBowelObstruct IS NULL
              )
              AND
              (
                  GenS_ProcSmallBowelObstruct = 'Other'
                  OR GenS_ProcSmallBowelObstruct IS NULL
              )
          )
          AND GenS_FLAG_BowelProc_Spell = 0
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date
          BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate)
SELECT @GS7230_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7230_Count + 1) / 2, (@GS7230_Count + 2) / 2 );

SELECT 'Metric GS7230 - Median LOS for No Procedure Bowel Obstruction Patients' AS Metric,
       @GS7230_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7230_Count AS Denominator;


/* Treatment rate during the original emergency admission following emergency admission for bowel obstruction 
(12mths to qtr end) 
Metric ID: GS7232

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND (GenS_ProcLargeBowelObstruct <> 'Other' OR GenS_ProcSmallBowelObstruct <> 'Other')

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM'

Q1 2024/25

*/

-- Metric GS7232: Treatment Rate During Original Emergency Admission for Bowel Obstruction

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7232_Numerator INT;

SELECT @GS7232_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND
      (
          GenS_ProcLargeBowelObstruct <> 'Other'
          OR GenS_ProcSmallBowelObstruct <> 'Other'
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7232_Denominator INT;

SELECT @GS7232_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7232_Rate FLOAT;

SET @GS7232_Rate = CASE
                       WHEN @GS7232_Denominator > 0 THEN
                           CAST(@GS7232_Numerator AS FLOAT) / @GS7232_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7232 - Treatment Rate During Original Emergency Admission for Bowel Obstruction' AS Metric,
       @GS7232_Rate AS Rate,
       @GS7232_Numerator AS Numerator,
       @GS7232_Denominator AS Denominator;

/* Average days between diagnosis of bowel obstruction and procedure for bowel obstruction within the original emergency admission 
(12mths to qtr end) 
Metric ID: GS7233

SUM(GenS_FLAG_AdmTreatPeriod)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND (GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND (GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')

Q4 2023/24

*/

-- Metric GS7233: Average Days Between Diagnosis and Procedure Within Original Emergency Admission

-- Date Range: Q4 2023/24 
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Calculate Total Days and Count
DECLARE @GS7233_TotalDays INT;
DECLARE @GS7233_Count INT;

SELECT @GS7233_TotalDays = SUM(GenS_FLAG_AdmTreatPeriod),
       @GS7233_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND (
          GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR
          GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'
      )
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Average Days
DECLARE @GS7233_AverageDays FLOAT;

SET @GS7233_AverageDays = CASE
                              WHEN @GS7233_Count > 0 THEN
                                  CAST(@GS7233_TotalDays AS FLOAT) / @GS7233_Count
                              ELSE
                                  NULL
                          END;

SELECT 'Metric GS7233 - Average Days Between Diagnosis and Procedure Within Original Emergency Admission' AS Metric,
       @GS7233_AverageDays AS Average_Days,
       @GS7233_TotalDays AS Total_Days,
       @GS7233_Count AS [Count];


/* Treatment rate in subsequent elective admission following diagnosis of bowel obstruction in an emergency admission (12mths to qtr end) 
Metric ID: GS7234

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_FLAG_DiagTreat = 1

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM'

Q4 2023/24

*/

-- Metric GS7234: Treatment Rate in Subsequent Elective Admission Following Emergency Admission for Bowel Obstruction

-- Date Range: Q4 2023/24 (January to March 2024)
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7234_Numerator INT;

SELECT @GS7234_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND GenS_FLAG_DiagTreat = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7234_Denominator INT;

SELECT @GS7234_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7234_Rate FLOAT;

SET @GS7234_Rate = CASE
                       WHEN @GS7234_Denominator > 0 THEN
                           CAST(@GS7234_Numerator AS FLOAT) / @GS7234_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7234 - Treatment Rate in Subsequent Elective Admission Following Emergency Admission for Bowel Obstruction' AS Metric,
       @GS7234_Rate AS Rate,
       @GS7234_Numerator AS Numerator,
       @GS7234_Denominator AS Denominator;


/* Average days between emergency diagnosis of bowel obstruction and subsequent elective procedure for bowel obstruction (12mths to qtr end) 
Metric ID: GS7235

Sum(GenS_FLAG_DiagTreatPeriod)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_FLAG_DiagTreat = 1

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_FLAG_DiagTreat = 1

Q4 2023/24

*/

-- Metric GS7235: Average Days Between Emergency Diagnosis and Subsequent Elective Procedure for Bowel Obstruction
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Calculate Total Days and Count
DECLARE @GS7235_TotalDays INT;
DECLARE @GS7235_Count INT;

SELECT @GS7235_TotalDays = SUM(GenS_FLAG_DiagTreatPeriod),
       @GS7235_Count = COUNT(*)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND GenS_FLAG_DiagTreat = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Average Days
DECLARE @GS7235_AverageDays FLOAT;

SET @GS7235_AverageDays = CASE
                              WHEN @GS7235_Count > 0 THEN
                                  CAST(@GS7235_TotalDays AS FLOAT) / @GS7235_Count
                              ELSE
                                  NULL
                          END;

SELECT 'Metric GS7235 - Average Days Between Emergency Diagnosis and Subsequent Elective Procedure for Bowel Obstruction' AS Metric,
       @GS7235_AverageDays AS Average_Days,
       @GS7235_TotalDays AS Total_Days,
       @GS7235_Count AS [Count];


/* Median length of stay for emergency procedure for bowel obstruction (12mths to qtr end) 
Metric ID: GS7231

Median(Spell_LOS)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND (GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')

COUNT(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND (GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')

Q1 2024/25

*/

-- Metric GS7231: Median LOS for Emergency Procedure for Bowel Obstruction

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @GS7231_Count INT;

SELECT @GS7231_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND (GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR
           GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7231_MedianLOS FLOAT;

WITH OrderedLOS AS (
    SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_BowelObstruct = 'Bowel obstruction'
          AND POD_Derived = 'EM'
          AND (GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR
               GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
)
SELECT @GS7231_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7231_Count + 1) / 2, (@GS7231_Count + 2) / 2 );

SELECT 'Metric GS7231 - Median LOS for Emergency Procedure for Bowel Obstruction' AS Metric,
       @GS7231_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7231_Count AS Denominator;


/* Emergency readmission within 30 days following procedure for bowel obstruction (12mths to qtr end) 
Metric ID: GS7236

Count(Spells)
(GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction') 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
(GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction') 
AND Mort = 0

Q4 2023/24

*/

-- Metric GS7236: Emergency Readmission Within 30 Days Following Procedure for Bowel Obstruction

-- Date Range: Q4 2023/24
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7236_Numerator INT;

SELECT @GS7236_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR
       GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7236_Denominator INT;

SELECT @GS7236_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' OR
       GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7236_Rate FLOAT;

SET @GS7236_Rate = CASE
                       WHEN @GS7236_Denominator > 0 THEN
                           CAST(@GS7236_Numerator AS FLOAT) / @GS7236_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7236 - Emergency Readmission Within 30 Days Following Procedure for Bowel Obstruction' AS Metric,
       @GS7236_Rate AS Rate,
       @GS7236_Numerator AS Numerator,
       @GS7236_Denominator AS Denominator;


/* -------------------------------------------------------------------
	Large bowel obstruction
 ------------------------------------------------------------------- */

/* Median length of stay for emergency procedure for large bowel obstruction (12mths to qtr end) 
Metric ID: GS7237

Median(Spell_LOS)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction'

COUNT(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction'

Q1 2024/25

*/

-- Metric GS7237: Median LOS for Emergency Procedure for Large Bowel Obstruction

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @GS7237_Count INT;

SELECT @GS7237_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7237_MedianLOS FLOAT;

WITH OrderedLOS AS (
    SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_BowelObstruct = 'Bowel obstruction'
          AND POD_Derived = 'EM'
          AND GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction'
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
)
SELECT @GS7237_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7237_Count + 1) / 2, (@GS7237_Count + 2) / 2 );

SELECT 'Metric GS7237 - Median LOS for Emergency Procedure for Large Bowel Obstruction' AS Metric,
       @GS7237_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7237_Count AS Denominator;


/* Treatment rate (procedure for large bowel obstruction) following diagnosis of bowel obstruction in an emergency admission (12mths to qtr end) 
Metric ID: GS7238

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND (GenS_FLAG_DiagTreatLarge = 1 OR GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction')

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM'

Q4 2023/24

*/

-- Metric GS7238: Treatment Rate for Large Bowel Obstruction Following Emergency Admission

-- Date Range: Q4 2023/24
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7238_Numerator INT;

SELECT @GS7238_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND (GenS_FLAG_DiagTreatLarge = 1 OR GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction')
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7238_Denominator INT;

SELECT @GS7238_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7238_Rate FLOAT;

SET @GS7238_Rate = CASE
                       WHEN @GS7238_Denominator > 0 THEN
                           CAST(@GS7238_Numerator AS FLOAT) / @GS7238_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7238 - Treatment Rate for Large Bowel Obstruction Following Emergency Admission' AS Metric,
       @GS7238_Rate AS Rate,
       @GS7238_Numerator AS Numerator,
       @GS7238_Denominator AS Denominator;

/* Average days between emergency diagnosis of bowel obstruction and elective procedure for large bowel obstruction (12mths to qtr end) 
Metric ID: GS7239

Sum(GenS_FLAG_DiagTreatPeriod)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_FLAG_DiagTreatLarge = 1

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_FLAG_DiagTreatLarge = 1

Q4 2023/24

*/

-- Metric GS7239: Average Days Between Emergency Diagnosis and Elective Procedure for Large Bowel Obstruction

-- Date Range: Q4 2023/24
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Calculate Total Days and Count
DECLARE @GS7239_TotalDays INT;
DECLARE @GS7239_Count INT;

SELECT @GS7239_TotalDays = SUM(GenS_FLAG_DiagTreatPeriod),
       @GS7239_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND GenS_FLAG_DiagTreatLarge = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date
      BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Average Days
DECLARE @GS7239_AverageDays FLOAT;

SET @GS7239_AverageDays = CASE
                              WHEN @GS7239_Count > 0 THEN
                                  CAST(@GS7239_TotalDays AS FLOAT) / @GS7239_Count
                              ELSE
                                  NULL
                          END;

SELECT 'Metric GS7239 - Average Days Between Emergency Diagnosis and Elective Procedure for Large Bowel Obstruction' AS Metric,
       @GS7239_AverageDays AS Average_Days,
       @GS7239_TotalDays AS Total_Days,
       @GS7239_Count AS [Count];


/* Emergency readmission within 30 days following procedure for large bowel obstruction (12mths to qtr end) 
Metric ID: GS7240

Count(Spells)
GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' 
AND Mort = 0 
AND Read30 = 'Y'

Count(Spells)
GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction' 
AND Mort = 0

Q4 2023/24

*/

-- Metric GS7240: Emergency Readmission Within 30 Days Following Procedure for Large Bowel Obstruction

-- Date Range: Q4 2023/24
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7240_Numerator INT;

SELECT @GS7240_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7240_Denominator INT;

SELECT @GS7240_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ProcLargeBowelObstruct = 'Procedure for large bowel obstruction'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7240_Rate FLOAT;

SET @GS7240_Rate = CASE
                       WHEN @GS7240_Denominator > 0 THEN
                           CAST(@GS7240_Numerator AS FLOAT) / @GS7240_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7240 - Emergency Readmission Within 30 Days Following Procedure for Large Bowel Obstruction' AS Metric,
       @GS7240_Rate AS Rate,
       @GS7240_Numerator AS Numerator,
       @GS7240_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Small bowel obstruction
 ------------------------------------------------------------------- */

/* Median length of stay for emergency procedure for small bowel obstruction (12mths to qtr end) 
Metric ID: GS7241

Median(Spell_LOS)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'

COUNT(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'

Q1 2024/25

*/

-- Metric GS7241: Median LOS for Emergency Procedure for Small Bowel Obstruction

-- Date Range: Q1 2024/25 (April to June 2024)
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Count of Spells
DECLARE @GS7241_Count INT;

SELECT @GS7241_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7241_MedianLOS FLOAT;

WITH OrderedLOS AS (
    SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_BowelObstruct = 'Bowel obstruction'
          AND POD_Derived = 'EM'
          AND GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
)
SELECT @GS7241_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7241_Count + 1) / 2, (@GS7241_Count + 2) / 2 );

SELECT 'Metric GS7241 - Median LOS for Emergency Procedure for Small Bowel Obstruction' AS Metric,
       @GS7241_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7241_Count AS Denominator;

/* Treatment rate (procedure for small bowel obstruction) in subsequent elective admission following diagnosis of small bowel obstruction 
in an emergency admission (12mths to qtr end) 
Metric ID: GS7242

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM' 
AND (GenS_FLAG_DiagTreatSmall = 1 OR GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')

Count(Spells)
GenS_BowelObstruct = 'Bowel obstruction' 
AND POD_Derived = 'EM'

Q4 2023/24

*/

-- Metric GS7242: Treatment Rate in Subsequent Elective Admission for Small Bowel Obstruction

-- Date Range: Q4 2023/24 (January to March 2024)
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7242_Numerator INT;

SELECT @GS7242_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND (GenS_FLAG_DiagTreatSmall = 1 OR GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction')
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7242_Denominator INT;

SELECT @GS7242_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_BowelObstruct = 'Bowel obstruction'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7242_Rate FLOAT;

SET @GS7242_Rate = CASE
                       WHEN @GS7242_Denominator > 0 THEN
                           CAST(@GS7242_Numerator AS FLOAT) / @GS7242_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7242 - Treatment Rate in Subsequent Elective Admission for Small Bowel Obstruction' AS Metric,
       @GS7242_Rate AS Rate,
       @GS7242_Numerator AS Numerator,
       @GS7242_Denominator AS Denominator;


/* Emergency readmission within 30 days following procedure for small bowel obstruction (12mths to qtr end)
Metric ID: GS7244

Count(Spells)
GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction' 
AND Mort = 0  
AND Read30 = 'Y'

Count(Spells)
GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction' 
AND Mort = 0

Q4 2023/24

*/

-- Metric GS7244: Emergency Readmission Within 30 Days Following Procedure for Small Bowel Obstruction

-- Date Range: Q4 2023/24
DECLARE @Q4_2023_24_StartDate DATE = '2023-04-01';
DECLARE @Q4_2023_24_EndDate DATE = '2024-03-31';

-- Numerator
DECLARE @GS7244_Numerator INT;

SELECT @GS7244_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'
      AND Mort = 0
      AND Read30 = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Denominator
DECLARE @GS7244_Denominator INT;

SELECT @GS7244_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ProcSmallBowelObstruct = 'Procedure for small bowel obstruction'
      AND Mort = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q4_2023_24_StartDate AND @Q4_2023_24_EndDate;

-- Calculate Rate
DECLARE @GS7244_Rate FLOAT;

SET @GS7244_Rate = CASE
                       WHEN @GS7244_Denominator > 0 THEN
                           CAST(@GS7244_Numerator AS FLOAT) / @GS7244_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7244 - Emergency Readmission Within 30 Days Following Procedure for Small Bowel Obstruction' AS Metric,
       @GS7244_Rate AS Rate,
       @GS7244_Numerator AS Numerator,
       @GS7244_Denominator AS Denominator;


/* -------------------------------------------------------------------
	Undifferentiated abdominal or pelvic pain
 ------------------------------------------------------------------- */

/* No procedure rate for emergency patents with undifferentiated abdominal or pelvic pain (12mths to qtr end)
Metric ID: GS7245

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM' 
AND GenS_ProcUndiffAbdom = 'No procedure' 
AND GenS_FLAG_NoProc_Spell = 1

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM'

Q1 2024/25

*/

-- Metric GS7245: No Procedure Rate for Emergency Patients with Undifferentiated Abdominal or Pelvic Pain

DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Date Range: Q1 2024/25

-- Numerator
DECLARE @GS7245_Numerator INT;

SELECT @GS7245_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
      AND POD_Derived = 'EM'
      AND GenS_ProcUndiffAbdom = 'No procedure'
      AND GenS_FLAG_NoProc_Spell = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7245_Denominator INT;

SELECT @GS7245_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7245_Rate FLOAT;

SET @GS7245_Rate = CASE
                       WHEN @GS7245_Denominator > 0 THEN
                           CAST(@GS7245_Numerator AS FLOAT) / @GS7245_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7245 - No Procedure Rate for Emergency Patients with Undifferentiated Abdominal or Pelvic Pain' AS Metric,
       @GS7245_Rate AS Rate,
       @GS7245_Numerator AS Numerator,
       @GS7245_Denominator AS Denominator;


/* Diagnostic procedure only rate for emergency patients with undifferentiated abdominal or pelvic pain (12mths to qtr end) 
Metric ID: GS7246

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM' 
AND GenS_ProcUndiffAbdom = 'Diagnostic procedure only' 
AND GenS_FLAG_ThProcUndiffAbdom_Spell = 0

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM'

Q1 2024/25

*/

-- Metric GS7246: Diagnostic Procedure Only Rate for Emergency Patients with Undifferentiated Abdominal or Pelvic Pain


-- Date Range: Q1 2024/25 (April to June 2024)

-- Numerator
DECLARE @GS7246_Numerator INT;

SELECT @GS7246_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
      AND POD_Derived = 'EM'
      AND GenS_ProcUndiffAbdom = 'Diagnostic procedure only'
      AND GenS_FLAG_ThProcUndiffAbdom_Spell = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator (Same as GS7245)
-- Using @GS7245_Denominator

-- Calculate Rate
DECLARE @GS7246_Rate FLOAT;

SET @GS7246_Rate = CASE
                       WHEN @GS7245_Denominator > 0 THEN
                           CAST(@GS7246_Numerator AS FLOAT) / @GS7245_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7246 - Diagnostic Procedure Only Rate for Emergency Patients with Undifferentiated Abdominal or Pelvic Pain' AS Metric,
       @GS7246_Rate AS Rate,
       @GS7246_Numerator AS Numerator,
       @GS7245_Denominator AS Denominator;


/* Therapeutic procedure rate for emergency patients with undifferentiated abdominal or pelvic pain (12mths to qtr end)
Metric ID: GS7247

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM' 
AND GenS_ProcUndiffAbdom = 'Therapeutic procedure'

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM'

Q1 2024/25

*/

-- Metric GS7247: Therapeutic Procedure Rate for Emergency Patients with Undifferentiated Abdominal or Pelvic Pain

-- Numerator
DECLARE @GS7247_Numerator INT;

SELECT @GS7247_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
      AND POD_Derived = 'EM'
      AND GenS_ProcUndiffAbdom = 'Therapeutic procedure'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator (Same as GS7245)
-- Using @GS7245_Denominator

-- Calculate Rate
DECLARE @GS7247_Rate FLOAT;

SET @GS7247_Rate = CASE
                       WHEN @GS7245_Denominator > 0 THEN
                           CAST(@GS7247_Numerator AS FLOAT) / @GS7245_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7247 - Therapeutic Procedure Rate for Emergency Patients with Undifferentiated Abdominal or Pelvic Pain' AS Metric,
       @GS7247_Rate AS Rate,
       @GS7247_Numerator AS Numerator,
       @GS7245_Denominator AS Denominator;


/* Length of stay greater than 3 days for emergency patents receiving no procedure for undifferentiated abdominal or pelvic pain (12mths to qtr end) 
Metric ID: GS7248

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') AND POD_Derived = 'EM' AND GenS_ProcUndiffAbdom = 'No procedure' AND GenS_FLAG_NoProc_Spell = 1 AND Spell_LOS > 3 

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') AND POD_Derived = 'EM' AND GenS_ProcUndiffAbdom = 'No procedure' AND GenS_FLAG_NoProc_Spell = 1

Q1 2024/25

*/

DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Metric GS7248: LOS > 3 Days for No Procedure Emergency Patients with Undifferentiated Abdominal or Pelvic Pain

-- Numerator
DECLARE @GS7248_Numerator INT;

SELECT @GS7248_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
      AND POD_Derived = 'EM'
      AND GenS_ProcUndiffAbdom = 'No procedure'
      AND GenS_FLAG_NoProc_Spell = 1
      AND Spell_LOS > 3
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7248_Denominator INT;

SELECT @GS7248_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
      AND POD_Derived = 'EM'
      AND GenS_ProcUndiffAbdom = 'No procedure'
      AND GenS_FLAG_NoProc_Spell = 1
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7248_Rate FLOAT;

SET @GS7248_Rate = CASE
                       WHEN @GS7248_Denominator > 0 THEN
                           CAST(@GS7248_Numerator AS FLOAT) / @GS7248_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7248 - LOS > 3 Days for No Procedure Emergency Patients with Undifferentiated Abdominal or Pelvic Pain' AS Metric,
       @GS7248_Rate AS Rate,
       @GS7248_Numerator AS Numerator,
       @GS7248_Denominator AS Denominator;


/* Minimal access rate for therapeutic procedures for emergency patients with undifferentiated abdominal or pelvic pain (12mths to qtr end) 
Metric ID: GS7250

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM' 
AND GenS_ProcUndiffAbdom = 'Therapeutic procedure' 
AND GenS_MinimalAccess IN ('Laparoscopic approach','Other minimal access approach','Robotic approach')

Count(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM' 
AND GenS_ProcUndiffAbdom = 'Therapeutic procedure'

Q1 2024/25

*/

DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Metric GS7250: Minimal Access Rate for Therapeutic Procedures for Emergency Patients with Undifferentiated Abdominal or Pelvic Pain

-- Numerator
DECLARE @GS7250_Numerator INT;

SELECT @GS7250_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
      AND POD_Derived = 'EM'
      AND GenS_ProcUndiffAbdom = 'Therapeutic procedure'
      AND GenS_MinimalAccess IN ('Laparoscopic approach', 'Other minimal access approach', 'Robotic approach')
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7250_Denominator INT;

SELECT @GS7250_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
      AND POD_Derived = 'EM'
      AND GenS_ProcUndiffAbdom = 'Therapeutic procedure'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7250_Rate FLOAT;

SET @GS7250_Rate = CASE
                       WHEN @GS7250_Denominator > 0 THEN
                           CAST(@GS7250_Numerator AS FLOAT) / @GS7250_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7250 - Minimal Access Rate for Therapeutic Procedures for Emergency Patients with Undifferentiated Abdominal or Pelvic Pain' AS Metric,
       @GS7250_Rate AS Rate,
       @GS7250_Numerator AS Numerator,
       @GS7250_Denominator AS Denominator;


/* Median length of stay for emergency patients receiving a therapeutic procedure for undifferentiated abdominal or pelvic pain (12mths to qtr end) 
Metric ID: GS7251

Median(Spell_LOS)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM' 
AND GenS_ProcUndiffAbdom = 'Therapeutic procedure'

COUNT(Spells)
GenS_AbdomPain IN ('Non specific abdominal or pelvic pain','Specific abdominal or pelvic pain') 
AND POD_Derived = 'EM' 
AND GenS_ProcUndiffAbdom = 'Therapeutic procedure'

Q1 2024/25

*/

DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Metric GS7251: Median LOS for Therapeutic Procedure Emergency Patients with Undifferentiated Abdominal or Pelvic Pain

-- Count of Spells
DECLARE @GS7251_Count INT;

SELECT @GS7251_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
      AND POD_Derived = 'EM'
      AND GenS_ProcUndiffAbdom = 'Therapeutic procedure'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Median Spell_LOS
DECLARE @GS7251_MedianLOS FLOAT;

WITH OrderedLOS AS (
    SELECT Spell_LOS,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Spell_LOS DESC) AS RowDesc
    FROM #Spells_With_Variables
    WHERE GenS_AbdomPain IN ('Non specific abdominal or pelvic pain', 'Specific abdominal or pelvic pain')
          AND POD_Derived = 'EM'
          AND GenS_ProcUndiffAbdom = 'Therapeutic procedure'
          AND Org_Code_Provider = 'rpa'
          AND Sector = 'med'
          AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate
)
SELECT @GS7251_MedianLOS = AVG(Spell_LOS)
FROM OrderedLOS
WHERE RowAsc IN ((@GS7251_Count + 1) / 2, (@GS7251_Count + 2) / 2 );

SELECT 'Metric GS7251 - Median LOS for Therapeutic Procedure Emergency Patients with Undifferentiated Abdominal or Pelvic Pain' AS Metric,
       @GS7251_MedianLOS AS Median_LOS,
       NULL AS Numerator,
       @GS7251_Count AS Denominator;


/* -------------------------------------------------------------------
	Other general surgery
 ------------------------------------------------------------------- */

/* No overnight stay rate for emergency patients receiving a procedure for peri-anal abscess (12mths to qtr end) 
Metric ID: GS7252

Count(Spells)
GenS_ProcPerianalAbcess = 'Procedure for perianal abscess' 
AND POD_Derived = 'EM' 
AND Spell_LOS = 0

Count(Spells)
GenS_ProcPerianalAbcess = 'Procedure for perianal abscess' 
AND POD_Derived = 'EM'

Q1 2024/25

*/

-- Metric GS7252: No Overnight Stay Rate for Emergency Patients Receiving a Procedure for Peri-Anal Abscess

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7252_Numerator INT;

SELECT @GS7252_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ProcPerianalAbcess = 'Procedure for perianal abscess'
      AND POD_Derived = 'EM'
      AND Spell_LOS = 0
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7252_Denominator INT;

SELECT @GS7252_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE GenS_ProcPerianalAbcess = 'Procedure for perianal abscess'
      AND POD_Derived = 'EM'
      AND Org_Code_Provider = 'rpa'
      AND Sector = 'med'
      AND Admission_Date BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7252_Rate FLOAT;

SET @GS7252_Rate = CASE
                       WHEN @GS7252_Denominator > 0 THEN
                           CAST(@GS7252_Numerator AS FLOAT) / @GS7252_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7252 - No Overnight Stay Rate for Emergency Patients Receiving a Procedure for Peri-Anal Abscess' AS Metric,
       @GS7252_Rate AS Rate,
       @GS7252_Numerator AS Numerator,
       @GS7252_Denominator AS Denominator;


/* Daycase rate for elective haemorrhoid surgery (12mths to qtr end) 
Metric ID: GS7255

Count(Spells)
NCIP_Procedure_Main = 'Haemorrhoid surgery | age 17+ | elective' 
AND POD_Derived = 'DC'

Count(Spells)
NCIP_Procedure_Main = 'Haemorrhoid surgery | age 17+ | elective'

Q1 2024/25

*/

-- Create Temporary Table for Haemorrhoid Surgery Elective Spells

IF OBJECT_ID('tempdb..#HaemorrhoidSurgeryElectiveSpells') IS NOT NULL
    DROP TABLE #HaemorrhoidSurgeryElectiveSpells;

WITH EligibleSpells
AS (SELECT DISTINCT
           s.Spell_Number
    FROM #Spells_With_Variables s
    WHERE s.Age >= 17
          AND s.POD_Derived IN ( 'EL', 'DC', 'RA' ))
SELECT DISTINCT
       s.Spell_Number
INTO #HaemorrhoidSurgeryElectiveSpells
FROM EligibleSpells s
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON s.Spell_Number = ipe.Spell_Number
WHERE (
          -- Condition A
          EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp
    WHERE ipp.Episode_Number = ipe.Episode_Number
          AND ipp.Sector = ipe.Sector
          AND ipp.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Haemorrhoid_surgery
              )
)
          AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = ipe.Episode_Number
          AND ipd.Sector = ipe.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Haemorrhoids
              )
)
      )
      OR
      (
          -- Condition B
          EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp1
    WHERE ipp1.Episode_Number = ipe.Episode_Number
          AND ipp1.Sector = ipe.Sector
          AND ipp1.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp1.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Ligation_of_artery
              )
)
          AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp2
    WHERE ipp2.Episode_Number = ipe.Episode_Number
          AND ipp2.Sector = ipe.Sector
          AND ipp2.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 24
          AND LEFT(ipp2.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Lateral_branch_of_abdominal_aorta
              )
)
          AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = ipe.Episode_Number
          AND ipd.Sector = ipe.Sector
          AND ipd.Coded_Clinical_Entry_Seq
          BETWEEN 1 AND 20
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ALL_Haemorrhoids
              )
)
      );


-- Metric GS7255: Day Case Rate for Elective Haemorrhoid Surgery

-- Date Range: Q1 2024/25
DECLARE @Q1_2024_25_StartDate DATE = '2023-07-01';
DECLARE @Q1_2024_25_EndDate DATE = '2024-06-30';

-- Numerator
DECLARE @GS7255_Numerator INT;

SELECT @GS7255_Numerator = COUNT(DISTINCT s.Spell_Number)
FROM #HaemorrhoidSurgeryElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.POD_Derived = 'DC'
      AND swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med'
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Denominator
DECLARE @GS7255_Denominator INT;

SELECT @GS7255_Denominator = COUNT(DISTINCT s.Spell_Number)
FROM #HaemorrhoidSurgeryElectiveSpells s
    INNER JOIN #Spells_With_Variables swv
        ON s.Spell_Number = swv.Spell_Number
WHERE swv.Org_Code_Provider = 'rpa'
      AND swv.Sector = 'med'
      AND swv.Admission_Date
      BETWEEN @Q1_2024_25_StartDate AND @Q1_2024_25_EndDate;

-- Calculate Rate
DECLARE @GS7255_Rate FLOAT;

SET @GS7255_Rate = CASE
                       WHEN @GS7255_Denominator > 0 THEN
                           CAST(@GS7255_Numerator AS FLOAT) / @GS7255_Denominator
                       ELSE
                           NULL
                   END;

SELECT 'Metric GS7255 - Day Case Rate for Elective Haemorrhoid Surgery' AS Metric,
       @GS7255_Rate AS Rate,
       @GS7255_Numerator AS Numerator,
       @GS7255_Denominator AS Denominator;

-- SQL Code Ends





