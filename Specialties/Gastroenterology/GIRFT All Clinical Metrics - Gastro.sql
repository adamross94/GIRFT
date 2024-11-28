/*
	
	Script Title: GIRFT All Clinical Metrics - Gastroenterology
	Author: Adam Ross
	Version: 1.0
	Description: This script generates the figures for the All Clinical metrics section 
	of the Model Hospital dashboard. It covers the following Classes:

	- Features of Gastroenterology Services
	- Endoscopy - Gastroscopy
	- Endoscopy - Colonoscopy
	- Endoscopy - Flexible Sigmoidoscopy
	- Endoscopy - ERCP
	- Upper Gastrointestinal Bleeds
	- Liver Disease
	- Complications of Liver Disease
	- Alcoholic Liver Disease
	- Non-alcoholic Liver Disease
	- Luminal Gastroenterology - Ulcerative Colitis
	- Luminal Gastroenterology - Crohns Disease
	- Nutrition

*/

-- SQL Code Begins

-- ========================================
-- Step 1: Drop Temporary Tables if They Exist
-- ========================================




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


-- ============================================================
-- Step 3: Create and Populate Temporary Tables for CodeGroups
-- ============================================================

-- -----------------------
-- Code Group: ViralHepititis_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ViralHepititis_3') IS NOT NULL
    DROP TABLE #CodeGroup_ViralHepititis_3;

CREATE TABLE #CodeGroup_ViralHepititis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ViralHepititis_3
(
    Code
)
VALUES
('B15'),
('B16'),
('B17'),
('B18'),
('B19');

-- -----------------------
-- Code Group: Risk_HCC_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Risk_HCC_3') IS NOT NULL
    DROP TABLE #CodeGroup_Risk_HCC_3;

CREATE TABLE #CodeGroup_Risk_HCC_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Risk_HCC_3
(
    Code
)
VALUES
('B16');

-- -----------------------
-- Code Group: Risk_HCC_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Risk_HCC_4') IS NOT NULL
    DROP TABLE #CodeGroup_Risk_HCC_4;

CREATE TABLE #CodeGroup_Risk_HCC_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Risk_HCC_4
(
    Code
)
VALUES
('B170'),
('B171'),
('B180'),
('B181'),
('B182');

-- -----------------------
-- Code Group: H_pylori_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_H_pylori_4') IS NOT NULL
    DROP TABLE #CodeGroup_H_pylori_4;

CREATE TABLE #CodeGroup_H_pylori_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_H_pylori_4
(
    Code
)
VALUES
('B980');

-- -----------------------
-- Code Group: Hepatoma_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Hepatoma_4') IS NOT NULL
    DROP TABLE #CodeGroup_Hepatoma_4;

CREATE TABLE #CodeGroup_Hepatoma_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Hepatoma_4
(
    Code
)
VALUES
('C220');

-- -----------------------
-- Code Group: Cancer_bileduct_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cancer_bileduct_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cancer_bileduct_4;

CREATE TABLE #CodeGroup_Cancer_bileduct_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cancer_bileduct_4
(
    Code
)
VALUES
('C221'),
('C253');

-- -----------------------
-- Code Group: Cancer_bileduct_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cancer_bileduct_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cancer_bileduct_3;

CREATE TABLE #CodeGroup_Cancer_bileduct_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cancer_bileduct_3
(
    Code
)
VALUES
('C24');

-- -----------------------
-- Code Group: Metastasis_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Metastasis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Metastasis_3;

CREATE TABLE #CodeGroup_Metastasis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Metastasis_3
(
    Code
)
VALUES
('C77'),
('C78'),
('C79');

-- -----------------------
-- Code Group: AKI_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AKI_4') IS NOT NULL
    DROP TABLE #CodeGroup_AKI_4;

CREATE TABLE #CodeGroup_AKI_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AKI_4
(
    Code
)
VALUES
('E871');

-- -----------------------
-- Code Group: AlcoholUse_MentalHealth_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AlcoholUse_MentalHealth_3') IS NOT NULL
    DROP TABLE #CodeGroup_AlcoholUse_MentalHealth_3;

CREATE TABLE #CodeGroup_AlcoholUse_MentalHealth_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AlcoholUse_MentalHealth_3
(
    Code
)
VALUES
('F10');

-- -----------------------
-- Code Group: AlcoholDependency_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AlcoholDependency_4') IS NOT NULL
    DROP TABLE #CodeGroup_AlcoholDependency_4;

CREATE TABLE #CodeGroup_AlcoholDependency_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AlcoholDependency_4
(
    Code
)
VALUES
('F101'),
('F102');

-- -----------------------
-- Code Group: EncephalopathyA_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_EncephalopathyA_4') IS NOT NULL
    DROP TABLE #CodeGroup_EncephalopathyA_4;

CREATE TABLE #CodeGroup_EncephalopathyA_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EncephalopathyA_4
(
    Code
)
VALUES
('G92X'),
('G934');

-- -----------------------
-- Code Group: Complications_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Complications_3') IS NOT NULL
    DROP TABLE #CodeGroup_Complications_3;

CREATE TABLE #CodeGroup_Complications_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Complications_3
(
    Code
)
VALUES
('G97'),
('H59'),
('H95'),
('I97'),
('I982'),
('J95'),
('K91'),
('K92'),
('M96'),
('N99'),
('O29'),
('O74'),
('O89'),
('T80'),
('T81'),
('T82'),
('T83'),
('T84'),
('T85'),
('T86'),
('T87'),
('T88'),
('Y60'),
('Y61'),
('Y62'),
('Y63'),
('Y64'),
('Y65'),
('Y66'),
('Y69'),
('Y70'),
('Y71'),
('Y72'),
('Y73'),
('Y74'),
('Y75'),
('Y76'),
('Y77'),
('Y78'),
('Y79'),
('Y80'),
('Y81'),
('Y82'),
('Y83'),
('Y84');

-- -----------------------
-- Code Group: Thromboembolic_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Thromboembolic_3') IS NOT NULL
    DROP TABLE #CodeGroup_Thromboembolic_3;

CREATE TABLE #CodeGroup_Thromboembolic_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Thromboembolic_3
(
    Code
)
VALUES
('I21'),
('I26'),
('I74'),
('I80'),
('I81'),
('I82');

-- -----------------------
-- Code Group: Thromboembolic_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Thromboembolic_4') IS NOT NULL
    DROP TABLE #CodeGroup_Thromboembolic_4;

CREATE TABLE #CodeGroup_Thromboembolic_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Thromboembolic_4
(
    Code
)
VALUES
('I630'),
('I631'),
('I633'),
('I634'),
('I636');

-- -----------------------
-- Code Group: UpperGI_bleeding_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_UpperGI_bleeding_4') IS NOT NULL
    DROP TABLE #CodeGroup_UpperGI_bleeding_4;

CREATE TABLE #CodeGroup_UpperGI_bleeding_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UpperGI_bleeding_4
(
    Code
)
VALUES
('I850'),
('I983'),
('K920'),
('K921'),
('K922');

-- -----------------------
-- Code Group: OesophagealVariceal_bleed_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OesophagealVariceal_bleed_4') IS NOT NULL
    DROP TABLE #CodeGroup_OesophagealVariceal_bleed_4;

CREATE TABLE #CodeGroup_OesophagealVariceal_bleed_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OesophagealVariceal_bleed_4
(
    Code
)
VALUES
('I850'),
('I983');

-- -----------------------
-- Code Group: OesophagealVariceal_NoBleed_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OesophagealVariceal_NoBleed_4') IS NOT NULL
    DROP TABLE #CodeGroup_OesophagealVariceal_NoBleed_4;

CREATE TABLE #CodeGroup_OesophagealVariceal_NoBleed_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OesophagealVariceal_NoBleed_4
(
    Code
)
VALUES
('I859'),
('I982');

-- -----------------------
-- Code Group: GastricVarices_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_GastricVarices_4') IS NOT NULL
    DROP TABLE #CodeGroup_GastricVarices_4;

CREATE TABLE #CodeGroup_GastricVarices_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_GastricVarices_4
(
    Code
)
VALUES
('I864');

-- -----------------------
-- Code Group: GastricUlcer_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_GastricUlcer_3') IS NOT NULL
    DROP TABLE #CodeGroup_GastricUlcer_3;

CREATE TABLE #CodeGroup_GastricUlcer_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_GastricUlcer_3
(
    Code
)
VALUES
('K25');

-- -----------------------
-- Code Group: GastricUlcer_haem_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_GastricUlcer_haem_4') IS NOT NULL
    DROP TABLE #CodeGroup_GastricUlcer_haem_4;

CREATE TABLE #CodeGroup_GastricUlcer_haem_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_GastricUlcer_haem_4
(
    Code
)
VALUES
('K250'),
('K252'),
('K254'),
('K256');

-- -----------------------
-- Code Group: GastricUlcer_perf_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_GastricUlcer_perf_4') IS NOT NULL
    DROP TABLE #CodeGroup_GastricUlcer_perf_4;

CREATE TABLE #CodeGroup_GastricUlcer_perf_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_GastricUlcer_perf_4
(
    Code
)
VALUES
('K251'),
('K252'),
('K255'),
('K256');

-- -----------------------
-- Code Group: DuodenalUlcer_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_DuodenalUlcer_3') IS NOT NULL
    DROP TABLE #CodeGroup_DuodenalUlcer_3;

CREATE TABLE #CodeGroup_DuodenalUlcer_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_DuodenalUlcer_3
(
    Code
)
VALUES
('K26');

-- -----------------------
-- Code Group: DuodenalUlcer_haem_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_DuodenalUlcer_haem_4') IS NOT NULL
    DROP TABLE #CodeGroup_DuodenalUlcer_haem_4;

CREATE TABLE #CodeGroup_DuodenalUlcer_haem_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_DuodenalUlcer_haem_4
(
    Code
)
VALUES
('K260'),
('K262'),
('K264'),
('K266');

-- -----------------------
-- Code Group: DuodenalUlcer_perf_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_DuodenalUlcer_perf_4') IS NOT NULL
    DROP TABLE #CodeGroup_DuodenalUlcer_perf_4;

CREATE TABLE #CodeGroup_DuodenalUlcer_perf_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_DuodenalUlcer_perf_4
(
    Code
)
VALUES
('K261'),
('K262'),
('K265'),
('K266');

-- -----------------------
-- Code Group: AlcoholInducedGastritis_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AlcoholInducedGastritis_4') IS NOT NULL
    DROP TABLE #CodeGroup_AlcoholInducedGastritis_4;

CREATE TABLE #CodeGroup_AlcoholInducedGastritis_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AlcoholInducedGastritis_4
(
    Code
)
VALUES
('K292'),
('K852'),
('K860');

-- -----------------------
-- Code Group: IBD_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_IBD_3') IS NOT NULL
    DROP TABLE #CodeGroup_IBD_3;

CREATE TABLE #CodeGroup_IBD_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_IBD_3
(
    Code
)
VALUES
('K52');

-- -----------------------
-- Code Group: Megacolon_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Megacolon_4') IS NOT NULL
    DROP TABLE #CodeGroup_Megacolon_4;

CREATE TABLE #CodeGroup_Megacolon_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Megacolon_4
(
    Code
)
VALUES
('K593');

-- -----------------------
-- Code Group: UpperGIComplic_PostProcedure_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_UpperGIComplic_PostProcedure_3') IS NOT NULL
    DROP TABLE #CodeGroup_UpperGIComplic_PostProcedure_3;

CREATE TABLE #CodeGroup_UpperGIComplic_PostProcedure_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UpperGIComplic_PostProcedure_3
(
    Code
)
VALUES
('K631');

-- -----------------------
-- Code Group: Colon_polyp_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Colon_polyp_4') IS NOT NULL
    DROP TABLE #CodeGroup_Colon_polyp_4;

CREATE TABLE #CodeGroup_Colon_polyp_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Colon_polyp_4
(
    Code
)
VALUES
('K635');

-- --------------------------------------
-- Code Group: Spon_bact_peritonitis_3
-- --------------------------------------

IF OBJECT_ID('tempdb..#CodeGroup_Spon_bact_peritonitis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Spon_bact_peritonitis_3;

CREATE TABLE #CodeGroup_Spon_bact_peritonitis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Spon_bact_peritonitis_3
(
    Code
)
VALUES
('K65');

-- -----------------------
-- Code Group: AlcoholicLD_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AlcoholicLD_3') IS NOT NULL
    DROP TABLE #CodeGroup_AlcoholicLD_3;

CREATE TABLE #CodeGroup_AlcoholicLD_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AlcoholicLD_3
(
    Code
)
VALUES
('K70');

-- -----------------------
-- Code Group: AlcoholicCirrhosis_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AlcoholicCirrhosis_4') IS NOT NULL
    DROP TABLE #CodeGroup_AlcoholicCirrhosis_4;

CREATE TABLE #CodeGroup_AlcoholicCirrhosis_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AlcoholicCirrhosis_4
(
    Code
)
VALUES
('K703');

-- -----------------------
-- Code Group: GeneralLD_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_GeneralLD_3') IS NOT NULL
    DROP TABLE #CodeGroup_GeneralLD_3;

CREATE TABLE #CodeGroup_GeneralLD_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_GeneralLD_3
(
    Code
)
VALUES
('K71'),
('K73'),
('K74'),
('K76');

-- -----------------------
-- Code Group: NonAlcholicCirrhosis_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_NonAlcholicCirrhosis_4') IS NOT NULL
    DROP TABLE #CodeGroup_NonAlcholicCirrhosis_4;

CREATE TABLE #CodeGroup_NonAlcholicCirrhosis_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_NonAlcholicCirrhosis_4
(
    Code
)
VALUES
('K717'),
('K743'),
('K744'),
('K745'),
('K746');

-- -----------------------
-- Code Group: ChronicHepaticFailure_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ChronicHepaticFailure_3') IS NOT NULL
    DROP TABLE #CodeGroup_ChronicHepaticFailure_3;

CREATE TABLE #CodeGroup_ChronicHepaticFailure_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ChronicHepaticFailure_3
(
    Code
)
VALUES
('K72');

-- -----------------------
-- Code Group: Encephalopathy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Encephalopathy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Encephalopathy_3;

CREATE TABLE #CodeGroup_Encephalopathy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Encephalopathy_3
(
    Code
)
VALUES
('K72');

-- -----------------------
-- Code Group: NonAlcoholFattyLD_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_NonAlcoholFattyLD_4') IS NOT NULL
    DROP TABLE #CodeGroup_NonAlcoholFattyLD_4;

CREATE TABLE #CodeGroup_NonAlcoholFattyLD_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_NonAlcoholFattyLD_4
(
    Code
)
VALUES
('K760');

-- -----------------------
-- Code Group: OtherLiverDisease
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OtherLiverDisease') IS NOT NULL
    DROP TABLE #CodeGroup_OtherLiverDisease;

CREATE TABLE #CodeGroup_OtherLiverDisease
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OtherLiverDisease
(
    Code
)
VALUES
('K71'),
('K73'),
('K74'),
('K76');

-- -----------------------
-- Code Group: OtherLiverDiseaseExc
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OtherLiverDiseaseExc') IS NOT NULL
    DROP TABLE #CodeGroup_OtherLiverDiseaseExc;

CREATE TABLE #CodeGroup_OtherLiverDiseaseExc
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OtherLiverDiseaseExc
(
    Code
)
VALUES
('K717'),
('K743'),
('K744'),
('K745'),
('K746');

-- -----------------------
-- Code Group: LiverDisorder_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_LiverDisorder_3') IS NOT NULL
    DROP TABLE #CodeGroup_LiverDisorder_3;

CREATE TABLE #CodeGroup_LiverDisorder_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_LiverDisorder_3
(
    Code
)
VALUES
('K77');

-- -----------------------
-- Code Group: Cholelithiasis_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cholelithiasis_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cholelithiasis_3;

CREATE TABLE #CodeGroup_Cholelithiasis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cholelithiasis_3
(
    Code
)
VALUES
('K80');

-- -----------------------
-- Code Group: ERCPComplic_Cholangitis_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCPComplic_Cholangitis_4') IS NOT NULL
    DROP TABLE #CodeGroup_ERCPComplic_Cholangitis_4;

CREATE TABLE #CodeGroup_ERCPComplic_Cholangitis_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCPComplic_Cholangitis_4
(
    Code
)
VALUES
('K803'),
('K830');

-- -----------------------
-- Code Group: ERCPComplic_Perforation_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCPComplic_Perforation_4') IS NOT NULL
    DROP TABLE #CodeGroup_ERCPComplic_Perforation_4;

CREATE TABLE #CodeGroup_ERCPComplic_Perforation_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCPComplic_Perforation_4
(
    Code
)
VALUES
('K822'),
('K832'),
('T812');

-- -----------------------
-- Code Group: OtherDiseaseBileDuct_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OtherDiseaseBileDuct_3') IS NOT NULL
    DROP TABLE #CodeGroup_OtherDiseaseBileDuct_3;

CREATE TABLE #CodeGroup_OtherDiseaseBileDuct_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OtherDiseaseBileDuct_3
(
    Code
)
VALUES
('K83');

-- -----------------------
-- Code Group: ERCPComplic_Pancreatitis_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCPComplic_Pancreatitis_3') IS NOT NULL
    DROP TABLE #CodeGroup_ERCPComplic_Pancreatitis_3;

CREATE TABLE #CodeGroup_ERCPComplic_Pancreatitis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCPComplic_Pancreatitis_3
(
    Code
)
VALUES
('K85');

-- -----------------------
-- Code Group: ERCPComplic_Pancreatitis_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCPComplic_Pancreatitis_4') IS NOT NULL
    DROP TABLE #CodeGroup_ERCPComplic_Pancreatitis_4;

CREATE TABLE #CodeGroup_ERCPComplic_Pancreatitis_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCPComplic_Pancreatitis_4
(
    Code
)
VALUES
('K860'),
('K861');

-- -----------------------
-- Code Group: OtherDiseaseBileDuct_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OtherDiseaseBileDuct_4') IS NOT NULL
    DROP TABLE #CodeGroup_OtherDiseaseBileDuct_4;

CREATE TABLE #CodeGroup_OtherDiseaseBileDuct_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OtherDiseaseBileDuct_4
(
    Code
)
VALUES
('K870');

-- -----------------------
-- Code Group: Complications_3 (Final Entries)
-- -----------------------

-- Ensure all unique codes are included

INSERT INTO #CodeGroup_Complications_3
(
    Code
)
VALUES
('J95'),
('K91');

-- -----------------------
-- Code Group: Palliative_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Palliative_4') IS NOT NULL
    DROP TABLE #CodeGroup_Palliative_4;

CREATE TABLE #CodeGroup_Palliative_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Palliative_4
(
    Code
)
VALUES
('Z515');

-- -----------------------
-- Code Group: Cancellation_all_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cancellation_all_3') IS NOT NULL
    DROP TABLE #CodeGroup_Cancellation_all_3;

CREATE TABLE #CodeGroup_Cancellation_all_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cancellation_all_3
(
    Code
)
VALUES
('Z53');

-- -----------------------
-- Code Group: OesophagoGastroduodenoscopy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OesophagoGastroduodenoscopy_3') IS NOT NULL
    DROP TABLE #CodeGroup_OesophagoGastroduodenoscopy_3;

CREATE TABLE #CodeGroup_OesophagoGastroduodenoscopy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OesophagoGastroduodenoscopy_3
(
    Code
)
VALUES
('G12'),
('G14'),
('G15'),
('G17'),
('G18'),
('G20'),
('G42'),
('G43'),
('G44'),
('G46'),
('G54');

-- -----------------------
-- Code Group: UpperGIVariceal_banding_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_UpperGIVariceal_banding_4') IS NOT NULL
    DROP TABLE #CodeGroup_UpperGIVariceal_banding_4;

CREATE TABLE #CodeGroup_UpperGIVariceal_banding_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UpperGIVariceal_banding_4
(
    Code
)
VALUES
('G437');

-- -----------------------
-- Code Group: Perc_endo_Gastro_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Perc_endo_Gastro_4') IS NOT NULL
    DROP TABLE #CodeGroup_Perc_endo_Gastro_4;

CREATE TABLE #CodeGroup_Perc_endo_Gastro_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Perc_endo_Gastro_4
(
    Code
)
VALUES
('G445');

-- -----------------------
-- Code Group: Colonoscopy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Colonoscopy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Colonoscopy_3;

CREATE TABLE #CodeGroup_Colonoscopy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Colonoscopy_3
(
    Code
)
VALUES
('H20'),
('H21');

-- -----------------------
-- Code Group: ColonoscopyDiag_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ColonoscopyDiag_3') IS NOT NULL
    DROP TABLE #CodeGroup_ColonoscopyDiag_3;

CREATE TABLE #CodeGroup_ColonoscopyDiag_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ColonoscopyDiag_3
(
    Code
)
VALUES
('H22');

-- -----------------------
-- Code Group: Flex_sig_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Flex_sig_3') IS NOT NULL
    DROP TABLE #CodeGroup_Flex_sig_3;

CREATE TABLE #CodeGroup_Flex_sig_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Flex_sig_3
(
    Code
)
VALUES
('H23'),
('H24');

-- -----------------------
-- Code Group: ACS_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ACS_3') IS NOT NULL
    DROP TABLE #CodeGroup_ACS_3;

CREATE TABLE #CodeGroup_ACS_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ACS_3
(
    Code
)
VALUES
('H25');

-- -----------------------
-- Code Group: Flex_sig_Diag_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Flex_sig_Diag_3') IS NOT NULL
    DROP TABLE #CodeGroup_Flex_sig_Diag_3;

CREATE TABLE #CodeGroup_Flex_sig_Diag_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Flex_sig_Diag_3
(
    Code
)
VALUES
('H25');

-- -----------------------
-- Code Group: Rigid_sig_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Rigid_sig_3') IS NOT NULL
    DROP TABLE #CodeGroup_Rigid_sig_3;

CREATE TABLE #CodeGroup_Rigid_sig_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Rigid_sig_3
(
    Code
)
VALUES
('H26'),
('H27');

-- -----------------------
-- Code Group: Rigid_sig_Diag_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Rigid_sig_Diag_3') IS NOT NULL
    DROP TABLE #CodeGroup_Rigid_sig_Diag_3;

CREATE TABLE #CodeGroup_Rigid_sig_Diag_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Rigid_sig_Diag_3
(
    Code
)
VALUES
('H28');

-- -----------------------
-- Code Group: Liver_biopsy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Liver_biopsy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Liver_biopsy_4;

CREATE TABLE #CodeGroup_Liver_biopsy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Liver_biopsy_4
(
    Code
)
VALUES
('J053'),
('J091'),
('J092'),
('J131'),
('J132'),
('J141'),
('J171');

-- -----------------------
-- Code Group: ERCP_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCP_3') IS NOT NULL
    DROP TABLE #CodeGroup_ERCP_3;

CREATE TABLE #CodeGroup_ERCP_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCP_3
(
    Code
)
VALUES
('J38'),
('J39'),
('J40'),
('J41'),
('J42');

-- -----------------------
-- Code Group: ERCP_Sphincterotomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCP_Sphincterotomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ERCP_Sphincterotomy_4;

CREATE TABLE #CodeGroup_ERCP_Sphincterotomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCP_Sphincterotomy_4
(
    Code
)
VALUES
('J381'),
('J382'),
('J391');

-- -----------------------
-- Code Group: ERCP_StoneExtraction_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCP_StoneExtraction_4') IS NOT NULL
    DROP TABLE #CodeGroup_ERCP_StoneExtraction_4;

CREATE TABLE #CodeGroup_ERCP_StoneExtraction_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCP_StoneExtraction_4
(
    Code
)
VALUES
('J381'),
('J411'),
('J423');

-- -----------------------
-- Code Group: ERCP_InsertStent_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCP_InsertStent_4') IS NOT NULL
    DROP TABLE #CodeGroup_ERCP_InsertStent_4;

CREATE TABLE #CodeGroup_ERCP_InsertStent_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCP_InsertStent_4
(
    Code
)
VALUES
('J382'),
('J394'),
('J401'),
('J402'),
('J403'),
('J404'),
('J405'),
('J406'),
('J407'),
('J408'),
('J409'),
('J421'),
('J422');

-- -----------------------
-- Code Group: ERCP_RemoveStent_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCP_RemoveStent_4') IS NOT NULL
    DROP TABLE #CodeGroup_ERCP_RemoveStent_4;

CREATE TABLE #CodeGroup_ERCP_RemoveStent_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCP_RemoveStent_4
(
    Code
)
VALUES
('J404');

-- -----------------------
-- Code Group: ERCP_Dilation_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCP_Dilation_4') IS NOT NULL
    DROP TABLE #CodeGroup_ERCP_Dilation_4;

CREATE TABLE #CodeGroup_ERCP_Dilation_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCP_Dilation_4
(
    Code
)
VALUES
('J412');

-- -----------------------
-- Code Group: ERCP_Lithotripsy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCP_Lithotripsy_4') IS NOT NULL
    DROP TABLE #CodeGroup_ERCP_Lithotripsy_4;

CREATE TABLE #CodeGroup_ERCP_Lithotripsy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCP_Lithotripsy_4
(
    Code
)
VALUES
('J413');

-- -----------------------
-- Code Group: ERCPDiag_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ERCPDiag_3') IS NOT NULL
    DROP TABLE #CodeGroup_ERCPDiag_3;

CREATE TABLE #CodeGroup_ERCPDiag_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ERCPDiag_3
(
    Code
)
VALUES
('J43'),
('J44'),
('J45');

-- -----------------------
-- Code Group: EUSDiag_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_EUSDiag_3') IS NOT NULL
    DROP TABLE #CodeGroup_EUSDiag_3;

CREATE TABLE #CodeGroup_EUSDiag_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_EUSDiag_3
(
    Code
)
VALUES
('J51'),
('J53');

-- -----------------------
-- Code Group: Ascitic_tap_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Ascitic_tap_4') IS NOT NULL
    DROP TABLE #CodeGroup_Ascitic_tap_4;

CREATE TABLE #CodeGroup_Ascitic_tap_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Ascitic_tap_4
(
    Code
)
VALUES
('T461');

-- -----------------------
-- Code Group: Ascitic_drain_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Ascitic_drain_4') IS NOT NULL
    DROP TABLE #CodeGroup_Ascitic_drain_4;

CREATE TABLE #CodeGroup_Ascitic_drain_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Ascitic_drain_4
(
    Code
)
VALUES
('T462');

-- -----------------------
-- Code Group: TPN_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_TPN_4') IS NOT NULL
    DROP TABLE #CodeGroup_TPN_4;

CREATE TABLE #CodeGroup_TPN_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_TPN_4
(
    Code
)
VALUES
('X904'),
('X921');

-- -----------------------
-- Code Group: Attended_5_6
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Attended_5_6') IS NOT NULL
    DROP TABLE #CodeGroup_Attended_5_6;

CREATE TABLE #CodeGroup_Attended_5_6
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Attended_5_6
(
    Code
)
VALUES
('5'),
('6');

-- -----------------------
-- Code Group: MAINSPEC_GEN
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_MAINSPEC_GEN') IS NOT NULL
    DROP TABLE #CodeGroup_MAINSPEC_GEN;

CREATE TABLE #CodeGroup_MAINSPEC_GEN
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_MAINSPEC_GEN
(
    Code
)
VALUES
('300');

-- -----------------------
-- Code Group: MAINSPEC_GASTRO
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_MAINSPEC_GASTRO') IS NOT NULL
    DROP TABLE #CodeGroup_MAINSPEC_GASTRO;

CREATE TABLE #CodeGroup_MAINSPEC_GASTRO
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_MAINSPEC_GASTRO
(
    Code
)
VALUES
('301');

-- -----------------------
-- Code Group: TRETSPEC_GASTRO
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_TRETSPEC_GASTRO') IS NOT NULL
    DROP TABLE #CodeGroup_TRETSPEC_GASTRO;

CREATE TABLE #CodeGroup_TRETSPEC_GASTRO
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_TRETSPEC_GASTRO
(
    Code
)
VALUES
('301');

-- -----------------------
-- Code Group: TRETSPEC_HEP
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_TRETSPEC_HEP') IS NOT NULL
    DROP TABLE #CodeGroup_TRETSPEC_HEP;

CREATE TABLE #CodeGroup_TRETSPEC_HEP
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_TRETSPEC_HEP
(
    Code
)
VALUES
('306');

-- -----------------------
-- Code Group: BucketDiag_2
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_BucketDiag_2') IS NOT NULL
    DROP TABLE #CodeGroup_BucketDiag_2;

CREATE TABLE #CodeGroup_BucketDiag_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_BucketDiag_2
(
    Code
)
VALUES
('B1'),
('C1'),
('C2'),
('I8'),
('I9'),
('K5'),
('K7'),
('K8'),
('T8'),
('Y6'),
('Y7'),
('Y8');

-- -----------------------
-- Code Group: BucketDiag_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_BucketDiag_3') IS NOT NULL
    DROP TABLE #CodeGroup_BucketDiag_3;

CREATE TABLE #CodeGroup_BucketDiag_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_BucketDiag_3
(
    Code
)
VALUES
('B98'),
('C77'),
('C78'),
('C79'),
('E87'),
('F10'),
('G92'),
('G93'),
('G97'),
('H59'),
('H95'),
('I21'),
('I26'),
('I63'),
('I74'),
('K25'),
('K26'),
('K29'),
('K63'),
('K65'),
('K91'),
('K92'),
('M96'),
('N17'),
('N99'),
('O29'),
('O74'),
('O89'),
('R18'),
('Z51'),
('Z53');

-- -----------------------
-- Code Group: BucketProc_2
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_BucketProc_2') IS NOT NULL
    DROP TABLE #CodeGroup_BucketProc_2;

CREATE TABLE #CodeGroup_BucketProc_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_BucketProc_2
(
    Code
)
VALUES
('G1'),
('G4'),
('H0'),
('H2'),
('J4');

-- -----------------------
-- Code Group: BucketProc_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_BucketProc_3') IS NOT NULL
    DROP TABLE #CodeGroup_BucketProc_3;

CREATE TABLE #CodeGroup_BucketProc_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_BucketProc_3
(
    Code
)
VALUES
('G20'),
('G54'),
('G55'),
('G72'),
('H10'),
('H11'),
('H29'),
('H33'),
('H40'),
('H41'),
('J05'),
('J09'),
('J13'),
('J14'),
('J17'),
('J38'),
('J39'),
('J51'),
('J53'),
('T46'),
('X14'),
('X90'),
('X92');

-- -----------------------
-- Code Group: Oesophago_gastric_cancer
-- -----------------------

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

-- -----------------------
-- Code Group: SmallIntestineCancer_3
-- -----------------------

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

-- -----------------------
-- Code Group: ColorectalCancer_3_2
-- -----------------------

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

-- -----------------------
-- Code Group: ColorectalCancer_3_4
-- -----------------------

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

-- -----------------------
-- Code Group: ColorectalCancer_3_3
-- -----------------------

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

-- -----------------------
-- Code Group: ColorectalCancer_3_1
-- -----------------------

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

-- -----------------------
-- Code Group: Primary_liver_cell_cancer
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Primary_liver_cell_cancer') IS NOT NULL
    DROP TABLE #CodeGroup_Primary_liver_cell_cancer;

CREATE TABLE #CodeGroup_Primary_liver_cell_cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Primary_liver_cell_cancer
(
    Code
)
VALUES
('C220');

-- -----------------------
-- Code Group: Other_primary_liver_cancer
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Other_primary_liver_cancer') IS NOT NULL
    DROP TABLE #CodeGroup_Other_primary_liver_cancer;

CREATE TABLE #CodeGroup_Other_primary_liver_cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Other_primary_liver_cancer
(
    Code
)
VALUES
('C222'),
('C223'),
('C224'),
('C227'),
('C229');

-- -----------------------
-- Code Group: Gall_bladder_cancer
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Gall_bladder_cancer') IS NOT NULL
    DROP TABLE #CodeGroup_Gall_bladder_cancer;

CREATE TABLE #CodeGroup_Gall_bladder_cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Gall_bladder_cancer
(
    Code
)
VALUES
('C23');

-- -----------------------
-- Code Group: Secondary_liver_cancer
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Secondary_liver_cancer') IS NOT NULL
    DROP TABLE #CodeGroup_Secondary_liver_cancer;

CREATE TABLE #CodeGroup_Secondary_liver_cancer
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Secondary_liver_cancer
(
    Code
)
VALUES
('C787');

-- -----------------------
-- Code Group: Crohns_disease
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Crohns_disease') IS NOT NULL
    DROP TABLE #CodeGroup_Crohns_disease;

CREATE TABLE #CodeGroup_Crohns_disease
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Crohns_disease
(
    Code
)
VALUES
('K50');

-- -----------------------
-- Code Group: Ulcerative_colitis
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Ulcerative_colitis') IS NOT NULL
    DROP TABLE #CodeGroup_Ulcerative_colitis;

CREATE TABLE #CodeGroup_Ulcerative_colitis
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Ulcerative_colitis
(
    Code
)
VALUES
('K51');

-- -----------------------
-- Code Group: GallStones_3
-- -----------------------

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

-- -----------------------
-- Code Group: Pancreatitis_3
-- -----------------------

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

-- -----------------------
-- Code Group: Pancreatitis_4
-- -----------------------

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

-- -----------------------
-- Code Group: AnastomosisColon_4
-- -----------------------

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

-- -----------------------
-- Code Group: Proctocolectomy_with_ileostomy
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Proctocolectomy_with_ileostomy') IS NOT NULL
    DROP TABLE #CodeGroup_Proctocolectomy_with_ileostomy;

CREATE TABLE #CodeGroup_Proctocolectomy_with_ileostomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Proctocolectomy_with_ileostomy
(
    Code
)
VALUES
('H041'),
('H048'),
('H049');

-- -----------------------
-- Code Group: Proctocolectomy_with_ileo_anal_pouch
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Proctocolectomy_with_ileo_anal_pouch') IS NOT NULL
    DROP TABLE #CodeGroup_Proctocolectomy_with_ileo_anal_pouch;

CREATE TABLE #CodeGroup_Proctocolectomy_with_ileo_anal_pouch
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Proctocolectomy_with_ileo_anal_pouch
(
    Code
)
VALUES
('H042'),
('H043');

-- -----------------------
-- Code Group: Colectomy_and_ileo_rectal_anastomosis
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Colectomy_and_ileo_rectal_anastomosis') IS NOT NULL
    DROP TABLE #CodeGroup_Colectomy_and_ileo_rectal_anastomosis;

CREATE TABLE #CodeGroup_Colectomy_and_ileo_rectal_anastomosis
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Colectomy_and_ileo_rectal_anastomosis
(
    Code
)
VALUES
('H051'),
('H112'),
('H114');

-- -----------------------
-- Code Group: Subtotal_colectomy
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Subtotal_colectomy') IS NOT NULL
    DROP TABLE #CodeGroup_Subtotal_colectomy;

CREATE TABLE #CodeGroup_Subtotal_colectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Subtotal_colectomy
(
    Code
)
VALUES
('H052'),
('H053'),
('H058'),
('H059');

-- -----------------------
-- Code Group: Extended_right_hemicolectomy
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Extended_right_hemicolectomy') IS NOT NULL
    DROP TABLE #CodeGroup_Extended_right_hemicolectomy;

CREATE TABLE #CodeGroup_Extended_right_hemicolectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Extended_right_hemicolectomy
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

-- -----------------------
-- Code Group: Right_hemicolectomy
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Right_hemicolectomy') IS NOT NULL
    DROP TABLE #CodeGroup_Right_hemicolectomy;

CREATE TABLE #CodeGroup_Right_hemicolectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Right_hemicolectomy
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

-- -----------------------
-- Code Group: Transverse_colectomy
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Transverse_colectomy') IS NOT NULL
    DROP TABLE #CodeGroup_Transverse_colectomy;

CREATE TABLE #CodeGroup_Transverse_colectomy
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Transverse_colectomy
(
    Code
)
VALUES
('H081'),
('H082'),
('H083'),
('H084'),
('H085'),
('H086'),
('H088'),
('H089');

-- -----------------------
-- Code Group: LeftHemicolectomy_3
-- -----------------------

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

-- -----------------------
-- Code Group: SigmoidColectomy_3
-- -----------------------

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

-- -----------------------
-- Code Group: OtherColonExcision_3
-- -----------------------

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

-- -----------------------
-- Code Group: SubTotalColonExcision_3
-- -----------------------

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

-- -----------------------
-- Code Group: RectalExcision_3
-- -----------------------

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

-- -----------------------
-- Code Group: Hartmanns
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Hartmanns') IS NOT NULL
    DROP TABLE #CodeGroup_Hartmanns;

CREATE TABLE #CodeGroup_Hartmanns
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Hartmanns
(
    Code
)
VALUES
('H335');

-- -----------------------
-- Code Group: RectalSurgery_4
-- -----------------------

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

-- -----------------------
-- Code Group: PeranalSurgery_4
-- -----------------------

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

-- -----------------------
-- Code Group: ExenterationPelvis_4
-- -----------------------

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

-- -----------------------
-- Code Group: OesophagoGastroduodenoscopyDiag_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OesophagoGastroduodenoscopyDiag_3') IS NOT NULL
    DROP TABLE #CodeGroup_OesophagoGastroduodenoscopyDiag_3;

CREATE TABLE #CodeGroup_OesophagoGastroduodenoscopyDiag_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OesophagoGastroduodenoscopyDiag_3
(
    Code
)
VALUES
('G16'),
('G19'),
('G45'),
('G55');

-- -----------------------
-- Code Group: UpperGIComplic_Infection_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_UpperGIComplic_Infection_4') IS NOT NULL
    DROP TABLE #CodeGroup_UpperGIComplic_Infection_4;

CREATE TABLE #CodeGroup_UpperGIComplic_Infection_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UpperGIComplic_Infection_4
(
    Code
)
VALUES
('T802'),
('T814');

-- -----------------------
-- Code Group: UpperGIComplic_Haemorrhage_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_UpperGIComplic_Haemorrhage_4') IS NOT NULL
    DROP TABLE #CodeGroup_UpperGIComplic_Haemorrhage_4;

CREATE TABLE #CodeGroup_UpperGIComplic_Haemorrhage_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UpperGIComplic_Haemorrhage_4
(
    Code
)
VALUES
('T802'),
('T814');

-- -----------------------
-- Code Group: UpperGIComplic_Perforation_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_UpperGIComplic_Perforation_4') IS NOT NULL
    DROP TABLE #CodeGroup_UpperGIComplic_Perforation_4;

CREATE TABLE #CodeGroup_UpperGIComplic_Perforation_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_UpperGIComplic_Perforation_4
(
    Code
)
VALUES
('K631'),
('Y600');

-- -----------------------
-- Code Group: AdverseIncident_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AdverseIncident_3') IS NOT NULL
    DROP TABLE #CodeGroup_AdverseIncident_3;

CREATE TABLE #CodeGroup_AdverseIncident_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AdverseIncident_3
(
    Code
)
VALUES
('Y60'),
('Y61'),
('Y62'),
('Y63'),
('Y64'),
('Y65'),
('Y66'),
('Y69'),
('Y70'),
('Y71'),
('Y72'),
('Y73'),
('Y74'),
('Y75'),
('Y76'),
('Y77'),
('Y78'),
('Y79'),
('Y80'),
('Y81'),
('Y82'),
('Y83'),
('Y84');

-- -----------------------
-- Code Group: OtherInflammatoryLD_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OtherInflammatoryLD_3') IS NOT NULL
    DROP TABLE #CodeGroup_OtherInflammatoryLD_3;

CREATE TABLE #CodeGroup_OtherInflammatoryLD_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OtherInflammatoryLD_3
(
    Code
)
VALUES
('K75');

-- -----------------------
-- Code Group: Ascites_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Ascites_3') IS NOT NULL
    DROP TABLE #CodeGroup_Ascites_3;

CREATE TABLE #CodeGroup_Ascites_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Ascites_3
(
    Code
)
VALUES
('R18');

-- -----------------------
-- Code Group: AKI_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AKI_3') IS NOT NULL
    DROP TABLE #CodeGroup_AKI_3;

CREATE TABLE #CodeGroup_AKI_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AKI_3
(
    Code
)
VALUES
('N17');

-- -----------------------
-- Code Group: Line_infections_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Line_infections_4') IS NOT NULL
    DROP TABLE #CodeGroup_Line_infections_4;

CREATE TABLE #CodeGroup_Line_infections_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Line_infections_4
(
    Code
)
VALUES
('T827');

-- -----------------------
-- Code Group: Proctocolectomy_with_ileostomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Proctocolectomy_with_ileostomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Proctocolectomy_with_ileostomy_4;

CREATE TABLE #CodeGroup_Proctocolectomy_with_ileostomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Proctocolectomy_with_ileostomy_4
(
    Code
)
VALUES
('H041'),
('H048'),
('H049');

-- ========================================
-- Step 4: Create the #Spells_With_Variables Table
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

    -- Gastroenterology Variables
    Gastro_OesophagoGastroduodenoscopy VARCHAR(100),
    Gastro_ERCP VARCHAR(100),
    Gastro_Colonoscopy VARCHAR(100),
    Gastro_Sigmoidoscopy VARCHAR(100),
    Gastro_Endoscopy VARCHAR(100),
    Gastro_ERCPProcedures VARCHAR(100),
    Gastro_ERCPConditions VARCHAR(100),
    Gastro_ERCPComplications VARCHAR(100),
    Gastro_DuodenalUlcer VARCHAR(100),
    Gastro_GastricUlcer VARCHAR(100),
    Gastro_UpperGIVarices VARCHAR(100),
    Gastro_GIBleeding VARCHAR(100),
    Gastro_GIVaricesBanding VARCHAR(100),
    Gastro_Cirrhosis VARCHAR(100),
    Gastro_LiverDisease VARCHAR(100),
    Gastro_OtherLiverDisease VARCHAR(100),
    Gastro_H_Pylori VARCHAR(100),
    Cancellation_All VARCHAR(100),
    Gastro_MainSpecialty VARCHAR(100),
    Gastro_TreatmentSpecialty VARCHAR(100),
    -- Age Groups
    Age_Under_55 BIT
        DEFAULT 0,
    Age_Under_50 BIT
        DEFAULT 0,
    Age_Between_50_80 BIT
        DEFAULT 0,
    Age_Over_80 BIT
        DEFAULT 0,
    Gastro_AlcoholUse VARCHAR(100),
    Gastro_ViralHepatitis VARCHAR(100),
    Gastro_Ascites VARCHAR(100),
    Gastro_Peritonitis VARCHAR(100),
    Gastro_AKI_Hyponatraemia VARCHAR(100),
    Gastro_Encephalopathy VARCHAR(100),
    Gastro_AsciticProcedures VARCHAR(100),
    Gastro_TPN VARCHAR(100),
    Gastro_VascularLineInfection VARCHAR(100),
    GenS_Colectomy VARCHAR(100),
    GenS_RectalExcision VARCHAR(100),
    GenS_OtherColonicResection VARCHAR(100),
    GenS_ColonicResection_Cancer VARCHAR(100),
    GenS_ColorectalCancer VARCHAR(100),
    Gastro_PalliativeCare VARCHAR(100),
    Gastro_Nutrition VARCHAR(100),
	GenS_UlcerativeColitis VARCHAR(100),
	Gastro_AscitesTapDrain VARCHAR(100),
	GenS_CrohnDisease VARCHAR(100),
    --Flags
    Gastro_FLAG_ERCPComplications BIT
        DEFAULT 0,
    Gastro_FLAG_GastricUlcer BIT
        DEFAULT 0,
    Gastro_FLAG_AlcoholicLiverDisease BIT
        DEFAULT 0,
    Read30 BIT
        DEFAULT 0,
    Read30_0LOS BIT
        DEFAULT 0,
	Mort30 BIT DEFAULT 0,
);

-- ========================================
-- Step 4.1: Create the #OP_Spells_With_Variables Table
-- ========================================

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
    Virtual_Booking BIT DEFAULT 0,
	Face_to_Face_Booking BIT DEFAULT 0,
	New_Appointment BIT DEFAULT 0,
	Follow_Up_Appointment BIT DEFAULT 0,
    Clinic_Code VARCHAR(50),
    Attendance_Status_Code VARCHAR(10),
    -- Procedure Flags
    Gastro_OesophagoGastroduodenoscopy VARCHAR(100),
	Gastro_ERCP VARCHAR(100),
    Gastro_Colonoscopy VARCHAR(100),
    Gastro_Sigmoidoscopy VARCHAR(100),
    Gastro_Endoscopy VARCHAR(100),
    Gastro_ERCPProcedures VARCHAR(100),
    Gastro_ERCPConditions VARCHAR(100),
    Gastro_ERCPComplications VARCHAR(100),
    Gastro_DuodenalUlcer VARCHAR(100),
    Gastro_GastricUlcer VARCHAR(100),
    Gastro_UpperGIVarices VARCHAR(100),
    Gastro_GIBleeding VARCHAR(100),
    Gastro_GIVaricesBanding VARCHAR(100),
    Gastro_Cirrhosis VARCHAR(100),
    Gastro_LiverDisease VARCHAR(100),
    Gastro_OtherLiverDisease VARCHAR(100),
    Gastro_ViralHepatitis VARCHAR(100),
    Gastro_Ascites VARCHAR(100),
    Gastro_Peritonitis VARCHAR(100),
    Gastro_AKI_Hyponatraemia VARCHAR(100),
    Gastro_Encephalopathy VARCHAR(100),
    Gastro_AscitesTapDrain VARCHAR(100),
    Gastro_Nutrition VARCHAR(100),
    Gastro_VascularLineInfection VARCHAR(100),
    Gastro_Proctocolectomy_with_Ileo_Anal_Pouch VARCHAR(100),
    Gastro_Proctocolectomy_with_Ileostomy VARCHAR(100),
    Gastro_Colectomy_with_Ileo_Rectal_Anastomosis VARCHAR(100),
    Gastro_Right_Hemicolectomy VARCHAR(100),
    Gastro_Extended_Right_Hemicolectomy VARCHAR(100),
    Gastro_Sigmoid_Colectomy VARCHAR(100),
    Gastro_Left_Hemicolectomy VARCHAR(100),
    Gastro_Transverse_Colectomy VARCHAR(100),
    Gastro_Other_Subtotal_Colectomy VARCHAR(100),
    GenS_RectalExcision VARCHAR(100),
    GenS_OtherColonicResection VARCHAR(100),
    GenS_ColonicResection_Cancer VARCHAR(100),
	GenS_UlcerativeColitis VARCHAR(100),
	GenS_CrohnDisease VARCHAR(100),
    -- Age Groups
    Age_Under_55 BIT
        DEFAULT 0,
    Age_Under_50 BIT
        DEFAULT 0,
    Age_Between_50_80 BIT
        DEFAULT 0,
    Age_Over_80 BIT
        DEFAULT 0,
	--Flags
	Gastro_FLAG_ERCPComplications BIT
        DEFAULT 0,
	Gastro_FLAG_GastricUlcer BIT
        DEFAULT 0,
	Gastro_FLAG_AlcoholicLiverDisease BIT
        DEFAULT 0,
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

-- ========================================
-- Step 4.3: Populate the #OP_Spells_With_Variables Table with Initial Data
-- ========================================

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
    Virtual_Booking,
	Face_to_Face_Booking,
	New_Appointment,
	Follow_Up_Appointment,
    Clinic_Code,
    Attendance_Status_Code
)
SELECT ope.OP_Attendance_ID,
       ope.Sector,
       ope.PAS_Number,
       ope.NHS_Number,
       ope.Appointment_Date,
       ope.Age_At_Appointment AS Age,
       ope.Main_Specialty_Code AS MAINSPEF,
       ope.Treatment_Function_Code AS TRETSPEF,
	   opa.M0010l_Virtual_Booking AS Virtual_Booking,
	   opa.M0010r_Face_To_Face_Booking AS Face_to_Face_Booking,
	   opa.M0010n_New_Appointment AS New_Appointment,
	   opa.M0010o_Follow_Up_Appointment AS Follow_Up_Appointment,
       ope.Clinic_Code,
       ope.Attendance_Status_Code
FROM PAS_OP_Appointment_Frozen ope
LEFT JOIN M0010_OP_Appointment opa
ON ope.OP_Attendance_ID = opa.OP_Attendance_ID
AND ope.Sector = opa.Sector
WHERE ope.Appointment_Date
      BETWEEN @OPStartDate AND @OPEndDate
      AND ope.Org_Code_Provider = 'RPA'
      AND ope.Sector = 'MED';

-- ========================================
-- Step 5.1: Update Therapeutic and Diagnostic Procedures
-- ========================================

-- **Therapeutic ERCP (Priority 1)**
UPDATE SWV
SET Gastro_ERCP = 'Therapeutic ERCP'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
);

-- **Diagnostic ERCP (Priority 2)**
UPDATE SWV
SET Gastro_ERCP = 'Diagnostic ERCP'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCPDiag_3
              )
);

-- **Therapeutic Colonoscopy (Priority 1)**
UPDATE SWV
SET Gastro_Colonoscopy = 'Therapeutic Colonoscopy'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Colonoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Colonoscopy_3
              )
);

-- **Diagnostic Colonoscopy (Priority 2)**
UPDATE SWV
SET Gastro_Colonoscopy = 'Diagnostic Colonoscopy'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Colonoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ColonoscopyDiag_3
              )
);

-- **Therapeutic Flexible Sigmoidoscopy (Priority 1)**
UPDATE SWV
SET Gastro_Sigmoidoscopy = 'Therapeutic Flexible Sigmoidoscopy'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Sigmoidoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Flex_sig_3
              )
);

-- **Diagnostic Flexible Sigmoidoscopy (Priority 2)**
UPDATE SWV
SET Gastro_Sigmoidoscopy = 'Diagnostic Flexible Sigmoidoscopy'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Sigmoidoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Flex_sig_Diag_3
              )
);

-- **Therapeutic Rigid Sigmoidoscopy (Priority 3)**
UPDATE SWV
SET Gastro_Sigmoidoscopy = 'Therapeutic Rigid Sigmoidoscopy'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Sigmoidoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Rigid_sig_3
              )
);

-- **Diagnostic Rigid Sigmoidoscopy (Priority 4)**
UPDATE SWV
SET Gastro_Sigmoidoscopy = 'Diagnostic Rigid Sigmoidoscopy'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Sigmoidoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Rigid_sig_Diag_3
              )
);

-- **Gastro_OesophagoGastroduodenoscopy**

-- **1. Therapeutic OGD (Priority 1)**
UPDATE SWV
SET Gastro_OesophagoGastroduodenoscopy = 'Therapeutic OGD'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagoGastroduodenoscopy_3
              )
);

-- **2. Diagnostic OGD (Priority 2)**
UPDATE SWV
SET Gastro_OesophagoGastroduodenoscopy = 'Diagnostic OGD'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagoGastroduodenoscopyDiag_3
              )
);

-- ========================================
-- Step 5.2: Update Gastroenterology Endoscopy
-- ========================================

-- **Gastroenterology Endoscopy (Priority 1)**
UPDATE SWV
SET Gastro_Endoscopy = 'Gastroenterology endoscopy'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Endoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagoGastroduodenoscopy_3
              )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_OesophagoGastroduodenoscopyDiag_3
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Colonoscopy_3
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_ColonoscopyDiag_3
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Flex_sig_3
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Flex_sig_Diag_3
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Rigid_sig_3
                 )
              OR LEFT(ipp.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Rigid_sig_Diag_3
                 )
          )
);

-- ========================================
-- Step 5.3: Update ERCP Procedures
-- ========================================

-- **Insertion of Stent (Priority 1)**
UPDATE SWV
SET Gastro_ERCPProcedures = 'Insertion of Stent'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_InsertStent_4
              )
);

-- **Stone Extraction (Priority 2)**
UPDATE SWV
SET Gastro_ERCPProcedures = 'Stone Extraction'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_StoneExtraction_4
              )
);

-- **Lithotripsy (Priority 3)**
UPDATE SWV
SET Gastro_ERCPProcedures = 'Lithotripsy'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_Lithotripsy_4
              )
);

-- **Dilation of Bile Duct (Priority 4)**
UPDATE SWV
SET Gastro_ERCPProcedures = 'Dilation of Bile Duct'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_Dilation_4
              )
);

-- **Removal of Stent (Priority 5)**
UPDATE SWV
SET Gastro_ERCPProcedures = 'Removal of Stent'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_RemoveStent_4
              )
);

-- ========================================
-- Step 5.4: Update ERCP Conditions
-- ========================================

UPDATE SWV
SET Gastro_ERCPConditions = CASE
                                -- Priority 1: Cancer of the Bile Duct
                                WHEN EXISTS
                                     (
                                         SELECT 1
                                         FROM PAS_IP_Episode_Frozen ipe
                                             INNER JOIN PAS_IP_Procedure_Normalised ipp
                                                 ON ipe.Episode_Number = ipp.Episode_Number
                                                    AND ipe.Sector = ipp.Sector
                                         WHERE ipe.Spell_Number = SWV.Spell_Number
                                               AND ipe.Sector = SWV.Sector
                                               AND
                                               (
                                                   LEFT(ipp.Procedure_Code, 3)IN
                                                   (
                                                       SELECT Code FROM #CodeGroup_Cancer_bileduct_3
                                                   )
                                                   OR LEFT(ipp.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_Cancer_bileduct_4
                                                      )
                                               )
                                     ) THEN
                                    'Cancer of the Bile Duct'

                                -- Priority 2: Cholelithiasis
                                WHEN EXISTS
                                     (
                                         SELECT 1
                                         FROM PAS_IP_Episode_Frozen ipe
                                             INNER JOIN PAS_IP_Procedure_Normalised ipp
                                                 ON ipe.Episode_Number = ipp.Episode_Number
                                                    AND ipe.Sector = ipp.Sector
                                         WHERE ipe.Spell_Number = SWV.Spell_Number
                                               AND ipe.Sector = SWV.Sector
                                               AND LEFT(ipp.Procedure_Code, 3)IN
                                                   (
                                                       SELECT Code FROM #CodeGroup_Cholelithiasis_3
                                                   )
                                     ) THEN
                                    'Cholelithiasis'

                                -- Priority 3: Other Conditions of the Bile Duct
                                WHEN EXISTS
                                     (
                                         SELECT 1
                                         FROM PAS_IP_Episode_Frozen ipe
                                             INNER JOIN PAS_IP_Procedure_Normalised ipp
                                                 ON ipe.Episode_Number = ipp.Episode_Number
                                                    AND ipe.Sector = ipp.Sector
                                         WHERE ipe.Spell_Number = SWV.Spell_Number
                                               AND ipe.Sector = SWV.Sector
                                               AND
                                               (
                                                   LEFT(ipp.Procedure_Code, 3)IN
                                                   (
                                                       SELECT Code FROM #CodeGroup_OtherDiseaseBileDuct_3
                                                   )
                                                   OR LEFT(ipp.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_OtherDiseaseBileDuct_4
                                                      )
                                               )
                                     ) THEN
                                    'Other Conditions of the Bile Duct'

                                -- If none of the conditions match, retain the current value
                                ELSE
                                    SWV.Gastro_ERCPConditions
                            END
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPConditions IS NULL;

-- ========================================
-- Step 5.5: Update ERCP Complications
-- ========================================

-- **Cholangitis (Priority 1)**
UPDATE SWV
SET Gastro_ERCPComplications = 'Cholangitis'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCPComplic_Cholangitis_4
              )
);

-- **Pancreatitis (Priority 2)**
UPDATE SWV
SET Gastro_ERCPComplications = 'Pancreatitis'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCPComplic_Pancreatitis_3
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ERCPComplic_Pancreatitis_4
                 )
          )
);

-- **Infection (Priority 3)**
UPDATE SWV
SET Gastro_ERCPComplications = 'Infection'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIComplic_Infection_4
              )
);

-- **Haemorrhage (Priority 4)**
UPDATE SWV
SET Gastro_ERCPComplications = 'Haemorrhage'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIComplic_Haemorrhage_4
              )
);

-- **Perforation (Priority 5)**
UPDATE SWV
SET Gastro_ERCPComplications = 'Perforation'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIComplic_Perforation_4
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ERCPComplic_Perforation_4
                 )
          )
);

-- **GI Bleeding (Priority 6)**
UPDATE SWV
SET Gastro_ERCPComplications = 'GI Bleeding'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGI_bleeding_4
              )
);

-- **Other Post Procedural Disorder (Priority 7)**
UPDATE SWV
SET Gastro_ERCPComplications = 'Other Post Procedural Disorder'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIComplic_PostProcedure_3
              )
);

-- **Other Complication (Priority 8)**
UPDATE SWV
SET Gastro_ERCPComplications = 'Other Complication'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Complications_3
              )
);

-- **Other Adverse Event (Priority 9)**
UPDATE SWV
SET Gastro_ERCPComplications = 'Other Adverse Event'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AdverseIncident_3
              )
);

-- ========================================
-- Step 5.6: Update Duodenal and Gastric Ulcers
-- ========================================

-- **Duodenal Ulcer with Haemorrhage (Priority 1)**
UPDATE SWV
SET Gastro_DuodenalUlcer = 'With haemorrhage'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_DuodenalUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_DuodenalUlcer_haem_4
              )
);

-- **Duodenal Ulcer with Perforation (Priority 2)**
UPDATE SWV
SET Gastro_DuodenalUlcer = 'With perforation'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_DuodenalUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_DuodenalUlcer_perf_4
              )
);

-- **Duodenal Ulcer with Other Presentation (Priority 3)**
UPDATE SWV
SET Gastro_DuodenalUlcer = 'With other presentation'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_DuodenalUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_DuodenalUlcer_3
              )
);

-- **Gastric Ulcer with Haemorrhage (Priority 1)**
UPDATE SWV
SET Gastro_GastricUlcer = 'With haemorrhage'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GastricUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricUlcer_haem_4
              )
);

-- **Gastric Ulcer with Perforation (Priority 2)**
UPDATE SWV
SET Gastro_GastricUlcer = 'With perforation'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GastricUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricUlcer_perf_4
              )
);

-- **Gastric Ulcer with Other Presentation (Priority 3)**
UPDATE SWV
SET Gastro_GastricUlcer = 'With other presentation'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GastricUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_GastricUlcer_3
              )
);

-- ========================================
-- Step 5.7: Update Upper GI Varices
-- ========================================

-- **Oesophageal Varices - Bleeding (Priority 1)**
UPDATE SWV
SET Gastro_UpperGIVarices = 'Oesophageal varices - bleeding'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_UpperGIVarices IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagealVariceal_bleed_4
              )
);

-- **Oesophageal Varices - Not Bleeding (Priority 2)**
UPDATE SWV
SET Gastro_UpperGIVarices = 'Oesophageal varices - not bleeding'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_UpperGIVarices IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagealVariceal_NoBleed_4
              )
);

-- **Other GI Varices - Bleeding (Priority 3)**
UPDATE SWV
SET Gastro_UpperGIVarices = 'Other GI varices - bleeding'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_UpperGIVarices IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGI_bleeding_4
              )
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricVarices_4
              )
);

-- **Other GI Varices - Not Bleeding (Priority 4)**
UPDATE SWV
SET Gastro_UpperGIVarices = 'Other GI varices - not bleeding'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_UpperGIVarices IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricVarices_4
              )
);


-- ========================================
-- Step 5.8: Update GI Bleeding and Complications
-- ========================================

-- **GI Bleeding Excluding Ulcers (Priority 1)**
UPDATE SWV
SET Gastro_GIBleeding = 'GI bleeding excluding ulcers'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GIBleeding IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGI_bleeding_4
              )
);

-- **Endoscopic Banding of Oesophageal Varices (Priority 1)**
UPDATE SWV
SET Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GIVaricesBanding IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIVariceal_banding_4
              )
          AND
          (
              LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagealVariceal_bleed_4
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_OesophagealVariceal_NoBleed_4
                 )
          )
);

-- **Endoscopic Banding of Other GI Varices (Priority 2)**
UPDATE SWV
SET Gastro_GIVaricesBanding = 'Endoscopic band ligation of other GI varices'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GIVaricesBanding IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricVarices_4
              )
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIVariceal_banding_4
              )
);

-- ========================================
-- Step 5.9: Update Age Groups
-- ========================================

-- **Age Under 55**
UPDATE SWV
SET Age_Under_55 = 1
FROM #Spells_With_Variables SWV
WHERE SWV.Age < 55;

-- **Age Under 50**
UPDATE SWV
SET Age_Under_50 = 1
FROM #Spells_With_Variables SWV
WHERE SWV.Age < 50;

-- **Age Between 50 and 80**
UPDATE SWV
SET Age_Between_50_80 = 1
FROM #Spells_With_Variables SWV
WHERE SWV.Age
BETWEEN 50 AND 80;

-- **Age Over 80**
UPDATE SWV
SET Age_Over_80 = 1
FROM #Spells_With_Variables SWV
WHERE SWV.Age > 80;

-- ========================================
-- Step 5.10: Update Cirrhosis and Liver Diseases
-- ========================================

-- **Gastro_Cirrhosis**

-- **Alcohol-related Cirrhosis (Priority 1)**
UPDATE SWV
SET Gastro_Cirrhosis = 'Alcohol-related cirrhosis'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Cirrhosis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AlcoholicCirrhosis_4
              )
);

-- **Non-alcohol Cirrhosis (Priority 2)**
UPDATE SWV
SET Gastro_Cirrhosis = 'Non-alcohol cirrhosis'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Cirrhosis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_NonAlcholicCirrhosis_4
              )
);

-- **Gastro_LiverDisease**

-- **Alcohol-related Liver Disease (Priority 1)**
UPDATE SWV
SET Gastro_LiverDisease = 'Alcohol-related liver disease'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AlcoholicLD_3
              )
);

-- **Cirrhosis (Priority 2)**
UPDATE SWV
SET Gastro_LiverDisease = 'Cirrhosis'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AlcoholicCirrhosis_4
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_NonAlcholicCirrhosis_4
                 )
          )
);

-- **Non-alcohol Fatty Liver Disease (Priority 3)**
UPDATE SWV
SET Gastro_LiverDisease = 'Non-alcohol fatty liver disease'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_NonAlcoholFattyLD_4
              )
);

-- **Chronic Hepatic Failure (Priority 4)**
UPDATE SWV
SET Gastro_LiverDisease = 'Chronic hepatic failure'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ChronicHepaticFailure_3
              )
);

-- **Other Inflammatory Liver Disease (Priority 5)**
UPDATE SWV
SET Gastro_LiverDisease = 'Other inflammatory liver disease'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OtherInflammatoryLD_3
              )
);

-- **Other Liver Disease (Priority 6)**
UPDATE SWV
SET Gastro_LiverDisease = 'Other liver disease'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_GeneralLD_3
              )
);

-- **Gastro_OtherLiverDisease**

-- **OtherLiverDisease (Priority 1)**
UPDATE SWV
SET Gastro_OtherLiverDisease = 'OtherLiverDisease'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OtherLiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OtherLiverDisease
              )
          AND LEFT(ipd.Diagnosis_Code, 4) NOT IN
              (
                  SELECT Code FROM #CodeGroup_OtherLiverDiseaseExc
              )
);

-- ========================================
-- Step 5.11: Update Other Conditions and Variables
-- ========================================

-- **Gastro_H_Pylori**

-- **Helicobacter Pylori (Priority 1)**
UPDATE SWV
SET Gastro_H_Pylori = 'Helicobacter pylori'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_H_Pylori IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_H_pylori_4
              )
);

-- **Cancellation All**
UPDATE SWV
SET Cancellation_All = 'Cancellation_all'
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
    INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
        ON ipd.Episode_Number = ipe.Episode_Number
           AND ipd.Sector = ipe.Sector
WHERE LEFT(ipd.Diagnosis_Code, 3)IN
      (
          SELECT Code FROM #CodeGroup_Cancellation_all_3
      );

-- **Gastro Main Specialty**
UPDATE SWV
SET Gastro_MainSpecialty = 'Gastroenterology'
FROM #Spells_With_Variables SWV
WHERE SWV.MAINSPEF IN
      (
          SELECT Code FROM #CodeGroup_MAINSPEC_GASTRO
      );

-- **Gastro Treatment Specialty**
UPDATE SWV
SET Gastro_TreatmentSpecialty = 'Gastroenterology or Hepatology'
FROM #Spells_With_Variables SWV
WHERE SWV.TRETSPEF IN
      (
          SELECT Code FROM #CodeGroup_TRETSPEC_GASTRO
      )
      OR SWV.TRETSPEF IN
         (
             SELECT Code FROM #CodeGroup_TRETSPEC_HEP
         );

-- ========================================
-- Step 5.13: Update Cirrhosis and Liver Diseases (Continued)
-- ========================================

-- **Alcohol Dependency (Priority 1)**
UPDATE SWV
SET Gastro_AlcoholUse = 'Alcohol dependency'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_AlcoholUse IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AlcoholDependency_4
              )
);

-- **Other Mental Health Disorders Related to Alcohol (Priority 2)**
UPDATE SWV
SET Gastro_AlcoholUse = 'Other mental health disorders related to alcohol'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_AlcoholUse IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AlcoholUse_MentalHealth_3
              )
);

-- **Alcohol Induced Gastritis (Priority 3)**
UPDATE SWV
SET Gastro_AlcoholUse = 'Alcohol induced gastritis'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_AlcoholUse IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AlcoholInducedGastritis_4
              )
);

-- ========================================
-- Step 5.14: Update Viral Hepatitis and Ascites
-- ========================================

-- **Viral Hepatitis (Priority 1)**
UPDATE SWV
SET Gastro_ViralHepatitis = 'Viral hepatitis'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ViralHepatitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ViralHepititis_3
              )
);

-- **Ascites (Priority 1)**
UPDATE SWV
SET Gastro_Ascites = 'Ascites'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Ascites IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Ascites_3
              )
);

-- **Spontaneous Bacterial Peritonitis (Priority 1)**
UPDATE SWV
SET Gastro_Peritonitis = 'Spontaneous bacterial peritonitis'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Peritonitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Spon_bact_peritonitis_3
              )
);

-- **Acute Kidney Injury or Hyponatraemia (Priority 1)**
UPDATE SWV
SET Gastro_AKI_Hyponatraemia = 'Acute Kidney Injury or Hyponatraemia'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_AKI_Hyponatraemia IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AKI_3
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_AKI_4
                 )
          )
);

-- **Gastro_Encephalopathy**

-- **Encephalopathy (Priority 1)**
UPDATE SWV
SET Gastro_Encephalopathy = 'Encephalopathy'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Encephalopathy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_EncephalopathyA_4
              )
              OR LEFT(ipd.Diagnosis_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Encephalopathy_3
                 )
          )
);

-- **Ascitic Tap (Priority 1)**
UPDATE SWV
SET Gastro_AsciticProcedures = 'Ascitic Tap'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_AsciticProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Ascitic_tap_4
              )
);


-- **Ascitic Drain (Priority 1)**
UPDATE SWV
SET Gastro_AsciticProcedures = 'Ascitic Drain'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_AsciticProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Ascitic_drain_4
              )
);


-- **Gastro_TPN**

-- **Total Parenteral Nutrition (TPN) (Priority 1)**
UPDATE SWV
SET Gastro_TPN = 'Total Parenteral Nutrition (TPN)'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_TPN IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_TPN_4
              )
);

-- **Gastro_VascularLineInfection**

-- **Vascular Line Infection (Priority 1)**
UPDATE SWV
SET Gastro_VascularLineInfection = 'Vascular Line Infection'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_VascularLineInfection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Line_infections_4
              )
);

-- ========================================
-- Step 5.15: Update Colectomy and Colonic Resection Procedures
-- ========================================

-- **GenS_Colectomy**

-- **1. Proctocolectomy with Ileo-Anal Pouch (Priority 1)**
UPDATE SWV
SET GenS_Colectomy = 'Proctocolectomy with ileo-anal pouch'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Proctocolectomy_with_ileo_anal_pouch
              )
);

-- **2. Proctocolectomy with Ileostomy (Priority 2)**
UPDATE SWV
SET GenS_Colectomy = 'Proctocolectomy with ileostomy'
FROM #Spells_With_Variables SWV
    INNER JOIN PAS_IP_Episode_Frozen ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Procedure_Normalised ipp1
    WHERE ipp1.Episode_Number = ipe.Episode_Number
          AND ipp1.Sector = ipe.Sector
          AND LEFT(ipp1.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Proctocolectomy_with_ileostomy_4
              )
)

;

-- **3. Colectomy with Ileo-Rectal Anastomosis (Priority 3)**
UPDATE SWV
SET GenS_Colectomy = 'Colectomy with ileo-rectal anastomosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Colectomy_and_ileo_rectal_anastomosis
              )
);

-- **4. Right Hemicolectomy (Priority 4)**
UPDATE SWV
SET GenS_Colectomy = 'Right hemicolectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Right_hemicolectomy
              )
);

-- **5. Extended Right Hemicolectomy (Priority 5)**
UPDATE SWV
SET GenS_Colectomy = 'Extended right hemicolectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Extended_right_hemicolectomy
              )
);

-- **6. Sigmoid Colectomy (Priority 6)**
UPDATE SWV
SET GenS_Colectomy = 'Sigmoid colectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_SigmoidColectomy_3
              )
);

-- **7. Left Hemicolectomy (Priority 7)**
UPDATE SWV
SET GenS_Colectomy = 'Left hemicolectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_LeftHemicolectomy_3
              )
);

-- **8. Transverse Colectomy (Priority 8)**
UPDATE SWV
SET GenS_Colectomy = 'Transverse colectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Transverse_colectomy
              )
);

-- **9. Other Subtotal Colectomy (Priority 9)**
UPDATE SWV
SET GenS_Colectomy = 'Other subtotal colectomy'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Subtotal_colectomy
              )
);

-- ========================================
-- Step 5.16: Update Hartmann's Procedure and Rectal Excision
-- ========================================

-- **GenS_RectalExcision**

-- **1. Hartmann's Procedure (Priority 1)**
UPDATE SWV
SET GenS_RectalExcision = 'Hartmann''s Procedure'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_RectalExcision IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Hartmanns
              )
);

-- **2. Rectal excision (Priority 2)**
UPDATE SWV
SET GenS_RectalExcision = 'Rectal excision'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_RectalExcision IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_RectalExcision_3
              )
);

-- **3. Perianal surgery (Priority 3)**
UPDATE SWV
SET GenS_RectalExcision = 'Perianal surgery'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_RectalExcision IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_PeranalSurgery_4
              )
);

-- ========================================
-- Step 5.17: Update Rectal and Perianal Surgery
-- ========================================

-- **GenS_OtherColonicResection**

-- **1. Rectal Surgery (Priority 1)**
UPDATE SWV
SET GenS_OtherColonicResection = 'Rectal surgery'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_RectalSurgery_4
              )
);

-- **2. Exenteration of pelvis (Priority 2)**
UPDATE SWV
SET GenS_OtherColonicResection = 'Exenteration of pelvis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ExenterationPelvis_4
              )
);

-- **3. Other anastomosis of colon (Priority 3)**
UPDATE SWV
SET GenS_OtherColonicResection = 'Other anastomosis of colon'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AnastomosisColon_4
              )
);

-- **4. Other total colon excision (Priority 4)**
UPDATE SWV
SET GenS_OtherColonicResection = 'Other total colon excision'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OtherColonExcision_3
              )
);

-- **5. Subtotal colon excision (Priority 5)**
UPDATE SWV
SET GenS_OtherColonicResection = 'Subtotal colon excision'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_SubTotalColonExcision_3
              )
);

-- ========================================
-- Step 5.18: Update GenS_ColonicResection_Cancer
-- ========================================

-- **GenS_ColonicResection_Cancer: Resection for colorectal cancer (Priority 1)**
UPDATE SWV
SET GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_ColonicResection_Cancer IS NULL
      AND
      (
          SWV.GenS_Colectomy NOT LIKE '%Other%'
          OR SWV.GenS_RectalExcision NOT LIKE '%Other%'
          OR SWV.GenS_OtherColonicResection NOT LIKE '%Other%'
      )
      AND SWV.GenS_ColorectalCancer NOT LIKE '%Other%';

-- ========================================
-- Step 5.21: Update Palliative Care, Nutrition, and Vascular Line Infections
-- ========================================

-- **Gastro_PalliativeCare**

-- **1. In hospital palliative care (Priority 1)**
UPDATE SWV
SET Gastro_PalliativeCare = 'In hospital palliative care'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_PalliativeCare IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Palliative_4
              )
);

-- **Gastro_Nutrition**

-- **1. Total parenteral nutrition (TPN) (Priority 1)**
UPDATE SWV
SET Gastro_Nutrition = 'Total parenteral nutrition (TPN)'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Nutrition IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_TPN_4
              )
);

-- **Gastro_VascularLineInfection**

-- **1. Infection and inflammation of vascular device (Priority 1)**
UPDATE SWV
SET Gastro_VascularLineInfection = 'Infection and inflammation of vascular device'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_VascularLineInfection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Line_infections_4
              )
);

/* -------------------------------------------------------------------
--	Gastro_AscitesTapDrain
------------------------------------------------------------------- */

-- **Gastro_AscitesTapDrain**

-- **1. Ascitic Tap or Drain (Priority 1)**
UPDATE SWV
SET Gastro_AscitesTapDrain = 'Ascitic tap or drain'
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_AscitesTapDrain IS NULL
      AND
      (
          EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Ascitic_drain_4
              )
)
          OR EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Procedure_Normalised ipp
            ON ipe.Episode_Number = ipp.Episode_Number
               AND ipe.Sector = ipp.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipp.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Ascitic_tap_4
              )
)
      );

/* -------------------------------------------------------------------
   GenS_UlcerativeColitis
------------------------------------------------------------------- */

-- **1. Ulcerative Colitis Primary Diagnosis (Priority 1)**
UPDATE SWV
SET GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Ulcerative_colitis
              )
);

/* -------------------------------------------------------------------
   GenS_CrohnDisease
------------------------------------------------------------------- */

-- **1. Crohn's Disease Primary Diagnosis (Priority 1)**
UPDATE SWV
SET GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_IP_Episode_Frozen ipe
        INNER JOIN PAS_IP_Diagnosis_Normalised ipd
            ON ipe.Episode_Number = ipd.Episode_Number
               AND ipe.Sector = ipd.Sector
    WHERE ipe.Spell_Number = SWV.Spell_Number
          AND ipe.Sector = SWV.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Crohns_disease
              )
);

/* -------------------------------------------------------------------
   Update GenS_UlcerativeColitis in OSV Table
------------------------------------------------------------------- */

-- **GenS_UlcerativeColitis**

-- **1. Ulcerative Colitis Primary Diagnosis (Priority 1)**
UPDATE OSV
SET GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.GenS_UlcerativeColitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Diagnosis_Normalised opd
    WHERE OSV.OP_Attendance_ID = opd.OP_Attendance_ID
          AND OSV.Sector = opd.Sector
          AND LEFT(opd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Ulcerative_colitis
              )
);

/* -------------------------------------------------------------------
--  GenS_CrohnDisease
------------------------------------------------------------------- */

-- **GenS_CrohnDisease**

-- **1. Crohn's Disease Primary Diagnosis (Priority 1)**
UPDATE OSV
SET GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.GenS_CrohnDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Diagnosis_Normalised opd
    WHERE OSV.OP_Attendance_ID = opd.OP_Attendance_ID
          AND OSV.Sector = opd.Sector
          AND LEFT(opd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Crohns_disease
              )
);


-- **Therapeutic ERCP (Priority 1)**
UPDATE OSV
SET Gastro_ERCP = 'Therapeutic ERCP'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCP IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
);

-- **Diagnostic ERCP (Priority 2)**
UPDATE OSV
SET Gastro_ERCP = 'Diagnostic ERCP'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCP IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCPDiag_3
              )
);

-- ========================================
-- Step 3.1: Update OesophagoGastroduodenoscopy (OGD)
-- ========================================

-- **Gastro_OesophagoGastroduodenoscopy**

-- **1. Therapeutic OGD (Priority 1)**
UPDATE OSV
SET Gastro_OesophagoGastroduodenoscopy = 'Therapeutic OGD'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagoGastroduodenoscopy_3
              )
);

-- **2. Diagnostic OGD (Priority 2)**
UPDATE OSV
SET Gastro_OesophagoGastroduodenoscopy = 'Diagnostic OGD'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagoGastroduodenoscopyDiag_3
              )
);

-- ========================================
-- Step 3.2: Update Colonoscopy
-- ========================================

-- **1. Therapeutic Colonoscopy (Priority 1)**
UPDATE OSV
SET Gastro_Colonoscopy = 'Therapeutic Colonoscopy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Colonoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Colonoscopy_3
              )
);

-- **2. Diagnostic Colonoscopy (Priority 2)**
UPDATE OSV
SET Gastro_Colonoscopy = 'Diagnostic Colonoscopy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Colonoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ColonoscopyDiag_3
              )
);

-- ========================================
-- Step 3.3: Update Sigmoidoscopy
-- ========================================

-- **Gastro_Sigmoidoscopy**

-- **1. Therapeutic Flexible Sigmoidoscopy (Priority 1)**
UPDATE OSV
SET Gastro_Sigmoidoscopy = 'Therapeutic Flexible Sigmoidoscopy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Sigmoidoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Flex_sig_3
              )
);

-- **2. Diagnostic Flexible Sigmoidoscopy (Priority 2)**
UPDATE OSV
SET Gastro_Sigmoidoscopy = 'Diagnostic Flexible Sigmoidoscopy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Sigmoidoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Flex_sig_Diag_3
              )
);

-- **3. Therapeutic Rigid Sigmoidoscopy (Priority 3)**
UPDATE OSV
SET Gastro_Sigmoidoscopy = 'Therapeutic Rigid Sigmoidoscopy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Sigmoidoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Rigid_sig_3
              )
);

-- **4. Diagnostic Rigid Sigmoidoscopy (Priority 4)**
UPDATE OSV
SET Gastro_Sigmoidoscopy = 'Diagnostic Rigid Sigmoidoscopy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Sigmoidoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Rigid_sig_Diag_3
              )
);

-- ========================================
-- Step 3.4: Update Gastroenterology Endoscopy
-- ========================================

-- **Gastro_Endoscopy**
-- **1. Gastroenterology endoscopy (Priority 1)**
UPDATE OSV
SET Gastro_Endoscopy = 'Gastroenterology endoscopy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Endoscopy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND
          (
              LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagoGastroduodenoscopy_3
              )
              OR LEFT(opn.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_OesophagoGastroduodenoscopyDiag_3
                 )
              OR LEFT(opn.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Colonoscopy_3
                 )
              OR LEFT(opn.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_ColonoscopyDiag_3
                 )
              OR LEFT(opn.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Flex_sig_3
                 )
              OR LEFT(opn.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Flex_sig_Diag_3
                 )
              OR LEFT(opn.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Rigid_sig_3
                 )
              OR LEFT(opn.Procedure_Code, 3)IN
                 (
                     SELECT Code FROM #CodeGroup_Rigid_sig_Diag_3
                 )
          )
);

-- ========================================
-- Step 3.5: Update ERCP Procedures
-- ========================================

-- **Gastro_ERCPProcedures**

-- **1. Insertion of Stent (Priority 1)**
UPDATE OSV
SET Gastro_ERCPProcedures = 'Insertion of stent'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_InsertStent_4
              )
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
);

-- **2. Stone Extraction (Priority 2)**
UPDATE OSV
SET Gastro_ERCPProcedures = 'Stone extraction'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_StoneExtraction_4
              )
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
);

-- **3. Lithotripsy (Priority 3)**
UPDATE OSV
SET Gastro_ERCPProcedures = 'Lithotripsy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_Lithotripsy_4
              )
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
);

-- **4. Dilation of Bile Duct (Priority 4)**
UPDATE OSV
SET Gastro_ERCPProcedures = 'Dilation of bile duct'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_Dilation_4
              )
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
);

-- **5. Removal of Stent (Priority 5)**
UPDATE OSV
SET Gastro_ERCPProcedures = 'Removal of stent'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPProcedures IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_RemoveStent_4
              )
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCP_3
              )
);

-- ========================================
-- Step 3.6: Update ERCP Conditions
-- ========================================

-- **Gastro_ERCPConditions**

-- **1. Cancer of the Bile Duct (Primary and Other) (Priority 1)**
UPDATE OSV
SET Gastro_ERCPConditions = 'Cancer of the bile duct'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPConditions IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON opn.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND opn.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Cancer_bileduct_3
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_Cancer_bileduct_4
                 )
          )
);

-- **2. Cholelithiasis (Priority 2)**
UPDATE OSV
SET Gastro_ERCPConditions = 'Cholelithiasis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPConditions IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON opn.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND opn.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Cholelithiasis_3
              )
);

-- **3. Other Conditions of the Bile Duct (Priority 3)**
UPDATE OSV
SET Gastro_ERCPConditions = 'Other conditions of the bile duct'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPConditions IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON opn.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND opn.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OtherDiseaseBileDuct_3
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_OtherDiseaseBileDuct_4
                 )
          )
);

-- ========================================
-- Step 3.7: Update ERCP Complications
-- ========================================

-- **Gastro_ERCPComplications**

-- **1. Cholangitis (Priority 1)**
UPDATE OSV
SET Gastro_ERCPComplications = 'Cholangitis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ERCPComplic_Cholangitis_4
              )
);

-- **2. Pancreatitis (Priority 2)**
UPDATE OSV
SET Gastro_ERCPComplications = 'Pancreatitis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ERCPComplic_Pancreatitis_3
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ERCPComplic_Pancreatitis_4
                 )
          )
);

-- **3. Infection (Priority 3)**
UPDATE OSV
SET Gastro_ERCPComplications = 'Infection'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIComplic_Infection_4
              )
);

-- **4. Haemorrhage (Priority 4)**
UPDATE OSV
SET Gastro_ERCPComplications = 'Haemorrhage'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIComplic_Haemorrhage_4
              )
);

-- **5. Perforation (Priority 5)**
UPDATE OSV
SET Gastro_ERCPComplications = 'Perforation'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIComplic_Perforation_4
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_ERCPComplic_Perforation_4
                 )
          )
);

-- **6. GI Bleeding (Priority 6)**
UPDATE OSV
SET Gastro_ERCPComplications = 'GI Bleeding'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGI_bleeding_4
              )
);

-- **7. Other Post Procedural Disorder (Priority 7)**
UPDATE OSV
SET Gastro_ERCPComplications = 'Other Post Procedural Disorder'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIComplic_PostProcedure_3
              )
);

-- **8. Other Complication (Priority 8)**
UPDATE OSV
SET Gastro_ERCPComplications = 'Other Complication'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Complications_3
              )
);

-- **9. Other Adverse Event (Priority 9)**
UPDATE OSV
SET Gastro_ERCPComplications = 'Other Adverse Event'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCPComplications IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AdverseIncident_3
              )
);

-- ========================================
-- Step 3.8: Update Duodenal and Gastric Ulcers
-- ========================================

-- **Gastro_DuodenalUlcer**

-- **1. Duodenal Ulcer with Haemorrhage (Priority 1)**
UPDATE OSV
SET Gastro_DuodenalUlcer = 'With haemorrhage'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_DuodenalUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_DuodenalUlcer_haem_4
              )
);

-- **2. Duodenal Ulcer with Perforation (Priority 2)**
UPDATE OSV
SET Gastro_DuodenalUlcer = 'With perforation'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_DuodenalUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_DuodenalUlcer_perf_4
              )
);

-- **3. Duodenal Ulcer with Other Presentation (Priority 3)**
UPDATE OSV
SET Gastro_DuodenalUlcer = 'With other presentation'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_DuodenalUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_DuodenalUlcer_3
              )
);

-- **Gastro_GastricUlcer**

-- **1. Gastric Ulcer with Haemorrhage (Priority 1)**
UPDATE OSV
SET Gastro_GastricUlcer = 'With haemorrhage'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_GastricUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricUlcer_haem_4
              )
);

-- **2. Gastric Ulcer with Perforation (Priority 2)**
UPDATE OSV
SET Gastro_GastricUlcer = 'With perforation'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_GastricUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricUlcer_perf_4
              )
);

-- **3. Gastric Ulcer with Other Presentation (Priority 3)**
UPDATE OSV
SET Gastro_GastricUlcer = 'With other presentation'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_GastricUlcer IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_GastricUlcer_3
              )
);

-- ========================================
-- Step 3.9: Update Upper GI Varices
-- ========================================

-- **Gastro_UpperGIVarices**

-- **1. Oesophageal Varices - Bleeding (Priority 1)**
UPDATE OSV
SET Gastro_UpperGIVarices = 'Oesophageal varices - bleeding'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_UpperGIVarices IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagealVariceal_bleed_4
              )
);

-- **2. Oesophageal Varices - Not Bleeding (Priority 2)**
UPDATE OSV
SET Gastro_UpperGIVarices = 'Oesophageal varices - not bleeding'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_UpperGIVarices IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagealVariceal_NoBleed_4
              )
);

-- **3. Other GI Varices - Bleeding (Priority 3)**
UPDATE OSV
SET Gastro_UpperGIVarices = 'Other GI varices - bleeding'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_UpperGIVarices IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGI_bleeding_4
              )
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricVarices_4
              )
);

-- **4. Other GI Varices - Not Bleeding (Priority 4)**
UPDATE OSV
SET Gastro_UpperGIVarices = 'Other GI varices - not bleeding'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_UpperGIVarices IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricVarices_4
              )
);

-- ========================================
-- Step 3.10: Update GI Bleeding and Complications
-- ========================================

-- **Gastro_GIBleeding**

-- **1. GI Bleeding Excluding Ulcers (Priority 1)**
UPDATE OSV
SET Gastro_GIBleeding = 'GI Bleeding Excluding Ulcers'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_GIBleeding IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGI_bleeding_4
              )
);

-- **2. Endoscopic Banding of Oesophageal Varices (Priority 1)**
UPDATE OSV
SET Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_GIVaricesBanding IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON opn.OP_Attendance_ID = ipd.OP_Attendance_ID
               AND opn.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIVariceal_banding_4
              )
          AND
          (
              LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_OesophagealVariceal_bleed_4
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_OesophagealVariceal_NoBleed_4
                 )
          )
);

-- **3. Endoscopic Banding of Other GI Varices (Priority 2)**
UPDATE OSV
SET Gastro_GIVaricesBanding = 'Endoscopic band ligation of other GI varices'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_GIVaricesBanding IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_GastricVarices_4
              )
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_UpperGIVariceal_banding_4
              )
);

-- ========================================
-- Step 3.11: Update Age Groups
-- ========================================

-- **Age Under 55**
UPDATE OSV
SET Age_Under_55 = 1
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Age < 55;

-- **Age Under 50**
UPDATE OSV
SET Age_Under_50 = 1
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Age < 50;

-- **Age Between 50 and 80**
UPDATE OSV
SET Age_Between_50_80 = 1
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Age
BETWEEN 50 AND 80;

-- **Age Over 80**
UPDATE OSV
SET Age_Over_80 = 1
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Age > 80;

-- ========================================
-- Step 3.12: Update Cirrhosis and Liver Diseases
-- ========================================

-- **Gastro_Cirrhosis**

-- **1. Alcohol-related Cirrhosis (Priority 1)**
UPDATE OSV
SET Gastro_Cirrhosis = 'Alcohol-related cirrhosis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Cirrhosis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AlcoholicCirrhosis_4
              )
);

-- **2. Non-Alcohol Cirrhosis (Priority 2)**
UPDATE OSV
SET Gastro_Cirrhosis = 'Non-alcohol cirrhosis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Cirrhosis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_NonAlcholicCirrhosis_4
              )
);

-- **Gastro_LiverDisease**

-- **1. Alcohol-related Liver Disease (Priority 1)**
UPDATE OSV
SET Gastro_LiverDisease = 'Alcohol-related liver disease'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AlcoholicLD_3
              )
);

-- **2. Cirrhosis (Priority 2)**
UPDATE OSV
SET Gastro_LiverDisease = 'Cirrhosis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND
          (
              LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AlcoholicCirrhosis_4
              )
              OR LEFT(ipd.Diagnosis_Code, 4)IN
                 (
                     SELECT Code FROM #CodeGroup_NonAlcholicCirrhosis_4
                 )
          )
);

-- **3. Non-Alcohol Fatty Liver Disease (Priority 3)**
UPDATE OSV
SET Gastro_LiverDisease = 'Non-alcohol fatty liver disease'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_NonAlcoholFattyLD_4
              )
);

-- **4. Chronic Hepatic Failure (Priority 4)**
UPDATE OSV
SET Gastro_LiverDisease = 'Chronic hepatic failure'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ChronicHepaticFailure_3
              )
);

-- **5. Other Inflammatory Liver Disease (Priority 5)**
UPDATE OSV
SET Gastro_LiverDisease = 'Other inflammatory liver disease'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OtherInflammatoryLD_3
              )
);

-- **6. Other Liver Disease (Priority 6)**
UPDATE OSV
SET Gastro_LiverDisease = 'Other liver disease'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_LiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_GeneralLD_3
              )
);

-- **Gastro_OtherLiverDisease**

-- **1. OtherLiverDisease (Priority 1)**
UPDATE OSV
SET Gastro_OtherLiverDisease = 'OtherLiverDisease'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OtherLiverDisease IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OtherLiverDisease
              )
          AND LEFT(ipd.Diagnosis_Code, 4) NOT IN
              (
                  SELECT Code FROM #CodeGroup_OtherLiverDiseaseExc
              )
);

-- ========================================
-- Step 3.13: Update Additional Variables
-- ========================================

-- **Gastro_ViralHepatitis**

-- **1. Viral Hepatitis (Priority 1)**
UPDATE OSV
SET Gastro_ViralHepatitis = 'Viral hepatitis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ViralHepatitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_ViralHepititis_3
              )
);

-- **Gastro_Ascites**

-- **1. Ascites (Priority 1)**
UPDATE OSV
SET Gastro_Ascites = 'Ascites'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Ascites IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Ascites_3
              )
);

-- **Gastro_Peritonitis**

-- **1. Spontaneous Bacterial Peritonitis (Priority 1)**
UPDATE OSV
SET Gastro_Peritonitis = 'Spontaneous bacterial peritonitis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Peritonitis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Spon_bact_peritonitis_3
              )
);

-- **Gastro_AKI_Hyponatraemia**

-- **1. Acute Kidney Injury or Hyponatraemia (Priority 1)**
UPDATE OSV
SET Gastro_AKI_Hyponatraemia = 'Acute Kidney Injury or Hyponatraemia'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_AKI_Hyponatraemia IS NULL
      AND
      (
          EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_AKI_3
              )
)
          OR EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AKI_4
              )
)
      );

-- **Gastro_Encephalopathy**

-- **1. Encephalopathy (Priority 1)**
UPDATE OSV
SET Gastro_Encephalopathy = 'Encephalopathy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Encephalopathy IS NULL
      AND
      (
          EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_EncephalopathyA_4
              )
)
          OR EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Encephalopathy_3
              )
)
      );

-- **Gastro_AscitesTapDrain**

-- **1. Ascitic Tap or Drain (Priority 1)**
UPDATE OSV
SET Gastro_AscitesTapDrain = 'Ascitic tap or drain'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_AscitesTapDrain IS NULL
      AND
      (
          EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Ascitic_drain_4
              )
)
          OR EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Ascitic_tap_4
              )
)
      );

-- **Gastro_Nutrition**

-- **1. Total Parenteral Nutrition (TPN) (Priority 1)**
UPDATE OSV
SET Gastro_Nutrition = 'Total parenteral nutrition (TPN)'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Nutrition IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_TPN_4
              )
);

-- **Gastro_VascularLineInfection**

-- **1. Infection and Inflammation of Vascular Device (Priority 1)**
UPDATE OSV
SET Gastro_VascularLineInfection = 'Infection and inflammation of vascular device'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_VascularLineInfection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Diagnosis_Normalised ipd
            ON ope.OP_Attendance_ID = IPD.OP_Attendance_ID
               AND ope.Sector = ipd.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipd.Diagnosis_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Line_infections_4
              )
);

-- ========================================
-- Step 3.14: Update Colectomy and Colonic Resection Procedures
-- ========================================

-- **Gastro_Proctocolectomy_with_Ileo_Anal_Pouch**

-- **1. Proctocolectomy with Ileo-Anal Pouch (Priority 1)**
UPDATE OSV
SET Gastro_Proctocolectomy_with_Ileo_Anal_Pouch = 'Proctocolectomy with Ileo-Anal Pouch'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Proctocolectomy_with_Ileo_Anal_Pouch IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Proctocolectomy_with_ileo_anal_pouch
              )
);

-- **Gastro_Proctocolectomy_with_Ileostomy**

-- **1. Proctocolectomy with Ileostomy (Priority 1)**
UPDATE OSV
SET Gastro_Proctocolectomy_with_Ileostomy = 'Proctocolectomy with Ileostomy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Proctocolectomy_with_Ileostomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Appointment_Frozen ope
        INNER JOIN PAS_OP_Procedure_Normalised ipp1
            ON ope.OP_Attendance_ID = ipp1.OP_Attendance_ID
               AND ope.Sector = ipp1.Sector
    WHERE OSV.OP_Attendance_ID = ope.OP_Attendance_ID
          AND OSV.Sector = ope.Sector
          AND LEFT(ipp1.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Proctocolectomy_with_ileostomy_4
              )
)
   ;

-- **Gastro_Colectomy_with_Ileo_Rectal_Anastomosis**

-- **1. Colectomy with Ileo-Rectal Anastomosis (Priority 1)**
UPDATE OSV
SET Gastro_Colectomy_with_Ileo_Rectal_Anastomosis = 'Colectomy with Ileo-Rectal Anastomosis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Colectomy_with_Ileo_Rectal_Anastomosis IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Colectomy_and_ileo_rectal_anastomosis
              )
);

-- **Gastro_Right_Hemicolectomy**

-- **1. Right Hemicolectomy (Priority 1)**
UPDATE OSV
SET Gastro_Right_Hemicolectomy = 'Right Hemicolectomy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Right_Hemicolectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Right_hemicolectomy
              )
);

-- **Gastro_Extended_Right_Hemicolectomy**

-- **1. Extended Right Hemicolectomy (Priority 1)**
UPDATE OSV
SET Gastro_Extended_Right_Hemicolectomy = 'Extended Right Hemicolectomy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Extended_Right_Hemicolectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Extended_right_hemicolectomy
              )
);

-- **Gastro_Sigmoid_Colectomy**

-- **1. Sigmoid Colectomy (Priority 1)**
UPDATE OSV
SET Gastro_Sigmoid_Colectomy = 'Sigmoid Colectomy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Sigmoid_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_SigmoidColectomy_3
              )
);

-- **Gastro_Left_Hemicolectomy**

-- **1. Left Hemicolectomy (Priority 1)**
UPDATE OSV
SET Gastro_Left_Hemicolectomy = 'Left Hemicolectomy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Left_Hemicolectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_LeftHemicolectomy_3
              )
);


-- **Gastro_Transverse_Colectomy**

-- **1. Transverse Colectomy (Priority 1)**
UPDATE OSV
SET Gastro_Transverse_Colectomy = 'Transverse Colectomy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Transverse_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Transverse_colectomy
              )
);

-- **Gastro_Other_Subtotal_Colectomy**

-- **1. Other Subtotal Colectomy (Priority 1)**
UPDATE OSV
SET Gastro_Other_Subtotal_Colectomy = 'Other Subtotal Colectomy'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Other_Subtotal_Colectomy IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_Subtotal_colectomy
              )
);

-- ========================================
-- Step 3.15: Update Hartmann's Procedure and Rectal Excision
-- ========================================

-- **GenS_RectalExcision**

-- **1. Hartmann's Procedure (Priority 1)**
UPDATE OSV
SET GenS_RectalExcision = 'Hartmann''s Procedure'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gens_RectalExcision IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_Hartmanns
              )
);

-- **2. Rectal Excision (Priority 2)**
UPDATE OSV
SET GenS_RectalExcision = 'Rectal Excision'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.GenS_RectalExcision IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_RectalExcision_3
              )
);

-- **3. Perianal Surgery (Priority 3)**
UPDATE OSV
SET GenS_RectalExcision = 'Perianal Surgery'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.GenS_RectalExcision IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_PeranalSurgery_4
              )
);

-- ========================================
-- Step 3.16: Update Rectal and Perianal Surgery
-- ========================================

-- **GenS_OtherColonicResection**

-- **1. Rectal Surgery (Priority 1)**
UPDATE OSV
SET GenS_OtherColonicResection = 'Rectal Surgery'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_RectalSurgery_4
              )
);

-- **2. Exenteration of Pelvis (Priority 2)**
UPDATE OSV
SET GenS_OtherColonicResection = 'Exenteration of Pelvis'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_ExenterationPelvis_4
              )
);

-- **3. Anastomosis Colon (Priority 3)**
UPDATE OSV
SET GenS_OtherColonicResection = 'Anastomosis Colon'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 4)IN
              (
                  SELECT Code FROM #CodeGroup_AnastomosisColon_4
              )
);

-- **4. Other Colon Excision (Priority 4)**
UPDATE OSV
SET GenS_OtherColonicResection = 'Other Colon Excision'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_OtherColonExcision_3
              )
);

-- **5. Subtotal Colon Excision (Priority 5)**
UPDATE OSV
SET GenS_OtherColonicResection = 'Subtotal Colon Excision'
FROM #OP_Spells_With_Variables OSV
WHERE OSV.GenS_OtherColonicResection IS NULL
      AND EXISTS
(
    SELECT 1
    FROM PAS_OP_Procedure_Normalised opn
    WHERE OSV.OP_Attendance_ID = opn.OP_Attendance_ID
          AND OSV.Sector = opn.Sector
          AND LEFT(opn.Procedure_Code, 3)IN
              (
                  SELECT Code FROM #CodeGroup_SubTotalColonExcision_3
              )
);

-- ========================================
-- Step 3.18: Update GenS_ColonicResection_Cancer
-- ========================================

-- **GenS_ColonicResection_Cancer: Resection for colorectal cancer**
UPDATE OSV
SET GenS_ColonicResection_Cancer = 'Resection for colorectal cancer'
FROM #OP_Spells_With_Variables OSV
WHERE (
          OSV.GenS_Colectomy NOT IN ( 'Other' )
          OR OSV.GenS_RectalExcision NOT IN ( 'Other' )
          OR OSV.GenS_OtherColonicResection NOT IN ( 'Other' )
      )
      AND OSV.GenS_ColorectalCancer NOT IN ( 'Other' );

-- ========================================
-- Update Flags
-- ========================================

-- Step 1: Set default value of the flag to 0 for all records where it's NULL
UPDATE SWV
SET Gastro_FLAG_AlcoholicLiverDisease = 0
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_FLAG_AlcoholicLiverDisease IS NULL;

-- Step 2: Identify spells where any episode has alcoholic liver disease
WITH AlcoholicLiverDisease_Spells
AS (SELECT DISTINCT
           Spell_Number
    FROM #Spells_With_Variables
    WHERE Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' ))

-- Step 3: Update the flag to 1 for all episodes in those spells
UPDATE SWV
SET Gastro_FLAG_AlcoholicLiverDisease = 1
FROM #Spells_With_Variables SWV
    INNER JOIN AlcoholicLiverDisease_Spells ALDS
        ON SWV.Spell_Number = ALDS.Spell_Number;

-- Step 1: Set default value of the flag to 0 for all records where it's NULL
UPDATE SWV
SET Gastro_FLAG_GastricUlcer = 0
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_FLAG_GastricUlcer IS NULL;

-- Step 2: For each spell, find the earliest occurrence of gastric and duodenal ulcers
WITH Ulcer_Timings
AS (SELECT Spell_Number,
           MIN(   CASE
                      WHEN Gastro_GastricUlcer <> 'Other' THEN
                          Admission_Date
                  END
              ) AS GastricUlcer_Date,
           MIN(   CASE
                      WHEN Gastro_DuodenalUlcer <> 'Other' THEN
                          Admission_Date
                  END
              ) AS DuodenalUlcer_Date
    FROM #Spells_With_Variables
    GROUP BY Spell_Number),

     -- Step 3: Determine spells where gastric ulcer appears before duodenal ulcer
     GastricUlcer_Spells
AS (SELECT Spell_Number
    FROM Ulcer_Timings
    WHERE GastricUlcer_Date IS NOT NULL
          AND
          (
              DuodenalUlcer_Date IS NULL
              OR GastricUlcer_Date <= DuodenalUlcer_Date
          ))

-- Step 4: Update the flag to 1 for all records in spells where gastric ulcer appears first
UPDATE SWV
SET Gastro_FLAG_GastricUlcer = 1
FROM #Spells_With_Variables SWV
    INNER JOIN GastricUlcer_Spells GUS
        ON SWV.Spell_Number = GUS.Spell_Number;

/* -------------------------------------------------------------------
   Update Gastro_FLAG_ERCPComplications in SWV and OSV Tables
------------------------------------------------------------------- */

-- Step 1: Identify Index Admissions (both SWV and OSV)

-- Inpatient Index Admissions from SWV
SELECT SWV.PAS_Number AS Patient_ID,
       SWV.Spell_Number AS Index_Spell_Number,
       SWV.Admission_Date AS Index_Admission_Date,
       SWV.Discharge_Date AS Index_Discharge_Date,
       'Inpatient' AS Admission_Type
INTO #Index_Admissions
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND SWV.POD_Derived IN ( 'DC', 'EL' );

-- Outpatient Index Admissions from OSV
INSERT INTO #Index_Admissions
SELECT OSV.PAS_Number AS Patient_ID,
       OSV.OP_Attendance_ID AS Index_Spell_Number,
       OSV.Appointment_Date AS Index_Admission_Date,
       OSV.Appointment_Date AS Index_Discharge_Date, -- Assuming same-day discharge
       'Outpatient' AS Admission_Type
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' );

-- Step 2: Identify Return Admissions with Complications within 30 days

-- From SWV
SELECT DISTINCT
       IA.Patient_ID,
       IA.Index_Spell_Number,
       RA.Spell_Number AS Return_Spell_Number,
       RA.Admission_Date AS Return_Admission_Date,
       IA.Admission_Type
INTO #Complications
FROM #Index_Admissions IA
    INNER JOIN #Spells_With_Variables RA
        ON IA.Patient_ID = RA.PAS_Number
WHERE RA.Gastro_ERCPComplications <> 'Other'
      AND RA.Admission_Date > IA.Index_Discharge_Date
      AND RA.Admission_Date <= DATEADD(DAY, 30, IA.Index_Discharge_Date);

-- From OSV
INSERT INTO #Complications
SELECT DISTINCT
       IA.Patient_ID,
       IA.Index_Spell_Number,
       RA.OP_Attendance_ID AS Return_Spell_Number,
       RA.Appointment_Date AS Return_Admission_Date,
       IA.Admission_Type
FROM #Index_Admissions IA
    INNER JOIN #OP_Spells_With_Variables RA
        ON IA.Patient_ID = RA.PAS_Number
WHERE RA.Gastro_ERCPComplications <> 'Other'
      AND RA.Appointment_Date > IA.Index_Discharge_Date
      AND RA.Appointment_Date <= DATEADD(DAY, 30, IA.Index_Discharge_Date);

-- Step 3: Update the flag for Index Admissions where complications are found

-- For Inpatient Index Admissions in SWV
UPDATE SWV
SET Gastro_FLAG_ERCPComplications = 1
FROM #Spells_With_Variables SWV
    INNER JOIN #Complications C
        ON SWV.Spell_Number = C.Index_Spell_Number
WHERE C.Admission_Type = 'Inpatient';

-- For Outpatient Index Admissions in OSV
UPDATE OSV
SET Gastro_FLAG_ERCPComplications = 1
FROM #OP_Spells_With_Variables OSV
    INNER JOIN #Complications C
        ON OSV.OP_Attendance_ID = C.Index_Spell_Number
WHERE C.Admission_Type = 'Outpatient';

-- Step 4: Set default value to 0 for Index Admissions where the flag is NULL

-- Inpatient Index Admissions in SWV
UPDATE SWV
SET Gastro_FLAG_ERCPComplications = 0
FROM #Spells_With_Variables SWV
    INNER JOIN #Index_Admissions IA
        ON SWV.Spell_Number = IA.Index_Spell_Number
WHERE SWV.Gastro_FLAG_ERCPComplications IS NULL
      AND IA.Admission_Type = 'Inpatient';

-- Outpatient Index Admissions in OSV
UPDATE OSV
SET Gastro_FLAG_ERCPComplications = 0
FROM #OP_Spells_With_Variables OSV
    INNER JOIN #Index_Admissions IA
        ON OSV.OP_Attendance_ID = IA.Index_Spell_Number
WHERE OSV.Gastro_FLAG_ERCPComplications IS NULL
      AND IA.Admission_Type = 'Outpatient';

-- Clean up temporary tables
DROP TABLE #Index_Admissions;
DROP TABLE #Complications;

-- Update Read30 flag
UPDATE SWV
SET Read30 = 1
FROM #Spells_With_Variables SWV
    LEFT JOIN [M0026_Readmissions] ram
        ON swv.Spell_Number = ram.Parent_Spell_Number
           AND swv.Sector = ram.Parent_Sector_Code
WHERE ram.M0026b_Readmission_Numerator_Less_30_Day = 1;

-- Update Read30_0LOS flag
UPDATE SWV
SET Read30_0LOS = 1
FROM #Spells_With_Variables SWV
    LEFT JOIN [M0026_Readmissions] ram
        ON SWV.Spell_Number = ram.Parent_Spell_Number
           AND SWV.Sector = ram.Parent_Sector_Code
WHERE ram.M0026b_Readmission_Numerator_Less_30_Day = 1
      AND SWV.Spell_LOS = 0;

/* Step 1: Update Mort30 to 1 for in-hospital deaths during the initial spell */
UPDATE SWV
SET Mort30 = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Spell_Frozen] ips
        ON SWV.Spell_Number = ips.Spell_Number
           AND SWV.Sector = ips.Sector
WHERE ips.Method_Of_Discharge_Code IN ( '4', '5' );

/* Step 2: Update Mort30 to 1 for deaths within 30 days after discharge based on M0026_Readmissions */
-- We will look for readmissions where the patient died within 30 days of the initial discharge date.

UPDATE SWV
SET Mort30 = 1
FROM #Spells_With_Variables SWV
    INNER JOIN [M0026_Readmissions] MR
        ON SWV.Spell_Number = MR.Parent_Spell_Number
WHERE MR.M0026l_Readmission_Deceased_On_Discharge = 1
      AND MR.M0026c_Days_To_Readmission > 0
      AND MR.M0026c_Days_To_Readmission <= 30;

/* -------------------------------------------------------------------
	Features of Gastroenterology Services
 ------------------------------------------------------------------- */

/* Number of outpatient Gastroenterology and Hepatology attendances (monthly) 

COUNT (Attendances)
Gastro_TreatmentSpecialty ='Gastroenterology or Hepatology'  
AND Care_setting = 'OP' 
AND POD_Setting = 'Attendance'

Metric ID: GE7100
Date: June 2024

*/

-- Metric GE7100: Number of outpatient Gastroenterology and Hepatology attendances (monthly)

DECLARE @GE7100_StartDate DATE = '2024-06-01';
DECLARE @GE7100_EndDate DATE = '2024-06-30';

DECLARE @GE7100_Num_Attendances INT;

SELECT @GE7100_Num_Attendances = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.TRETSPEF IN ( '301', '306' ) -- Gastroenterology or Hepatology
      AND OSV.Attendance_Status_Code = '5' -- Attended appointments
      AND OSV.Appointment_Date
      BETWEEN @GE7100_StartDate AND @GE7100_EndDate;

SELECT 'GE7100 - Number of outpatient Gastroenterology and Hepatology attendances (monthly)' AS Metric,
       @GE7100_Num_Attendances AS Value;


/* Percentage of virtual (non face-to-face) Gastroenterology and Hepatology outpatient attendances (12mths to qtr end) 

COUNT (Attendances)Gastro_TreatmentSpecialty ='Gastroenterology or Hepatology'  
AND Care_Setting = 'OP'  
AND POD_Setting = 'Attendance' 
AND POD_Face = 'Virtual'

COUNT (Attendances)Gastro_TreatmentSpecialty ='Gastroenterology or Hepatology'  
AND Care_setting = 'OP' 
AND POD_Setting = 'Attendance'

Metric ID: GE7101
Date: Q1 2024/25

*/

DECLARE @GE7101_StartDate DATE = '2023-07-01';
DECLARE @GE7101_EndDate DATE = '2024-06-30';

DECLARE @GE7101_Num_Virtual INT;
DECLARE @GE7101_Denom_Total INT;
DECLARE @GE7101_Percentage_Virtual FLOAT;

-- Numerator: Virtual attendances
SELECT @GE7101_Num_Virtual = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.TRETSPEF IN ( '301', '306' ) -- Gastroenterology or Hepatology
      AND OSV.Attendance_Status_Code = '5' -- Attended appointments
      AND OSV.Virtual_Booking = 1 -- Virtual appointments
      AND OSV.Appointment_Date
      BETWEEN @GE7101_StartDate AND @GE7101_EndDate;

-- Denominator: All attendances
SELECT @GE7101_Denom_Total = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.TRETSPEF IN ( '301', '306' ) -- Gastroenterology or Hepatology
      AND OSV.Attendance_Status_Code = '5' -- Attended appointments
      AND OSV.Appointment_Date
      BETWEEN @GE7101_StartDate AND @GE7101_EndDate;

-- Calculate percentage
SET @GE7101_Percentage_Virtual = (CAST(@GE7101_Num_Virtual AS FLOAT) / NULLIF(@GE7101_Denom_Total, 0)) * 100;

SELECT 'GE7101 - Percentage of virtual Gastroenterology and Hepatology outpatient attendances (12 months to quarter end)' AS Metric,
       ROUND(@GE7101_Percentage_Virtual, 2) AS Percentage,
       @GE7101_Num_Virtual AS Numerator,
       @GE7101_Denom_Total AS Denominator;

/* Follow-up to new ratio for Gastroenterology and Hepatology outpatient attendances (12mths to qtr end) 

COUNT (Attendances)Gastro_TreatmentSpecialty ='Gastroenterology or Hepatology'  
AND Care_Setting = 'OP' 
AND POD_Setting = 'Attendance' 
AND POD_Type = 'Follow-up'

COUNT (Attendances)Gastro_TreatmentSpecialty ='Gastroenterology or Hepatology'  
AND Care_setting = 'OP' 
AND POD_Setting = 'Attendance' 
AND POD_Type = 'First'

Metric ID: GE7102
Date: Q1 2024/25

*/

DECLARE @GE7102_StartDate DATE = '2023-07-01';
DECLARE @GE7102_EndDate DATE = '2024-06-30';

DECLARE @GE7102_Num_FollowUp INT;
DECLARE @GE7102_Denom_First INT;
DECLARE @GE7102_Ratio_FollowUpToFirst FLOAT;

-- Numerator: Follow-up attendances
SELECT @GE7102_Num_FollowUp = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.TRETSPEF IN ( '301', '306' ) -- Gastroenterology or Hepatology
      AND OSV.Attendance_Status_Code = '5' -- Attended appointments
      AND OSV.Follow_Up_Appointment = 1 -- Follow-up appointments
      AND OSV.Appointment_Date
      BETWEEN @GE7102_StartDate AND @GE7102_EndDate;

-- Denominator: New appointments
SELECT @GE7102_Denom_First = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.TRETSPEF IN ( '301', '306' ) -- Gastroenterology or Hepatology
      AND OSV.Attendance_Status_Code = '5' -- Attended appointments
      AND OSV.New_Appointment = 1 -- New appointments
      AND OSV.Appointment_Date
      BETWEEN @GE7102_StartDate AND @GE7102_EndDate;

-- Calculate ratio
SET @GE7102_Ratio_FollowUpToFirst = @GE7102_Num_FollowUp / NULLIF(@GE7102_Denom_First, 0);

SELECT 'GE7102 - Follow-up to new ratio for Gastroenterology and Hepatology outpatient attendances (12 months to quarter end)' AS Metric,
       ROUND(@GE7102_Ratio_FollowUpToFirst, 2) AS Ratio,
       @GE7102_Num_FollowUp AS Numerator,
       @GE7102_Denom_First AS Denominator;

/* Planned procedures not carried out in Gastroenterology day case admissions (12mths to qtr end) 

COUNT (Spells)Gastro_MainSpecialty ='Gastroenterology'   
AND POD_Derived = 'DC' 
AND Gastro_Cancellation = 'Cancellation_all'

COUNT (Spells)Gastro_MainSpecialty ='Gastroenterology'  
AND POD_Derived = 'DC'

Metric ID: GE7103
Date: Q1 2024/25

*/

DECLARE @GE7103_StartDate DATE = '2023-07-01';
DECLARE @GE7103_EndDate DATE = '2024-06-30';

DECLARE @GE7103_Num_Cancellations INT;
DECLARE @GE7103_Denom_TotalDC INT;
DECLARE @GE7103_Percentage_Cancellations FLOAT;

-- Numerator: Cancellations in Gastroenterology Day Case Admissions
SELECT @GE7103_Num_Cancellations = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_MainSpecialty = 'Gastroenterology'
      AND SWV.POD_Derived = 'DC'
      AND SWV.Cancellation_All = 'Cancellation_all'
      AND SWV.Admission_Date
      BETWEEN @GE7103_StartDate AND @GE7103_EndDate;

-- Denominator: All Gastroenterology Day Case Admissions
SELECT @GE7103_Denom_TotalDC = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_MainSpecialty = 'Gastroenterology'
      AND SWV.POD_Derived = 'DC'
      AND SWV.Admission_Date
      BETWEEN @GE7103_StartDate AND @GE7103_EndDate;

-- Calculate Percentage
SET @GE7103_Percentage_Cancellations
    = (CAST(@GE7103_Num_Cancellations AS FLOAT) / NULLIF(@GE7103_Denom_TotalDC, 0)) * 100;

SELECT 'GE7103 - Planned Procedures Not Carried Out in Gastroenterology Day Case Admissions (12 months to quarter end)' AS Metric,
       ROUND(@GE7103_Percentage_Cancellations, 2) AS Percentage,
       @GE7103_Num_Cancellations AS Numerator,
       @GE7103_Denom_TotalDC AS Denominator;


/* -------------------------------------------------------------------
	Endoscopy - Gastroscopy
 ------------------------------------------------------------------- */

/* Number of gastroscopy procedures (all settings) (monthly) 

COUNT (Spell + Attendances)
Gastro_OesophagoGastroduodenoscopy IN ('Diagnostic OGD','Therapeutic OGD') 

Metric ID: GE7104
Date: June 2024

*/

DECLARE @GE7104_StartDate DATE = '2024-06-01';
DECLARE @GE7104_EndDate DATE = '2024-06-30';

DECLARE @GE7104_Num_Procedures INT;

-- From Inpatient Spells
SELECT @GE7104_Num_Procedures = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND SWV.Admission_Date
      BETWEEN @GE7104_StartDate AND @GE7104_EndDate;

-- From Outpatient Attendances
DECLARE @GE7104_Num_Attendances INT;

SELECT @GE7104_Num_Attendances = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND OSV.Appointment_Date
      BETWEEN @GE7104_StartDate AND @GE7104_EndDate;

-- Total Procedures
DECLARE @GE7104_Total_Procedures INT = @GE7104_Num_Procedures + @GE7104_Num_Attendances;

SELECT 'GE7104 - Number of Gastroscopy Procedures (All Settings) (Monthly)' AS Metric,
       @GE7104_Total_Procedures AS Value;

/* Percentage of patients receiving a gastroscopy procedure that are aged 17-54 years (12mths to qtr end) 

COUNT (Spell + Attendances)
Gastro_OesophagoGastroduodenoscopy IN ('Diagnostic OGD','Therapeutic OGD') 
AND Gastro_Age_Under_55 = 'Age_Under_55'

COUNT (Spell + Attendances)
Gastro_OesophagoGastroduodenoscopy IN ('Diagnostic OGD','Therapeutic OGD')

Metric ID: GE7105
Date: Q1 2024/25

*/

DECLARE @GE7105_StartDate DATE = '2023-07-01';
DECLARE @GE7105_EndDate DATE = '2024-06-30';

-- Numerator: Patients aged 17-54
DECLARE @GE7105_Num_IP INT;
DECLARE @GE7105_Num_OP INT;

-- Inpatient Spells
SELECT @GE7105_Num_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND SWV.Age
      BETWEEN 17 AND 54
      AND SWV.Admission_Date
      BETWEEN @GE7105_StartDate AND @GE7105_EndDate;

-- Outpatient Attendances
SELECT @GE7105_Num_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND OSV.Age
      BETWEEN 17 AND 54
      AND OSV.Appointment_Date
      BETWEEN @GE7105_StartDate AND @GE7105_EndDate;

DECLARE @GE7105_Numerator INT = @GE7105_Num_IP + @GE7105_Num_OP;

-- Denominator: All patients receiving gastroscopy
DECLARE @GE7105_Denom_IP INT;
DECLARE @GE7105_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7105_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND SWV.Admission_Date
      BETWEEN @GE7105_StartDate AND @GE7105_EndDate;

-- Outpatient Attendances
SELECT @GE7105_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND OSV.Appointment_Date
      BETWEEN @GE7105_StartDate AND @GE7105_EndDate;

DECLARE @GE7105_Denominator INT = @GE7105_Denom_IP + @GE7105_Denom_OP;

-- Calculate Percentage
DECLARE @GE7105_Percentage_Age17_54 FLOAT;
SET @GE7105_Percentage_Age17_54 = (CAST(@GE7105_Numerator AS FLOAT) / NULLIF(@GE7105_Denominator, 0)) * 100;

SELECT 'GE7105 - Percentage of Patients Aged 17-54 Receiving a Gastroscopy Procedure (12 months to quarter end)' AS Metric,
       ROUND(@GE7105_Percentage_Age17_54, 2) AS Percentage,
       @GE7105_Numerator AS Numerator,
       @GE7105_Denominator AS Denominator;

/* Percentage of gastroscopies carried out as a diagnostic procedure (12mths to qtr end) 

COUNT (Spell + Attendances)
Gastro_OesophagoGastroduodenoscopy IN ('Diagnostic OGD') 
AND (Care_setting = 'OP' OR POD_Derived in ('DC','EL')) 

COUNT (Spell + Attendances)
Gastro_OesophagoGastroduodenoscopy IN ('Diagnostic OGD','Therapeutic OGD') 

Metric ID: GE7106
Date: Q1 2024/25

*/

DECLARE @GE7106_StartDate DATE = '2023-07-01';
DECLARE @GE7106_EndDate DATE = '2024-06-30';

-- Numerator: Diagnostic gastroscopies
DECLARE @GE7106_Num_IP INT;
DECLARE @GE7106_Num_OP INT;

-- Inpatient Spells
SELECT @GE7106_Num_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy = 'Diagnostic OGD'
      AND SWV.POD_Derived IN ( 'DC', 'EL' )
      AND SWV.Admission_Date
      BETWEEN @GE7106_StartDate AND @GE7106_EndDate;

-- Outpatient Attendances
SELECT @GE7106_Num_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy = 'Diagnostic OGD'
      AND OSV.Appointment_Date
      BETWEEN @GE7106_StartDate AND @GE7106_EndDate;

DECLARE @GE7106_Numerator INT = @GE7106_Num_IP + @GE7106_Num_OP;

-- Denominator: All gastroscopy procedures
DECLARE @GE7106_Denom_IP INT;
DECLARE @GE7106_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7106_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND SWV.Admission_Date
      BETWEEN @GE7106_StartDate AND @GE7106_EndDate;

-- Outpatient Attendances
SELECT @GE7106_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND OSV.Appointment_Date
      BETWEEN @GE7106_StartDate AND @GE7106_EndDate;

DECLARE @GE7106_Denominator INT = @GE7106_Denom_IP + @GE7106_Denom_OP;

-- Calculate Percentage
DECLARE @GE7106_Percentage_Diagnostic FLOAT;
SET @GE7106_Percentage_Diagnostic = (CAST(@GE7106_Numerator AS FLOAT) / NULLIF(@GE7106_Denominator, 0)) * 100;

SELECT 'GE7106 - Percentage of Gastroscopies Carried Out as a Diagnostic Procedure (12 months to quarter end)' AS Metric,
       ROUND(@GE7106_Percentage_Diagnostic, 2) AS Percentage,
       @GE7106_Numerator AS Numerator,
       @GE7106_Denominator AS Denominator;

/* Percentage of gastroscopies carried out in an outpatient setting (12mths to qtr end) 

COUNT (Attendances)
Gastro_OesophagoGastroduodenoscopy IN ('Diagnostic OGD','Therapeutic OGD') 
AND Care_setting = 'OP'

COUNT (Spell + Attendances)
Gastro_OesophagoGastroduodenoscopy IN ('Diagnostic OGD','Therapeutic OGD') 

Metric ID: GE7107
Date: Q1 2024/25

*/

DECLARE @GE7107_StartDate DATE = '2023-07-01';
DECLARE @GE7107_EndDate DATE = '2024-06-30';

-- Numerator: Outpatient gastroscopies
DECLARE @GE7107_Numerator INT;

SELECT @GE7107_Numerator = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND OSV.Appointment_Date
      BETWEEN @GE7107_StartDate AND @GE7107_EndDate;

-- Denominator: All gastroscopy procedures
DECLARE @GE7107_Denom_IP INT;
DECLARE @GE7107_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7107_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND SWV.Admission_Date
      BETWEEN @GE7107_StartDate AND @GE7107_EndDate;

-- Outpatient Attendances
SELECT @GE7107_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND OSV.Appointment_Date
      BETWEEN @GE7107_StartDate AND @GE7107_EndDate;

DECLARE @GE7107_Denominator INT = @GE7107_Denom_IP + @GE7107_Denom_OP;

-- Calculate Percentage
DECLARE @GE7107_Percentage_Outpatient FLOAT;
SET @GE7107_Percentage_Outpatient = (CAST(@GE7107_Numerator AS FLOAT) / NULLIF(@GE7107_Denominator, 0)) * 100;

SELECT 'GE7107 - Percentage of Gastroscopies Carried Out in an Outpatient Setting (12 months to quarter end)' AS Metric,
       ROUND(@GE7107_Percentage_Outpatient, 2) AS Percentage,
       @GE7107_Numerator AS Numerator,
       @GE7107_Denominator AS Denominator;

/* Percentage of gastroscopies carried out in a daycase or outpatient setting (12mths to qtr end) 

COUNT (Spell + Attendances)
Gastro_OesophagoGastroduodenoscopy IN ('Diagnostic OGD','Therapeutic OGD') 
AND (POD_Derived = 'DC' OR Care_setting = 'OP')

COUNT (Spell + Attendances)
Gastro_OesophagoGastroduodenoscopy IN ('Diagnostic OGD','Therapeutic OGD') 

Metric ID: GE7108
Date: Q1 2024/25

*/

DECLARE @GE7108_StartDate DATE = '2023-07-01';
DECLARE @GE7108_EndDate DATE = '2024-06-30';

-- Numerator: Day Case or Outpatient Gastroscopies
DECLARE @GE7108_Num_IP_DC INT;
DECLARE @GE7108_Num_OP INT;

-- Inpatient Day Cases
SELECT @GE7108_Num_IP_DC = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND SWV.POD_Derived = 'DC'
      AND SWV.Admission_Date
      BETWEEN @GE7108_StartDate AND @GE7108_EndDate;

-- Outpatient Attendances
SELECT @GE7108_Num_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND OSV.Appointment_Date
      BETWEEN @GE7108_StartDate AND @GE7108_EndDate;

DECLARE @GE7108_Numerator INT = @GE7108_Num_IP_DC + @GE7108_Num_OP;

-- Denominator: All gastroscopy procedures
DECLARE @GE7108_Denom_IP INT;
DECLARE @GE7108_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7108_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND SWV.Admission_Date
      BETWEEN @GE7108_StartDate AND @GE7108_EndDate;

-- Outpatient Attendances
SELECT @GE7108_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_OesophagoGastroduodenoscopy IN ( 'Diagnostic OGD', 'Therapeutic OGD' )
      AND OSV.Appointment_Date
      BETWEEN @GE7108_StartDate AND @GE7108_EndDate;

DECLARE @GE7108_Denominator INT = @GE7108_Denom_IP + @GE7108_Denom_OP;

-- Calculate Percentage
DECLARE @GE7108_Percentage_DC_OP FLOAT;
SET @GE7108_Percentage_DC_OP = (CAST(@GE7108_Numerator AS FLOAT) / NULLIF(@GE7108_Denominator, 0)) * 100;

SELECT 'GE7108 - Percentage of Gastroscopies Carried Out in a Day Case or Outpatient Setting (12 months to quarter end)' AS Metric,
       ROUND(@GE7108_Percentage_DC_OP, 2) AS Percentage,
       @GE7108_Numerator AS Numerator,
       @GE7108_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Endoscopy - Colonoscopy
 ------------------------------------------------------------------- */

/* Number of colonoscopy procedures (all settings) (monthly) 

COUNT (Spells + Attendances)
Gastro_Colonoscopy IN ('Diagnostic colonoscopy','Therapeutic colonoscopy') 
AND (Care_setting = 'OP' OR POD_Derived in ('DC','EL','NE','EM'))

Metric ID: GE7109
Date: June 2024

*/

DECLARE @GE7109_StartDate DATE = '2024-06-01';
DECLARE @GE7109_EndDate DATE = '2024-06-30';

-- Inpatient Spells
DECLARE @GE7109_Num_IP INT;

SELECT @GE7109_Num_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND SWV.POD_Derived IN ( 'DC', 'EL', 'NE', 'EM' )
      AND SWV.Admission_Date
      BETWEEN @GE7109_StartDate AND @GE7109_EndDate;

-- Outpatient Attendances
DECLARE @GE7109_Num_OP INT;

SELECT @GE7109_Num_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND OSV.Appointment_Date
      BETWEEN @GE7109_StartDate AND @GE7109_EndDate;

-- Total Procedures
DECLARE @GE7109_Total_Procedures INT = @GE7109_Num_IP + @GE7109_Num_OP;

SELECT 'GE7109 - Number of Colonoscopy Procedures (All Settings) (Monthly)' AS Metric,
       @GE7109_Total_Procedures AS Value;

/* Percentage of patients receiving a colonoscopy procedure that are aged 17-49 years (12mths to qtr end) 

COUNT (Spell + Attendances)
Gastro_Colonoscopy IN ('Diagnostic colonoscopy','Therapeutic colonoscopy') 
AND (Care_setting = 'OP' OR POD_Derived in ('DC','EL','NE','EM')) 
AND Gastro_Age_Under_50 = 'Age_Under_50'

COUNT (Spells + Attendances)
Gastro_Colonoscopy IN ('Diagnostic colonoscopy','Therapeutic colonoscopy') 
AND (Care_setting = 'OP' OR POD_Derived in ('DC','EL','NE','EM'))

Metric ID: GE7110
Date: Q1 2024/25

*/

DECLARE @GE7110_StartDate DATE = '2023-07-01';
DECLARE @GE7110_EndDate DATE = '2024-06-30';

-- Numerator: Patients aged 17-49
DECLARE @GE7110_Num_IP INT;
DECLARE @GE7110_Num_OP INT;

-- Inpatient Spells
SELECT @GE7110_Num_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND SWV.POD_Derived IN ( 'DC', 'EL', 'NE', 'EM' )
      AND SWV.Age
      BETWEEN 17 AND 49
      AND SWV.Admission_Date
      BETWEEN @GE7110_StartDate AND @GE7110_EndDate;

-- Outpatient Attendances
SELECT @GE7110_Num_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND OSV.Age
      BETWEEN 17 AND 49
      AND OSV.Appointment_Date
      BETWEEN @GE7110_StartDate AND @GE7110_EndDate;

DECLARE @GE7110_Numerator INT = @GE7110_Num_IP + @GE7110_Num_OP;

-- Denominator: All patients receiving colonoscopy
DECLARE @GE7110_Denom_IP INT;
DECLARE @GE7110_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7110_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND SWV.POD_Derived IN ( 'DC', 'EL', 'NE', 'EM' )
      AND SWV.Admission_Date
      BETWEEN @GE7110_StartDate AND @GE7110_EndDate;

-- Outpatient Attendances
SELECT @GE7110_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND OSV.Appointment_Date
      BETWEEN @GE7110_StartDate AND @GE7110_EndDate;

DECLARE @GE7110_Denominator INT = @GE7110_Denom_IP + @GE7110_Denom_OP;

-- Calculate Percentage
DECLARE @GE7110_Percentage_Age17_49 FLOAT;
SET @GE7110_Percentage_Age17_49 = (CAST(@GE7110_Numerator AS FLOAT) / NULLIF(@GE7110_Denominator, 0)) * 100;

SELECT 'GE7110 - Percentage of Patients Aged 17-49 Receiving a Colonoscopy Procedure (12 months to quarter end)' AS Metric,
       ROUND(@GE7110_Percentage_Age17_49, 2) AS Percentage,
       @GE7110_Numerator AS Numerator,
       @GE7110_Denominator AS Denominator;

/* Percentage of patients receiving a colonoscopy procedure that are aged 80 years and over (12mths to qtr end) 

COUNT (Spell + Attendances)
Gastro_Colonoscopy IN ('Diagnostic colonoscopy','Therapeutic colonoscopy') 
AND (Care_setting = 'OP' OR POD_Derived in ('DC','EL','NE','EM')) 
AND Gastro_Age_Over_80 = 'Age_Over_80'

COUNT (Spells + Attendances)
Gastro_Colonoscopy IN ('Diagnostic colonoscopy','Therapeutic colonoscopy') 
AND (Care_setting = 'OP' OR POD_Derived in ('DC','EL','NE','EM'))

Metric ID: GE7111
Date: Q1 2024/25

*/

DECLARE @GE7111_StartDate DATE = '2023-07-01';
DECLARE @GE7111_EndDate DATE = '2024-06-30';

-- Numerator: Patients aged 80 and over
DECLARE @GE7111_Num_IP INT;
DECLARE @GE7111_Num_OP INT;

-- Inpatient Spells
SELECT @GE7111_Num_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND SWV.POD_Derived IN ( 'DC', 'EL', 'NE', 'EM' )
      AND SWV.Age >= 80
      AND SWV.Admission_Date
      BETWEEN @GE7111_StartDate AND @GE7111_EndDate;

-- Outpatient Attendances
SELECT @GE7111_Num_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND OSV.Age >= 80
      AND OSV.Appointment_Date
      BETWEEN @GE7111_StartDate AND @GE7111_EndDate;

DECLARE @GE7111_Numerator INT = @GE7111_Num_IP + @GE7111_Num_OP;

-- Denominator: All patients receiving colonoscopy
DECLARE @GE7111_Denom_IP INT;
DECLARE @GE7111_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7111_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND SWV.POD_Derived IN ( 'DC', 'EL', 'NE', 'EM' )
      AND SWV.Admission_Date
      BETWEEN @GE7111_StartDate AND @GE7111_EndDate;

-- Outpatient Attendances
SELECT @GE7111_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND OSV.Appointment_Date
      BETWEEN @GE7111_StartDate AND @GE7111_EndDate;

DECLARE @GE7111_Denominator INT = @GE7111_Denom_IP + @GE7111_Denom_OP;

-- Calculate Percentage
DECLARE @GE7111_Percentage_Age80Plus FLOAT;
SET @GE7111_Percentage_Age80Plus = (CAST(@GE7111_Numerator AS FLOAT) / NULLIF(@GE7111_Denominator, 0)) * 100;

SELECT 'GE7111 - Percentage of Patients Aged 80 and Over Receiving a Colonoscopy Procedure (12 months to quarter end)' AS Metric,
       ROUND(@GE7111_Percentage_Age80Plus, 2) AS Percentage,
       @GE7111_Numerator AS Numerator,
       @GE7111_Denominator AS Denominator;

/* Percentage of colonoscopies carried out on patients staying overnight (i.e., NOT daycases or zero LOS non electives) (12mths to qtr end) 

COUNT (Spells)Gastro_Colonoscopy IN ('Diagnostic colonoscopy','Therapeutic colonoscopy') 
AND (POD_Derived in ('EL','NE','EM')) 
AND Spell_LOS != 0

COUNT (Spells + Attendances)
Gastro_Colonoscopy IN ('Diagnostic colonoscopy','Therapeutic colonoscopy') 
AND (Care_setting = 'OP' OR POD_Derived in ('DC','EL','NE','EM'))

Metric ID: GE7112
Date: Q1 2024/25

*/

DECLARE @GE7112_StartDate DATE = '2023-07-01';
DECLARE @GE7112_EndDate DATE = '2024-06-30';

-- Numerator: Inpatient spells with LOS > 0
DECLARE @GE7112_Numerator INT;

SELECT @GE7112_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND SWV.POD_Derived IN ( 'EL', 'NE', 'EM' )
      AND SWV.Spell_LOS != 0
      AND SWV.Admission_Date
      BETWEEN @GE7112_StartDate AND @GE7112_EndDate;

-- Denominator: All colonoscopy procedures
DECLARE @GE7112_Denom_IP INT;
DECLARE @GE7112_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7112_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND SWV.POD_Derived IN ( 'DC', 'EL', 'NE', 'EM' )
      AND SWV.Admission_Date
      BETWEEN @GE7112_StartDate AND @GE7112_EndDate;

-- Outpatient Attendances
SELECT @GE7112_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Colonoscopy IN ( 'Diagnostic colonoscopy', 'Therapeutic colonoscopy' )
      AND OSV.Appointment_Date
      BETWEEN @GE7112_StartDate AND @GE7112_EndDate;

DECLARE @GE7112_Denominator INT = @GE7112_Denom_IP + @GE7112_Denom_OP;

-- Calculate Percentage
DECLARE @GE7112_Percentage_Overnight FLOAT;
SET @GE7112_Percentage_Overnight = (CAST(@GE7112_Numerator AS FLOAT) / NULLIF(@GE7112_Denominator, 0)) * 100;

SELECT 'GE7112 - Percentage of Colonoscopies Carried Out on Patients Staying Overnight (12 months to quarter end)' AS Metric,
       ROUND(@GE7112_Percentage_Overnight, 2) AS Percentage,
       @GE7112_Numerator AS Numerator,
       @GE7112_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Endoscopy - Flexible Sigmoidoscopy
 ------------------------------------------------------------------- */

/* Number of flexible sigmoidoscopy procedures (all settings) (monthly) 

COUNT (Spell + Attendances)
Gastro_Sigmoidoscopy IN ('Diagnostic flexible sigmoidoscopy','Therapeutic flexible sigmoidoscopy') 

Metric ID: GE7113
Date: June 2024

*/

DECLARE @GE7113_StartDate DATE = '2024-06-01';
DECLARE @GE7113_EndDate DATE = '2024-06-30';

-- Inpatient Spells
DECLARE @GE7113_Num_IP INT;

SELECT @GE7113_Num_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Sigmoidoscopy IN ( 'Diagnostic flexible sigmoidoscopy', 'Therapeutic flexible sigmoidoscopy' )
      AND SWV.Admission_Date
      BETWEEN @GE7113_StartDate AND @GE7113_EndDate;

-- Outpatient Attendances
DECLARE @GE7113_Num_OP INT;

SELECT @GE7113_Num_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Sigmoidoscopy IN ( 'Diagnostic flexible sigmoidoscopy', 'Therapeutic flexible sigmoidoscopy' )
      AND OSV.Appointment_Date
      BETWEEN @GE7113_StartDate AND @GE7113_EndDate;

-- Total Procedures
DECLARE @GE7113_Total_Procedures INT = @GE7113_Num_IP + @GE7113_Num_OP;

SELECT 'GE7113 - Number of Flexible Sigmoidoscopy Procedures (All Settings) (Monthly)' AS Metric,
       @GE7113_Total_Procedures AS Value;

/* Percentage of flexible sigmoidoscopies carried out as a diagnostic procedure (12mths to qtr end) 

COUNT (Spell + Attendances)
Gastro_Sigmoidoscopy IN ('Diagnostic flexible sigmoidoscopy') 
AND (Care_setting = 'OP' 
OR POD_Derived in ('DC','EL'))

COUNT (Spell + Attendances)
Gastro_Sigmoidoscopy IN ('Diagnostic flexible sigmoidoscopy','Therapeutic flexible sigmoidoscopy') 

Metric ID: GE7114
Date: Q1 2024/25

*/

DECLARE @GE7114_StartDate DATE = '2023-07-01';
DECLARE @GE7114_EndDate DATE = '2024-06-30';

-- Numerator: Diagnostic flexible sigmoidoscopies
DECLARE @GE7114_Num_IP INT;
DECLARE @GE7114_Num_OP INT;

-- Inpatient Spells
SELECT @GE7114_Num_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Sigmoidoscopy = 'Diagnostic flexible sigmoidoscopy'
      AND SWV.POD_Derived IN ( 'DC', 'EL' )
      AND SWV.Admission_Date
      BETWEEN @GE7114_StartDate AND @GE7114_EndDate;

-- Outpatient Attendances
SELECT @GE7114_Num_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Sigmoidoscopy = 'Diagnostic flexible sigmoidoscopy'
      AND OSV.Appointment_Date
      BETWEEN @GE7114_StartDate AND @GE7114_EndDate;

DECLARE @GE7114_Numerator INT = @GE7114_Num_IP + @GE7114_Num_OP;

-- Denominator: All flexible sigmoidoscopy procedures
DECLARE @GE7114_Denom_IP INT;
DECLARE @GE7114_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7114_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Sigmoidoscopy IN ( 'Diagnostic flexible sigmoidoscopy', 'Therapeutic flexible sigmoidoscopy' )
      AND SWV.Admission_Date
      BETWEEN @GE7114_StartDate AND @GE7114_EndDate;

-- Outpatient Attendances
SELECT @GE7114_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_Sigmoidoscopy IN ( 'Diagnostic flexible sigmoidoscopy', 'Therapeutic flexible sigmoidoscopy' )
      AND OSV.Appointment_Date
      BETWEEN @GE7114_StartDate AND @GE7114_EndDate;

DECLARE @GE7114_Denominator INT = @GE7114_Denom_IP + @GE7114_Denom_OP;

-- Calculate Percentage
DECLARE @GE7114_Percentage_Diagnostic FLOAT;
SET @GE7114_Percentage_Diagnostic = (CAST(@GE7114_Numerator AS FLOAT) / NULLIF(@GE7114_Denominator, 0)) * 100;

SELECT 'GE7114 - Percentage of Flexible Sigmoidoscopies Carried Out as a Diagnostic Procedure (12 months to quarter end)' AS Metric,
       ROUND(@GE7114_Percentage_Diagnostic, 2) AS Percentage,
       @GE7114_Numerator AS Numerator,
       @GE7114_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Endoscopy - ERCP
 ------------------------------------------------------------------- */

/* Number of ERCP procedures (all settings) (monthly) 

COUNT (Spell + Attendances)
Gastro_ERCP IN ('Diagnostic ERCP','Therapeutic ERCP')  

Metric ID: GE7115
Date: June 2024

*/

DECLARE @GE7115_StartDate DATE = '2024-06-01';
DECLARE @GE7115_EndDate DATE = '2024-06-30';

-- Inpatient Spells
DECLARE @GE7115_Num_IP INT;

SELECT @GE7115_Num_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND SWV.Admission_Date
      BETWEEN @GE7115_StartDate AND @GE7115_EndDate;

-- Outpatient Attendances
DECLARE @GE7115_Num_OP INT;

SELECT @GE7115_Num_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND OSV.Appointment_Date
      BETWEEN @GE7115_StartDate AND @GE7115_EndDate;

-- Total Procedures
DECLARE @GE7115_Total_Procedures INT = @GE7115_Num_IP + @GE7115_Num_OP;

SELECT 'GE7115 - Number of ERCP Procedures (All Settings) (Monthly)' AS Metric,
       @GE7115_Total_Procedures AS Value;

/* Daycase rate for ERCP procedures (12mths to qtr end) 

COUNT (Spells)
Gastro_ERCP IN ('Diagnostic ERCP','Therapeutic ERCP')  
AND (POD_Derived in ('DC'))

COUNT (Spell + Attendances)
Gastro_ERCP IN ('Diagnostic ERCP','Therapeutic ERCP')  

Metric ID: GE7116
Date: Q1 2024/25

*/

DECLARE @GE7116_StartDate DATE = '2023-07-01';
DECLARE @GE7116_EndDate DATE = '2024-06-30';

-- Numerator: Day Case ERCP Procedures
DECLARE @GE7116_Numerator INT;

SELECT @GE7116_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND SWV.POD_Derived = 'DC'
      AND SWV.Admission_Date
      BETWEEN @GE7116_StartDate AND @GE7116_EndDate;

-- Denominator: All ERCP Procedures
DECLARE @GE7116_Denom_IP INT;
DECLARE @GE7116_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7116_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND SWV.Admission_Date
      BETWEEN @GE7116_StartDate AND @GE7116_EndDate;

-- Outpatient Attendances
SELECT @GE7116_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND OSV.Appointment_Date
      BETWEEN @GE7116_StartDate AND @GE7116_EndDate;

DECLARE @GE7116_Denominator INT = @GE7116_Denom_IP + @GE7116_Denom_OP;

-- Calculate Day Case Rate
DECLARE @GE7116_DayCaseRate FLOAT;
SET @GE7116_DayCaseRate = (CAST(@GE7116_Numerator AS FLOAT) / NULLIF(@GE7116_Denominator, 0)) * 100;

SELECT 'GE7116 - Day Case Rate for ERCP Procedures (12 months to quarter end)' AS Metric,
       ROUND(@GE7116_DayCaseRate, 2) AS Percentage,
       @GE7116_Numerator AS Numerator,
       @GE7116_Denominator AS Denominator;

/* Percentage of ERCP procedures carried out on patients with cholelithiasis (12mths to qtr end) 

COUNT (Spells)
Gastro_ERCP IN ('Diagnostic ERCP','Therapeutic ERCP') 
AND Gastro_ERCPConditions = 'Cholelithiasis'

COUNT (Spell + Attendances)
Gastro_ERCP IN ('Diagnostic ERCP','Therapeutic ERCP')  

Metric ID: GE7117
Date: Q1 2024/25

*/

DECLARE @GE7117_StartDate DATE = '2023-07-01';
DECLARE @GE7117_EndDate DATE = '2024-06-30';

-- Numerator: ERCP Procedures for Cholelithiasis
DECLARE @GE7117_Numerator INT;

SELECT @GE7117_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND SWV.Gastro_ERCPConditions = 'Cholelithiasis'
      AND SWV.Admission_Date
      BETWEEN @GE7117_StartDate AND @GE7117_EndDate;

-- Denominator: All ERCP Procedures
DECLARE @GE7117_Denom_IP INT;
DECLARE @GE7117_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7117_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND SWV.Admission_Date
      BETWEEN @GE7117_StartDate AND @GE7117_EndDate;

-- Outpatient Attendances
SELECT @GE7117_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND OSV.Appointment_Date
      BETWEEN @GE7117_StartDate AND @GE7117_EndDate;

DECLARE @GE7117_Denominator INT = @GE7117_Denom_IP + @GE7117_Denom_OP;

-- Calculate Percentage
DECLARE @GE7117_Percentage_Cholelithiasis FLOAT;
SET @GE7117_Percentage_Cholelithiasis = (CAST(@GE7117_Numerator AS FLOAT) / NULLIF(@GE7117_Denominator, 0)) * 100;

SELECT 'GE7117 - Percentage of ERCP Procedures Carried Out on Patients with Cholelithiasis (12 months to quarter end)' AS Metric,
       ROUND(@GE7117_Percentage_Cholelithiasis, 2) AS Percentage,
       @GE7117_Numerator AS Numerator,
       @GE7117_Denominator AS Denominator;

/* Complication within 30 days after an ERCP procedure (12mths to qtr end) 

COUNT (Spells)
Gastro_ERCP IN ('Diagnostic ERCP','Therapeutic ERCP') 
AND ((Care_setting = 'OP' AND Gastro_FLAG_ERCPComplications = 1) 
OR (POD_Derived in ('DC','EL')) AND (Gastro_ERCPComplications <> 'Other' 
OR Gastro_FLAG_ERCPComplications = 1))

COUNT (Spell + Attendances)
Gastro_ERCP IN ('Diagnostic ERCP','Therapeutic ERCP')  

Metric ID: GE7118
Date: Q4 2023/24

*/

DECLARE @GE7118_StartDate DATE = '2023-04-01';
DECLARE @GE7118_EndDate DATE = '2024-03-31';

-- Numerator: ERCP Procedures with Complications Within 30 Days
DECLARE @GE7118_Numerator_IP INT;
DECLARE @GE7118_Numerator_OP INT;

-- Inpatient Spells
SELECT @GE7118_Numerator_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND SWV.POD_Derived IN ( 'DC', 'EL' )
      AND
      (
          SWV.Gastro_ERCPComplications <> 'Other'
          OR SWV.Gastro_FLAG_ERCPComplications = 1
      )
      AND SWV.Admission_Date
      BETWEEN @GE7118_StartDate AND @GE7118_EndDate;

-- Outpatient Attendances
SELECT @GE7118_Numerator_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND OSV.Gastro_FLAG_ERCPComplications = 1
      AND OSV.Appointment_Date
      BETWEEN @GE7118_StartDate AND @GE7118_EndDate;

DECLARE @GE7118_Numerator INT = @GE7118_Numerator_IP + @GE7118_Numerator_OP;

-- Denominator: All ERCP Procedures
DECLARE @GE7118_Denom_IP INT;
DECLARE @GE7118_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7118_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND SWV.Admission_Date
      BETWEEN @GE7118_StartDate AND @GE7118_EndDate;

-- Outpatient Attendances
SELECT @GE7118_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_ERCP IN ( 'Diagnostic ERCP', 'Therapeutic ERCP' )
      AND OSV.Appointment_Date
      BETWEEN @GE7118_StartDate AND @GE7118_EndDate;

DECLARE @GE7118_Denominator INT = @GE7118_Denom_IP + @GE7118_Denom_OP;

-- Calculate Complication Rate
DECLARE @GE7118_ComplicationRate FLOAT;
SET @GE7118_ComplicationRate = (CAST(@GE7118_Numerator AS FLOAT) / NULLIF(@GE7118_Denominator, 0)) * 100;

SELECT 'GE7118 - Complication Within 30 Days After an ERCP Procedure (12 months to quarter end)' AS Metric,
       ROUND(@GE7118_ComplicationRate, 2) AS Percentage,
       @GE7118_Numerator AS Numerator,
       @GE7118_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Upper Gastrointestinal Bleeds
 ------------------------------------------------------------------- */

/* Number of inpatient admissions for patients with duodenal or gastric ulcers (monthly)

COUNT (Spells)
(Gastro_DuodenalUlcer <> 'Other' OR Gastro_GastricUlcer <> 'Other') 
AND Care_setting = 'APC' 

Metric ID: GE7119
Date: June 2024

*/

DECLARE @GE7119_StartDate DATE = '2024-06-01';
DECLARE @GE7119_EndDate DATE = '2024-06-30';

DECLARE @GE7119_Num_Admissions INT;

SELECT @GE7119_Num_Admissions = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE (
          SWV.Gastro_DuodenalUlcer NOT LIKE '%Other%'
          OR SWV.Gastro_GastricUlcer NOT LIKE '%Other%'
      )
      AND SWV.Admission_Date
      BETWEEN @GE7119_StartDate AND @GE7119_EndDate;

SELECT 'GE7119 - Number of Inpatient Admissions for Patients with Duodenal or Gastric Ulcers (Monthly)' AS Metric,
       @GE7119_Num_Admissions AS Value;

/* Haemorrhage rate for admissions for gastric ulcers (12mths to qtr end) 

COUNT (Spells)
Gastro_GastricUlcer = 'With haemorrhage'  
AND Gastro_FLAG_GastricUlcer = 1

COUNT (Spells)(Gastro_GastricUlcer <> 'Other') 
AND Care_setting = 'APC'
AND Gastro_FLAG_GastricUlcer = 1

Metric ID: GE7120
Date: Q1 2024/25

*/

DECLARE @GE7120_StartDate DATE = '2023-07-01';
DECLARE @GE7120_EndDate DATE = '2024-06-30';

-- Numerator: Admissions with Gastric Ulcer and Haemorrhage
DECLARE @GE7120_Numerator INT;

SELECT @GE7120_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GastricUlcer = 'With haemorrhage'
      AND SWV.Gastro_FLAG_GastricUlcer = 1
      AND SWV.Admission_Date
      BETWEEN @GE7120_StartDate AND @GE7120_EndDate;

-- Denominator: All Admissions with Gastric Ulcer
DECLARE @GE7120_Denominator INT;

SELECT @GE7120_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE (SWV.Gastro_GastricUlcer <> 'Other'
		OR swv.Gastro_GastricUlcer IS NULL)
      AND SWV.Gastro_FLAG_GastricUlcer = 1
      AND SWV.Admission_Date
      BETWEEN @GE7120_StartDate AND @GE7120_EndDate;

-- Calculate Haemorrhage Rate
DECLARE @GE7120_HaemorrhageRate FLOAT;
SET @GE7120_HaemorrhageRate = (CAST(@GE7120_Numerator AS FLOAT) / NULLIF(@GE7120_Denominator, 0)) * 100;

SELECT 'GE7120 - Haemorrhage Rate for Admissions for Gastric Ulcers (12 months to quarter end)' AS Metric,
       ROUND(@GE7120_HaemorrhageRate, 2) AS Percentage,
       @GE7120_Numerator AS Numerator,
       @GE7120_Denominator AS Denominator;

/* Haemorrhage rate for admissions for duodenal ulcers (12mths to qtr end) 

COUNT (Spells)
Gastro_DuodenalUlcer = 'With haemorrhage'  
AND Gastro_FLAG_GastricUlcer = 0

COUNT (Spells)(Gastro_DuodenalUlcer <> 'Other') 
AND Care_setting = 'APC' 
AND Gastro_FLAG_GastricUlcer = 0

Metric ID: GE7121
Date: Q1 2024/25

*/

DECLARE @GE7121_StartDate DATE = '2023-07-01';
DECLARE @GE7121_EndDate DATE = '2024-06-30';

-- Numerator: Admissions with Duodenal Ulcer and Haemorrhage
DECLARE @GE7121_Numerator INT;

SELECT @GE7121_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_DuodenalUlcer = 'With haemorrhage'
      AND SWV.Gastro_FLAG_GastricUlcer = 0
      AND SWV.Admission_Date
      BETWEEN @GE7121_StartDate AND @GE7121_EndDate;

-- Denominator: All Admissions with Duodenal Ulcer
DECLARE @GE7121_Denominator INT;

SELECT @GE7121_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_DuodenalUlcer <> 'Other'
      AND SWV.Gastro_FLAG_GastricUlcer = 0
      AND SWV.Admission_Date
      BETWEEN @GE7121_StartDate AND @GE7121_EndDate;

-- Calculate Haemorrhage Rate
DECLARE @GE7121_HaemorrhageRate FLOAT;
SET @GE7121_HaemorrhageRate = (CAST(@GE7121_Numerator AS FLOAT) / NULLIF(@GE7121_Denominator, 0)) * 100;

SELECT 'GE7121 - Haemorrhage Rate for Admissions for Duodenal Ulcers (12 months to quarter end)' AS Metric,
       ROUND(@GE7121_HaemorrhageRate, 2) AS Percentage,
       @GE7121_Numerator AS Numerator,
       @GE7121_Denominator AS Denominator;

/* Helicobacter pylori infection rate for patients with duodenal ulcers (12mths to qtr end) 

COUNT (Spells)(Gastro_DuodenalUlcer <> 'Other') 
AND Care_setting = 'APC' 
AND Gastro_H_Pylori = 'Helicobacter pylori' 
AND Gastro_FLAG_GastricUlcer = 0

COUNT (Spells)(Gastro_DuodenalUlcer <> 'Other') 
AND Care_setting = 'APC' 
AND Gastro_FLAG_GastricUlcer = 0

Metric ID: GE7122
Date: Q1 2024/25

*/

DECLARE @GE7122_StartDate DATE = '2023-07-01';
DECLARE @GE7122_EndDate DATE = '2024-06-30';

-- Numerator: Patients with Duodenal Ulcer and H. Pylori Infection
DECLARE @GE7122_Numerator INT;

SELECT @GE7122_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_DuodenalUlcer NOT like '%Other%'
      AND SWV.Gastro_H_Pylori = 'Helicobacter pylori'
      AND SWV.Gastro_FLAG_GastricUlcer = 0
      AND SWV.Admission_Date
      BETWEEN @GE7122_StartDate AND @GE7122_EndDate;

-- Denominator: All Patients with Duodenal Ulcer
DECLARE @GE7122_Denominator INT;

SELECT @GE7122_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_DuodenalUlcer <> 'Other'
      AND SWV.Gastro_FLAG_GastricUlcer = 0
      AND SWV.Admission_Date
      BETWEEN @GE7122_StartDate AND @GE7122_EndDate;

-- Calculate Infection Rate
DECLARE @GE7122_InfectionRate FLOAT;
SET @GE7122_InfectionRate = (CAST(@GE7122_Numerator AS FLOAT) / NULLIF(@GE7122_Denominator, 0)) * 100;

SELECT 'GE7122 - Helicobacter Pylori Infection Rate for Patients with Duodenal Ulcers (12 months to quarter end)' AS Metric,
       ROUND(@GE7122_InfectionRate, 2) AS Percentage,
       @GE7122_Numerator AS Numerator,
       @GE7122_Denominator AS Denominator;

/* Number of emergency admissions for patients with upper gastrointestinal bleeding (monthly) 

COUNT (Spells)
Gastro_GIBleeding = 'GI bleeding excluding ulcers' 
AND POD_Derived = 'EM'

Metric ID: GE7123
Date: June 2024

*/

DECLARE @GE7123_StartDate DATE = '2024-06-01';
DECLARE @GE7123_EndDate DATE = '2024-06-30';

DECLARE @GE7123_Num_Admissions INT;

SELECT @GE7123_Num_Admissions = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GIBleeding = 'GI bleeding excluding ulcers'
      AND SWV.POD_Derived = 'EM'
      AND SWV.Admission_Date
      BETWEEN @GE7123_StartDate AND @GE7123_EndDate;

SELECT 'GE7123 - Number of Emergency Admissions for Patients with Upper Gastrointestinal Bleeding (Monthly)' AS Metric,
       @GE7123_Num_Admissions AS Value;

/* Emergency admission rate for patients with oesophageal varices (12mths to qtr end) 

COUNT (Spells)
Gastro_UpperGIVarices IN ('Oesophageal varices - bleeding','Oesophageal varices - not bleeding')  
AND POD_Derived = 'EM'

COUNT (Spells)
Gastro_UpperGIVarices IN ('Oesophageal varices - bleeding','Oesophageal varices - not bleeding')

Metric ID: GE7124
Date: Q1 2024/25

*/

DECLARE @GE7124_StartDate DATE = '2023-07-01';
DECLARE @GE7124_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Admissions with Oesophageal Varices
DECLARE @GE7124_Numerator INT;

SELECT @GE7124_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_UpperGIVarices IN ( 'Oesophageal varices - bleeding', 'Oesophageal varices - not bleeding' )
      AND SWV.POD_Derived = 'EM'
      AND SWV.Admission_Date
      BETWEEN @GE7124_StartDate AND @GE7124_EndDate;

-- Denominator: All Admissions with Oesophageal Varices
DECLARE @GE7124_Denominator INT;

SELECT @GE7124_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_UpperGIVarices IN ( 'Oesophageal varices - bleeding', 'Oesophageal varices - not bleeding' )
      AND SWV.Admission_Date
      BETWEEN @GE7124_StartDate AND @GE7124_EndDate;

-- Calculate Emergency Admission Rate
DECLARE @GE7124_EmergencyRate FLOAT;
SET @GE7124_EmergencyRate = (CAST(@GE7124_Numerator AS FLOAT) / NULLIF(@GE7124_Denominator, 0)) * 100;

SELECT 'GE7124 - Emergency Admission Rate for Patients with Oesophageal Varices (12 months to quarter end)' AS Metric,
       ROUND(@GE7124_EmergencyRate, 2) AS Percentage,
       @GE7124_Numerator AS Numerator,
       @GE7124_Denominator AS Denominator;

/* Mean emergency length of stay for patients with oesophageal varices (12mths to qtr end) 

Sum (Spell_LOS)
Gastro_UpperGIVarices IN ('Oesophageal varices - bleeding','Oesophageal varices - not bleeding') 
AND POD_Derived = 'EM'

COUNT (Spells)
Gastro_UpperGIVarices IN ('Oesophageal varices - bleeding','Oesophageal varices - not bleeding') 
AND POD_Derived = 'EM'

Metric ID: GE7125
Date: Q1 2024/25

*/

-- Declare variables
DECLARE @GE7125_StartDate DATE = '2023-07-01';
DECLARE @GE7125_EndDate DATE = '2024-06-30';
DECLARE @GE7125_Total_LOS INT;
DECLARE @GE7125_Num_Admissions INT;
DECLARE @GE7125_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gastro_UpperGIVarices IN ( 'Oesophageal varices - bleeding', 'Oesophageal varices - not bleeding' )
          AND SWV.POD_Derived = 'EM'
          AND SWV.Admission_Date
          BETWEEN @GE7125_StartDate AND @GE7125_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7125_Total_LOS = SUM(DS.Spell_LOS),
       @GE7125_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7125_Mean_LOS = @GE7125_Total_LOS / NULLIF(@GE7125_Num_Admissions, 0);

-- Output the results
SELECT 'GE7125 - Mean Emergency Length of Stay for Patients with Oesophageal Varices (12 months to quarter end)' AS Metric,
       ROUND(@GE7125_Mean_LOS, 2) AS Mean_LOS,
       @GE7125_Total_LOS AS Total_LOS,
       @GE7125_Num_Admissions AS Number_of_Admissions;

/* Day case rate for banding of oesophageal varices (12mths to qtr end) 

COUNT (Spells)
Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices' 
AND POD_Derived IN ('DC')

COUNT (Spell + Attendances)
Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'

Metric ID: GE7126
Date: Q1 2024/25

*/

DECLARE @GE7126_StartDate DATE = '2023-07-01';
DECLARE @GE7126_EndDate DATE = '2024-06-30';

-- Numerator: Day Case Banding Procedures
DECLARE @GE7126_Numerator INT;

SELECT @GE7126_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'
      AND SWV.POD_Derived = 'DC'
      AND SWV.Admission_Date
      BETWEEN @GE7126_StartDate AND @GE7126_EndDate;

-- Denominator: All Banding Procedures
DECLARE @GE7126_Denom_IP INT;
DECLARE @GE7126_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7126_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'
      AND SWV.Admission_Date
      BETWEEN @GE7126_StartDate AND @GE7126_EndDate;

-- Outpatient Attendances
SELECT @GE7126_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'
      AND OSV.Appointment_Date
      BETWEEN @GE7126_StartDate AND @GE7126_EndDate;

DECLARE @GE7126_Denominator INT = @GE7126_Denom_IP + @GE7126_Denom_OP;

-- Calculate Day Case Rate
DECLARE @GE7126_DayCaseRate FLOAT;
SET @GE7126_DayCaseRate = (CAST(@GE7126_Numerator AS FLOAT) / NULLIF(@GE7126_Denominator, 0)) * 100;

SELECT 'GE7126 - Day Case Rate for Banding of Oesophageal Varices (12 months to quarter end)' AS Metric,
       ROUND(@GE7126_DayCaseRate, 2) AS Percentage,
       @GE7126_Numerator AS Numerator,
       @GE7126_Denominator AS Denominator;

/* Emergency admission rate for endoscopic band ligation procedure for oesophageal varices (12mths to qtr end) 

COUNT (Spells)
Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices' 
AND POD_Derived = 'EM'

COUNT (Spells)
Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'

Metric ID: GE7127
Date: Q1 2024/25

*/

DECLARE @GE7127_StartDate DATE = '2023-07-01';
DECLARE @GE7127_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Admissions for Banding Procedure
DECLARE @GE7127_Numerator INT;

SELECT @GE7127_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'
      AND SWV.POD_Derived = 'EM'
      AND SWV.Admission_Date
      BETWEEN @GE7127_StartDate AND @GE7127_EndDate;

-- Denominator: All Banding Procedures (Inpatient Only)
DECLARE @GE7127_Denominator INT;

SELECT @GE7127_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'
      AND SWV.Admission_Date
      BETWEEN @GE7127_StartDate AND @GE7127_EndDate;

-- Calculate Emergency Admission Rate
DECLARE @GE7127_EmergencyRate FLOAT;
SET @GE7127_EmergencyRate = (CAST(@GE7127_Numerator AS FLOAT) / NULLIF(@GE7127_Denominator, 0)) * 100;

SELECT 'GE7127 - Emergency Admission Rate for Endoscopic Band Ligation Procedure (12 months to quarter end)' AS Metric,
       ROUND(@GE7127_EmergencyRate, 2) AS Percentage,
       @GE7127_Numerator AS Numerator,
       @GE7127_Denominator AS Denominator;

/* Mean emergency length of stay for endoscopic band ligation procedure for oesophageal varices (12mths to qtr end) 

Sum (Spell_LOS)
Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices' 
AND POD_Derived = 'EM'

COUNT (Spells)
Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices' 
AND POD_Derived = 'EM'

Metric ID: GE7128
Date: Q1 2024/25

*/

-- Declare variables
DECLARE @GE7128_StartDate DATE = '2023-07-01';
DECLARE @GE7128_EndDate DATE = '2024-06-30';
DECLARE @GE7128_Total_LOS INT;
DECLARE @GE7128_Num_Admissions INT;
DECLARE @GE7128_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gastro_GIVaricesBanding = 'Endoscopic band ligation of oesophageal varices'
          AND SWV.POD_Derived = 'EM'
          AND SWV.Admission_Date
          BETWEEN @GE7128_StartDate AND @GE7128_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7128_Total_LOS = SUM(DS.Spell_LOS),
       @GE7128_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7128_Mean_LOS = @GE7128_Total_LOS / NULLIF(@GE7128_Num_Admissions, 0);

-- Output the results
SELECT 'GE7128 - Mean Emergency Length of Stay for Endoscopic Band Ligation Procedure (12 months to quarter end)' AS Metric,
       ROUND(@GE7128_Mean_LOS, 2) AS Mean_LOS,
       @GE7128_Total_LOS AS Total_LOS,
       @GE7128_Num_Admissions AS Number_of_Admissions;

/* -------------------------------------------------------------------
	Liver Disease
 ------------------------------------------------------------------- */

/* Number of inpatient admissions for patients with liver disease (monthly) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' OR Gastro_LiverDisease = 'OtherLiverDisease') 
AND Care_setting = 'APC'

Metric ID: GE7129
Date: June 2024

*/

DECLARE @GE7129_StartDate DATE = '2024-06-01';
DECLARE @GE7129_EndDate DATE = '2024-06-30';

DECLARE @GE7129_Num_Admissions INT;

SELECT @GE7129_Num_Admissions = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE (
          SWV.Gastro_LiverDisease NOT LIKE '%Other%'
          OR SWV.Gastro_LiverDisease = 'OtherLiverDisease'
      )
      AND SWV.Admission_Date
      BETWEEN @GE7129_StartDate AND @GE7129_EndDate;

SELECT 'GE7129 - Number of Inpatient Admissions for Patients with Liver Disease (Monthly)' AS Metric,
       @GE7129_Num_Admissions AS Value;

/* Emergency admission rate for patients with liver disease (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND POD_Derived = 'EM'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC')

Metric ID: GE7130
Date: Q1 2024/25

*/

DECLARE @GE7130_StartDate DATE = '2023-07-01';
DECLARE @GE7130_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Admissions with Liver Disease
DECLARE @GE7130_Numerator INT;

SELECT @GE7130_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.POD_Derived = 'EM'
      AND SWV.Admission_Date
      BETWEEN @GE7130_StartDate AND @GE7130_EndDate;

-- Denominator: All Admissions with Liver Disease
DECLARE @GE7130_Denominator INT;

SELECT @GE7130_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Admission_Date
      BETWEEN @GE7130_StartDate AND @GE7130_EndDate;

-- Calculate Emergency Admission Rate
DECLARE @GE7130_EmergencyRate FLOAT;
SET @GE7130_EmergencyRate = (CAST(@GE7130_Numerator AS FLOAT) / NULLIF(@GE7130_Denominator, 0)) * 100;

SELECT 'GE7130 - Emergency Admission Rate for Patients with Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7130_EmergencyRate, 2) AS Percentage,
       @GE7130_Numerator AS Numerator,
       @GE7130_Denominator AS Denominator;

/* Mean emergency length of stay for patients with liver disease (12mths to qtr end) 

Sum (Spell_LOS)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND POD_Derived = 'EM'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND POD_Derived = 'EM'

Metric ID: GE7131
Date: Q1 2024/25

*/

-- Declare variables
DECLARE @GE7131_StartDate DATE = '2023-07-01';
DECLARE @GE7131_EndDate DATE = '2024-06-30';
DECLARE @GE7131_Total_LOS INT;
DECLARE @GE7131_Num_Admissions INT;
DECLARE @GE7131_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
          AND SWV.POD_Derived = 'EM'
          AND SWV.Age > 17
          AND SWV.Admission_Date
          BETWEEN @GE7131_StartDate AND @GE7131_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7131_Total_LOS = SUM(DS.Spell_LOS),
       @GE7131_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7131_Mean_LOS = @GE7131_Total_LOS / NULLIF(@GE7131_Num_Admissions, 0);

-- Output the results
SELECT 'GE7131 - Mean Emergency Length of Stay for Patients with Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7131_Mean_LOS, 2) AS Mean_LOS,
       @GE7131_Total_LOS AS Total_LOS,
       @GE7131_Num_Admissions AS Number_of_Admissions;

/* Alcohol use rate for patients with liver disease (12mths to qtr end)

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_AlcoholUse <> 'Other'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC')

Metric ID: GE7132
Date: Q1 2024/25

*/

DECLARE @GE7132_StartDate DATE = '2023-07-01';
DECLARE @GE7132_EndDate DATE = '2024-06-30';

-- Numerator: Patients with Liver Disease and Alcohol Use
DECLARE @GE7132_Numerator INT;

SELECT @GE7132_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_AlcoholUse NOT LIKE '%Other%'
	  AND SWV.Age > 17
      AND SWV.Admission_Date
      BETWEEN @GE7132_StartDate AND @GE7132_EndDate;

-- Denominator: All Patients with Liver Disease
DECLARE @GE7132_Denominator INT;

SELECT @GE7132_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
	  AND SWV.Age > 17
      AND SWV.Admission_Date
      BETWEEN @GE7132_StartDate AND @GE7132_EndDate;

-- Calculate Alcohol Use Rate
DECLARE @GE7132_AlcoholUseRate FLOAT;
SET @GE7132_AlcoholUseRate = (CAST(@GE7132_Numerator AS FLOAT) / NULLIF(@GE7132_Denominator, 0)) * 100;

SELECT 'GE7132 - Alcohol Use Rate for Patients with Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7132_AlcoholUseRate, 2) AS Percentage,
       @GE7132_Numerator AS Numerator,
       @GE7132_Denominator AS Denominator;

/* Emergency readmission rate (within 30 days) following an admission for liver disease where readmission length of stay equals 0 days (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Mort30 = 0 
AND Read30 = 'Y' 
AND Read30_0LOS = 1

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Mort30 = 0 

Metric ID: GE7133
Date: Q4 2023/24

*/

DECLARE @GE7133_StartDate DATE = '2023-04-01';
DECLARE @GE7133_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS = 0
DECLARE @GE7133_Numerator INT;

SELECT @GE7133_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Read30_0LOS = 1
      AND SWV.Admission_Date
      BETWEEN @GE7133_StartDate AND @GE7133_EndDate;

-- Denominator: Admissions for Liver Disease where patient did not die within 30 days
DECLARE @GE7133_Denominator INT;

SELECT @GE7133_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7133_StartDate AND @GE7133_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7133_ReadmissionRate FLOAT;
SET @GE7133_ReadmissionRate = (CAST(@GE7133_Numerator AS FLOAT) / NULLIF(@GE7133_Denominator, 0)) * 100;

SELECT 'GE7133 - Emergency Readmission Rate (Within 30 Days) with Readmission LOS = 0 Days (12 months to quarter end)' AS Metric,
       ROUND(@GE7133_ReadmissionRate, 2) AS Percentage,
       @GE7133_Numerator AS Numerator,
       @GE7133_Denominator AS Denominator;

/* Emergency readmission rate (within 30 days) following an admission for liver disease where readmission length of stay is 1 day or more (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Mort30 = 0 
AND Read30 = 'Y' 
AND Read30_1andOverLOS = 1

Metric ID: GE7134
Date: Q4 2023/24

*/

DECLARE @GE7134_StartDate DATE = '2023-04-01';
DECLARE @GE7134_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS >= 1
DECLARE @GE7134_Numerator INT;

SELECT @GE7134_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Spell_LOS >= 1
      AND SWV.Admission_Date
      BETWEEN @GE7134_StartDate AND @GE7134_EndDate;

-- Denominator: Admissions for Liver Disease where patient did not die within 30 days
DECLARE @GE7134_Denominator INT;

SELECT @GE7134_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7134_StartDate AND @GE7134_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7134_ReadmissionRate FLOAT;
SET @GE7134_ReadmissionRate = (CAST(@GE7134_Numerator AS FLOAT) / NULLIF(@GE7134_Denominator, 0)) * 100;

SELECT 'GE7134 - Emergency Readmission Rate (Within 30 Days) with Readmission LOS >= 1 Day (12 months to quarter end)' AS Metric,
       ROUND(@GE7134_ReadmissionRate, 2) AS Percentage,
       @GE7134_Numerator AS Numerator,
       @GE7134_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Complications of Liver Disease
 ------------------------------------------------------------------- */

/* Gastrointestinal bleed rate for patients with liver disease (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_GIBleeding = 'GI bleeding excluding ulcers'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC')

Metric ID: GE7135
Date: Q1 2024/25

*/

DECLARE @GE7135_StartDate DATE = '2023-07-01';
DECLARE @GE7135_EndDate DATE = '2024-06-30';

-- Numerator: Patients with Liver Disease and GI Bleeding
DECLARE @GE7135_Numerator INT;

SELECT @GE7135_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_GIBleeding = 'GI bleeding excluding ulcers'
      AND SWV.Admission_Date
      BETWEEN @GE7135_StartDate AND @GE7135_EndDate;

-- Denominator: All Patients with Liver Disease
DECLARE @GE7135_Denominator INT;

SELECT @GE7135_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Admission_Date
      BETWEEN @GE7135_StartDate AND @GE7135_EndDate;

-- Calculate GI Bleed Rate
DECLARE @GE7135_GIBleedRate FLOAT;
SET @GE7135_GIBleedRate = (CAST(@GE7135_Numerator AS FLOAT) / NULLIF(@GE7135_Denominator, 0)) * 100;

SELECT 'GE7135 - Gastrointestinal Bleed Rate for Patients with Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7135_GIBleedRate, 2) AS Percentage,
       @GE7135_Numerator AS Numerator,
       @GE7135_Denominator AS Denominator;

/* Hepatic encephalopathy rate for patients with liver disease (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_Encephalopathy = 'Encephalopathy'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC')

Metric ID: GE7136
Date: Q1 2024/25

*/

DECLARE @GE7136_StartDate DATE = '2023-07-01';
DECLARE @GE7136_EndDate DATE = '2024-06-30';

-- Numerator: Patients with Liver Disease and Encephalopathy
DECLARE @GE7136_Numerator INT;

SELECT @GE7136_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_Encephalopathy = 'Encephalopathy'
      AND SWV.Admission_Date
      BETWEEN @GE7136_StartDate AND @GE7136_EndDate;

-- Denominator: All Patients with Liver Disease
DECLARE @GE7136_Denominator INT;

SELECT @GE7136_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Admission_Date
      BETWEEN @GE7136_StartDate AND @GE7136_EndDate;

-- Calculate Encephalopathy Rate
DECLARE @GE7136_EncephalopathyRate FLOAT;
SET @GE7136_EncephalopathyRate = (CAST(@GE7136_Numerator AS FLOAT) / NULLIF(@GE7136_Denominator, 0)) * 100;

SELECT 'GE7136 - Hepatic Encephalopathy Rate for Patients with Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7136_EncephalopathyRate, 2) AS Percentage,
       @GE7136_Numerator AS Numerator,
       @GE7136_Denominator AS Denominator;

/* Peritonitis rate for patients with liver disease (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_Peritonitis = 'Spontaneous bacterial peritonitis'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC')

Metric ID: GE7137
Date: Q1 2024/25

*/

DECLARE @GE7137_StartDate DATE = '2023-07-01';
DECLARE @GE7137_EndDate DATE = '2024-06-30';

-- Numerator: Patients with Liver Disease and Peritonitis
DECLARE @GE7137_Numerator INT;

SELECT @GE7137_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_Peritonitis = 'Spontaneous bacterial peritonitis'
      AND SWV.Admission_Date
      BETWEEN @GE7137_StartDate AND @GE7137_EndDate;

-- Denominator: All Patients with Liver Disease
DECLARE @GE7137_Denominator INT;

SELECT @GE7137_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Admission_Date
      BETWEEN @GE7137_StartDate AND @GE7137_EndDate;

-- Calculate Peritonitis Rate
DECLARE @GE7137_PeritonitisRate FLOAT;
SET @GE7137_PeritonitisRate = (CAST(@GE7137_Numerator AS FLOAT) / NULLIF(@GE7137_Denominator, 0)) * 100;

SELECT 'GE7137 - Peritonitis Rate for Patients with Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7137_PeritonitisRate, 2) AS Percentage,
       @GE7137_Numerator AS Numerator,
       @GE7137_Denominator AS Denominator;

/* Ascites rate for patients with liver disease (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_Ascites = 'Ascites'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC')

Metric ID: GE7138
Date: Q1 2024/25

*/

DECLARE @GE7138_StartDate DATE = '2023-07-01';
DECLARE @GE7138_EndDate DATE = '2024-06-30';

-- Numerator: Patients with Liver Disease and Ascites
DECLARE @GE7138_Numerator INT;

SELECT @GE7138_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_Ascites = 'Ascites'
      AND SWV.Admission_Date
      BETWEEN @GE7138_StartDate AND @GE7138_EndDate;

-- Denominator: All Patients with Liver Disease
DECLARE @GE7138_Denominator INT;

SELECT @GE7138_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Admission_Date
      BETWEEN @GE7138_StartDate AND @GE7138_EndDate;

-- Calculate Ascites Rate
DECLARE @GE7138_AscitesRate FLOAT;
SET @GE7138_AscitesRate = (CAST(@GE7138_Numerator AS FLOAT) / NULLIF(@GE7138_Denominator, 0)) * 100;

SELECT 'GE7138 - Ascites Rate for Patients with Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7138_AscitesRate, 2) AS Percentage,
       @GE7138_Numerator AS Numerator,
       @GE7138_Denominator AS Denominator;

/* Ascitic drain for patients with liver disease (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_AscitesTapDrain = 'Ascitic tap or drain'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC')

Metric ID: GE7139
Date: Q1 2024/25

*/

DECLARE @GE7139_StartDate DATE = '2023-07-01';
DECLARE @GE7139_EndDate DATE = '2024-06-30';

-- Numerator: Patients with Liver Disease and Ascitic Drain
DECLARE @GE7139_Numerator INT;

SELECT @GE7139_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_AscitesTapDrain = 'Ascitic tap or drain'
      AND SWV.Admission_Date
      BETWEEN @GE7139_StartDate AND @GE7139_EndDate;

-- Denominator: All Patients with Liver Disease
DECLARE @GE7139_Denominator INT;

SELECT @GE7139_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Admission_Date
      BETWEEN @GE7139_StartDate AND @GE7139_EndDate;

-- Calculate Ascitic Drain Rate
DECLARE @GE7139_AsciticDrainRate FLOAT;
SET @GE7139_AsciticDrainRate = (CAST(@GE7139_Numerator AS FLOAT) / NULLIF(@GE7139_Denominator, 0)) * 100;

SELECT 'GE7139 - Ascitic Drain Rate for Patients with Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7139_AsciticDrainRate, 2) AS Percentage,
       @GE7139_Numerator AS Numerator,
       @GE7139_Denominator AS Denominator;

/* Daycase rate for ascitic drains (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other') 
AND Gastro_AscitesTapDrain = 'Ascitic tap or drain' 
AND POD_Derived IN ('DC')

COUNT (Spell + Attendances)
(Gastro_LiverDisease <> 'Other') 
AND Gastro_AscitesTapDrain = 'Ascitic tap or drain' 

Metric ID: GE7140
Date: Q1 2024/25

*/

DECLARE @GE7140_StartDate DATE = '2023-07-01';
DECLARE @GE7140_EndDate DATE = '2024-06-30';

-- Numerator: Day Case Ascitic Drains
DECLARE @GE7140_Numerator INT;

SELECT @GE7140_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_AscitesTapDrain = 'Ascitic tap or drain'
      AND SWV.POD_Derived = 'DC'
      AND SWV.Admission_Date
      BETWEEN @GE7140_StartDate AND @GE7140_EndDate;

-- Denominator: All Ascitic Drains (Inpatient and Outpatient)
DECLARE @GE7140_Denom_IP INT;
DECLARE @GE7140_Denom_OP INT;

-- Inpatient Spells
SELECT @GE7140_Denom_IP = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_AscitesTapDrain = 'Ascitic tap or drain'
      AND SWV.Admission_Date
      BETWEEN @GE7140_StartDate AND @GE7140_EndDate;

-- Outpatient Attendances
SELECT @GE7140_Denom_OP = COUNT(DISTINCT OSV.OP_Attendance_ID)
FROM #OP_Spells_With_Variables OSV
WHERE OSV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND OSV.Gastro_AscitesTapDrain = 'Ascitic tap or drain'
      AND OSV.Appointment_Date
      BETWEEN @GE7140_StartDate AND @GE7140_EndDate;

DECLARE @GE7140_Denominator INT = @GE7140_Denom_IP + @GE7140_Denom_OP;

-- Calculate Day Case Rate
DECLARE @GE7140_DayCaseRate FLOAT;
SET @GE7140_DayCaseRate = (CAST(@GE7140_Numerator AS FLOAT) / NULLIF(@GE7140_Denominator, 0)) * 100;

SELECT 'GE7140 - Day Case Rate for Ascitic Drains (12 months to quarter end)' AS Metric,
       ROUND(@GE7140_DayCaseRate, 2) AS Percentage,
       @GE7140_Numerator AS Numerator,
       @GE7140_Denominator AS Denominator;

/* Emergency admission rate for patients with liver disease undergoing an ascitic 
drain procedure (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_AscitesTapDrain = 'Ascitic tap or drain' 
AND POD_Derived = 'EM'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_AscitesTapDrain = 'Ascitic tap or drain'

Metric ID: GE7141
Date: Q1 2024/25

*/

DECLARE @GE7141_StartDate DATE = '2023-07-01';
DECLARE @GE7141_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Admissions for Ascitic Drain
DECLARE @GE7141_Numerator INT;

SELECT @GE7141_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_AscitesTapDrain = 'Ascitic tap or drain'
      AND SWV.POD_Derived = 'EM'
      AND SWV.Admission_Date
      BETWEEN @GE7141_StartDate AND @GE7141_EndDate;

-- Denominator: All Inpatient Ascitic Drains
DECLARE @GE7141_Denominator INT;

SELECT @GE7141_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
      AND SWV.Gastro_AscitesTapDrain = 'Ascitic tap or drain'
      AND SWV.Admission_Date
      BETWEEN @GE7141_StartDate AND @GE7141_EndDate;

-- Calculate Emergency Admission Rate
DECLARE @GE7141_EmergencyRate FLOAT;
SET @GE7141_EmergencyRate = (CAST(@GE7141_Numerator AS FLOAT) / NULLIF(@GE7141_Denominator, 0)) * 100;

SELECT 'GE7141 - Emergency Admission Rate for Ascitic Drain Procedures (12 months to quarter end)' AS Metric,
       ROUND(@GE7141_EmergencyRate, 2) AS Percentage,
       @GE7141_Numerator AS Numerator,
       @GE7141_Denominator AS Denominator;

/* Mean inpatient length of stay for patients with liver disease with a gastrointestinal bleed 
(12mths to qtr end) 

Sum (Spell_LOS)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_GIBleeding = 'GI bleeding excluding ulcers'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_GIBleeding = 'GI bleeding excluding ulcers'

Metric ID: GE7142
Date: Q1 2024/25

*/

-- Declare variables
DECLARE @GE7142_StartDate DATE = '2023-07-01';
DECLARE @GE7142_EndDate DATE = '2024-06-30';
DECLARE @GE7142_Total_LOS INT;
DECLARE @GE7142_Num_Admissions INT;
DECLARE @GE7142_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
          AND SWV.Gastro_GIBleeding = 'GI bleeding excluding ulcers'
          AND SWV.Admission_Date
          BETWEEN @GE7142_StartDate AND @GE7142_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7142_Total_LOS = SUM(DS.Spell_LOS),
       @GE7142_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7142_Mean_LOS = @GE7142_Total_LOS / NULLIF(@GE7142_Num_Admissions, 0);

-- Output the results
SELECT 'GE7142 - Mean Inpatient LOS for Patients with Liver Disease and GI Bleed (12 months to quarter end)' AS Metric,
       ROUND(@GE7142_Mean_LOS, 2) AS Mean_LOS,
       @GE7142_Total_LOS AS Total_LOS,
       @GE7142_Num_Admissions AS Number_of_Admissions;

/* Mean inpatient length of stay for patients with liver disease with hepatic encephalopathy 
(12mths to qtr end)

Sum (Spell_LOS)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_Encephalopathy = 'Encephalopathy'

COUNT (Spells)
(Gastro_LiverDisease <> 'Other' AND Care_setting = 'APC') 
AND Gastro_Encephalopathy = 'Encephalopathy'

Metric ID: GE7143
Date: Q1 2024/25

*/


-- Declare variables
DECLARE @GE7143_StartDate DATE = '2023-07-01';
DECLARE @GE7143_EndDate DATE = '2024-06-30';
DECLARE @GE7143_Total_LOS INT;
DECLARE @GE7143_Num_Admissions INT;
DECLARE @GE7143_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gastro_LiverDisease NOT LIKE '%Other%'
          AND SWV.Gastro_Encephalopathy = 'Encephalopathy'
          AND SWV.Admission_Date
          BETWEEN @GE7143_StartDate AND @GE7143_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7143_Total_LOS = SUM(DS.Spell_LOS),
       @GE7143_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7143_Mean_LOS = @GE7143_Total_LOS / NULLIF(@GE7143_Num_Admissions, 0);

-- Output the results
SELECT 'GE7143 - Mean Inpatient LOS for Patients with Liver Disease and Encephalopathy (12 months to quarter end)' AS Metric,
       ROUND(@GE7143_Mean_LOS, 2) AS Mean_LOS,
       @GE7143_Total_LOS AS Total_LOS,
       @GE7143_Num_Admissions AS Number_of_Admissions;

/* -------------------------------------------------------------------
	Alcoholic Liver Disease
 ------------------------------------------------------------------- */

/* Number of inpatient admissions for patients with alcoholic liver disease (monthly) 

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 

Metric ID: GE7145
Date: June 2024

*/

DECLARE @GE7145_StartDate DATE = '2024-06-01';
DECLARE @GE7145_EndDate DATE = '2024-06-30';

DECLARE @GE7145_Num_Admissions INT;

SELECT @GE7145_Num_Admissions = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
      AND SWV.Admission_Date
      BETWEEN @GE7145_StartDate AND @GE7145_EndDate;

SELECT 'GE7145 - Number of Inpatient Admissions for Patients with Alcoholic Liver Disease (Monthly)' AS Metric,
       @GE7145_Num_Admissions AS Value;

/* Emergency admission rate for patients with alcoholic liver disease inpatient admission 
(12mths to qtr end) 

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 
AND POD_Derived = 'EM'

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 

Metric ID: GE7146
Date: Q1 2024/25

*/

DECLARE @GE7146_StartDate DATE = '2023-07-01';
DECLARE @GE7146_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Admissions with Alcoholic Liver Disease
DECLARE @GE7146_Numerator INT;

SELECT @GE7146_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
      AND SWV.POD_Derived = 'EM'
      AND SWV.Admission_Date
      BETWEEN @GE7146_StartDate AND @GE7146_EndDate;

-- Denominator: All Admissions with Alcoholic Liver Disease
DECLARE @GE7146_Denominator INT;

SELECT @GE7146_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
      AND SWV.Admission_Date
      BETWEEN @GE7146_StartDate AND @GE7146_EndDate;

-- Calculate Emergency Admission Rate
DECLARE @GE7146_EmergencyRate FLOAT;
SET @GE7146_EmergencyRate = (CAST(@GE7146_Numerator AS FLOAT) / NULLIF(@GE7146_Denominator, 0)) * 100;

SELECT 'GE7146 - Emergency Admission Rate for Patients with Alcoholic Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7146_EmergencyRate, 2) AS Percentage,
       @GE7146_Numerator AS Numerator,
       @GE7146_Denominator AS Denominator;

/* Mean emergency length of stay for patients with alcoholic liver disease (12mths to qtr end) 

Sum (Spell_LOS)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis')  
AND POD_Derived IN ('EM')

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 
AND POD_Derived IN ('EM')

Metric ID: GE7147
Date: Q1 2024/25

*/

-- Declare variables
DECLARE @GE7147_StartDate DATE = '2023-07-01';
DECLARE @GE7147_EndDate DATE = '2024-06-30';
DECLARE @GE7147_Total_LOS INT;
DECLARE @GE7147_Num_Admissions INT;
DECLARE @GE7147_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
          AND SWV.POD_Derived = 'EM'
          AND SWV.Admission_Date
          BETWEEN @GE7147_StartDate AND @GE7147_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7147_Total_LOS = SUM(DS.Spell_LOS),
       @GE7147_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7147_Mean_LOS = @GE7147_Total_LOS / NULLIF(@GE7147_Num_Admissions, 0);

-- Output the results
SELECT 'GE7147 - Mean Emergency Length of Stay for Patients with Alcoholic Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7147_Mean_LOS, 2) AS Mean_LOS,
       @GE7147_Total_LOS AS Total_LOS,
       @GE7147_Num_Admissions AS Number_of_Admissions;

/* Emergency readmission rate within 30 days following an admission for alcoholic liver disease 
(12mths to qtr end) 

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 
AND Mort30 = 0 
AND Read30 = 'Y'

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 
AND Mort30 = 0

Metric ID: GE7148
Date: Q1 2024/25

*/

DECLARE @GE7148_StartDate DATE = '2023-07-01';
DECLARE @GE7148_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days
DECLARE @GE7148_Numerator INT;

SELECT @GE7148_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Admission_Date
      BETWEEN @GE7148_StartDate AND @GE7148_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7148_Denominator INT;

SELECT @GE7148_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7148_StartDate AND @GE7148_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7148_ReadmissionRate FLOAT;
SET @GE7148_ReadmissionRate = (CAST(@GE7148_Numerator AS FLOAT) / NULLIF(@GE7148_Denominator, 0)) * 100;

SELECT 'GE7148 - Emergency Readmission Rate Within 30 Days for Alcoholic Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7148_ReadmissionRate, 2) AS Percentage,
       @GE7148_Numerator AS Numerator,
       @GE7148_Denominator AS Denominator;

/* Emergency readmission rate (within 30 days) following an admission for alcoholic liver disease where readmission length of stay equals 0 days 
(12mths to qtr end) 

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 
AND Mort30 = 0 
AND Read30 = 'Y' 
AND Read30_0LOS = 1

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 
AND Mort30 = 0

Metric ID: GE7149
Date: Q4 2023/24

*/

DECLARE @GE7149_StartDate DATE = '2023-04-01';
DECLARE @GE7149_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS = 0
DECLARE @GE7149_Numerator INT;

SELECT @GE7149_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Read30_0LOS = 1
      AND SWV.Admission_Date
      BETWEEN @GE7149_StartDate AND @GE7149_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7149_Denominator INT;

SELECT @GE7149_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7149_StartDate AND @GE7149_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7149_ReadmissionRate FLOAT;
SET @GE7149_ReadmissionRate = (CAST(@GE7149_Numerator AS FLOAT) / NULLIF(@GE7149_Denominator, 0)) * 100;

SELECT 'GE7149 - Emergency Readmission Rate Within 30 Days with Readmission LOS = 0 Days for Alcoholic Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7149_ReadmissionRate, 2) AS Percentage,
       @GE7149_Numerator AS Numerator,
       @GE7149_Denominator AS Denominator;

/* Emergency readmission rate (within 30 days) following an admission for alcoholic liver disease where readmission length of stay is 1 day or more 
(12mths to qtr end) 

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 
AND Mort30 = 0 
AND Read30 = 'Y' AND Read30_1andOverLOS = 1

COUNT (Spells)
Gastro_LiverDisease IN ('Alcohol-related liver disease','Cirrhosis') 
AND Mort30 = 0 

Metric ID: GE7150
Date: Q4 2023/24

*/

DECLARE @GE7150_StartDate DATE = '2023-04-01';
DECLARE @GE7150_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS >= 1
DECLARE @GE7150_Numerator INT;

SELECT @GE7150_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND swv.Spell_LOS >= 1
      AND SWV.Admission_Date
      BETWEEN @GE7150_StartDate AND @GE7150_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7150_Denominator INT;

SELECT @GE7150_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Alcohol-related liver disease', 'Cirrhosis' )
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7150_StartDate AND @GE7150_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7150_ReadmissionRate FLOAT;
SET @GE7150_ReadmissionRate = (CAST(@GE7150_Numerator AS FLOAT) / NULLIF(@GE7150_Denominator, 0)) * 100;

SELECT 'GE7150 - Emergency Readmission Rate Within 30 Days with Readmission LOS >= 1 Day for Alcoholic Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7150_ReadmissionRate, 2) AS Percentage,
       @GE7150_Numerator AS Numerator,
       @GE7150_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Non-alcoholic Liver Disease
 ------------------------------------------------------------------- */

/* Number of inpatient admissions for patients with non-alcoholic liver disease (monthly) 

COUNT (Spells)
Gastro_LiverDisease IN ('Non-alcohol fatty liver disease','Other inflammatory liver disease','Chronic hepatic failure','Other liver disease') 
AND Gastro_FLAG_AlcoholicLiverDisease = 0

Metric ID: GE7151
Date: June 2024

*/

DECLARE @GE7151_StartDate DATE = '2024-06-01';
DECLARE @GE7151_EndDate DATE = '2024-06-30';

DECLARE @GE7151_Num_Admissions INT;

SELECT @GE7151_Num_Admissions = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Non-alcohol fatty liver disease', 'Other inflammatory liver disease',
                                   'Chronic hepatic failure', 'Other liver disease'
                                 )
      AND SWV.Gastro_FLAG_AlcoholicLiverDisease = 0
      AND SWV.Admission_Date
      BETWEEN @GE7151_StartDate AND @GE7151_EndDate;

SELECT 'GE7151 - Number of Inpatient Admissions for Patients with Non-Alcoholic Liver Disease (Monthly)' AS Metric,
       @GE7151_Num_Admissions AS Value;

/* Emergency admission rate for patients with non-alcoholic liver disease (12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease IN ('Non-alcohol fatty liver disease','Other inflammatory liver disease','Chronic hepatic failure','Other liver disease')) 
AND POD_Derived = 'EM' 
AND Gastro_FLAG_AlcoholicLiverDisease = 0

COUNT (Spells)
Gastro_LiverDisease IN ('Non-alcohol fatty liver disease','Other inflammatory liver disease','Chronic hepatic failure','Other liver disease') 
AND Gastro_FLAG_AlcoholicLiverDisease = 0

Metric ID: GE7152
Date: Q1 2024/25

*/

DECLARE @GE7152_StartDate DATE = '2023-07-01';
DECLARE @GE7152_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Admissions
DECLARE @GE7152_Numerator INT;

SELECT @GE7152_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Non-alcohol fatty liver disease', 'Other inflammatory liver disease',
                                   'Chronic hepatic failure', 'Other liver disease'
                                 )
      AND SWV.Gastro_FLAG_AlcoholicLiverDisease = 0
      AND SWV.Admission_Sub_Type = 'EMR'
      AND SWV.Admission_Date
      BETWEEN @GE7152_StartDate AND @GE7152_EndDate;

-- Denominator: All Admissions
DECLARE @GE7152_Denominator INT;

SELECT @GE7152_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Non-alcohol fatty liver disease', 'Other inflammatory liver disease',
                                   'Chronic hepatic failure', 'Other liver disease'
                                 )
      AND SWV.Gastro_FLAG_AlcoholicLiverDisease = 0
      AND SWV.Admission_Date
      BETWEEN @GE7152_StartDate AND @GE7152_EndDate;

-- Calculate Emergency Admission Rate
DECLARE @GE7152_EmergencyRate FLOAT;
SET @GE7152_EmergencyRate = (CAST(@GE7152_Numerator AS FLOAT) / NULLIF(@GE7152_Denominator, 0)) * 100;

SELECT 'GE7152 - Emergency Admission Rate for Patients with Non-Alcoholic Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7152_EmergencyRate, 2) AS Percentage,
       @GE7152_Numerator AS Numerator,
       @GE7152_Denominator AS Denominator;

/* Mean emergency length of stay for patients with non-alcoholic liver disease (12mths to qtr end) 

Sum (Spell_LOS)
(Gastro_LiverDisease IN ('Non-alcohol fatty liver disease','Other inflammatory liver disease','Chronic hepatic failure','Other liver disease')) 
AND POD_Derived = 'EM' 
AND Gastro_FLAG_AlcoholicLiverDisease = 0

COUNT (Spells)
(Gastro_LiverDisease IN ('Non-alcohol fatty liver disease','Other inflammatory liver disease','Chronic hepatic failure','Other liver disease')) 
AND POD_Derived = 'EM' 
AND Gastro_FLAG_AlcoholicLiverDisease = 0

Metric ID: GE7153
Date: Q1 2024/25

*/

-- Declare variables
DECLARE @GE7153_StartDate DATE = '2023-07-01';
DECLARE @GE7153_EndDate DATE = '2024-06-30';
DECLARE @GE7153_Total_LOS INT;
DECLARE @GE7153_Num_Admissions INT;
DECLARE @GE7153_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gastro_LiverDisease IN ( 'Non-alcohol fatty liver disease', 'Other inflammatory liver disease',
                                       'Chronic hepatic failure', 'Other liver disease'
                                     )
          AND SWV.Gastro_FLAG_AlcoholicLiverDisease = 0
          AND SWV.Admission_Sub_Type = 'EMR'
          AND SWV.Admission_Date
          BETWEEN @GE7153_StartDate AND @GE7153_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7153_Total_LOS = SUM(DS.Spell_LOS),
       @GE7153_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7153_Mean_LOS = @GE7153_Total_LOS / NULLIF(@GE7153_Num_Admissions, 0);

-- Output the results
SELECT 'GE7153 - Mean Emergency Length of Stay for Patients with Non-Alcoholic Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7153_Mean_LOS, 2) AS Mean_LOS,
       @GE7153_Total_LOS AS Total_LOS,
       @GE7153_Num_Admissions AS Number_of_Admissions;

/* Emergency readmission rate (within 30 days) following an admission for non-alcoholic liver disease where readmission length of stay equals 0 days 
(12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease IN ('Non-alcohol fatty liver disease','Other inflammatory liver disease','Chronic hepatic failure','Other liver disease')) 
AND Mort30 = 0 
AND Read30 = 'Y' 
AND Read30_0LOS = 1  
AND Gastro_FLAG_AlcoholicLiverDisease = 0

COUNT (Spells)
(Gastro_LiverDisease IN ('Non-alcohol fatty liver disease','Other inflammatory liver disease','Chronic hepatic failure','Other liver disease')) 
AND Mort30 = 0 
AND Gastro_FLAG_AlcoholicLiverDisease = 0

Metric ID: GE7154
Date: Q4 2023/24

*/

DECLARE @GE7154_StartDate DATE = '2023-04-01';
DECLARE @GE7154_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS = 0
DECLARE @GE7154_Numerator INT;

SELECT @GE7154_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Non-alcohol fatty liver disease', 'Other inflammatory liver disease',
                                   'Chronic hepatic failure', 'Other liver disease'
                                 )
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Spell_LOS >= 1
      AND SWV.Gastro_FLAG_AlcoholicLiverDisease = 0
      AND SWV.Admission_Date
      BETWEEN @GE7154_StartDate AND @GE7154_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7154_Denominator INT;

SELECT @GE7154_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Non-alcohol fatty liver disease', 'Other inflammatory liver disease',
                                   'Chronic hepatic failure', 'Other liver disease'
                                 )
      AND SWV.Mort30 = 0
      AND SWV.Gastro_FLAG_AlcoholicLiverDisease = 0
      AND SWV.Admission_Date
      BETWEEN @GE7154_StartDate AND @GE7154_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7154_ReadmissionRate FLOAT;
SET @GE7154_ReadmissionRate = (CAST(@GE7154_Numerator AS FLOAT) / NULLIF(@GE7154_Denominator, 0)) * 100;

SELECT 'GE7154 - Emergency Readmission Rate Within 30 Days with Readmission LOS = 0 Days for Non-Alcoholic Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7154_ReadmissionRate, 2) AS Percentage,
       @GE7154_Numerator AS Numerator,
       @GE7154_Denominator AS Denominator;

/* Emergency readmission rate (within 30 days) following an admission for non-alcoholic liver disease where readmission length of stay is 1 day or more 
(12mths to qtr end) 

COUNT (Spells)
(Gastro_LiverDisease IN ('Non-alcohol fatty liver disease','Other inflammatory liver disease','Chronic hepatic failure','Other liver disease')) 
AND Mort30 = 0 
AND Read30 = 'Y' 
AND Read30_1andOverLOS = 1 
AND Gastro_FLAG_AlcoholicLiverDisease = 0

COUNT (Spells)
(Gastro_LiverDisease IN ('Non-alcohol fatty liver disease','Other inflammatory liver disease','Chronic hepatic failure','Other liver disease')) 
AND Mort30 = 0  
AND Gastro_FLAG_AlcoholicLiverDisease = 0

Metric ID: GE7155
Date: Q4 2023/24

*/

DECLARE @GE7155_StartDate DATE = '2023-04-01';
DECLARE @GE7155_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS >= 1
DECLARE @GE7155_Numerator INT;

SELECT @GE7155_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Non-alcohol fatty liver disease', 'Other inflammatory liver disease',
                                   'Chronic hepatic failure', 'Other liver disease'
                                 )
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Spell_LOS >= 1
      AND SWV.Gastro_FLAG_AlcoholicLiverDisease = 0
      AND SWV.Admission_Date
      BETWEEN @GE7155_StartDate AND @GE7155_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7155_Denominator INT;

SELECT @GE7155_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_LiverDisease IN ( 'Non-alcohol fatty liver disease', 'Other inflammatory liver disease',
                                   'Chronic hepatic failure', 'Other liver disease'
                                 )
      AND SWV.Mort30 = 0
      AND SWV.Gastro_FLAG_AlcoholicLiverDisease = 0
      AND SWV.Admission_Date
      BETWEEN @GE7155_StartDate AND @GE7155_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7155_ReadmissionRate FLOAT;
SET @GE7155_ReadmissionRate = (CAST(@GE7155_Numerator AS FLOAT) / NULLIF(@GE7155_Denominator, 0)) * 100;

SELECT 'GE7155 - Emergency Readmission Rate Within 30 Days with Readmission LOS >= 1 Day for Non-Alcoholic Liver Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7155_ReadmissionRate, 2) AS Percentage,
       @GE7155_Numerator AS Numerator,
       @GE7155_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Luminal Gastroenterology - Ulcerative Colitis
 ------------------------------------------------------------------- */

/* Number of inpatient admissions for patients with ulcerative colitis (monthly) 

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'

Metric ID: GE7156
Date: June 2024

*/

DECLARE @GE7156_StartDate DATE = '2024-06-01';
DECLARE @GE7156_EndDate DATE = '2024-06-30';

DECLARE @GE7156_Num_Admissions INT;

SELECT @GE7156_Num_Admissions = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Admission_Date
      BETWEEN @GE7156_StartDate AND @GE7156_EndDate;

SELECT 'GE7156 - Number of Inpatient Admissions for Patients with Ulcerative Colitis (Monthly)' AS Metric,
       @GE7156_Num_Admissions AS Value;

/* Emergency admission rate for patients with ulcerative colitis (12mths to qtr end) 

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND POD_Derived = 'EM'

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'

Metric ID: GE7157
Date: Q1 2024/25

*/

DECLARE @GE7157_StartDate DATE = '2023-07-01';
DECLARE @GE7157_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Admissions
DECLARE @GE7157_Numerator INT;

SELECT @GE7157_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Admission_Sub_Type = 'EMR'
      AND SWV.Admission_Date
      BETWEEN @GE7157_StartDate AND @GE7157_EndDate;

-- Denominator: All Admissions
DECLARE @GE7157_Denominator INT;

SELECT @GE7157_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Admission_Date
      BETWEEN @GE7157_StartDate AND @GE7157_EndDate;

-- Calculate Emergency Admission Rate
DECLARE @GE7157_EmergencyRate FLOAT;
SET @GE7157_EmergencyRate = (CAST(@GE7157_Numerator AS FLOAT) / NULLIF(@GE7157_Denominator, 0)) * 100;

SELECT 'GE7157 - Emergency Admission Rate for Patients with Ulcerative Colitis (12 months to quarter end)' AS Metric,
       ROUND(@GE7157_EmergencyRate, 2) AS Percentage,
       @GE7157_Numerator AS Numerator,
       @GE7157_Denominator AS Denominator;

/* Percentage of endoscopy procedures carried out on patients with ulcerative colitis 
(12mths to qtr end) 

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND Gastro_Endoscopy = 'Gastroenterology endoscopy'

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'

Metric ID: GE7158
Date: Q1 2024/25

*/

DECLARE @GE7158_StartDate DATE = '2023-07-01';
DECLARE @GE7158_EndDate DATE = '2024-06-30';

-- Numerator: Endoscopy Procedures
DECLARE @GE7158_Numerator INT;

SELECT @GE7158_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Gastro_Endoscopy = 'Gastroenterology endoscopy'
      AND SWV.Admission_Date
      BETWEEN @GE7158_StartDate AND @GE7158_EndDate;

-- Denominator: All Admissions
DECLARE @GE7158_Denominator INT;

SELECT @GE7158_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Admission_Date
      BETWEEN @GE7158_StartDate AND @GE7158_EndDate;

-- Calculate Percentage of Endoscopy Procedures
DECLARE @GE7158_EndoscopyRate FLOAT;
SET @GE7158_EndoscopyRate = (CAST(@GE7158_Numerator AS FLOAT) / NULLIF(@GE7158_Denominator, 0)) * 100;

SELECT 'GE7158 - Percentage of Endoscopy Procedures for Patients with Ulcerative Colitis (12 months to quarter end)' AS Metric,
       ROUND(@GE7158_EndoscopyRate, 2) AS Percentage,
       @GE7158_Numerator AS Numerator,
       @GE7158_Denominator AS Denominator;

/* Percentage of colectomy procedures carried out on patients with ulcerative colitis (12mths to qtr end) 

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' AND GenS_Colectomy <> 'Other'

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'

Metric ID: GE7159
Date: Q1 2024/25

*/

DECLARE @GE7159_StartDate DATE = '2023-07-01';
DECLARE @GE7159_EndDate DATE = '2024-06-30';

-- Numerator: Colectomy Procedures
DECLARE @GE7159_Numerator INT;

SELECT @GE7159_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.GenS_Colectomy NOT LIKE '%Other%'
      AND SWV.Admission_Date
      BETWEEN @GE7159_StartDate AND @GE7159_EndDate;

-- Denominator: All Admissions
DECLARE @GE7159_Denominator INT;

SELECT @GE7159_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Admission_Date
      BETWEEN @GE7159_StartDate AND @GE7159_EndDate;

-- Calculate Percentage of Colectomy Procedures
DECLARE @GE7159_ColectomyRate FLOAT;
SET @GE7159_ColectomyRate = (CAST(@GE7159_Numerator AS FLOAT) / NULLIF(@GE7159_Denominator, 0)) * 100;

SELECT 'GE7159 - Percentage of Colectomy Procedures for Patients with Ulcerative Colitis (12 months to quarter end)' AS Metric,
       ROUND(@GE7159_ColectomyRate, 2) AS Percentage,
       @GE7159_Numerator AS Numerator,
       @GE7159_Denominator AS Denominator;

/* Mean emergency length of stay for patients with ulcerative colitis (12mths to qtr end) 

Sum (Spell_LOS)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND POD_Derived = 'EM'

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND POD_Derived = 'EM'

Metric ID: GE7160
Date: Q1 2024/25

*/

-- Declare variables
DECLARE @GE7160_StartDate DATE = '2023-07-01';
DECLARE @GE7160_EndDate DATE = '2024-06-30';
DECLARE @GE7160_Total_LOS INT;
DECLARE @GE7160_Num_Admissions INT;
DECLARE @GE7160_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
          AND SWV.Admission_Sub_Type = 'EMR'
          AND SWV.Admission_Date
          BETWEEN @GE7160_StartDate AND @GE7160_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7160_Total_LOS = SUM(DS.Spell_LOS),
       @GE7160_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7160_Mean_LOS = @GE7160_Total_LOS / NULLIF(@GE7160_Num_Admissions, 0);

-- Output the results
SELECT 'GE7160 - Mean Emergency Length of Stay for Patients with Ulcerative Colitis (12 months to quarter end)' AS Metric,
       ROUND(@GE7160_Mean_LOS, 2) AS Mean_LOS,
       @GE7160_Total_LOS AS Total_LOS,
       @GE7160_Num_Admissions AS Number_of_Admissions;

/* Emergency readmission rate within 30 days following an admission for ulcerative colitis (12mths to qtr end) 

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND Mort30 = 0 
AND Read30 = 'Y'

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND Mort30 = 0

Metric ID: GE7161
Date: Q4 2023/24

*/

DECLARE @GE7161_StartDate DATE = '2023-07-01';
DECLARE @GE7161_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days
DECLARE @GE7161_Numerator INT;

SELECT @GE7161_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Admission_Date
      BETWEEN @GE7161_StartDate AND @GE7161_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7161_Denominator INT;

SELECT @GE7161_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7161_StartDate AND @GE7161_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7161_ReadmissionRate FLOAT;
SET @GE7161_ReadmissionRate = (CAST(@GE7161_Numerator AS FLOAT) / NULLIF(@GE7161_Denominator, 0)) * 100;

SELECT 'GE7161 - Emergency Readmission Rate Within 30 Days for Ulcerative Colitis (12 months to quarter end)' AS Metric,
       ROUND(@GE7161_ReadmissionRate, 2) AS Percentage,
       @GE7161_Numerator AS Numerator,
       @GE7161_Denominator AS Denominator;

/* Emergency readmission rate (within 30 days) following an admission for ulcerative colitis where readmission length of stay equals 0 days 
(12mths to qtr end) 

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND Mort30 = 0 
AND Read30 = 'Y' 
AND Read30_0LOS = 1

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND Mort30 = 0 

Metric ID: GE7162
Date: Q4 2023/24

*/

DECLARE @GE7162_StartDate DATE = '2023-04-01';
DECLARE @GE7162_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS = 0
DECLARE @GE7162_Numerator INT;

SELECT @GE7162_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Read30_0LOS = 1
      AND SWV.Admission_Date
      BETWEEN @GE7162_StartDate AND @GE7162_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7162_Denominator INT;

SELECT @GE7162_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7162_StartDate AND @GE7162_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7162_ReadmissionRate FLOAT;
SET @GE7162_ReadmissionRate = (CAST(@GE7162_Numerator AS FLOAT) / NULLIF(@GE7162_Denominator, 0)) * 100;

SELECT 'GE7162 - Emergency Readmission Rate Within 30 Days with Readmission LOS = 0 Days for Ulcerative Colitis (12 months to quarter end)' AS Metric,
       ROUND(@GE7162_ReadmissionRate, 2) AS Percentage,
       @GE7162_Numerator AS Numerator,
       @GE7162_Denominator AS Denominator;

/* Emergency readmission rate (within 30 days) following an admission for ulcerative colitis where readmission length of stay is 1 day or more 
(12mths to qtr end) 

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND Mort30 = 0 
AND Read30 = 'Y' 
AND Read30_1andOverLOS = 1

COUNT (Spells)
GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis' 
AND Mort30 = 0 

Metric ID: GE7163
Date: Q4 2023/24 

*/

DECLARE @GE7163_StartDate DATE = '2023-04-01';
DECLARE @GE7163_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS >= 1
DECLARE @GE7163_Numerator INT;

SELECT @GE7163_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Spell_LOS >= 1
      AND SWV.Admission_Date
      BETWEEN @GE7163_StartDate AND @GE7163_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7163_Denominator INT;

SELECT @GE7163_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_UlcerativeColitis = 'Ulcerative colitis primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7163_StartDate AND @GE7163_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7163_ReadmissionRate FLOAT;
SET @GE7163_ReadmissionRate = (CAST(@GE7163_Numerator AS FLOAT) / NULLIF(@GE7163_Denominator, 0)) * 100;

SELECT 'GE7163 - Emergency Readmission Rate Within 30 Days with Readmission LOS >= 1 Day for Ulcerative Colitis (12 months to quarter end)' AS Metric,
       ROUND(@GE7163_ReadmissionRate, 2) AS Percentage,
       @GE7163_Numerator AS Numerator,
       @GE7163_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Luminal Gastroenterology - Crohns Disease
 ------------------------------------------------------------------- */

/* Number of inpatient admissions for patients with Crohn's Disease (monthly) 

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'

Metric ID: GE7164
Date: June 2024

*/

DECLARE @GE7164_StartDate DATE = '2024-06-01';
DECLARE @GE7164_EndDate DATE = '2024-06-30';

DECLARE @GE7164_Num_Admissions INT;

SELECT @GE7164_Num_Admissions = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Admission_Date
      BETWEEN @GE7164_StartDate AND @GE7164_EndDate;

SELECT 'GE7164 - Number of Inpatient Admissions for Patients with Crohn''s Disease (Monthly)' AS Metric,
       @GE7164_Num_Admissions AS Value;

/* Emergency admission rate for patients with Crohn's Disease (12mths to qtr end)

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND POD_Derived = 'EM'

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'

Metric ID: GE7165
Date: Q1 2024/25

*/

DECLARE @GE7165_StartDate DATE = '2023-07-01';
DECLARE @GE7165_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Admissions
DECLARE @GE7165_Numerator INT;

SELECT @GE7165_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Admission_Sub_Type = 'EMR'
      AND SWV.Admission_Date
      BETWEEN @GE7165_StartDate AND @GE7165_EndDate;

-- Denominator: All Admissions
DECLARE @GE7165_Denominator INT;

SELECT @GE7165_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Admission_Date
      BETWEEN @GE7165_StartDate AND @GE7165_EndDate;

-- Calculate Emergency Admission Rate
DECLARE @GE7165_EmergencyRate FLOAT;
SET @GE7165_EmergencyRate = (CAST(@GE7165_Numerator AS FLOAT) / NULLIF(@GE7165_Denominator, 0)) * 100;

SELECT 'GE7165 - Emergency Admission Rate for Patients with Crohn''s Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7165_EmergencyRate, 2) AS Percentage,
       @GE7165_Numerator AS Numerator,
       @GE7165_Denominator AS Denominator;

/* Percentage of colectomy procedures carried out on patients with Crohn's disease (12mths to qtr end) 

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND GenS_Colectomy <> 'Other'

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'

Metric ID: GE7166
Date: Q1 2024/25

*/

DECLARE @GE7166_StartDate DATE = '2023-07-01';
DECLARE @GE7166_EndDate DATE = '2024-06-30';

-- Numerator: Colectomy Procedures
DECLARE @GE7166_Numerator INT;

SELECT @GE7166_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.GenS_Colectomy <> 'Other'
      AND SWV.Admission_Date
      BETWEEN @GE7166_StartDate AND @GE7166_EndDate;

-- Denominator: All Admissions
DECLARE @GE7166_Denominator INT;

SELECT @GE7166_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Admission_Date
      BETWEEN @GE7166_StartDate AND @GE7166_EndDate;

-- Calculate Percentage of Colectomy Procedures
DECLARE @GE7166_ColectomyRate FLOAT;
SET @GE7166_ColectomyRate = (CAST(@GE7166_Numerator AS FLOAT) / NULLIF(@GE7166_Denominator, 0)) * 100;

SELECT 'GE7166 - Percentage of Colectomy Procedures for Patients with Crohn''s Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7166_ColectomyRate, 2) AS Percentage,
       @GE7166_Numerator AS Numerator,
       @GE7166_Denominator AS Denominator;

/* Mean emergency length of stay for patients with Crohn's Disease (12mths to qtr end) 

Sum (Spell_LOS)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND POD_Derived = 'EM'

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND POD_Derived = 'EM'

Metric ID: GE7167
Date: Q1 2024/25

*/

-- Declare variables
DECLARE @GE7167_StartDate DATE = '2023-07-01';
DECLARE @GE7167_EndDate DATE = '2024-06-30';
DECLARE @GE7167_Total_LOS INT;
DECLARE @GE7167_Num_Admissions INT;
DECLARE @GE7167_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
          AND SWV.Admission_Sub_Type = 'EMR'
          AND SWV.Admission_Date
          BETWEEN @GE7167_StartDate AND @GE7167_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7167_Total_LOS = SUM(DS.Spell_LOS),
       @GE7167_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7167_Mean_LOS = @GE7167_Total_LOS / NULLIF(@GE7167_Num_Admissions, 0);

-- Output the results
SELECT 'GE7167 - Mean Emergency Length of Stay for Patients with Crohn''s Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7167_Mean_LOS, 2) AS Mean_LOS,
       @GE7167_Total_LOS AS Total_LOS,
       @GE7167_Num_Admissions AS Number_of_Admissions;

/* Emergency readmission rate within 30 days following an admission for Crohn's Disease (12mths to qtr end) 

COUNT (Spells)GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND Mort30 = 0 
AND Read30 = 'Y'

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND Mort30 = 0

Metric ID: GE7168
Date: Q4 2023/24

*/

DECLARE @GE7168_StartDate DATE = '2023-07-01';
DECLARE @GE7168_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days
DECLARE @GE7168_Numerator INT;

SELECT @GE7168_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Admission_Date
      BETWEEN @GE7168_StartDate AND @GE7168_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7168_Denominator INT;

SELECT @GE7168_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7168_StartDate AND @GE7168_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7168_ReadmissionRate FLOAT;
SET @GE7168_ReadmissionRate = (CAST(@GE7168_Numerator AS FLOAT) / NULLIF(@GE7168_Denominator, 0)) * 100;

SELECT 'GE7168 - Emergency Readmission Rate Within 30 Days for Crohn''s Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7168_ReadmissionRate, 2) AS Percentage,
       @GE7168_Numerator AS Numerator,
       @GE7168_Denominator AS Denominator;

/* Emergency readmission rate (within 30 days) following an admission for Crohn's Disease where readmission length of stay equals 0 days 
(12mths to qtr end) 

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND Mort30 = 0 
AND Read30 = 'Y' 
AND Read30_0LOS = 1

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND Mort30 = 0 

Metric ID: GE7169
Date: Q4 2023/24

*/

DECLARE @GE7169_StartDate DATE = '2023-04-01';
DECLARE @GE7169_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS = 0
DECLARE @GE7169_Numerator INT;

SELECT @GE7169_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Read30_0LOS = 1
      AND SWV.Admission_Date
      BETWEEN @GE7169_StartDate AND @GE7169_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7169_Denominator INT;

SELECT @GE7169_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7169_StartDate AND @GE7169_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7169_ReadmissionRate FLOAT;
SET @GE7169_ReadmissionRate = (CAST(@GE7169_Numerator AS FLOAT) / NULLIF(@GE7169_Denominator, 0)) * 100;

SELECT 'GE7169 - Emergency Readmission Rate Within 30 Days with Readmission LOS = 0 Days for Crohn''s Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7169_ReadmissionRate, 2) AS Percentage,
       @GE7169_Numerator AS Numerator,
       @GE7169_Denominator AS Denominator;

/* Emergency readmission rate (within 30 days) following an admission for Crohn's Disease where readmission length of stay is 1 day or more 
(12mths to qtr end) 

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND Mort30 = 0 
AND Read30 = 'Y' 
AND Read30_1andOverLOS = 1

COUNT (Spells)
GenS_CrohnDisease = 'Crohn''s disease primary diagnosis' 
AND Mort30 = 0 

Metric ID: GE7170
Date: Q4 2023/24

*/

DECLARE @GE7170_StartDate DATE = '2023-04-01';
DECLARE @GE7170_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 30 days with LOS >= 1
DECLARE @GE7170_Numerator INT;

SELECT @GE7170_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Read30 = 1
      AND SWV.Spell_LOS >= 1
      AND SWV.Admission_Date
      BETWEEN @GE7170_StartDate AND @GE7170_EndDate;

-- Denominator: Admissions where patient did not die within 30 days
DECLARE @GE7170_Denominator INT;

SELECT @GE7170_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.GenS_CrohnDisease = 'Crohn''s disease primary diagnosis'
      AND SWV.Mort30 = 0
      AND SWV.Admission_Date
      BETWEEN @GE7170_StartDate AND @GE7170_EndDate;

-- Calculate Readmission Rate
DECLARE @GE7170_ReadmissionRate FLOAT;
SET @GE7170_ReadmissionRate = (CAST(@GE7170_Numerator AS FLOAT) / NULLIF(@GE7170_Denominator, 0)) * 100;

SELECT 'GE7170 - Emergency Readmission Rate Within 30 Days with Readmission LOS >= 1 Day for Crohn''s Disease (12 months to quarter end)' AS Metric,
       ROUND(@GE7170_ReadmissionRate, 2) AS Percentage,
       @GE7170_Numerator AS Numerator,
       @GE7170_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Nutrition
 ------------------------------------------------------------------- */

/* Number of inpatient admissions for patients where TPN was administered (monthly) 

COUNT (Spells)
Gastro_Nutrition = 'Total parenteral nutrition (TPN)'

Metric ID: GE7171
Date: June 2024

*/

DECLARE @GE7171_StartDate DATE = '2024-06-01';
DECLARE @GE7171_EndDate DATE = '2024-06-30';

DECLARE @GE7171_Num_Admissions INT;

SELECT @GE7171_Num_Admissions = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Nutrition = 'Total parenteral nutrition (TPN)'
      AND SWV.Admission_Date
      BETWEEN @GE7171_StartDate AND @GE7171_EndDate;

SELECT 'GE7171 - Number of Inpatient Admissions Where TPN Was Administered (Monthly)' AS Metric,
       @GE7171_Num_Admissions AS Value;

/* Mean inpatient length of stay for patients with an admission where TPN was administered (12mths to qtr end) 

Sum (Spell_LOS)
Gastro_Nutrition = 'Total parenteral nutrition (TPN)'

COUNT (Spells)
Gastro_Nutrition = 'Total parenteral nutrition (TPN)'

Metric ID: GE7172
Date: Q1 2024/25

*/

-- Declare variables
DECLARE @GE7172_StartDate DATE = '2023-07-01';
DECLARE @GE7172_EndDate DATE = '2024-06-30';
DECLARE @GE7172_Total_LOS INT;
DECLARE @GE7172_Num_Admissions INT;
DECLARE @GE7172_Mean_LOS FLOAT;

-- Create a derived table of distinct spells with their Spell_LOS
WITH Distinct_Spells
AS (SELECT SWV.Spell_Number,
           MAX(SWV.Spell_LOS) AS Spell_LOS -- Use MAX to get the Spell_LOS per spell
    FROM #Spells_With_Variables SWV
    WHERE SWV.Gastro_Nutrition = 'Total parenteral nutrition (TPN)'
          AND SWV.Admission_Date
          BETWEEN @GE7172_StartDate AND @GE7172_EndDate
    GROUP BY SWV.Spell_Number)

-- Calculate Total LOS and Number of Admissions
SELECT @GE7172_Total_LOS = SUM(DS.Spell_LOS),
       @GE7172_Num_Admissions = COUNT(DISTINCT DS.Spell_Number)
FROM Distinct_Spells DS;

-- Calculate Mean Length of Stay
SET @GE7172_Mean_LOS = @GE7172_Total_LOS / NULLIF(@GE7172_Num_Admissions, 0);

-- Output the results
SELECT 'GE7172 - Mean Inpatient LOS for Admissions Where TPN Was Administered (12 months to quarter end)' AS Metric,
       ROUND(@GE7172_Mean_LOS, 2) AS Mean_LOS,
       @GE7172_Total_LOS AS Total_LOS,
       @GE7172_Num_Admissions AS Number_of_Admissions;

/* Line infection rate for patients with an admission where TPN was administered (12mths to qtr end) 

COUNT (Spells)
Gastro_Nutrition = 'Total parenteral nutrition (TPN)' 
AND Gastro_VascularLineInfection = 'Infection and inflammation of vascular device'

COUNT (Spells)
Gastro_Nutrition = 'Total parenteral nutrition (TPN)'

Metric ID: GE7173
Date: Q1 2024/25

*/

DECLARE @GE7173_StartDate DATE = '2023-07-01';
DECLARE @GE7173_EndDate DATE = '2024-06-30';

-- Numerator: Admissions with Line Infection
DECLARE @GE7173_Numerator INT;

SELECT @GE7173_Numerator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Nutrition = 'Total parenteral nutrition (TPN)'
      AND SWV.Gastro_VascularLineInfection = 'Infection and inflammation of vascular device'
      AND SWV.Admission_Date
      BETWEEN @GE7173_StartDate AND @GE7173_EndDate;

-- Denominator: All Admissions Where TPN Was Administered
DECLARE @GE7173_Denominator INT;

SELECT @GE7173_Denominator = COUNT(DISTINCT SWV.Spell_Number)
FROM #Spells_With_Variables SWV
WHERE SWV.Gastro_Nutrition = 'Total parenteral nutrition (TPN)'
      AND SWV.Admission_Date
      BETWEEN @GE7173_StartDate AND @GE7173_EndDate;

-- Calculate Line Infection Rate
DECLARE @GE7173_LineInfectionRate FLOAT;
SET @GE7173_LineInfectionRate = (CAST(@GE7173_Numerator AS FLOAT) / NULLIF(@GE7173_Denominator, 0)) * 100;

SELECT 'GE7173 - Line Infection Rate for Admissions Where TPN Was Administered (12 months to quarter end)' AS Metric,
       ROUND(@GE7173_LineInfectionRate, 2) AS Percentage,
       @GE7173_Numerator AS Numerator,
       @GE7173_Denominator AS Denominator;
