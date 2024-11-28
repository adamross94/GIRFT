/*
	Script Title: GIRFT All Clinical Metrics - Gynaecology
	Author: Adam Ross
	Version: 1.0
	Description: This script generates the figures for the All Clinical metrics section 
	of the Model Hospital dashboard. It covers the following Classes:

	- Benign Hysterectomy (Elective)
	- Cancer Hysterectomy (Elective)
	- Prolapse Procedures (Elective)
	- Incontinence (Elective)
	- Emergency Care
	- Other
*/

-- SQL Code Begins

-- ========================================
-- Step 1: Drop Temporary Tables if They Exist
-- ========================================

IF OBJECT_ID('tempdb..#Spells_With_Variables') IS NOT NULL
    DROP TABLE #Spells_With_Variables;

IF OBJECT_ID('tempdb..#CodeGroup_Gynae_Procedures') IS NOT NULL
    DROP TABLE #CodeGroup_Gynae_Procedures;

IF OBJECT_ID('tempdb..#CodeGroup_Gynae_Diagnoses') IS NOT NULL
    DROP TABLE #CodeGroup_Gynae_Diagnoses;

-- ========================================
-- Step 2: Variable Declarations
-- ========================================

-- Define the end date of the reporting period (e.g., end of the quarter)
DECLARE @QuarterEndDate DATE = '2024-06-30'; -- Adjust as needed

-- Define the number of months to look back from the Quarter End Date
DECLARE @MonthsBack INT = 12;

-- Calculate the Metric Start Date (first day of the month 12 months prior)
DECLARE @MetricStartDate DATE = DATEADD(YEAR, -1, DATEADD(DAY, 1, EOMONTH(@QuarterEndDate, -13)));

-- Define the Metric End Date
DECLARE @MetricEndDate DATE = @QuarterEndDate;

-- Define the overall date range for data extraction
DECLARE @OverallStartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @OverallEndDate DATE = @QuarterEndDate;

-- Provider and Sector Codes
DECLARE @Org_Code_Provider VARCHAR(10) = 'RPA'; 
DECLARE @Sector VARCHAR(10) = 'MED'; 

-- ========================================
-- Step 3: Create and Populate Temporary Tables for CodeGroups
-- ========================================

-- -----------------------
-- Code Group: Gynae_bucket_diagnosis_2
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Gynae_bucket_diagnosis_2') IS NOT NULL
    DROP TABLE #CodeGroup_Gynae_bucket_diagnosis_2;

CREATE TABLE #CodeGroup_Gynae_bucket_diagnosis_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Gynae_bucket_diagnosis_2
(
    Code
)
VALUES
('C4'),
('C5'),
('D0'),
('D2'),
('D3'),
('E6'),
('K5'),
('N3'),
('N7'),
('N8'),
('N9'),
('O0'),
('R3'),
('T8'),
('T9'),
('Y6');

-- -----------------------
-- Code Group: Cond_CancerHysterectomy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_CancerHysterectomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_CancerHysterectomy_3;

CREATE TABLE #CodeGroup_Cond_CancerHysterectomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_CancerHysterectomy_3
(
    Code
)
VALUES
('C48'),
('C53'),
('C54'),
('C55'),
('C56');

-- -----------------------
-- Code Group: Cond_CancerGynae_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_CancerGynae_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_CancerGynae_3;

CREATE TABLE #CodeGroup_Cond_CancerGynae_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_CancerGynae_3
(
    Code
)
VALUES
('C51'),
('C52'),
('C53'),
('C54'),
('C55'),
('C56'),
('C57'),
('D06');

-- -----------------------
-- Code Group: Cond_CancerCervical_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_CancerCervical_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_CancerCervical_3;

CREATE TABLE #CodeGroup_Cond_CancerCervical_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_CancerCervical_3
(
    Code
)
VALUES
('C53'),
('D06');

-- -----------------------
-- Code Group: Cond_CancerEndometrial_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_CancerEndometrial_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_CancerEndometrial_3;

CREATE TABLE #CodeGroup_Cond_CancerEndometrial_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_CancerEndometrial_3
(
    Code
)
VALUES
('C54'),
('C55');

-- -----------------------
-- Code Group: Cond_CancerOvaries_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_CancerOvaries_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_CancerOvaries_3;

CREATE TABLE #CodeGroup_Cond_CancerOvaries_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_CancerOvaries_3
(
    Code
)
VALUES
('C56');

-- -----------------------
-- Code Group: Cond_BenignNeoFemaleOrgans_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_BenignNeoFemaleOrgans_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_BenignNeoFemaleOrgans_3;

CREATE TABLE #CodeGroup_Cond_BenignNeoFemaleOrgans_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_BenignNeoFemaleOrgans_3
(
    Code
)
VALUES
('D25'),
('D26'),
('D27'),
('D28'),
('D30');

-- -----------------------
-- Code Group: Cond_Leiomyoma_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_Leiomyoma_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_Leiomyoma_3;

CREATE TABLE #CodeGroup_Cond_Leiomyoma_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_Leiomyoma_3
(
    Code
)
VALUES
('D25');

-- -----------------------
-- Code Group: Cond_BenignNeoplasmOvaries_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_BenignNeoplasmOvaries_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_BenignNeoplasmOvaries_3;

CREATE TABLE #CodeGroup_Cond_BenignNeoplasmOvaries_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_BenignNeoplasmOvaries_3
(
    Code
)
VALUES
('D27');

-- -----------------------
-- Code Group: Cond_Endometriosis_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_Endometriosis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_Endometriosis_3;

CREATE TABLE #CodeGroup_Cond_Endometriosis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_Endometriosis_3
(
    Code
)
VALUES
('N80');

-- -----------------------
-- Code Group: Cond_OvarianCyst_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_OvarianCyst_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_OvarianCyst_4;

CREATE TABLE #CodeGroup_Cond_OvarianCyst_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_OvarianCyst_4
(
    Code
)
VALUES
('N830'),
('N831'),
('N832');

-- -----------------------
-- Code Group: Cond_Incontinence_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_Incontinence_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_Incontinence_3;

CREATE TABLE #CodeGroup_Cond_Incontinence_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_Incontinence_3
(
    Code
)
VALUES
('R32');

-- -----------------------
-- Code Group: Cond_Incontinence_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_Incontinence_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_Incontinence_4;

CREATE TABLE #CodeGroup_Cond_Incontinence_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_Incontinence_4
(
    Code
)
VALUES
('N393'),
('N394');

-- -----------------------
-- Code Group: Complications_Surgery_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Complications_Surgery_4') IS NOT NULL
    DROP TABLE #CodeGroup_Complications_Surgery_4;

CREATE TABLE #CodeGroup_Complications_Surgery_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Complications_Surgery_4
(
    Code
)
VALUES
('T810'),
('T811'),
('T812'),
('T813'),
('T814'),
('T815'),
('T816'),
('T817'),
('T818'),
('T819'),
('T888'),
('T889'),
('Y600'),
('Y604'),
('Y608'),
('Y609');

-- -----------------------
-- Code Group: DiagProcLymphNode_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_DiagProcLymphNode_3') IS NOT NULL
    DROP TABLE #CodeGroup_DiagProcLymphNode_3;

CREATE TABLE #CodeGroup_DiagProcLymphNode_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_DiagProcLymphNode_3
(
    Code
)
VALUES
('T86'),
('T87'),
('T91');

-- -----------------------
-- Code Group: DiagProcSentinelLymph_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_DiagProcSentinelLymph_4') IS NOT NULL
    DROP TABLE #CodeGroup_DiagProcSentinelLymph_4;

CREATE TABLE #CodeGroup_DiagProcSentinelLymph_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_DiagProcSentinelLymph_4
(
    Code
)
VALUES
('T866'),
('T867'),
('T868'),
('T869'),
('T875'),
('T877'),
('T878'),
('T879'),
('T911'),
('T912');

-- -----------------------
-- Code Group: Neurogenicbladder_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Neurogenicbladder_3') IS NOT NULL
    DROP TABLE #CodeGroup_Neurogenicbladder_3;

CREATE TABLE #CodeGroup_Neurogenicbladder_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Neurogenicbladder_3
(
    Code
)
VALUES
('N31');

-- -----------------------
-- Code Group: Cond_BladderDisorder_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_BladderDisorder_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_BladderDisorder_4;

CREATE TABLE #CodeGroup_Cond_BladderDisorder_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_BladderDisorder_4
(
    Code
)
VALUES
('N318'),
('N328');

-- -----------------------
-- Code Group: Cond_Bartholin_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_Bartholin_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_Bartholin_4;

CREATE TABLE #CodeGroup_Cond_Bartholin_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_Bartholin_4
(
    Code
)
VALUES
('N750'),
('N751'),
('N758'),
('N759');

-- -----------------------
-- Code Group: Cond_InflammatoryBowel_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_InflammatoryBowel_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_InflammatoryBowel_3;

CREATE TABLE #CodeGroup_Cond_InflammatoryBowel_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_InflammatoryBowel_3
(
    Code
)
VALUES
('K50'),
('K51');

-- -----------------------
-- Code Group: Cond_EptopicPregnancy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_EptopicPregnancy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_EptopicPregnancy_3;

CREATE TABLE #CodeGroup_Cond_EptopicPregnancy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_EptopicPregnancy_3
(
    Code
)
VALUES
('O00');

-- -----------------------
-- Code Group: Cond_Miscarriage_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_Miscarriage_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_Miscarriage_3;

CREATE TABLE #CodeGroup_Cond_Miscarriage_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_Miscarriage_3
(
    Code
)
VALUES
('O03');

-- -----------------------
-- Code Group: AppendectomyOrColonicResection_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AppendectomyOrColonicResection_3') IS NOT NULL
    DROP TABLE #CodeGroup_AppendectomyOrColonicResection_3;

CREATE TABLE #CodeGroup_AppendectomyOrColonicResection_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AppendectomyOrColonicResection_3
(
    Code
)
VALUES
('H01'),
('H02'),
('H04'),
('H05'),
('H06'),
('H07'),
('H08'),
('H09'),
('H10'),
('H11'),
('H29');

-- -----------------------
-- Code Group: Splenectomy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Splenectomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Splenectomy_3;

CREATE TABLE #CodeGroup_Splenectomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Splenectomy_3
(
    Code
)
VALUES
('J69');

-- -----------------------
-- Code Group: Splenectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Splenectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Splenectomy_4;

CREATE TABLE #CodeGroup_Splenectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Splenectomy_4
(
    Code
)
VALUES
('J701');

-- -----------------------
-- Code Group: UrethralInjection_InertSubstance_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_UrethralInjection_InertSubstance_4') IS NOT NULL
    DROP TABLE #CodeGroup_UrethralInjection_InertSubstance_4;

CREATE TABLE #CodeGroup_UrethralInjection_InertSubstance_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UrethralInjection_InertSubstance_4
(
    Code
)
VALUES
('M323'),
('M563');

-- -----------------------
-- Code Group: InjectionBotox_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_InjectionBotox_4') IS NOT NULL
    DROP TABLE #CodeGroup_InjectionBotox_4;

CREATE TABLE #CodeGroup_InjectionBotox_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_InjectionBotox_4
(
    Code
)
VALUES
('M434'),
('M488'),
('M489'),
('M494'),
('M495');

-- -----------------------
-- Code Group: Cystoscopy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cystoscopy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cystoscopy_4;

CREATE TABLE #CodeGroup_Cystoscopy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cystoscopy_4
(
    Code
)
VALUES
('M458'),
('M459');

-- -----------------------
-- Code Group: Colposuspension_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Colposuspension_4') IS NOT NULL
    DROP TABLE #CodeGroup_Colposuspension_4;

CREATE TABLE #CodeGroup_Colposuspension_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Colposuspension_4
(
    Code
)
VALUES
('M523');

-- -----------------------
-- Code Group: IntroductionTVT_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_IntroductionTVT_4') IS NOT NULL
    DROP TABLE #CodeGroup_IntroductionTVT_4;

CREATE TABLE #CodeGroup_IntroductionTVT_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_IntroductionTVT_4
(
    Code
)
VALUES
('M533');

-- -----------------------
-- Code Group: IntroductionTOT_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_IntroductionTOT_4') IS NOT NULL
    DROP TABLE #CodeGroup_IntroductionTOT_4;

CREATE TABLE #CodeGroup_IntroductionTOT_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_IntroductionTOT_4
(
    Code
)
VALUES
('M536');

-- -----------------------
-- Code Group: Colporrhaphy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Colporrhaphy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Colporrhaphy_4;

CREATE TABLE #CodeGroup_Colporrhaphy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Colporrhaphy_4
(
    Code
)
VALUES
('P221'),
('P222'),
('P223'),
('P231'),
('P232'),
('P233'),
('P236'),
('P237');

-- -----------------------
-- Code Group: SacrospinousFix_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_SacrospinousFix_4') IS NOT NULL
    DROP TABLE #CodeGroup_SacrospinousFix_4;

CREATE TABLE #CodeGroup_SacrospinousFix_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_SacrospinousFix_4
(
    Code
)
VALUES
('P247');

-- -----------------------
-- Code Group: AbdominalHysterectomy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AbdominalHysterectomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_AbdominalHysterectomy_3;

CREATE TABLE #CodeGroup_AbdominalHysterectomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AbdominalHysterectomy_3
(
    Code
)
VALUES
('Q07');

-- -----------------------
-- Code Group: Qual_HysterTotal_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Qual_HysterTotal_4') IS NOT NULL
    DROP TABLE #CodeGroup_Qual_HysterTotal_4;

CREATE TABLE #CodeGroup_Qual_HysterTotal_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Qual_HysterTotal_4
(
    Code
)
VALUES
('Q074');

-- -----------------------
-- Code Group: Qual_HysterSubTotal_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Qual_HysterSubTotal_4') IS NOT NULL
    DROP TABLE #CodeGroup_Qual_HysterSubTotal_4;

CREATE TABLE #CodeGroup_Qual_HysterSubTotal_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Qual_HysterSubTotal_4
(
    Code
)
VALUES
('Q075');

-- -----------------------
-- Code Group: VaginalHysterectomy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_VaginalHysterectomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_VaginalHysterectomy_3;

CREATE TABLE #CodeGroup_VaginalHysterectomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_VaginalHysterectomy_3
(
    Code
)
VALUES
('Q08');

-- -----------------------
-- Code Group: EndometrialAblation_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_EndometrialAblation_4') IS NOT NULL
    DROP TABLE #CodeGroup_EndometrialAblation_4;

CREATE TABLE #CodeGroup_EndometrialAblation_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EndometrialAblation_4
(
    Code
)
VALUES
('Q162'),
('Q163'),
('Q164'),
('Q165'),
('Q166'),
('Q176'),
('Q177');

-- -----------------------
-- Code Group: Hysteroscopy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Hysteroscopy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Hysteroscopy_3;

CREATE TABLE #CodeGroup_Hysteroscopy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Hysteroscopy_3
(
    Code
)
VALUES
('Q18');

-- -----------------------
-- Code Group: Salpingoophorectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Salpingoophorectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Salpingoophorectomy_4;

CREATE TABLE #CodeGroup_Salpingoophorectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Salpingoophorectomy_4
(
    Code
)
VALUES
('Q221'),
('Q231'),
('Q232'),
('Q241');

-- -----------------------
-- Code Group: Salpingectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Salpingectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Salpingectomy_4;

CREATE TABLE #CodeGroup_Salpingectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Salpingectomy_4
(
    Code
)
VALUES
('Q222'),
('Q233'),
('Q234'),
('Q242');

-- -----------------------
-- Code Group: Oophorectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Oophorectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Oophorectomy_4;

CREATE TABLE #CodeGroup_Oophorectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Oophorectomy_4
(
    Code
)
VALUES
('Q223'),
('Q235'),
('Q236'),
('Q243');

-- -----------------------
-- Code Group: DyeTestFallopian_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_DyeTestFallopian_4') IS NOT NULL
    DROP TABLE #CodeGroup_DyeTestFallopian_4;

CREATE TABLE #CodeGroup_DyeTestFallopian_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_DyeTestFallopian_4
(
    Code
)
VALUES
('Q413');

-- -----------------------
-- Code Group: ProcEndometriosis_Other_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ProcEndometriosis_Other_3') IS NOT NULL
    DROP TABLE #CodeGroup_ProcEndometriosis_Other_3;

CREATE TABLE #CodeGroup_ProcEndometriosis_Other_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcEndometriosis_Other_3
(
    Code
)
VALUES
('T33'),
('T34'),
('T39'),
('T41');

-- -----------------------
-- Code Group: Omentectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Omentectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Omentectomy_4;

CREATE TABLE #CodeGroup_Omentectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Omentectomy_4
(
    Code
)
VALUES
('T361');

-- -----------------------
-- Code Group: BlockDissectionLymphNode_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_BlockDissectionLymphNode_3') IS NOT NULL
    DROP TABLE #CodeGroup_BlockDissectionLymphNode_3;

CREATE TABLE #CodeGroup_BlockDissectionLymphNode_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_BlockDissectionLymphNode_3
(
    Code
)
VALUES
('T85');

-- -----------------------
-- Code Group: Lymphandectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Lymphandectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Lymphandectomy_4;

CREATE TABLE #CodeGroup_Lymphandectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Lymphandectomy_4
(
    Code
)
VALUES
('T854'),
('T855'),
('T856');

-- -----------------------
-- Code Group: Body_BilateralProc_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Body_BilateralProc_4') IS NOT NULL
    DROP TABLE #CodeGroup_Body_BilateralProc_4;

CREATE TABLE #CodeGroup_Body_BilateralProc_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Body_BilateralProc_4
(
    Code
)
VALUES
('Z941');

-- -----------------------
-- Code Group: Gender_Value
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Gender_Value') IS NOT NULL
    DROP TABLE #CodeGroup_Gender_Value;

CREATE TABLE #CodeGroup_Gender_Value
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Gender_Value
(
    Code
)
VALUES
('2');

-- -----------------------
-- Code Group: Attended
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Attended') IS NOT NULL
    DROP TABLE #CodeGroup_Attended;

CREATE TABLE #CodeGroup_Attended
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Attended
(
    Code
)
VALUES
('5'),
('6');

-- -----------------------
-- Code Group: MAINSPEF_1
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_MAINSPEF_1') IS NOT NULL
    DROP TABLE #CodeGroup_MAINSPEF_1;

CREATE TABLE #CodeGroup_MAINSPEF_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_MAINSPEF_1
(
    Code
)
VALUES
('500'),
('502'); -- Main specialty codes

-- -----------------------
-- Code Group: TRETSPEF_1
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_TRETSPEF_1') IS NOT NULL
    DROP TABLE #CodeGroup_TRETSPEF_1;

CREATE TABLE #CodeGroup_TRETSPEF_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_TRETSPEF_1
(
    Code
)
VALUES
('502'),
('503'); -- Treatment specialty codes

-- -----------------------
-- Code Group: WH50_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_WH50_4') IS NOT NULL
    DROP TABLE #CodeGroup_WH50_4;

CREATE TABLE #CodeGroup_WH50_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_WH50_4
(
    Code
)
VALUES
('WH50');

-- -----------------------
-- Code Group: Pregnancy
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Pregnancy') IS NOT NULL
    DROP TABLE #CodeGroup_Pregnancy;

CREATE TABLE #CodeGroup_Pregnancy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Pregnancy
(
    Code
)
VALUES
('O268'),
('O998');

-- -----------------------
-- Code Group: App_MinimalAccess_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_App_MinimalAccess_3') IS NOT NULL
    DROP TABLE #CodeGroup_App_MinimalAccess_3;

CREATE TABLE #CodeGroup_App_MinimalAccess_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_MinimalAccess_3
(
    Code
)
VALUES
('Y75');

-- -----------------------
-- Code Group: App_Conversion_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_App_Conversion_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_Conversion_4;

CREATE TABLE #CodeGroup_App_Conversion_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_Conversion_4
(
    Code
)
VALUES
('Y75');

-- -----------------------
-- Code Group: VaginalRepairs_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_VaginalRepairs_4') IS NOT NULL
    DROP TABLE #CodeGroup_VaginalRepairs_4;

CREATE TABLE #CodeGroup_VaginalRepairs_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_VaginalRepairs_4
(
    Code
)
VALUES
('P221'),
('P222'),
('P223'),
('P231'),
('P232'),
('P233'),
('P236'),
('P237');

-- -----------------------
-- Code Group: Prolapse_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Prolapse_3') IS NOT NULL
    DROP TABLE #CodeGroup_Prolapse_3;

CREATE TABLE #CodeGroup_Prolapse_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Prolapse_3
(
    Code
)
VALUES
('N81');


-- -----------------------
-- Code Group: ProlapseVagVaultHyst_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ProlapseVagVaultHyst_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProlapseVagVaultHyst_4;

CREATE TABLE #CodeGroup_ProlapseVagVaultHyst_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProlapseVagVaultHyst_4
(
    Code
)
VALUES
('N993');

-- -----------------------
-- Code Group: RoboticApproach_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_RoboticApproach_4') IS NOT NULL
    DROP TABLE #CodeGroup_RoboticApproach_4;

CREATE TABLE #CodeGroup_RoboticApproach_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_RoboticApproach_4
(
    Code
)
VALUES
('Y743'),
('Y753'),
('Y765');

-- -----------------------
-- Code Group: Qual_ExclLapHyster_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Qual_ExclLapHyster_4') IS NOT NULL
    DROP TABLE #CodeGroup_Qual_ExclLapHyster_4;

CREATE TABLE #CodeGroup_Qual_ExclLapHyster_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Qual_ExclLapHyster_4
(
    Code
)
VALUES
('Y751'),
('Y752'),
('Y755');

-- -----------------------
-- Code Group: InjectionBotox_4A
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_InjectionBotox_4A') IS NOT NULL
    DROP TABLE #CodeGroup_InjectionBotox_4A;

CREATE TABLE #CodeGroup_InjectionBotox_4A
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_InjectionBotox_4A
(
    Code
)
VALUES
('M434');

-- -----------------------
-- Code Group: InjectionBotox_4B
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_InjectionBotox_4B') IS NOT NULL
    DROP TABLE #CodeGroup_InjectionBotox_4B;

CREATE TABLE #CodeGroup_InjectionBotox_4B
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_InjectionBotox_4B
(
    Code
)
VALUES
('M488');

-- -----------------------
-- Code Group: App_BotoxDrug_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_App_BotoxDrug_4') IS NOT NULL
    DROP TABLE #CodeGroup_App_BotoxDrug_4;

CREATE TABLE #CodeGroup_App_BotoxDrug_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_App_BotoxDrug_4
(
    Code
)
VALUES
('X851');

-- -----------------------
-- Code Group: BlockDissectionLymphNodes_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_BlockDissectionLymphNodes_3') IS NOT NULL
    DROP TABLE #CodeGroup_BlockDissectionLymphNodes_3;

CREATE TABLE #CodeGroup_BlockDissectionLymphNodes_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_BlockDissectionLymphNodes_3
(
    Code
)
VALUES
('T85');

-- -----------------------
-- Code Group: ExcisionBiopsyLymphNode_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ExcisionBiopsyLymphNode_3') IS NOT NULL
    DROP TABLE #CodeGroup_ExcisionBiopsyLymphNode_3;

CREATE TABLE #CodeGroup_ExcisionBiopsyLymphNode_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ExcisionBiopsyLymphNode_3
(
    Code
)
VALUES
('T87');

-- -----------------------
-- Code Group: CancelClinical_4
-- -----------------------

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

-- -----------------------
-- Code Group: Pregnancy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Pregnancy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Pregnancy_4;

CREATE TABLE #CodeGroup_Pregnancy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Pregnancy_4
(
    Code
)
VALUES
('O268'),
('O998');

-- -----------------------
-- Code Group: GynaeChapter_1
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_GynaeChapter_1') IS NOT NULL
    DROP TABLE #CodeGroup_GynaeChapter_1;

CREATE TABLE #CodeGroup_GynaeChapter_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_GynaeChapter_1
(
    Code
)
VALUES
('N');

-- -----------------------
-- Code Group: TherapeuticEndoscopicUterus_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_TherapeuticEndoscopicUterus_3') IS NOT NULL
    DROP TABLE #CodeGroup_TherapeuticEndoscopicUterus_3;

CREATE TABLE #CodeGroup_TherapeuticEndoscopicUterus_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_TherapeuticEndoscopicUterus_3
(
    Code
)
VALUES
('Q16'),
('Q17');

-- -----------------------
-- Code Group: Colposcopy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Colposcopy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Colposcopy_4;

CREATE TABLE #CodeGroup_Colposcopy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Colposcopy_4
(
    Code
)
VALUES
('Q014'),
('Q031'),
('Q032'),
('Q033');

-- -----------------------
-- Code Group: ProcBartholin_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ProcBartholin_4') IS NOT NULL
    DROP TABLE #CodeGroup_ProcBartholin_4;

CREATE TABLE #CodeGroup_ProcBartholin_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ProcBartholin_4
(
    Code
)
VALUES
('P032'),
('P034');

-- -----------------------
-- Code Group: Complications
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Complications') IS NOT NULL
    DROP TABLE #CodeGroup_Complications;

CREATE TABLE #CodeGroup_Complications
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Complications
(
    Code
)
VALUES
('T810'),
('T811'),
('T812'),
('T813'),
('T814'),
('T815'),
('T816'),
('T817'),
('T818'),
('T819'),
('T888'),
('T889'),
('Y600'),
('Y604'),
('Y608'),
('Y609');

-- -----------------------
-- Code Group: RemovalVaginalMesh_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_RemovalVaginalMesh_4') IS NOT NULL
    DROP TABLE #CodeGroup_RemovalVaginalMesh_4;

CREATE TABLE #CodeGroup_RemovalVaginalMesh_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_RemovalVaginalMesh_4
(
    Code
)
VALUES
('M534'),
('M535'),
('M537'),
('M572'),
('M573'),
('M574');

-- -----------------------
-- Code Group: RemovalVaginalMeshProlapse_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_RemovalVaginalMeshProlapse_4') IS NOT NULL
    DROP TABLE #CodeGroup_RemovalVaginalMeshProlapse_4;

CREATE TABLE #CodeGroup_RemovalVaginalMeshProlapse_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_RemovalVaginalMeshProlapse_4
(
    Code
)
VALUES
('P281'),
('P282'),
('P301'),
('P302');

-- -----------------------
-- Code Group: OtherCombinedAbdVagSupportBladder_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OtherCombinedAbdVagSupportBladder_4') IS NOT NULL
    DROP TABLE #CodeGroup_OtherCombinedAbdVagSupportBladder_4;

CREATE TABLE #CodeGroup_OtherCombinedAbdVagSupportBladder_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OtherCombinedAbdVagSupportBladder_4
(
    Code
)
VALUES
('M518'),
('M528'),
('M538'),
('M548'),
('M558'),
('M588');

-- -----------------------
-- Code Group: OtherRepairProlapse_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OtherRepairProlapse_4') IS NOT NULL
    DROP TABLE #CodeGroup_OtherRepairProlapse_4;

CREATE TABLE #CodeGroup_OtherRepairProlapse_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OtherRepairProlapse_4
(
    Code
)
VALUES
('P238'),
('P248'),
('P258');

-- -----------------------
-- Code Group: RemovalProsthesisOrganNOC_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_RemovalProsthesisOrganNOC_4') IS NOT NULL
    DROP TABLE #CodeGroup_RemovalProsthesisOrganNOC_4;

CREATE TABLE #CodeGroup_RemovalProsthesisOrganNOC_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_RemovalProsthesisOrganNOC_4
(
    Code
)
VALUES
('Y037');

-- -----------------------
-- Code Group: VaginalHysterectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_VaginalHysterectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_VaginalHysterectomy_4;

CREATE TABLE #CodeGroup_VaginalHysterectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_VaginalHysterectomy_4
(
    Code
)
VALUES
('Q081'),
('Q082'),
('Q083'),
('Q088'),
('Q089');

-- -----------------------
-- Code Group: Gynae_complications_HVLC_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Gynae_complications_HVLC_3') IS NOT NULL
    DROP TABLE #CodeGroup_Gynae_complications_HVLC_3;

CREATE TABLE #CodeGroup_Gynae_complications_HVLC_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Gynae_complications_HVLC_3
(
    Code
)
VALUES
('T80'),
('T83'),
('T88'),
('Y60'),
('Y61'),
('Y62'),
('Y63'),
('Y64'),
('Y65');

-- -----------------------
-- Code Group: Gynae_AbdominalHysterectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AbdominalHysterectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_AbdominalHysterectomy_4;

CREATE TABLE #CodeGroup_AbdominalHysterectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AbdominalHysterectomy_4
(
    Code
)
VALUES
('Q071'),
('Q072'),
('Q073'),
('Q074'),
('Q075'),
('Q076'),
('Q078'),
('Q079');

-- -----------------------
-- Code Group: CancelNonClinical_4
-- -----------------------

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

-- -----------------------
-- Code Group: UrinaryIncontinence_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_UrinaryIncontinence_4') IS NOT NULL
    DROP TABLE #CodeGroup_UrinaryIncontinence_4;

CREATE TABLE #CodeGroup_UrinaryIncontinence_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UrinaryIncontinence_4 (Code)
VALUES
('N393'),
('N394');

-- -----------------------
-- Code Group: UnspecifiedUrinaryIncontinence_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_UnspecifiedUrinaryIncontinence_3') IS NOT NULL
    DROP TABLE #CodeGroup_UnspecifiedUrinaryIncontinence_3;

CREATE TABLE #CodeGroup_UnspecifiedUrinaryIncontinence_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UnspecifiedUrinaryIncontinence_3 (Code)
VALUES
('R32');

-- -----------------------
-- Code Group: IntroductionTVT_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_IntroductionTVT_4') IS NOT NULL
    DROP TABLE #CodeGroup_IntroductionTVT_4;

CREATE TABLE #CodeGroup_IntroductionTVT_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_IntroductionTVT_4 (Code)
VALUES
('M533');

-- -----------------------
-- Code Group: IntroductionTVT_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_IntroductionTVT_4') IS NOT NULL
    DROP TABLE #CodeGroup_IntroductionTVT_4;

CREATE TABLE #CodeGroup_IntroductionTVT_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_IntroductionTVT_4 (Code)
VALUES
('M533');

-- -----------------------
-- Code Group: IntroductionTOT_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_IntroductionTOT_4') IS NOT NULL
    DROP TABLE #CodeGroup_IntroductionTOT_4;

CREATE TABLE #CodeGroup_IntroductionTOT_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_IntroductionTOT_4 (Code)
VALUES
('M536');

-- -----------------------
-- Code Group: VaginalRepairs_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_VaginalRepairs_4') IS NOT NULL
    DROP TABLE #CodeGroup_VaginalRepairs_4;

CREATE TABLE #CodeGroup_VaginalRepairs_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_VaginalRepairs_4 (Code)
VALUES
('P221'),
('P222'),
('P223'),
('P231'),
('P232'),
('P233'),
('P236'),
('P237');

-- -----------------------
-- Code Group: AbdominalHysterectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AbdominalHysterectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_AbdominalHysterectomy_4;

CREATE TABLE #CodeGroup_AbdominalHysterectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AbdominalHysterectomy_4 (Code)
VALUES
('Q071'),
('Q072'),
('Q073'),
('Q074'),
('Q075'),
('Q076'),
('Q078'),
('Q079');

-- -----------------------
-- Code Group: VaginalHysterectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_VaginalHysterectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_VaginalHysterectomy_4;

CREATE TABLE #CodeGroup_VaginalHysterectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_VaginalHysterectomy_4 (Code)
VALUES
('Q081'),
('Q082'),
('Q083'),
('Q088'),
('Q089');

-- -----------------------
-- Code Group: SuprapubicSling_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_SuprapubicSling_4') IS NOT NULL
    DROP TABLE #CodeGroup_SuprapubicSling_4;

CREATE TABLE #CodeGroup_SuprapubicSling_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_SuprapubicSling_4 (Code)
VALUES ('M521');

-- -----------------------
-- Code Group: Colposuspension_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Colposuspension_4') IS NOT NULL
    DROP TABLE #CodeGroup_Colposuspension_4;

CREATE TABLE #CodeGroup_Colposuspension_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Colposuspension_4 (Code)
VALUES ('M523');

-- -----------------------
-- Code Group: AutologousSling_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AutologousSling_4') IS NOT NULL
    DROP TABLE #CodeGroup_AutologousSling_4;

CREATE TABLE #CodeGroup_AutologousSling_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AutologousSling_4 (Code)
VALUES ('M528');

-- -----------------------
-- Code Group: HarvestOfFascia_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_HarvestOfFascia_4') IS NOT NULL
    DROP TABLE #CodeGroup_HarvestOfFascia_4;

CREATE TABLE #CodeGroup_HarvestOfFascia_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_HarvestOfFascia_4 (Code)
VALUES ('Y604'), ('Y608'), ('Y609');

-- -----------------------
-- Code Group: LeiomyomaOfUterus_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_LeiomyomaOfUterus_4') IS NOT NULL
    DROP TABLE #CodeGroup_LeiomyomaOfUterus_4;

CREATE TABLE #CodeGroup_LeiomyomaOfUterus_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_LeiomyomaOfUterus_4
(
    Code
)
VALUES
('D250'),
('D251'),
('D252'),
('D259');

-- -----------------------
-- Code Group: Myomectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Myomectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Myomectomy_4;

CREATE TABLE #CodeGroup_Myomectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Myomectomy_4
(
    Code
)
VALUES
('Q092');

-- -----------------------
-- Code Group: EndoscopicResectionUterus_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_EndoscopicResectionUterus_4') IS NOT NULL
    DROP TABLE #CodeGroup_EndoscopicResectionUterus_4;

CREATE TABLE #CodeGroup_EndoscopicResectionUterus_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EndoscopicResectionUterus_4
(
    Code
)
VALUES
('Q171');

-- -----------------------
-- Code Group: Hysteroscopic_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Hysteroscopic_4') IS NOT NULL
    DROP TABLE #CodeGroup_Hysteroscopic_4;

CREATE TABLE #CodeGroup_Hysteroscopic_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Hysteroscopic_4
(
    Code
)
VALUES
('Q171');

-- -----------------------
-- Code Group: ConversionToOpenApproach_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ConversionToOpenApproach_4') IS NOT NULL
    DROP TABLE #CodeGroup_ConversionToOpenApproach_4;

CREATE TABLE #CodeGroup_ConversionToOpenApproach_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ConversionToOpenApproach_4
(
    Code
)
VALUES
('Y714'),
('Y715');

-- ========================================
-- Step 4: Create and Populate #Spells_With_Variables Table
-- ========================================

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
    SpellDominantProcedure_Current VARCHAR(50),
    Diagnosis_Code_Primary VARCHAR(10),
	SpellHRG_Current VARCHAR(50),
    -- Additional Variables for Metrics
    Gynae_Proc_Hyster_Benign_IP VARCHAR(50),
    Gynae_Proc_Hyster_Cancer_IP VARCHAR(50),
    Gynae_AgeGroup_IP VARCHAR(10),
    Gynae_FLAG_Hysterectomy_Complic30 BIT
        DEFAULT 0,
    Read30 BIT
        DEFAULT 0,
    Read90 BIT
        DEFAULT 0,
    -- Additional Variables from Recipes
    Failed_MinAccess BIT
        DEFAULT 0,
    Removal_rate BIT
        DEFAULT 0,
    Procedure_Subgroup VARCHAR(100),
    Procedure_Main VARCHAR(100),
    Gynaec_Procedure VARCHAR(100),
    Gynae_Procedure VARCHAR(100),
    Approach_Subgroup VARCHAR(50),
    Gynae_Dominant_Procedure VARCHAR(50),
    Planned_Proc_not_Carried_Out_IP BIT
        DEFAULT 0,
    Gynae_ParaUrethralInjection_IP BIT
        DEFAULT 0,
    Gynae_Ovarian_Cyst_IP BIT
        DEFAULT 0,
    Gynae_Hysteroscopy_IP BIT
        DEFAULT 0,
    Gynae_InjectionBotox_IP BIT
        DEFAULT 0,
    Gynae_Cystoscopy_IP BIT
        DEFAULT 0,
    Gynae_Miscarriage_IP BIT
        DEFAULT 0,
    Gynae_Lymph_GynaeCancer_IP BIT
        DEFAULT 0,
    Gynae_Omen_GynaeCancer_IP BIT
        DEFAULT 0,
    Gynae_Ectopic_Pregnancy_IP BIT
        DEFAULT 0,
    Gynae_Cancel VARCHAR(50),
    Gynae_Attend VARCHAR(50),
    Gynae_MainSpef_OP BIT
        DEFAULT 0,
    Gynae_TretSpef_OP BIT
        DEFAULT 0,
    Gynae_TretSpef_IP BIT
        DEFAULT 0,
    Gynae_MainSpef_IP BIT
        DEFAULT 0,
    Gynae_Complications_of_Surgery_IP BIT
        DEFAULT 0,
    Gynae_CondBartholin_IP BIT
        DEFAULT 0,
    Gynae_Cond_IP VARCHAR(50),
    Gynae_Elective_Spell BIT
        DEFAULT 0,
    Gynae_IntraoperativeComplications BIT
        DEFAULT 0,
    Gynae_Proc_Ther_Endo BIT
        DEFAULT 0,
    Gynae_Proc_Vag_Prolapse BIT
        DEFAULT 0,
    Gynae_Hyster_GynaeCancer_IP BIT
        DEFAULT 0,
    Gynae_Cystoscopy_OP BIT
        DEFAULT 0,
    Gynae_Colposcopy_OP BIT
        DEFAULT 0,
    Gynae_InjectionBotox_OP BIT
        DEFAULT 0,
    Gynae_ParaUrethralInjection_OP BIT
        DEFAULT 0,
    Gynae_EndometrialAblation_OP BIT
        DEFAULT 0,
    Gynae_Hysteroscopy_OP BIT
        DEFAULT 0,
    Gynae_ProcBartholin_OP BIT
        DEFAULT 0,
    Gynae_Proc_Hysterectomy VARCHAR(50),
    Gynae_Proc_IP VARCHAR(50),
    Gynae_Colposcopy_IP BIT
        DEFAULT 0,
    Gynae_Procedure_OP VARCHAR(50),
		Gynae_ProcBartholin_IP BIT
        DEFAULT 0,
		Gynae_FLAG_UrethralInjection_ReOp2yrs BIT DEFAULT 0
);

-- **4.2: Populate the #Spells_With_Variables Table with Initial Data**

DECLARE @OverallStartDate DATE = '2018-01-01';
DECLARE @OverallEndDate DATE = '2024-09-30';

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
    Diagnosis_Code_Primary,
	SpellHRG_Current
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
       -- Derive POD_Derived
       CASE
           WHEN ips.National_POD IN ( 'DC', 'EL' ) THEN
               ips.National_POD
           WHEN ips.National_POD LIKE '%RA%' THEN
               'RA'
			WHEN ips.National_POD LIKE '%NE%' THEN 
			   'NE'
           WHEN ips.Admission_Sub_Type = 'EMR' THEN
               'EM'
           ELSE
               'Other'
       END AS POD_Derived,
       ips.PAS_Number,
       ips.Admission_Treatment_Function_Code AS TRETSPEF,
       ipe.Main_Specialty_Code AS MAINSPEF,
       ips.Spell_Dominant_Procedure_Code AS SpellDominantProcedure_Current,
       ips.Spell_Primary_Diagnosis_Code AS Diagnosis_Code_Primary,
	   ips.Spell_HRG_Code AS SpellHRG_Current
FROM [PAS_IP_Spell_Frozen] ips
    LEFT JOIN [PAS_IP_Episode_Frozen] ipe
        ON ips.Spell_Number = ipe.Spell_Number
           AND ips.Sector = ipe.Sector
WHERE ips.Admission_Date
      BETWEEN @OverallStartDate AND @OverallEndDate
      AND ips.Org_Code_Provider = 'RPA'
      AND ips.Sector = 'MED';

-- **4.3: Populate the #OP_Spells_With_Variables Table with Initial Data**

IF OBJECT_ID('tempdb..#OP_Spells_With_Variables') IS NOT NULL
    DROP TABLE #OP_Spells_With_Variables;

CREATE TABLE #OP_Spells_With_Variables
(
    -- Basic Appointment Information
    OP_Attendance_ID VARCHAR(50),
    Sector VARCHAR(10),
    PAS_Number VARCHAR(50),
    NHS_Number VARCHAR(50),
    Appointment_Date DATE,
    Age INT,
    MAINSPEF VARCHAR(10),
    TRETSPEF VARCHAR(10),
    Consultation_Type_Code VARCHAR(10),
    Clinic_Code VARCHAR(50),
    Attendance_Status_Code VARCHAR(10),
    -- Additional Variables for Metrics
    Gynae_Cystoscopy_OP BIT
        DEFAULT 0,
    Gynae_Colposcopy_OP BIT
        DEFAULT 0,
    Gynae_InjectionBotox_OP BIT
        DEFAULT 0,
    Gynae_ParaUrethralInjection_OP BIT
        DEFAULT 0,
    Gynae_EndometrialAblation_OP BIT
        DEFAULT 0,
    Gynae_Hysteroscopy_OP BIT
        DEFAULT 0,
    Gynae_ProcBartholin_OP BIT
        DEFAULT 0,
    Gynae_Procedure_OP VARCHAR(100),
    Gynae_MainSpef_OP BIT
        DEFAULT 0,
    Gynae_TretSpef_OP BIT
        DEFAULT 0
-- Add other outpatient variables as needed
);

DECLARE @OPStartDate DATE = '2018-01-01';
DECLARE @OPEndDate DATE = '2024-09-30';

INSERT INTO #OP_Spells_With_Variables
(
    OP_Attendance_ID,
    Sector,
    PAS_Number,
    NHS_Number,
    Appointment_Date,
    Age,
    MAINSPEF,
    TRETSPEF,
    Consultation_Type_Code,
    Clinic_Code,
	Attendance_Status_Code
)
SELECT
    ope.OP_Attendance_ID,
    ope.Sector,
    ope.PAS_Number,
    ope.NHS_Number,
    ope.Appointment_Date,
    DATEDIFF(YEAR, ope.Date_Of_Birth, ope.Appointment_Date) AS Age,
    ope.Main_Specialty_Code AS MAINSPEF,
    ope.Treatment_Function_Code AS TRETSPEF,
    ope.Consultation_Type_Code,
    ope.Clinic_Code,
	ope.Attendance_Status_Code
FROM
    PAS_OP_Appointment_Frozen ope
WHERE
    ope.Appointment_Date BETWEEN @OPStartDate AND @OPEndDate
    AND ope.Org_Code_Provider = 'RPA'
    AND ope.Sector = 'MED';

-- ========================================
-- Step 5: Update Columns and Flags
-- ========================================

-- **Assigning 'Gynae_Proc_Hyster_Benign_IP'**

-- Update for 'ProcHysterBenignAbdOpen'
UPDATE SWV
SET Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
	INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipd.Episode_Number = ipe.Episode_Number
           AND ipd.Sector = ipe.Sector
WHERE
    -- Procedure is Abdominal Hysterectomy (3-character codes)
    LEFT(ipp.Procedure_Code, 3)IN
    (
        SELECT Code FROM #CodeGroup_AbdominalHysterectomy_3
    )
    -- Diagnosis is NOT Cancer Hysterectomy Conditions
    AND LEFT(ipd.Diagnosis_Code, 3) NOT IN
        (
            SELECT Code FROM #CodeGroup_Cond_CancerHysterectomy_3
        )
    -- Procedure is NOT Minimal Access (3-character codes)
    AND LEFT(ipp.Procedure_Code, 3) NOT IN
        (
            SELECT Code FROM #CodeGroup_App_MinimalAccess_3
        );

-- **Update for 'ProcHysterBenignAbdMina' Using EXISTS**

UPDATE SWV
SET Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
WHERE
    -- Check for Abdominal Hysterectomy Procedure
    EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp1
    WHERE ipp1.Episode_Number = ipe.Episode_Number
          AND ipp1.Sector = ipe.Sector
          AND LEFT(ipp1.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AbdominalHysterectomy_3
              )
)
    -- Check for Minimal Access Procedure
    AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp2
    WHERE ipp2.Episode_Number = ipe.Episode_Number
          AND ipp2.Sector = ipe.Sector
          AND LEFT(ipp2.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_App_MinimalAccess_3
              )
)
    -- Exclude Cancer Diagnoses
    AND NOT EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = ipe.Episode_Number
          AND ipd.Sector = ipe.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Cond_CancerHysterectomy_3
              )
);

-- Update for 'ProcHysterBenignVag'
UPDATE SWV
SET Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
	 INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipd.Episode_Number = ipe.Episode_Number
           AND ipd.Sector = ipe.Sector
WHERE LEFT(ipp.Procedure_Code, 3)IN
      (
          SELECT Code FROM #CodeGroup_VaginalHysterectomy_3
      )
      AND LEFT(ipd.Diagnosis_Code, 3) NOT IN
          (
              SELECT Code FROM #CodeGroup_Cond_CancerHysterectomy_3
          );

-- **Update for 'ProcHysterCancerAbdOpen' Using EXISTS Clauses**

UPDATE SWV
SET Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdOpen'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON ipe.Spell_Number = SWV.Spell_Number
           AND ipe.Sector = SWV.Sector
WHERE
    -- **Check for Abdominal Hysterectomy Procedure**
    EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp1
    WHERE ipp1.Episode_Number = ipe.Episode_Number
          AND ipp1.Sector = ipe.Sector
          AND LEFT(ipp1.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AbdominalHysterectomy_3
              )
)
    -- **Check for Cancer Diagnosis**
    AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = ipe.Episode_Number
          AND ipd.Sector = ipe.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Cond_CancerHysterectomy_3
              )
)
    -- **And either:**
    AND
    (
        -- **Condition 1: No Minimal Access procedure code exists**
        NOT EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp2
    WHERE ipp2.Episode_Number = ipe.Episode_Number
          AND ipp2.Sector = ipe.Sector
          AND LEFT(ipp2.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_App_MinimalAccess_3
              )
)
        -- **OR Condition 2: Conversion procedure code exists**
        OR EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp3
    WHERE ipp3.Episode_Number = ipe.Episode_Number
          AND ipp3.Sector = ipe.Sector
          AND LEFT(ipp3.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_Conversion_4
              )
)
    );

-- **Update for 'ProcHysterCancerAbdMina' Using EXISTS Clauses**

UPDATE SWV
SET Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON ipe.Spell_Number = SWV.Spell_Number
           AND ipe.Sector = SWV.Sector
WHERE
    -- Check for Abdominal Hysterectomy Procedure
    EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp1
    WHERE ipp1.Episode_Number = ipe.Episode_Number
          AND ipp1.Sector = ipe.Sector
          AND LEFT(ipp1.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AbdominalHysterectomy_3
              )
)
    -- Check for Minimal Access Procedure
    AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp2
    WHERE ipp2.Episode_Number = ipe.Episode_Number
          AND ipp2.Sector = ipe.Sector
          AND LEFT(ipp2.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_App_MinimalAccess_3
              )
)
    -- Check for Cancer Diagnosis
    AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Diagnosis_Normalised] ipd
    WHERE ipd.Episode_Number = ipe.Episode_Number
          AND ipd.Sector = ipe.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Cond_CancerHysterectomy_3
              )
);

-- Update for 'ProcHysterCancerVag'
UPDATE SWV
SET Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerVag'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON ipe.Spell_Number = SWV.Spell_Number
           AND ipe.Sector = SWV.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipp.Episode_Number = ipe.Episode_Number
           AND ipp.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipd.Episode_Number = ipe.Episode_Number
           AND ipd.Sector = ipe.Sector
WHERE LEFT(ipp.Procedure_Code, 3)IN
      (
          SELECT Code FROM #CodeGroup_VaginalHysterectomy_3
      )
      AND LEFT(ipd.Diagnosis_Code, 3)IN
          (
              SELECT Code FROM #CodeGroup_Cond_CancerHysterectomy_3
          );

-- **Assigning 'Gynae_AgeGroup_IP'**

UPDATE SWV
SET Gynae_AgeGroup_IP = CASE
                            WHEN SWV.Age >= 50 THEN
                                'Age50+'
                            ELSE
                                'Age<50'
                        END
FROM #Spells_With_Variables SWV;

-- **Assigning 'Gynae_FLAG_Hysterectomy_Complic30'**

UPDATE SWV
SET Gynae_FLAG_Hysterectomy_Complic30 = 1
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
          AND ipe.Episode_Start_Date
          BETWEEN SWV.Admission_Date AND DATEADD(DAY, 30, SWV.Discharge_Date)
          AND ipd.Diagnosis_Code IN
              (
                  SELECT Code FROM #CodeGroup_Complications
              )
);


-- **Assigning 'Failed_MinAccess' Flag**

UPDATE SWV
SET Failed_MinAccess = 1
FROM #Spells_With_Variables SWV
WHERE EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_App_Conversion_4
              )
);

-- **Assigning 'Removal_rate' Flag**

UPDATE SWV
SET Removal_rate = 1
FROM #Spells_With_Variables SWV
WHERE (
          EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_RemovalVaginalMesh_4
          )
)
          OR EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_RemovalVaginalMeshProlapse_4
          )
)
          OR
          (
              (
                  EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_OtherCombinedAbdVagSupportBladder_4
          )
)
                  OR EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_OtherRepairProlapse_4
          )
)
              )
              AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Episode_Frozen] ipe
        INNER JOIN [PAS_IP_Procedure_Normalised] ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_RemovalProsthesisOrganNOC_4
          )
)
          )
      );

-- Update Read30 flag
UPDATE SWV
SET Read30 = 1
FROM #Spells_With_Variables SWV
    LEFT JOIN [M0026_Readmissions] ram
        ON SWV.Spell_Number = ram.Parent_Spell_Number
           AND SWV.Sector = ram.Parent_Sector_Code
WHERE ram.M0026b_Readmission_Numerator_Less_30_Day = 1;

-- Update Read90 flag
UPDATE SWV
SET Read90 = 1
FROM #Spells_With_Variables SWV
    LEFT JOIN [M0026_Readmissions] ram
        ON SWV.Spell_Number = ram.Parent_Spell_Number
           AND SWV.Sector = ram.Parent_Sector_Code
WHERE ram.M0026n_Readmission_Numerator_Less_90_Day = 1;


-- **Procedure_Main Update Statement**

UPDATE SWV
SET Procedure_Main = CASE
                         -- **Priority 1: 'Colposuspension | age 17+ | elective'**
                         WHEN
                         (
                             -- Procedure Code Condition
                             EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp_colpo
                                 WHERE ipp_colpo.Episode_Number = ipe.Episode_Number
                                       AND ipp_colpo.Sector = ipe.Sector
                                       AND LEFT(ipp_colpo.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Colposuspension_4
                                           )
                             )
                             -- Age Condition
                             AND SWV.Age >= 17
                             -- Only update if higher priority or Procedure_Main is NULL
                             AND
                             (
                                 SWV.Procedure_Main IS NULL
                                 OR SWV.Procedure_Main IN ( 'Autologous fascia sling | age 17+ | elective',
                                                            'Vaginal prolapse procedures | age 17+ | elective',
                                                            'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective',
                                                            'Insertion of transobturator tape (TOT) only | age 17+ | elective',
                                                            'Myomectomy | age 17+ | elective'
                                                          )
                             )
                         ) THEN
                             'Colposuspension | age 17+ | elective'

                         -- **Priority 2: 'Autologous fascia sling | age 17+ | elective'**
                         WHEN
                         (
                             -- Procedure Code Conditions
                             (
                                 -- Suprapubic Sling
                                 EXISTS
                                 (
                                     SELECT 1
                                     FROM [PAS_IP_Procedure_Normalised] ipp_suprapubic
                                     WHERE ipp_suprapubic.Episode_Number = ipe.Episode_Number
                                           AND ipp_suprapubic.Sector = ipe.Sector
                                           AND LEFT(ipp_suprapubic.Procedure_Code, 4)IN
                                               (
                                                   SELECT Code FROM #CodeGroup_SuprapubicSling_4
                                               )
                                 )
                                 OR
                                 -- Autologous Sling AND Harvest of Fascia
                                 (
                                     EXISTS
                                     (
                                         SELECT 1
                                         FROM [PAS_IP_Procedure_Normalised] ipp_autologous
                                         WHERE ipp_autologous.Episode_Number = ipe.Episode_Number
                                               AND ipp_autologous.Sector = ipe.Sector
                                               AND LEFT(ipp_autologous.Procedure_Code, 4)IN
                                                   (
                                                       SELECT Code FROM #CodeGroup_AutologousSling_4
                                                   )
                                     )
                                     AND EXISTS
                                         (
                                             SELECT 1
                                             FROM [PAS_IP_Procedure_Normalised] ipp_harvest
                                             WHERE ipp_harvest.Episode_Number = ipe.Episode_Number
                                                   AND ipp_harvest.Sector = ipe.Sector
                                                   AND LEFT(ipp_harvest.Procedure_Code, 4)IN
                                                       (
                                                           SELECT Code FROM #CodeGroup_HarvestOfFascia_4
                                                       )
                                         )
                                 )
                             )
                             -- Age Condition
                             AND SWV.Age >= 17
                             -- Only update if higher priority or Procedure_Main is NULL
                             AND
                             (
                                 SWV.Procedure_Main IS NULL
                                 OR SWV.Procedure_Main IN ( 'Vaginal prolapse procedures | age 17+ | elective',
                                                            'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective',
                                                            'Insertion of transobturator tape (TOT) only | age 17+ | elective',
                                                            'Myomectomy | age 17+ | elective'
                                                          )
                             )
                         ) THEN
                             'Autologous fascia sling | age 17+ | elective'

                         -- **Priority 3: 'Vaginal prolapse procedures | age 17+ | elective'**
                         WHEN
                         (
                             -- Existing Conditions
                             (
                                 -- Procedure Codes
                                 (
                                     LEFT(ipp.Procedure_Code, 4)IN
                                     (
                                         SELECT Code FROM #CodeGroup_VaginalRepairs_4
                                     )
                                     OR LEFT(ipp.Procedure_Code, 4)IN
                                        (
                                            SELECT Code FROM #CodeGroup_VaginalHysterectomy_4
                                        )
                                 )
                                 -- Diagnosis Codes
                                 AND
                                 (
                                     LEFT(ipd.Diagnosis_Code, 3)IN
                                     (
                                         SELECT Code FROM #CodeGroup_Prolapse_3
                                     )
                                     OR LEFT(ipd.Diagnosis_Code, 4)IN
                                        (
                                            SELECT Code FROM #CodeGroup_ProlapseVagVaultHyst_4
                                        )
                                 )
                                 -- Exclusions
                                 AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                     (
                                         SELECT Code FROM #CodeGroup_IntroductionTVT_4
                                     )
                                 AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                     (
                                         SELECT Code FROM #CodeGroup_IntroductionTOT_4
                                     )
                                 AND LEFT(ipp.Procedure_Code, 3) NOT IN
                                     (
                                         SELECT Code FROM #CodeGroup_AbdominalHysterectomy_3
                                     )
                                 -- Age and POD Conditions
                                 AND SWV.Age >= 17
                                 AND SWV.POD_Derived IN ( 'EL', 'DC' )
                             )
                             -- Only update if higher priority or Procedure_Main is NULL
                             AND
                             (
                                 SWV.Procedure_Main IS NULL
                                 OR SWV.Procedure_Main IN ( 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective',
                                                            'Insertion of transobturator tape (TOT) only | age 17+ | elective',
                                                            'Myomectomy | age 17+ | elective'
                                                          )
                             )
                         ) THEN
                             'Vaginal prolapse procedures | age 17+ | elective'

                         -- **Priority 4: 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective'**
                         WHEN
                         (
                             -- Existing Conditions
                             LEFT(ipp.Procedure_Code, 4)IN
                             (
                                 SELECT Code FROM #CodeGroup_IntroductionTVT_4
                             )
                             AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                 (
                                     SELECT Code FROM #CodeGroup_IntroductionTOT_4
                                 )
                             AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                 (
                                     SELECT Code FROM #CodeGroup_VaginalHysterectomy_4
                                 )
                             AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                 (
                                     SELECT Code FROM #CodeGroup_AbdominalHysterectomy_4
                                 )
                             AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                 (
                                     SELECT Code FROM #CodeGroup_VaginalRepairs_4
                                 )
                             -- Diagnosis Codes
                             AND
                             (
                                 LEFT(ipd.Diagnosis_Code, 4)IN
                                 (
                                     SELECT Code FROM #CodeGroup_UrinaryIncontinence_4
                                 )
                                 OR LEFT(ipd.Diagnosis_Code, 3)IN
                                    (
                                        SELECT Code FROM #CodeGroup_UnspecifiedUrinaryIncontinence_3
                                    )
                             )
                             -- Age and POD Conditions
                             AND SWV.Age >= 17
                             AND SWV.POD_Derived IN ( 'EL', 'DC' )
                             -- Only update if Procedure_Main is NULL or has lower priority
                             AND
                             (
                                 SWV.Procedure_Main IS NULL
                                 OR SWV.Procedure_Main IN ( 'Insertion of transobturator tape (TOT) only | age 17+ | elective',
                                                            'Myomectomy | age 17+ | elective'
                                                          )
                             )
                         ) THEN
                             'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective'

                         -- **Priority 5: 'Insertion of transobturator tape (TOT) only | age 17+ | elective'**
                         WHEN
                         (
                             -- Existing Conditions
                             LEFT(ipp.Procedure_Code, 4)IN
                             (
                                 SELECT Code FROM #CodeGroup_IntroductionTOT_4
                             )
                             AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                 (
                                     SELECT Code FROM #CodeGroup_IntroductionTVT_4
                                 )
                             AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                 (
                                     SELECT Code FROM #CodeGroup_VaginalHysterectomy_4
                                 )
                             AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                 (
                                     SELECT Code FROM #CodeGroup_AbdominalHysterectomy_4
                                 )
                             AND LEFT(ipp.Procedure_Code, 4) NOT IN
                                 (
                                     SELECT Code FROM #CodeGroup_VaginalRepairs_4
                                 )
                             -- Diagnosis Codes
                             AND
                             (
                                 LEFT(ipd.Diagnosis_Code, 4)IN
                                 (
                                     SELECT Code FROM #CodeGroup_UrinaryIncontinence_4
                                 )
                                 OR LEFT(ipd.Diagnosis_Code, 3)IN
                                    (
                                        SELECT Code FROM #CodeGroup_UnspecifiedUrinaryIncontinence_3
                                    )
                             )
                             -- Age and POD Conditions
                             AND SWV.Age >= 17
                             AND SWV.POD_Derived IN ( 'EL', 'DC' )
                             -- Only update if Procedure_Main is NULL
                             AND
                             (
                                 SWV.Procedure_Main IS NULL
                                 OR SWV.Procedure_Main = 'Myomectomy | age 17+ | elective'
                             )
                         ) THEN
                             'Insertion of transobturator tape (TOT) only | age 17+ | elective'

                         -- **Priority 6: 'Myomectomy | age 17+ | elective'**
                         WHEN
                         (
                             (
                                 -- Condition 1: Myomectomy procedure and Leiomyoma diagnosis
                                 EXISTS
                                 (
                                     SELECT 1
                                     FROM [PAS_IP_Procedure_Normalised] ipp_myomectomy
                                     WHERE ipp_myomectomy.Episode_Number = ipe.Episode_Number
                                           AND ipp_myomectomy.Sector = ipe.Sector
                                           AND LEFT(ipp_myomectomy.Procedure_Code, 4)IN
                                               (
                                                   SELECT Code FROM #CodeGroup_Myomectomy_4
                                               )
                                 )
                                 AND EXISTS
                                     (
                                         SELECT 1
                                         FROM [PAS_IP_Diagnosis_Normalised] ipd_leiomyoma
                                         WHERE ipd_leiomyoma.Episode_Number = ipe.Episode_Number
                                               AND ipd_leiomyoma.Sector = ipe.Sector
                                               AND LEFT(ipd_leiomyoma.Diagnosis_Code, 4)IN
                                                   (
                                                       SELECT Code FROM #CodeGroup_LeiomyomaOfUterus_4
                                                   )
                                     )
                             )
                             OR (
                                    -- Condition 2: Endoscopic resection procedure and Leiomyoma diagnosis
                                    EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp_endoscopic
                                        WHERE ipp_endoscopic.Episode_Number = ipe.Episode_Number
                                              AND ipp_endoscopic.Sector = ipe.Sector
                                              AND LEFT(ipp_endoscopic.Procedure_Code, 4)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_EndoscopicResectionUterus_4
                                                  )
                                    )
                                    AND EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Diagnosis_Normalised] ipd_leiomyoma
                                            WHERE ipd_leiomyoma.Episode_Number = ipe.Episode_Number
                                                  AND ipd_leiomyoma.Sector = ipe.Sector
                                                  AND LEFT(ipd_leiomyoma.Diagnosis_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_LeiomyomaOfUterus_4
                                                      )
                                        )
                                )
                                -- Age Condition
                                AND SWV.Age >= 17
                                -- Only update if Procedure_Main is NULL
                                AND SWV.Procedure_Main IS NULL
                         ) THEN
                             'Myomectomy | age 17+ | elective'
                         ELSE
                             SWV.Procedure_Main
                     END
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipe.Episode_Number = ipd.Episode_Number
           AND ipe.Sector = ipd.Sector;

-- **Assigning 'Gynaec_Procedure' = 'Vaginal hysterectomy (including laparoscopically assisted)'**

UPDATE SWV
SET Gynaec_Procedure = 'Vaginal hysterectomy (including laparoscopically assisted)'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON ipe.Spell_Number = SWV.Spell_Number
           AND ipe.Sector = SWV.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipp.Episode_Number = ipe.Episode_Number
           AND ipp.Sector = ipe.Sector
WHERE LEFT(ipp.Procedure_Code, 3)IN
      (
          SELECT Code FROM #CodeGroup_VaginalHysterectomy_3
      )
      AND SWV.Age >= 17
      AND SWV.POD_Derived IN ( 'EL', 'DC' );

-- **Assigning 'Procedure_Subgroup' = 'Vaginal repair'**

UPDATE SWV
SET Procedure_Subgroup = 'Vaginal repair'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON ipe.Spell_Number = SWV.Spell_Number
           AND ipe.Sector = SWV.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipp.Episode_Number = ipe.Episode_Number
           AND ipp.Sector = ipe.Sector
WHERE SWV.Procedure_Main = 'Vaginal prolapse procedures | age 17+ | elective'
      AND LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_VaginalRepairs_4
          )
      AND LEFT(ipp.Procedure_Code, 4) NOT IN
          (
              SELECT Code FROM #CodeGroup_VaginalHysterectomy_4
          );

UPDATE SWV
SET Approach_Subgroup = CASE
                            -- **Assign 'Robotic' Approach_Subgroup**
                            WHEN
                            (
                                -- Procedure_Main Condition
                                SWV.Procedure_Main IN ( 'General surgery procedures performed via robotic approach',
                                                        'Gynaecology procedures performed via robotic approach',
                                                        'OMF procedures performed via robotic approach',
                                                        'Paediatrics procedures performed via robotic approach',
                                                        'Urology procedures performed via robotic approach'
                                                      )
                                -- Procedure_Code Condition
                                AND EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp_rob
                                        WHERE ipp_rob.Episode_Number = ipe.Episode_Number
                                              AND ipp_rob.Sector = ipe.Sector
                                              AND LEFT(ipp_rob.Procedure_Code, 4)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_RoboticApproach_4
                                                  )
                                    )
                                -- Exclusion Condition
                                AND NOT EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp_conv
                                            WHERE ipp_conv.Episode_Number = ipe.Episode_Number
                                                  AND ipp_conv.Sector = ipe.Sector
                                                  AND LEFT(ipp_conv.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_ConversionToOpenApproach_4
                                                      )
                                        )
                            ) THEN
                                'Robotic'

                                                      -- **Assign 'Hysteroscopic' Approach_Subgroup**
                            WHEN
                            (
                                -- Procedure_Main Condition
                                SWV.Procedure_Main = 'Gynaecology procedures performed via hysteroscopic approach'
                                -- Procedure_Code Condition
                                AND EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp_hyst
                                        WHERE ipp_hyst.Episode_Number = ipe.Episode_Number
                                              AND ipp_hyst.Sector = ipe.Sector
                                              AND LEFT(ipp_hyst.Procedure_Code, 4)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_Hysteroscopic_4
                                                  )
                                    )
                                -- Exclusion Condition
                                AND NOT EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp_conv_hyst
                                            WHERE ipp_conv_hyst.Episode_Number = ipe.Episode_Number
                                                  AND ipp_conv_hyst.Sector = ipe.Sector
                                                  AND LEFT(ipp_conv_hyst.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_ConversionToOpenApproach_4
                                                      )
                                        )
                                -- Age Condition
                                AND SWV.Age >= 17
                                -- POD_Derived Condition
                                AND SWV.POD_Derived IN ( 'EL', 'DC' )
                                -- Procedure_Main Priority Condition
                                AND
                                (
                                    SWV.Procedure_Main IS NULL
                                    OR SWV.Procedure_Main IN ( 'Insertion of transobturator tape (TOT) only | age 17+ | elective',
                                                               'Myomectomy | age 17+ | elective'
                                                             )
                                )
                            ) THEN
                                'Hysteroscopic'
                            ELSE
                                SWV.Approach_Subgroup -- Retain existing value if no conditions met
                        END
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON ipe.Spell_Number = SWV.Spell_Number
           AND ipe.Sector = SWV.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipe.Episode_Number = ipd.Episode_Number
           AND ipe.Sector = ipd.Sector;

-- **Assigning 'Gynae_Dominant_Procedure'**
UPDATE SWV
SET Gynae_Dominant_Procedure = CASE
                                   WHEN ISNULL(SWV.SpellDominantProcedure_Current, 'Other') = 'Other' THEN
                                       'NoProc'
                                   ELSE
                                       'Proc'
                               END
FROM #Spells_With_Variables SWV;

-- **Assigning 'Planned_Proc_not_Carried_Out_IP'**

UPDATE SWV
SET Planned_Proc_not_Carried_Out_IP = 1
FROM #Spells_With_Variables SWV
WHERE SWV.SpellHRG_Current LIKE 'WH50%';

-- **Assigning 'Gynae_ParaUrethralInjection_IP'**

UPDATE SWV
SET Gynae_ParaUrethralInjection_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT DISTINCT
               ipe.Spell_Number,
               ipe.Sector
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
                ON ipe.Episode_Number = ipd.Episode_Number
                   AND ipe.Sector = ipd.Sector
            INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                ON ipe.Episode_Number = ipp.Episode_Number
                   AND ipe.Sector = ipp.Sector
        WHERE LEFT(ipp.Procedure_Code, 4)IN
                  (
                      SELECT Code FROM #CodeGroup_UrethralInjection_InertSubstance_4
                  )
              AND
              (
                  LEFT(ipd.Diagnosis_Code, 3)IN
                  (
                      SELECT Code FROM #CodeGroup_Cond_Incontinence_3
                  )
                  OR LEFT(ipd.Diagnosis_Code, 4)IN
                     (
                         SELECT Code FROM #CodeGroup_Cond_Incontinence_4
                     )
              )
    ) AS Temp
        ON SWV.Spell_Number = Temp.Spell_Number
           AND SWV.Sector = Temp.Sector;

-- **Assigning 'Gynae_Ovarian_Cyst_IP'**

UPDATE SWV
SET Gynae_Ovarian_Cyst_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT DISTINCT
               ipe.Spell_Number,
               ipe.Sector
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
                ON ipe.Episode_Number = ipd.Episode_Number
                   AND ipe.Sector = ipd.Sector
        WHERE LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Cond_OvarianCyst_4
              )
    ) AS Temp
        ON SWV.Spell_Number = Temp.Spell_Number
           AND SWV.Sector = Temp.Sector;

-- **Assigning 'Gynae_Hysteroscopy_IP'**

UPDATE SWV
SET Gynae_Hysteroscopy_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT DISTINCT
               ipe.Spell_Number,
               ipe.Sector
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                ON ipe.Episode_Number = ipp.Episode_Number
                   AND ipe.Sector = ipp.Sector
        WHERE LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Hysteroscopy_3
              )
              AND LEFT(ipp.Procedure_Code, 4) NOT IN
                  (
                      SELECT Code FROM #CodeGroup_DyeTestFallopian_4
                  )
              AND LEFT(ipp.Procedure_Code, 4) NOT IN
                  (
                      SELECT Code FROM #CodeGroup_Qual_ExclLapHyster_4
                  )
    ) AS Temp
        ON SWV.Spell_Number = Temp.Spell_Number
           AND SWV.Sector = Temp.Sector;

-- **Assigning 'Gynae_InjectionBotox_IP'**

UPDATE SWV
SET Gynae_InjectionBotox_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT DISTINCT
               ipe.Spell_Number,
               ipe.Sector
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                ON ipe.Episode_Number = ipp.Episode_Number
                   AND ipe.Sector = ipp.Sector
            INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
                ON ipe.Episode_Number = ipd.Episode_Number
                   AND ipe.Sector = ipd.Sector
        WHERE (
                  LEFT(ipd.Diagnosis_Code, 3)IN
                  (
                      SELECT Code FROM #CodeGroup_Cond_Incontinence_3
                  )
                  OR LEFT(ipd.Diagnosis_Code, 4)IN
                     (
                         SELECT Code FROM #CodeGroup_Cond_Incontinence_4
                     )
                  OR LEFT(ipd.Diagnosis_Code, 3)IN
                     (
                         SELECT Code FROM #CodeGroup_Neurogenicbladder_3
                     )
              )
              AND
              (
                  (LEFT(ipp.Procedure_Code, 4)IN
                   (
                       SELECT Code FROM #CodeGroup_InjectionBotox_4A
                   )
                  )
                  OR
                  (
                      LEFT(ipp.Procedure_Code, 4)IN
                      (
                          SELECT Code FROM #CodeGroup_InjectionBotox_4B
                      )
                      AND LEFT(ipp.Procedure_Code, 4)IN
                          (
                              SELECT Code FROM #CodeGroup_App_BotoxDrug_4
                          )
                  )
              )
    ) AS Temp
        ON SWV.Spell_Number = Temp.Spell_Number
           AND SWV.Sector = Temp.Sector;

-- **Assigning 'Gynae_Cystoscopy_IP'**

UPDATE SWV
SET Gynae_Cystoscopy_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT DISTINCT
               ipe.Spell_Number,
               ipe.Sector
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                ON ipe.Episode_Number = ipp.Episode_Number
                   AND ipe.Sector = ipp.Sector
        WHERE LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Cystoscopy_4
              )
              AND LEFT(ipp.Procedure_Code, 4) NOT IN
                  (
                      SELECT Code FROM #CodeGroup_InjectionBotox_4
                  )
    ) AS Temp
        ON SWV.Spell_Number = Temp.Spell_Number
           AND SWV.Sector = Temp.Sector;

-- **Assigning 'Gynae_Miscarriage_IP'**

UPDATE SWV
SET Gynae_Miscarriage_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT DISTINCT
               ipe.Spell_Number,
               ipe.Sector
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
                ON ipe.Episode_Number = ipd.Episode_Number
                   AND ipe.Sector = ipd.Sector
        WHERE LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Cond_Miscarriage_3
              )
    ) AS Temp
        ON SWV.Spell_Number = Temp.Spell_Number
           AND SWV.Sector = Temp.Sector;

-- **Assigning 'Gynae_Lymph_GynaeCancer_IP'**

UPDATE SWV
SET Gynae_Lymph_GynaeCancer_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT DISTINCT
               ipe.Spell_Number,
               ipe.Sector
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                ON ipe.Episode_Number = ipp.Episode_Number
                   AND ipe.Sector = ipp.Sector
        WHERE LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_BlockDissectionLymphNodes_3
              )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_ExcisionBiopsyLymphNode_3
                 )
    ) AS Temp
        ON SWV.Spell_Number = Temp.Spell_Number
           AND SWV.Sector = Temp.Sector;

-- **Assigning 'Gynae_Omen_GynaeCancer_IP'**

UPDATE SWV
SET Gynae_Omen_GynaeCancer_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT DISTINCT
               ipe.Spell_Number,
               ipe.Sector
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Procedure_Normalised] ipp
                ON ipe.Episode_Number = ipp.Episode_Number
                   AND ipe.Sector = ipp.Sector
        WHERE LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Omentectomy_4
              )
    ) AS Temp
        ON SWV.Spell_Number = Temp.Spell_Number
           AND SWV.Sector = Temp.Sector;

-- **Assigning 'Gynae_Ectopic_Pregnancy_IP'**

UPDATE SWV
SET Gynae_Ectopic_Pregnancy_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN
    (
        SELECT DISTINCT
               ipe.Spell_Number,
               ipe.Sector
        FROM [PAS_IP_Episode_Frozen] ipe
            INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
                ON ipe.Episode_Number = ipd.Episode_Number
                   AND ipe.Sector = ipd.Sector
        WHERE LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Cond_EptopicPregnancy_3
              )
    ) AS Temp
        ON SWV.Spell_Number = Temp.Spell_Number
           AND SWV.Sector = Temp.Sector;

-- **Assigning 'Gynae_Cancel'**

-- Set to 'Clinical_Reason' if diagnosis code matches
UPDATE SWV
SET Gynae_Cancel = 'Clinical_Reason'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipe.Episode_Number = ipd.Episode_Number
           AND ipe.Sector = ipd.Sector
WHERE LEFT(ipd.Diagnosis_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_CancelClinical_4
      );

-- Set to 'NonClinical_Reason' if diagnosis code matches
UPDATE SWV
SET Gynae_Cancel = 'NonClinical_Reason'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipe.Episode_Number = ipd.Episode_Number
           AND ipe.Sector = ipd.Sector
WHERE LEFT(ipd.Diagnosis_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_CancelNonClinical_4
      );

-- -----------------------
-- Assigning 'Gynae_FLAG_UrethralInjection_ReOp2yrs'
-- -----------------------

UPDATE SWV
SET Gynae_FLAG_UrethralInjection_ReOp2yrs = 1
FROM #Spells_With_Variables SWV
WHERE
    -- Initial Spell Conditions
    (
        SWV.Gynae_ParaUrethralInjection_OP = 1
        OR SWV.Gynae_ParaUrethralInjection_IP = 1
    )
    AND NOT EXISTS
(
    SELECT 1
    FROM [PAS_IP_Spell_Frozen] ips
    WHERE ips.Spell_Number = SWV.Spell_Number
          AND ips.Sector = SWV.Sector
          AND ips.Method_Of_Discharge_Code IN ( '4', '5' ) -- In-hospital death codes
)
    -- Reoperation Conditions
    AND EXISTS
(
    SELECT 1
    FROM #Spells_With_Variables SWV_ReOp
        INNER JOIN [PAS_IP_Episode_Frozen] ipe_ReOp
            ON SWV_ReOp.Spell_Number = ipe_ReOp.Spell_Number
               AND SWV_ReOp.Sector = ipe_ReOp.Sector
    WHERE
        -- Same Patient
        SWV_ReOp.PAS_Number = SWV.PAS_Number
        -- Different Spell
        AND SWV_ReOp.Spell_Number <> SWV.Spell_Number
        -- Admission Date within 2 years of initial spell
        AND ipe_ReOp.Episode_Start_Date
        BETWEEN SWV.Admission_Date AND DATEADD(YEAR, 2, SWV.Admission_Date)
        -- Reoperation includes paraurethral injection
        AND
        (
            SWV_ReOp.Gynae_ParaUrethralInjection_OP = 1
            OR SWV_ReOp.Gynae_ParaUrethralInjection_IP = 1
        )
);

-- **Assigning 'Gynae_MainSpef_OP'**

UPDATE OPV
SET Gynae_MainSpef_OP = 1
FROM #OP_Spells_With_Variables OPV
WHERE OPV.MAINSPEF IN
      (
          SELECT Code FROM #CodeGroup_MAINSPEF_1
      );

-- **Assigning 'Gynae_TretSpef_OP'**

UPDATE OPV
SET Gynae_TretSpef_OP = 1
FROM #OP_Spells_With_Variables OPV
WHERE OPV.TRETSPEF IN
      (
          SELECT Code FROM #CodeGroup_TRETSPEF_1
      );

-- **Assigning 'Gynae_MainSpef_IP'**

UPDATE SWV
SET Gynae_MainSpef_IP = 1
FROM #Spells_With_Variables SWV
WHERE SWV.MAINSPEF IN
      (
          SELECT Code FROM #CodeGroup_MAINSPEF_1
      );

-- **Assigning 'Gynae_Complications_of_Surgery_IP'**

UPDATE SWV
SET Gynae_Complications_of_Surgery_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipe.Episode_Number = ipd.Episode_Number
           AND ipe.Sector = ipd.Sector
WHERE LEFT(ipd.Diagnosis_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_Complications_Surgery_4
      );

-- **Assigning 'Gynae_CondBartholin_IP'**

UPDATE SWV
SET Gynae_CondBartholin_IP = 1
FROM #Spells_With_Variables SWV
       INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipe.Episode_Number = ipd.Episode_Number
           AND ipe.Sector = ipd.Sector
WHERE LEFT(ipd.Diagnosis_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_Cond_Bartholin_4
      );

-- **Assigning 'Gynae_Cond_IP'**

-- Assign 'CondOvarianCyst'
UPDATE SWV
SET Gynae_Cond_IP = 'CondOvarianCyst'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipe.Episode_Number = ipd.Episode_Number
           AND ipe.Sector = ipd.Sector
WHERE LEFT(ipd.Diagnosis_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_Cond_OvarianCyst_4
      )
      OR
      (
          LEFT(ipd.Diagnosis_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_Cond_OvarianCyst_4
          )
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Pregnancy_4
              )
      )
      OR
      (
          LEFT(ipd.Diagnosis_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_Cond_OvarianCyst_4
          )
          AND LEFT(ipd.Diagnosis_Code, 1)IN
              (
                  SELECT Code FROM #CodeGroup_GynaeChapter_1
              )
      );

-- Assign 'CondMiscarriage'
UPDATE SWV
SET Gynae_Cond_IP = 'CondMiscarriage'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipe.Episode_Number = ipd.Episode_Number
           AND ipe.Sector = ipd.Sector
WHERE LEFT(ipd.Diagnosis_Code, 3)IN
      (
          SELECT Code FROM #CodeGroup_Cond_Miscarriage_3
      );

-- Assign 'CondEctopic'
UPDATE SWV
SET Gynae_Cond_IP = 'CondEctopic'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipe.Episode_Number = ipd.Episode_Number
           AND ipe.Sector = ipd.Sector
WHERE LEFT(ipd.Diagnosis_Code, 3)IN
      (
          SELECT Code FROM #CodeGroup_Cond_EptopicPregnancy_3
      );

-- **Assigning 'Gynae_Elective_Spell'**

UPDATE SWV
SET Gynae_Elective_Spell = 1
FROM #Spells_With_Variables SWV
WHERE SWV.MAINSPEF IN
      (
          SELECT Code FROM #CodeGroup_MAINSPEF_1
      );

-- **Assigning 'Gynae_Proc_Ther_Endo'**

UPDATE SWV
SET Gynae_Proc_Ther_Endo = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
WHERE LEFT(ipp.Procedure_Code, 3)IN
      (
          SELECT Code FROM #CodeGroup_TherapeuticEndoscopicUterus_3
      );

-- **Assigning 'Gynae_Proc_Vag_Prolapse'**

UPDATE SWV
SET Gynae_Proc_Vag_Prolapse = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
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
          LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_VaginalRepairs_4
          )
          OR LEFT(ipp.Procedure_Code, 3)IN
             (
                 SELECT Code FROM #CodeGroup_VaginalHysterectomy_3
             )
      )
      AND
      (
          LEFT(ipd.Diagnosis_Code, 3)IN
          (
              SELECT Code FROM #CodeGroup_Prolapse_3
          )
          OR LEFT(ipd.Diagnosis_Code, 4)IN
             (
                 SELECT Code FROM #CodeGroup_ProlapseVagVaultHyst_4
             )
      )
      AND LEFT(ipp.Procedure_Code, 4) NOT IN
          (
              SELECT Code FROM #CodeGroup_IntroductionTVT_4
          )
      AND LEFT(ipp.Procedure_Code, 4) NOT IN
          (
              SELECT Code FROM #CodeGroup_IntroductionTOT_4
          )
      AND LEFT(ipp.Procedure_Code, 3) NOT IN
          (
              SELECT Code FROM #CodeGroup_AbdominalHysterectomy_3
          );

-- **Assigning 'Gynae_Hyster_GynaeCancer_IP'**

UPDATE SWV
SET Gynae_Hyster_GynaeCancer_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
WHERE ipe.Spell_Number = SWV.Spell_Number
      AND ipe.Sector = SWV.Sector
      AND
      (
          LEFT(ipp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_AbdominalHysterectomy_4
          )
          OR LEFT(ipp.Procedure_Code, 4)IN
             (
                 SELECT Code FROM #CodeGroup_VaginalHysterectomy_4
             )
      );

-- **Assigning 'Gynae_ProcBartholin_IP'**

UPDATE SWV
SET Gynae_ProcBartholin_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
WHERE LEFT(ipp.Procedure_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_ProcBartholin_4
      );

-- **Assigning 'Gynae_Colposcopy_IP'**

UPDATE SWV
SET Gynae_Colposcopy_IP = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
WHERE LEFT(ipp.Procedure_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_Colposcopy_4
      );


-- **Assigning 'Gynae_Cystoscopy_OP'**
UPDATE OPV
SET Gynae_Cystoscopy_OP = 1
FROM #OP_Spells_With_Variables OPV
    INNER JOIN [PAS_OP_Procedure_Normalised] opp
        ON OPV.OP_Attendance_ID = opp.OP_Attendance_ID
           AND OPV.Sector = opp.Sector
WHERE LEFT(opp.Procedure_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_Cystoscopy_4
      )
      AND LEFT(opp.Procedure_Code, 4) NOT IN
          (
              SELECT Code FROM #CodeGroup_InjectionBotox_4
          );


-- **Assigning 'Gynae_Colposcopy_OP'**

UPDATE OPV
SET Gynae_Colposcopy_OP = 1
FROM #OP_Spells_With_Variables OPV
    INNER JOIN [PAS_OP_Procedure_Normalised] opp
        ON OPV.OP_Attendance_ID = opp.OP_Attendance_ID
           AND OPV.Sector = opp.Sector
WHERE LEFT(opp.Procedure_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_Colposcopy_4
      );

-- **Assigning 'Gynae_InjectionBotox_OP'**

UPDATE OPV
SET Gynae_InjectionBotox_OP = 1
FROM #OP_Spells_With_Variables OPV
    INNER JOIN [PAS_OP_Procedure_Normalised] opp
        ON OPV.OP_Attendance_ID = opp.OP_Attendance_ID
           AND OPV.Sector = opp.Sector
WHERE OPV.MAINSPEF IN
      (
          SELECT Code FROM #CodeGroup_MAINSPEF_1
      )
      AND
      (
          LEFT(opp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_InjectionBotox_4A
          )
          OR
          (
              LEFT(opp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_InjectionBotox_4B
              )
              AND LEFT(opp.Procedure_Code, 4)IN
                  (
                      SELECT Code FROM #CodeGroup_App_BotoxDrug_4
                  )
          )
      );

-- **Assigning 'Gynae_ParaUrethralInjection_OP'**

UPDATE OPV
SET Gynae_ParaUrethralInjection_OP = 1
FROM #OP_Spells_With_Variables OPV
    INNER JOIN [PAS_OP_Procedure_Normalised] opp
        ON OPV.OP_Attendance_ID = opp.OP_Attendance_ID
           AND OPV.Sector = opp.Sector
WHERE OPV.MAINSPEF IN
      (
          SELECT Code FROM #CodeGroup_MAINSPEF_1
      )
      AND LEFT(opp.Procedure_Code, 4)IN
          (
              SELECT Code FROM #CodeGroup_UrethralInjection_InertSubstance_4
          );

-- **Assigning 'Gynae_EndometrialAblation_OP'**

UPDATE OPV
SET Gynae_EndometrialAblation_OP = 1
FROM #OP_Spells_With_Variables OPV
    INNER JOIN [PAS_OP_Procedure_Normalised] opp
        ON OPV.OP_Attendance_ID = opp.OP_Attendance_ID
           AND OPV.Sector = opp.Sector
WHERE LEFT(opp.Procedure_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_EndometrialAblation_4
      );

-- **Assigning 'Gynae_Hysteroscopy_OP'**

UPDATE OPV
SET Gynae_Hysteroscopy_OP = 1
FROM #OP_Spells_With_Variables OPV
    INNER JOIN [PAS_OP_Procedure_Normalised] opp
        ON OPV.OP_Attendance_ID = opp.OP_Attendance_ID
           AND OPV.Sector = opp.Sector
WHERE LEFT(opp.Procedure_Code, 3)IN
      (
          SELECT Code FROM #CodeGroup_Hysteroscopy_3
      )
      AND LEFT(opp.Procedure_Code, 4) NOT IN
          (
              SELECT Code FROM #CodeGroup_DyeTestFallopian_4
          )
      AND LEFT(opp.Procedure_Code, 4) NOT IN
          (
              SELECT Code FROM #CodeGroup_Qual_ExclLapHyster_4
          );

-- **Assigning 'Gynae_ProcBartholin_OP'**

UPDATE OPV
SET Gynae_ProcBartholin_OP = 1
FROM #OP_Spells_With_Variables OPV
    INNER JOIN [PAS_OP_Procedure_Normalised] opp
        ON OPV.OP_Attendance_ID = opp.OP_Attendance_ID
           AND OPV.Sector = opp.Sector
WHERE LEFT(opp.Procedure_Code, 4)IN
      (
          SELECT Code FROM #CodeGroup_ProcBartholin_4
      );


-- **Assigning 'Gynae_Procedure_OP'**

UPDATE OPV
SET Gynae_Procedure_OP = 'Therapeutic_endoscopic_Proc'
FROM #OP_Spells_With_Variables OPV
    INNER JOIN [PAS_OP_Procedure_Normalised] opp
        ON OPV.OP_Attendance_ID = opp.OP_Attendance_ID
           AND OPV.Sector = opp.Sector
WHERE LEFT(opp.Procedure_Code, 3)IN
      (
          SELECT Code FROM #CodeGroup_TherapeuticEndoscopicUterus_3
      );

-- **Assigning 'VaginalHysterectomy' to Gynae_Proc_Hysterectomy**

UPDATE SWV
SET Gynae_Proc_Hysterectomy = 'VaginalHysterectomy'
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
                  SELECT Code FROM #CodeGroup_VaginalHysterectomy_3
              )
);

/* -------------------------------------------------------------------
	Benign Hysterectomy (Elective)
------------------------------------------------------------------- */


/* Number of Open Abdominal Hysterectomies for Benign Condition

COUNT(Spells) 
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen' 
AND POD_Derived IN ('DC','EL')

*/

-- Metric GY7100: Number of Open Abdominal Hysterectomies for Benign Condition

DECLARE @GY7100_StartDate DATE = '2024-06-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Numerator
DECLARE @GY7100_Num_OpenAbdHystBenign INT;

SELECT @GY7100_Num_OpenAbdHystBenign = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT 'GY7100 - Number of Open Abdominal Hysterectomies for Benign Condition' AS Metric,
       @GY7100_Num_OpenAbdHystBenign AS Value;


/* 
    Metric: Number of Vaginal Hysterectomies for Benign Condition
    Description: COUNT(Spells) where Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag' 
                 AND POD_Derived IN ('DC','EL')
*/

-- Metric GY7101: Number of Vaginal Hysterectomies for Benign Condition

DECLARE @GY7100_StartDate DATE = '2024-06-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

DECLARE @GY7101_Num_VagHystBenign INT;

SELECT @GY7101_Num_VagHystBenign = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT 'GY7101 - Number of Vaginal Hysterectomies for Benign Condition' AS Metric,
       @GY7101_Num_VagHystBenign AS Value;


/* 
    Metric: Number of Minimal Access Hysterectomies for Benign Condition
    Description: COUNT(Spells) where Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina' 
                 AND National_POD IN ('DC','EL')
*/

-- Metric GY7102: Number of Minimal Access Abdominal Hysterectomies for Benign Condition

DECLARE @GY7100_StartDate DATE = '2024-06-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

DECLARE @GY7102_Num_MinAccessHystBenign INT;

SELECT @GY7102_Num_MinAccessHystBenign = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT 'GY7102 - Number of Minimal Access Abdominal Hysterectomies for Benign Condition' AS Metric,
       @GY7102_Num_MinAccessHystBenign AS Value;

/* Length of stay for open abdominal hysterectomy for benign condition 

SUM(Spell_LoS)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen' 
AND National_POD IN ('DC','EL')

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7103: Length of Stay for Open Abdominal Hysterectomy for Benign Condition

DECLARE @GY7103_Sum_LOS_OpenAbdHystBenign FLOAT;
DECLARE @GY7103_Count_OpenAbdHystBenign INT;
DECLARE @GY7103_Avg_LOS_OpenAbdHystBenign FLOAT;

SELECT @GY7103_Sum_LOS_OpenAbdHystBenign = SUM(Spell_LOS),
       @GY7103_Count_OpenAbdHystBenign = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7103_Avg_LOS_OpenAbdHystBenign = @GY7103_Sum_LOS_OpenAbdHystBenign / NULLIF(@GY7103_Count_OpenAbdHystBenign, 0);

SELECT 'GY7103 - Average LOS for Open Abdominal Hysterectomy for Benign Condition' AS Metric,
       @GY7103_Avg_LOS_OpenAbdHystBenign AS GY7103_Value,
	   @GY7103_Sum_LOS_OpenAbdHystBenign AS GY7103_Numerator,
       @GY7103_Count_OpenAbdHystBenign AS GY7103_Denominator;


/* Length of stay for vaginal hysterectomy for benign condition 

SUM(Spell_LoS)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag' 
AND National_POD IN ('DC','EL')

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7104: Length of Stay for Vaginal Hysterectomy for Benign Condition

DECLARE @GY7104_Sum_LOS_VagHystBenign FLOAT;
DECLARE @GY7104_Count_VagHystBenign INT;
DECLARE @GY7104_Avg_LOS_VagHystBenign FLOAT;

SELECT @GY7104_Sum_LOS_VagHystBenign = SUM(Spell_LOS),
       @GY7104_Count_VagHystBenign = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7104_Avg_LOS_VagHystBenign = @GY7104_Sum_LOS_VagHystBenign / NULLIF(@GY7104_Count_VagHystBenign, 0);

SELECT 'GY7104 - Average LOS for Vaginal Hysterectomy for Benign Condition' AS Metric,
       @GY7104_Avg_LOS_VagHystBenign AS Average_LOS,
	   @GY7104_Sum_LOS_VagHystBenign AS GY7104_Numerator,
       @GY7104_Count_VagHystBenign AS Count_Spells;

/* % Length of stay less than 2 days for vaginal hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag' 
AND National_POD IN ('DC','EL') 
AND Spell_LoS < 2

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7105: Percentage of Vaginal Hysterectomies with LOS Less Than 2 Days

DECLARE @GY7105_Num_VagHyst_LOS_LT2 INT;
DECLARE @GY7105_Denom_VagHyst INT;
DECLARE @GY7105_Perc_VagHyst_LOS_LT2 FLOAT;

SELECT @GY7105_Num_VagHyst_LOS_LT2 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag'
      AND National_POD IN ( 'DC', 'EL' )
      AND Spell_LOS < 2
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7105_Denom_VagHyst = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7105_Perc_VagHyst_LOS_LT2
    = (CAST(@GY7105_Num_VagHyst_LOS_LT2 AS FLOAT) / NULLIF(@GY7105_Denom_VagHyst, 0)) * 100;

SELECT 'GY7105 - Percentage of Vaginal Hysterectomies with LOS < 2 Days' AS Metric,
       @GY7105_Perc_VagHyst_LOS_LT2 AS Percentage,
       @GY7105_Num_VagHyst_LOS_LT2 AS Numerator,
       @GY7105_Denom_VagHyst AS Denominator;

/* Length of stay for minimal access hysterectomy for benign condition 

SUM(Spell_LoS)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina' 
AND National_POD IN ('DC','EL')

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7106: Length of Stay for Minimal Access Abdominal Hysterectomy for Benign Condition

DECLARE @GY7106_Sum_LOS_MinAccessHystBenign FLOAT;
DECLARE @GY7106_Count_MinAccessHystBenign INT;
DECLARE @GY7106_Avg_LOS_MinAccessHystBenign FLOAT;

SELECT @GY7106_Sum_LOS_MinAccessHystBenign = SUM(Spell_LOS),
       @GY7106_Count_MinAccessHystBenign = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7106_Avg_LOS_MinAccessHystBenign
    = @GY7106_Sum_LOS_MinAccessHystBenign / NULLIF(@GY7106_Count_MinAccessHystBenign, 0);

SELECT 'GY7106 - Average LOS for Minimal Access Abdominal Hysterectomy for Benign Condition' AS Metric,
       @GY7106_Avg_LOS_MinAccessHystBenign AS GY7106_Value,
	   @GY7106_Sum_LOS_MinAccessHystBenign AS GY7106_Numerator,
       @GY7106_Count_MinAccessHystBenign AS GY7106_Denominator;

/* % length of stay less than 2 days for minimal access hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina' 
AND National_POD IN ('DC','EL') 
AND Spell_LoS < 2

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7107: Percentage of Minimal Access Abdominal Hysterectomies with LOS Less Than 2 Days

DECLARE @GY7107_Num_MinAccessHyst_LOS_LT2 INT;
DECLARE @GY7107_Denom_MinAccessHyst INT;
DECLARE @GY7107_Perc_MinAccessHyst_LOS_LT2 FLOAT;

SELECT @GY7107_Num_MinAccessHyst_LOS_LT2 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina'
      AND National_POD IN ( 'DC', 'EL' )
      AND Spell_LOS < 2
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7107_Denom_MinAccessHyst = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7107_Perc_MinAccessHyst_LOS_LT2
    = (CAST(@GY7107_Num_MinAccessHyst_LOS_LT2 AS FLOAT) / NULLIF(@GY7107_Denom_MinAccessHyst, 0)) * 100;

SELECT 'GY7107 - Percentage of Minimal Access Abdominal Hysterectomies with LOS < 2 Days' AS Metric,
       @GY7107_Perc_MinAccessHyst_LOS_LT2 AS Percentage,
       @GY7107_Num_MinAccessHyst_LOS_LT2 AS Numerator,
       @GY7107_Denom_MinAccessHyst AS Denominator;

/* Open procedure rate for patients (less than 50 years) receiving hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP IN ('ProcHysterBenignAbdOpen','ProcHysterBenignAbdMina') 
AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL') 
AND Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen' 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7108: Open Procedure Rate for Patients (<50 years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7108_Num_OpenProc_Under50 INT;
DECLARE @GY7108_Denom_Hyst_Under50 INT;
DECLARE @GY7108_Rate_OpenProc_Under50 FLOAT;

SELECT @GY7108_Num_OpenProc_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP IN ( 'ProcHysterBenignAbdOpen', 'ProcHysterBenignAbdMina' )
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7108_Denom_Hyst_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7108_Rate_OpenProc_Under50
    = (CAST(@GY7108_Num_OpenProc_Under50 AS FLOAT) / NULLIF(@GY7108_Denom_Hyst_Under50, 0)) * 100;

SELECT 'GY7108 - Open Procedure Rate for Patients (<50 years)' AS Metric,
       @GY7108_Rate_OpenProc_Under50 AS Percentage,
       @GY7108_Num_OpenProc_Under50 AS Numerator,
       @GY7108_Denom_Hyst_Under50 AS Denominator;

/* Vaginal approach rate for patients (less than 50 years) receiving hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL') 
AND Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag' 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7109: Vaginal Approach Rate for Patients (<50 years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7109_Num_VagApproach_Under50 INT;
DECLARE @GY7109_Denom_Hyst_Under50 INT;
DECLARE @GY7109_Rate_VagApproach_Under50 FLOAT;

SELECT @GY7109_Num_VagApproach_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7109_Denom_Hyst_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7109_Rate_VagApproach_Under50
    = (CAST(@GY7109_Num_VagApproach_Under50 AS FLOAT) / NULLIF(@GY7109_Denom_Hyst_Under50, 0)) * 100;

SELECT 'GY7109 - Vaginal Approach Rate for Patients (<50 years)' AS Metric,
       @GY7109_Rate_VagApproach_Under50 AS Percentage,
       @GY7109_Num_VagApproach_Under50 AS Numerator,
       @GY7109_Denom_Hyst_Under50 AS Denominator;

/* Minimal access rate for patients (less than 50 years) receiving hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP IN ('ProcHysterBenignAbdOpen','ProcHysterBenignAbdMina')AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL') 
AND Gynae_Proc_Hyster_Benign_IP =  'ProcHysterBenignAbdMina'

COUNT(Spells)Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7110: Minimal Access Rate for Patients (<50 years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7110_Num_MinAccess_Under50 INT;
DECLARE @GY7110_Denom_Hyst_Under50 INT;
DECLARE @GY7110_Rate_MinAccess_Under50 FLOAT;

SELECT @GY7110_Num_MinAccess_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP IN ( 'ProcHysterBenignAbdOpen', 'ProcHysterBenignAbdMina' )
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7110_Denom_Hyst_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7110_Rate_MinAccess_Under50
    = (CAST(@GY7110_Num_MinAccess_Under50 AS FLOAT) / NULLIF(@GY7110_Denom_Hyst_Under50, 0)) * 100;

SELECT 'GY7110 - Minimal Access Rate for Patients (<50 years)' AS Metric,
       @GY7110_Rate_MinAccess_Under50 AS Percentage,
       @GY7110_Num_MinAccess_Under50 AS Numerator,
       @GY7110_Denom_Hyst_Under50 AS Denominator;

/* Complication during surgery or within 30 days for patients (less than 50 years) receiving hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP NOT IN ('Other')  
AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL') 
AND Gynae_FLAG_Hysterectomy_Complic30=1

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-03-31'; -- Adjust as needed

-- Metric GY7111: Complication During Surgery or Within 30 Days for Patients (<50 years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7111_Num_Complications_Under50 INT;
DECLARE @GY7111_Denom_Hyst_Under50 INT;
DECLARE @GY7111_Rate_Complications_Under50 FLOAT;

SELECT @GY7111_Num_Complications_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Gynae_FLAG_Hysterectomy_Complic30 = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7111_Denom_Hyst_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7111_Rate_Complications_Under50
    = (CAST(@GY7111_Num_Complications_Under50 AS FLOAT) / NULLIF(@GY7111_Denom_Hyst_Under50, 0)) * 100;

SELECT 'GY7111 - Complication Rate During Surgery or Within 30 Days for Patients (<50 years)' AS Metric,
       @GY7111_Rate_Complications_Under50 AS Percentage,
       @GY7111_Num_Complications_Under50 AS Numerator,
       @GY7111_Denom_Hyst_Under50 AS Denominator;

/* Emergency readmission within 30 days for patients (less than 50 years) receiving hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP NOT IN ('Other') 
AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL') 
AND Read30 = 1

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age<50' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-03-31'; -- Adjust as needed

-- Metric GY7112: Emergency Readmission Within 30 Days for Patients (<50 years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7112_Num_Readmissions_Under50 INT;
DECLARE @GY7112_Denom_Hyst_Under50 INT;
DECLARE @GY7112_Rate_Readmissions_Under50 FLOAT;

SELECT @GY7112_Num_Readmissions_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Read30 = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7112_Denom_Hyst_Under50 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age<50'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7112_Rate_Readmissions_Under50
    = (CAST(@GY7112_Num_Readmissions_Under50 AS FLOAT) / NULLIF(@GY7112_Denom_Hyst_Under50, 0)) * 100;

SELECT 'GY7112 - Emergency Readmission Rate Within 30 Days for Patients (<50 years)' AS Metric,
       @GY7112_Rate_Readmissions_Under50 AS Percentage,
       @GY7112_Num_Readmissions_Under50 AS Numerator,
       @GY7112_Denom_Hyst_Under50 AS Denominator;

/* Open procedure rate for patients 50+ years receiving hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP IN ('ProcHysterBenignAbdOpen','ProcHysterBenignAbdMina') 
AND Gynae_AgeGroup_IP = 'Age50+' 
AND National_POD IN ('DC','EL') 
AND Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen' 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age50+' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7113: Open Procedure Rate for Patients (50+ years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7113_Num_OpenProc_50Plus INT;
DECLARE @GY7113_Denom_Hyst_50Plus INT;
DECLARE @GY7113_Rate_OpenProc_50Plus FLOAT;

SELECT @GY7113_Num_OpenProc_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP IN ( 'ProcHysterBenignAbdOpen', 'ProcHysterBenignAbdMina' )
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdOpen'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7113_Denom_Hyst_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7113_Rate_OpenProc_50Plus
    = (CAST(@GY7113_Num_OpenProc_50Plus AS FLOAT) / NULLIF(@GY7113_Denom_Hyst_50Plus, 0)) * 100;

SELECT 'GY7113 - Open Procedure Rate for Patients (50+ years)' AS Metric,
       @GY7113_Rate_OpenProc_50Plus AS Percentage,
       @GY7113_Num_OpenProc_50Plus AS Numerator,
       @GY7113_Denom_Hyst_50Plus AS Denominator;

/* Vaginal approach rate for patients (50+ years) receiving hysterectomy for benign condition 

COUNT(Spells)Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age50+' 
AND National_POD IN ('DC','EL') 
And Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag' 

COUNT(Spells)Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age50+' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7114: Vaginal Approach Rate for Patients (50+ years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7114_Num_VagApproach_50Plus INT;
DECLARE @GY7114_Denom_Hyst_50Plus INT;
DECLARE @GY7114_Rate_VagApproach_50Plus FLOAT;

SELECT @GY7114_Num_VagApproach_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignVag'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7114_Denom_Hyst_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7114_Rate_VagApproach_50Plus
    = (CAST(@GY7114_Num_VagApproach_50Plus AS FLOAT) / NULLIF(@GY7114_Denom_Hyst_50Plus, 0)) * 100;

SELECT 'GY7114 - Vaginal Approach Rate for Patients (50+ years)' AS Metric,
       @GY7114_Rate_VagApproach_50Plus AS Percentage,
       @GY7114_Num_VagApproach_50Plus AS Numerator,
       @GY7114_Denom_Hyst_50Plus AS Denominator;

/* Minimal access rate for patients (50+ years) receiving hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP IN ('ProcHysterBenignAbdOpen','ProcHysterBenignAbdMina') 
AND Gynae_AgeGroup_IP = 'Age50+' 
AND National_POD IN ('DC','EL') 
AND Gynae_Proc_Hyster_Benign_IP =  'ProcHysterBenignAbdMina'

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age50+' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7115: Minimal Access Rate for Patients (50+ years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7115_Num_MinAccess_50Plus INT;
DECLARE @GY7115_Denom_Hyst_50Plus INT;
DECLARE @GY7115_Rate_MinAccess_50Plus FLOAT;

SELECT @GY7115_Num_MinAccess_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP IN ( 'ProcHysterBenignAbdOpen', 'ProcHysterBenignAbdMina' )
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Gynae_Proc_Hyster_Benign_IP = 'ProcHysterBenignAbdMina'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7115_Denom_Hyst_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7115_Rate_MinAccess_50Plus
    = (CAST(@GY7115_Num_MinAccess_50Plus AS FLOAT) / NULLIF(@GY7115_Denom_Hyst_50Plus, 0)) * 100;

SELECT 'GY7115 - Minimal Access Rate for Patients (50+ years)' AS Metric,
       @GY7115_Rate_MinAccess_50Plus AS Percentage,
       @GY7115_Num_MinAccess_50Plus AS Numerator,
       @GY7115_Denom_Hyst_50Plus AS Denominator;

/* Complication during surgery or within 30 days for patients 50+ years receiving hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP NOT IN ('Other') 
AND Gynae_AgeGroup_IP = 'Age50+'
AND National_POD IN ('DC','EL') 
AND Gynae_FLAG_Hysterectomy_Complic30=1

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age50+' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-03-31'; -- Adjust as needed

-- Metric GY7116: Complication During Surgery or Within 30 Days for Patients (50+ years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7116_Num_Complications_50Plus INT;
DECLARE @GY7116_Denom_Hyst_50Plus INT;
DECLARE @GY7116_Rate_Complications_50Plus FLOAT;

SELECT @GY7116_Num_Complications_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Gynae_FLAG_Hysterectomy_Complic30 = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7116_Denom_Hyst_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7116_Rate_Complications_50Plus
    = (CAST(@GY7116_Num_Complications_50Plus AS FLOAT) / NULLIF(@GY7116_Denom_Hyst_50Plus, 0)) * 100;

SELECT 'GY7116 - Complication Rate During Surgery or Within 30 Days for Patients (50+ years)' AS Metric,
       @GY7116_Rate_Complications_50Plus AS Percentage,
       @GY7116_Num_Complications_50Plus AS Numerator,
       @GY7116_Denom_Hyst_50Plus AS Denominator;

/* Emergency readmission within 30 days for patients 50+ years receiving hysterectomy for benign condition 

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP NOT IN ('Other')  
AND Gynae_AgeGroup_IP = 'Age50+' 
AND National_POD IN ('DC','EL') 
AND Read30 = 1

COUNT(Spells)
Gynae_Proc_Hyster_Benign_IP <> 'Other' 
AND Gynae_AgeGroup_IP = 'Age50+' 
AND National_POD IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-03-31'; -- Adjust as needed

-- Metric GY7117: Emergency Readmission Within 30 Days for Patients (50+ years) Receiving Hysterectomy for Benign Condition

DECLARE @GY7117_Num_Readmissions_50Plus INT;
DECLARE @GY7117_Denom_Hyst_50Plus INT;
DECLARE @GY7117_Rate_Readmissions_50Plus FLOAT;

SELECT @GY7117_Num_Readmissions_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Read30 = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7117_Denom_Hyst_50Plus = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Benign_IP <> 'Other'
      AND Gynae_AgeGroup_IP = 'Age50+'
      AND National_POD IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7117_Rate_Readmissions_50Plus
    = (CAST(@GY7117_Num_Readmissions_50Plus AS FLOAT) / NULLIF(@GY7117_Denom_Hyst_50Plus, 0)) * 100;

SELECT 'GY7117 - Emergency Readmission Rate Within 30 Days for Patients (50+ years)' AS Metric,
       @GY7117_Rate_Readmissions_50Plus AS Percentage,
       @GY7117_Num_Readmissions_50Plus AS Numerator,
       @GY7117_Denom_Hyst_50Plus AS Denominator;

/* -------------------------------------------------------------------
	Cancer Hysterectomy (Elective)
------------------------------------------------------------------- */

/* Number of vaginal hysterectomies for cancer 

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerVag' 
AND POD_Derived IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2024-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-04-30'; -- Adjust as needed

-- Metric GY7118: Number of Open Abdominal Hysterectomies for Cancer

DECLARE @GY7118_Num_OpenAbdHystCancer INT;

SELECT @GY7118_Num_OpenAbdHystCancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdOpen'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT 'GY7118 - Number of Open Abdominal Hysterectomies for Cancer' AS Metric,
       @GY7118_Num_OpenAbdHystCancer AS Value;

/* Number of minimal access hysterectomies for cancer 

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina' 
AND POD_Derived IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2024-05-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-05-31'; -- Adjust as needed

-- Metric GY7119: Number of Vaginal Hysterectomies for Cancer

DECLARE @GY7119_Num_VagHystCancer INT;

SELECT @GY7119_Num_VagHystCancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerVag'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT 'GY7119 - Number of Vaginal Hysterectomies for Cancer' AS Metric,
       @GY7119_Num_VagHystCancer AS Value;

/* Open procedure rate for patients receiving hysterectomy for cancer 

COUNT(Spells
)Gynae_Proc_Hyster_Cancer_IP NOT IN ('Other') 
AND POD_Derived IN ('DC','EL') 
AND Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdOpen' 

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP NOT IN ('Other') 
AND POD_Derived IN ('DC','EL') 

*/

DECLARE @GY7100_StartDate DATE = '2024-06-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7120: Number of Minimal Access Abdominal Hysterectomies for Cancer

DECLARE @GY7120_Num_MinAccessHystCancer INT;

SELECT @GY7120_Num_MinAccessHystCancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT 'GY7120 - Number of Minimal Access Abdominal Hysterectomies for Cancer' AS Metric,
       @GY7120_Num_MinAccessHystCancer AS Value;


/* Minimal access rate for patients receiving hysterectomy for cancer 

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP IN ('ProcHysterCancerAbdMina') 
AND POD_Derived IN ('DC','EL')

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP IN ('ProcHysterCancerAbdOpen','ProcHysterCancerAbdMina') 
AND POD_Derived IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7122: Minimal Access Rate for Patients Receiving Hysterectomy for Cancer

DECLARE @GY7122_Num_MinAccessCancer INT;
DECLARE @GY7122_Denom_HystCancer INT;
DECLARE @GY7122_Rate_MinAccessCancer FLOAT;

SELECT @GY7122_Num_MinAccessCancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT @GY7122_Denom_HystCancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP IN ( 'ProcHysterCancerAbdOpen', 'ProcHysterCancerAbdMina' )
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7122_Rate_MinAccessCancer
    = (CAST(@GY7122_Num_MinAccessCancer AS FLOAT) / NULLIF(@GY7122_Denom_HystCancer, 0)) * 100;

SELECT 'GY7122 - Minimal Access Rate for Patients Receiving Hysterectomy for Cancer' AS Metric,
       @GY7122_Rate_MinAccessCancer AS Percentage,
       @GY7122_Num_MinAccessCancer AS Numerator,
       @GY7122_Denom_HystCancer AS Denominator;

/* Length of stay for open abdominal hysterectomy for cancer 

SUM(Spell_LoS)
Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdOpen' 
AND POD_Derived IN ('DC','EL')

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdOpen' 
AND POD_Derived IN ('DC','EL')

Metric ID: GY7123

*/

DECLARE @GY7100_StartDate DATE = '2018-10-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2019-09-30'; -- Adjust as needed

-- Metric GY7123: Length of Stay for Open Abdominal Hysterectomy for Cancer

DECLARE @GY7123_Sum_LOS_OpenAbdHystCancer FLOAT;
DECLARE @GY7123_Count_OpenAbdHystCancer INT;
DECLARE @GY7123_Avg_LOS_OpenAbdHystCancer FLOAT;

SELECT @GY7123_Sum_LOS_OpenAbdHystCancer = SUM(Spell_LOS),
       @GY7123_Count_OpenAbdHystCancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdOpen'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7123_Avg_LOS_OpenAbdHystCancer = @GY7123_Sum_LOS_OpenAbdHystCancer / NULLIF(@GY7123_Count_OpenAbdHystCancer, 0);

SELECT 'GY7123 - Average LOS for Open Abdominal Hysterectomy for Cancer' AS Metric,
       @GY7123_Avg_LOS_OpenAbdHystCancer AS Average_LOS,
	   @GY7123_Sum_LOS_OpenAbdHystCancer AS GY7123_Numerator,
       @GY7123_Count_OpenAbdHystCancer AS Count_Spells;

/* Length of stay for minimal access hysterectomy for cancer 

SUM(Spell_LoS)
Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina' 
AND POD_Derived IN ('DC','EL')

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina' 
AND POD_Derived IN ('DC','EL')

Metric ID: GY7124

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7124: Length of Stay for Minimal Access Hysterectomy for Cancer

DECLARE @GY7124_Sum_LOS_MinAccessHystCancer FLOAT;
DECLARE @GY7124_Count_MinAccessHystCancer INT;
DECLARE @GY7124_Avg_LOS_MinAccessHystCancer FLOAT;

SELECT @GY7124_Sum_LOS_MinAccessHystCancer = SUM(Spell_LOS),
       @GY7124_Count_MinAccessHystCancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7124_Avg_LOS_MinAccessHystCancer
    = @GY7124_Sum_LOS_MinAccessHystCancer / NULLIF(@GY7124_Count_MinAccessHystCancer, 0);

SELECT 'GY7124 - Average LOS for Minimal Access Hysterectomy for Cancer' AS Metric,
       @GY7124_Avg_LOS_MinAccessHystCancer AS Average_LOS,
	   @GY7124_Sum_LOS_MinAccessHystCancer AS Num,
       @GY7124_Count_MinAccessHystCancer AS Count_Spells;

/* % length of stay less than 2 days for minimal access hysterectomy for cancer 

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina' 
AND POD_Derived IN ('DC','EL') 
AND Spell_LoS < 2

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina'  
AND POD_Derived IN ('DC','EL')

Metric ID: GY7125

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7125: Percentage of Minimal Access Hysterectomies for Cancer with LOS Less Than 2 Days

DECLARE @GY7125_Num_MinAccessHystCancer_LOS_LT2 INT;
DECLARE @GY7125_Denom_MinAccessHystCancer INT;
DECLARE @GY7125_Perc_MinAccessHystCancer_LOS_LT2 FLOAT;

-- Numerator
SELECT @GY7125_Num_MinAccessHystCancer_LOS_LT2 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Spell_LOS < 2
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7125_Denom_MinAccessHystCancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP = 'ProcHysterCancerAbdMina'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Calculate Percentage
SET @GY7125_Perc_MinAccessHystCancer_LOS_LT2
    = (CAST(@GY7125_Num_MinAccessHystCancer_LOS_LT2 AS FLOAT) / NULLIF(@GY7125_Denom_MinAccessHystCancer, 0)) * 100;

SELECT 'GY7125 - Percentage of Minimal Access Hysterectomies for Cancer with LOS < 2 Days' AS Metric,
       @GY7125_Perc_MinAccessHystCancer_LOS_LT2 AS Percentage,
       @GY7125_Num_MinAccessHystCancer_LOS_LT2 AS Numerator,
       @GY7125_Denom_MinAccessHystCancer AS Denominator;

/* Complication during surgery or within 30 days for patients receiving hysterectomy for cancer 

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP NOT IN ('Other')  
AND POD_Derived IN ('DC','EL') 
AND Gynae_FLAG_Hysterectomy_Complic30=1

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP NOT IN ('Other') 
AND POD_Derived IN ('DC','EL')

Metric ID: GY7126

*/

DECLARE @GY7100_StartDate DATE = '2023-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-03-31'; -- Adjust as needed

-- Metric GY7126: Complication During Surgery or Within 30 Days for Patients Receiving Hysterectomy for Cancer

DECLARE @GY7126_Num_Complications_Cancer INT;
DECLARE @GY7126_Denom_Hyst_Cancer INT;
DECLARE @GY7126_Rate_Complications_Cancer FLOAT;

-- Numerator
SELECT @GY7126_Num_Complications_Cancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP <> 'Other'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Gynae_FLAG_Hysterectomy_Complic30 = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7126_Denom_Hyst_Cancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP <> 'Other'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Calculate Complication Rate
SET @GY7126_Rate_Complications_Cancer
    = (CAST(@GY7126_Num_Complications_Cancer AS FLOAT) / NULLIF(@GY7126_Denom_Hyst_Cancer, 0)) * 100;

SELECT 'GY7126 - Complication Rate During Surgery or Within 30 Days for Hysterectomy for Cancer' AS Metric,
       @GY7126_Rate_Complications_Cancer AS Percentage,
       @GY7126_Num_Complications_Cancer AS Numerator,
       @GY7126_Denom_Hyst_Cancer AS Denominator;


/* Emergency readmission within 30 days for patients receiving hysterectomy for cancer 

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP NOT IN ('Other')  
AND POD_Derived IN ('DC','EL')  AND Read30 = 1

COUNT(Spells)
Gynae_Proc_Hyster_Cancer_IP NOT IN ('Other')  
AND POD_Derived IN ('DC','EL')

Metric ID: GY7127

*/

DECLARE @GY7100_StartDate DATE = '2023-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-03-31'; -- Adjust as needed

-- Metric GY7127: Emergency Readmission Within 30 Days for Patients Receiving Hysterectomy for Cancer

DECLARE @GY7127_Num_Readmissions_Cancer INT;
DECLARE @GY7127_Denom_Hyst_Cancer INT;
DECLARE @GY7127_Rate_Readmissions_Cancer FLOAT;

-- Numerator
SELECT @GY7127_Num_Readmissions_Cancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP <> 'Other'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Read30 = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7127_Denom_Hyst_Cancer = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Hyster_Cancer_IP <> 'Other'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Calculate Readmission Rate
SET @GY7127_Rate_Readmissions_Cancer
    = (CAST(@GY7127_Num_Readmissions_Cancer AS FLOAT) / NULLIF(@GY7127_Denom_Hyst_Cancer, 0)) * 100;

SELECT 'GY7127 - Emergency Readmission Rate Within 30 Days for Hysterectomy for Cancer' AS Metric,
       @GY7127_Rate_Readmissions_Cancer AS Percentage,
       @GY7127_Num_Readmissions_Cancer AS Numerator,
       @GY7127_Denom_Hyst_Cancer AS Denominator;

/* -------------------------------------------------------------------
	Prolapse Procedures (Elective)
------------------------------------------------------------------- */


/* Number of abdominal prolapse procedures 

COUNT(Spells)
NCIP_Procedure_Main = 'Abdominal prolapse procedures | age 17+ | elective'

Metric ID: GY7128

*/

DECLARE @GY7100_StartDate DATE = '2024-06-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7128: Number of Abdominal Prolapse Procedures (Elective)

DECLARE @GY7128_Num_AbdominalProlapse INT;

SELECT @GY7128_Num_AbdominalProlapse = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Procedure_Main = 'Abdominal prolapse procedures | age 17+ | elective'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT 'GY7128 - Number of Abdominal Prolapse Procedures (Elective)' AS Metric,
       @GY7128_Num_AbdominalProlapse AS Value;


/* Length of stay for abdominal prolapse procedures 



*/



/* Length of stay for vaginal prolapse procedures with vaginal hysterectomy 

SUM(Spell_LoS)
Gynae_Proc_Vag_Prolapse = 'VaginalProlapseProcedures' 
AND Gynae_Proc_Hysterectomy = 'VaginalHysterectomy' 
AND POD_Derived IN ('DC','EL')

COUNT(Spells)
Gynae_Proc_Vag_Prolapse = 'VaginalProlapseProcedures' 
AND Gynae_Proc_Hysterectomy = 'VaginalHysterectomy' 
AND POD_Derived IN ('DC','EL')

Metric ID: GY7130

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7130: Length of Stay for Vaginal Prolapse Procedures with Vaginal Hysterectomy

DECLARE @GY7130_Sum_LOS_VagProlapseWithHyst FLOAT;
DECLARE @GY7130_Count_VagProlapseWithHyst INT;
DECLARE @GY7130_Avg_LOS_VagProlapseWithHyst FLOAT;

-- Numerator and Denominator
SELECT @GY7130_Sum_LOS_VagProlapseWithHyst = SUM(Spell_LOS),
       @GY7130_Count_VagProlapseWithHyst = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Vag_Prolapse = 1
      AND Gynae_Proc_Hysterectomy = 'VaginalHysterectomy'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Calculate Average LOS
SET @GY7130_Avg_LOS_VagProlapseWithHyst
    = @GY7130_Sum_LOS_VagProlapseWithHyst / NULLIF(@GY7130_Count_VagProlapseWithHyst, 0);

SELECT 'GY7130 - Average LOS for Vaginal Prolapse Procedures with Vaginal Hysterectomy' AS Metric,
       @GY7130_Avg_LOS_VagProlapseWithHyst AS Average_LOS,
	   @GY7130_Sum_LOS_VagProlapseWithHyst AS Num,
       @GY7130_Count_VagProlapseWithHyst AS Count_Spells;

/* Length of stay for vaginal prolapse procedures without vaginal hysterectomy 

SUM(Spell_LoS)
Gynae_Proc_Vag_Prolapse = 'VaginalProlapseProcedures' 
AND Gynae_Proc_Hysterectomy <> 'VaginalHysterectomy' 
AND POD_Derived IN ('DC','EL')

COUNT(Spells)Gynae_Proc_Vag_Prolapse = 'VaginalProlapseProcedures' 
AND Gynae_Proc_Hysterectomy <> 'VaginalHysterectomy' 
AND POD_Derived IN ('DC','EL')

Metric ID: GY7131

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7131: Length of Stay for Vaginal Prolapse Procedures without Vaginal Hysterectomy

DECLARE @GY7131_Sum_LOS_VagProlapseWithoutHyst FLOAT;
DECLARE @GY7131_Count_VagProlapseWithoutHyst INT;
DECLARE @GY7131_Avg_LOS_VagProlapseWithoutHyst FLOAT;

-- Numerator and Denominator
SELECT @GY7131_Sum_LOS_VagProlapseWithoutHyst = SUM(Spell_LOS),
       @GY7131_Count_VagProlapseWithoutHyst = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Proc_Vag_Prolapse = 1
      AND
      (
          Gynae_Proc_Hysterectomy <> 'VaginalHysterectomy'
          OR Gynae_Proc_Hysterectomy IS NULL
      )
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Calculate Average LOS
SET @GY7131_Avg_LOS_VagProlapseWithoutHyst
    = @GY7131_Sum_LOS_VagProlapseWithoutHyst / NULLIF(@GY7131_Count_VagProlapseWithoutHyst, 0);

SELECT 'GY7131 - Average LOS for Vaginal Prolapse Procedures without Vaginal Hysterectomy' AS Metric,
       @GY7131_Avg_LOS_VagProlapseWithoutHyst AS Average_LOS,
	   @GY7131_Sum_LOS_VagProlapseWithoutHyst AS Numerator,
       @GY7131_Count_VagProlapseWithoutHyst AS Count_Spells;

/* Emergency readmission within 30 days following a vaginal prolapse procedure 

COUNT(Spells)
NCIP_Procedure_Main = 'Vaginal prolapse procedures | age 17+ | elective' 
AND Read30 = 1

COUNT(Spells)
NCIP_Procedure_Main = 'Vaginal prolapse procedures | age 17+ | elective'

Metric ID: GY7132

*/

DECLARE @GY7100_StartDate DATE = '2023-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-03-31'; -- Adjust as needed

-- Metric GY7132: Emergency Readmission Within 30 Days Following a Vaginal Prolapse Procedure

DECLARE @GY7132_Num_Readmissions_VagProlapse INT;
DECLARE @GY7132_Denom_VagProlapse INT;
DECLARE @GY7132_Rate_Readmissions_VagProlapse FLOAT;

-- Numerator
SELECT @GY7132_Num_Readmissions_VagProlapse = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Procedure_Main = 'Vaginal prolapse procedures | age 17+ | elective'
      AND Read30 = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7132_Denom_VagProlapse = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Procedure_Main = 'Vaginal prolapse procedures | age 17+ | elective'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Calculate Readmission Rate
SET @GY7132_Rate_Readmissions_VagProlapse
    = (CAST(@GY7132_Num_Readmissions_VagProlapse AS FLOAT) / NULLIF(@GY7132_Denom_VagProlapse, 0)) * 100;

SELECT 'GY7132 - Emergency Readmission Rate Within 30 Days Following a Vaginal Prolapse Procedure' AS Metric,
       @GY7132_Rate_Readmissions_VagProlapse AS Percentage,
       @GY7132_Num_Readmissions_VagProlapse AS Numerator,
       @GY7132_Denom_VagProlapse AS Denominator;

/* -------------------------------------------------------------------
	Incontinence (Elective)
------------------------------------------------------------------- */

/* Number of Autologous fascia sling 

COUNT(Spells)
NCIP_Procedure_Main = 'Autologous fascia sling | age 17+ | elective'

Metric ID: GY7133

*/

DECLARE @GY7100_StartDate DATE = '2023-11-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2023-11-30'; -- Adjust as needed

-- Metric GY7133: Number of Autologous Fascia Sling Procedures

DECLARE @GY7133_Num_AutologousFasciaSling INT;

SELECT @GY7133_Num_AutologousFasciaSling = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Procedure_Main = 'Autologous fascia sling | age 17+ | elective'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SELECT 'GY7133 - Number of Autologous Fascia Sling Procedures' AS Metric,
       @GY7133_Num_AutologousFasciaSling AS Value;


/* Daycase rate for vaginal tape (TVT or TOT) for incontinence 

COUNT(Spells) 
NCIP_Procedure_Main = 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective' OR NCIP_Procedure_Main = 'Insertion of transobturator tape (TOT) only | age 17+ | elective' 
AND POD_Derived = 'DC'

COUNT(Spells)
NCIP_Procedure_Main = 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective' OR NCIP_Procedure_Main = 'Insertion of transobturator tape (TOT) only | age 17+ | elective'

Metric ID: GY7134

*/

DECLARE @GY7100_StartDate DATE = '2018-01-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2018-12-31'; -- Adjust as needed

-- Metric GY7134: Daycase Rate for Vaginal Tape (TVT or TOT) for Incontinence

DECLARE @GY7134_Num_Daycase_VaginalTape INT;
DECLARE @GY7134_Denom_VaginalTape INT;
DECLARE @GY7134_Rate_Daycase_VaginalTape FLOAT;

-- Numerator
SELECT @GY7134_Num_Daycase_VaginalTape = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (
          Procedure_Main = 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective'
          OR Procedure_Main = 'Insertion of transobturator tape (TOT) only | age 17+ | elective'
      )
      AND POD_Derived = 'DC'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7134_Denom_VaginalTape = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (
          Procedure_Main = 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective'
          OR Procedure_Main = 'Insertion of transobturator tape (TOT) only | age 17+ | elective'
      )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Calculate Daycase Rate
SET @GY7134_Rate_Daycase_VaginalTape
    = (CAST(@GY7134_Num_Daycase_VaginalTape AS FLOAT) / NULLIF(@GY7134_Denom_VaginalTape, 0)) * 100;

SELECT 'GY7134 - Daycase Rate for Vaginal Tape (TVT or TOT) for Incontinence' AS Metric,
       @GY7134_Rate_Daycase_VaginalTape AS Percentage,
       @GY7134_Num_Daycase_VaginalTape AS Numerator,
       @GY7134_Denom_VaginalTape AS Denominator;

/* Emergency readmission within 30 days for patients receiving surgery for incontinence 

COUNT(Spells)
(NCIP_Procedure_Main = 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective' OR NCIP_Procedure_Main = 'Insertion of transobturator tape (TOT) only | age 17+ | elective' OR NCIP_Procedure_Main =' Autologous fascia sling | age 17+ | elective' OR NCIP_Procedure_Main = 'Colposuspension | age 17+ | elective') 
AND Read30 = 1

COUNT(Spells)
NCIP_Procedure_Main = 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective' OR NCIP_Procedure_Main = 'Insertion of transobturator tape (TOT) only | age 17+ | elective' OR NCIP_Procedure_Main =' Autologous fascia sling | age 17+ | elective' OR NCIP_Procedure_Main = 'Colposuspension | age 17+ | elective'

Metric ID: GY7136

*/

DECLARE @GY7100_StartDate DATE = '2018-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2019-03-31'; -- Adjust as needed

-- Metric GY7136: Emergency Readmission Within 30 Days for Patients Receiving Surgery for Incontinence

DECLARE @GY7136_Num_Readmissions_Incontinence INT;
DECLARE @GY7136_Denom_Incontinence INT;
DECLARE @GY7136_Rate_Readmissions_Incontinence FLOAT;

-- Numerator
SELECT @GY7136_Num_Readmissions_Incontinence = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (
          Procedure_Main = 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective'
          OR Procedure_Main = 'Insertion of transobturator tape (TOT) only | age 17+ | elective'
          OR Procedure_Main = 'Autologous fascia sling | age 17+ | elective'
          OR Procedure_Main = 'Colposuspension | age 17+ | elective'
      )
      AND Read30 = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7136_Denom_Incontinence = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (
          Procedure_Main = 'Insertion of tension-free vaginal tape (TVT) only | age 17+ | elective'
          OR Procedure_Main = 'Insertion of transobturator tape (TOT) only | age 17+ | elective'
          OR Procedure_Main = 'Autologous fascia sling | age 17+ | elective'
          OR Procedure_Main = 'Colposuspension | age 17+ | elective'
      )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Calculate Readmission Rate
SET @GY7136_Rate_Readmissions_Incontinence
    = (CAST(@GY7136_Num_Readmissions_Incontinence AS FLOAT) / NULLIF(@GY7136_Denom_Incontinence, 0)) * 100;

SELECT 'GY7136 - Emergency Readmission Rate Within 30 Days for Patients Receiving Surgery for Incontinence' AS Metric,
       @GY7136_Rate_Readmissions_Incontinence AS Percentage,
       @GY7136_Num_Readmissions_Incontinence AS Numerator,
       @GY7136_Denom_Incontinence AS Denominator;


/* Outpatient rate for injection of Botox for incontinence 

COUNT(Spells + OP Attendances)
Gynae_InjectionBotox_OP = 'InjectionBotox'

COUNT(Spells + OP Attendances)
Gynae_InjectionBotox_OP = 'InjectionBotox' 
OR (Gynae_InjectionBotox_IP = 'InjectionBotox' 
AND POD_Derived IN ('DC','EL'))

Metric ID: GY7137

*/

-- Define Metric Start and End Dates
DECLARE @MetricStartDate DATE = '2023-07-01'; -- Replace with your actual start date
DECLARE @MetricEndDate DATE = '2024-06-30'; -- Replace with your actual end date

-- Metric GY7137: Outpatient Rate for Injection of Botox for Incontinence

DECLARE @GY7137_Num_OP_InjectionBotox INT;
DECLARE @GY7137_Denom_Total_InjectionBotox INT;
DECLARE @GY7137_Rate_OP_InjectionBotox FLOAT;

-- Numerator: Outpatient attendances with InjectionBotox_OP = 1
SELECT @GY7137_Num_OP_InjectionBotox = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
WHERE OPV.Gynae_InjectionBotox_OP = 1
      AND OPV.Appointment_Date
      BETWEEN @MetricStartDate AND @MetricEndDate;

-- Denominator: Total outpatient attendances and inpatient spells with InjectionBotox
SELECT @GY7137_Denom_Total_InjectionBotox =
(
    -- Outpatient attendances
    SELECT COUNT(DISTINCT OPV.OP_Attendance_ID)
    FROM #OP_Spells_With_Variables OPV
    WHERE OPV.Gynae_InjectionBotox_OP = 1
          AND OPV.Appointment_Date
          BETWEEN @MetricStartDate AND @MetricEndDate
) +
(
    -- Inpatient spells
    SELECT COUNT(DISTINCT SWV.Spell_Number)
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gynae_InjectionBotox_IP = 1
          AND SWV.POD_Derived IN ( 'DC', 'EL' )
          AND SWV.Admission_Date
          BETWEEN @MetricStartDate AND @MetricEndDate
);

-- Calculate Outpatient Rate
SET @GY7137_Rate_OP_InjectionBotox
    = (CAST(@GY7137_Num_OP_InjectionBotox AS FLOAT) / NULLIF(@GY7137_Denom_Total_InjectionBotox, 0)) * 100;

-- Output the Results
SELECT 'GY7137 - Outpatient Rate for Injection of Botox for Incontinence' AS Metric,
       @GY7137_Rate_OP_InjectionBotox AS Percentage,
       @GY7137_Num_OP_InjectionBotox AS Numerator,
       @GY7137_Denom_Total_InjectionBotox AS Denominator;


/* Outpatient rate for para-urethral bulking injection for incontinence

COUNT(Spells + OP Attendances)
Gynae_ParaUrethralInjection_OP = 'ParaUrethralInjection'

COUNT(Spells + OP Attendances)
Gynae_ParaUrethralInjection_OP = 'ParaUrethralInjection' 
OR (Gynae_ParaUrethralInjection_IP = 'ParaUrethralInjection' 
AND POD_Derived IN ('DC','EL'))

*/

-- Define Metric Start and End Dates
DECLARE @MetricStartDate DATE = '2023-07-01'; -- Replace with your actual start date
DECLARE @MetricEndDate DATE = '2024-06-30'; -- Replace with your actual end date

-- Metric GY7138: Outpatient Rate for Para-Urethral Bulking Injection for Incontinence

DECLARE @GY7138_Num_OP_ParaUrethralInjection INT;
DECLARE @GY7138_Denom_ParaUrethralInjection INT;
DECLARE @GY7138_Rate_OP_ParaUrethralInjection FLOAT;

-- Numerator: Outpatient attendances with ParaUrethralInjection_OP = 1
SELECT @GY7138_Num_OP_ParaUrethralInjection = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
WHERE OPV.Gynae_ParaUrethralInjection_OP = 1
      AND OPV.Appointment_Date
      BETWEEN @MetricStartDate AND @MetricEndDate;

-- Denominator: Total outpatient attendances and inpatient spells with ParaUrethralInjection
SELECT @GY7138_Denom_ParaUrethralInjection =
(
    -- Outpatient attendances
    SELECT COUNT(DISTINCT OPV.OP_Attendance_ID)
    FROM #OP_Spells_With_Variables OPV
    WHERE OPV.Gynae_ParaUrethralInjection_OP = 1
          AND OPV.Appointment_Date
          BETWEEN @MetricStartDate AND @MetricEndDate
) +
(
    -- Inpatient spells
    SELECT COUNT(DISTINCT SWV.Spell_Number)
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gynae_ParaUrethralInjection_IP = 1
          AND SWV.POD_Derived IN ( 'DC', 'EL' )
          AND SWV.Admission_Date
          BETWEEN @MetricStartDate AND @MetricEndDate
);

-- Calculate Outpatient Rate
SET @GY7138_Rate_OP_ParaUrethralInjection
    = (CAST(@GY7138_Num_OP_ParaUrethralInjection AS FLOAT) / NULLIF(@GY7138_Denom_ParaUrethralInjection, 0)) * 100;

-- Output the Results
SELECT 'GY7138 - Outpatient Rate for Para-Urethral Bulking Injection for Incontinence' AS Metric,
       @GY7138_Rate_OP_ParaUrethralInjection AS Percentage,
       @GY7138_Num_OP_ParaUrethralInjection AS Numerator,
       @GY7138_Denom_ParaUrethralInjection AS Denominator;


/* Repeat injection within 2 years for urethral bulking injection for incontinence 

COUNT(Spells)
(Gynae_ParaUrethralInjection_OP = 'ParaUrethralInjection' OR (Gynae_ParaUrethralInjection_IP = 'ParaUrethralInjection'  AND POD_Derived IN ('DC','EL'))) 
AND Gynae_FLAG_Urethralinjection_ReOp2yrs = 1

COUNT(Spells)
Gynae_ParaUrethralInjection_OP = 'ParaUrethralInjection' 
OR (Gynae_ParaUrethralInjection_IP = 'ParaUrethralInjection' 
AND POD_Derived IN ('DC','EL'))

*/

-- Define Metric Start and End Dates
DECLARE @GY7100_StartDate DATE = '2021-07-01'; -- Replace with your actual start date
DECLARE @GY7100_EndDate DATE = '2022-06-30'; -- Replace with your actual end date

-- Metric GY7139: Repeat Injection Within 2 Years for Urethral Bulking Injection for Incontinence

DECLARE @GY7139_Num_RepeatInjection INT;
DECLARE @GY7139_Denom_Injection INT;
DECLARE @GY7139_Rate_RepeatInjection FLOAT;

-- Numerator
SELECT @GY7139_Num_RepeatInjection = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (
          Gynae_ParaUrethralInjection_OP = 1
          OR
          (
              Gynae_ParaUrethralInjection_IP = 1
              AND POD_Derived IN ( 'DC', 'EL' )
          )
      )
      AND Gynae_FLAG_UrethralInjection_ReOp2yrs = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7139_Denom_Injection = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_ParaUrethralInjection_OP = 1
      OR (
             Gynae_ParaUrethralInjection_IP = 1
             AND POD_Derived IN ( 'DC', 'EL' )
         )
         AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7139_Rate_RepeatInjection
    = (CAST(@GY7139_Num_RepeatInjection AS FLOAT) / NULLIF(@GY7139_Denom_Injection, 0)) * 100;

SELECT 'GY7139 - Repeat Injection Within 2 Years for Urethral Bulking Injection' AS Metric,
       @GY7139_Rate_RepeatInjection AS Percentage,
       @GY7139_Num_RepeatInjection AS Numerator,
       @GY7139_Denom_Injection AS Denominator;

/* -------------------------------------------------------------------
	Emergency Care
------------------------------------------------------------------- */

/* Non-elective rate for gynaecology admissions 

COUNT(Spells)
Gynae_MainSpef_IP = 'Gynae_MainSpef' 
AND POD_Derived IN ('EM','NE')

COUNT(Spells)
Gynae_MainSpef_IP = 'Gynae_MainSpef' 
AND POD_Derived IN ('DC','EL','EM','NE')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7140: Non-Elective Rate for Gynaecology Admissions

DECLARE @GY7140_Num_NonElective INT;
DECLARE @GY7140_Denom_TotalAdmissions INT;
DECLARE @GY7140_Rate_NonElective FLOAT;

-- Numerator
SELECT @GY7140_Num_NonElective = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_MainSpef_IP = 1
      AND POD_Derived IN ( 'EM', 'NE' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7140_Denom_TotalAdmissions = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_MainSpef_IP = 1
      AND POD_Derived IN ( 'DC', 'EL', 'EM', 'NE' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7140_Rate_NonElective
    = (CAST(@GY7140_Num_NonElective AS FLOAT) / NULLIF(@GY7140_Denom_TotalAdmissions, 0)) * 100;

SELECT 'GY7140 - Non-Elective Rate for Gynaecology Admissions' AS Metric,
       @GY7140_Rate_NonElective AS Percentage,
       @GY7140_Num_NonElective AS Numerator,
       @GY7140_Denom_TotalAdmissions AS Denominator;


/* Procedure delivered during emergency miscarriage admission 

COUNT(Spells) 
Gynae_Cond_IP = 'CondMiscarriage' 
AND POD_Derived IN ('EM') 
AND Gynae_Dominant_Procedure = 'Proc'

COUNT(Spells)
Gynae_Cond_IP = 'CondMiscarriage' 
AND POD_Derived IN ('EM')

*/



/* Length of stay less than 2 days for emergency miscarriage diagnosis 

COUNT(Spells)
Gynae_Cond_IP = 'CondMiscarriage' 
AND POD_Derived IN ('EM') 
And Spell_Los <2

COUNT(Spells)
Gynae_Cond_IP = 'CondMiscarriage' 
AND POD_Derived IN ('EM')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7142: Length of Stay Less Than 2 Days for Emergency Miscarriage Diagnosis

DECLARE @GY7142_Num_LOS_LT2 INT;
DECLARE @GY7142_Denom_Miscarriage INT;
DECLARE @GY7142_Rate_LOS_LT2 FLOAT;

-- Numerator
SELECT @GY7142_Num_LOS_LT2 = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Cond_IP = 'CondMiscarriage'
      AND Admission_Sub_Type = 'EMR'
      AND Spell_LOS < 2
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7142_Denom_Miscarriage = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Cond_IP = 'CondMiscarriage'
      AND Admission_Sub_Type = 'EMR'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7142_Rate_LOS_LT2 = (CAST(@GY7142_Num_LOS_LT2 AS FLOAT) / NULLIF(@GY7142_Denom_Miscarriage, 0)) * 100;

SELECT 'GY7142 - LOS Less Than 2 Days for Emergency Miscarriage Diagnosis' AS Metric,
       @GY7142_Rate_LOS_LT2 AS Percentage,
       @GY7142_Num_LOS_LT2 AS Numerator,
       @GY7142_Denom_Miscarriage AS Denominator;


/* Procedure delivered during emergency ectopic pregnancy admission 

COUNT(Spells)
Gynae_Cond_IP = 'CondEctopic' 
AND POD_Derived IN ('EM') 
AND Gynae_Dominant_Procedure = 'Proc'

COUNT(Spells)
Gynae_Cond_IP = 'CondEctopic' 
AND POD_Derived IN ('EM')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7143: Procedure Delivered During Emergency Ectopic Pregnancy Admission

DECLARE @GY7143_Num_Procedure INT;
DECLARE @GY7143_Denom_Ectopic INT;
DECLARE @GY7143_Rate_Procedure FLOAT;

-- Numerator
SELECT @GY7143_Num_Procedure = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Cond_IP = 'CondEctopic'
      AND Admission_Sub_Type = 'EMR'
      AND Gynae_Dominant_Procedure = 'Proc'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7143_Denom_Ectopic = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Cond_IP = 'CondEctopic'
      AND Admission_Sub_Type = 'EMR'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7143_Rate_Procedure = (CAST(@GY7143_Num_Procedure AS FLOAT) / NULLIF(@GY7143_Denom_Ectopic, 0)) * 100;

SELECT 'GY7143 - Procedure Delivered During Emergency Ectopic Pregnancy Admission' AS Metric,
       @GY7143_Rate_Procedure AS Percentage,
       @GY7143_Num_Procedure AS Numerator,
       @GY7143_Denom_Ectopic AS Denominator;

/* Length of stay for emergency ectopic pregnancy diagnosis 

SUM(Spell_LoS)
Gynae_Cond_IP = 'CondEctopic' 
AND POD_Derived IN ('EM')

COUNT(Spells)
Gynae_Cond_IP = 'CondEctopic' 
AND POD_Derived IN ('EM')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7145: Length of Stay for Emergency Ectopic Pregnancy

DECLARE @GY7145_Sum_LOS_Ectopic FLOAT;
DECLARE @GY7145_Count_Ectopic INT;
DECLARE @GY7145_Avg_LOS_Ectopic FLOAT;

SELECT @GY7145_Sum_LOS_Ectopic = SUM(Spell_LOS),
       @GY7145_Count_Ectopic = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Cond_IP = 'CondEctopic'
      AND Admission_Sub_Type = 'EMR'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7145_Avg_LOS_Ectopic = @GY7145_Sum_LOS_Ectopic / NULLIF(@GY7145_Count_Ectopic, 0);

SELECT 'GY7145 - Average LOS for Emergency Ectopic Pregnancy' AS Metric,
       @GY7145_Avg_LOS_Ectopic AS Average_LOS,
	   @GY7145_Sum_LOS_Ectopic AS Num,
       @GY7145_Count_Ectopic AS Count_Spells;

/* Procedure delivered during emergency ovarian cyst admission 

COUNT(Spells)
Gynae_Cond_IP = 'CondOvarianCyst' 
AND POD_Derived IN ('EM') 
AND Gynae_Dominant_Procedure = 'Proc'

COUNT(Spells)
Gynae_Cond_IP = 'CondOvarianCyst' 
AND POD_Derived IN ('EM')

*/

DECLARE @GY7100_StartDate DATE = '2023-04-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-03-31'; -- Adjust as needed

-- Metric GY7146: Procedure Delivered During Emergency Ovarian Cyst Admission

DECLARE @GY7146_Num_Procedure_OvarianCyst INT;
DECLARE @GY7146_Denom_OvarianCyst INT;
DECLARE @GY7146_Rate_Procedure_OvarianCyst FLOAT;

-- Numerator
SELECT @GY7146_Num_Procedure_OvarianCyst = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Cond_IP = 'CondOvarianCyst'
      AND Admission_Sub_Type = 'EMR'
      AND Gynae_Dominant_Procedure = 'Proc'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7146_Denom_OvarianCyst = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Cond_IP = 'CondOvarianCyst'
      AND Admission_Sub_Type = 'EMR'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7146_Rate_Procedure_OvarianCyst
    = (CAST(@GY7146_Num_Procedure_OvarianCyst AS FLOAT) / NULLIF(@GY7146_Denom_OvarianCyst, 0)) * 100;

SELECT 'GY7146 - Procedure Delivered During Emergency Ovarian Cyst Admission' AS Metric,
       @GY7146_Rate_Procedure_OvarianCyst AS Percentage,
       @GY7146_Num_Procedure_OvarianCyst AS Numerator,
       @GY7146_Denom_OvarianCyst AS Denominator;


/* Length of stay for emergency ovarian cyst admission where a procedure was delivered 

SUM(Spell_LoS)
Gynae_Cond_IP = 'CondOvarianCyst' 
AND Gynae_Dominant_Procedure = 'Proc' 
AND POD_Derived IN ('EM')

COUNT(Spells)
Gynae_Cond_IP = 'CondOvarianCyst' 
AND Gynae_Dominant_Procedure = 'Proc' 
AND POD_Derived IN ('EM')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7147: LOS for Emergency Ovarian Cyst Admission with Procedure

DECLARE @GY7147_Sum_LOS_OvarianCyst_Proc FLOAT;
DECLARE @GY7147_Count_OvarianCyst_Proc INT;
DECLARE @GY7147_Avg_LOS_OvarianCyst_Proc FLOAT;

SELECT @GY7147_Sum_LOS_OvarianCyst_Proc = SUM(Spell_LOS),
       @GY7147_Count_OvarianCyst_Proc = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Cond_IP = 'CondOvarianCyst'
      AND Gynae_Dominant_Procedure = 'Proc'
      AND Admission_Sub_Type = 'EMR'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7147_Avg_LOS_OvarianCyst_Proc = @GY7147_Sum_LOS_OvarianCyst_Proc / NULLIF(@GY7147_Count_OvarianCyst_Proc, 0);

SELECT 'GY7147 - Average LOS for Emergency Ovarian Cyst Admission with Procedure' AS Metric,
       @GY7147_Avg_LOS_OvarianCyst_Proc AS Average_LOS,
	   @GY7147_Sum_LOS_OvarianCyst_Proc AS Num,
       @GY7147_Count_OvarianCyst_Proc AS Count_Spells;

/* Length of stay for emergency ovarian cyst admission without a procedure 

SUM(Spell_LoS)
Gynae_Cond_IP = 'CondOvarianCyst' 
AND Gynae_Dominant_Procedure = 'NoProc' 
AND POD_Derived IN ('EM')

COUNT(Spells)
Gynae_Cond_IP = 'CondOvarianCyst' 
AND Gynae_Dominant_Procedure = 'NoProc' 
AND POD_Derived IN ('EM')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7148: LOS for Emergency Ovarian Cyst Admission without Procedure

DECLARE @GY7148_Sum_LOS_OvarianCyst_NoProc FLOAT;
DECLARE @GY7148_Count_OvarianCyst_NoProc INT;
DECLARE @GY7148_Avg_LOS_OvarianCyst_NoProc FLOAT;

SELECT @GY7148_Sum_LOS_OvarianCyst_NoProc = SUM(Spell_LOS),
       @GY7148_Count_OvarianCyst_NoProc = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_Cond_IP = 'CondOvarianCyst'
      AND Gynae_Dominant_Procedure = 'NoProc'
      AND Admission_Sub_Type = 'EMR'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7148_Avg_LOS_OvarianCyst_NoProc
    = @GY7148_Sum_LOS_OvarianCyst_NoProc / NULLIF(@GY7148_Count_OvarianCyst_NoProc, 0);

SELECT 'GY7148 - Average LOS for Emergency Ovarian Cyst Admission without Procedure' AS Metric,
       @GY7148_Avg_LOS_OvarianCyst_NoProc AS Average_LOS,
	   @GY7148_Sum_LOS_OvarianCyst_NoProc AS Num,
       @GY7148_Count_OvarianCyst_NoProc AS Count_Spells;


/* Length of stay for emergency Bartholin's gland diagnosis 

SUM(Spell_LoS)
Gynae_Cond_IP = 'CondBartholin' 
AND POD_Derived IN ('EM')

COUNT(Spells)
Gynae_Cond_IP = 'CondBartholin' 
AND POD_Derived IN ('EM')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7149: Length of Stay for Emergency Bartholin's Gland Diagnosis

DECLARE @GY7149_Sum_LOS_Bartholin FLOAT;
DECLARE @GY7149_Count_Bartholin INT;
DECLARE @GY7149_Avg_LOS_Bartholin FLOAT;

SELECT @GY7149_Sum_LOS_Bartholin = SUM(Spell_LOS),
       @GY7149_Count_Bartholin = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_CondBartholin_IP = 1
      AND Admission_Sub_Type = 'EMR'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7149_Avg_LOS_Bartholin = @GY7149_Sum_LOS_Bartholin / NULLIF(@GY7149_Count_Bartholin, 0);

SELECT 'GY7149 - Average LOS for Emergency Bartholins Gland Diagnosis' AS Metric,
       @GY7149_Avg_LOS_Bartholin AS Average_LOS,
	   @GY7149_Sum_LOS_Bartholin AS Num,
       @GY7149_Count_Bartholin AS Count_Spells;

/* Procedure delivered during emergency Bartholin's gland admission 

COUNT(Spells) 
Gynae_Cond_IP = 'CondBartholin' 
AND Gynae_Proc_IP = 'ProcBartholin' 
AND POD_Derived IN ('EM')

COUNT(Spells)
Gynae_Cond_IP = 'CondBartholin' 
AND POD_Derived IN ('EM')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7150: Procedure Delivered During Emergency Bartholin's Gland Admission

DECLARE @GY7150_Num_Procedure_Bartholin INT;
DECLARE @GY7150_Denom_Bartholin INT;
DECLARE @GY7150_Rate_Procedure_Bartholin FLOAT;

-- Numerator
SELECT @GY7150_Num_Procedure_Bartholin = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_CondBartholin_IP = 1
      AND Gynae_ProcBartholin_IP = 1
      AND Admission_Sub_Type = 'EMR'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7150_Denom_Bartholin = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_CondBartholin_IP = 1
      AND Admission_Sub_Type = 'EMR'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7150_Rate_Procedure_Bartholin
    = (CAST(@GY7150_Num_Procedure_Bartholin AS FLOAT) / NULLIF(@GY7150_Denom_Bartholin, 0)) * 100;

SELECT 'GY7150 - Procedure Delivered During Emergency Bartholins Gland Admission' AS Metric,
       @GY7150_Rate_Procedure_Bartholin AS Percentage,
       @GY7150_Num_Procedure_Bartholin AS Numerator,
       @GY7150_Denom_Bartholin AS Denominator;


/* -------------------------------------------------------------------
	Other
------------------------------------------------------------------- */

/* Planned procedure not carried out rate 

COUNT(Spells)
Gynae_MainSpef_IP='Gynae_MainSpef'  
AND POD_Derived IN ('DC','EL') 
AND Planned_Proc_not_Carried_Out_IP = 'PlannedProcNotCarriedOut'

COUNT(Spells)
Gynae_MainSpef_IP='Gynae_MainSpef'  
AND POD_Derived IN ('DC','EL')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7151: Planned Procedure Not Carried Out Rate

DECLARE @GY7151_Num_PlannedProcNotCarriedOut INT;
DECLARE @GY7151_Denom_TotalElectives INT;
DECLARE @GY7151_Rate_PlannedProcNotCarriedOut FLOAT;

-- Numerator
SELECT @GY7151_Num_PlannedProcNotCarriedOut = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_MainSpef_IP = 1
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Planned_Proc_not_Carried_Out_IP = 1
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator
SELECT @GY7151_Denom_TotalElectives = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Gynae_MainSpef_IP = 1
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7151_Rate_PlannedProcNotCarriedOut
    = (CAST(@GY7151_Num_PlannedProcNotCarriedOut AS FLOAT) / NULLIF(@GY7151_Denom_TotalElectives, 0)) * 100;

SELECT 'GY7151 - Planned Procedure Not Carried Out Rate' AS Metric,
       @GY7151_Rate_PlannedProcNotCarriedOut AS Percentage,
       @GY7151_Num_PlannedProcNotCarriedOut AS Numerator,
       @GY7151_Denom_TotalElectives AS Denominator;

/* New to follow-up ratio for outpatient face-to-face appointments 

COUNT(OP Attendances)
(Gynae_MainSpef_OP = 'Gynae_MainSpef' OR Gynae_TretSpef_OP = 'Gynae_tretSpef') 
AND Gynae_Attend = 'Attend_1' 
AND POD_Face = 'Face2Face' 
And POD_Type ='Follow-up'

COUNT(OP Attendances)
(Gynae_MainSpef_OP = 'Gynae_MainSpef' OR Gynae_TretSpef_OP = 'Gynae_tretSpef') 
AND Gynae_Attend = 'Attend_1' 
AND POD_Face = 'Face2Face' 
And POD_Type = 'First'

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7152: New to Follow-Up Ratio for Outpatient Face-to-Face Appointments

DECLARE @GY7152_Num_FollowUp INT;
DECLARE @GY7152_Denom_First INT;
DECLARE @GY7152_Ratio_NewToFollowUp FLOAT;

-- Numerator: Follow-up attendances
SELECT @GY7152_Num_FollowUp = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
    INNER JOIN M0010_OP_Appointment M0010
        ON OPV.OP_Attendance_ID = M0010.OP_Attendance_ID
           AND OPV.Sector = M0010.Sector
WHERE (
          OPV.Gynae_MainSpef_OP = 1
          OR OPV.Gynae_TretSpef_OP = 1
      )
      AND OPV.Attendance_Status_Code IN ( '5', '6' ) -- ATTENDED
      AND M0010.M0010r_Face_To_Face_Booking = 1 -- POD_Face = 'Face2Face'
      AND M0010.M0010o_Follow_Up_Appointment = 1 -- POD_Type = 'Follow-up'
      AND OPV.Appointment_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator: First attendances
SELECT @GY7152_Denom_First = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
    INNER JOIN M0010_OP_Appointment M0010
        ON OPV.OP_Attendance_ID = M0010.OP_Attendance_ID
           AND OPV.Sector = M0010.Sector
WHERE (
          OPV.Gynae_MainSpef_OP = 1
          OR OPV.Gynae_TretSpef_OP = 1
      )
      AND OPV.Attendance_Status_Code IN ( '5', '6' ) -- ATTENDED
      AND M0010.M0010r_Face_To_Face_Booking = 1 -- POD_Face = 'Face2Face'
      AND M0010.M0010n_New_Appointment = 1 -- POD_Type = 'First'
      AND OPV.Appointment_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7152_Ratio_NewToFollowUp = CAST(@GY7152_Num_FollowUp AS FLOAT) / NULLIF(@GY7152_Denom_First, 0);

SELECT 'GY7152 - New to Follow-Up Ratio for Face-to-Face Appointments' AS Metric,
       @GY7152_Ratio_NewToFollowUp AS Ratio,
       @GY7152_Num_FollowUp AS Numerator,
       @GY7152_Denom_First AS Denominator;

/* Non face-to-face rate for outpatient attendances 

COUNT(OP Attendances)
(Gynae_MainSpef_OP = 'Gynae_MainSpef' OR Gynae_TretSpef_OP = 'Gynae_tretSpef') 
AND ATTENDED IN ('5','6') 
AND POD_Setting = 'Attendance' 
AND POD_Face = 'Virtual'

COUNT(OP Attendances)
(Gynae_MainSpef_OP = 'Gynae_MainSpef' OR Gynae_TretSpef_OP = 'Gynae_tretSpef')  
AND ATTENDED IN ('5','6') 
AND POD_Setting = 'Attendance'

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7153: Non Face-to-Face Rate for Outpatient Attendances

DECLARE @GY7153_Num_Virtual INT;
DECLARE @GY7153_Denom_TotalAttendances INT;
DECLARE @GY7153_Rate_Virtual FLOAT;

-- Numerator: Virtual attendances
SELECT @GY7153_Num_Virtual = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
    INNER JOIN M0010_OP_Appointment M0010
        ON OPV.OP_Attendance_ID = M0010.OP_Attendance_ID
           AND OPV.Sector = M0010.Sector
WHERE (
          OPV.Gynae_MainSpef_OP = 1
          OR OPV.Gynae_TretSpef_OP = 1
      )
      AND OPV.Attendance_Status_Code IN ( '5', '6' ) -- ATTENDED
      AND M0010.M0010l_Virtual_Booking = 1 -- POD_Face = 'Virtual'
      AND OPV.Appointment_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator: Total attendances
SELECT @GY7153_Denom_TotalAttendances = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
WHERE (
          OPV.Gynae_MainSpef_OP = 1
          OR OPV.Gynae_TretSpef_OP = 1
      )
      AND OPV.Attendance_Status_Code IN ( '5', '6' ) -- ATTENDED
      AND OPV.Appointment_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7153_Rate_Virtual = (CAST(@GY7153_Num_Virtual AS FLOAT) / NULLIF(@GY7153_Denom_TotalAttendances, 0)) * 100;

SELECT 'GY7153 - Non Face-to-Face Rate for Outpatient Attendances' AS Metric,
       @GY7153_Rate_Virtual AS Percentage,
       @GY7153_Num_Virtual AS Numerator,
       @GY7153_Denom_TotalAttendances AS Denominator;

/* Outpatient rate for colposcopy 

COUNT(OP attendances)
Gynae_HVLC_Pathways = 'Endometrial ablation' 
AND POD_Derived IN ('EL', 'DC') 
AND Gynae_FLAG_ReturnGynae90_HVLC = 1

COUNT(Spells + OP Attendances)
Gynae_Colposcopy_OP = 'Colposcopy' 
OR (Gynae_Colposcopy_IP = 'Colposcopy' 
AND POD_Derived IN ('DC','EL'))

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7154: Outpatient Rate for Colposcopy

DECLARE @GY7154_Num_OP_Colposcopy INT;
DECLARE @GY7154_Denom_TotalColposcopy INT;
DECLARE @GY7154_Rate_OP_Colposcopy FLOAT;

-- Numerator: Outpatient colposcopy attendances
SELECT @GY7154_Num_OP_Colposcopy = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
WHERE OPV.Gynae_Colposcopy_OP = 1
      AND OPV.Appointment_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator: Outpatient and inpatient colposcopy
SELECT @GY7154_Denom_TotalColposcopy =
(
    SELECT COUNT(DISTINCT OPV.OP_Attendance_ID)
    FROM #OP_Spells_With_Variables OPV
    WHERE OPV.Gynae_Colposcopy_OP = 1
          AND OPV.Appointment_Date
          BETWEEN @GY7100_StartDate AND @GY7100_EndDate
) +
(
    SELECT COUNT(DISTINCT SWV.Spell_Number)
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gynae_Colposcopy_IP = 1
          AND SWV.POD_Derived IN ( 'DC', 'EL' )
          AND SWV.Admission_Date
          BETWEEN @GY7100_StartDate AND @GY7100_EndDate
);

SET @GY7154_Rate_OP_Colposcopy
    = (CAST(@GY7154_Num_OP_Colposcopy AS FLOAT) / NULLIF(@GY7154_Denom_TotalColposcopy, 0)) * 100;

SELECT 'GY7154 - Outpatient Rate for Colposcopy' AS Metric,
       @GY7154_Rate_OP_Colposcopy AS Percentage,
       @GY7154_Num_OP_Colposcopy AS Numerator,
       @GY7154_Denom_TotalColposcopy AS Denominator;

/* Outpatient rate for hysteroscopy 

COUNT(Spells + OP Attendances)
Gynae_Hysteroscopy_OP = 'Hysteroscopy' 

COUNT(Spells + OP Attendances)
Gynae_Hysteroscopy_OP = 'Hysteroscopy' 
OR (Gynae_Hysteroscopy_IP = 'Hysteroscopy' 
AND POD_Derived IN ('DC','EL'))

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7155: Outpatient Rate for Hysteroscopy

DECLARE @GY7155_Num_OP_Hysteroscopy INT;
DECLARE @GY7155_Denom_TotalHysteroscopy INT;
DECLARE @GY7155_Rate_OP_Hysteroscopy FLOAT;

-- Numerator: Outpatient hysteroscopy attendances
SELECT @GY7155_Num_OP_Hysteroscopy = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
WHERE OPV.Gynae_Hysteroscopy_OP = 1
      AND OPV.Appointment_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator: Outpatient and inpatient hysteroscopy
SELECT @GY7155_Denom_TotalHysteroscopy =
(
    SELECT COUNT(DISTINCT OPV.OP_Attendance_ID)
    FROM #OP_Spells_With_Variables OPV
    WHERE OPV.Gynae_Hysteroscopy_OP = 1
          AND OPV.Appointment_Date
          BETWEEN @GY7100_StartDate AND @GY7100_EndDate
) +
(
    SELECT COUNT(DISTINCT SWV.Spell_Number)
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gynae_Hysteroscopy_IP = 1
          AND SWV.POD_Derived IN ( 'DC', 'EL' )
          AND SWV.Admission_Date
          BETWEEN @GY7100_StartDate AND @GY7100_EndDate
);

SET @GY7155_Rate_OP_Hysteroscopy
    = (CAST(@GY7155_Num_OP_Hysteroscopy AS FLOAT) / NULLIF(@GY7155_Denom_TotalHysteroscopy, 0)) * 100;

SELECT 'GY7155 - Outpatient Rate for Hysteroscopy' AS Metric,
       @GY7155_Rate_OP_Hysteroscopy AS Percentage,
       @GY7155_Num_OP_Hysteroscopy AS Numerator,
       @GY7155_Denom_TotalHysteroscopy AS Denominator;

/* Outpatient rate for cystoscopy 

COUNT(OP attendances)
Gynae_HVLC_Pathways = 'Hysteroscopy' 
AND POD_Derived IN ('EL', 'DC') 
AND Gynae_FLAG_ReturnGynae90_HVLC = 1

COUNT(Spells + OP Attendances)
(Gynae_Cystoscopy_OP = 'Cystoscopy' AND Gynae_MainSpef_OP = 'Gynae_MainSpef') 
OR (Gynae_Cystoscopy_IP = 'Cystoscopy' 
AND POD_Derived IN ('DC','EL') 
AND Gynae_MainSpef_IP = 'Gynae_MainSpef')

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7156: Outpatient Rate for Cystoscopy

DECLARE @GY7156_Num_OP_Cystoscopy INT;
DECLARE @GY7156_Denom_TotalCystoscopy INT;
DECLARE @GY7156_Rate_OP_Cystoscopy FLOAT;

-- Numerator: Outpatient cystoscopy attendances
SELECT @GY7156_Num_OP_Cystoscopy = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
WHERE OPV.Gynae_Cystoscopy_OP = 1
      AND OPV.Gynae_MainSpef_OP = 1
      AND OPV.Appointment_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator: Outpatient and inpatient cystoscopy
SELECT @GY7156_Denom_TotalCystoscopy =
(
    SELECT COUNT(DISTINCT OPV.OP_Attendance_ID)
    FROM #OP_Spells_With_Variables OPV
    WHERE OPV.Gynae_Cystoscopy_OP = 1
          AND OPV.Gynae_MainSpef_OP = 1
          AND OPV.Appointment_Date
          BETWEEN @GY7100_StartDate AND @GY7100_EndDate
) +
(
    SELECT COUNT(DISTINCT SWV.Spell_Number)
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gynae_Cystoscopy_IP = 1
          AND SWV.POD_Derived IN ( 'DC', 'EL' )
          AND SWV.Gynae_MainSpef_IP = 1
          AND SWV.Admission_Date
          BETWEEN @GY7100_StartDate AND @GY7100_EndDate
);

SET @GY7156_Rate_OP_Cystoscopy
    = (CAST(@GY7156_Num_OP_Cystoscopy AS FLOAT) / NULLIF(@GY7156_Denom_TotalCystoscopy, 0)) * 100;

SELECT 'GY7156 - Outpatient Rate for Cystoscopy' AS Metric,
       @GY7156_Rate_OP_Cystoscopy AS Percentage,
       @GY7156_Num_OP_Cystoscopy AS Numerator,
       @GY7156_Denom_TotalCystoscopy AS Denominator;

/* Therapeutic endoscopic operations on uterus % OP procedure 

COUNT(Attendances)
Gynae_Procedure_OP = 'Therapeutic_endoscopic_Proc'

COUNT(Spells + OP Attendances)
(Gynae_Proc_Ther_Endo= 'TherapeuticEndoProcdures' 
AND POD_Derived IN ('DC','EL')) 
OR Gynae_Procedure_OP = 'Therapeutic_endoscopic_Proc'

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7157: Therapeutic Endoscopic Operations on Uterus % OP Procedure

DECLARE @GY7157_Num_OP_TherapeuticEndo INT;
DECLARE @GY7157_Denom_TotalTherapeuticEndo INT;
DECLARE @GY7157_Rate_OP_TherapeuticEndo FLOAT;

-- Numerator: Outpatient therapeutic endoscopic procedures
SELECT @GY7157_Num_OP_TherapeuticEndo = COUNT(DISTINCT OPV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OPV
WHERE OPV.Gynae_Procedure_OP = 'Therapeutic_endoscopic_Proc'
      AND OPV.Appointment_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

-- Denominator: Inpatient and outpatient therapeutic endoscopic procedures
SELECT @GY7157_Denom_TotalTherapeuticEndo =
(
    SELECT COUNT(DISTINCT OPV.OP_Attendance_ID)
    FROM #OP_Spells_With_Variables OPV
    WHERE OPV.Gynae_Procedure_OP = 'Therapeutic_endoscopic_Proc'
          AND OPV.Appointment_Date
          BETWEEN @GY7100_StartDate AND @GY7100_EndDate
) +
(
    SELECT COUNT(DISTINCT SWV.Spell_Number)
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gynae_Proc_Ther_Endo = 1
          AND SWV.POD_Derived IN ( 'DC', 'EL' )
          AND SWV.Admission_Date
          BETWEEN @GY7100_StartDate AND @GY7100_EndDate
);

SET @GY7157_Rate_OP_TherapeuticEndo
    = (CAST(@GY7157_Num_OP_TherapeuticEndo AS FLOAT) / NULLIF(@GY7157_Denom_TotalTherapeuticEndo, 0)) * 100;

SELECT 'GY7157 - Therapeutic Endoscopic Operations on Uterus % OP Procedure' AS Metric,
       @GY7157_Rate_OP_TherapeuticEndo AS Percentage,
       @GY7157_Num_OP_TherapeuticEndo AS Numerator,
       @GY7157_Denom_TotalTherapeuticEndo AS Denominator;


/* Myomectomy: % hysteroscopic 

COUNT(Spells)
NCIP_Procedure_Main = 'Myomectomy | age 17+ | elective' 
AND NCIP_Approach_Subgroup = 'Hysteroscopic' 

COUNT(Spells)
NCIP_Procedure_Main = 'Myomectomy | age 17+ | elective'

*/

DECLARE @GY7100_StartDate DATE = '2023-07-01'; -- Adjust as needed
DECLARE @GY7100_EndDate DATE = '2024-06-30'; -- Adjust as needed

-- Metric GY7158: Myomectomy: % Hysteroscopic

DECLARE @GY7158_Num_Hysteroscopic INT;
DECLARE @GY7158_Denom_Myomectomy INT;
DECLARE @GY7158_Rate_Hysteroscopic FLOAT;

SELECT @GY7158_Num_Hysteroscopic = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Procedure_Normalised] ipp
        ON ipe.Episode_Number = ipp.Episode_Number
           AND ipe.Sector = ipp.Sector
WHERE SWV.Procedure_Main = 'Myomectomy | age 17+ | elective'
      AND SWV.Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate
      AND EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp_hyst
    WHERE ipp_hyst.Episode_Number = ipe.Episode_Number
          AND ipp_hyst.Sector = ipe.Sector
          AND LEFT(ipp_hyst.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Hysteroscopic_4
              )
)
      AND NOT EXISTS
(
    SELECT 1
    FROM [PAS_IP_Procedure_Normalised] ipp_conv
    WHERE ipp_conv.Episode_Number = ipe.Episode_Number
          AND ipp_conv.Sector = ipe.Sector
          AND LEFT(ipp_conv.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ConversionToOpenApproach_4
              )
);

-- Denominator
SELECT @GY7158_Denom_Myomectomy = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE Procedure_Main = 'Myomectomy | age 17+ | elective'
      AND Admission_Date
      BETWEEN @GY7100_StartDate AND @GY7100_EndDate;

SET @GY7158_Rate_Hysteroscopic
    = (CAST(@GY7158_Num_Hysteroscopic AS FLOAT) / NULLIF(@GY7158_Denom_Myomectomy, 0)) * 100;

SELECT 'GY7158 - Myomectomy: % Hysteroscopic' AS Metric,
       @GY7158_Rate_Hysteroscopic AS Percentage,
       @GY7158_Num_Hysteroscopic AS Numerator,
       @GY7158_Denom_Myomectomy AS Denominator;


