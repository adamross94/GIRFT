/*
	
	Script Title: GIRFT All Clinical Metrics - ENT
	Author: Adam Ross
	Version: 1.0
	Description: This script generates the figures for the All Clinical metrics section 
	of the Model Hospital dashboard. It covers the following Classes:

	- Elective Care
	- Cancer Major Surgical Resection
	- Outpatients
	- Non-Elective Care

*/

-- SQL Code Begins

-- ============================================================
-- Step 3: Create and Populate Temporary Tables for CodeGroups
-- ============================================================

-- -----------------------
-- Code Group: ENT_bucket_diagnosis_2
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ENT_bucket_diagnosis_2') IS NOT NULL
    DROP TABLE #CodeGroup_ENT_bucket_diagnosis_2;

CREATE TABLE #CodeGroup_ENT_bucket_diagnosis_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ENT_bucket_diagnosis_2
(
    Code
)
VALUES
('C0'),
('C1'),
('C3');

-- -----------------------
-- Code Group: ENT_bucket_diagnosis_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ENT_bucket_diagnosis_3') IS NOT NULL
    DROP TABLE #CodeGroup_ENT_bucket_diagnosis_3;

CREATE TABLE #CodeGroup_ENT_bucket_diagnosis_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ENT_bucket_diagnosis_3
(
    Code
)
VALUES
('C73'),
('J35');

-- -----------------------
-- Code Group: Cond_CancerHeadNeck_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_CancerHeadNeck_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_CancerHeadNeck_4;

CREATE TABLE #CodeGroup_Cond_CancerHeadNeck_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_CancerHeadNeck_4
(
    Code
)
VALUES
('C01X'),
('C051'),
('C052'),
('C07X'),
('C080'),
('C081'),
('C089'),
('C090'),
('C091'),
('C098'),
('C099'),
('C100'),
('C101'),
('C102'),
('C103'),
('C108'),
('C109'),
('C110'),
('C111'),
('C112'),
('C113'),
('C118'),
('C119'),
('C12X'),
('C130'),
('C131'),
('C132'),
('C138'),
('C139'),
('C320'),
('C321'),
('C322'),
('C328'),
('C329'),
('C73X');

-- -----------------------
-- Code Group: Cond_Tonsillitis_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cond_Tonsillitis_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cond_Tonsillitis_4;

CREATE TABLE #CodeGroup_Cond_Tonsillitis_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cond_Tonsillitis_4
(
    Code
)
VALUES
('J350'),
('J351'),
('J353');

-- -----------------------
-- Code Group: ENT_bucket_Procedure_2
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ENT_bucket_Procedure_2') IS NOT NULL
    DROP TABLE #CodeGroup_ENT_bucket_Procedure_2;

CREATE TABLE #CodeGroup_ENT_bucket_Procedure_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ENT_bucket_Procedure_2
(
    Code
)
VALUES
('C0'),
('D0'),
('D1'),
('D2'),
('E0'),
('E1'),
('E2'),
('E3'),
('E4'),
('F0'),
('F2'),
('F3'),
('F4'),
('G0'),
('S1'),
('S2'),
('S3'),
('T8'),
('U0'),
('U1'),
('U2'),
('U3'),
('V0'),
('V1'),
('V4'),
('W3'),
('W8'),
('Y4'),
('Y5'),
('Y6');

-- -----------------------
-- Code Group: MSR_HNCancer_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_MSR_HNCancer_4') IS NOT NULL
    DROP TABLE #CodeGroup_MSR_HNCancer_4;

CREATE TABLE #CodeGroup_MSR_HNCancer_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_MSR_HNCancer_4
(
    Code
)
VALUES
('C011'),
('E011'),
('E018'),
('E038'),
('E148'),
('E174'),
('E191'),
('E192'),
('E214'),
('E231'),
('E291'),
('E292'),
('E293'),
('E295'),
('E301'),
('E341'),
('E342'),
('E414'),
('F011'),
('F018'),
('F042'),
('F202'),
('F221'),
('F222'),
('F301'),
('F303'),
('F304'),
('F305'),
('F324'),
('F328'),
('F349'),
('F381'),
('F382'),
('F391'),
('F392'),
('F441'),
('F442'),
('G021'),
('G032'),
('S171'),
('S208'),
('S248'),
('S288'),
('S353'),
('T851'),
('V072'),
('V078'),
('V141'),
('V142'),
('V143'),
('V144'),
('V168'),
('V191'),
('V462');

-- -----------------------
-- Code Group: MSR_HNCancerY_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_MSR_HNCancerY_4') IS NOT NULL
    DROP TABLE #CodeGroup_MSR_HNCancerY_4;

CREATE TABLE #CodeGroup_MSR_HNCancerY_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_MSR_HNCancerY_4
(
    Code
)
VALUES
('Y462'),
('Y592'),
('Y598'),
('Y612'),
('Y631'),
('Y638'),
('Y662'),
('Y663'),
('Y664'),
('Y666');

-- -----------------------
-- Code Group: Tonsillectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tonsillectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tonsillectomy_4;

CREATE TABLE #CodeGroup_Tonsillectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tonsillectomy_4
(
    Code
)
VALUES
('F341'),
('F342'),
('F343'),
('F344'),
('F347'),
('F348'),
('F349');

-- -----------------------
-- Code Group: Grommets_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Grommets_4') IS NOT NULL
    DROP TABLE #CodeGroup_Grommets_4;

CREATE TABLE #CodeGroup_Grommets_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Grommets_4
(
    Code
)
VALUES
('D151'),
('D152'),
('D153'),
('D158'),
('D159');

-- -----------------------
-- Code Group: Removal_VentTube_TympMembrane_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Removal_VentTube_TympMembrane_4') IS NOT NULL
    DROP TABLE #CodeGroup_Removal_VentTube_TympMembrane_4;

CREATE TABLE #CodeGroup_Removal_VentTube_TympMembrane_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Removal_VentTube_TympMembrane_4
(
    Code
)
VALUES
('D203');

-- -----------------------
-- Code Group: Adenoidectomy_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Adenoidectomy_4') IS NOT NULL
    DROP TABLE #CodeGroup_Adenoidectomy_4;

CREATE TABLE #CodeGroup_Adenoidectomy_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Adenoidectomy_4
(
    Code
)
VALUES
('E201'),
('E204'),
('E208'),
('E209');

-- -----------------------
-- Code Group: Pinnaplasty_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Pinnaplasty_4') IS NOT NULL
    DROP TABLE #CodeGroup_Pinnaplasty_4;

CREATE TABLE #CodeGroup_Pinnaplasty_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Pinnaplasty_4
(
    Code
)
VALUES
('D033');

-- -----------------------
-- Code Group: Rhinoplasty_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Rhinoplasty_4') IS NOT NULL
    DROP TABLE #CodeGroup_Rhinoplasty_4;

CREATE TABLE #CodeGroup_Rhinoplasty_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Rhinoplasty_4
(
    Code
)
VALUES
('E023'),
('E024'),
('E026'),
('E073');

-- -----------------------
-- Code Group: Reduction_fracture_NasalBone_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Reduction_fracture_NasalBone_4') IS NOT NULL
    DROP TABLE #CodeGroup_Reduction_fracture_NasalBone_4;

CREATE TABLE #CodeGroup_Reduction_fracture_NasalBone_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Reduction_fracture_NasalBone_4
(
    Code
)
VALUES
('V092');

-- -----------------------
-- Code Group: Removal_wax_ExtAuditoryCanal_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Removal_wax_ExtAuditoryCanal_4') IS NOT NULL
    DROP TABLE #CodeGroup_Removal_wax_ExtAuditoryCanal_4;

CREATE TABLE #CodeGroup_Removal_wax_ExtAuditoryCanal_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Removal_wax_ExtAuditoryCanal_4
(
    Code
)
VALUES
('D072');

-- -----------------------
-- Code Group: Removal_ForeignBody_ExtAuditoryCanal_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Removal_ForeignBody_ExtAuditoryCanal_4') IS NOT NULL
    DROP TABLE #CodeGroup_Removal_ForeignBody_ExtAuditoryCanal_4;

CREATE TABLE #CodeGroup_Removal_ForeignBody_ExtAuditoryCanal_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Removal_ForeignBody_ExtAuditoryCanal_4
(
    Code
)
VALUES
('D073');

-- -----------------------
-- Code Group: Tympanoplasty_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tympanoplasty_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tympanoplasty_4;

CREATE TABLE #CodeGroup_Tympanoplasty_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tympanoplasty_4
(
    Code
)
VALUES
('D141'),
('D142'),
('D143');

-- -----------------------
-- Code Group: Cauterisation_InternalNose_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Cauterisation_InternalNose_4') IS NOT NULL
    DROP TABLE #CodeGroup_Cauterisation_InternalNose_4;

CREATE TABLE #CodeGroup_Cauterisation_InternalNose_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Cauterisation_InternalNose_4
(
    Code
)
VALUES
('E051');

-- -----------------------
-- Code Group: Removal_ForeignBody_CavityNose_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Removal_ForeignBody_CavityNose_4') IS NOT NULL
    DROP TABLE #CodeGroup_Removal_ForeignBody_CavityNose_4;

CREATE TABLE #CodeGroup_Removal_ForeignBody_CavityNose_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Removal_ForeignBody_CavityNose_4
(
    Code
)
VALUES
('E085');

-- -----------------------
-- Code Group: Septoplasty_Nose_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Septoplasty_Nose_4') IS NOT NULL
    DROP TABLE #CodeGroup_Septoplasty_Nose_4;

CREATE TABLE #CodeGroup_Septoplasty_Nose_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Septoplasty_Nose_4
(
    Code
)
VALUES
('E036');

-- -----------------------
-- Code Group: Incision_excision_frenulum_tongue_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Incision_excision_frenulum_tongue_4') IS NOT NULL
    DROP TABLE #CodeGroup_Incision_excision_frenulum_tongue_4;

CREATE TABLE #CodeGroup_Incision_excision_frenulum_tongue_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Incision_excision_frenulum_tongue_4
(
    Code
)
VALUES
('F262'),
('F263');

-- -----------------------
-- Code Group: Examination_Ear_UnderAnaesthetic_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Examination_Ear_UnderAnaesthetic_4') IS NOT NULL
    DROP TABLE #CodeGroup_Examination_Ear_UnderAnaesthetic_4;

CREATE TABLE #CodeGroup_Examination_Ear_UnderAnaesthetic_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Examination_Ear_UnderAnaesthetic_4
(
    Code
)
VALUES
('D282');

-- -----------------------
-- Code Group: Proc_Otology_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Proc_Otology_4') IS NOT NULL
    DROP TABLE #CodeGroup_Proc_Otology_4;

CREATE TABLE #CodeGroup_Proc_Otology_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Proc_Otology_4
(
    Code
)
VALUES
('D102'),
('D106'),
('D122'),
('D124'),
('D142'),
('D143'),
('D144'),
('D241');

-- -----------------------
-- Code Group: Proc_Rhinology_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Proc_Rhinology_4') IS NOT NULL
    DROP TABLE #CodeGroup_Proc_Rhinology_4;

CREATE TABLE #CodeGroup_Proc_Rhinology_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Proc_Rhinology_4
(
    Code
)
VALUES
('E023'),
('E024'),
('E036'),
('E073'),
('E081'),
('E142');

-- -----------------------
-- Code Group: Proc_ENT_Diagnostic_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Proc_ENT_Diagnostic_4') IS NOT NULL
    DROP TABLE #CodeGroup_Proc_ENT_Diagnostic_4;

CREATE TABLE #CodeGroup_Proc_ENT_Diagnostic_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Proc_ENT_Diagnostic_4
(
    Code
)
VALUES
('U051'),
('U052'),
('U053'),
('U054'),
('U055'),
('U058'),
('U059'),
('U131'),
('U132'),
('U133'),
('U134'),
('U135'),
('U136'),
('U138'),
('U139'),
('U141'),
('U142'),
('U143'),
('U144'),
('U148'),
('U149'),
('U211'),
('U212'),
('U213'),
('U214'),
('U215'),
('U216'),
('U217'),
('U218'),
('U219'),
('U338'),
('U339'),
('U368'),
('U369'),
('W361'),
('W362'),
('W363'),
('W364'),
('W365'),
('W368'),
('W369'),
('W881'),
('W888'),
('W889');

-- -----------------------
-- Code Group: MAIN_SPEC_ENT
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_MAIN_SPEC_ENT') IS NOT NULL
    DROP TABLE #CodeGroup_MAIN_SPEC_ENT;

CREATE TABLE #CodeGroup_MAIN_SPEC_ENT
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_MAIN_SPEC_ENT
(
    Code
)
VALUES
('120');

-- -----------------------
-- Code Group: TFC_Code_ENT
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_TFC_Code_ENT') IS NOT NULL
    DROP TABLE #CodeGroup_TFC_Code_ENT;

CREATE TABLE #CodeGroup_TFC_Code_ENT
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_TFC_Code_ENT
(
    Code
)
VALUES
('120'),
('215');

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
-- Code Group: ExcisionPre_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ExcisionPre_4') IS NOT NULL
    DROP TABLE #CodeGroup_ExcisionPre_4;

CREATE TABLE #CodeGroup_ExcisionPre_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ExcisionPre_4
(
    Code
)
VALUES
('D013');

-- -----------------------
-- Code Group: Excision_biopsy_1_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Excision_biopsy_1_3') IS NOT NULL
    DROP TABLE #CodeGroup_Excision_biopsy_1_3;

CREATE TABLE #CodeGroup_Excision_biopsy_1_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Excision_biopsy_1_3
(
    Code
)
VALUES
('D02');

-- -----------------------
-- Code Group: Excision_biopsy_2_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Excision_biopsy_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_Excision_biopsy_2_4;

CREATE TABLE #CodeGroup_Excision_biopsy_2_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Excision_biopsy_2_4
(
    Code
)
VALUES
('D061');

-- -----------------------
-- Code Group: PinnaplastyBilateral_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_PinnaplastyBilateral_4') IS NOT NULL
    DROP TABLE #CodeGroup_PinnaplastyBilateral_4;

CREATE TABLE #CodeGroup_PinnaplastyBilateral_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PinnaplastyBilateral_4
(
    Code
)
VALUES
('D033');

-- -----------------------
-- Code Group: ModifiedRadicalMeatoplasty_1_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ModifiedRadicalMeatoplasty_1_4') IS NOT NULL
    DROP TABLE #CodeGroup_ModifiedRadicalMeatoplasty_1_4;

CREATE TABLE #CodeGroup_ModifiedRadicalMeatoplasty_1_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ModifiedRadicalMeatoplasty_1_4
(
    Code
)
VALUES
('D102');

-- -----------------------
-- Code Group: ModifiedRadicalMeatoplasty_2_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ModifiedRadicalMeatoplasty_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_ModifiedRadicalMeatoplasty_2_4;

CREATE TABLE #CodeGroup_ModifiedRadicalMeatoplasty_2_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ModifiedRadicalMeatoplasty_2_4
(
    Code
)
VALUES
('D103');

-- -----------------------
-- Code Group: ModifiedRadicalMeatoplasty_3_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_ModifiedRadicalMeatoplasty_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_ModifiedRadicalMeatoplasty_3_4;

CREATE TABLE #CodeGroup_ModifiedRadicalMeatoplasty_3_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_ModifiedRadicalMeatoplasty_3_4
(
    Code
)
VALUES
('D104');

-- -----------------------
-- Code Group: Tympanoplasty_1_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tympanoplasty_1_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tympanoplasty_1_4;

CREATE TABLE #CodeGroup_Tympanoplasty_1_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tympanoplasty_1_4
(
    Code
)
VALUES
('D141');

-- -----------------------
-- Code Group: Tympanoplasty_2_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tympanoplasty_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tympanoplasty_2_4;

CREATE TABLE #CodeGroup_Tympanoplasty_2_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tympanoplasty_2_4
(
    Code
)
VALUES
('D142');

-- -----------------------
-- Code Group: Tympanoplasty_3_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tympanoplasty_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tympanoplasty_3_4;

CREATE TABLE #CodeGroup_Tympanoplasty_3_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tympanoplasty_3_4
(
    Code
)
VALUES
('D144');

-- -----------------------
-- Code Group: Tympanoplasty_4_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tympanoplasty_4_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tympanoplasty_4_4;

CREATE TABLE #CodeGroup_Tympanoplasty_4_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tympanoplasty_4_4
(
    Code
)
VALUES
('D148');

-- -----------------------
-- Code Group: Tympanoplasty_5_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tympanoplasty_5_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tympanoplasty_5_4;

CREATE TABLE #CodeGroup_Tympanoplasty_5_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tympanoplasty_5_4
(
    Code
)
VALUES
('D149');

-- -----------------------
-- Code Group: Tympanoplasty_6_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tympanoplasty_6_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tympanoplasty_6_4;

CREATE TABLE #CodeGroup_Tympanoplasty_6_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tympanoplasty_6_4
(
    Code
)
VALUES
('D143');

-- -----------------------
-- Code Group: Myringotomy_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Myringotomy_3') IS NOT NULL
    DROP TABLE #CodeGroup_Myringotomy_3;

CREATE TABLE #CodeGroup_Myringotomy_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Myringotomy_3
(
    Code
)
VALUES
('D15');

-- -----------------------
-- Code Group: Ossiculoplasty_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Ossiculoplasty_3') IS NOT NULL
    DROP TABLE #CodeGroup_Ossiculoplasty_3;

CREATE TABLE #CodeGroup_Ossiculoplasty_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Ossiculoplasty_3
(
    Code
)
VALUES
('D16');

-- -----------------------
-- Code Group: RemovalOfVentilationDevice_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_RemovalOfVentilationDevice_4') IS NOT NULL
    DROP TABLE #CodeGroup_RemovalOfVentilationDevice_4;

CREATE TABLE #CodeGroup_RemovalOfVentilationDevice_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_RemovalOfVentilationDevice_4
(
    Code
)
VALUES
('D203');

-- -----------------------
-- Code Group: Septorhinoplasty_1_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Septorhinoplasty_1_4') IS NOT NULL
    DROP TABLE #CodeGroup_Septorhinoplasty_1_4;

CREATE TABLE #CodeGroup_Septorhinoplasty_1_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Septorhinoplasty_1_4
(
    Code
)
VALUES
('E023');

-- -----------------------
-- Code Group: Septorhinoplasty_2_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Septorhinoplasty_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_Septorhinoplasty_2_4;

CREATE TABLE #CodeGroup_Septorhinoplasty_2_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Septorhinoplasty_2_4
(
    Code
)
VALUES
('E024');

-- -----------------------
-- Code Group: Septorhinoplasty_3_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Septorhinoplasty_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_Septorhinoplasty_3_4;

CREATE TABLE #CodeGroup_Septorhinoplasty_3_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Septorhinoplasty_3_4
(
    Code
)
VALUES
('E073');

-- -----------------------
-- Code Group: Septoplasty_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Septoplasty_4') IS NOT NULL
    DROP TABLE #CodeGroup_Septoplasty_4;

CREATE TABLE #CodeGroup_Septoplasty_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Septoplasty_4
(
    Code
)
VALUES
('E036');

-- -----------------------
-- Code Group: NasalSeptum_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_NasalSeptum_4') IS NOT NULL
    DROP TABLE #CodeGroup_NasalSeptum_4;

CREATE TABLE #CodeGroup_NasalSeptum_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_NasalSeptum_4
(
    Code
)
VALUES
('E051');

-- -----------------------
-- Code Group: OperationsOnTurbinates_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_OperationsOnTurbinates_3') IS NOT NULL
    DROP TABLE #CodeGroup_OperationsOnTurbinates_3;

CREATE TABLE #CodeGroup_OperationsOnTurbinates_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_OperationsOnTurbinates_3
(
    Code
)
VALUES
('E04');

-- -----------------------
-- Code Group: Polypectomy_1_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Polypectomy_1_4') IS NOT NULL
    DROP TABLE #CodeGroup_Polypectomy_1_4;

CREATE TABLE #CodeGroup_Polypectomy_1_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Polypectomy_1_4
(
    Code
)
VALUES
('E081');

-- -----------------------
-- Code Group: Polypectomy_2_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Polypectomy_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_Polypectomy_2_4;

CREATE TABLE #CodeGroup_Polypectomy_2_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Polypectomy_2_4
(
    Code
)
VALUES
('E082');

-- -----------------------
-- Code Group: Polypectomy_3_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Polypectomy_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_Polypectomy_3_4;

CREATE TABLE #CodeGroup_Polypectomy_3_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Polypectomy_3_4
(
    Code
)
VALUES
('E088');

-- -----------------------
-- Code Group: Polypectomy_4_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Polypectomy_4_4') IS NOT NULL
    DROP TABLE #CodeGroup_Polypectomy_4_4;

CREATE TABLE #CodeGroup_Polypectomy_4_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Polypectomy_4_4
(
    Code
)
VALUES
('E089');

-- -----------------------
-- Code Group: Intranasal_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Intranasal_4') IS NOT NULL
    DROP TABLE #CodeGroup_Intranasal_4;

CREATE TABLE #CodeGroup_Intranasal_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Intranasal_4
(
    Code
)
VALUES
('E133');

-- -----------------------
-- Code Group: FESSEndoscopic_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_FESSEndoscopic_4') IS NOT NULL
    DROP TABLE #CodeGroup_FESSEndoscopic_4;

CREATE TABLE #CodeGroup_FESSEndoscopic_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_FESSEndoscopic_4
(
    Code
)
VALUES
('E142');

-- -----------------------
-- Code Group: Anaesthesia_1_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Anaesthesia_1_4') IS NOT NULL
    DROP TABLE #CodeGroup_Anaesthesia_1_4;

CREATE TABLE #CodeGroup_Anaesthesia_1_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Anaesthesia_1_4
(
    Code
)
VALUES
('V091');

-- -----------------------
-- Code Group: Anaesthesia_2_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Anaesthesia_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_Anaesthesia_2_4;

CREATE TABLE #CodeGroup_Anaesthesia_2_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Anaesthesia_2_4
(
    Code
)
VALUES
('V092');

-- -----------------------
-- Code Group: AdenoidSurgery_1_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AdenoidSurgery_1_4') IS NOT NULL
    DROP TABLE #CodeGroup_AdenoidSurgery_1_4;

CREATE TABLE #CodeGroup_AdenoidSurgery_1_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AdenoidSurgery_1_4
(
    Code
)
VALUES
('E201');

-- -----------------------
-- Code Group: AdenoidSurgery_2_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AdenoidSurgery_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_AdenoidSurgery_2_4;

CREATE TABLE #CodeGroup_AdenoidSurgery_2_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AdenoidSurgery_2_4
(
    Code
)
VALUES
('E202');

-- -----------------------
-- Code Group: AdenoidSurgery_3_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AdenoidSurgery_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_AdenoidSurgery_3_4;

CREATE TABLE #CodeGroup_AdenoidSurgery_3_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AdenoidSurgery_3_4
(
    Code
)
VALUES
('E204');

-- -----------------------
-- Code Group: AdenoidSurgery_4_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AdenoidSurgery_4_4') IS NOT NULL
    DROP TABLE #CodeGroup_AdenoidSurgery_4_4;

CREATE TABLE #CodeGroup_AdenoidSurgery_4_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AdenoidSurgery_4_4
(
    Code
)
VALUES
('E208');

-- -----------------------
-- Code Group: AdenoidSurgery_5_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AdenoidSurgery_5_4') IS NOT NULL
    DROP TABLE #CodeGroup_AdenoidSurgery_5_4;

CREATE TABLE #CodeGroup_AdenoidSurgery_5_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AdenoidSurgery_5_4
(
    Code
)
VALUES
('E209');

-- -----------------------
-- Code Group: AdenoidSurgery_6_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_AdenoidSurgery_6_4') IS NOT NULL
    DROP TABLE #CodeGroup_AdenoidSurgery_6_4;

CREATE TABLE #CodeGroup_AdenoidSurgery_6_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_AdenoidSurgery_6_4
(
    Code
)
VALUES
('E203');

-- -----------------------
-- Code Group: Therapeutic_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Therapeutic_3') IS NOT NULL
    DROP TABLE #CodeGroup_Therapeutic_3;

CREATE TABLE #CodeGroup_Therapeutic_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Therapeutic_3
(
    Code
)
VALUES
('E24');

-- -----------------------
-- Code Group: Diagnosticendoscopic_1_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Diagnosticendoscopic_1_3') IS NOT NULL
    DROP TABLE #CodeGroup_Diagnosticendoscopic_1_3;

CREATE TABLE #CodeGroup_Diagnosticendoscopic_1_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Diagnosticendoscopic_1_3
(
    Code
)
VALUES
('E25');

-- -----------------------
-- Code Group: Diagnosticendoscopic_2_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Diagnosticendoscopic_2_3') IS NOT NULL
    DROP TABLE #CodeGroup_Diagnosticendoscopic_2_3;

CREATE TABLE #CodeGroup_Diagnosticendoscopic_2_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Diagnosticendoscopic_2_3
(
    Code
)
VALUES
('E36');

-- -----------------------
-- Code Group: Diagnosticendoscopic_3_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Diagnosticendoscopic_3_3') IS NOT NULL
    DROP TABLE #CodeGroup_Diagnosticendoscopic_3_3;

CREATE TABLE #CodeGroup_Diagnosticendoscopic_3_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Diagnosticendoscopic_3_3
(
    Code
)
VALUES
('E37');

-- -----------------------
-- Code Group: Tonsillectomy_1_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tonsillectomy_1_3') IS NOT NULL
    DROP TABLE #CodeGroup_Tonsillectomy_1_3;

CREATE TABLE #CodeGroup_Tonsillectomy_1_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tonsillectomy_1_3
(
    Code
)
VALUES
('F34');

-- -----------------------
-- Code Group: Tonsillectomy_2_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tonsillectomy_2_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tonsillectomy_2_4;

CREATE TABLE #CodeGroup_Tonsillectomy_2_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tonsillectomy_2_4
(
    Code
)
VALUES
('D345');

-- -----------------------
-- Code Group: Tonsillectomy_3_4
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Tonsillectomy_3_4') IS NOT NULL
    DROP TABLE #CodeGroup_Tonsillectomy_3_4;

CREATE TABLE #CodeGroup_Tonsillectomy_3_4
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Tonsillectomy_3_4
(
    Code
)
VALUES
('F346');

-- -----------------------
-- Code Group: Lasersurgery_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_Lasersurgery_3') IS NOT NULL
    DROP TABLE #CodeGroup_Lasersurgery_3;

CREATE TABLE #CodeGroup_Lasersurgery_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_Lasersurgery_3
(
    Code
)
VALUES
('E34');

-- -----------------------
-- Code Group: PS_Adenoid_4_1
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_PS_Adenoid_4_1') IS NOT NULL
    DROP TABLE #CodeGroup_PS_Adenoid_4_1;

CREATE TABLE #CodeGroup_PS_Adenoid_4_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PS_Adenoid_4_1
(
    Code
)
VALUES
('E201'),
('E202'),
('E208'),
('E209'),
('E204');

-- -----------------------
-- Code Group: PS_Adenoid_4_2
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_PS_Adenoid_4_2') IS NOT NULL
    DROP TABLE #CodeGroup_PS_Adenoid_4_2;

CREATE TABLE #CodeGroup_PS_Adenoid_4_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PS_Adenoid_4_2
(
    Code
)
VALUES
('E203');

-- -----------------------
-- Code Group: PS_Tonsillectomy_3_1
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_PS_Tonsillectomy_3_1') IS NOT NULL
    DROP TABLE #CodeGroup_PS_Tonsillectomy_3_1;

CREATE TABLE #CodeGroup_PS_Tonsillectomy_3_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PS_Tonsillectomy_3_1
(
    Code
)
VALUES
('F34');

-- -----------------------
-- Code Group: PS_Tonsillectomy_4_2
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_PS_Tonsillectomy_4_2') IS NOT NULL
    DROP TABLE #CodeGroup_PS_Tonsillectomy_4_2;

CREATE TABLE #CodeGroup_PS_Tonsillectomy_4_2
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PS_Tonsillectomy_4_2
(
    Code
)
VALUES
('F345');

-- -----------------------
-- Code Group: PS_Tonsillectomy_4_3
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_PS_Tonsillectomy_4_3') IS NOT NULL
    DROP TABLE #CodeGroup_PS_Tonsillectomy_4_3;

CREATE TABLE #CodeGroup_PS_Tonsillectomy_4_3
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PS_Tonsillectomy_4_3
(
    Code
)
VALUES
('F346');

-- -----------------------
-- Code Group: PS_Myringotomy_3_1
-- -----------------------

IF OBJECT_ID('tempdb..#CodeGroup_PS_Myringotomy_3_1') IS NOT NULL
    DROP TABLE #CodeGroup_PS_Myringotomy_3_1;

CREATE TABLE #CodeGroup_PS_Myringotomy_3_1
(
    Code VARCHAR(10) PRIMARY KEY
);

INSERT INTO #CodeGroup_PS_Myringotomy_3_1
(
    Code
)
VALUES
('D15');

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

-- =========================================================
-- Step 4: Create and Populate #Spells_With_Variables Table
-- =========================================================

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
    ENT_Procs VARCHAR(100),
    ENT_Procs1 VARCHAR(100),
    ENT_Condition VARCHAR(100),
    ENT_CancerMSR VARCHAR(100),
    ENT_AgeGroup VARCHAR(100),
    ENT_MainSpecialty VARCHAR(100),
    ENT_TreatmentFunction VARCHAR(100),
    ENT_NoProcedure VARCHAR(100),
    ENT_Dominant_Procedure VARCHAR(100),
    ENT_Planned_Proc_not_Carried_Out_IP VARCHAR(100),
    ENT_Procedure VARCHAR(100),
    ENT_Cancel VARCHAR(100),
    Read30 BIT
        DEFAULT 0,
    ENT_FLAG_RhinologyProc1Yr BIT
        DEFAULT 0,
    ENT_FLAG_OtologyProc1Yr BIT
        DEFAULT 0
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
FROM DB_Medway.[dbo].[PAS_IP_Spell_Frozen] ips
    LEFT JOIN DB_Medway.[dbo].[PAS_IP_Episode_Frozen] ipe
        ON ips.Spell_Number = ipe.Spell_Number
           AND ips.Sector = ipe.Sector
WHERE ips.Admission_Date
      BETWEEN @OverallStartDate AND @OverallEndDate
      AND ips.Org_Code_Provider = 'RPA'
      AND ips.Sector = 'MED';

-- =========================================================
-- Step 5: Update #Spells_With_Variables Table
-- =========================================================

-- Update ENT_FLAG_OtologyProc1Yr in #Spells_With_Variables
UPDATE SWV
SET ENT_FLAG_OtologyProc1Yr = 1
FROM #Spells_With_Variables SWV
WHERE
    -- Index Admission Criteria
    SWV.ENT_Procs1 = 'Otology'
    AND SWV.POD_Derived IN ( 'DC', 'EL' )
    AND EXISTS
(
    -- Return Admission Criteria
    SELECT 1
    FROM #Spells_With_Variables SWV_Return
    WHERE SWV_Return.PAS_Number = SWV.PAS_Number
          AND SWV_Return.Admission_Date > SWV.Admission_Date
          AND SWV_Return.Admission_Date <= DATEADD(YEAR, 1, SWV.Admission_Date)
		  AND SWV_Return.ENT_Procedure IS NOT NULL
);

-- Update ENT_FLAG_RhinologyProc1Yr in #Spells_With_Variables
UPDATE SWV
SET ENT_FLAG_RhinologyProc1Yr = 1
FROM #Spells_With_Variables SWV
WHERE
    -- Index Admission Criteria
    SWV.ENT_Procs1 = 'Rhinology'
    AND SWV.POD_Derived IN ( 'DC', 'EL' )
    AND SWV.ENT_AgeGroup = 'Adult'
    AND EXISTS
(
    -- Return Admission Criteria
    SELECT 1
    FROM #Spells_With_Variables SWV_Return
    WHERE SWV_Return.PAS_Number = SWV.PAS_Number
          AND SWV_Return.Admission_Date > SWV.Admission_Date
          AND SWV_Return.Admission_Date <= DATEADD(YEAR, 1, SWV.Admission_Date)
		  AND SWV_Return.ENT_Procedure IS NOT NULL
);

-- Update Read30 flag
UPDATE SWV
SET Read30 = 1
FROM #Spells_With_Variables SWV
    LEFT JOIN [M0026_Readmissions] ram
        ON SWV.Spell_Number = ram.Parent_Spell_Number
           AND SWV.Sector = ram.Parent_Sector_Code
WHERE ram.M0026b_Readmission_Numerator_Less_30_Day = 1;

-- ========================================
-- Combined Update for 'ENT_Procs'
-- ========================================

UPDATE SWV
SET ENT_Procs = CASE
                    -- Priority 1: Tonsillectomy
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp1
                             WHERE ipp1.Episode_Number = ipe.Episode_Number
                                   AND ipp1.Sector = ipe.Sector
                                   AND LEFT(ipp1.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Tonsillectomy_4
                                       )
                         ) THEN
                        'Tonsillectomy'

                                  -- Priority 2: Grommets
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp2
                             WHERE ipp2.Episode_Number = ipe.Episode_Number
                                   AND ipp2.Sector = ipe.Sector
                                   AND LEFT(ipp2.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Grommets_4
                                       )
                         ) THEN
                        'Grommets'

                                  -- Priority 3: RemoveTubeEar
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp3
                             WHERE ipp3.Episode_Number = ipe.Episode_Number
                                   AND ipp3.Sector = ipe.Sector
                                   AND LEFT(ipp3.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Removal_VentTube_TympMembrane_4
                                       )
                         ) THEN
                        'RemoveTubeEar'

                                  -- Priority 4: Adenoidectomy
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp4
                             WHERE ipp4.Episode_Number = ipe.Episode_Number
                                   AND ipp4.Sector = ipe.Sector
                                   AND LEFT(ipp4.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Adenoidectomy_4
                                       )
                         ) THEN
                        'Adenoidectomy'

                                  -- Priority 5: Pinnaplasty
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp5
                             WHERE ipp5.Episode_Number = ipe.Episode_Number
                                   AND ipp5.Sector = ipe.Sector
                                   AND LEFT(ipp5.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Pinnaplasty_4
                                       )
                         ) THEN
                        'Pinnaplasty'

                                  -- Priority 6: Rhinoplasty
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp6
                             WHERE ipp6.Episode_Number = ipe.Episode_Number
                                   AND ipp6.Sector = ipe.Sector
                                   AND LEFT(ipp6.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Rhinoplasty_4
                                       )
                         ) THEN
                        'Rhinoplasty'

                                  -- Priority 7: FractureNose
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp7
                             WHERE ipp7.Episode_Number = ipe.Episode_Number
                                   AND ipp7.Sector = ipe.Sector
                                   AND LEFT(ipp7.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Reduction_fracture_NasalBone_4
                                       )
                         ) THEN
                        'FractureNose'

                                  -- Priority 8: EarWax
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp8
                             WHERE ipp8.Episode_Number = ipe.Episode_Number
                                   AND ipp8.Sector = ipe.Sector
                                   AND LEFT(ipp8.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Removal_wax_ExtAuditoryCanal_4
                                       )
                         ) THEN
                        'EarWax'

                                  -- Priority 9: EarForeignBody
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp9
                             WHERE ipp9.Episode_Number = ipe.Episode_Number
                                   AND ipp9.Sector = ipe.Sector
                                   AND LEFT(ipp9.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Removal_ForeignBody_ExtAuditoryCanal_4
                                       )
                         ) THEN
                        'EarForeignBody'

                                  -- Priority 10: TympanoplastyExcCombined
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp10
                             WHERE ipp10.Episode_Number = ipe.Episode_Number
                                   AND ipp10.Sector = ipe.Sector
                                   AND LEFT(ipp10.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Tympanoplasty_4
                                       )
                         ) THEN
                        'TympanoplastyExcCombined'

                                  -- Priority 11: CauteriseNose
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp11
                             WHERE ipp11.Episode_Number = ipe.Episode_Number
                                   AND ipp11.Sector = ipe.Sector
                                   AND LEFT(ipp11.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Cauterisation_InternalNose_4
                                       )
                         ) THEN
                        'CauteriseNose'

                                  -- Priority 12: NoseForeignBody
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp12
                             WHERE ipp12.Episode_Number = ipe.Episode_Number
                                   AND ipp12.Sector = ipe.Sector
                                   AND LEFT(ipp12.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Removal_ForeignBody_CavityNose_4
                                       )
                         ) THEN
                        'NoseForeignBody'

                                  -- Priority 13: SeptoplastyNose
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp13
                             WHERE ipp13.Episode_Number = ipe.Episode_Number
                                   AND ipp13.Sector = ipe.Sector
                                   AND LEFT(ipp13.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Septoplasty_Nose_4
                                       )
                         ) THEN
                        'SeptoplastyNose'

                                  -- Priority 14: FrenulumTongue
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp14
                             WHERE ipp14.Episode_Number = ipe.Episode_Number
                                   AND ipp14.Sector = ipe.Sector
                                   AND LEFT(ipp14.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Incision_excision_frenulum_tongue_4
                                       )
                         ) THEN
                        'FrenulumTongue'

                                  -- Priority 15: EarAnaesthetic
                    WHEN EXISTS
                         (
                             SELECT 1
                             FROM [PAS_IP_Procedure_Normalised] ipp15
                             WHERE ipp15.Episode_Number = ipe.Episode_Number
                                   AND ipp15.Sector = ipe.Sector
                                   AND LEFT(ipp15.Procedure_Code, 4)IN
                                       (
                                           SELECT Code FROM #CodeGroup_Examination_Ear_UnderAnaesthetic_4
                                       )
                         ) THEN
                        'EarAnaesthetic'
                    ELSE
                        ENT_Procs -- Retain existing value if no conditions are met
                END
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector;

-- ========================================
-- Combined Update for 'ENT_Procs1'
-- ========================================

UPDATE SWV
SET ENT_Procs1 = CASE
                     -- Priority 1: Rhinology
                     WHEN EXISTS
                          (
                              SELECT 1
                              FROM [PAS_IP_Procedure_Normalised] ipp1
                              WHERE ipp1.Episode_Number = ipe.Episode_Number
                                    AND ipp1.Sector = ipe.Sector
                                    AND LEFT(ipp1.Procedure_Code, 4)IN
                                        (
                                            SELECT Code FROM #CodeGroup_Proc_Rhinology_4
                                        )
                          ) THEN
                         'Rhinology'

                     -- Priority 2: Otology
                     WHEN EXISTS
                          (
                              SELECT 1
                              FROM [PAS_IP_Procedure_Normalised] ipp2
                              WHERE ipp2.Episode_Number = ipe.Episode_Number
                                    AND ipp2.Sector = ipe.Sector
                                    AND LEFT(ipp2.Procedure_Code, 4)IN
                                        (
                                            SELECT Code FROM #CodeGroup_Proc_Otology_4
                                        )
                          ) THEN
                         'Otology'
                     ELSE
                         ENT_Procs1
                 END
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector;

-- ========================================
-- Combined Update for 'ENT_Condition'
-- ========================================

UPDATE SWV
SET ENT_Condition = CASE
                        -- Priority 1: H&Ncancer
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Diagnosis_Normalised] ipd1
                                 WHERE ipd1.Episode_Number = ipe.Episode_Number
                                       AND ipd1.Sector = ipe.Sector
                                       AND LEFT(ipd1.Diagnosis_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Cond_CancerHeadNeck_4
                                           )
                             ) THEN
                            'H&Ncancer'

                        -- Priority 2: Tonsillitis
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Diagnosis_Normalised] ipd2
                                 WHERE ipd2.Episode_Number = ipe.Episode_Number
                                       AND ipd2.Sector = ipe.Sector
                                       AND LEFT(ipd2.Diagnosis_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Cond_Tonsillitis_4
                                           )
                             ) THEN
                            'Tonsillitis'
                        ELSE
                            ENT_Condition
                    END
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector;

-- ========================================
-- Combined Update for 'ENT_CancerMSR'
-- ========================================

UPDATE SWV
SET ENT_CancerMSR = CASE
                        WHEN
    -- Procedure Code Condition
    EXISTS
    (
        SELECT 1
        FROM [PAS_IP_Procedure_Normalised] ipp
        WHERE ipp.Episode_Number = ipe.Episode_Number
              AND ipp.Sector = ipe.Sector
              AND LEFT(ipp.Procedure_Code, 4)IN
                  (
                      SELECT Code FROM #CodeGroup_MSR_HNCancer_4
                  )
    )
    AND
    -- Diagnosis Code Condition
    EXISTS
    (
        SELECT 1
        FROM [PAS_IP_Diagnosis_Normalised] ipd
        WHERE ipd.Episode_Number = ipe.Episode_Number
              AND ipd.Sector = ipe.Sector
              AND LEFT(ipd.Diagnosis_Code, 4)IN
                  (
                      SELECT Code FROM #CodeGroup_Cond_CancerHeadNeck_4
                  )
    ) THEN
                            'Cancer MSR'
                        ELSE
                            ENT_CancerMSR
                    END
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector;

-- ========================================
-- Combined Update for 'ENT_AgeGroup'
-- ========================================

UPDATE #Spells_With_Variables
SET ENT_AgeGroup = CASE
                       -- Priority 1: Child
                       WHEN Age
                            BETWEEN 0 AND 16 THEN
                           'Child'
                       -- Priority 2: Adult
                       WHEN Age >= 17 THEN
                           'Adult'
                       ELSE
                           ENT_AgeGroup
                   END;

-- ========================================
-- Update for 'ENT_MainSpecialty'
-- ========================================

UPDATE #Spells_With_Variables
SET ENT_MainSpecialty = CASE
                            WHEN MAINSPEF IN ( '120' ) THEN
                                'ENT' -- Replace '120' with codes from 'MAIN_SPEC_ENT' code group
                            ELSE
                                ENT_MainSpecialty
                        END;

-- ========================================
-- Update for 'ENT_TreatmentFunction'
-- ========================================

UPDATE #Spells_With_Variables
SET ENT_TreatmentFunction = CASE
                                WHEN TRETSPEF IN ( '120', '215' ) THEN
                                    'ENT' -- Replace with codes from 'TFC_Code_ENT' code group
                                ELSE
                                    ENT_TreatmentFunction
                            END;

-- ========================================
-- Update for 'ENT_Planned_Proc_not_Carried_Out_IP'
-- ========================================

UPDATE #Spells_With_Variables
SET ENT_Planned_Proc_not_Carried_Out_IP = CASE
                                              WHEN LEFT(SpellHRG_Current, 4) IN ( 'WH50' ) THEN
                                                  'PlannedProcNotCarriedOut' -- Replace with codes from 'WH50_4' code group
                                              ELSE
                                                  ENT_Planned_Proc_not_Carried_Out_IP
                                          END;

-- ========================================
-- Combined Update for 'ENT_Cancel'
-- ========================================

UPDATE SWV
SET ENT_Cancel = CASE
                     -- Priority 1: Clinical_Reason
                     WHEN EXISTS
                          (
                              SELECT 1
                              FROM [PAS_IP_Diagnosis_Normalised] ipd1
                                  LEFT JOIN DB_Medway.dbo.PAS_IP_Episode ipe
                                      ON ipd1.Episode_Number = ipe.Episode_Number
                                         AND ipd1.Sector = ipe.Sector
                              WHERE ipe.Spell_Number = SWV.Spell_Number
                                    AND ipe.Sector = SWV.Sector
                                    AND LEFT(ipd1.Diagnosis_Code, 4)IN
                                        (
                                            SELECT Code FROM #CodeGroup_CancelClinical_4
                                        )
                          ) THEN
                         'Clinical_Reason'

                     -- Priority 2: NonClinical_Reason
                     WHEN EXISTS
                          (
                              SELECT 1
                              FROM [PAS_IP_Diagnosis_Normalised] ipd2
                                  LEFT JOIN DB_Medway.dbo.PAS_IP_Episode ipe
                                      ON ipd2.Episode_Number = ipe.Episode_Number
                                         AND ipd2.Sector = ipe.Sector
                              WHERE ipe.Spell_Number = SWV.Spell_Number
                                    AND ipd2.Sector = SWV.Sector
                                    AND LEFT(ipd2.Diagnosis_Code, 4)IN
                                        (
                                            SELECT Code FROM #CodeGroup_CancelNonClinical_4
                                        )
                          ) THEN
                         'NonClinical_Reason'
                     ELSE
                         ENT_Cancel
                 END
FROM #Spells_With_Variables SWV;

-- ========================================
-- Combined Update for 'ENT_Procedure'
-- ========================================

UPDATE SWV
SET ENT_Procedure = CASE
                        -- Priority 1: Excision pre-auricular abnormality
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp1
                                 WHERE ipp1.Episode_Number = ipe.Episode_Number
                                       AND ipp1.Sector = ipe.Sector
                                       AND LEFT(ipp1.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_ExcisionPre_4
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Excision pre-auricular abnormality'

                                          -- Priority 2: Excision/biopsy of lesion of pinna
                        WHEN (
                                 EXISTS
                                 (
                                     SELECT 1
                                     FROM [PAS_IP_Procedure_Normalised] ipp2a
                                     WHERE ipp2a.Episode_Number = ipe.Episode_Number
                                           AND ipp2a.Sector = ipe.Sector
                                           AND LEFT(ipp2a.Procedure_Code, 3)IN
                                               (
                                                   SELECT Code FROM #CodeGroup_Excision_biopsy_1_3
                                               )
                                 )
                                 OR EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp2b
                                        WHERE ipp2b.Episode_Number = ipe.Episode_Number
                                              AND ipp2b.Sector = ipe.Sector
                                              AND LEFT(ipp2b.Procedure_Code, 4)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_Excision_biopsy_2_4
                                                  )
                                    )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Excision/biopsy of lesion of pinna'

                                          -- Priority 3: Pinnaplasty (including bilateral)
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp3
                                 WHERE ipp3.Episode_Number = ipe.Episode_Number
                                       AND ipp3.Sector = ipe.Sector
                                       AND LEFT(ipp3.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_PinnaplastyBilateral_4
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Pinnaplasty (including bilateral)'

                                          -- Priority 4: Modified radical mastoidectomy (including meatoplasty)
                        WHEN (
                                 EXISTS
                                 (
                                     SELECT 1
                                     FROM [PAS_IP_Procedure_Normalised] ipp4a
                                     WHERE ipp4a.Episode_Number = ipe.Episode_Number
                                           AND ipp4a.Sector = ipe.Sector
                                           AND LEFT(ipp4a.Procedure_Code, 4)IN
                                               (
                                                   SELECT Code FROM #CodeGroup_ModifiedRadicalMeatoplasty_1_4
                                               )
                                 )
                                 OR EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp4b
                                        WHERE ipp4b.Episode_Number = ipe.Episode_Number
                                              AND ipp4b.Sector = ipe.Sector
                                              AND LEFT(ipp4b.Procedure_Code, 4)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_ModifiedRadicalMeatoplasty_2_4
                                                  )
                                    )
                                 OR EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp4c
                                        WHERE ipp4c.Episode_Number = ipe.Episode_Number
                                              AND ipp4c.Sector = ipe.Sector
                                              AND LEFT(ipp4c.Procedure_Code, 4)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_ModifiedRadicalMeatoplasty_3_4
                                                  )
                                    )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Modified radical mastoidectomy (including meatoplasty)'

                                          -- Priority 5: Tympanoplasty
                        WHEN (
                                 (
                                     EXISTS
                                     (
                                         SELECT 1
                                         FROM [PAS_IP_Procedure_Normalised] ipp5a
                                         WHERE ipp5a.Episode_Number = ipe.Episode_Number
                                               AND ipp5a.Sector = ipe.Sector
                                               AND LEFT(ipp5a.Procedure_Code, 4)IN
                                                   (
                                                       SELECT Code FROM #CodeGroup_Tympanoplasty_1_4
                                                   )
                                     )
                                     OR EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp5b
                                            WHERE ipp5b.Episode_Number = ipe.Episode_Number
                                                  AND ipp5b.Sector = ipe.Sector
                                                  AND LEFT(ipp5b.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_Tympanoplasty_2_4
                                                      )
                                        )
                                     OR EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp5c
                                            WHERE ipp5c.Episode_Number = ipe.Episode_Number
                                                  AND ipp5c.Sector = ipe.Sector
                                                  AND LEFT(ipp5c.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_Tympanoplasty_3_4
                                                      )
                                        )
                                     OR EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp5d
                                            WHERE ipp5d.Episode_Number = ipe.Episode_Number
                                                  AND ipp5d.Sector = ipe.Sector
                                                  AND LEFT(ipp5d.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_Tympanoplasty_4_4
                                                      )
                                        )
                                     OR EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp5e
                                            WHERE ipp5e.Episode_Number = ipe.Episode_Number
                                                  AND ipp5e.Sector = ipe.Sector
                                                  AND LEFT(ipp5e.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_Tympanoplasty_5_4
                                                      )
                                        )
                                 )
                                 AND NOT EXISTS
                                         (
                                             SELECT 1
                                             FROM [PAS_IP_Procedure_Normalised] ipp5f
                                             WHERE ipp5f.Episode_Number = ipe.Episode_Number
                                                   AND ipp5f.Sector = ipe.Sector
                                                   AND LEFT(ipp5f.Procedure_Code, 4)IN
                                                       (
                                                           SELECT Code FROM #CodeGroup_Tympanoplasty_6_4
                                                       )
                                         )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Tympanoplasty'

                                          -- Priority 6: Myringotomy � insertion of tube, suction clearance
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp6
                                 WHERE ipp6.Episode_Number = ipe.Episode_Number
                                       AND ipp6.Sector = ipe.Sector
                                       AND LEFT(ipp6.Procedure_Code, 3)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Myringotomy_3
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Myringotomy � insertion of tube, suction clearance'

                                          -- Priority 7: Ossiculoplasty
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp7
                                 WHERE ipp7.Episode_Number = ipe.Episode_Number
                                       AND ipp7.Sector = ipe.Sector
                                       AND LEFT(ipp7.Procedure_Code, 3)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Ossiculoplasty_3
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Ossiculoplasty'

                                          -- Priority 8: Removal of ventilation device
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp8
                                 WHERE ipp8.Episode_Number = ipe.Episode_Number
                                       AND ipp8.Sector = ipe.Sector
                                       AND LEFT(ipp8.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_RemovalOfVentilationDevice_4
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Removal of ventilation device'

                                          -- Priority 9: Septorhinoplasty � graft/implant
                        WHEN (
                                 EXISTS
                                 (
                                     SELECT 1
                                     FROM [PAS_IP_Procedure_Normalised] ipp9a
                                     WHERE ipp9a.Episode_Number = ipe.Episode_Number
                                           AND ipp9a.Sector = ipe.Sector
                                           AND LEFT(ipp9a.Procedure_Code, 4)IN
                                               (
                                                   SELECT Code FROM #CodeGroup_Septorhinoplasty_1_4
                                               )
                                 )
                                 OR EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp9b
                                        WHERE ipp9b.Episode_Number = ipe.Episode_Number
                                              AND ipp9b.Sector = ipe.Sector
                                              AND LEFT(ipp9b.Procedure_Code, 4)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_Septorhinoplasty_2_4
                                                  )
                                    )
                                 OR EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp9c
                                        WHERE ipp9c.Episode_Number = ipe.Episode_Number
                                              AND ipp9c.Sector = ipe.Sector
                                              AND LEFT(ipp9c.Procedure_Code, 4)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_Septorhinoplasty_3_4
                                                  )
                                    )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Septorhinoplasty � graft/implant'

                                          -- Priority 10: Septoplasty of nose
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp10
                                 WHERE ipp10.Episode_Number = ipe.Episode_Number
                                       AND ipp10.Sector = ipe.Sector
                                       AND LEFT(ipp10.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Septoplasty_4
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Septoplasty of nose'

                                          -- Priority 11: Nasal septum cauterisation (and bilateral)
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp11
                                 WHERE ipp11.Episode_Number = ipe.Episode_Number
                                       AND ipp11.Sector = ipe.Sector
                                       AND LEFT(ipp11.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_NasalSeptum_4
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Nasal septum cauterisation (and bilateral)'

                                          -- Priority 12: Operations on turbinates of nose
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp12
                                 WHERE ipp12.Episode_Number = ipe.Episode_Number
                                       AND ipp12.Sector = ipe.Sector
                                       AND LEFT(ipp12.Procedure_Code, 3)IN
                                           (
                                               SELECT Code FROM #CodeGroup_OperationsOnTurbinates_3
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Operations on turbinates of nose'

                                          -- Priority 13: Polypectomy of internal nose
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp13
                                 WHERE ipp13.Episode_Number = ipe.Episode_Number
                                       AND ipp13.Sector = ipe.Sector
                                       AND LEFT(ipp13.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Polypectomy_1_4
                                           )
                                       AND LEFT(ipp13.Procedure_Code, 4) NOT IN
                                           (
                                               SELECT Code
                                               FROM #CodeGroup_Polypectomy_2_4
                                               UNION
                                               SELECT Code
                                               FROM #CodeGroup_Polypectomy_3_4
                                               UNION
                                               SELECT Code
                                               FROM #CodeGroup_Polypectomy_4_4
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Polypectomy of internal nose'

                                          -- Priority 14: Intranasal antrostomy (including endoscopic)
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp14
                                 WHERE ipp14.Episode_Number = ipe.Episode_Number
                                       AND ipp14.Sector = ipe.Sector
                                       AND LEFT(ipp14.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Intranasal_4
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Intranasal antrostomy (including endoscopic)'

                                          -- Priority 15: FESS Endoscopic uncinectomy, anterior and posterior ethmoidectomy
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp15
                                 WHERE ipp15.Episode_Number = ipe.Episode_Number
                                       AND ipp15.Sector = ipe.Sector
                                       AND LEFT(ipp15.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_FESSEndoscopic_4
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'FESS Endoscopic uncinectomy, anterior and posterior ethmoidectomy'

                                          -- Priority 16: Manipulation under anaesthesia of fractured nose (as sole procedure)
                        WHEN (
                                 EXISTS
                                 (
                                     SELECT 1
                                     FROM [PAS_IP_Procedure_Normalised] ipp16a
                                     WHERE ipp16a.Episode_Number = ipe.Episode_Number
                                           AND ipp16a.Sector = ipe.Sector
                                           AND LEFT(ipp16a.Procedure_Code, 4)IN
                                               (
                                                   SELECT Code FROM #CodeGroup_Anaesthesia_1_4
                                               )
                                 )
                                 OR EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp16b
                                        WHERE ipp16b.Episode_Number = ipe.Episode_Number
                                              AND ipp16b.Sector = ipe.Sector
                                              AND LEFT(ipp16b.Procedure_Code, 4)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_Anaesthesia_2_4
                                                  )
                                    )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Manipulation under anaesthesia of fractured nose (as sole procedure)'

                                          -- Priority 17: Adenoid Surgery
                        WHEN (
                                 (
                                     EXISTS
                                     (
                                         SELECT 1
                                         FROM [PAS_IP_Procedure_Normalised] ipp17a
                                         WHERE ipp17a.Episode_Number = ipe.Episode_Number
                                               AND ipp17a.Sector = ipe.Sector
                                               AND LEFT(ipp17a.Procedure_Code, 4)IN
                                                   (
                                                       SELECT Code FROM #CodeGroup_AdenoidSurgery_1_4
                                                   )
                                     )
                                     OR EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp17b
                                            WHERE ipp17b.Episode_Number = ipe.Episode_Number
                                                  AND ipp17b.Sector = ipe.Sector
                                                  AND LEFT(ipp17b.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_AdenoidSurgery_2_4
                                                      )
                                        )
                                     OR EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp17c
                                            WHERE ipp17c.Episode_Number = ipe.Episode_Number
                                                  AND ipp17c.Sector = ipe.Sector
                                                  AND LEFT(ipp17c.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_AdenoidSurgery_3_4
                                                      )
                                        )
                                     OR EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp17d
                                            WHERE ipp17d.Episode_Number = ipe.Episode_Number
                                                  AND ipp17d.Sector = ipe.Sector
                                                  AND LEFT(ipp17d.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_AdenoidSurgery_4_4
                                                      )
                                        )
                                     OR EXISTS
                                        (
                                            SELECT 1
                                            FROM [PAS_IP_Procedure_Normalised] ipp17e
                                            WHERE ipp17e.Episode_Number = ipe.Episode_Number
                                                  AND ipp17e.Sector = ipe.Sector
                                                  AND LEFT(ipp17e.Procedure_Code, 4)IN
                                                      (
                                                          SELECT Code FROM #CodeGroup_AdenoidSurgery_5_4
                                                      )
                                        )
                                 )
                                 AND NOT EXISTS
                                         (
                                             SELECT 1
                                             FROM [PAS_IP_Procedure_Normalised] ipp17f
                                             WHERE ipp17f.Episode_Number = ipe.Episode_Number
                                                   AND ipp17f.Sector = ipe.Sector
                                                   AND LEFT(ipp17f.Procedure_Code, 4)IN
                                                       (
                                                           SELECT Code FROM #CodeGroup_AdenoidSurgery_6_4
                                                       )
                                         )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Adenoid Surgery'

                                          -- Priority 18: Therapeutic endoscopic operations on pharynx
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp18
                                 WHERE ipp18.Episode_Number = ipe.Episode_Number
                                       AND ipp18.Sector = ipe.Sector
                                       AND LEFT(ipp18.Procedure_Code, 3)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Therapeutic_3
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Therapeutic endoscopic operations on pharynx'

                                          -- Priority 19: Diagnostic endoscopic examination of pharynx/larynx � biopsy
                        WHEN (
                                 EXISTS
                                 (
                                     SELECT 1
                                     FROM [PAS_IP_Procedure_Normalised] ipp19a
                                     WHERE ipp19a.Episode_Number = ipe.Episode_Number
                                           AND ipp19a.Sector = ipe.Sector
                                           AND LEFT(ipp19a.Procedure_Code, 3)IN
                                               (
                                                   SELECT Code FROM #CodeGroup_Diagnosticendoscopic_1_3
                                               )
                                 )
                                 OR EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp19b
                                        WHERE ipp19b.Episode_Number = ipe.Episode_Number
                                              AND ipp19b.Sector = ipe.Sector
                                              AND LEFT(ipp19b.Procedure_Code, 3)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_Diagnosticendoscopic_2_3
                                                  )
                                    )
                                 OR EXISTS
                                    (
                                        SELECT 1
                                        FROM [PAS_IP_Procedure_Normalised] ipp19c
                                        WHERE ipp19c.Episode_Number = ipe.Episode_Number
                                              AND ipp19c.Sector = ipe.Sector
                                              AND LEFT(ipp19c.Procedure_Code, 3)IN
                                                  (
                                                      SELECT Code FROM #CodeGroup_Diagnosticendoscopic_3_3
                                                  )
                                    )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Diagnostic endoscopic examination of pharynx/larynx � biopsy'

                                          -- Priority 20: Tonsillectomy
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp20
                                 WHERE ipp20.Episode_Number = ipe.Episode_Number
                                       AND ipp20.Sector = ipe.Sector
                                       AND LEFT(ipp20.Procedure_Code, 3)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Tonsillectomy_1_3
                                           )
                                       AND LEFT(ipp20.Procedure_Code, 4) NOT IN
                                           (
                                               SELECT Code
                                               FROM #CodeGroup_Tonsillectomy_2_4
                                               UNION
                                               SELECT Code
                                               FROM #CodeGroup_Tonsillectomy_3_4
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Tonsillectomy'

                                          -- Priority 21: Laser surgery to vocal cord (including microlaryngoscopy)
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp21
                                 WHERE ipp21.Episode_Number = ipe.Episode_Number
                                       AND ipp21.Sector = ipe.Sector
                                       AND LEFT(ipp21.Procedure_Code, 3)IN
                                           (
                                               SELECT Code FROM #CodeGroup_Lasersurgery_3
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 17 AND 120
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Laser surgery to vocal cord (including microlaryngoscopy)'

                                          -- Priority 22: Adenoid Surgery (Paediatric)
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp22
                                 WHERE ipp22.Episode_Number = ipe.Episode_Number
                                       AND ipp22.Sector = ipe.Sector
                                       AND LEFT(ipp22.Procedure_Code, 4)IN
                                           (
                                               SELECT Code FROM #CodeGroup_PS_Adenoid_4_1
                                           )
                                       AND LEFT(ipp22.Procedure_Code, 4) NOT IN
                                           (
                                               SELECT Code FROM #CodeGroup_PS_Adenoid_4_2
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 0 AND 16
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Adenoid Surgery (Paediatric)'

                                          -- Priority 23: Tonsillectomy (Paediatric)
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp23
                                 WHERE ipp23.Episode_Number = ipe.Episode_Number
                                       AND ipp23.Sector = ipe.Sector
                                       AND LEFT(ipp23.Procedure_Code, 3)IN
                                           (
                                               SELECT Code FROM #CodeGroup_PS_Tonsillectomy_3_1
                                           )
                                       AND LEFT(ipp23.Procedure_Code, 4) NOT IN
                                           (
                                               SELECT Code
                                               FROM #CodeGroup_PS_Tonsillectomy_4_2
                                               UNION
                                               SELECT Code
                                               FROM #CodeGroup_PS_Tonsillectomy_4_3
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 0 AND 16
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Tonsillectomy (Paediatric)'

                                          -- Priority 24: Myringotomy + insertion of tube, suction clearance (Paediatric)
                        WHEN EXISTS
                             (
                                 SELECT 1
                                 FROM [PAS_IP_Procedure_Normalised] ipp24
                                 WHERE ipp24.Episode_Number = ipe.Episode_Number
                                       AND ipp24.Sector = ipe.Sector
                                       AND LEFT(ipp24.Procedure_Code, 3)IN
                                           (
                                               SELECT Code FROM #CodeGroup_PS_Myringotomy_3_1
                                           )
                             )
                             AND SWV.Age
                             BETWEEN 0 AND 16
                             AND SWV.POD_Derived IN ( 'DC', 'EL', 'RA' ) THEN
                            'Myringotomy + insertion of tube, suction clearance (Paediatric)'
                        ELSE
                            ENT_Procedure -- Retain existing value if no conditions are met
                    END
FROM #Spells_With_Variables SWV
    INNER JOIN [PAS_IP_Episode_Frozen] ipe
        ON SWV.Spell_Number = ipe.Spell_Number
           AND SWV.Sector = ipe.Sector;

-- ========================================
-- ENT Metrics
-- ========================================

/* Number of adult patients receiving tonsillectomy under ENT surgeon (monthly) 
Model Hospital ID: EN7116

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT')  
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult'

Jul 2024

*/

-- Metric EN7116: Number of Adult Patients Receiving Tonsillectomy Under ENT Surgeon (Monthly)

DECLARE @EN7116_StartDate DATE = '2024-07-01'; 
DECLARE @EN7116_EndDate DATE = '2024-07-31'; 

DECLARE @EN7116_Num_Tonsillectomy_Adults INT;

SELECT @EN7116_Num_Tonsillectomy_Adults = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND POD_Derived IN ( 'DC', 'EL' )
      AND ENT_AgeGroup = 'Adult'
      AND Admission_Date
      BETWEEN @EN7116_StartDate AND @EN7116_EndDate;

SELECT 'EN7116 - Number of Adult Patients Receiving Tonsillectomy Under ENT Surgeon (Monthly)' AS Metric,
       @EN7116_Num_Tonsillectomy_Adults AS Value;


/* Number of child patients receiving tonsillectomy under ENT surgeon (monthly) 
Model Hospital ID: EN7117

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Jul 2024

*/

-- Metric EN7117: Number of Child Patients Receiving Tonsillectomy Under ENT Surgeon (Monthly)

DECLARE @EN7117_StartDate DATE = '2024-07-01';
DECLARE @EN7117_EndDate DATE = '2024-07-31';

DECLARE @EN7117_Num_Tonsillectomy_Children INT;

SELECT @EN7117_Num_Tonsillectomy_Children = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND POD_Derived IN ( 'DC', 'EL' )
      AND ENT_AgeGroup = 'Child'
      AND Admission_Date
      BETWEEN @EN7117_StartDate AND @EN7117_EndDate;

SELECT 'EN7117 - Number of Child Patients Receiving Tonsillectomy Under ENT Surgeon (Monthly)' AS Metric,
       @EN7117_Num_Tonsillectomy_Children AS Value;

/* Number of child patients receiving grommet procedures (monthly) 
Model Hospital ID: EN7118

COUNT(Spells)
ENT_Procs = 'Grommets' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Jun 2024

*/

-- Metric EN7118: Number of Child Patients Receiving Grommet Procedures (Monthly)

DECLARE @EN7118_StartDate DATE = '2024-06-01'; 
DECLARE @EN7118_EndDate DATE = '2024-06-30'; 

DECLARE @EN7118_Num_Grommets_Children INT;

SELECT @EN7118_Num_Grommets_Children = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Grommets'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND ENT_AgeGroup = 'Child'
      AND Admission_Date
      BETWEEN @EN7118_StartDate AND @EN7118_EndDate;

SELECT 'EN7118 - Number of Child Patients Receiving Grommet Procedures (Monthly)' AS Metric,
       @EN7118_Num_Grommets_Children AS Value;

/* Number of child patients receiving adenoidectomy (monthly) 
Model Hospital ID: EN7119

COUNT(Spells)
ENT_Procs = 'Adenoidectomy' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Jul 2024

*/

-- Metric EN7119: Number of Child Patients Receiving Adenoidectomy (Monthly)

DECLARE @EN7119_StartDate DATE = '2024-07-01'; 
DECLARE @EN7119_EndDate DATE = '2024-07-31'; 

DECLARE @EN7119_Num_Adenoidectomy_Children INT;

SELECT @EN7119_Num_Adenoidectomy_Children = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Adenoidectomy'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND ENT_AgeGroup = 'Child'
      AND Admission_Date
      BETWEEN @EN7119_StartDate AND @EN7119_EndDate;

SELECT 'EN7119 - Number of Child Patients Receiving Adenoidectomy (Monthly)' AS Metric,
       @EN7119_Num_Adenoidectomy_Children AS Value;

/* Number of child patients receiving pinnaplasty (monthly) 
Model Hospital ID: EN7120

COUNT(Spells)
ENT_Procs = 'Pinnaplasty' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Jun 2024

*/

-- Metric EN7120: Number of Child Patients Receiving Pinnaplasty (Monthly)

DECLARE @EN7120_StartDate DATE = '2024-06-01'; 
DECLARE @EN7120_EndDate DATE = '2024-06-30'; 

DECLARE @EN7120_Num_Pinnaplasty_Children INT;

SELECT @EN7120_Num_Pinnaplasty_Children = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Pinnaplasty'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND ENT_AgeGroup = 'Child'
      AND Admission_Date
      BETWEEN @EN7120_StartDate AND @EN7120_EndDate;

SELECT 'EN7120 - Number of Child Patients Receiving Pinnaplasty (Monthly)' AS Metric,
       @EN7120_Num_Pinnaplasty_Children AS Value;

/* Day case rate for adult patients receiving tonsillectomy under ENT surgeon (12mths to qtr end) 
Model Hospital ID: EN7100

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT')  
AND ENT_AgeGroup = 'Adult' 
AND POD_Derived in ('DC')

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT')  
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult'

Q1 2024/25

*/

-- Metric EN7100: Day Case Rate for Adult Patients Receiving Tonsillectomy Under ENT Surgeon (12 Months to Quarter End)

DECLARE @EN7100_StartDate DATE = '2023-07-01';
DECLARE @EN7100_EndDate DATE = '2024-06-30';

-- Numerator: Day Cases
DECLARE @EN7100_Num_DayCases INT;

SELECT @EN7100_Num_DayCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived = 'DC'
      AND Admission_Date
      BETWEEN @EN7100_StartDate AND @EN7100_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7100_Denom_AllCases INT;

SELECT @EN7100_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7100_StartDate AND @EN7100_EndDate;

-- Calculate Day Case Rate
DECLARE @EN7100_DayCaseRate FLOAT;

SET @EN7100_DayCaseRate = (CAST(@EN7100_Num_DayCases AS FLOAT) / NULLIF(@EN7100_Denom_AllCases, 0)) * 100;

SELECT 'EN7100 - Day Case Rate for Adult Patients Receiving Tonsillectomy Under ENT Surgeon (12 Months to Quarter End)' AS Metric,
       @EN7100_DayCaseRate AS Percentage,
       @EN7100_Num_DayCases AS Numerator,
       @EN7100_Denom_AllCases AS Denominator;

/* Day case rate for child patients receiving tonsillectomy under ENT surgeon (12mths to qtr end) 
Model Hospital ID: EN7101

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT')  
AND ENT_AgeGroup = 'Child' 
AND POD_Derived in ('DC')

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Q1 2024/25

*/

-- Metric EN7101: Day Case Rate for Child Patients Receiving Tonsillectomy Under ENT Surgeon (12 Months to Quarter End)

DECLARE @EN7101_StartDate DATE = '2023-07-01'; 
DECLARE @EN7101_EndDate DATE = '2024-06-30'; 

-- Numerator: Day Cases
DECLARE @EN7101_Num_DayCases INT;

SELECT @EN7101_Num_DayCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived = 'DC'
      AND Admission_Date
      BETWEEN @EN7101_StartDate AND @EN7101_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7101_Denom_AllCases INT;

SELECT @EN7101_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7101_StartDate AND @EN7101_EndDate;

-- Calculate Day Case Rate
DECLARE @EN7101_DayCaseRate FLOAT;

SET @EN7101_DayCaseRate = (CAST(@EN7101_Num_DayCases AS FLOAT) / NULLIF(@EN7101_Denom_AllCases, 0)) * 100;

SELECT 'EN7101 - Day Case Rate for Child Patients Receiving Tonsillectomy Under ENT Surgeon (12 Months to Quarter End)' AS Metric,
       @EN7101_DayCaseRate AS Percentage,
       @EN7101_Num_DayCases AS Numerator,
       @EN7101_Denom_AllCases AS Denominator;

/* Day case rate for child patients receiving grommet procedures (12mths to qtr end) 
Model Hospital ID: EN7102

COUNT(Spells)
ENT_Procs = 'Grommets' 
AND ENT_AgeGroup = 'Child' 
AND POD_Derived in ('DC')

COUNT(Spells)
ENT_Procs = 'Grommets' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Q1 2024/25

*/

-- Metric EN7102: Day Case Rate for Child Patients Receiving Grommet Procedures (12 Months to Quarter End)

DECLARE @EN7102_StartDate DATE = '2023-07-01'; 
DECLARE @EN7102_EndDate DATE = '2024-06-30'; 

-- Numerator: Day Cases
DECLARE @EN7102_Num_DayCases INT;

SELECT @EN7102_Num_DayCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Grommets'
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived = 'DC'
      AND Admission_Date
      BETWEEN @EN7102_StartDate AND @EN7102_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7102_Denom_AllCases INT;

SELECT @EN7102_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Grommets'
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7102_StartDate AND @EN7102_EndDate;

-- Calculate Day Case Rate
DECLARE @EN7102_DayCaseRate FLOAT;

SET @EN7102_DayCaseRate = (CAST(@EN7102_Num_DayCases AS FLOAT) / NULLIF(@EN7102_Denom_AllCases, 0)) * 100;

SELECT 'EN7102 - Day Case Rate for Child Patients Receiving Grommet Procedures (12 Months to Quarter End)' AS Metric,
       @EN7102_DayCaseRate AS Percentage,
       @EN7102_Num_DayCases AS Numerator,
       @EN7102_Denom_AllCases AS Denominator;

/* Day case rate for child patients receiving adenoidectomy (12mths to qtr end) 
Model Hospital ID: EN7103

COUNT(Spells)
ENT_Procs = 'Adenoidectomy' 
AND ENT_AgeGroup = 'Child' 
AND POD_Derived in ('DC')

COUNT(Spells)
ENT_Procs = 'Adenoidectomy' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Q1 2024/25

*/

-- Metric EN7103: Day Case Rate for Child Patients Receiving Adenoidectomy (12 Months to Quarter End)

DECLARE @EN7103_StartDate DATE = '2023-07-01'; 
DECLARE @EN7103_EndDate DATE = '2024-06-30'; 

-- Numerator: Day Cases
DECLARE @EN7103_Num_DayCases INT;

SELECT @EN7103_Num_DayCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Adenoidectomy'
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived = 'DC'
      AND Admission_Date
      BETWEEN @EN7103_StartDate AND @EN7103_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7103_Denom_AllCases INT;

SELECT @EN7103_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Adenoidectomy'
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7103_StartDate AND @EN7103_EndDate;

-- Calculate Day Case Rate
DECLARE @EN7103_DayCaseRate FLOAT;

SET @EN7103_DayCaseRate = (CAST(@EN7103_Num_DayCases AS FLOAT) / NULLIF(@EN7103_Denom_AllCases, 0)) * 100;

SELECT 'EN7103 - Day Case Rate for Child Patients Receiving Adenoidectomy (12 Months to Quarter End)' AS Metric,
       @EN7103_DayCaseRate AS Percentage,
       @EN7103_Num_DayCases AS Numerator,
       @EN7103_Denom_AllCases AS Denominator;

/* Day case rate for child patients receiving pinnaplasty (12mths to qtr end) 
Model Hospital ID: EN7104

COUNT(Spells)
ENT_Procs = 'Pinnaplasty'  
AND ENT_AgeGroup = 'Child' 
AND POD_Derived in ('DC')

COUNT(Spells)
ENT_Procs = 'Pinnaplasty' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Q1 2019/20

*/

-- Metric EN7104: Day Case Rate for Child Patients Receiving Pinnaplasty (12 Months to Quarter End)

DECLARE @EN7104_StartDate DATE = '2018-07-01'; 
DECLARE @EN7104_EndDate DATE = '2019-06-30'; 

-- Numerator: Day Cases
DECLARE @EN7104_Num_DayCases INT;

SELECT @EN7104_Num_DayCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Pinnaplasty'
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived = 'DC'
      AND Admission_Date
      BETWEEN @EN7104_StartDate AND @EN7104_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7104_Denom_AllCases INT;

SELECT @EN7104_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Pinnaplasty'
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7104_StartDate AND @EN7104_EndDate;

-- Calculate Day Case Rate
DECLARE @EN7104_DayCaseRate FLOAT;

SET @EN7104_DayCaseRate = (CAST(@EN7104_Num_DayCases AS FLOAT) / NULLIF(@EN7104_Denom_AllCases, 0)) * 100;

SELECT 'EN7104 - Day Case Rate for Child Patients Receiving Pinnaplasty (12 Months to Quarter End)' AS Metric,
       @EN7104_DayCaseRate AS Percentage,
       @EN7104_Num_DayCases AS Numerator,
       @EN7104_Denom_AllCases AS Denominator;

/* Day case rate for adult patients receiving rhinoplasty (12mths to qtr end) 
Model Hospital ID: EN7105

COUNT(Spells)
ENT_Procs = 'Rhinoplasty' 
AND ENT_AgeGroup = 'Adult' 
AND POD_Derived in ('DC')

COUNT(Spells)
ENT_Procs = 'Rhinoplasty' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult'

Q1 2024/25

*/

-- Metric EN7105: Day Case Rate for Adult Patients Receiving Rhinoplasty (12 Months to Quarter End)

DECLARE @EN7105_StartDate DATE = '2023-07-01';
DECLARE @EN7105_EndDate DATE = '2024-06-30';

-- Numerator: Day Cases
DECLARE @EN7105_Num_DayCases INT;

SELECT @EN7105_Num_DayCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Rhinoplasty'
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived = 'DC'
      AND Admission_Date
      BETWEEN @EN7105_StartDate AND @EN7105_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7105_Denom_AllCases INT;

SELECT @EN7105_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Rhinoplasty'
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7105_StartDate AND @EN7105_EndDate;

-- Calculate Day Case Rate
DECLARE @EN7105_DayCaseRate FLOAT;

SET @EN7105_DayCaseRate = (CAST(@EN7105_Num_DayCases AS FLOAT) / NULLIF(@EN7105_Denom_AllCases, 0)) * 100;

SELECT 'EN7105 - Day Case Rate for Adult Patients Receiving Rhinoplasty (12 Months to Quarter End)' AS Metric,
       @EN7105_DayCaseRate AS Percentage,
       @EN7105_Num_DayCases AS Numerator,
       @EN7105_Denom_AllCases AS Denominator;

/* Day case rate for patients receiving tympanoplasty (12mths to qtr end) 
Model Hospital ID: EN7106

COUNT(Spells)
ENT_Procs = 'TympanoplastyExcCombined' 
AND POD_Derived in ('DC')

COUNT(Spells)
ENT_Procs = 'TympanoplastyExcCombined' 
AND POD_Derived in ('DC','EL')

Q1 2024/25

*/

-- Metric EN7106: Day Case Rate for Patients Receiving Tympanoplasty (12 Months to Quarter End)

DECLARE @EN7106_StartDate DATE = '2023-07-01';
DECLARE @EN7106_EndDate DATE = '2024-06-30'; 

-- Numerator: Day Cases
DECLARE @EN7106_Num_DayCases INT;

SELECT @EN7106_Num_DayCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'TympanoplastyExcCombined'
      AND POD_Derived = 'DC'
      AND Admission_Date
      BETWEEN @EN7106_StartDate AND @EN7106_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7106_Denom_AllCases INT;

SELECT @EN7106_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'TympanoplastyExcCombined'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7106_StartDate AND @EN7106_EndDate;

-- Calculate Day Case Rate
DECLARE @EN7106_DayCaseRate FLOAT;

SET @EN7106_DayCaseRate = (CAST(@EN7106_Num_DayCases AS FLOAT) / NULLIF(@EN7106_Denom_AllCases, 0)) * 100;

SELECT 'EN7106 - Day Case Rate for Patients Receiving Tympanoplasty (12 Months to Quarter End)' AS Metric,
       @EN7106_DayCaseRate AS Percentage,
       @EN7106_Num_DayCases AS Numerator,
       @EN7106_Denom_AllCases AS Denominator;


/* Day case rate for adult patients receiving septoplasty of the nose (12mths to qtr end) 
Model Hospital ID: EN7107

COUNT(Spells)
ENT_Procs = 'SeptoplastyNose' 
AND ENT_AgeGroup = 'Adult' 
AND POD_Derived in ('DC')

COUNT(Spells)
ENT_Procs = 'SeptoplastyNose' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult'

Q1 2024/25

*/

-- Metric EN7107: Day Case Rate for Adult Patients Receiving Septoplasty of the Nose (12 Months to Quarter End)

DECLARE @EN7107_StartDate DATE = '2023-07-01'; 
DECLARE @EN7107_EndDate DATE = '2024-06-30';   

-- Numerator: Day Cases
DECLARE @EN7107_Num_DayCases INT;

SELECT @EN7107_Num_DayCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'SeptoplastyNose'
  AND ENT_AgeGroup = 'Adult'
  AND POD_Derived = 'DC'
  AND Admission_Date BETWEEN @EN7107_StartDate AND @EN7107_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7107_Denom_AllCases INT;

SELECT @EN7107_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'SeptoplastyNose'
  AND ENT_AgeGroup = 'Adult'
  AND POD_Derived IN ('DC', 'EL')
  AND Admission_Date BETWEEN @EN7107_StartDate AND @EN7107_EndDate;

-- Calculate Day Case Rate
DECLARE @EN7107_DayCaseRate FLOAT;

SET @EN7107_DayCaseRate = (CAST(@EN7107_Num_DayCases AS FLOAT) / NULLIF(@EN7107_Denom_AllCases, 0)) * 100;

SELECT 'EN7107 - Day Case Rate for Adult Patients Receiving Septoplasty of the Nose (12 Months to Quarter End)' AS Metric,
       @EN7107_DayCaseRate AS Percentage,
       @EN7107_Num_DayCases AS Numerator,
       @EN7107_Denom_AllCases AS Denominator;

/* Emergency adult readmissions within 30 days following tonsillectomy under ENT surgeon (12mths to qtr end) 
Model Hospital ID: EN7108

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT')  
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult' 
AND Read30='Y' 

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT')  
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult'

Q1 2024/25

*/

-- Metric EN7108: Emergency Adult Readmissions Within 30 Days Following Tonsillectomy Under ENT Surgeon (12 Months to Quarter End)

DECLARE @EN7108_StartDate DATE = '2023-07-01'; 
DECLARE @EN7108_EndDate DATE = '2024-06-30'; 

-- Numerator: Readmissions
DECLARE @EN7108_Num_Readmissions INT;

SELECT @EN7108_Num_Readmissions = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Read30 = 1
      AND Admission_Date
      BETWEEN @EN7108_StartDate AND @EN7108_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7108_Denom_AllCases INT;

SELECT @EN7108_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7108_StartDate AND @EN7108_EndDate;

-- Calculate Readmission Rate
DECLARE @EN7108_ReadmissionRate FLOAT;

SET @EN7108_ReadmissionRate = (CAST(@EN7108_Num_Readmissions AS FLOAT) / NULLIF(@EN7108_Denom_AllCases, 0)) * 100;

SELECT 'EN7108 - Emergency Adult Readmissions Within 30 Days Following Tonsillectomy Under ENT Surgeon (12 Months to Quarter End)' AS Metric,
       @EN7108_ReadmissionRate AS Percentage,
       @EN7108_Num_Readmissions AS Numerator,
       @EN7108_Denom_AllCases AS Denominator;

/* Emergency child readmissions within 30 days following tonsillectomy under ENT surgeon (12mths to qtr end) 
Model Hospital ID: EN7109

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT')  
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child' 
AND Read30='Y' 

COUNT(Spells)
ENT_Procs = 'Tonsillectomy' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT')  
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Q1 2024/25

*/

-- Metric EN7109: Emergency Child Readmissions Within 30 Days Following Tonsillectomy Under ENT Surgeon (12 Months to Quarter End)

DECLARE @EN7109_StartDate DATE = '2023-07-01';
DECLARE @EN7109_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions
DECLARE @EN7109_Num_Readmissions INT;

SELECT @EN7109_Num_Readmissions = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Read30 = 1
      AND Admission_Date
      BETWEEN @EN7109_StartDate AND @EN7109_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7109_Denom_AllCases INT;

SELECT @EN7109_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs = 'Tonsillectomy'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7109_StartDate AND @EN7109_EndDate;

-- Calculate Readmission Rate
DECLARE @EN7109_ReadmissionRate FLOAT;

SET @EN7109_ReadmissionRate = (CAST(@EN7109_Num_Readmissions AS FLOAT) / NULLIF(@EN7109_Denom_AllCases, 0)) * 100;

SELECT 'EN7109 - Emergency Child Readmissions Within 30 Days Following Tonsillectomy Under ENT Surgeon (12 Months to Quarter End)' AS Metric,
       @EN7109_ReadmissionRate AS Percentage,
       @EN7109_Num_Readmissions AS Numerator,
       @EN7109_Denom_AllCases AS Denominator;

/* Emergency readmissions within 30 days following an otology procedure under ENT (12mths to qtr end) 
Model Hospital ID: EN7110

COUNT(Spells)
ENT_Procs1 = 'Otology' 
AND POD_Derived in ('DC','EL') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND Read30='Y' 

COUNT(Spells)
ENT_Procs1 = 'Otology' 
AND POD_Derived in ('DC','EL') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 

Q1 2024/25

*/

-- Metric EN7110: Emergency Readmissions Within 30 Days Following an Otology Procedure Under ENT (12 Months to Quarter End)

DECLARE @EN7110_StartDate DATE = '2023-07-01'; 
DECLARE @EN7110_EndDate DATE = '2024-06-30'; 

-- Numerator: Readmissions
DECLARE @EN7110_Num_Readmissions INT;

SELECT @EN7110_Num_Readmissions = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs1 = 'Otology'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Read30 = 1
      AND Admission_Date
      BETWEEN @EN7110_StartDate AND @EN7110_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7110_Denom_AllCases INT;

SELECT @EN7110_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs1 = 'Otology'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7110_StartDate AND @EN7110_EndDate;

-- Calculate Readmission Rate
DECLARE @EN7110_ReadmissionRate FLOAT;

SET @EN7110_ReadmissionRate = (CAST(@EN7110_Num_Readmissions AS FLOAT) / NULLIF(@EN7110_Denom_AllCases, 0)) * 100;

SELECT 'EN7110 - Emergency Readmissions Within 30 Days Following an Otology Procedure Under ENT (12 Months to Quarter End)' AS Metric,
       @EN7110_ReadmissionRate AS Percentage,
       @EN7110_Num_Readmissions AS Numerator,
       @EN7110_Denom_AllCases AS Denominator;


/* Emergency adult readmissions within 30 days following a rhinology procedure under ENT (12mths to qtr end) 
Model Hospital ID: EN7111

COUNT(Spells)
ENT_Procs1 = 'Rhinology' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND Read30='Y' 

COUNT(Spells)
ENT_Procs1 = 'Rhinology' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 

Q1 2024/25

*/

-- Metric EN7111: Emergency Adult Readmissions Within 30 Days Following a Rhinology Procedure Under ENT (12 Months to Quarter End)

DECLARE @EN7111_StartDate DATE = '2023-07-01'; 
DECLARE @EN7111_EndDate DATE = '2024-06-30';

-- Numerator: Readmissions
DECLARE @EN7111_Num_Readmissions INT;

SELECT @EN7111_Num_Readmissions = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs1 = 'Rhinology'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Read30 = 1
      AND Admission_Date
      BETWEEN @EN7111_StartDate AND @EN7111_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7111_Denom_AllCases INT;

SELECT @EN7111_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs1 = 'Rhinology'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7111_StartDate AND @EN7111_EndDate;

-- Calculate Readmission Rate
DECLARE @EN7111_ReadmissionRate FLOAT;

SET @EN7111_ReadmissionRate = (CAST(@EN7111_Num_Readmissions AS FLOAT) / NULLIF(@EN7111_Denom_AllCases, 0)) * 100;

SELECT 'EN7111 - Emergency Adult Readmissions Within 30 Days Following a Rhinology Procedure Under ENT (12 Months to Quarter End)' AS Metric,
       @EN7111_ReadmissionRate AS Percentage,
       @EN7111_Num_Readmissions AS Numerator,
       @EN7111_Denom_AllCases AS Denominator;

/* Return admissions within 1 year for patients following an otology procedure under an ENT surgeon (12mths to qtr end) 

COUNT(Spells)
ENT_Procs1 = 'Otology' 
AND POD_Derived in ('DC','EL') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND ENT_FLAG_OtologyProc1Yr = 1

COUNT(Spells)
ENT_Procs1 = 'Otology' 
AND POD_Derived in ('DC','EL') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 

Q1 2023/24

*/

DECLARE @StartDate DATE = '2022-07-01';
DECLARE @EndDate DATE = '2023-06-30';

-- Denominator: All index admissions for otology procedures
DECLARE @Denominator INT;

SELECT @Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs1 = 'Otology'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND Admission_Date
      BETWEEN @StartDate AND @EndDate;

-- Numerator: Index admissions with a return admission within 1 year
DECLARE @Numerator INT;

SELECT @Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs1 = 'Otology'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_FLAG_OtologyProc1Yr = 1
      AND Admission_Date
      BETWEEN @StartDate AND @EndDate;

-- Calculate the rate
DECLARE @Rate FLOAT;

SET @Rate = (CAST(@Numerator AS FLOAT) / NULLIF(@Denominator, 0)) * 100;

-- Output the result
SELECT 'Return Admissions Within 1 Year for Patients Following an Otology Procedure Under an ENT Surgeon (12 Months to Quarter End)' AS Metric,
       @Rate AS Percentage,
       @Numerator AS Numerator,
       @Denominator AS Denominator;

/* Return admissions within 1 year for adult patients following a rhinology procedure under an ENT surgeon (12mths to qtr end) 
Model Hospital ID: EN7113

COUNT(Spells)	
ENT_Procs1 = 'Rhinology' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND ENT_FLAG_RhinologyProc1Yr = 1

COUNT(Spells)
ENT_Procs1 = 'Rhinology' 
AND POD_Derived in ('DC','EL') 
AND ENT_AgeGroup = 'Adult' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 

Q1 2023/24

*/

DECLARE @StartDate DATE = '2022-07-01'; 
DECLARE @EndDate DATE = '2023-06-30'; 

-- Denominator: All index admissions for rhinology procedures (Adults)
DECLARE @Denominator INT;

SELECT @Denominator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs1 = 'Rhinology'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND ENT_AgeGroup = 'Adult'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND Admission_Date
      BETWEEN @StartDate AND @EndDate;

-- Numerator: Index admissions with a return admission within 1 year
DECLARE @Numerator INT;

SELECT @Numerator = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_Procs1 = 'Rhinology'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND ENT_AgeGroup = 'Adult'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_FLAG_RhinologyProc1Yr = 1
      AND Admission_Date
      BETWEEN @StartDate AND @EndDate;

-- Calculate the rate
DECLARE @Rate FLOAT;

SET @Rate = (CAST(@Numerator AS FLOAT) / NULLIF(@Denominator, 0)) * 100;

-- Output the result
SELECT 'EN7113 - Return Admissions Within 1 Year for Adult Patients Following a Rhinology Procedure Under an ENT Surgeon (12 Months to Quarter End)' AS Metric,
       @Rate AS Percentage,
       @Numerator AS Numerator,
       @Denominator AS Denominator;

/* Planned procedure not carried out adult rate (12mths to qtr end) 
Model Hospital ID: EN7114

COUNT(Spells)
ENT_MainSpecialty = 'ENT'  
AND POD_Derived IN ('DC','EL') 
AND ENT_AgeGroup = 'Adult' 
AND ENT_Planned_Proc_not_Carried_Out_IP = 'PlannedProcNotCarriedOut'

COUNT(Spells)
(ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Derived IN ('DC','EL') 
AND ENT_AgeGroup = 'Adult'

Q1 2024/25

*/

-- Metric EN7114: Planned Procedure Not Carried Out Adult Rate (12 Months to Quarter End)

DECLARE @EN7114_StartDate DATE = '2023-07-01'; 
DECLARE @EN7114_EndDate DATE = '2024-06-30'; 

-- Numerator: Cases Where Planned Procedure Not Carried Out
DECLARE @EN7114_Num_PlannedNotCarriedOut INT;

SELECT @EN7114_Num_PlannedNotCarriedOut = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_MainSpecialty = 'ENT'
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND ENT_Planned_Proc_not_Carried_Out_IP = 'PlannedProcNotCarriedOut'
      AND Admission_Date
      BETWEEN @EN7114_StartDate AND @EN7114_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7114_Denom_AllCases INT;

SELECT @EN7114_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7114_StartDate AND @EN7114_EndDate;

-- Calculate Rate
DECLARE @EN7114_Rate FLOAT;

SET @EN7114_Rate = (CAST(@EN7114_Num_PlannedNotCarriedOut AS FLOAT) / NULLIF(@EN7114_Denom_AllCases, 0)) * 100;

SELECT 'EN7114 - Planned Procedure Not Carried Out Adult Rate (12 Months to Quarter End)' AS Metric,
       @EN7114_Rate AS Percentage,
       @EN7114_Num_PlannedNotCarriedOut AS Numerator,
       @EN7114_Denom_AllCases AS Denominator;

/* Planned procedure not carried out child rate (12mths to qtr end) 
Model Hospital ID: EN7115

COUNT(Spells)
(ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Derived IN ('DC','EL') 
AND ENT_AgeGroup = 'Child' 
AND ENT_Planned_Proc_not_Carried_Out_IP = 'PlannedProcNotCarriedOut'

COUNT(Spells)
(ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Derived IN ('DC','EL') 
AND ENT_AgeGroup = 'Child'

Q1 2024/25

*/

-- Metric EN7115: Planned Procedure Not Carried Out Child Rate (12 Months to Quarter End)

DECLARE @EN7115_StartDate DATE = '2023-07-01'; 
DECLARE @EN7115_EndDate DATE = '2024-06-30'; 

-- Numerator: Cases Where Planned Procedure Not Carried Out
DECLARE @EN7115_Num_PlannedNotCarriedOut INT;

SELECT @EN7115_Num_PlannedNotCarriedOut = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND ENT_Planned_Proc_not_Carried_Out_IP = 'PlannedProcNotCarriedOut'
      AND Admission_Date
      BETWEEN @EN7115_StartDate AND @EN7115_EndDate;

-- Denominator: All Elective Cases
DECLARE @EN7115_Denom_AllCases INT;

SELECT @EN7115_Denom_AllCases = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Child'
      AND POD_Derived IN ( 'DC', 'EL' )
      AND Admission_Date
      BETWEEN @EN7115_StartDate AND @EN7115_EndDate;

-- Calculate Rate
DECLARE @EN7115_Rate FLOAT;

SET @EN7115_Rate = (CAST(@EN7115_Num_PlannedNotCarriedOut AS FLOAT) / NULLIF(@EN7115_Denom_AllCases, 0)) * 100;

SELECT 'EN7115 - Planned Procedure Not Carried Out Child Rate (12 Months to Quarter End)' AS Metric,
       @EN7115_Rate AS Percentage,
       @EN7115_Num_PlannedNotCarriedOut AS Numerator,
       @EN7115_Denom_AllCases AS Denominator;


/* -------------------------------------------------------------------
	Cancer Major Surgical Resection
 ------------------------------------------------------------------- */

/* Number of adult ENT MSR procedures for head and neck cancer (monthly) 
Model Hospital ID: EN7125

COUNT(Spells)
ENT_CancerMSR = 'Cancer MSR' 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND ENT_AgeGroup = 'Adult'

May 2024

*/

-- Metric EN7125: Number of Adult ENT MSR Procedures for Head and Neck Cancer (Monthly)

DECLARE @EN7125_StartDate DATE = '2024-05-01'; -- Start of May 2024
DECLARE @EN7125_EndDate DATE = '2024-05-31'; -- End of May 2024

DECLARE @EN7125_Num_CancerMSR INT;

SELECT @EN7125_Num_CancerMSR = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE ENT_CancerMSR = 'Cancer MSR'
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND Admission_Date
      BETWEEN @EN7125_StartDate AND @EN7125_EndDate;

SELECT 'EN7125 - Number of Adult ENT MSR Procedures for Head and Neck Cancer (Monthly)' AS Metric,
       @EN7125_Num_CancerMSR AS Value;

/* -------------------------------------------------------------------
	Outpatients
 ------------------------------------------------------------------- */

/* Outpatient follow-up ratio for adult attendances and procedures (12mths to qtr end) 
Model Hospital ID: EN7126

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Type = 'Follow-up' 
AND ENT_AgeGroup = 'Adult'

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Type = 'First' 
AND ENT_AgeGroup = 'Adult'

Q1 2024/25

*/

SELECT COUNT(   CASE
                    WHEN New_Follow_Up_Flag_Appointment = 'F' THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of follow-up adult attendances or procedures in ENT",
       COUNT(   CASE
                    WHEN New_Follow_Up_Flag_Appointment = 'N' THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of adult first attendances or procedures in ENT"
FROM [PAS_OP_Appointment_Frozen]
WHERE Attendance_Status_Code IN ( '5', '6' )
      AND
      (
          Main_Specialty_Code = 120
          OR Treatment_Function_Code IN ( '120', '215' )
      )
      AND Appointment_Date
      BETWEEN '20230701' AND '20240630'
      AND Age_At_Appointment > 16;

/* Outpatient follow-up ratio for child attendances and procedures (12mths to qtr end) 
Model Hospital ID: EN7127

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Type = 'Follow-up' 
AND ENT_AgeGroup = 'Child'

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Type = 'First' 
AND ENT_AgeGroup = 'Child'

Q1 2024/25

*/

SELECT COUNT(   CASE
                    WHEN New_Follow_Up_Flag_Appointment = 'F' THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of follow-up child attendances or procedures in ENT",
       COUNT(   CASE
                    WHEN New_Follow_Up_Flag_Appointment = 'N' THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of child first attendances or procedures in ENT"
FROM [PAS_OP_Appointment_Frozen]
WHERE Attendance_Status_Code IN ( '5', '6' )
      AND
      (
          Main_Specialty_Code = 120
          OR Treatment_Function_Code IN ( '120', '215' )
      )
      AND Appointment_Date
      BETWEEN '20230701' AND '20240630'
	  AND Age_At_Appointment < 17;

/* First ENT attendance - % adult patient discharged (12mths to qtr end) 
Model Hospital ID: EN7128

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Type = 'First' 
AND ENT_AgeGroup = 'Adult' 
AND OUTCOME = '1'

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Type = 'First' 
AND ENT_AgeGroup = 'Adult'

Q1 2024/25

*/

SELECT COUNT(   CASE
                    WHEN Outpatient_Attendance_Outcome_Code = '1' THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of adult first attendances or procedures in ENT where patient discharged",
       COUNT(   CASE
                    WHEN New_Follow_Up_Flag_Appointment = 'N' THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of adult first attendances or procedures in ENT"
FROM [PAS_OP_Appointment_Frozen]
WHERE Attendance_Status_Code IN ( '5', '6' )
      AND
      (
          Main_Specialty_Code = 120
          OR Treatment_Function_Code IN ( '120', '215' )
      )
      AND Appointment_Date
      BETWEEN '20230701' AND '20240630'
      AND Age_At_Appointment > 16
      AND New_Follow_Up_Flag_Appointment = 'N';

/* First ENT attendance - % child patient discharged (12mths to qtr end) 
Model Hospital ID: EN7129

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Type = 'First' 
AND ENT_AgeGroup = 'Child' 
AND OUTCOME = '1'

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Type = 'First' 
AND ENT_AgeGroup = 'Child'

Q1 2024/25

*/


SELECT COUNT(   CASE
                    WHEN Outpatient_Attendance_Outcome_Code = '1' THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of child first attendances or procedures in ENT where patient discharged",
       COUNT(   CASE
                    WHEN New_Follow_Up_Flag_Appointment = 'N' THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of child first attendances or procedures in ENT"
FROM [PAS_OP_Appointment_Frozen]
WHERE Attendance_Status_Code IN ( '5', '6' )
      AND
      (
          Main_Specialty_Code = 120
          OR Treatment_Function_Code IN ( '120', '215' )
      )
      AND Appointment_Date
      BETWEEN '20230701' AND '20240630'
      AND Age_At_Appointment < 17
      AND New_Follow_Up_Flag_Appointment = 'N'
      AND Org_Code_Provider = 'RPA'
      AND Sector = 'MED';

/* Virtual attendance rate for adult outpatients attendances (12mths to qtr end) 
Model Hospital ID: EN7130

COUNT(OP attendances)
ATTENDED IN ('5','6')  
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Setting = 'Attendance' AND POD_Face = 'Virtual' 
AND ENT_AgeGroup = 'Adult'

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Setting = 'Attendance' 
AND ENT_AgeGroup = 'Adult'

Q1 2024/25

*/

SELECT COUNT(   CASE
                    WHEN M0010l_Virtual_Booking = 1 THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of virtual adult attendances in ENT",
       COUNT(OP_Attendance_ID) AS "Number of adult attendances in ENT"
FROM [M0010_OP_Appointment] 
WHERE Attendance_Status_Code IN ( '5', '6' )
      AND
      (
          Local_Sub_Specialty_Code = 120
          OR Treatment_Function_Code IN ( '120', '215' )
      )
      AND Appointment_Date
      BETWEEN '20230701' AND '20240630'
      AND Age_At_Appointment > 16
      AND Org_Code_Provider = 'RPA'
      AND Sector = 'MED';


/* Virtual attendance rate for child outpatients attendances under ENT specialty (12mths to qtr end) 
Model Hospital ID: EN7131

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Setting = 'Attendance' 
AND ENT_AgeGroup = 'Child' 
AND POD_Face = 'Virtual'

COUNT(OP attendances)
ATTENDED IN ('5','6') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND POD_Setting = 'Attendance' 
AND ENT_AgeGroup = 'Child'

Q1 2024/25

*/

SELECT COUNT(   CASE
                    WHEN M0010l_Virtual_Booking = 1 THEN
                        1
                    ELSE
                        NULL
                END
            ) AS "Number of virtual child attendances in ENT",
       COUNT(OP_Attendance_ID) AS "Number of child attendances in ENT"
FROM [M0010_OP_Appointment]
WHERE Attendance_Status_Code IN ( '5', '6' )
      AND
      (
          Local_Sub_Specialty_Code = 120
          OR Treatment_Function_Code IN ( '120', '215' )
      )
      AND Appointment_Date
      BETWEEN '20230701' AND '20240630'
      AND Age_At_Appointment < 17
      AND Org_Code_Provider = 'RPA'
      AND Sector = 'MED';

/* -------------------------------------------------------------------
	Non-Elective Care
 ------------------------------------------------------------------- */

/* Non-elective adult ENT admission with no procedure (12mths to qtr end) 
Model Hospital ID: EN7132

COUNT(Spells)
POD_Derived in ('EM','NE') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND ENT_AgeGroup = 'Adult' 
AND ENT_Dominant_Procedure = 'NoProc'

COUNT(Spells)
POD_Derived in ('EM','NE') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND ENT_AgeGroup = 'Adult'

Q1 2024/25

*/

-- Metric EN7132: Non-Elective Adult ENT Admissions with No Procedure (12 Months to Quarter End)

DECLARE @EN7132_StartDate DATE = '2023-07-01'; 
DECLARE @EN7132_EndDate DATE = '2024-06-30'; 

-- Numerator: Non-elective admissions with no procedure
DECLARE @EN7132_Num_NoProc INT;

SELECT @EN7132_Num_NoProc = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE POD_Derived IN ( 'EM', 'NE' )
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND SpellDominantProcedure_Current IS NULL
      AND Admission_Date
      BETWEEN @EN7132_StartDate AND @EN7132_EndDate;

-- Denominator: All non-elective admissions
DECLARE @EN7132_Denom_AllNonElective INT;

SELECT @EN7132_Denom_AllNonElective = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE POD_Derived IN ( 'EM', 'NE' )
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Adult'
      AND Admission_Date
      BETWEEN @EN7132_StartDate AND @EN7132_EndDate;

-- Calculate Rate
DECLARE @EN7132_Rate FLOAT;

SET @EN7132_Rate = (CAST(@EN7132_Num_NoProc AS FLOAT) / NULLIF(@EN7132_Denom_AllNonElective, 0)) * 100;

SELECT 'EN7132 - Non-Elective Adult ENT Admissions with No Procedure (12 Months to Quarter End)' AS Metric,
       @EN7132_Rate AS Percentage,
       @EN7132_Num_NoProc AS Numerator,
       @EN7132_Denom_AllNonElective AS Denominator;


/* Non-elective child ENT admission with no procedure (12mths to qtr end) 
Model Hospital ID: EN7133

COUNT(Spells)
POD_Derived in ('EM','NE') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND ENT_AgeGroup = 'Child' 
AND ENT_Dominant_Procedure = 'NoProc'

COUNT(Spells)
POD_Derived in ('EM','NE') 
AND (ENT_MainSpecialty = 'ENT' or ENT_TreatmentFunction = 'ENT') 
AND ENT_AgeGroup = 'Child'

Q1 2024/25

*/

-- Metric EN7133: Non-Elective Child ENT Admissions with No Procedure (12 Months to Quarter End)

DECLARE @EN7133_StartDate DATE = '2023-07-01'; 
DECLARE @EN7133_EndDate DATE = '2024-06-30'; 

-- Numerator: Non-elective admissions with no procedure
DECLARE @EN7133_Num_NoProc INT;

SELECT @EN7133_Num_NoProc = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE POD_Derived IN ( 'EM', 'NE' )
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Child'
      AND SpellDominantProcedure_Current IS NULL
      AND Admission_Date
      BETWEEN @EN7133_StartDate AND @EN7133_EndDate;

-- Denominator: All non-elective admissions
DECLARE @EN7133_Denom_AllNonElective INT;

SELECT @EN7133_Denom_AllNonElective = COUNT(DISTINCT Spell_Number)
FROM #Spells_With_Variables
WHERE POD_Derived IN ( 'EM', 'NE' )
      AND
      (
          ENT_MainSpecialty = 'ENT'
          OR ENT_TreatmentFunction = 'ENT'
      )
      AND ENT_AgeGroup = 'Child'
      AND Admission_Date
      BETWEEN @EN7133_StartDate AND @EN7133_EndDate;

-- Calculate Rate
DECLARE @EN7133_Rate FLOAT;

SET @EN7133_Rate = (CAST(@EN7133_Num_NoProc AS FLOAT) / NULLIF(@EN7133_Denom_AllNonElective, 0)) * 100;

SELECT 'EN7133 - Non-Elective Child ENT Admissions with No Procedure (12 Months to Quarter End)' AS Metric,
       @EN7133_Rate AS Percentage,
       @EN7133_Num_NoProc AS Numerator,
       @EN7133_Denom_AllNonElective AS Denominator;

--SQL Script Ends