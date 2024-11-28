# GIRFT

The SQL code in this repository was created using the Model Hospital metadata files, which consist of hundreds of different metrics now converted into functional SQL code. 

The **Getting It Right First Time (GIRFT)** programme is a national NHS England initiative designed to improve treatment and care by reviewing health services in England. It conducts clinically-led reviews of specialties, combining extensive data analysis with the expertise of senior clinicians to evaluate current practices and identify opportunities for improvement.

---

# Model Hospital

The **Model Health System** is a data-driven improvement tool that supports health and care systems in enhancing patient outcomes and population health. It provides benchmarked insights across quality of care, productivity, and organisational culture, helping identify areas for improvement. The Model Health System includes the **Model Hospital**, which offers hospital provider-level benchmarking.

### Key Features:
- Benchmark and compare productivity, quality, and responsiveness data.
- Identify opportunities for improvement at operational and system levels.
- Access data tailored for acute, ambulance, mental health, and community NHS trusts.
- Explore operational and system-level data across local STPs or ICSs.

Accessible to all NHS commissioners and providers in England, the Model Health System enables users from board to ward to dive deeper into their data, compare with peers, and understand what good practice looks like.

---

# Metadata Files

Below are links to GIRFT metadata files for various specialties:

### Breast Surgery:
[Download Breast Surgery Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_BreastSurgery.xlsx)

### Diabetes:
[Download Diabetes Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_Diabetes.xlsx)

### ENT:
[Download ENT Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_ENT.xlsx)

### Gastroenterology:
[Download Gastroenterology Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_Gastroenterology.xlsx)

### General & Acute Medicine:
[Download General & Acute Medicine Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_AGM.xlsx)

### Geriatric Medicine:
[Download Geriatric Medicine Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_GeriatricMedicine.xlsx)

### Gynaecology:
[Download Gynaecology Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_Gynaecology.xlsx)

### Orthopaedic Surgery:
[Download Orthopaedic Surgery Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_Orthopaedics.xlsx)

### Paediatrics:
- [Download Paediatric Trauma & Orthopaedics Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_PaediatricTandO.xlsx)
- [Download Paediatric Surgery Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_PaediatricSurgery.xlsx)
- [Download Paediatric ENT Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_PaediatricENT.xlsx)

### Respiratory Medicine:
[Download Respiratory Medicine Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_RespiratoryMedicine.xlsx)

### Spinal Services:
[Download Spinal Services Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_SpinalServices.xlsx)

### Urology:
[Download Urology Metadata](https://static.model.nhs.uk/downloads/GIRFT_Metadata_Urology.xlsx)

---

# SQL Code Structure

The SQL code follows a structured process to ensure consistency and accuracy:

1. **Drop Temp Tables**: Remove any temporary tables to allow a clean start if a reset is needed.
2. **Declare Variables**: Define key variables, such as organisation codes and date ranges.
3. **Create Code Groups**: Convert the metadata file's CodeGroups into temporary tables for metric calculation.
4. **Create Main Tables**: Establish main tables to store data for all metrics.
5. **Update Main Table Columns**: Populate main table columns based on the recipes provided in the metadata files.
6. **Write Metric SQL Code**: Implement the SQL logic using the snippets and guidance from the metadata files.

---

This repository is intended to assist healthcare professionals and analysts in leveraging the GIRFT programme and the Model Health System to improve care quality and efficiency.
