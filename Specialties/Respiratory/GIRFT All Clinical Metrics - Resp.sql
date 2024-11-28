/*
	
	Script Title: GIRFT Respiratory - All Clinical Metrics
	Author: Adam Ross
	Version: 1.0
	Description: This script generates the figures for the Respiratory All Clinical
	metrics section of the Model Hospital dashboard. It covers the following classes:

	- Respiratory Medicine - Overview
	- Pleural Disease - Pleural Effusion
	- Pleural Disease - Pneumothorax
	- Pulmonary Embolism
	- Pneumonia
	- Chronic Obstructive Pulmonary Disease
	- Asthma
	- Bronchiectasis

*/

-- SQL Code Begins

-- ========================================
-- Step 3: Create and Populate Temporary Tables for CodeGroups
-- ========================================

		-- -----------------------
		-- Code Group: RespiratoryMedicine_2
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_RespiratoryMedicine_2') IS NOT NULL
			DROP TABLE #CodeGroup_RespiratoryMedicine_2;

		CREATE TABLE #CodeGroup_RespiratoryMedicine_2
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_RespiratoryMedicine_2
		(
			Code
		)
		VALUES
		('DZ');

		-- -----------------------
		-- Code Group: PulmEmbolismWithInterv_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PulmEmbolismWithInterv_5') IS NOT NULL
			DROP TABLE #CodeGroup_PulmEmbolismWithInterv_5;

		CREATE TABLE #CodeGroup_PulmEmbolismWithInterv_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PulmEmbolismWithInterv_5
		(
			Code
		)
		VALUES
		('DZ09J'),
		('DZ09K');

		-- -----------------------
		-- Code Group: PulmEmbolismWOInterv0-2_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PulmEmbolismWOInterv02_5') IS NOT NULL
			DROP TABLE #CodeGroup_PulmEmbolismWOInterv02_5;

		CREATE TABLE #CodeGroup_PulmEmbolismWOInterv02_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PulmEmbolismWOInterv02_5
		(
			Code
		)
		VALUES
		('DZ09Q');

		-- -----------------------
		-- Code Group: PulmEmbolismWOInterv3-8_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PulmEmbolismWOInterv38_5') IS NOT NULL
			DROP TABLE #CodeGroup_PulmEmbolismWOInterv38_5;

		CREATE TABLE #CodeGroup_PulmEmbolismWOInterv38_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PulmEmbolismWOInterv38_5
		(
			Code
		)
		VALUES
		('DZ09N'),
		('DZ09P');

		-- -----------------------
		-- Code Group: PulmEmbolismWOInterv9+_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PulmEmbolismWOInterv9_5') IS NOT NULL
			DROP TABLE #CodeGroup_PulmEmbolismWOInterv9_5;

		CREATE TABLE #CodeGroup_PulmEmbolismWOInterv9_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PulmEmbolismWOInterv9_5
		(
			Code
		)
		VALUES
		('DZ09L'),
		('DZ09M');

	
		-- -----------------------
		-- Code Group: PulmEmbolismICD_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PulmEmbolismICD_4') IS NOT NULL
			DROP TABLE #CodeGroup_PulmEmbolismICD_4;

		CREATE TABLE #CodeGroup_PulmEmbolismICD_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PulmEmbolismICD_4
		(
			Code
		)
		VALUES
		('I269');

		-- -----------------------
		-- Code Group: Asthma_3
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_Asthma_3') IS NOT NULL
			DROP TABLE #CodeGroup_Asthma_3;

		CREATE TABLE #CodeGroup_Asthma_3
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_Asthma_3
		(
			Code
		)
		VALUES
		('J45'),
		('J46');

		-- -----------------------
		-- Code Group: AsthmaEmergHRGs_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_AsthmaEmergHRGs_4') IS NOT NULL
			DROP TABLE #CodeGroup_AsthmaEmergHRGs_4;

		CREATE TABLE #CodeGroup_AsthmaEmergHRGs_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_AsthmaEmergHRGs_4
		(
			Code
		)
		VALUES
		('DZ15'),
		('PD12');

		-- -----------------------
		-- Code Group: AsthmaEmergHRGs_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_AsthmaEmergHRGs_5') IS NOT NULL
			DROP TABLE #CodeGroup_AsthmaEmergHRGs_5;

		CREATE TABLE #CodeGroup_AsthmaEmergHRGs_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_AsthmaEmergHRGs_5
		(
			Code
		)
		VALUES
		('UZ01Z');

		-- -----------------------
		-- Code Group: EmergSpecs
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_EmergSpecs') IS NOT NULL
			DROP TABLE #CodeGroup_EmergSpecs;

		CREATE TABLE #CodeGroup_EmergSpecs
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_EmergSpecs
		(
			Code
		)
		VALUES
		('180'),
		('190'),
		('192'),
		('300'),
		('301'),
		('302'),
		('303'),
		('305'),
		('311'),
		('313'),
		('314'),
		('320'),
		('326'),
		('330'),
		('340'),
		('350'),
		('352'),
		('360'),
		('361'),
		('370'),
		('400'),
		('410'),
		('420'),
		('430'),
		('499'),
		('501'),
		('502'),
		('600'),
		('710'),
		('800'),
		('810'),
		('823'),
		('824'),
		('831'),
		('833');

		-- -----------------------
		-- Code Group: COPD_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_COPD_4') IS NOT NULL
			DROP TABLE #CodeGroup_COPD_4;

		CREATE TABLE #CodeGroup_COPD_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_COPD_4
		(
			Code
		)
		VALUES
		('DZ65');

		-- -----------------------
		-- Code Group: COPDNIV_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_COPDNIV_4') IS NOT NULL
			DROP TABLE #CodeGroup_COPDNIV_4;

		CREATE TABLE #CodeGroup_COPDNIV_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_COPDNIV_4
		(
			Code
		)
		VALUES
		('E852');

		-- -----------------------
		-- Code Group: PneumoniaBroncho_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PneumoniaBroncho_4') IS NOT NULL
			DROP TABLE #CodeGroup_PneumoniaBroncho_4;

		CREATE TABLE #CodeGroup_PneumoniaBroncho_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PneumoniaBroncho_4
		(
			Code
		)
		VALUES
		('J180');

		-- -----------------------
		-- Code Group: PneumoniaLobar_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PneumoniaLobar_4') IS NOT NULL
			DROP TABLE #CodeGroup_PneumoniaLobar_4;

		CREATE TABLE #CodeGroup_PneumoniaLobar_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PneumoniaLobar_4
		(
			Code
		)
		VALUES
		('J181');

		-- -----------------------
		-- Code Group: PneumoniaInfluenza_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PneumoniaInfluenza_4') IS NOT NULL
			DROP TABLE #CodeGroup_PneumoniaInfluenza_4;

		CREATE TABLE #CodeGroup_PneumoniaInfluenza_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PneumoniaInfluenza_4
		(
			Code
		)
		VALUES
		('J100');

		-- -----------------------
		-- Code Group: PneumoniaPneumococcal_3
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PneumoniaPneumococcal_3') IS NOT NULL
			DROP TABLE #CodeGroup_PneumoniaPneumococcal_3;

		CREATE TABLE #CodeGroup_PneumoniaPneumococcal_3
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PneumoniaPneumococcal_3
		(
			Code
		)
		VALUES
		('J13');

		-- -----------------------
		-- Code Group: PneumoniaUnspecified_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PneumoniaUnspecified_4') IS NOT NULL
			DROP TABLE #CodeGroup_PneumoniaUnspecified_4;

		CREATE TABLE #CodeGroup_PneumoniaUnspecified_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PneumoniaUnspecified_4
		(
			Code
		)
		VALUES
		('J189');

		-- -----------------------
		-- Code Group: PneumoniaOther_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PneumoniaOther_4') IS NOT NULL
			DROP TABLE #CodeGroup_PneumoniaOther_4;

		CREATE TABLE #CodeGroup_PneumoniaOther_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PneumoniaOther_4
		(
			Code
		)
		VALUES
		('J110'),
		('J120'),
		('J121'),
		('J122'),
		('J123'),
		('J128'),
		('J129'),
		('J150'),
		('J160'),
		('J168'),
		('J170'),
		('J171'),
		('J178'),
		('J182'),
		('J188'),
		('A481'),
		('U049');

		-- -----------------------
		-- Code Group: PneumoniaOther_3
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PneumoniaOther_3') IS NOT NULL
			DROP TABLE #CodeGroup_PneumoniaOther_3;

		CREATE TABLE #CodeGroup_PneumoniaOther_3
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PneumoniaOther_3
		(
			Code
		)
		VALUES
		('J14'),
		('A70'),
		('B59');

		-- -----------------------
		-- Code Group: AGE18_40
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_AGE18_40') IS NOT NULL
			DROP TABLE #CodeGroup_AGE18_40;

		CREATE TABLE #CodeGroup_AGE18_40
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_AGE18_40
		(
			Code
		)
		VALUES
		('18'),
		('40');

		-- -----------------------
		-- Code Group: AGE41_65
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_AGE41_65') IS NOT NULL
			DROP TABLE #CodeGroup_AGE41_65;

		CREATE TABLE #CodeGroup_AGE41_65
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_AGE41_65
		(
			Code
		)
		VALUES
		('41'),
		('65');

		-- -----------------------
		-- Code Group: AGE41_75
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_AGE41_75') IS NOT NULL
			DROP TABLE #CodeGroup_AGE41_75;

		CREATE TABLE #CodeGroup_AGE41_75
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_AGE41_75
		(
			Code
		)
		VALUES
		('41'),
		('75');

		-- -----------------------
		-- Code Group: AGE66_80
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_AGE66_80') IS NOT NULL
			DROP TABLE #CodeGroup_AGE66_80;

		CREATE TABLE #CodeGroup_AGE66_80
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_AGE66_80
		(
			Code
		)
		VALUES
		('66'),
		('80');

		-- -----------------------
		-- Code Group: AGE80_plus
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_AGE80_plus') IS NOT NULL
			DROP TABLE #CodeGroup_AGE80_plus;

		CREATE TABLE #CodeGroup_AGE80_plus
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_AGE80_plus
		(
			Code
		)
		VALUES
		('81'),
		('120');

		-- -----------------------
		-- Code Group: Pneumothorax_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_Pneumothorax_4') IS NOT NULL
			DROP TABLE #CodeGroup_Pneumothorax_4;

		CREATE TABLE #CodeGroup_Pneumothorax_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_Pneumothorax_4
		(
			Code
		)
		VALUES
		('J930'),
		('J931'),
		('J938'),
		('J939'),
		('S270');

		-- -----------------------
		-- Code Group: PulmEmbolismHRG_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PulmEmbolismHRG_4') IS NOT NULL
			DROP TABLE #CodeGroup_PulmEmbolismHRG_4;

		CREATE TABLE #CodeGroup_PulmEmbolismHRG_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PulmEmbolismHRG_4
		(
			Code
		)
		VALUES
		('DZ09');

		-- -----------------------
		-- Code Group: PleuralDiseaseMultInterv_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PleuralDiseaseMultInterv_5') IS NOT NULL
			DROP TABLE #CodeGroup_PleuralDiseaseMultInterv_5;

		CREATE TABLE #CodeGroup_PleuralDiseaseMultInterv_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PleuralDiseaseMultInterv_5
		(
			Code
		)
		VALUES
		('DZ16H'),
		('DZ16J'),
		('DZ16L'),
		('DZ16P');

		-- -----------------------
		-- Code Group: PleuralDiseaseSingInterv_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PleuralDiseaseSingInterv_5') IS NOT NULL
			DROP TABLE #CodeGroup_PleuralDiseaseSingInterv_5;

		CREATE TABLE #CodeGroup_PleuralDiseaseSingInterv_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PleuralDiseaseSingInterv_5
		(
			Code
		)
		VALUES
		('DZ16K'),
		('DZ16M'),
		('DZ16N'),
		('DZ16Q');

		-- -----------------------
		-- Code Group: PleuralDiseaseWOInterv_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PleuralDiseaseWOInterv_5') IS NOT NULL
			DROP TABLE #CodeGroup_PleuralDiseaseWOInterv_5;

		CREATE TABLE #CodeGroup_PleuralDiseaseWOInterv_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PleuralDiseaseWOInterv_5
		(
			Code
		)
		VALUES
		('DZ16R');

		-- -----------------------
		-- Code Group: PleuralDisease_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PleuralDisease_4') IS NOT NULL
			DROP TABLE #CodeGroup_PleuralDisease_4;

		CREATE TABLE #CodeGroup_PleuralDisease_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PleuralDisease_4
		(
			Code
		)
		VALUES
		('DZ16');

		-- -----------------------
		-- Code Group: PleuralDisease_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PleuralDisease_5') IS NOT NULL
			DROP TABLE #CodeGroup_PleuralDisease_5;

		CREATE TABLE #CodeGroup_PleuralDisease_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PleuralDisease_5
		(
			Code
		)
		VALUES
		('YD02Z'),
		('YD04Z'),
		('YD05Z');

		-- -----------------------
		-- Code Group: Empyema_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_Empyema_4') IS NOT NULL
			DROP TABLE #CodeGroup_Empyema_4;

		CREATE TABLE #CodeGroup_Empyema_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_Empyema_4
		(
			Code
		)
		VALUES
		('DZ10');

		-- -----------------------
		-- Code Group: TRETSPEF_300
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_TRETSPEF_300') IS NOT NULL
			DROP TABLE #CodeGroup_TRETSPEF_300;

		CREATE TABLE #CodeGroup_TRETSPEF_300
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_TRETSPEF_300
		(
			Code
		)
		VALUES
		('300');

		-- -----------------------
		-- Code Group: TRETSPEF_326
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_TRETSPEF_326') IS NOT NULL
			DROP TABLE #CodeGroup_TRETSPEF_326;

		CREATE TABLE #CodeGroup_TRETSPEF_326
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_TRETSPEF_326
		(
			Code
		)
		VALUES
		('326');

		-- -----------------------
		-- Code Group: TRETSPEF_340
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_TRETSPEF_340') IS NOT NULL
			DROP TABLE #CodeGroup_TRETSPEF_340;

		CREATE TABLE #CodeGroup_TRETSPEF_340
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_TRETSPEF_340
		(
			Code
		)
		VALUES
		('340');

		-- -----------------------
		-- Code Group: TRETSPEF_430
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_TRETSPEF_430') IS NOT NULL
			DROP TABLE #CodeGroup_TRETSPEF_430;

		CREATE TABLE #CodeGroup_TRETSPEF_430
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_TRETSPEF_430
		(
			Code
		)
		VALUES
		('430');

		-- -----------------------
		-- Code Group: COPD_ICD_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_COPD_ICD_4') IS NOT NULL
			DROP TABLE #CodeGroup_COPD_ICD_4;

		CREATE TABLE #CodeGroup_COPD_ICD_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_COPD_ICD_4
		(
			Code
		)
		VALUES
		('J40X'),
		('J410'),
		('J411'),
		('J418'),
		('J42X'),
		('J431'),
		('J432'),
		('J438'),
		('J439'),
		('J440'),
		('J441'),
		('J448'),
		('J449');

		-- -----------------------
		-- Code Group: Bronchiectasis_3
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_Bronchiectasis_3') IS NOT NULL
			DROP TABLE #CodeGroup_Bronchiectasis_3;

		CREATE TABLE #CodeGroup_Bronchiectasis_3
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_Bronchiectasis_3
		(
			Code
		)
		VALUES
		('J47');

		-- -----------------------
		-- Code Group: Value_One
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_Value_One') IS NOT NULL
			DROP TABLE #CodeGroup_Value_One;

		CREATE TABLE #CodeGroup_Value_One
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_Value_One
		(
			Code
		)
		VALUES
		('1');

		-- -----------------------
		-- Code Group: Discharged
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_Discharged') IS NOT NULL
			DROP TABLE #CodeGroup_Discharged;

		CREATE TABLE #CodeGroup_Discharged
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_Discharged
		(
			Code
		)
		VALUES
		('1');

		-- -----------------------
		-- Code Group: DNA
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_DNA') IS NOT NULL
			DROP TABLE #CodeGroup_DNA;

		CREATE TABLE #CodeGroup_DNA
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_DNA
		(
			Code
		)
		VALUES
		('3');

		-- -----------------------
		-- Code Group: Face2Face
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_Face2Face') IS NOT NULL
			DROP TABLE #CodeGroup_Face2Face;

		CREATE TABLE #CodeGroup_Face2Face
		(
			Code VARCHAR(20) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_Face2Face
		(
			Code
		)
		VALUES
		('Face2Face');

		-- -----------------------
		-- Code Group: Virtual
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_Virtual') IS NOT NULL
			DROP TABLE #CodeGroup_Virtual;

		CREATE TABLE #CodeGroup_Virtual
		(
			Code VARCHAR(20) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_Virtual
		(
			Code
		)
		VALUES
		('Virtual');


		-- -----------------------
		-- Code Group: PleuralDiseaseBPT_5
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_PleuralDiseaseBPT_5') IS NOT NULL
			DROP TABLE #CodeGroup_PleuralDiseaseBPT_5;

		CREATE TABLE #CodeGroup_PleuralDiseaseBPT_5
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_PleuralDiseaseBPT_5
		(
			Code
		)
		VALUES
		('YD04Z'),
		('YD05Z');

		-- -----------------------
		-- Code Group: CPAP_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_CPAP_4') IS NOT NULL
			DROP TABLE #CodeGroup_CPAP_4;

		CREATE TABLE #CodeGroup_CPAP_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_CPAP_4
		(
			Code
		)
		VALUES
		('E856');

		-- -----------------------
		-- Code Group: LimPolysomnography_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_LimPolysomnography_4') IS NOT NULL
			DROP TABLE #CodeGroup_LimPolysomnography_4;

		CREATE TABLE #CodeGroup_LimPolysomnography_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_LimPolysomnography_4
		(
			Code
		)
		VALUES
		('U331');

		-- -----------------------
		-- Code Group: FullPolysomnography_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_FullPolysomnography_4') IS NOT NULL
			DROP TABLE #CodeGroup_FullPolysomnography_4;

		CREATE TABLE #CodeGroup_FullPolysomnography_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_FullPolysomnography_4
		(
			Code
		)
		VALUES
		('A847');

		-- -----------------------
		-- Code Group: TRETSPEF_347
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_TRETSPEF_347') IS NOT NULL
			DROP TABLE #CodeGroup_TRETSPEF_347;

		CREATE TABLE #CodeGroup_TRETSPEF_347
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_TRETSPEF_347
		(
			Code
		)
		VALUES
		('347');

		-- -----------------------
		-- Code Group: WF_2
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_WF_2') IS NOT NULL
			DROP TABLE #CodeGroup_WF_2;

		CREATE TABLE #CodeGroup_WF_2
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_WF_2
		(
			Code
		)
		VALUES
		('WF');

		-- -----------------------
		-- Code Group: ElectiveAdmissions
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_ElectiveAdmissions') IS NOT NULL
			DROP TABLE #CodeGroup_ElectiveAdmissions;

		CREATE TABLE #CodeGroup_ElectiveAdmissions
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_ElectiveAdmissions
		(
			Code
		)
		VALUES
		('11'),
		('12'),
		('13');

		-- -----------------------
		-- Code Group: Immunotherapy_4
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_Immunotherapy_4') IS NOT NULL
			DROP TABLE #CodeGroup_Immunotherapy_4;

		CREATE TABLE #CodeGroup_Immunotherapy_4
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_Immunotherapy_4
		(
			Code
		)
		VALUES
		('X962'),
		('X385'),
		('X353'),
		('X374');

		-- -----------------------
		-- Code Group: POD_Derived_EL
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_POD_Derived_EL') IS NOT NULL
			DROP TABLE #CodeGroup_POD_Derived_EL;

		CREATE TABLE #CodeGroup_POD_Derived_EL
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_POD_Derived_EL
		(
			Code
		)
		VALUES
		('EL');

		-- -----------------------
		-- Code Group: POD_Derived_RA
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_POD_Derived_RA') IS NOT NULL
			DROP TABLE #CodeGroup_POD_Derived_RA;

		CREATE TABLE #CodeGroup_POD_Derived_RA
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_POD_Derived_RA
		(
			Code
		)
		VALUES
		('RA');

		-- -----------------------
		-- Code Group: POD_Derived_EM
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_POD_Derived_EM') IS NOT NULL
			DROP TABLE #CodeGroup_POD_Derived_EM;

		CREATE TABLE #CodeGroup_POD_Derived_EM
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_POD_Derived_EM
		(
			Code
		)
		VALUES
		('EM');

		-- -----------------------
		-- Code Group: POD_Derived_DC
		-- -----------------------

		IF OBJECT_ID('tDCpdb..#CodeGroup_POD_Derived_DC') IS NOT NULL
			DROP TABLE #CodeGroup_POD_Derived_DC;

		CREATE TABLE #CodeGroup_POD_Derived_DC
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_POD_Derived_DC
		(
			Code
		)
		VALUES
		('DC');

		-- -----------------------
		-- Code Group: TRETSPEF_341
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_TRETSPEF_341') IS NOT NULL
			DROP TABLE #CodeGroup_TRETSPEF_341;

		CREATE TABLE #CodeGroup_TRETSPEF_341
		(
			Code VARCHAR(10) PRIMARY KEY
		);

		INSERT INTO #CodeGroup_TRETSPEF_341
		(
			Code
		)
		VALUES
		('341');

		-- -----------------------
		-- Code Group: OrdinaryDC_Adms
		-- -----------------------

		IF OBJECT_ID('tempdb..#CodeGroup_OrdinaryDC_Adms') IS NOT NULL
			DROP TABLE #CodeGroup_OrdinaryDC_Adms;

		CREATE TABLE #CodeGroup_OrdinaryDC_Adms
		(
			Code VARCHAR(10)
		);

		INSERT INTO #CodeGroup_OrdinaryDC_Adms
		(
			Code
		)
		VALUES
		('1'), 
		('2');

-- ========================================
-- Step 4: Create and Populate #Spells_With_Variables Table for Respiratory Medicine
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
		Discharge_Treatment_Function_Code VARCHAR(10),
		SpellDominantProcedure_Current VARCHAR(50),
		Diagnosis_Code_Primary VARCHAR(10),
		SpellHRG_Current VARCHAR(50),
		Patient_Classification_Code INT,
		SpellCCDays INT,

		-- Additional Variables for Metrics (Respiratory Medicine)

		-- Specialty and HRG
		RespM_SpecialtyEM VARCHAR(100),
		RespM_HRG VARCHAR(100),

		-- Pulmonary Embolism Variables
		RespM_PulmonaryEmbolism VARCHAR(100),

		-- Asthma Emergency Variables
		RespM_AsthmaEM VARCHAR(100),
		RespM_AsthmaEM_CC VARCHAR(100),

		-- COPD Variables
		RespM_COPDEM VARCHAR(100),
		RespM_COPDEM_ITU VARCHAR(100),
		RespM_COPDEM_NIV VARCHAR(100),

		-- Pneumonia Emergency Variables
		RespM_PneumoniaEM VARCHAR(100),
		RespM_PneumoniaEM_CC VARCHAR(100),

		-- Age Groups
		RespM_AgeGroup1 VARCHAR(100),
		RespM_AgeGroup2 VARCHAR(100),

		-- Pneumothorax Emergency Variables
		RespM_PneumothoraxEM VARCHAR(100),

		-- Pleural Effusion Variables
		RespM_PleuralEffusion VARCHAR(100),
		RespM_PleuralEffusion_CC VARCHAR(100),

		-- Bronchiectasis Variables
		RespM_Bronchiectasis VARCHAR(100),

		-- CPAP Variables
		RespM_DC_CPAP VARCHAR(100),

		-- Pleural Effusion BPT
		RespM_PleuralEffusion_BPT VARCHAR(100),

		-- Asthma I Variables
		RespM_Asthma_I VARCHAR(100),

		-- Outpatient-Related Variables (Excluded from Inpatient Table)

		-- Flags and Outcomes
		Read30 VARCHAR(100),
		Read90 VARCHAR(100),
		RespM_FLAG_AsthmaFollowUp INT

	-- Add other inpatient variables as needed
	);

	-- **4.2: Populate the #Spells_With_Variables Table with Initial Data for Respiratory Medicine**

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
		Discharge_Treatment_Function_Code,
		SpellDominantProcedure_Current,
		Diagnosis_Code_Primary,
		SpellHRG_Current,
		Patient_Classification_Code,
		SpellCCDays
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
		   ips.Discharge_Treatment_Function_Code,
		   ips.Spell_Dominant_Procedure_Code AS SpellDominantProcedure_Current,
		   ips.Spell_Primary_Diagnosis_Code AS Diagnosis_Code_Primary,
		   ips.Spell_HRG_Code AS SpellHRG_Current,
		   ips.Patient_Classification_Code,
		   ips.Spell_CC_Days AS SpellCCDays
	FROM [PAS_IP_Spell_Frozen] ips
		LEFT JOIN [PAS_IP_Episode_Frozen] ipe
			ON ips.Spell_Number = ipe.Spell_Number
			   AND ips.Sector = ipe.Sector
	WHERE ips.Admission_Date
		  BETWEEN @OverallStartDate AND @OverallEndDate
		  AND ips.Org_Code_Provider = 'RPA'
		  AND ips.Sector = 'MED';

	-- **4.3: Create and Populate #OP_Spells_With_Variables Table for Respiratory Medicine**

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
		Attend_HRG VARCHAR(50),

		-- Additional Variables for Metrics (Respiratory Medicine)

		-- Specialty and HRG
		RespM_SpecialtyEM VARCHAR(100),
		RespM_HRG VARCHAR(100),

		-- Pulmonary Embolism Variables
		RespM_PulmonaryEmbolism VARCHAR(100),

		-- Asthma Emergency Variables
		RespM_AsthmaEM VARCHAR(100),
		RespM_AsthmaEM_CC VARCHAR(100),

		-- COPD Variables
		RespM_COPDEM VARCHAR(100),
		RespM_COPDEM_ITU VARCHAR(100),
		RespM_COPDEM_NIV VARCHAR(100),

		-- Pneumonia Emergency Variables
		RespM_PneumoniaEM VARCHAR(100),
		RespM_PneumoniaEM_CC VARCHAR(100),

		-- Age Groups
		RespM_AgeGroup1 VARCHAR(100),
		RespM_AgeGroup2 VARCHAR(100),

		-- Pneumothorax Emergency Variables
		RespM_PneumothoraxEM VARCHAR(100),

		-- Pleural Effusion Variables
		RespM_PleuralEffusion VARCHAR(100),
		RespM_PleuralEffusion_CC VARCHAR(100),

		-- Bronchiectasis Variables
		RespM_Bronchiectasis VARCHAR(100),

		-- CPAP Variables
		RespM_DC_CPAP VARCHAR(100),

		-- Pleural Effusion BPT
		RespM_PleuralEffusion_BPT VARCHAR(100),

		-- Asthma I Variables
		RespM_Asthma_I VARCHAR(100),

		-- Outpatient Procedures and Flags
		RespM_OP VARCHAR(100),
		RespM_OP_Face VARCHAR(100),
		RespM_OP_Type VARCHAR(100),
		RespM_OP_DNA VARCHAR(100),
		RespM_OP_Outcome VARCHAR(100),
		RespM_OP_CPAP VARCHAR(100),
		RespM_OP_SMS VARCHAR(100),
		RespM_OP_Polysomnography_Lim VARCHAR(100),
		RespM_OP_Polysomnography_Full VARCHAR(100)
	-- Add other outpatient variables as needed
	);

	-- **4.3: Populate the #OP_Spells_With_Variables Table with Initial Data for Respiratory Medicine**

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
		Attendance_Status_Code,
		Attend_HRG
	)
	SELECT ope.OP_Attendance_ID,
		   ope.Sector,
		   ope.PAS_Number,
		   ope.NHS_Number,
		   ope.Appointment_Date,
		   ope.Age_At_Appointment AS Age,
		   ope.Main_Specialty_Code AS MAINSPEF,
		   ope.Treatment_Function_Code AS TRETSPEF,
		   ope.Consultation_Type_Code,
		   ope.Clinic_Code,
		   ope.Attendance_Status_Code,
		   ope.HRG_Code AS Attend_HRG
	FROM PAS_OP_Appointment_Frozen ope
	WHERE ope.Appointment_Date
		  BETWEEN @OPStartDate AND @OPEndDate
		  AND ope.Org_Code_Provider = 'RPA'
		  AND ope.Sector = 'MED';

-- ========================================
-- Step 5: Update Statements for Respiratory Medicine (Inpatients)
-- ========================================

	-- Update RespM_SpecialtyEM based on priorities
	UPDATE swv
	SET RespM_SpecialtyEM = CASE
		-- Priority 1: 'Respiratory Medicine'
		WHEN (swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_340)
			or swv.Discharge_Treatment_Function_Code IN (SELECT Code FROM #CodeGroup_TRETSPEF_340))
			 AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
		THEN 'Respiratory Medicine'
		ELSE 'Other'
	END
	FROM #Spells_With_Variables swv;

	-- Update RespM_HRG to 'Respiratory Medicine'
	UPDATE swv
	SET RespM_HRG = 'Respiratory Medicine'
	FROM #Spells_With_Variables swv
	WHERE LEFT(swv.SpellHRG_Current, 2)IN
		  (
			  SELECT Code FROM #CodeGroup_RespiratoryMedicine_2
		  );

	UPDATE swv
	SET RespM_PulmonaryEmbolism = CASE
    -- Priority 1: 'With Intervention'
    WHEN LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PulmEmbolismICD_4)
         AND LEFT(swv.SpellHRG_Current, 5) IN (SELECT Code FROM #CodeGroup_PulmEmbolismWithInterv_5)
		 AND ipd.Coded_Clinical_Entry_Seq BETWEEN 1 AND 3
    THEN 'With Intervention'
    
    -- Priority 2: 'Without Int, CC 0-2'
    WHEN LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PulmEmbolismICD_4)
         AND LEFT(ipe.HRG_Code, 5) IN (SELECT Code FROM #CodeGroup_PulmEmbolismWOInterv02_5)
		 AND ipd.Coded_Clinical_Entry_Seq BETWEEN 1 AND 3
    THEN 'Without Int, CC 0-2'
    
    -- Priority 3: 'Without Int, CC 3-8'
    WHEN LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PulmEmbolismICD_4)
         AND LEFT(ipe.HRG_Code, 5) IN (SELECT Code FROM #CodeGroup_PulmEmbolismWOInterv38_5)
		 AND ipd.Coded_Clinical_Entry_Seq BETWEEN 1 AND 3
    THEN 'Without Int, CC 3-8'
    
    -- Priority 4: 'Without Int, CC 9+'
    WHEN LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PulmEmbolismICD_4)
         AND LEFT(ipe.HRG_Code, 5) IN (SELECT Code FROM #CodeGroup_PulmEmbolismWOInterv9_5)
		 AND ipd.Coded_Clinical_Entry_Seq BETWEEN 1 AND 3
    THEN 'Without Int, CC 9+'
    
    -- Retain existing value if none of the conditions are met
    ELSE swv.RespM_PulmonaryEmbolism
	END
	FROM #Spells_With_Variables swv
	INNER JOIN [PAS_IP_Episode_Frozen] ipe
		ON swv.Spell_Number = ipe.Spell_Number
		   AND swv.Sector = ipe.Sector
	INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
		ON ipd.Episode_Number = ipe.Episode_Number
		   AND ipd.Sector = ipe.Sector ;


	UPDATE swv
	SET RespM_AsthmaEM = CASE
		-- Priority 1: 'General Medicine'
		WHEN LEFT(swv.Diagnosis_Code_Primary, 3) IN (SELECT Code FROM #CodeGroup_Asthma_3)
			 AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_300)
			 AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
		THEN 'General Medicine'
		-- Priority 2: 'Respiratory Medicine'
		WHEN swv.RespM_AsthmaEM IS NULL
			 AND LEFT(swv.Diagnosis_Code_Primary, 3) IN (SELECT Code FROM #CodeGroup_Asthma_3)
			 AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_340)
			 AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
		THEN 'Respiratory Medicine'
		-- Priority 3: 'Other Specialties'
		WHEN swv.RespM_AsthmaEM IS NULL
			 AND LEFT(swv.Diagnosis_Code_Primary, 3) IN (SELECT Code FROM #CodeGroup_Asthma_3)
			 AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_EmergSpecs)
			 AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
		THEN 'Other Specialties'
		ELSE swv.RespM_AsthmaEM
	END
	FROM #Spells_With_Variables swv
	INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
		ON swv.Episode_Number = ipd.Episode_Number
		AND swv.Sector = ipd.Sector;

	-- Update RespM_AsthmaEM_CC to 'Critical Care Admissions'
	UPDATE swv
	SET RespM_AsthmaEM_CC = 'Critical Care Admissions'
	FROM #Spells_With_Variables swv
		INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
			ON swv.Episode_Number = ipd.Episode_Number
			   AND swv.Sector = ipd.Sector
	WHERE LEFT(swv.Diagnosis_Code_Primary, 3)IN
		  (
			  SELECT Code FROM #CodeGroup_Asthma_3
		  )
		  AND swv.TRETSPEF IN
			  (
				  SELECT Code FROM #CodeGroup_EmergSpecs
			  )
		  AND swv.POD_Derived IN
			  (
				  SELECT Code FROM #CodeGroup_POD_Derived_EM
			  )
	
		  AND swv.SpellCCDays >= 1;

	-- Merged Update of RespM_COPDEM with Priorities
	UPDATE swv
	SET RespM_COPDEM = CASE
    -- Priority 1: 'Respiratory Medicine'
    WHEN LEFT(swv.Diagnosis_Code_Primary, 4) IN (SELECT Code FROM #CodeGroup_COPD_ICD_4)
         AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_340)
         AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
    THEN 'Respiratory Medicine'
    
    -- Priority 2: 'General Medicine'
    WHEN swv.RespM_COPDEM IS NULL
         AND LEFT(swv.Diagnosis_Code_Primary, 4) IN (SELECT Code FROM #CodeGroup_COPD_ICD_4)
         AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_300)
         AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
    THEN 'General Medicine'
    
    -- Priority 3: 'Care of the Elderly'
    WHEN swv.RespM_COPDEM IS NULL
         AND LEFT(swv.Diagnosis_Code_Primary, 4) IN (SELECT Code FROM #CodeGroup_COPD_ICD_4)
         AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_430)
         AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
    THEN 'Care of the Elderly'
    
    -- Priority 4: 'Other Specialities'
    WHEN swv.RespM_COPDEM IS NULL
         AND LEFT(swv.Diagnosis_Code_Primary, 4) IN (SELECT Code FROM #CodeGroup_COPD_ICD_4)
         AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_EmergSpecs)
         AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
    THEN 'Other Specialities'
    
    -- Retain existing value if none of the conditions are met
    ELSE swv.RespM_COPDEM
	END
	FROM #Spells_With_Variables swv
	-- Include the join if necessary
	LEFT JOIN [PAS_IP_Diagnosis_Normalised] ipd
		ON swv.Episode_Number = ipd.Episode_Number
		   AND swv.Sector = ipd.Sector;

	-- Update RespM_COPDEM_ITU to 'Critical Care Admissions'
	UPDATE swv
	SET RespM_COPDEM_ITU = 'Critical Care Admissions'
	FROM #Spells_With_Variables swv
		INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
			ON swv.Episode_Number = ipd.Episode_Number
			   AND swv.Sector = ipd.Sector
	WHERE LEFT(swv.Diagnosis_Code_Primary, 4)IN
		  (
			  SELECT Code FROM #CodeGroup_COPD_ICD_4
		  )
		  AND swv.TRETSPEF IN
			  (
				  SELECT Code FROM #CodeGroup_EmergSpecs
			  )
		
		  AND swv.POD_Derived IN
			  (
				  SELECT Code FROM #CodeGroup_POD_Derived_EM
			  )
		  AND swv.SpellCCDays >= 1;

	-- Update RespM_COPDEM_NIV to 'With NIV' (Priority 1)
	UPDATE swv
	SET RespM_COPDEM_NIV = CASE
		-- Priority 1: 'With NIV'
		WHEN LEFT(swv.Diagnosis_Code_Primary, 4) IN (SELECT Code FROM #CodeGroup_COPD_ICD_4)
			 AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_EmergSpecs)
			 AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
			 AND EXISTS (
				 SELECT 1
				 FROM [PAS_IP_Procedure_Normalised] ipp
				 WHERE ipp.Episode_Number = swv.Episode_Number
					   AND ipp.Sector = swv.Sector
					   AND LEFT(ipp.Procedure_Code, 4) IN (SELECT Code FROM #CodeGroup_COPDNIV_4)
			 )
		THEN 'With NIV'
		-- Priority 2: 'Without NIV'
		WHEN swv.RespM_COPDEM_NIV IS NULL
			 AND LEFT(swv.Diagnosis_Code_Primary, 4) IN (SELECT Code FROM #CodeGroup_COPD_ICD_4)
			 AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_EmergSpecs)
			 AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
		THEN 'Without NIV'
		ELSE swv.RespM_COPDEM_NIV
	END
	FROM #Spells_With_Variables swv
	INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
		ON swv.Episode_Number = ipd.Episode_Number
		AND swv.Sector = ipd.Sector;

	-- Create a temp table with all pneumonia diagnosis codes
	IF OBJECT_ID('tempdb..#PneumoniaCodes') IS NOT NULL
		DROP TABLE #PneumoniaCodes;

	SELECT Code
	INTO #PneumoniaCodes
	FROM #CodeGroup_PneumoniaBroncho_4
	UNION
	SELECT Code
	FROM #CodeGroup_PneumoniaLobar_4
	UNION
	SELECT Code
	FROM #CodeGroup_PneumoniaInfluenza_4
	UNION
	SELECT Code
	FROM #CodeGroup_PneumoniaUnspecified_4
	UNION
	SELECT Code
	FROM #CodeGroup_PneumoniaOther_4
	UNION
	SELECT Code
	FROM #CodeGroup_PneumoniaPneumococcal_3
	UNION
	SELECT Code
	FROM #CodeGroup_PneumoniaOther_3;

	-- Update RespM_PneumoniaEM to 'Respiratory Medicine' (Priority 1)
	UPDATE swv
	SET RespM_PneumoniaEM = CASE
		-- Priority 1: 'Respiratory Medicine'
		WHEN
			(
				LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaBroncho_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaLobar_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaInfluenza_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaUnspecified_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaOther_4)
				OR LEFT(ipd.Diagnosis_Code, 3) IN (SELECT Code FROM #CodeGroup_PneumoniaPneumococcal_3)
				OR LEFT(ipd.Diagnosis_Code, 3) IN (SELECT Code FROM #CodeGroup_PneumoniaOther_3)
			)
			AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_340)
			AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
		THEN 'Respiratory Medicine'

		-- Priority 2: 'General Medicine'
		WHEN swv.RespM_PneumoniaEM IS NULL
			AND (
				LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaBroncho_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaLobar_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaInfluenza_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaUnspecified_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaOther_4)
				OR LEFT(ipd.Diagnosis_Code, 3) IN (SELECT Code FROM #CodeGroup_PneumoniaPneumococcal_3)
				OR LEFT(ipd.Diagnosis_Code, 3) IN (SELECT Code FROM #CodeGroup_PneumoniaOther_3)
			)
			AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_300)
			AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
		THEN 'General Medicine'

		-- Priority 3: 'Care of the Elderly'
		WHEN swv.RespM_PneumoniaEM IS NULL
			AND (
				LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaBroncho_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaLobar_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaInfluenza_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaUnspecified_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaOther_4)
				OR LEFT(ipd.Diagnosis_Code, 3) IN (SELECT Code FROM #CodeGroup_PneumoniaPneumococcal_3)
				OR LEFT(ipd.Diagnosis_Code, 3) IN (SELECT Code FROM #CodeGroup_PneumoniaOther_3)
			)
			AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_430)
			AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
		THEN 'Care of the Elderly'

		-- Priority 4: 'Other Specialties'
		WHEN swv.RespM_PneumoniaEM IS NULL
			AND (
				LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaBroncho_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaLobar_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaInfluenza_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaUnspecified_4)
				OR LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_PneumoniaOther_4)
				OR LEFT(ipd.Diagnosis_Code, 3) IN (SELECT Code FROM #CodeGroup_PneumoniaPneumococcal_3)
				OR LEFT(ipd.Diagnosis_Code, 3) IN (SELECT Code FROM #CodeGroup_PneumoniaOther_3)
			)
			AND swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_EmergSpecs)
			AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM)
		THEN 'Other Specialties'

		ELSE swv.RespM_PneumoniaEM -- Retain existing value if none of the conditions are met
	END
	FROM #Spells_With_Variables swv
	INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
		ON swv.Episode_Number = ipd.Episode_Number
		AND swv.Sector = ipd.Sector;

	-- Update RespM_PneumoniaEM_CC to 'Critical Care Admissions'
	UPDATE swv
	SET RespM_PneumoniaEM_CC = 'Critical Care Admissions'
	FROM #Spells_With_Variables swv
		INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
			ON swv.Episode_Number = ipd.Episode_Number
			   AND swv.Sector = ipd.Sector
	WHERE (
			  LEFT(ipd.Diagnosis_Code, 4)IN
			  (
				  SELECT Code FROM #PneumoniaCodes
			  )
			  OR LEFT(ipd.Diagnosis_Code, 3)IN
				 (
					 SELECT Code FROM #PneumoniaCodes
				 )
		  )
		  AND swv.TRETSPEF IN
			  (
				  SELECT Code FROM #CodeGroup_EmergSpecs
			  )
		  AND swv.POD_Derived IN
			  (
				  SELECT Code FROM #CodeGroup_POD_Derived_EM
			  )
		  AND swv.SpellCCDays >= 1;

	-- Update RespM_AgeGroup1 based on Age ranges
	UPDATE swv
	SET RespM_AgeGroup1 = CASE
							  WHEN swv.Age
								   BETWEEN 18 AND 40 THEN
								  'Age18-40'
							  WHEN swv.Age
								   BETWEEN 41 AND 65 THEN
								  'Age41-65'
							  WHEN swv.Age
								   BETWEEN 66 AND 80 THEN
								  'Age66-80'
							  WHEN swv.Age >= 81 THEN
								  'Age80+'
							  ELSE
								  NULL
						  END
	FROM #Spells_With_Variables swv;

	-- Update RespM_AgeGroup2 based on Age ranges
	UPDATE swv
	SET RespM_AgeGroup2 = 'Age41-75'
	FROM #Spells_With_Variables swv
	WHERE swv.Age
	BETWEEN 41 AND 75;

	-- Update RespM_PneumothoraxEM
	UPDATE swv
	SET RespM_PneumothoraxEM = CASE
		-- Priority 1: 'Respiratory Medicine'
		WHEN (swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_340)
		OR Discharge_Treatment_Function_Code IN (SELECT Code FROM #CodeGroup_TRETSPEF_340))
		THEN 'Respiratory Medicine'
		-- Priority 2: 'Other Specialties'
		WHEN swv.RespM_PneumothoraxEM IS NULL THEN 'Other Specialties'
		ELSE swv.RespM_PneumothoraxEM
	END
	FROM #Spells_With_Variables swv
	INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
		ON swv.Episode_Number = ipd.Episode_Number
		AND swv.Sector = ipd.Sector
	WHERE LEFT(ipd.Diagnosis_Code, 4) IN (SELECT Code FROM #CodeGroup_Pneumothorax_4)
		AND swv.POD_Derived IN (SELECT Code FROM #CodeGroup_POD_Derived_EM);

	-- Update RespM_PleuralEffusion 
	UPDATE swv
	SET RespM_PleuralEffusion = CASE
		-- Priority 1: 'General or Acute Medicine'
		WHEN (swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_300)
			 OR swv.TRETSPEF IN (SELECT Code FROM #CodeGroup_TRETSPEF_326))
		THEN 'General or Acute Medicine'
		-- Priority 2: 'Other Specialities'
		WHEN swv.RespM_PleuralEffusion IS NULL THEN 'Other'
		ELSE swv.RespM_PleuralEffusion
	END
	FROM #Spells_With_Variables swv
	WHERE (
		LEFT(swv.SpellHRG_Current, 4) IN (SELECT Code FROM #CodeGroup_PleuralDisease_4)
		OR LEFT(swv.SpellHRG_Current, 5) IN (SELECT Code FROM #CodeGroup_PleuralDisease_5)
	);

	-- Update RespM_PleuralEffusion_CC
	UPDATE swv
	SET RespM_PleuralEffusion_CC = CASE
		-- Priority 1: 'Multiple Int, CC 11+'
		WHEN LEFT(swv.SpellHRG_Current, 5) IN (SELECT Code FROM #CodeGroup_PleuralDiseaseMultInterv_5)
		THEN 'Multiple Int, CC 11+'
		-- Priority 2: 'Single Int, CC 6-10'
		WHEN swv.RespM_PleuralEffusion_CC IS NULL
			 AND LEFT(swv.SpellHRG_Current, 5) IN (SELECT Code FROM #CodeGroup_PleuralDiseaseSingInterv_5)
		THEN 'Single Int, CC 6-10'
		-- Priority 3: 'No Int, CC 0-5'
		WHEN swv.RespM_PleuralEffusion_CC IS NULL
			 AND LEFT(swv.SpellHRG_Current, 5) IN (SELECT Code FROM #CodeGroup_PleuralDiseaseWOInterv_5)
		THEN 'No Int, CC 0-5'
		ELSE swv.RespM_PleuralEffusion_CC
	END
	FROM #Spells_With_Variables swv;

	-- Update RespM_Bronchiectasis to 'All'
	UPDATE swv
	SET RespM_Bronchiectasis = 'All'
	FROM #Spells_With_Variables swv
		INNER JOIN [PAS_IP_Diagnosis_Normalised] ipd
			ON swv.Episode_Number = ipd.Episode_Number
			   AND swv.Sector = ipd.Sector
	WHERE LEFT(Diagnosis_Code_Primary, 3)IN
		  (
			  SELECT Code FROM #CodeGroup_Bronchiectasis_3
		  );

	-- Update RespM_DC_CPAP to 'CPAP'
	UPDATE swv
	SET RespM_DC_CPAP = 'CPAP'
	FROM #Spells_With_Variables swv
		INNER JOIN [PAS_IP_Procedure_Normalised] ipp
			ON swv.Episode_Number = ipp.Episode_Number
			   AND swv.Sector = ipp.Sector
	WHERE (
			  swv.TRETSPEF IN
			  (
				  SELECT Code FROM #CodeGroup_TRETSPEF_340
			  )
			  OR swv.TRETSPEF IN
				 (
					 SELECT Code FROM #CodeGroup_TRETSPEF_347
				 )
		  )
		  AND LEFT(ipp.Procedure_Code, 4)IN
			  (
				  SELECT Code FROM #CodeGroup_CPAP_4
			  )
		  AND swv.POD_Derived IN
			  (
				  SELECT Code FROM #CodeGroup_POD_Derived_DC
			  );

	-- Update RespM_PleuralEffusion_BPT to 'Best Practice Tariff'
	UPDATE swv
	SET RespM_PleuralEffusion_BPT = 'Best Practice Tariff'
	FROM #Spells_With_Variables swv
	WHERE LEFT(swv.SpellHRG_Current, 5)IN
		  (
			  SELECT Code FROM #CodeGroup_PleuralDiseaseBPT_5
		  );

	-- Update RespM_Asthma_I to 'Immunotherapy'
	UPDATE swv
	SET RespM_Asthma_I = 'Immunotherapy'
	FROM #Spells_With_Variables swv
	WHERE LEFT(swv.Diagnosis_Code_Primary, 3)IN
		  (
			  SELECT Code FROM #CodeGroup_Asthma_3
		  )
		  AND LEFT(swv.SpellDominantProcedure_Current, 4)IN
			  (
				  SELECT Code FROM #CodeGroup_Immunotherapy_4
			  )
		  AND swv.TRETSPEF IN
			  (
				  SELECT Code FROM #CodeGroup_TRETSPEF_340
			  )
		  AND swv.POD_Derived IN
			  (
				  SELECT Code FROM #CodeGroup_POD_Derived_DC
			  )
		  OR swv.POD_Derived IN
			 (
				 SELECT Code FROM #CodeGroup_POD_Derived_EL
			 )
		  OR swv.POD_Derived IN
			 (
				 SELECT Code FROM #CodeGroup_POD_Derived_RA
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

	-- Update RespM_FLAG_AsthmaFollowUp
	UPDATE swv
	SET RespM_FLAG_AsthmaFollowUp = 1
	FROM #Spells_With_Variables swv
	INNER JOIN #OP_Spells_With_Variables opw
		ON swv.PAS_Number = opw.PAS_Number and swv.Sector = opw.Sector
	WHERE swv.RespM_AsthmaEM NOT LIKE 'Other%'
	  AND opw.Appointment_Date BETWEEN DATEADD(DAY, 1, swv.Discharge_Date) AND DATEADD(DAY, 14, swv.Discharge_Date)
	  AND opw.RespM_OP_Face IS NOT NULL
	  AND opw.RespM_OP_Type = 'Follow-up';

-- ========================================
-- Step 5.2: Update Statements for Respiratory Medicine (Outpatients)
-- ========================================

	-- Update RespM_OP to 'All'
	UPDATE opw
	SET RespM_OP = 'All'
	FROM #OP_Spells_With_Variables opw
	INNER JOIN [M0010_OP_Appointment] m0010
		ON opw.Sector = m0010.Sector
		   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
	WHERE (
			  opw.TRETSPEF IN
			  (
				  SELECT Code FROM #CodeGroup_TRETSPEF_340
			  )
			  OR opw.TRETSPEF IN
				 (
					 SELECT Code FROM #CodeGroup_TRETSPEF_341
				 )
		  )
		  --AND LEFT(opw.Attend_HRG, 2) IN
			--  (
				--  SELECT Code FROM #CodeGroup_WF_2
			  --);

	-- Update RespM_OP_Face to 'Face2Face'
	UPDATE opw
	SET RespM_OP_Face = 'Face2Face'
	FROM #OP_Spells_With_Variables opw
		INNER JOIN [M0010_OP_Appointment] m0010
			ON opw.Sector = m0010.Sector
			   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
	WHERE m0010.M0010r_Face_To_Face_Booking = 1;

	-- Update RespM_OP_Face to 'Virtual'
	UPDATE opw
	SET RespM_OP_Face = 'Virtual'
	FROM #OP_Spells_With_Variables opw
		INNER JOIN [M0010_OP_Appointment] m0010
			ON opw.Sector = m0010.Sector
			   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
	WHERE m0010.M0010l_Virtual_Booking = 1
		  AND opw.RespM_OP_Face IS NULL;

	-- Update RespM_OP_Type based on appointment type
	UPDATE opw
	SET RespM_OP_Type = CASE
		-- If it's a new appointment, set to 'First'
		WHEN m0010.M0010n_New_Appointment = 1 THEN 'First'
		-- If it's a follow-up appointment and RespM_OP_Type is NULL, set to 'Follow-up'
		WHEN m0010.M0010o_Follow_Up_Appointment = 1 AND opw.RespM_OP_Type IS NULL THEN 'Follow-up'
		-- Otherwise, retain existing value
		ELSE opw.RespM_OP_Type
	END
	FROM #OP_Spells_With_Variables opw
	INNER JOIN [M0010_OP_Appointment] m0010
		ON opw.Sector = m0010.Sector
		   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID;

	-- Update RespM_OP_DNA to 'DNA'
	UPDATE opw
	SET RespM_OP_DNA = 'DNA'
	FROM #OP_Spells_With_Variables opw
		INNER JOIN [M0010_OP_Appointment] m0010
			ON opw.Sector = m0010.Sector
			   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
	WHERE m0010.M0010b_DNA = 1;

	-- Update RespM_OP_Outcome to 'Discharged'
	UPDATE opw
	SET RespM_OP_Outcome = 'Discharged'
	FROM #OP_Spells_With_Variables opw
		INNER JOIN [M0010_OP_Appointment] m0010
			ON opw.Sector = m0010.Sector
			   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
	WHERE m0010.M0010u_New_Appointment_Discharged = 1;

	-- Update RespM_OP_CPAP to 'CPAP'
	UPDATE opw
	SET RespM_OP_CPAP = 'CPAP'
	FROM #OP_Spells_With_Variables opw
		INNER JOIN [M0010_OP_Appointment] m0010
			ON opw.Sector = m0010.Sector
			   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
		INNER JOIN [PAS_OP_Procedure_Normalised] opp
			ON opw.OP_Attendance_ID = opp.OP_Attendance_ID
	WHERE (
			  m0010.Treatment_Function_Code IN
			  (
				  SELECT Code FROM #CodeGroup_TRETSPEF_340
			  )
			  OR m0010.Treatment_Function_Code IN
				 (
					 SELECT Code FROM #CodeGroup_TRETSPEF_347
				 )
		  )
		  AND LEFT(opp.Procedure_Code, 4)IN
			  (
				  SELECT Code FROM #CodeGroup_CPAP_4
			  );

	-- Update RespM_OP_SMS to 'First'
	UPDATE opw
	SET RespM_OP_SMS = 'First'
	FROM #OP_Spells_With_Variables opw
		INNER JOIN [M0010_OP_Appointment] m0010
			ON opw.Sector = m0010.Sector
			   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
	WHERE m0010.Treatment_Function_Code IN
		  (
			  SELECT Code FROM #CodeGroup_TRETSPEF_347
		  )
		  AND m0010.M0010n_New_Appointment = 1;

	-- Update RespM_OP_SMS to 'Follow-up'
	UPDATE opw
	SET RespM_OP_SMS = 'Follow-up'
	FROM #OP_Spells_With_Variables opw
		INNER JOIN [M0010_OP_Appointment] m0010
			ON opw.Sector = m0010.Sector
			   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
	WHERE m0010.Treatment_Function_Code IN
		  (
			  SELECT Code FROM #CodeGroup_TRETSPEF_347
		  )
		  AND m0010.M0010o_Follow_Up_Appointment = 1
		  AND opw.RespM_OP_SMS IS NULL;

	-- Update RespM_OP_Polysomnography_Lim to 'Limited'
	UPDATE opw
	SET RespM_OP_Polysomnography_Lim = 'Limited'
	FROM #OP_Spells_With_Variables opw
		INNER JOIN [M0010_OP_Appointment] m0010
			ON opw.Sector = m0010.Sector
			   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
		INNER JOIN [PAS_OP_Procedure_Normalised] opp
			ON opw.OP_Attendance_ID = opp.OP_Attendance_ID
	WHERE (
			  m0010.Treatment_Function_Code IN
			  (
				  SELECT Code FROM #CodeGroup_TRETSPEF_340
			  )
			  OR m0010.Treatment_Function_Code IN
				 (
					 SELECT Code FROM #CodeGroup_TRETSPEF_347
				 )
		  )
		  AND LEFT(opp.Procedure_Code, 4)IN
			  (
				  SELECT Code FROM #CodeGroup_LimPolysomnography_4
			  );

	-- Update RespM_OP_Polysomnography_Full to 'Full'
	UPDATE opw
	SET RespM_OP_Polysomnography_Full = 'Full'
	FROM #OP_Spells_With_Variables opw
		INNER JOIN [M0010_OP_Appointment] m0010
			ON opw.Sector = m0010.Sector
			   AND opw.OP_Attendance_ID = m0010.OP_Attendance_ID
		INNER JOIN [PAS_OP_Procedure_Normalised] opp
			ON opw.OP_Attendance_ID = opp.OP_Attendance_ID
	WHERE (
			  m0010.Treatment_Function_Code IN
			  (
				  SELECT Code FROM #CodeGroup_TRETSPEF_340
			  )
			  OR m0010.Treatment_Function_Code IN
				 (
					 SELECT Code FROM #CodeGroup_TRETSPEF_347
				 )
		  )
		  AND LEFT(opp.Procedure_Code, 4)IN
			  (
				  SELECT Code FROM #CodeGroup_FullPolysomnography_4
			  );




-- ========================================
-- Step 6: Calculate Metrics
-- ========================================

/* Respiratory emergency admissions mean length of stay - days 
Model Hospital ID: RI7100

Sum(Spell_LOS)
RespM_SpecialtyEM <> 'Other'

Count(Spells)
RespM_SpecialtyEM <> 'Other'

*/

-- Define the start and end dates for Metric RI7100
DECLARE @RI7100_StartDate DATE = '2023-07-01';
DECLARE @RI7100_EndDate DATE = '2024-06-30';

-- Numerator: Sum of Spell_LOS per unique Spell_Number
DECLARE @RI7100_Total_LOS INT;

SELECT @RI7100_Total_LOS = SUM(Spell_LOS)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS
    FROM #Spells_With_Variables
    WHERE RespM_SpecialtyEM <> 'Other'
          AND Admission_Date BETWEEN @RI7100_StartDate AND @RI7100_EndDate
    GROUP BY Spell_Number
) AS Unique_Spells;

-- Denominator: Count of Spells
DECLARE @RI7100_Total_Spells INT;

SELECT @RI7100_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_SpecialtyEM <> 'Other'
      AND Admission_Date BETWEEN @RI7100_StartDate AND @RI7100_EndDate;

-- Calculate Mean Length of Stay
DECLARE @RI7100_Mean_LOS FLOAT;

SET @RI7100_Mean_LOS = CAST(@RI7100_Total_LOS AS FLOAT) / NULLIF(@RI7100_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7100 - Respiratory Emergency Admissions Mean Length of Stay' AS Metric,
       @RI7100_Mean_LOS AS Mean_LOS,
       @RI7100_Total_LOS AS Total_LOS,
       @RI7100_Total_Spells AS Total_Spells;

/* HRG chapter DZ (Respiratory System) admissions mean length of stay - days 
Model Hospital ID: RI7101

Sum(Spell_LOS)
RespM_HRG <> 'Other'

Count(Spells)
RespM_HRG <> 'Other'

*/

-- Define the start and end dates for Metric RI7101
DECLARE @RI7101_StartDate DATE = '2023-07-01';
DECLARE @RI7101_EndDate DATE = '2024-06-30';

-- Numerator: Sum of Spell_LOS per unique Spell_Number
DECLARE @RI7101_Total_LOS INT;

SELECT @RI7101_Total_LOS = SUM(Spell_LOS)
FROM (
    SELECT Spell_Number, Spell_LOS
    FROM #Spells_With_Variables
    WHERE RespM_HRG <> 'Other'
          AND Admission_Date BETWEEN @RI7101_StartDate AND @RI7101_EndDate
) AS Unique_Spells;

-- Denominator: Count of unique Spell_Number
DECLARE @RI7101_Total_Spells INT;

SELECT @RI7101_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_HRG <> 'Other'
      AND Admission_Date BETWEEN @RI7101_StartDate AND @RI7101_EndDate;

-- Calculate Mean Length of Stay
DECLARE @RI7101_Mean_LOS FLOAT;

SET @RI7101_Mean_LOS = CAST(@RI7101_Total_LOS AS FLOAT) / NULLIF(@RI7101_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7101 - HRG Chapter DZ Admissions Mean Length of Stay' AS Metric,
       @RI7101_Mean_LOS AS Mean_LOS,
       @RI7101_Total_LOS AS Total_LOS,
       @RI7101_Total_Spells AS Total_Spells;

/* Percentage of patients with chapter DZ (Respiratory system) HRG coded to the specialty of Respiratory Medicine 
Model Hospital ID: RI7102

Count(Spells)
RespM_HRG <> 'Other' 
AND RespM_SpecialtyEM = 'Respiratory Medicine'

Count(Spells)
RespM_HRG <> 'Other'

*/

-- Define the start and end dates for Metric RI7102
DECLARE @RI7102_StartDate DATE = '2023-07-01';
DECLARE @RI7102_EndDate DATE = '2024-06-30';

-- Numerator: Count of Spells where Respiratory Medicine is the specialty
DECLARE @RI7102_Numerator INT;

SELECT @RI7102_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_HRG <> 'Other'
      AND RespM_SpecialtyEM = 'Respiratory Medicine'
      AND Admission_Date >= @RI7102_StartDate
      AND Admission_Date <= @RI7102_EndDate;

-- Denominator: Count of Spells where RespM_HRG <> 'Other'
DECLARE @RI7102_Denominator INT;

SELECT @RI7102_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_HRG <> 'Other'
      AND Admission_Date >= @RI7102_StartDate
      AND Admission_Date <= @RI7102_EndDate;

-- Calculate Percentage
DECLARE @RI7102_Percentage FLOAT;

SET @RI7102_Percentage = CAST(@RI7102_Numerator AS FLOAT) / NULLIF(@RI7102_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7102 - Percentage of Patients with Chapter DZ HRG Coded to Respiratory Medicine' AS Metric,
       @RI7102_Percentage AS Percentage,
       @RI7102_Numerator AS Numerator,
       @RI7102_Denominator AS Denominator;

/* Proportion of patients with a respiratory medicine HRG and a zero length of stay coded to the specialty of Respiratory Medicine 
Model Hospital ID: RI7103

Count(Spells)
RespM_HRG <> 'Other' 
AND RespM_SpecialtyEM = 'Respiratory Medicine' 
AND Spell_LOS=0

Count(Spells)
RespM_HRG <> 'Other' 
AND Spell_LOS=0

*/

-- Define the start and end dates for Metric RI7103
DECLARE @RI7103_StartDate DATE = '2023-07-01';
DECLARE @RI7103_EndDate DATE = '2024-06-30';

-- Numerator: Count of Spells with zero LOS
DECLARE @RI7103_Numerator INT;

SELECT @RI7103_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_HRG <> 'Other'
      AND Spell_LOS = 0
      AND RespM_SpecialtyEM = 'Respiratory Medicine'
      AND Admission_Date >= @RI7103_StartDate
      AND Admission_Date <= @RI7103_EndDate;

-- Denominator: Count of Spells with Respiratory Medicine specialty
DECLARE @RI7103_Denominator INT;

SELECT @RI7103_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_HRG <> 'Other'
      AND Spell_LOS = 0
      AND Admission_Date >= @RI7103_StartDate
      AND Admission_Date <= @RI7103_EndDate;

-- Calculate Proportion
DECLARE @RI7103_Proportion FLOAT;

SET @RI7103_Proportion = CAST(@RI7103_Numerator AS FLOAT) / NULLIF(@RI7103_Denominator, 0);

-- Output the result
SELECT 'Metric RI7103 - Proportion of Patients with Respiratory Medicine HRG and Zero LOS' AS Metric,
       @RI7103_Proportion AS Proportion,
       @RI7103_Numerator AS Numerator,
       @RI7103_Denominator AS Denominator;

/* Outpatient new to follow up ratio (first and follow up (WF) codes only) 
Model Hospital ID: RI7104

Count(OP Attendances)
RespM_OP_Type = 'First' 
AND RespM_OP='All' 

Count(OP Attendances)
RespM_OP_Type = 'Follow-up' 
AND RespM_OP='All' 

*/

-- Define the start and end dates for Metric RI7104
DECLARE @RI7104_StartDate DATE = '2023-07-01';
DECLARE @RI7104_EndDate DATE = '2024-06-30';

-- Numerator: Count of Follow-Up Attendances
DECLARE @RI7104_Numerator INT;

SELECT @RI7104_Numerator = COUNT(DISTINCT OP_Attendance_ID)
FROM #OP_Spells_With_Variables
WHERE RespM_OP_Type = 'Follow-up'
      AND RespM_OP = 'All'
	  and Age >= 17
      AND Appointment_Date >= @RI7104_StartDate
      AND Appointment_Date <= @RI7104_EndDate;
	  
-- Denominator: Count of First Attendances
DECLARE @RI7104_Denominator INT;

SELECT @RI7104_Denominator = COUNT(DISTINCT OP_Attendance_ID)
FROM #OP_Spells_With_Variables
WHERE RespM_OP_Type = 'First'
      AND RespM_OP = 'All'
      AND Appointment_Date >= @RI7104_StartDate
      AND Appointment_Date <= @RI7104_EndDate;

-- Calculate New to Follow-Up Ratio
DECLARE @RI7104_Ratio FLOAT;

SET @RI7104_Ratio = CAST(@RI7104_Numerator AS FLOAT) / NULLIF(@RI7104_Denominator, 0);

-- Output the result
SELECT 'Metric RI7104 - Outpatient New to Follow-Up Ratio' AS Metric,
       @RI7104_Ratio AS NewToFollowUpRatio,
       @RI7104_Denominator AS First_Attendances,
	   @RI7104_Numerator AS FollowUp_Attendances;

/* Outpatient did not attend rate (first and follow up (WF) codes only) 
Model Hospital ID: RI7105

Count(OP Attendances)
RespM_OP_DNA = 'DNA' 
AND RespM_OP='All' 

Count(OP Attendances)
RespM_OP = 'All' 

*/

-- Define the start and end dates for Metric RI7105
DECLARE @RI7105_StartDate DATE = '2023-07-01';
DECLARE @RI7105_EndDate DATE = '2024-06-30';

-- Numerator: Count of Did Not Attend (DNA) occurrences
DECLARE @RI7105_Numerator INT;

SELECT @RI7105_Numerator = COUNT(DISTINCT OP_Attendance_ID)
FROM #OP_Spells_With_Variables
WHERE RespM_OP_DNA = 'DNA'
      AND RespM_OP = 'All'
	  AND Age >= 17
      AND Appointment_Date >= @RI7105_StartDate
      AND Appointment_Date <= @RI7105_EndDate;

-- Denominator: Total Outpatient Attendances
DECLARE @RI7105_Denominator INT;

SELECT @RI7105_Denominator = COUNT(DISTINCT OP_Attendance_ID)
FROM #OP_Spells_With_Variables
WHERE RespM_OP = 'All'
	  AND Age >= 17
      AND Appointment_Date >= @RI7105_StartDate
      AND Appointment_Date <= @RI7105_EndDate;

-- Calculate DNA Rate
DECLARE @RI7105_Rate FLOAT;

SET @RI7105_Rate = CAST(@RI7105_Numerator AS FLOAT) / NULLIF(@RI7105_Denominator, 0);

-- Output the result
SELECT 'Metric RI7105 - Outpatient Did Not Attend Rate' AS Metric,
       @RI7105_Rate AS DNARate,
       @RI7105_Numerator AS DNA_Count,
       @RI7105_Denominator AS Total_Attendances;

/* Percentage of patients discharged at first appointment (first (WF) codes only) 
Model Hospital ID: RI7106

Count(OP Attendances)
RespM_OP_Type = 'First' 
AND RespM_OP_Outcome = 'Discharged' 
AND RespM_OP='All' 

Count(OP Attendances)
RespM_OP_Type = 'First' 
AND RespM_OP='All' 

*/

-- Define the start and end dates for Metric RI7106
DECLARE @RI7106_StartDate DATE = '2023-07-01';
DECLARE @RI7106_EndDate DATE = '2024-06-30';

-- Numerator: Count of Patients Discharged at First Appointment
DECLARE @RI7106_Numerator INT;

SELECT @RI7106_Numerator = COUNT(DISTINCT OP_Attendance_ID)
FROM #OP_Spells_With_Variables
WHERE RespM_OP_Type = 'First'
      AND RespM_OP_Outcome = 'Discharged'
      AND RespM_OP = 'All'
	  AND Age >= 17
      AND Appointment_Date >= @RI7106_StartDate
      AND Appointment_Date <= @RI7106_EndDate;

-- Denominator: Total First Attendances
DECLARE @RI7106_Denominator INT;

SELECT @RI7106_Denominator = COUNT(DISTINCT OP_Attendance_ID)
FROM #OP_Spells_With_Variables
WHERE RespM_OP_Type = 'First'
      AND RespM_OP = 'All'
	  AND Age >= 17
      AND Appointment_Date >= @RI7106_StartDate
      AND Appointment_Date <= @RI7106_EndDate;

-- Calculate Percentage Discharged at First Appointment
DECLARE @RI7106_Percentage FLOAT;

SET @RI7106_Percentage = CAST(@RI7106_Numerator AS FLOAT) / NULLIF(@RI7106_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7106 - Percentage of Patients Discharged at First Appointment' AS Metric,
       @RI7106_Percentage AS Percentage,
       @RI7106_Numerator AS Discharged_First_Appointments,
       @RI7106_Denominator AS Total_First_Appointments;

/* -------------------------------------------------------------------
	Pleural Disease - Pleural Effusion
------------------------------------------------------------------- */

/*  Number of elective admissions for Pleural Effusion 
Model Hospital ID: RI7107

Count(Spells)
RespM_PleuralEffusion <> 'Other' 
AND (POD_Derived = 'DC' OR POD_Derived = 'EL') 



*/

-- Define the start and end dates for Metric RI7107
DECLARE @RI7107_StartDate DATE = '2023-07-01';
DECLARE @RI7107_EndDate DATE = '2024-06-30';

-- Count of Elective Admissions
DECLARE @RI7107_Count INT;

SELECT @RI7107_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion IS NOT NULL
      AND POD_Derived IN ('DC', 'EL')
      AND Admission_Date BETWEEN @RI7107_StartDate AND @RI7107_EndDate;

-- Output the result
SELECT 'Metric RI7107 - Number of Elective Admissions for Pleural Effusion' AS Metric,
       @RI7107_Count AS Count;

/* Number of non-elective admissions for Pleural Effusion 
Model Hospital ID: RI7108

Count(Spells)
RespM_PleuralEffusion <> 'Other' 
AND POD_Derived = 'EM' 

*/

-- Define the start and end dates for Metric RI7108
DECLARE @RI7108_StartDate DATE = '2023-07-01';
DECLARE @RI7108_EndDate DATE = '2024-06-30';

-- Count of Non-Elective Admissions
DECLARE @RI7108_Count INT;

SELECT @RI7108_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion IS NOT NULL
      AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @RI7108_StartDate AND @RI7108_EndDate;

-- Output the result
SELECT 'Metric RI7108 - Number of Non-Elective Admissions for Pleural Effusion' AS Metric,
       @RI7108_Count AS Count;

/* Percentage of non-elective pleural effusion admissions (>1 day) discharged from general or acute medicine 
Model Hospital ID: RI7109

Count(Spells)
RespM_PleuralEffusion = 'General or Acute Medicine' 
AND Spell_LOS >1 
AND POD_Derived = 'EM' 

Count(Spells)
RespM_PleuralEffusion <> 'Other' 
AND Spell_LOS >1 
AND POD_Derived = 'EM' 

*/

-- Define the start and end dates for Metric RI7109
DECLARE @RI7109_StartDate DATE = '2023-07-01';
DECLARE @RI7109_EndDate DATE = '2024-06-30';

-- Numerator: Admissions discharged from General or Acute Medicine
DECLARE @RI7109_Numerator INT;

SELECT @RI7109_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion = 'General or Acute Medicine'
      AND Spell_LOS > 1
      AND POD_Derived = 'EM'
	  and Discharge_Treatment_Function_Code IN ('300','326')
      AND Admission_Date BETWEEN @RI7109_StartDate AND @RI7109_EndDate;

-- Denominator: All Non-Elective Pleural Effusion Admissions (>1 Day)
DECLARE @RI7109_Denominator INT;

SELECT @RI7109_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion IS NOT NULL
      AND Spell_LOS > 1
      AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @RI7109_StartDate AND @RI7109_EndDate;

-- Calculate Percentage
DECLARE @RI7109_Percentage FLOAT;

SET @RI7109_Percentage = CAST(@RI7109_Numerator AS FLOAT) / NULLIF(@RI7109_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7109 - Percentage of Non-Elective Pleural Effusion Admissions (>1 Day) Discharged from General or Acute Medicine' AS Metric,
       @RI7109_Percentage AS Percentage,
       @RI7109_Numerator AS Numerator,
       @RI7109_Denominator AS Denominator;

/* Percentage of emergency pleural effusion admissions to general or acute medicine (300 or 326) that are zero length of stay 
Model Hospital ID: RI7110

Count(Spells)
RespM_PleuralEffusion = 'General or Acute Medicine' 
AND Spell_LOS <1 
AND POD_Derived = 'EM' 

Count(Spells)
RespM_PleuralEffusion = 'General or Acute Medicine' 
AND POD_Derived = 'EM' 


*/

-- Define the start and end dates for Metric RI7110
DECLARE @RI7110_StartDate DATE = '2023-07-01';
DECLARE @RI7110_EndDate DATE = '2024-06-30';

-- Numerator: Zero LOS Admissions
DECLARE @RI7110_Numerator INT;

SELECT @RI7110_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion = 'General or Acute Medicine'
      AND Spell_LOS = 0
	  AND Age >= 17
      AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @RI7110_StartDate AND @RI7110_EndDate;

-- Denominator: All Emergency Admissions to General or Acute Medicine
DECLARE @RI7110_Denominator INT;

SELECT @RI7110_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion = 'General or Acute Medicine'
      AND POD_Derived = 'EM'
	  AND Age >= 17
      AND Admission_Date BETWEEN @RI7110_StartDate AND @RI7110_EndDate;

-- Calculate Percentage
DECLARE @RI7110_Percentage FLOAT;

SET @RI7110_Percentage = CAST(@RI7110_Numerator AS FLOAT) / NULLIF(@RI7110_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7110 - Percentage of Emergency Pleural Effusion Admissions to General or Acute Medicine That Are Zero LOS' AS Metric,
       @RI7110_Percentage AS Percentage,
       @RI7110_Numerator AS Numerator,
       @RI7110_Denominator AS Denominator;

/* Day case rate for patients with Pleural Effusion 
Model Hospital ID: RI7111

Count(Spells)
RespM_PleuralEffusion <> 'Other' 
AND POD_Derived = 'DC'

Count(Spells)
RespM_PleuralEffusion <> 'Other' 
AND (POD_Derived = 'DC' OR POD_Derived = 'EL') 

*/

-- Define the start and end dates for Metric RI7111
DECLARE @RI7111_StartDate DATE = '2023-07-01';
DECLARE @RI7111_EndDate DATE = '2024-06-30';

-- Numerator: Day Case Admissions
DECLARE @RI7111_Numerator INT;

SELECT @RI7111_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion is not null
      AND POD_Derived = 'DC'
	  and Age >= 17
      AND Admission_Date BETWEEN @RI7111_StartDate AND @RI7111_EndDate;

-- Denominator: Elective and Day Case Admissions
DECLARE @RI7111_Denominator INT;

SELECT @RI7111_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion is not null
      AND POD_Derived IN ('DC', 'EL')
	  and Age >= 17
      AND Admission_Date BETWEEN @RI7111_StartDate AND @RI7111_EndDate;

-- Calculate Day Case Rate
DECLARE @RI7111_Rate FLOAT;

SET @RI7111_Rate = CAST(@RI7111_Numerator AS FLOAT) / NULLIF(@RI7111_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7111 - Day Case Rate for Patients with Pleural Effusion' AS Metric,
       @RI7111_Rate AS DayCaseRatePercentage,
       @RI7111_Numerator AS DayCaseAdmissions,
       @RI7111_Denominator AS TotalElectiveAdmissions;

/* % of admissions with Pleural Effusion achieving Best Practice Tariff 
Model Hospital ID: RI7112

Count(Spells)
RespM_PleuralEffusion <> 'Other'  
AND RespM_PleuralEffusion_BPT = 'Best Practice Tariff' 
AND (POD_Derived = 'EL' OR POD_Derived = 'DC')

Count(Spells)
RespM_PleuralEffusion <> 'Other' 
AND (POD_Derived = 'EL' OR POD_Derived = 'DC')

*/

-- Define the start and end dates for Metric RI7112
DECLARE @RI7112_StartDate DATE = '2023-07-01';
DECLARE @RI7112_EndDate DATE = '2024-06-30';

-- Numerator: Spells with Pleural Effusion achieving Best Practice Tariff
DECLARE @RI7112_Numerator INT;

SELECT @RI7112_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion IS NOT NULL
      AND RespM_PleuralEffusion_BPT = 'Best Practice Tariff'
      AND POD_Derived IN ('EL', 'DC')
      AND Admission_Date BETWEEN @RI7112_StartDate AND @RI7112_EndDate;

-- Denominator: All Spells with Pleural Effusion (excluding 'Other') and elective or day case admissions
DECLARE @RI7112_Denominator INT;

SELECT @RI7112_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion IS NOT NULL
      AND POD_Derived IN ('EL', 'DC')
      AND Admission_Date BETWEEN @RI7112_StartDate AND @RI7112_EndDate;

-- Calculate Percentage
DECLARE @RI7112_Percentage FLOAT;

SET @RI7112_Percentage = CAST(@RI7112_Numerator AS FLOAT) / NULLIF(@RI7112_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7112 - Percentage of Admissions with Pleural Effusion Achieving Best Practice Tariff' AS Metric,
       @RI7112_Percentage AS Percentage,
       @RI7112_Numerator AS Numerator,
       @RI7112_Denominator AS Denominator;

/* Average length of stay - multiple interventions, high complexity and co-morbidity 
Model Hospital ID: RI7113

Sum(Spell_LOS)
RespM_PleuralEffusion_CC = 'Multiple Int, CC 11+'

Count(Spells)
RespM_PleuralEffusion_CC = 'Multiple Int, CC 11+'

*/

-- Define the start and end dates for Metric RI7113
DECLARE @RI7113_StartDate DATE = '2023-07-01';
DECLARE @RI7113_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7113_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7113_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_PleuralEffusion_CC = 'Multiple Int, CC 11+'
		  AND Method_Of_Discharge_Code = 1
          AND Admission_Date BETWEEN @RI7113_StartDate AND @RI7113_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7113_Total_Spells INT;

SELECT @RI7113_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion_CC = 'Multiple Int, CC 11+'
	  AND Method_Of_Discharge_Code = 1
      AND Admission_Date BETWEEN @RI7113_StartDate AND @RI7113_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7113_Average_LOS FLOAT;

SET @RI7113_Average_LOS = CAST(@RI7113_Total_LOS AS FLOAT) / NULLIF(@RI7113_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7113 - Average LOS for Multiple Interventions, High Complexity and Co-morbidity' AS Metric,
       @RI7113_Average_LOS AS Average_LOS,
       @RI7113_Total_LOS AS Total_LOS,
       @RI7113_Total_Spells AS Total_Spells;

/* Average length of stay - intervention with low or moderate complexity and co-morbidity 
Model Hospital ID: RI7114

Sum(Spell_LOS)
RespM_PleuralEffusion_CC = 'Single Int, CC 6-10'

Count(Spells)
RespM_PleuralEffusion_CC = 'Single Int, CC 6-10'


*/

-- Define the start and end dates for Metric RI7114
DECLARE @RI7114_StartDate DATE = '2023-07-01';
DECLARE @RI7114_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7114_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7114_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_PleuralEffusion_CC = 'Single Int, CC 6-10'
          AND Admission_Date BETWEEN @RI7114_StartDate AND @RI7114_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7114_Total_Spells INT;

SELECT @RI7114_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion_CC = 'Single Int, CC 6-10'
      AND Admission_Date BETWEEN @RI7114_StartDate AND @RI7114_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7114_Average_LOS FLOAT;

SET @RI7114_Average_LOS = CAST(@RI7114_Total_LOS AS FLOAT) / NULLIF(@RI7114_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7114 - Average LOS for Intervention with Low or Moderate Complexity and Co-morbidity' AS Metric,
       @RI7114_Average_LOS AS Average_LOS,
       @RI7114_Total_LOS AS Total_LOS,
       @RI7114_Total_Spells AS Total_Spells;

/* Average length of stay - without intervention and low complexity and co-morbidity 
Model Hospital ID: RI7115

Sum(Spell_LOS)
RespM_PleuralEffusion_CC = 'No Int, CC 0-5'

Count(Spells)
RespM_PleuralEffusion_CC = 'No Int, CC 0-5'


*/

-- Define the start and end dates for Metric RI7115
DECLARE @RI7115_StartDate DATE = '2023-07-01';
DECLARE @RI7115_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7115_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7115_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_PleuralEffusion_CC = 'No Int, CC 0-5'
          AND Admission_Date BETWEEN @RI7115_StartDate AND @RI7115_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7115_Total_Spells INT;

SELECT @RI7115_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PleuralEffusion_CC = 'No Int, CC 0-5' 
      AND Admission_Date BETWEEN @RI7115_StartDate AND @RI7115_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7115_Average_LOS FLOAT;

SET @RI7115_Average_LOS = CAST(@RI7115_Total_LOS AS FLOAT) / NULLIF(@RI7115_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7115 - Average LOS for Without Intervention and Low Complexity and Co-morbidity' AS Metric,
       @RI7115_Average_LOS AS Average_LOS,
       @RI7115_Total_LOS AS Total_LOS,
       @RI7115_Total_Spells AS Total_Spells;

/* -------------------------------------------------------------------
	Pleural Disease - Pneumothorax
------------------------------------------------------------------- */

/* % of emergency admissions with Pneumothorax coded to Respiratory Medicine 
Model Hospital ID: RI7116

Count(Spells)
RespM_PneumothoraxEM = 'Respiratory Medicine'

Count(Spells)
RespM_PneumothoraxEM <> 'Other'


*/

-- Define the start and end dates for Metric RI7116
DECLARE @RI7116_StartDate DATE = '2023-07-01';
DECLARE @RI7116_EndDate DATE = '2024-06-30';

-- Numerator: Count of spells where RespM_PneumothoraxEM = 'Respiratory Medicine'
DECLARE @RI7116_Numerator INT;

SELECT @RI7116_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumothoraxEM = 'Respiratory Medicine'
      AND Admission_Date BETWEEN @RI7116_StartDate AND @RI7116_EndDate;

-- Denominator: Count of spells where RespM_PneumothoraxEM <> 'Other'
DECLARE @RI7116_Denominator INT;

SELECT @RI7116_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumothoraxEM <> 'Other'
      AND Admission_Date BETWEEN @RI7116_StartDate AND @RI7116_EndDate;

-- Calculate Percentage
DECLARE @RI7116_Percentage FLOAT;

SET @RI7116_Percentage = CAST(@RI7116_Numerator AS FLOAT) / NULLIF(@RI7116_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7116 - Percentage of Emergency Admissions with Pneumothorax Coded to Respiratory Medicine' AS Metric,
       @RI7116_Percentage AS Percentage,
       @RI7116_Numerator AS Numerator,
       @RI7116_Denominator AS Denominator;


/* Average length of stay (days) - Emergency admissions with Pneumothorax 
Model Hospital ID: RI7117

Sum(Spell_LOS)
RespM_PneumothoraxEM <> 'Other'

Count(Spells)
RespM_PneumothoraxEM <> 'Other'


*/

-- Define the start and end dates for Metric RI7117
DECLARE @RI7117_StartDate DATE = '2023-07-01';
DECLARE @RI7117_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7117_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7117_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_PneumothoraxEM <> 'Other'
		  AND Age >= 17
          AND Admission_Date BETWEEN @RI7117_StartDate AND @RI7117_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7117_Total_Spells INT;

SELECT @RI7117_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumothoraxEM <> 'Other'
	  AND Age >= 17
      AND Admission_Date BETWEEN @RI7117_StartDate AND @RI7117_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7117_Average_LOS FLOAT;

SET @RI7117_Average_LOS = CAST(@RI7117_Total_LOS AS FLOAT) / NULLIF(@RI7117_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7117 - Average Length of Stay for Emergency Admissions with Pneumothorax' AS Metric,
       @RI7117_Average_LOS AS Average_LOS,
       @RI7117_Total_LOS AS Total_LOS,
       @RI7117_Total_Spells AS Total_Spells;

/* -------------------------------------------------------------------
	Pulmonary Embolism
------------------------------------------------------------------- */

/* Average length of stay - PE with intervention 
Model Hospital ID: RI7118

Sum(Spell_LOS)
RespM_PulmonaryEmbolism = 'With Intervention'

Count(Spells)
RespM_PulmonaryEmbolism = 'With Intervention'


*/

-- Define the start and end dates for Metric RI7118
DECLARE @RI7118_StartDate DATE = '2023-07-01';
DECLARE @RI7118_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7118_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7118_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_PulmonaryEmbolism = 'With Intervention'
          AND Admission_Date BETWEEN @RI7118_StartDate AND @RI7118_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7118_Total_Spells INT;

SELECT @RI7118_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PulmonaryEmbolism = 'With Intervention'
      AND Admission_Date BETWEEN @RI7118_StartDate AND @RI7118_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7118_Average_LOS FLOAT;

SET @RI7118_Average_LOS = CAST(@RI7118_Total_LOS AS FLOAT) / NULLIF(@RI7118_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7118 - Average LOS for Pulmonary Embolism with Intervention' AS Metric,
       @RI7118_Average_LOS AS Average_LOS,
       @RI7118_Total_LOS AS Total_LOS,
       @RI7118_Total_Spells AS Total_Spells;

/* Average length of stay - PE without intervention, CC score 0-2 
Model Hospital ID: RI7119

Sum(Spell_LOS)
RespM_PulmonaryEmbolism = 'Without Int, CC 0-2'

Count(Spells)
RespM_PulmonaryEmbolism = 'Without Int, CC 0-2'


*/

-- Define the start and end dates for Metric RI7119
DECLARE @RI7119_StartDate DATE = '2023-07-01';
DECLARE @RI7119_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7119_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7119_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_PulmonaryEmbolism = 'Without Int, CC 0-2'
          AND Admission_Date BETWEEN @RI7119_StartDate AND @RI7119_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7119_Total_Spells INT;

SELECT @RI7119_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PulmonaryEmbolism = 'Without Int, CC 0-2'
      AND Admission_Date BETWEEN @RI7119_StartDate AND @RI7119_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7119_Average_LOS FLOAT;

SET @RI7119_Average_LOS = CAST(@RI7119_Total_LOS AS FLOAT) / NULLIF(@RI7119_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7119 - Average LOS for Pulmonary Embolism without Intervention, CC Score 0-2' AS Metric,
       @RI7119_Average_LOS AS Average_LOS,
       @RI7119_Total_LOS AS Total_LOS,
       @RI7119_Total_Spells AS Total_Spells;

/* Average length of stay - PE without intervention, CC score 3-8 
Model Hospital ID: RI7120

Sum(Spell_LOS)
RespM_PulmonaryEmbolism = 'Without Int, CC 3-8'

Count(Spells)
RespM_PulmonaryEmbolism = 'Without Int, CC 3-8'


*/

-- Define the start and end dates for Metric RI7120
DECLARE @RI7120_StartDate DATE = '2023-07-01';
DECLARE @RI7120_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7120_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7120_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_PulmonaryEmbolism = 'Without Int, CC 3-8'
          AND Admission_Date BETWEEN @RI7120_StartDate AND @RI7120_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7120_Total_Spells INT;

SELECT @RI7120_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PulmonaryEmbolism = 'Without Int, CC 3-8'
      AND Admission_Date BETWEEN @RI7120_StartDate AND @RI7120_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7120_Average_LOS FLOAT;

SET @RI7120_Average_LOS = CAST(@RI7120_Total_LOS AS FLOAT) / NULLIF(@RI7120_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7120 - Average LOS for Pulmonary Embolism without Intervention, CC Score 3-8' AS Metric,
       @RI7120_Average_LOS AS Average_LOS,
       @RI7120_Total_LOS AS Total_LOS,
       @RI7120_Total_Spells AS Total_Spells;

/* Average length of stay - PE without intervention, CC score 9+ 
Model Hospital ID: RI7121

Sum(Spell_LOS)
RespM_PulmonaryEmbolism = 'Without Int, CC 9+'

Count(Spells)
RespM_PulmonaryEmbolism = 'Without Int, CC 9+'


*/

-- Define the start and end dates for Metric RI7121
DECLARE @RI7121_StartDate DATE = '2023-07-01';
DECLARE @RI7121_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7121_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7121_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_PulmonaryEmbolism = 'Without Int, CC 9+'
          AND Admission_Date BETWEEN @RI7121_StartDate AND @RI7121_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7121_Total_Spells INT;

SELECT @RI7121_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PulmonaryEmbolism = 'Without Int, CC 9+'
      AND Admission_Date BETWEEN @RI7121_StartDate AND @RI7121_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7121_Average_LOS FLOAT;

SET @RI7121_Average_LOS = CAST(@RI7121_Total_LOS AS FLOAT) / NULLIF(@RI7121_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7121 - Average LOS for Pulmonary Embolism without Intervention, CC Score 9+' AS Metric,
       @RI7121_Average_LOS AS Average_LOS,
       @RI7121_Total_LOS AS Total_LOS,
       @RI7121_Total_Spells AS Total_Spells;

/* -------------------------------------------------------------------
	Pneumonia
------------------------------------------------------------------- */

/* Emergency Readmission rate (within 30 days) following Pneumonia Admission 
Model Hospital ID: RI7122

Count(Spells)
RespM_PneumoniaEM <> 'Other' 
AND Read30 = 1

Count(Spells)
RespM_PneumoniaEM <> 'Other'


*/

-- Define the start and end dates for Metric RI7122
DECLARE @RI7122_StartDate DATE = '2023-07-01';
DECLARE @RI7122_EndDate DATE = '2024-06-30';

-- Numerator: Count of spells where Read30 = 1
DECLARE @RI7122_Numerator INT;

SELECT @RI7122_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM NOT LIKE 'Other%'
      AND Read30 = 1
      AND Admission_Date BETWEEN @RI7122_StartDate AND @RI7122_EndDate;

-- Denominator: Count of spells where RespM_PneumoniaEM <> 'Other'
DECLARE @RI7122_Denominator INT;

SELECT @RI7122_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM NOT LIKE 'Other%'
      AND Admission_Date BETWEEN @RI7122_StartDate AND @RI7122_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7122_ReadmissionRate FLOAT;

SET @RI7122_ReadmissionRate = CAST(@RI7122_Numerator AS FLOAT) / NULLIF(@RI7122_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7122 - Emergency Readmission Rate within 30 Days Following Pneumonia Admission' AS Metric,
       @RI7122_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7122_Numerator AS Numerator,
       @RI7122_Denominator AS Denominator;

/* Emergency Readmission rate (within 90 days) following Pnuemonia Admission 
Model Hospital ID: RI7123

Count(Spells)
RespM_PneumoniaEM <> 'Other' 
AND Read90 = 1

Count(Spells)
RespM_PneumoniaEM <> 'Other'



*/

-- Define the start and end dates for Metric RI7123
DECLARE @RI7123_StartDate DATE = '2023-07-01';
DECLARE @RI7123_EndDate DATE = '2024-06-30';

-- Numerator: Count of spells where Read90 = 1
DECLARE @RI7123_Numerator INT;

SELECT @RI7123_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM NOT LIKE 'Other%'
      AND Read90 = 1
      AND Admission_Date BETWEEN @RI7123_StartDate AND @RI7123_EndDate;

-- Denominator: Count of spells where RespM_PneumoniaEM <> 'Other'
DECLARE @RI7123_Denominator INT;

SELECT @RI7123_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM NOT LIKE 'Other%'
      AND Admission_Date BETWEEN @RI7123_StartDate AND @RI7123_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7123_ReadmissionRate FLOAT;

SET @RI7123_ReadmissionRate = CAST(@RI7123_Numerator AS FLOAT) / NULLIF(@RI7123_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7123 - Emergency Readmission Rate within 90 Days Following Pneumonia Admission' AS Metric,
       @RI7123_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7123_Numerator AS Numerator,
       @RI7123_Denominator AS Denominator;

/* Average Pneumonia length of stay  - general medicine 
Model Hospital ID: RI7126

Sum(Spell_LOS)
RespM_PneumoniaEM = 'Respiratory Medicine'

Count(Spells)
RespM_PneumoniaEM = 'Respiratory Medicine'


*/

-- Define the start and end dates for Metric RI7126
DECLARE @RI7126_StartDate DATE = '2023-07-01';
DECLARE @RI7126_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7126_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7126_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_PneumoniaEM IS NOT NULL
		  AND Discharge_Treatment_Function_Code = '300'
          AND Admission_Date BETWEEN @RI7126_StartDate AND @RI7126_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7126_Total_Spells INT;

SELECT @RI7126_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM IS NOT NULL
		  AND Discharge_Treatment_Function_Code = '300'
      AND Admission_Date BETWEEN @RI7126_StartDate AND @RI7126_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7126_Average_LOS FLOAT;

SET @RI7126_Average_LOS = CAST(@RI7126_Total_LOS AS FLOAT) / NULLIF(@RI7126_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7126 - Average Pneumonia Length of Stay - General Medicine' AS Metric,
       @RI7126_Average_LOS AS Average_LOS,
       @RI7126_Total_LOS AS Total_LOS,
       @RI7126_Total_Spells AS Total_Spells;

/* Average Pneumonia length of stay - respiratory medicine 
Model Hospital ID: RI7125

Sum(Spell_LOS)
RespM_PneumoniaEM = 'General Medicine'

Count(Spells)
RespM_PneumoniaEM = 'General Medicine'

*/

-- Define the start and end dates for Metric RI7125
DECLARE @RI7125_StartDate DATE = '2023-07-01';
DECLARE @RI7125_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7125_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7125_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT swv.Spell_Number, MAX(swv.Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables swv
    INNER JOIN PAS_IP_Spell_Frozen ips
        ON swv.Spell_Number = ips.Spell_Number
        AND swv.Sector = ips.Sector
    WHERE swv.RespM_PneumoniaEM IS NOT NULL
          AND swv.Admission_Date BETWEEN @RI7125_StartDate AND @RI7125_EndDate
          AND ips.Discharge_Treatment_Function_Code = '340'
    GROUP BY swv.Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7125_Total_Spells INT;

SELECT @RI7125_Total_Spells = COUNT(DISTINCT swv.Spell_Number)
FROM #Spells_With_Variables swv
INNER JOIN PAS_IP_Spell_Frozen ips
    ON swv.Spell_Number = ips.Spell_Number
    AND swv.Sector = ips.Sector
WHERE swv.RespM_PneumoniaEM IS NOT NULL
      AND swv.Admission_Date BETWEEN @RI7125_StartDate AND @RI7125_EndDate
      AND ips.Discharge_Treatment_Function_Code = '340';

-- Calculate Average Length of Stay
DECLARE @RI7125_Average_LOS FLOAT;

SET @RI7125_Average_LOS = CAST(@RI7125_Total_LOS AS FLOAT) / NULLIF(@RI7125_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7125 - Average Pneumonia Length of Stay - Respiratory Medicine' AS Metric,
       @RI7125_Average_LOS AS Average_LOS,
       @RI7125_Total_LOS AS Total_LOS,
       @RI7125_Total_Spells AS Total_Spells;

/* Average Pneumonia length of stay - care of the elderly 
Model Hospital ID: RI7127

Sum(Spell_LOS)
RespM_PneumoniaEM = 'Care of the Elderly'

Count(Spells)
RespM_PneumoniaEM = 'Care of the Elderly'


*/

-- Define the start and end dates for Metric RI7127
DECLARE @RI7127_StartDate DATE = '2023-07-01';
DECLARE @RI7127_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7127_Total_LOS INT;

SELECT @RI7127_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT swv.Spell_Number, MAX(swv.Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables swv
    INNER JOIN PAS_IP_Spell_Frozen ips
        ON swv.Spell_Number = ips.Spell_Number
        AND swv.Sector = ips.Sector
    WHERE swv.RespM_PneumoniaEM IS NOT NULL
          AND swv.Admission_Date BETWEEN @RI7127_StartDate AND @RI7127_EndDate
          AND swv.Discharge_Treatment_Function_Code = '430'
    GROUP BY swv.Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7127_Total_Spells INT;

SELECT @RI7127_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '430'
      AND Admission_Date BETWEEN @RI7127_StartDate AND @RI7127_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7127_Average_LOS FLOAT;

SET @RI7127_Average_LOS = CAST(@RI7127_Total_LOS AS FLOAT) / NULLIF(@RI7127_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7127 - Average Pneumonia Length of Stay - Care of the Elderly' AS Metric,
       @RI7127_Average_LOS AS Average_LOS,
       @RI7127_Total_LOS AS Total_LOS,
       @RI7127_Total_Spells AS Total_Spells;

/* Pneumonia - critical care admission rate - 18-40 years 
Model Hospital ID: RI7128

Count(Spells)
RespM_AgeGroup1 = 'Age18-40' 
AND RespM_PneumoniaEM_CC = 'Critical Care Admissions'

Count(Spells)
RespM_PneumoniaEM <> 'Other' 
AND RespM_AgeGroup1 = 'Age18-40'

*/

-- Define the start and end dates for Metric RI7128
DECLARE @RI7128_StartDate DATE = '2023-07-01';
DECLARE @RI7128_EndDate DATE = '2024-06-30';

-- Numerator: Count of spells with critical care admissions
DECLARE @RI7128_Numerator INT;

SELECT @RI7128_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AgeGroup1 = 'Age18-40'
	  AND RespM_PneumoniaEM IS NOT NULL
      AND RespM_PneumoniaEM_CC = 'Critical Care Admissions'
      AND Admission_Date BETWEEN @RI7128_StartDate AND @RI7128_EndDate;

-- Denominator: Count of spells with pneumonia not 'Other' in age group
DECLARE @RI7128_Denominator INT;

SELECT @RI7128_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM NOT LIKE 'Other%'
      AND RespM_AgeGroup1 = 'Age18-40'
      AND Admission_Date BETWEEN @RI7128_StartDate AND @RI7128_EndDate;

-- Calculate Critical Care Admission Rate
DECLARE @RI7128_Rate FLOAT;

SET @RI7128_Rate = CAST(@RI7128_Numerator AS FLOAT) / NULLIF(@RI7128_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7128 - Pneumonia Critical Care Admission Rate - 18-40 Years' AS Metric,
       @RI7128_Rate AS CriticalCareAdmissionRatePercentage,
       @RI7128_Numerator AS Numerator,
       @RI7128_Denominator AS Denominator;

/* Pneumonia - critical care admission rate - 41-65 years 
Model Hospital ID: RI7129

Count(Spells)
RespM_AgeGroup1 = 'Age41-65' 
AND RespM_PneumoniaEM_CC = 'Critical Care Admissions'

Count(Spells)
RespM_PneumoniaEM <> 'Other' 
AND RespM_AgeGroup1 = 'Age41-65'

*/

-- Define the start and end dates for Metric RI7129
DECLARE @RI7129_StartDate DATE = '2023-07-01';
DECLARE @RI7129_EndDate DATE = '2024-06-30';

-- Numerator: Count of spells with critical care admissions
DECLARE @RI7129_Numerator INT;

SELECT @RI7129_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AgeGroup1 = 'Age41-65'
      AND RespM_PneumoniaEM_CC = 'Critical Care Admissions'
	  AND RespM_PneumoniaEM IS NOT NULL
      AND Admission_Date BETWEEN @RI7129_StartDate AND @RI7129_EndDate;

-- Denominator: Count of spells with pneumonia not 'Other' in age group
DECLARE @RI7129_Denominator INT;

SELECT @RI7129_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM NOT LIKE 'Other%'
      AND RespM_AgeGroup1 = 'Age41-65'
      AND Admission_Date BETWEEN @RI7129_StartDate AND @RI7129_EndDate;

-- Calculate Critical Care Admission Rate
DECLARE @RI7129_Rate FLOAT;

SET @RI7129_Rate = CAST(@RI7129_Numerator AS FLOAT) / NULLIF(@RI7129_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7129 - Pneumonia Critical Care Admission Rate - 41-65 Years' AS Metric,
       @RI7129_Rate AS CriticalCareAdmissionRatePercentage,
       @RI7129_Numerator AS Numerator,
       @RI7129_Denominator AS Denominator;

/* Pneumonia - critical care admission rate - 66-80 years 
Model Hospital ID: RI7130

Count(Spells)
RespM_AgeGroup1 = 'Age66-80' 
AND RespM_PneumoniaEM_CC = 'Critical Care Admissions'

Count(Spells)
RespM_PneumoniaEM <> 'Other' 
AND RespM_AgeGroup1 = 'Age66-80'


*/

-- Define the start and end dates for Metric RI7130
DECLARE @RI7130_StartDate DATE = '2023-07-01';
DECLARE @RI7130_EndDate DATE = '2024-06-30';

-- Numerator: Count of spells with critical care admissions
DECLARE @RI7130_Numerator INT;

SELECT @RI7130_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AgeGroup1 = 'Age66-80'
      AND RespM_PneumoniaEM_CC = 'Critical Care Admissions'
	  AND RespM_PneumoniaEM IS NOT NULL
      AND Admission_Date BETWEEN @RI7130_StartDate AND @RI7130_EndDate;

-- Denominator: Count of spells with pneumonia not 'Other' in age group
DECLARE @RI7130_Denominator INT;

SELECT @RI7130_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM NOT LIKE 'Other%'
      AND RespM_AgeGroup1 = 'Age66-80'
      AND Admission_Date BETWEEN @RI7130_StartDate AND @RI7130_EndDate;

-- Calculate Critical Care Admission Rate
DECLARE @RI7130_Rate FLOAT;

SET @RI7130_Rate = CAST(@RI7130_Numerator AS FLOAT) / NULLIF(@RI7130_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7130 - Pneumonia Critical Care Admission Rate - 66-80 Years' AS Metric,
       @RI7130_Rate AS CriticalCareAdmissionRatePercentage,
       @RI7130_Numerator AS Numerator,
       @RI7130_Denominator AS Denominator;

/* Pneumonia - critical care admission rate - over 80 years 
Model Hospital ID: RI7131

Count(Spells)
RespM_AgeGroup1 = 'Age80+' 
AND RespM_PneumoniaEM_CC = 'Critical Care Admissions'

Count(Spells)
RespM_PneumoniaEM <> 'Other' 
AND RespM_AgeGroup1 = 'Age80+'


*/

-- Define the start and end dates for Metric RI7131
DECLARE @RI7131_StartDate DATE = '2023-07-01';
DECLARE @RI7131_EndDate DATE = '2024-06-30';

-- Numerator: Count of spells with critical care admissions
DECLARE @RI7131_Numerator INT;

SELECT @RI7131_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AgeGroup1 = 'Age80+'
      AND RespM_PneumoniaEM_CC = 'Critical Care Admissions'
	  AND RespM_PneumoniaEM IS NOT NULL
      AND Admission_Date BETWEEN @RI7131_StartDate AND @RI7131_EndDate;

-- Denominator: Count of spells with pneumonia not 'Other' in age group
DECLARE @RI7131_Denominator INT;

SELECT @RI7131_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_PneumoniaEM NOT LIKE 'Other%'
      AND RespM_AgeGroup1 = 'Age80+'
      AND Admission_Date BETWEEN @RI7131_StartDate AND @RI7131_EndDate;

-- Calculate Critical Care Admission Rate
DECLARE @RI7131_Rate FLOAT;

SET @RI7131_Rate = CAST(@RI7131_Numerator AS FLOAT) / NULLIF(@RI7131_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7131 - Pneumonia Critical Care Admission Rate - Over 80 Years' AS Metric,
       @RI7131_Rate AS CriticalCareAdmissionRatePercentage,
       @RI7131_Numerator AS Numerator,
       @RI7131_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Chronic Obstructive Pulmonary Disease
------------------------------------------------------------------- */

/* Average COPD length of stay - Respiratory Medicine 
Model Hospital ID: RI7132

Sum(Spell_LOS)
RespM_COPDEM = 'Respiratory Medicine'

Count(Spells)
RespM_COPDEM = 'Respiratory Medicine'



*/

-- Define the start and end dates for Metric RI7132
DECLARE @RI7132_StartDate DATE = '2023-07-01';
DECLARE @RI7132_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7132_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7132_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_COPDEM IS NOT NULL
		AND Discharge_Treatment_Function_Code = '340'
          AND Admission_Date BETWEEN @RI7132_StartDate AND @RI7132_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7132_Total_Spells INT;

SELECT @RI7132_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
		AND Discharge_Treatment_Function_Code = '340'
      AND Admission_Date BETWEEN @RI7132_StartDate AND @RI7132_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7132_Average_LOS FLOAT;

SET @RI7132_Average_LOS = CAST(@RI7132_Total_LOS AS FLOAT) / NULLIF(@RI7132_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7132 - Average COPD Length of Stay - Respiratory Medicine' AS Metric,
       @RI7132_Average_LOS AS Average_LOS,
       @RI7132_Total_LOS AS Total_LOS,
       @RI7132_Total_Spells AS Total_Spells;

/* Average COPD length of stay - General Medicine 
Model Hospital ID: RI7133

Sum(Spell_LOS)
RespM_COPDEM = 'General Medicine'

Count(Spells)
RespM_COPDEM = 'General Medicine'


*/

-- Define the start and end dates for Metric RI7133
DECLARE @RI7133_StartDate DATE = '2023-07-01';
DECLARE @RI7133_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7133_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7133_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_COPDEM IS NOT NULL
		AND Discharge_Treatment_Function_Code = '300'
          AND Admission_Date BETWEEN @RI7133_StartDate AND @RI7133_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7133_Total_Spells INT;

SELECT @RI7133_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
		AND Discharge_Treatment_Function_Code = '300'
      AND Admission_Date BETWEEN @RI7133_StartDate AND @RI7133_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7133_Average_LOS FLOAT;

SET @RI7133_Average_LOS = CAST(@RI7133_Total_LOS AS FLOAT) / NULLIF(@RI7133_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7133 - Average COPD Length of Stay - General Medicine' AS Metric,
       @RI7133_Average_LOS AS Average_LOS,
       @RI7133_Total_LOS AS Total_LOS,
       @RI7133_Total_Spells AS Total_Spells;

/* Average COPD length of stay - Care of the Elderly 
Model Hospital ID: RI7134

Sum(Spell_LOS)
RespM_COPDEM = 'Care of the Elderly'

Count(Spells)
RespM_COPDEM = 'Care of the Elderly'


*/

-- Define the start and end dates for Metric RI7134
DECLARE @RI7134_StartDate DATE = '2023-07-01';
DECLARE @RI7134_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7134_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7134_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_COPDEM = 'Care of the Elderly'
          AND Admission_Date BETWEEN @RI7134_StartDate AND @RI7134_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7134_Total_Spells INT;

SELECT @RI7134_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM = 'Care of the Elderly'
      AND Admission_Date BETWEEN @RI7134_StartDate AND @RI7134_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7134_Average_LOS FLOAT;

SET @RI7134_Average_LOS = CAST(@RI7134_Total_LOS AS FLOAT) / NULLIF(@RI7134_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7134 - Average COPD Length of Stay - Care of the Elderly' AS Metric,
       @RI7134_Average_LOS AS Average_LOS,
       @RI7134_Total_LOS AS Total_LOS,
       @RI7134_Total_Spells AS Total_Spells;

/* Percentage of COPD patients readmitted within 30 days 
Model Hospital ID: RI7135

Count(Spells)
RespM_COPDEM <> 'Other' 
AND Read30=1

Count(Spells)
RespM_COPDEM <> 'Other'


*/

-- Define the start and end dates for Metric RI7135
DECLARE @RI7135_StartDate DATE = '2023-07-01';
DECLARE @RI7135_EndDate DATE = '2024-06-30';

-- Numerator: Patients readmitted within 30 days
DECLARE @RI7135_Numerator INT;

SELECT @RI7135_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM NOT LIKE 'Other%'
      AND Read30 = 1
      AND Admission_Date BETWEEN @RI7135_StartDate AND @RI7135_EndDate;

-- Denominator: All COPD patients
DECLARE @RI7135_Denominator INT;

SELECT @RI7135_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM NOT LIKE 'Other%'
      AND Admission_Date BETWEEN @RI7135_StartDate AND @RI7135_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7135_ReadmissionRate FLOAT;

SET @RI7135_ReadmissionRate = CAST(@RI7135_Numerator AS FLOAT) / NULLIF(@RI7135_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7135 - Percentage of COPD Patients Readmitted Within 30 Days' AS Metric,
       @RI7135_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7135_Numerator AS Numerator,
       @RI7135_Denominator AS Denominator;

/* Emergency Readmission rate (within 30 days) where final COPD episode was in Respiratory Medicine 
Model Hospital ID: RI7136

Count(Spells)
RespM_COPDEM = 'Respiratory Medicine' 
AND Read30 = 1

Count(Spells)
RespM_COPDEM = 'Respiratory Medicine'


*/

-- Define the start and end dates for Metric RI7136
DECLARE @RI7136_StartDate DATE = '2023-07-01';
DECLARE @RI7136_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days
DECLARE @RI7136_Numerator INT;

SELECT @RI7136_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '340'
      AND Read30 = 1
      AND Admission_Date BETWEEN @RI7136_StartDate AND @RI7136_EndDate;

-- Denominator: Total spells in Respiratory Medicine
DECLARE @RI7136_Denominator INT;

SELECT @RI7136_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '340'
      AND Admission_Date BETWEEN @RI7136_StartDate AND @RI7136_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7136_ReadmissionRate FLOAT;

SET @RI7136_ReadmissionRate = CAST(@RI7136_Numerator AS FLOAT) / NULLIF(@RI7136_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7136 - Emergency Readmission Rate Within 30 Days - Respiratory Medicine' AS Metric,
       @RI7136_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7136_Numerator AS Numerator,
       @RI7136_Denominator AS Denominator;

/* Emergency Readmission rate (within 30 days) where final COPD episode was in General Medicine 
Model Hospital ID: RI7137

Count(Spells)
RespM_COPDEM = 'General Medicine' 
AND Read30 = 1

Count(Spells)
RespM_COPDEM = 'General Medicine'

*/

-- Define the start and end dates for Metric RI7137
DECLARE @RI7137_StartDate DATE = '2023-07-01';
DECLARE @RI7137_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days
DECLARE @RI7137_Numerator INT;

SELECT @RI7137_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '300'
      AND Read30 = 1
      AND Admission_Date BETWEEN @RI7137_StartDate AND @RI7137_EndDate;

-- Denominator: Total spells in General Medicine
DECLARE @RI7137_Denominator INT;

SELECT @RI7137_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '300'
      AND Admission_Date BETWEEN @RI7137_StartDate AND @RI7137_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7137_ReadmissionRate FLOAT;

SET @RI7137_ReadmissionRate = CAST(@RI7137_Numerator AS FLOAT) / NULLIF(@RI7137_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7137 - Emergency Readmission Rate Within 30 Days - General Medicine' AS Metric,
       @RI7137_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7137_Numerator AS Numerator,
       @RI7137_Denominator AS Denominator;

/* Emergency Readmission rate (within 30 days) where final COPD episode was in Care of the Elderly 
Model Hospital ID: RI7138

Count(Spells)
RespM_COPDEM = 'Care of the Elderly' 
AND Read30 = 1

Count(Spells)
RespM_COPDEM = 'Care of the Elderly'

*/

-- Define the start and end dates for Metric RI7138
DECLARE @RI7138_StartDate DATE = '2023-07-01';
DECLARE @RI7138_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days
DECLARE @RI7138_Numerator INT;

SELECT @RI7138_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '430'
      AND Read30 = 1
      AND Admission_Date BETWEEN @RI7138_StartDate AND @RI7138_EndDate;

-- Denominator: Total spells in Care of the Elderly
DECLARE @RI7138_Denominator INT;

SELECT @RI7138_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '430'
      AND Admission_Date BETWEEN @RI7138_StartDate AND @RI7138_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7138_ReadmissionRate FLOAT;

SET @RI7138_ReadmissionRate = CAST(@RI7138_Numerator AS FLOAT) / NULLIF(@RI7138_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7138 - Emergency Readmission Rate Within 30 Days - Care of the Elderly' AS Metric,
       @RI7138_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7138_Numerator AS Numerator,
       @RI7138_Denominator AS Denominator;

/* Emergency Readmission rate (within 90 days) where final COPD episode was in Respiratory Medicine 
Model Hospital ID: RI7139

Count(Spells)
RespM_COPDEM = 'Respiratory Medicine' 
AND Read90 = 1

Count(Spells)
RespM_COPDEM = 'Respiratory Medicine'


*/

-- Define the start and end dates for Metric RI7139
DECLARE @RI7139_StartDate DATE = '2023-04-01';
DECLARE @RI7139_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 90 days
DECLARE @RI7139_Numerator INT;

SELECT @RI7139_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '340'
      AND Read90 = 1
      AND Admission_Date BETWEEN @RI7139_StartDate AND @RI7139_EndDate;

-- Denominator: Total spells in Respiratory Medicine
DECLARE @RI7139_Denominator INT;

SELECT @RI7139_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '340'
      AND Admission_Date BETWEEN @RI7139_StartDate AND @RI7139_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7139_ReadmissionRate FLOAT;

SET @RI7139_ReadmissionRate = CAST(@RI7139_Numerator AS FLOAT) / NULLIF(@RI7139_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7139 - Emergency Readmission Rate Within 90 Days - Respiratory Medicine' AS Metric,
       @RI7139_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7139_Numerator AS Numerator,
       @RI7139_Denominator AS Denominator;

/* Emergency Readmission rate (within 90 days) where final COPD episode was in General Medicine 
Model Hospital ID: RI7140

Count(Spells)
RespM_COPDEM = 'General Medicine' 
AND Read90 = 1

Count(Spells)
RespM_COPDEM = 'General Medicine'


*/

-- Define the start and end dates for Metric RI7140
DECLARE @RI7140_StartDate DATE = '2023-04-01';
DECLARE @RI7140_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 90 days
DECLARE @RI7140_Numerator INT;

SELECT @RI7140_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '300'
      AND Read90 = 1
      AND Admission_Date BETWEEN @RI7140_StartDate AND @RI7140_EndDate;

-- Denominator: Total spells in General Medicine
DECLARE @RI7140_Denominator INT;

SELECT @RI7140_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '300'
      AND Admission_Date BETWEEN @RI7140_StartDate AND @RI7140_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7140_ReadmissionRate FLOAT;

SET @RI7140_ReadmissionRate = CAST(@RI7140_Numerator AS FLOAT) / NULLIF(@RI7140_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7140 - Emergency Readmission Rate Within 90 Days - General Medicine' AS Metric,
       @RI7140_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7140_Numerator AS Numerator,
       @RI7140_Denominator AS Denominator;

/* Emergency Readmission rate (within 90 days) where final COPD episode was in Care of the Elderly 
Model Hospital ID: RI7141

Count(Spells)
RespM_COPDEM = 'Care of the Elderly' 
AND Read90 = 1

Count(Spells)
RespM_COPDEM = 'Care of the Elderly'

*/

-- Define the start and end dates for Metric RI7141
DECLARE @RI7141_StartDate DATE = '2023-07-01';
DECLARE @RI7141_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 90 days
DECLARE @RI7141_Numerator INT;

SELECT @RI7141_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '430'
      AND Read90 = 1
      AND Admission_Date BETWEEN @RI7141_StartDate AND @RI7141_EndDate;

-- Denominator: Total spells in Care of the Elderly
DECLARE @RI7141_Denominator INT;

SELECT @RI7141_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '430'
      AND Admission_Date BETWEEN @RI7141_StartDate AND @RI7141_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7141_ReadmissionRate FLOAT;

SET @RI7141_ReadmissionRate = CAST(@RI7141_Numerator AS FLOAT) / NULLIF(@RI7141_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7141 - Emergency Readmission Rate Within 90 Days - Care of the Elderly' AS Metric,
       @RI7141_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7141_Numerator AS Numerator,
       @RI7141_Denominator AS Denominator;

/* COPD admissions with NIV 
Model Hospital ID: RI7142

Count(Spells)
RespM_COPDEM_NIV = 'With NIV'

*/

-- Define the start and end dates for Metric RI7142
DECLARE @RI7142_StartDate DATE = '2023-07-01';
DECLARE @RI7142_EndDate DATE = '2024-06-30';

-- Count of COPD Admissions with NIV
DECLARE @RI7142_Count INT;

SELECT @RI7142_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM_NIV = 'With NIV'
      AND Admission_Date BETWEEN @RI7142_StartDate AND @RI7142_EndDate;

-- Output the result
SELECT 'Metric RI7142 - COPD Admissions with NIV' AS Metric,
       @RI7142_Count AS Count;

/* COPD admissions without NIV 
Model Hospital ID: RI7143

Count(Spells)
RespM_COPDEM_NIV = 'Without NIV' 


*/

-- Define the start and end dates for Metric RI7143
DECLARE @RI7143_StartDate DATE = '2023-07-01';
DECLARE @RI7143_EndDate DATE = '2024-06-30';

-- Count of COPD Admissions without NIV
DECLARE @RI7143_Count INT;

SELECT @RI7143_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM_NIV = 'Without NIV'
      AND Admission_Date BETWEEN @RI7143_StartDate AND @RI7143_EndDate;

-- Output the result
SELECT 'Metric RI7143 - COPD Admissions without NIV' AS Metric,
       @RI7143_Count AS Count;

/* % of COPD admissions admitted to ITU 
Model Hospital ID: RI7144

Count(Spells)
RespM_COPDEM_ITU = 'Critical Care Admissions'

Count(Spells)
RespM_COPDEM <> 'Other'


*/

-- Define the start and end dates for Metric RI7144
DECLARE @RI7144_StartDate DATE = '2023-07-01';
DECLARE @RI7144_EndDate DATE = '2024-06-30';

-- Numerator: COPD Admissions admitted to ITU
DECLARE @RI7144_Numerator INT;

SELECT @RI7144_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM_ITU = 'Critical Care Admissions'
      AND Admission_Date BETWEEN @RI7144_StartDate AND @RI7144_EndDate;

-- Denominator: All COPD Admissions
DECLARE @RI7144_Denominator INT;

SELECT @RI7144_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_COPDEM NOT LIKE 'Other%'
      AND Admission_Date BETWEEN @RI7144_StartDate AND @RI7144_EndDate;

-- Calculate Percentage
DECLARE @RI7144_Percentage FLOAT;

SET @RI7144_Percentage = CAST(@RI7144_Numerator AS FLOAT) / NULLIF(@RI7144_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7144 - Percentage of COPD Admissions Admitted to ITU' AS Metric,
       @RI7144_Percentage AS Percentage,
       @RI7144_Numerator AS Numerator,
       @RI7144_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Asthma
------------------------------------------------------------------- */

/* Number of non-elective asthma admissions (18 years+) 
Model Hospital ID: RI7145

Count(Spells)
RespM_AsthmaEM <> 'Other'

*/

-- Define the start and end dates for Metric RI7145
DECLARE @RI7145_StartDate DATE = '2023-07-01';
DECLARE @RI7145_EndDate DATE = '2024-06-30';

-- Count of Non-Elective Asthma Admissions (18 years and over)
DECLARE @RI7145_Count INT;

SELECT @RI7145_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM NOT LIKE 'Other%'
      AND Age >= 18
      AND Admission_Date BETWEEN @RI7145_StartDate AND @RI7145_EndDate;

-- Output the result
SELECT 'Metric RI7145 - Number of Non-Elective Asthma Admissions (18 Years and Over)' AS Metric,
       @RI7145_Count AS Count;

/* Number of non-elective asthma admissions with zero length of stay 
Model Hospital ID: RI7146

Count(Spells)
RespM_AsthmaEM <> 'Other' 
AND Spell_LOS = 0

*/

-- Define the start and end dates for Metric RI7146
DECLARE @RI7146_StartDate DATE = '2023-07-01';
DECLARE @RI7146_EndDate DATE = '2024-06-30';

-- Count of Non-Elective Asthma Admissions with Zero LOS
DECLARE @RI7146_Count INT;

SELECT @RI7146_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM NOT LIKE 'Other%'
      AND Spell_LOS = 0
      AND Admission_Date BETWEEN @RI7146_StartDate AND @RI7146_EndDate;

-- Output the result
SELECT 'Metric RI7146 - Number of Non-Elective Asthma Admissions with Zero Length of Stay' AS Metric,
       @RI7146_Count AS Count;

/* Average Asthma length of stay - General Medicine 
Model Hospital ID: RI7147

Sum(Spell_LOS)
RespM_AsthmaEM = 'General Medicine'

Count(Spells)
RespM_AsthmaEM = 'General Medicine'

*/

-- Define the start and end dates for Metric RI7147
DECLARE @RI7147_StartDate DATE = '2023-07-01';
DECLARE @RI7147_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7147_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7147_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_AsthmaEM IS NOT NULL
		  AND Discharge_Treatment_Function_Code = '300'
          AND Admission_Date BETWEEN @RI7147_StartDate AND @RI7147_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7147_Total_Spells INT;

SELECT @RI7147_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
		  AND Discharge_Treatment_Function_Code = '300'
      AND Admission_Date BETWEEN @RI7147_StartDate AND @RI7147_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7147_Average_LOS FLOAT;

SET @RI7147_Average_LOS = CAST(@RI7147_Total_LOS AS FLOAT) / NULLIF(@RI7147_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7147 - Average Asthma Length of Stay - General Medicine' AS Metric,
       @RI7147_Average_LOS AS Average_LOS,
       @RI7147_Total_LOS AS Total_LOS,
       @RI7147_Total_Spells AS Total_Spells;

/* Average Asthma length of stay - Respiratory Medicine 
Model Hospital ID: RI7148

Sum(Spell_LOS)
RespM_AsthmaEM = 'Respiratory Medicine'

Count(Spells)
RespM_AsthmaEM= 'Respiratory Medicine'

*/

-- Define the start and end dates for Metric RI7148
DECLARE @RI7148_StartDate DATE = '2023-07-01';
DECLARE @RI7148_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7148_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7148_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_AsthmaEM IS NOT NULL
		  AND Discharge_Treatment_Function_Code = '340'
          AND Admission_Date BETWEEN @RI7148_StartDate AND @RI7148_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7148_Total_Spells INT;

SELECT @RI7148_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
		  AND Discharge_Treatment_Function_Code = '340'
      AND Admission_Date BETWEEN @RI7148_StartDate AND @RI7148_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7148_Average_LOS FLOAT;

SET @RI7148_Average_LOS = CAST(@RI7148_Total_LOS AS FLOAT) / NULLIF(@RI7148_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7148 - Average Asthma Length of Stay - Respiratory Medicine' AS Metric,
       @RI7148_Average_LOS AS Average_LOS,
       @RI7148_Total_LOS AS Total_LOS,
       @RI7148_Total_Spells AS Total_Spells;

/* Average Asthma length of stay - Other specialties 
Model Hospital ID: RI7149

Sum(Spell_LOS)
RespM_AsthmaEM =  'Other Specialties'

Count(Spells)
RespM_AsthmaEM= 'Other Specialties'

*/

-- Define the start and end dates for Metric RI7149
DECLARE @RI7149_StartDate DATE = '2023-07-01';
DECLARE @RI7149_EndDate DATE = '2024-06-30';

-- Total Length of Stay
DECLARE @RI7149_Total_LOS INT;

-- Aggregate LOS per unique Spell_Number
SELECT @RI7149_Total_LOS = SUM(Spell_LOS_Sum)
FROM (
    SELECT Spell_Number, MAX(Spell_LOS) AS Spell_LOS_Sum
    FROM #Spells_With_Variables
    WHERE RespM_AsthmaEM = 'Other Specialties'
		  AND Discharge_Treatment_Function_Code IN (SELECT Code FROM #CodeGroup_EmergSpecs)
		  and Age >= 17
          AND Admission_Date BETWEEN @RI7149_StartDate AND @RI7149_EndDate
    GROUP BY Spell_Number
) AS LOS_Per_Spell;

-- Number of Spells
DECLARE @RI7149_Total_Spells INT;

SELECT @RI7149_Total_Spells = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM = 'Other Specialties'
	  AND Discharge_Treatment_Function_Code IN (SELECT Code FROM #CodeGroup_EmergSpecs)
	  and Age >= 17
      AND Admission_Date BETWEEN @RI7149_StartDate AND @RI7149_EndDate;

-- Calculate Average Length of Stay
DECLARE @RI7149_Average_LOS FLOAT;

SET @RI7149_Average_LOS = CAST(@RI7149_Total_LOS AS FLOAT) / NULLIF(@RI7149_Total_Spells, 0);

-- Output the result
SELECT 'Metric RI7149 - Average Asthma Length of Stay - Other Specialties' AS Metric,
       @RI7149_Average_LOS AS Average_LOS,
       @RI7149_Total_LOS AS Total_LOS,
       @RI7149_Total_Spells AS Total_Spells;

/* Emergency Readmission rate (within 30 days) following Asthma Admission 
Model Hospital ID: RI7150

Count(Spells)
RespM_AsthmaEM <> 'Other' 
AND Read30 = 1

Count(Spells)
RespM_AsthmaEM <> 'Other'

*/

-- Define the start and end dates for Metric RI7150
DECLARE @RI7150_StartDate DATE = '2023-07-01';
DECLARE @RI7150_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days
DECLARE @RI7150_Numerator INT;

SELECT @RI7150_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM <> 'Other'
	  AND Age >= 17
      AND Read30 = 1
      AND Admission_Date BETWEEN @RI7150_StartDate AND @RI7150_EndDate;

-- Denominator: All asthma admissions
DECLARE @RI7150_Denominator INT;

SELECT @RI7150_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM <> 'Other'
	  AND Age >= 17
      AND Admission_Date BETWEEN @RI7150_StartDate AND @RI7150_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7150_ReadmissionRate FLOAT;

SET @RI7150_ReadmissionRate = CAST(@RI7150_Numerator AS FLOAT) / NULLIF(@RI7150_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7150 - Emergency Readmission Rate within 30 Days Following Asthma Admission' AS Metric,
       @RI7150_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7150_Numerator AS Numerator,
       @RI7150_Denominator AS Denominator;

/* Emergency Readmission rate (within 30 days) where final Asthma episode was in General Medicine 
Model Hospital ID: RI7151

Count(Spells)
RespM_AsthmaEM = 'General Medicine' 
AND Read30 = 1

Count(Spells)
RespM_AsthmaEM = 'General Medicine'

*/

-- Define the start and end dates for Metric RI7151
DECLARE @RI7151_StartDate DATE = '2023-07-01';
DECLARE @RI7151_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days in General Medicine
DECLARE @RI7151_Numerator INT;

SELECT @RI7151_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '300'
      AND Read30 = 1
      AND Admission_Date BETWEEN @RI7151_StartDate AND @RI7151_EndDate;

-- Denominator: All asthma admissions in General Medicine
DECLARE @RI7151_Denominator INT;

SELECT @RI7151_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '300'
      AND Admission_Date BETWEEN @RI7151_StartDate AND @RI7151_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7151_ReadmissionRate FLOAT;

SET @RI7151_ReadmissionRate = CAST(@RI7151_Numerator AS FLOAT) / NULLIF(@RI7151_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7151 - Emergency Readmission Rate within 30 Days - General Medicine' AS Metric,
       @RI7151_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7151_Numerator AS Numerator,
       @RI7151_Denominator AS Denominator;

/* Emergency Readmission rate (within 30 days) where final Asthma episode was in Respiratory Medicine
Model Hospital ID: RI7152

Count(Spells)
RespM_AsthmaEM = 'Respiratory Medicine' 
AND Read30 = 1

Count(Spells)
RespM_AsthmaEM = 'Respiratory Medicine'

*/

-- Define the start and end dates for Metric RI7152
DECLARE @RI7152_StartDate DATE = '2023-07-01';
DECLARE @RI7152_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days in Respiratory Medicine
DECLARE @RI7152_Numerator INT;

SELECT @RI7152_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '340'
      AND Read30 = 1
      AND Admission_Date BETWEEN @RI7152_StartDate AND @RI7152_EndDate;

-- Denominator: All asthma admissions in Respiratory Medicine
DECLARE @RI7152_Denominator INT;

SELECT @RI7152_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '340'
      AND Admission_Date BETWEEN @RI7152_StartDate AND @RI7152_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7152_ReadmissionRate FLOAT;

SET @RI7152_ReadmissionRate = CAST(@RI7152_Numerator AS FLOAT) / NULLIF(@RI7152_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7152 - Emergency Readmission Rate within 30 Days - Respiratory Medicine' AS Metric,
       @RI7152_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7152_Numerator AS Numerator,
       @RI7152_Denominator AS Denominator;

/* Emergency Readmission rate (within 30 days) where final Asthma episode was in Other Specialities 
Model Hospital ID: RI7153

Count(Spells)
RespM_AsthmaEM = 'Other Specialties' 
AND Read30 = 1

Count(Spells)
RespM_AsthmaEM = 'Other Specialties'

*/

-- Define the start and end dates for Metric RI7153
DECLARE @RI7153_StartDate DATE = '2023-07-01';
DECLARE @RI7153_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 30 days in Other Specialties
DECLARE @RI7153_Numerator INT;

SELECT @RI7153_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM = 'Other Specialties'
      AND Discharge_Treatment_Function_Code IN (SELECT Code FROM #CodeGroup_EmergSpecs)
      AND Read30 = 1
	  AND Age >= 17
      AND Admission_Date BETWEEN @RI7153_StartDate AND @RI7153_EndDate;

-- Denominator: All asthma admissions in Other Specialties
DECLARE @RI7153_Denominator INT;

SELECT @RI7153_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM = 'Other Specialties'
	  AND Discharge_Treatment_Function_Code IN (SELECT Code FROM #CodeGroup_EmergSpecs)
	  AND Age >= 17
      AND Admission_Date BETWEEN @RI7153_StartDate AND @RI7153_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7153_ReadmissionRate FLOAT;

SET @RI7153_ReadmissionRate = CAST(@RI7153_Numerator AS FLOAT) / NULLIF(@RI7153_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7153 - Emergency Readmission Rate within 30 Days - Other Specialties' AS Metric,
       @RI7153_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7153_Numerator AS Numerator,
       @RI7153_Denominator AS Denominator;

/* Emergency Readmission rate (within 90 days) following Asthma Admission 
Model Hospital ID: RI7154

Count(Spells)
RespM_AsthmaEM <> 'Other' 
AND Read90 = 1

Count(Spells)
RespM_AsthmaEM <> 'Other'


*/

-- Define the start and end dates for Metric RI7154
DECLARE @RI7154_StartDate DATE = '2023-04-01';
DECLARE @RI7154_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 90 days
DECLARE @RI7154_Numerator INT;

SELECT @RI7154_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM NOT LIKE 'Other%'
      AND Age >= 17
      AND Read90 = 1
      AND Admission_Date BETWEEN @RI7154_StartDate AND @RI7154_EndDate;

-- Denominator: All asthma admissions
DECLARE @RI7154_Denominator INT;

SELECT @RI7154_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM NOT LIKE 'Other%'
      AND Age >= 17
      AND Admission_Date BETWEEN @RI7154_StartDate AND @RI7154_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7154_ReadmissionRate FLOAT;

SET @RI7154_ReadmissionRate = CAST(@RI7154_Numerator AS FLOAT) / NULLIF(@RI7154_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7154 - Emergency Readmission Rate within 90 Days Following Asthma Admission' AS Metric,
       @RI7154_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7154_Numerator AS Numerator,
       @RI7154_Denominator AS Denominator;

/* Emergency Readmission rate (within 90 days) where final Asthma episode was in General Medicine 
Model Hospital ID: RI7155

Count(Spells)
RespM_AsthmaEM = 'General Medicine' 
AND Read90 = 1

Count(Spells)
RespM_AsthmaEM = 'General Medicine'


*/

-- Define the start and end dates for Metric RI7155
DECLARE @RI7155_StartDate DATE = '2023-04-01';
DECLARE @RI7155_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 90 days in General Medicine
DECLARE @RI7155_Numerator INT;

SELECT @RI7155_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '300'
      AND Read90 = 1
      AND Admission_Date BETWEEN @RI7155_StartDate AND @RI7155_EndDate;

-- Denominator: All asthma admissions in General Medicine
DECLARE @RI7155_Denominator INT;

SELECT @RI7155_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '300'
      AND Admission_Date BETWEEN @RI7155_StartDate AND @RI7155_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7155_ReadmissionRate FLOAT;

SET @RI7155_ReadmissionRate = CAST(@RI7155_Numerator AS FLOAT) / NULLIF(@RI7155_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7155 - Emergency Readmission Rate within 90 Days - General Medicine' AS Metric,
       @RI7155_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7155_Numerator AS Numerator,
       @RI7155_Denominator AS Denominator;

/* Emergency Readmission rate (within 90 days) where final Asthma episode was in Respiratory Medicine 
Model Hospital ID: RI7156

Count(Spells)
RespM_AsthmaEM = 'Respiratory Medicine' 
AND Read90 = 1

Count(Spells)
RespM_AsthmaEM = 'Respiratory Medicine'


*/

-- Define the start and end dates for Metric RI7156
DECLARE @RI7156_StartDate DATE = '2023-04-01';
DECLARE @RI7156_EndDate DATE = '2024-03-31';

-- Numerator: Readmissions within 90 days in Respiratory Medicine
DECLARE @RI7156_Numerator INT;

SELECT @RI7156_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '340'
      AND Read90 = 1
      AND Admission_Date BETWEEN @RI7156_StartDate AND @RI7156_EndDate;

-- Denominator: All asthma admissions in Respiratory Medicine
DECLARE @RI7156_Denominator INT;

SELECT @RI7156_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM IS NOT NULL
	  AND Discharge_Treatment_Function_Code = '340'
      AND Admission_Date BETWEEN @RI7156_StartDate AND @RI7156_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7156_ReadmissionRate FLOAT;

SET @RI7156_ReadmissionRate = CAST(@RI7156_Numerator AS FLOAT) / NULLIF(@RI7156_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7156 - Emergency Readmission Rate within 90 Days - Respiratory Medicine' AS Metric,
       @RI7156_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7156_Numerator AS Numerator,
       @RI7156_Denominator AS Denominator;

/* Emergency Readmission rate (within 90 days) where final Asthma episode was in Other Specialities 
Model Hospital ID: RI7157

Count(Spells)
RespM_AsthmaEM = 'Other Specialties' 
AND Read90 = 1

Count(Spells)
RespM_AsthmaEM = 'Other Specialties'


*/

-- Define the start and end dates for Metric RI7157
DECLARE @RI7157_StartDate DATE = '2023-07-01';
DECLARE @RI7157_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions within 90 days in Other Specialties
DECLARE @RI7157_Numerator INT;

SELECT @RI7157_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM = 'Other Specialties'
	  AND Discharge_Treatment_Function_Code IN (SELECT Code FROM #CodeGroup_EmergSpecs)
	  AND Age >= 17
      AND Read90 = 1
      AND Admission_Date BETWEEN @RI7157_StartDate AND @RI7157_EndDate;

-- Denominator: All asthma admissions in Other Specialties
DECLARE @RI7157_Denominator INT;

SELECT @RI7157_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM = 'Other Specialties'
	  AND Discharge_Treatment_Function_Code IN (SELECT Code FROM #CodeGroup_EmergSpecs)
	  AND Age >= 17
      AND Admission_Date BETWEEN @RI7157_StartDate AND @RI7157_EndDate;

-- Calculate Readmission Rate
DECLARE @RI7157_ReadmissionRate FLOAT;

SET @RI7157_ReadmissionRate = CAST(@RI7157_Numerator AS FLOAT) / NULLIF(@RI7157_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7157 - Emergency Readmission Rate within 90 Days - Other Specialties' AS Metric,
       @RI7157_ReadmissionRate AS ReadmissionRatePercentage,
       @RI7157_Numerator AS Numerator,
       @RI7157_Denominator AS Denominator;

/* % of admissions admitted to critical care 
Model Hospital ID: RI7158

Count(Spells)
RespM_AsthmaEM_CC = 'Critical Care Admissions'

Count(Spells)
RespM_AsthmaEM <> 'Other'

*/

-- Define the start and end dates for Metric RI7158
DECLARE @RI7158_StartDate DATE = '2023-07-01';
DECLARE @RI7158_EndDate DATE = '2024-06-30';

-- Numerator: Admissions admitted to critical care
DECLARE @RI7158_Numerator INT;

SELECT @RI7158_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM_CC = 'Critical Care Admissions'
	  AND Age >= 17
      AND Admission_Date BETWEEN @RI7158_StartDate AND @RI7158_EndDate;

-- Denominator: All asthma admissions
DECLARE @RI7158_Denominator INT;

SELECT @RI7158_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM <> 'Other'
	  AND Age >= 17
      AND Admission_Date BETWEEN @RI7158_StartDate AND @RI7158_EndDate;

-- Calculate Percentage
DECLARE @RI7158_Percentage FLOAT;

SET @RI7158_Percentage = CAST(@RI7158_Numerator AS FLOAT) / NULLIF(@RI7158_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7158 - Percentage of Admissions Admitted to Critical Care' AS Metric,
       @RI7158_Percentage AS Percentage,
       @RI7158_Numerator AS Numerator,
       @RI7158_Denominator AS Denominator;

/* % of admitted asthma patients who get a f2f or virtual follow up outpatient appointment within 2 weeks 
Model Hospital ID: RI7160

Count(OP Attendances)
RespM_FLAG_AsthmaFollowUp = 1

Count(Spells)
RespM_AsthmaEM <> 'Other'

*/

-- Define the start and end dates for Metric RI7160
DECLARE @RI7160_StartDate DATE = '2023-07-01';
DECLARE @RI7160_EndDate DATE = '2024-06-30';

-- Numerator: Asthma patients who got follow-up appointment within 2 weeks
DECLARE @RI7160_Numerator INT;

SELECT @RI7160_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_FLAG_AsthmaFollowUp = 1
      AND Admission_Date BETWEEN @RI7160_StartDate AND @RI7160_EndDate;

-- Denominator: All asthma admissions
DECLARE @RI7160_Denominator INT;

SELECT @RI7160_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_AsthmaEM NOT LIKE 'Other%'
      AND Admission_Date BETWEEN @RI7160_StartDate AND @RI7160_EndDate;

-- Calculate Percentage
DECLARE @RI7160_Percentage FLOAT;

SET @RI7160_Percentage = CAST(@RI7160_Numerator AS FLOAT) / NULLIF(@RI7160_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7160 - Percentage of Admitted Asthma Patients Who Get a Follow-Up Appointment Within 2 Weeks' AS Metric,
       @RI7160_Percentage AS Percentage,
       @RI7160_Numerator AS Numerator,
       @RI7160_Denominator AS Denominator;

/* -------------------------------------------------------------------
	Bronchiectasis
------------------------------------------------------------------- */

/* Number of elective/day case Bronchiectasis 
Model Hospital ID: RI7162

Count(Spells)
RespM_Bronchiectasis = 'All' 
AND (POD_Derived = 'EL' OR POD_Derived = 'DC')

*/

-- Define the start and end dates for Metric RI7162
DECLARE @RI7162_StartDate DATE = '2023-07-01';
DECLARE @RI7162_EndDate DATE = '2024-06-30';

-- Count of Elective/Day Case Bronchiectasis Admissions
DECLARE @RI7162_Count INT;

SELECT @RI7162_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_Bronchiectasis = 'All'
      AND POD_Derived IN ('EL', 'DC')
      AND Admission_Date BETWEEN @RI7162_StartDate AND @RI7162_EndDate;

-- Output the result
SELECT 'Metric RI7162 - Number of Elective/Day Case Bronchiectasis Admissions' AS Metric,
       @RI7162_Count AS Count;

/* Number of emergency Bronchiectasis admissions  <=2 LOS 
Model Hospital ID: RI7163

Count(Spells)
RespM_Bronchiectasis = 'All' 
AND POD_Derived = 'EM' 
AND Spell_LOS <=2


*/

-- Define the start and end dates for Metric RI7163
DECLARE @RI7163_StartDate DATE = '2023-07-01';
DECLARE @RI7163_EndDate DATE = '2024-06-30';

-- Count of Emergency Bronchiectasis Admissions with LOS ≤ 2
DECLARE @RI7163_Count INT;

SELECT @RI7163_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_Bronchiectasis = 'All'
      AND POD_Derived = 'EM'
      AND Spell_LOS <= 2
      AND Admission_Date BETWEEN @RI7163_StartDate AND @RI7163_EndDate;

-- Output the result
SELECT 'Metric RI7163 - Number of Emergency Bronchiectasis Admissions with LOS ≤ 2 Days' AS Metric,
       @RI7163_Count AS Count;

/* Rate of emergency Bronchiectasis admissions  <=2 LOS 
Model Hospital ID: RI7164

Count(Spells)
RespM_Bronchiectasis = 'All' 
AND POD_Derived = 'EM' 
AND Spell_LOS <=2

Count(Spells)
RespM_Bronchiectasis = 'All' 
AND POD_Derived = 'EM' 

*/

-- Define the start and end dates for Metric RI7164
DECLARE @RI7164_StartDate DATE = '2023-07-01';
DECLARE @RI7164_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Bronchiectasis Admissions with LOS ≤ 2
DECLARE @RI7164_Numerator INT;

SELECT @RI7164_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_Bronchiectasis = 'All'
      AND POD_Derived = 'EM'
      AND Spell_LOS <= 2
      AND Admission_Date BETWEEN @RI7164_StartDate AND @RI7164_EndDate;

-- Denominator: All Emergency Bronchiectasis Admissions
DECLARE @RI7164_Denominator INT;

SELECT @RI7164_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_Bronchiectasis = 'All'
      AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @RI7164_StartDate AND @RI7164_EndDate;

-- Calculate Rate
DECLARE @RI7164_Rate FLOAT;

SET @RI7164_Rate = CAST(@RI7164_Numerator AS FLOAT) / NULLIF(@RI7164_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7164 - Rate of Emergency Bronchiectasis Admissions with LOS ≤ 2 Days' AS Metric,
       @RI7164_Rate AS RatePercentage,
       @RI7164_Numerator AS Numerator,
       @RI7164_Denominator AS Denominator;

/* Number of emergency Bronchiectasis admissions  <=14 LOS 
Model Hospital ID: RI7165

Count(Spells)
RespM_Bronchiectasis = 'All' 
AND POD_Derived = 'EM' 
AND Spell_LOS <=14

*/

-- Define the start and end dates for Metric RI7165
DECLARE @RI7165_StartDate DATE = '2023-07-01';
DECLARE @RI7165_EndDate DATE = '2024-06-30';

-- Count of Emergency Bronchiectasis Admissions with LOS ≤ 14
DECLARE @RI7165_Count INT;

SELECT @RI7165_Count = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_Bronchiectasis = 'All'
      AND POD_Derived = 'EM'
      AND Spell_LOS <= 14
      AND Admission_Date BETWEEN @RI7165_StartDate AND @RI7165_EndDate;

-- Output the result
SELECT 'Metric RI7165 - Number of Emergency Bronchiectasis Admissions with LOS ≤ 14 Days' AS Metric,
       @RI7165_Count AS Count;

/* Rate of emergency Bronchiectasis admissions  <=14 LOS 
Model Hospital ID: RI7166

Count(Spells)
RespM_Bronchiectasis = 'All' 
AND POD_Derived = 'EM' 
AND Spell_LOS <=14

Count(Spells)
RespM_Bronchiectasis = 'All' 
AND POD_Derived = 'EM' 


*/

-- Define the start and end dates for Metric RI7166
DECLARE @RI7166_StartDate DATE = '2023-07-01';
DECLARE @RI7166_EndDate DATE = '2024-06-30';

-- Numerator: Emergency Bronchiectasis Admissions with LOS ≤ 14
DECLARE @RI7166_Numerator INT;

SELECT @RI7166_Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_Bronchiectasis = 'All'
      AND POD_Derived = 'EM'
      AND Spell_LOS <= 14
      AND Admission_Date BETWEEN @RI7166_StartDate AND @RI7166_EndDate;

-- Denominator: All Emergency Bronchiectasis Admissions
DECLARE @RI7166_Denominator INT;

SELECT @RI7166_Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE RespM_Bronchiectasis = 'All'
      AND POD_Derived = 'EM'
      AND Admission_Date BETWEEN @RI7166_StartDate AND @RI7166_EndDate;

-- Calculate Rate
DECLARE @RI7166_Rate FLOAT;

SET @RI7166_Rate = CAST(@RI7166_Numerator AS FLOAT) / NULLIF(@RI7166_Denominator, 0) * 100;

-- Output the result
SELECT 'Metric RI7166 - Rate of Emergency Bronchiectasis Admissions with LOS ≤ 14 Days' AS Metric,
       @RI7166_Rate AS RatePercentage,
       @RI7166_Numerator AS Numerator,
       @RI7166_Denominator AS Denominator;
