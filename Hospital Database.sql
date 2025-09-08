create database Hospital_Managment_System;
use Hospital_Managment_System;

-- Patient Table
CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    gender ENUM('M', 'F') NOT NULL,
    contact VARCHAR(20) NOT NULL,
    address VARCHAR(255)
);

-- Department Table
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Doctors Table
CREATE TABLE doctors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    specialty VARCHAR(100),
    contact VARCHAR(20) NOT NULL,
    FOREIGN KEY (department_id)
        REFERENCES departments (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (patient_id)
        REFERENCES patients (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Staff Table
CREATE TABLE staff (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    role TEXT NOT NULL,
    contact VARCHAR(20) NOT NULL
);

-- Users Table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(255)
);

-- Appointments Table
CREATE TABLE appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME,
    status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (patient_id)
        REFERENCES patients (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id)
        REFERENCES doctors (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Medical Records Table
CREATE TABLE medical_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    visit_date DATETIME,
    diagnosis TEXT,
    treatment TEXT,
    FOREIGN KEY (patient_id)
        REFERENCES patients (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id)
        REFERENCES doctors (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Billing Table
CREATE TABLE billing (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    amount DECIMAL(10 , 2 ),
    billing_date DATETIME,
    paid BOOLEAN,
    FOREIGN KEY (patient_id)
        REFERENCES patients (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insurance Provider Table
CREATE TABLE insurance_provider (
    id INT PRIMARY KEY AUTO_INCREMENT,
    provider VARCHAR(100),
    policy_number VARCHAR(50),
    coverage_amount DECIMAL(10 , 2 )
);

-- Patient Insurance Table
CREATE TABLE patient_insurance (
    patient_id INT,
    insurance_id INT,
    PRIMARY KEY (patient_id , insurance_id),
    FOREIGN KEY (patient_id)
        REFERENCES patients (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (insurance_id)
        REFERENCES insurance_provider (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Medicine Table
CREATE TABLE medicines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    stock INT
);

-- Prescription Table
CREATE TABLE prescriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    medicine_id INT NOT NULL,
    dosage VARCHAR(50),
    frequency VARCHAR(50),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (patient_id)
        REFERENCES patients (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id)
        REFERENCES doctors (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (medicine_id)
        REFERENCES medicines (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Feedback by users Table
CREATE TABLE feedback (
    patient_id INT NOT NULL,
    doctor_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comments TEXT,
    PRIMARY KEY (patient_id , doctor_id),
    FOREIGN KEY (patient_id)
        REFERENCES patients (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id)
        REFERENCES doctors (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Rooms Table
CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10),
    type ENUM('General', 'ICU', 'Operation Theater'),
    availability BOOLEAN
);

-- Schedules Table
CREATE TABLE schedules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (doctor_id)
        REFERENCES doctors (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Test results Table
CREATE TABLE test_results (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    test_name VARCHAR(100),
    result TEXT,
    test_date DATE,
    FOREIGN KEY (patient_id)
        REFERENCES patients (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

--  Data Insertion

-- Patients
INSERT INTO patients (name, dob, gender, contact, address) VALUES
('Ahmed Khan', '1985-03-14', 'M', '03001234567', 'Street 10, G-11, Islamabad'),
('Fatima Bibi', '1992-08-22', 'F', '03111234567', 'House 5, Model Town, Lahore'),
('Ali Raza', '1978-12-30', 'M', '03211234567', 'Flat 9, Clifton Block 2, Karachi'),
('Ayesha Noor', '1989-05-17', 'F', '03011223344', 'Near Khyber Market, Peshawar'),
('Bilal Aslam', '1983-09-02', 'M', '03334567890', 'F-7 Sector, Islamabad'),
('Maria Iqbal', '1990-11-01', 'F', '03451234567', 'DHA Phase 5, Lahore'),
('Usman Ghani', '1982-04-04', 'M', '03034561234', 'Johar Town, Lahore'),
('Sana Tariq', '1994-06-10', 'F', '03229876543', 'Gulshan-e-Iqbal, Karachi'),
('Hamza Ali', '1987-01-25', 'M', '03015678900', 'PECHS Block 6, Karachi'),
('Zainab Shah', '1991-07-14', 'F', '03322110055', 'Satellite Town, Rawalpindi'),
('Tariq Mehmood', '1975-10-10', 'M', '03453334455', 'Civil Lines, Multan'),
('Kiran Zafar', '1993-02-18', 'F', '03008887766', 'Gulberg III, Lahore'),
('Rehan Qureshi', '1984-06-30', 'M', '03227776655', 'Faisal Colony, Quetta'),
('Hira Saeed', '1990-12-12', 'F', '03116665444', 'Airport Road, Sialkot'),
('Shahbaz Anwar', '1986-11-20', 'M', '03330001122', 'Satellite Town, Gujranwala'),
('Nimra Naveed', '1995-03-03', 'F', '03009998877', 'Wapda Town, Lahore'),
('Adnan Bashir', '1981-07-07', 'M', '03451112233', 'Gulzar-e-Hijri, Karachi'),
('Mehwish Aamir', '1988-08-18', 'F', '03002223344', 'North Nazimabad, Karachi'),
('Fahad Yousuf', '1979-01-09', 'M', '03214445566', 'Cantt Area, Hyderabad'),
('Rabia Anwar', '1996-09-16', 'F', '03118889900', 'Model Colony, Karachi'),
('Imran Shah', '1980-02-02', 'M', '03456667788', 'Saddar, Faisalabad'),
('Saima Bano', '1992-06-06', 'F', '03334440011', 'Jinnah Town, Quetta'),
('Rashid Latif', '1983-05-12', 'M', '03017778899', 'Chowk Yadgar, Peshawar'),
('Sadia Haroon', '1987-03-23', 'F', '03219990077', 'Askari 10, Lahore'),
('Nabeel Javed', '1990-10-05', 'M', '03006665544', 'Korangi, Karachi'),
('Areeba Faisal', '1994-04-28', 'F', '03452221100', 'DHA Phase 2, Islamabad'),
('Junaid Alam', '1985-08-08', 'M', '03115556677', 'New Garden Town, Lahore'),
('Nazia Zubair', '1991-01-19', 'F', '03012221199', 'Tariq Road, Karachi'),
('Waqar Younis', '1977-12-04', 'M', '03338884477', 'University Road, Quetta'),
('Hina Shaikh', '1993-09-09', 'F', '03223336611', 'Bahadurabad, Karachi'),
('Arif Masood', '1989-06-01', 'M', '03457779900', 'Satellite Town, Sargodha'),
('Maham Riaz', '1992-03-15', 'F', '03013334422', 'Shalimar Town, Lahore'),
('Omar Zaman', '1986-07-11', 'M', '03114443322', 'F-10 Markaz, Islamabad'),
('Neha Rizwan', '1995-12-30', 'F', '03451114455', 'Iqbal Town, Lahore'),
('Hassan Rauf', '1983-05-05', 'M', '03018883377', 'Samanabad, Lahore'),
('Lubna Awan', '1994-01-07', 'F', '03331115566', 'Gulistan-e-Johar, Karachi'),
('Kamran Shahid', '1978-09-27', 'M', '03216662255', 'Mall Road, Lahore'),
('Farah Nadeem', '1989-10-13', 'F', '03450009988', 'Nishtar Town, Multan'),
('Danish Afzal', '1982-11-23', 'M', '03002220077', 'Cantt, Lahore'),
('Sarah Fayyaz', '1990-08-19', 'F', '03116668800', 'Shah Faisal Colony, Karachi'),
('Yasir Mehmood', '1981-02-20', 'M', '03334443300', 'F-6 Sector, Islamabad'),
('Huma Shah', '1993-11-30', 'F', '03014440033', 'Allama Iqbal Town, Lahore'),
('Adeel Raja', '1976-07-17', 'M', '03229992200', 'Saddar, Karachi'),
('Nadia Khawar', '1988-04-09', 'F', '03457778866', 'Gulberg Greens, Islamabad'),
('Zeeshan Haider', '1987-12-01', 'M', '03119993322', 'Askari 11, Lahore'),
('Rida Sattar', '1991-06-25', 'F', '03014445566', 'Garden East, Karachi'),
('Asim Jatoi', '1980-03-10', 'M', '03212221111', 'Bahria Town, Lahore'),
('Anam Tariq', '1994-10-07', 'F', '03119990033', 'Phase 6 DHA, Karachi'),
('Sajjad Hussain', '1979-01-03', 'M', '03458887722', 'PWD Colony, Islamabad');

-- Departments
INSERT INTO departments (id, name) VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'Pediatrics'),
(5, 'Gynecology'),
(6, 'Dermatology'),
(7, 'ENT'),
(8, 'Oncology'),
(9, 'Psychiatry'),
(10, 'Radiology'),
(11, 'Urology'),
(12, 'Nephrology'),
(13, 'Gastroenterology'),
(14, 'Endocrinology'),
(15, 'Hematology'),
(16, 'Pulmonology'),
(17, 'Ophthalmology'),
(18, 'Anesthesiology'),
(19, 'Emergency Medicine'),
(20, 'General Surgery'),
(21, 'Plastic Surgery'),
(22, 'Cardiothoracic Surgery'),
(23, 'Vascular Surgery'),
(24, 'Pathology'),
(25, 'Rehabilitation Medicine'),
(26, 'Internal Medicine'),
(27, 'Family Medicine'),
(28, 'Infectious Diseases'),
(29, 'Nuclear Medicine'),
(30, 'Allergy and Immunology');

-- Doctors
INSERT INTO doctors (id, name, patient_id, department_id, specialty, contact) VALUES
(1, 'Dr. Faisal Ahmed', NULL, 1, 'Cardiologist', '03211234501'),
(2, 'Dr. Sana Iqbal', 4, 2, 'Neurologist', '03221234502'),
(3, 'Dr. Imran Sheikh', 1, 3, 'Orthopedist', '03231234503'),
(4, 'Dr. Amina Tariq', 5, 4, 'Pediatrician', '03241234504'),
(5, 'Dr. Kamran Javed', 7, 5, 'Gynecologist', '03251234505'),
(6, 'Dr. Nida Saeed', 9, 6, 'Dermatologist', '03261234506'),
(7, 'Dr. Rashid Ali', NULL, 7, 'ENT Specialist', '03271234507'),
(8, 'Dr. Mahnoor Khan', 2, 8, 'Oncologist', '03281234508'),
(9, 'Dr. Usman Rauf', 10, 9, 'Psychiatrist', '03291234509'),
(10, 'Dr. Rabia Shah', 6, 10, 'Radiologist', '03301234510'),
(11, 'Dr. Ahmed Zafar', NULL, 11, 'Urologist', '03311234511'),
(12, 'Dr. Sana Malik', 12, 12, 'Nephrologist', '03321234512'),
(13, 'Dr. Ali Hassan', NULL, 13, 'Gastroenterologist', '03331234513'),
(14, 'Dr. Fatima Noor', 8, 14, 'Endocrinologist', '03341234514'),
(15, 'Dr. Bilal Raza', 3, 15, 'Hematologist', '03351234515'),
(16, 'Dr. Samina Khan', NULL, 16, 'Pulmonologist', '03361234516'),
(17, 'Dr. Tariq Javed', 11, 17, 'Ophthalmologist', '03371234517'),
(18, 'Dr. Maryam Qureshi', 14, 18, 'Anesthesiologist', '03381234518'),
(19, 'Dr. Imtiaz Shah', NULL, 19, 'Emergency Medicine', '03391234519'),
(20, 'Dr. Ayesha Iqbal', 13, 20, 'General Surgeon', '03401234520'),
(21, 'Dr. Omar Farooq', NULL, 21, 'Plastic Surgeon', '03411234521'),
(22, 'Dr. Hina Riaz', 15, 22, 'Cardiothoracic Surgeon', '03421234522'),
(23, 'Dr. Saad Malik', NULL, 23, 'Vascular Surgeon', '03431234523'),
(24, 'Dr. Saba Ahmed', 16, 24, 'Pathologist', '03441234524'),
(25, 'Dr. Faisal Khan', NULL, 25, 'Rehabilitation Medicine', '03451234525'),
(26, 'Dr. Noreen Siddiqui', 17, 26, 'Internal Medicine', '03461234526'),
(27, 'Dr. Zain Abbas', NULL, 27, 'Family Medicine', '03471234527'),
(28, 'Dr. Sana Tariq', 18, 28, 'Infectious Disease Specialist', '03481234528'),
(29, 'Dr. Asim Raza', NULL, 29, 'Nuclear Medicine', '03491234529'),
(30, 'Dr. Amina Farooq', 19, 30, 'Allergist & Immunologist', '03501234530'),
(31, 'Dr. Yasir Shah', NULL, 1, 'Cardiologist', '03511234531'),
(32, 'Dr. Rabia Khan', 20, 2, 'Neurologist', '03521234532'),
(33, 'Dr. Asad Malik', NULL, 3, 'Orthopedist', '03531234533'),
(34, 'Dr. Huma Ali', 21, 4, 'Pediatrician', '03541234534'),
(35, 'Dr. Kamal Ahmed', NULL, 5, 'Gynecologist', '03551234535'),
(36, 'Dr. Shazia Khan', 22, 6, 'Dermatologist', '03561234536'),
(37, 'Dr. Tariq Mahmood', NULL, 7, 'ENT Specialist', '03571234537'),
(38, 'Dr. Noor Fatima', 23, 8, 'Oncologist', '03581234538'),
(39, 'Dr. Waqas Ahmed', NULL, 9, 'Psychiatrist', '03591234539'),
(40, 'Dr. Areeba Aslam', 24, 10, 'Radiologist', '03601234540'),
(41, 'Dr. Shahid Iqbal', NULL, 11, 'Urologist', '03611234541'),
(42, 'Dr. Iqra Malik', 25, 12, 'Nephrologist', '03621234542'),
(43, 'Dr. Hamza Ali', NULL, 13, 'Gastroenterologist', '03631234543'),
(44, 'Dr. Zara Khan', 26, 14, 'Endocrinologist', '03641234544'),
(45, 'Dr. Faisal Qureshi', NULL, 15, 'Hematologist', '03651234545'),
(46, 'Dr. Saira Abbas', 27, 16, 'Pulmonologist', '03661234546'),
(47, 'Dr. Kamran Shah', NULL, 17, 'Ophthalmologist', '03671234547'),
(48, 'Dr. Nadia Aslam', 28, 18, 'Anesthesiologist', '03681234548'),
(49, 'Dr. Usman Malik', NULL, 19, 'Emergency Medicine', '03691234549'),
(50, 'Dr. Maria Riaz', 29, 20, 'General Surgeon', '03701234550');

-- Staff
INSERT INTO staff (id, name, role, contact) VALUES
(1, 'Nurse Samina', 'Nurse', '03401234501'),
(2, 'Receptionist Arif', 'Receptionist', '03411234502'),
(3, 'Cleaner Kamal', 'Cleaner', '03421234503'),
(4, 'Technician Aslam', 'Technician', '03431234504'),
(5, 'Pharmacist Adeel', 'Pharmacist', '03441234505'),
(6, 'Lab Assistant Sana', 'Lab Assistant', '03451234506'),
(7, 'Security Ahmed', 'Security', '03461234507'),
(8, 'Janitor Bilal', 'Janitor', '03471234508'),
(9, 'Accountant Zain', 'Accountant', '03481234509'),
(10, 'Driver Tariq', 'Driver', '03491234510'),
(11, 'Nurse Farah', 'Nurse', '03501234511'),
(12, 'Receptionist Kashif', 'Receptionist', '03511234512'),
(13, 'Cleaner Nadeem', 'Cleaner', '03521234513'),
(14, 'Technician Nasir', 'Technician', '03531234514'),
(15, 'Pharmacist Faizan', 'Pharmacist', '03541234515'),
(16, 'Lab Assistant Mariam', 'Lab Assistant', '03551234516'),
(17, 'Security Salman', 'Security', '03561234517'),
(18, 'Janitor Raza', 'Janitor', '03571234518'),
(19, 'Accountant Hina', 'Accountant', '03581234519'),
(20, 'Driver Imran', 'Driver', '03591234520'),
(21, 'Nurse Sana', 'Nurse', '03601234521'),
(22, 'Receptionist Saeed', 'Receptionist', '03611234522'),
(23, 'Cleaner Asif', 'Cleaner', '03621234523'),
(24, 'Technician Waseem', 'Technician', '03631234524'),
(25, 'Pharmacist Noman', 'Pharmacist', '03641234525'),
(26, 'Lab Assistant Huma', 'Lab Assistant', '03651234526'),
(27, 'Security Tariq', 'Security', '03661234527'),
(28, 'Janitor Yasir', 'Janitor', '03671234528'),
(29, 'Accountant Rabia', 'Accountant', '03681234529'),
(30, 'Driver Fahad', 'Driver', '03691234530'),
(31, 'Nurse Ayesha', 'Nurse', '03701234531'),
(32, 'Receptionist Kamran', 'Receptionist', '03711234532'),
(33, 'Cleaner Javed', 'Cleaner', '03721234533'),
(34, 'Technician Bilal', 'Technician', '03731234534'),
(35, 'Pharmacist Rida', 'Pharmacist', '03741234535'),
(36, 'Lab Assistant Saima', 'Lab Assistant', '03751234536'),
(37, 'Security Iqbal', 'Security', '03761234537'),
(38, 'Janitor Nisar', 'Janitor', '03771234538'),
(39, 'Accountant Shehzad', 'Accountant', '03781234539'),
(40, 'Driver Zafar', 'Driver', '03791234540');

-- Users
INSERT INTO users ( username, password, role) VALUES
('dfaisal', 'pass123', 'Doctor'),
('snida', 'nursepass', 'Nurse'),
('arifrecp', 'receppass', 'Receptionist'),
('admin1', 'adminpass', 'Admin'),
('adeelpharma', 'pharma123', 'Pharmacist'),
('sanalab', 'labpass', 'Lab Assistant'),
('rashidsec', 'secpass', 'Security'),
('bilaljanitor', 'janitorpass', 'Janitor'),
('zainacc', 'account123', 'Accountant'),
('tariqdriver', 'driverpass', 'Driver'),
('farahnurse', 'nurse456', 'Nurse'),
('kashifrecp', 'recp456', 'Receptionist'),
('nadeemclean', 'clean123', 'Cleaner'),
('nasirtech', 'techpass', 'Technician'),
('faizanpharma', 'pharma456', 'Pharmacist'),
('mariamlab', 'lab456', 'Lab Assistant'),
('salmansec', 'sec456', 'Security'),
('razajanitor', 'janitor456', 'Janitor'),
('hinacc', 'account456', 'Accountant'),
('imrandriver', 'driver456', 'Driver'),
('sanam', 'pass789', 'Nurse'),
('saeedrecp', 'recp789', 'Receptionist'),
('asifclean', 'clean789', 'Cleaner'),
('waseemtech', 'tech789', 'Technician'),
('nomanpharma', 'pharma789', 'Pharmacist'),
('humalab', 'lab789', 'Lab Assistant'),
('tariqsec', 'sec789', 'Security'),
('yasirjanitor', 'janitor789', 'Janitor'),
('rabiaacc', 'account789', 'Accountant'),
('fahaddriver', 'driver789', 'Driver'),
('ayeshanurse', 'nurse101', 'Nurse'),
('kamranrecp', 'recp101', 'Receptionist'),
('javedclean', 'clean101', 'Cleaner'),
('bilaltech', 'tech101', 'Technician'),
('ridapharma', 'pharma101', 'Pharmacist'),
('saimalab', 'lab101', 'Lab Assistant'),
('iqbalsec', 'sec101', 'Security'),
('nisarjanitor', 'janitor101', 'Janitor'),
('shehzadacc', 'account101', 'Accountant'),
('zafardriver', 'driver101', 'Driver'),
('aliadmin', 'admin123', 'Admin'),
('fatimanurse', 'nurse102', 'Nurse'),
('zainabrecp', 'recp102', 'Receptionist'),
('umerclean', 'clean102', 'Cleaner'),
('haroontech', 'tech102', 'Technician'),
('salmapharma', 'pharma102', 'Pharmacist'),
('danialab', 'lab102', 'Lab Assistant'),
('junaidsec', 'sec102', 'Security'),
('rahuljanitor', 'janitor102', 'Janitor'),
('umaracc', 'account102', 'Accountant');

-- Appointments
INSERT INTO appointments (id, patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, 1, '2025-05-01 09:00:00', 'Completed'),
(2, 2, 3, '2025-05-03 14:30:00', 'Completed'),
(3, 3, 5, '2025-05-05 11:00:00', 'Cancelled'),
(4, 4, 2, '2025-05-07 10:00:00', 'Scheduled'),
(5, 5, 4, '2025-05-10 15:30:00', 'Completed'),
(6, 6, 6, '2025-05-12 09:45:00', 'Scheduled'),
(7, 7, 7, '2025-05-15 13:00:00', 'Cancelled'),
(8, 8, 8, '2025-05-18 16:00:00', 'Completed'),
(9, 9, 9, '2025-05-20 08:30:00', 'Scheduled'),
(10, 10, 10, '2025-05-22 14:00:00', 'Completed'),
(11, 11, 11, '2025-05-25 10:15:00', 'Scheduled'),
(12, 12, 12, '2025-05-28 09:00:00', 'Cancelled'),
(13, 13, 13, '2025-06-01 11:30:00', 'Completed'),
(14, 14, 14, '2025-06-03 13:45:00', 'Scheduled'),
(15, 15, 15, '2025-06-05 14:00:00', 'Completed'),
(16, 16, 16, '2025-06-07 09:00:00', 'Cancelled'),
(17, 17, 17, '2025-06-10 10:30:00', 'Scheduled'),
(18, 18, 18, '2025-06-12 15:00:00', 'Completed'),
(19, 19, 19, '2025-06-15 08:00:00', 'Scheduled'),
(20, 20, 20, '2025-06-17 11:00:00', 'Completed'),
(21, 21, 21, '2025-06-19 09:15:00', 'Scheduled'),
(22, 22, 22, '2025-06-21 14:45:00', 'Completed'),
(23, 23, 23, '2025-06-23 13:30:00', 'Cancelled'),
(24, 24, 24, '2025-06-25 10:00:00', 'Scheduled'),
(25, 25, 25, '2025-06-27 15:30:00', 'Completed'),
(26, 26, 26, '2025-06-29 09:45:00', 'Scheduled'),
(27, 27, 27, '2025-07-01 08:30:00', 'Cancelled'),
(28, 28, 28, '2025-07-03 14:00:00', 'Completed'),
(29, 29, 29, '2025-07-05 11:00:00', 'Scheduled'),
(30, 30, 30, '2025-07-07 16:00:00', 'Completed');

-- Medical Records
INSERT INTO medical_records (id, patient_id, doctor_id, visit_date, diagnosis, treatment) VALUES
(1, 1, 1, '2025-06-01', 'Hypertension', 'Medication A'),
(2, 2, 2, '2025-06-02', 'Migraine', 'Medication B'),
(3, 3, 3, '2025-06-03', 'Fracture', 'Surgery'),
(4, 4, 4, '2025-06-04', 'Flu', 'Rest and Medication'),
(5, 5, 5, '2025-06-05', 'Pregnancy Checkup', 'Routine Monitoring'),
(6, 6, 6, '2025-06-06', 'Eczema', 'Topical Cream'),
(7, 7, 7, '2025-06-07', 'Sinusitis', 'Antibiotics'),
(8, 8, 8, '2025-06-08', 'Cancer', 'Chemotherapy'),
(9, 9, 9, '2025-06-09', 'Depression', 'Therapy and Medication'),
(10, 10, 10, '2025-06-10', 'Broken Bone', 'Cast and Rest'),
(11, 11, 1, '2025-06-11', 'Asthma', 'Inhaler'),
(12, 12, 2, '2025-06-12', 'Tension Headache', 'Pain Relievers'),
(13, 13, 3, '2025-06-13', 'Sprained Ankle', 'Physical Therapy'),
(14, 14, 4, '2025-06-14', 'Common Cold', 'Rest and Fluids'),
(15, 15, 5, '2025-06-15', 'Prenatal Checkup', 'Routine Monitoring'),
(16, 16, 6, '2025-06-16', 'Psoriasis', 'Medicated Shampoo'),
(17, 17, 7, '2025-06-17', 'Allergic Rhinitis', 'Antihistamines'),
(18, 18, 8, '2025-06-18', 'Leukemia', 'Radiation Therapy'),
(19, 19, 9, '2025-06-19', 'Anxiety', 'Counseling'),
(20, 20, 10, '2025-06-20', 'Dislocated Shoulder', 'Reduction and Rest'),
(21, 21, 1, '2025-06-21', 'High Cholesterol', 'Diet and Medication'),
(22, 22, 2, '2025-06-22', 'Cluster Headache', 'Oxygen Therapy'),
(23, 23, 3, '2025-06-23', 'Torn Ligament', 'Surgery'),
(24, 24, 4, '2025-06-24', 'Bronchitis', 'Antibiotics'),
(25, 25, 5, '2025-06-25', 'Postpartum Checkup', 'Routine Monitoring'),
(26, 26, 6, '2025-06-26', 'Acne', 'Topical Treatment'),
(27, 27, 7, '2025-06-27', 'Ear Infection', 'Antibiotics'),
(28, 28, 8, '2025-06-28', 'Lymphoma', 'Chemotherapy'),
(29, 29, 9, '2025-06-29', 'Bipolar Disorder', 'Medication and Therapy'),
(30, 30, 10, '2025-06-30', 'Hairline Fracture', 'Immobilization'),
(31, 1, 1, '2025-07-01', 'Arrhythmia', 'Medication'),
(32, 2, 2, '2025-07-02', 'Stroke', 'Rehabilitation'),
(33, 3, 3, '2025-07-03', 'Arthritis', 'Pain Management'),
(34, 4, 4, '2025-07-04', 'Allergic Reaction', 'Antihistamines'),
(35, 5, 5, '2025-07-05', 'Ultrasound Scan', 'Routine Check'),
(36, 6, 6, '2025-07-06', 'Fungal Infection', 'Antifungal Cream'),
(37, 7, 7, '2025-07-07', 'Tonsillitis', 'Antibiotics'),
(38, 8, 8, '2025-07-08', 'Melanoma', 'Surgical Removal'),
(39, 9, 9, '2025-07-09', 'PTSD', 'Psychotherapy'),
(40, 10, 10, '2025-07-10', 'Knee Injury', 'Physical Therapy'),
(41, 11, 1, '2025-07-11', 'Coronary Artery Disease', 'Medication and Lifestyle Change'),
(42, 12, 2, '2025-07-12', 'Epilepsy', 'Medication'),
(43, 13, 3, '2025-07-13', 'Back Pain', 'Physiotherapy'),
(44, 14, 4, '2025-07-14', 'Cold Sores', 'Antiviral Medication'),
(45, 15, 5, '2025-07-15', 'Routine Prenatal Check', 'Monitoring');

-- Billing
INSERT INTO billing (id, patient_id, amount, billing_date, paid) VALUES
(1, 1, 2000.00, '2025-06-05', TRUE),
(2, 2, 1500.00, '2025-06-06', FALSE),
(3, 3, 5000.00, '2025-06-07', TRUE),
(4, 4, 1000.00, '2025-06-08', TRUE),
(5, 5, 2500.00, '2025-06-09', FALSE),
(6, 6, 800.00, '2025-06-10', TRUE),
(7, 7, 1200.00, '2025-06-11', TRUE),
(8, 8, 7000.00, '2025-06-12', FALSE),
(9, 9, 600.00, '2025-06-13', TRUE),
(10, 10, 3000.00, '2025-06-14', TRUE),
(11, 11, 2200.00, '2025-06-15', FALSE),
(12, 12, 1800.00, '2025-06-16', TRUE),
(13, 13, 3500.00, '2025-06-17', TRUE),
(14, 14, 900.00, '2025-06-18', FALSE),
(15, 15, 2600.00, '2025-06-19', TRUE),
(16, 16, 1100.00, '2025-06-20', TRUE),
(17, 17, 1300.00, '2025-06-21', FALSE),
(18, 18, 7200.00, '2025-06-22', TRUE),
(19, 19, 750.00, '2025-06-23', TRUE),
(20, 20, 3100.00, '2025-06-24', FALSE),
(21, 21, 2100.00, '2025-06-25', TRUE),
(22, 22, 1950.00, '2025-06-26', TRUE),
(23, 23, 3400.00, '2025-06-27', FALSE),
(24, 24, 950.00, '2025-06-28', TRUE),
(25, 25, 2700.00, '2025-06-29', TRUE);

-- Insurance
INSERT INTO insurance_provider (id, provider, policy_number, coverage_amount) VALUES
(1, 'Adamjee Insurance', 'AD123456', 20000.00),
(2, 'EFU Insurance', 'EF654321', 30000.00),
(3, 'Jubilee Insurance', 'JU789012', 25000.00),
(4, 'State Life', 'SL345678', 40000.00),
(5, 'New Jubilee', 'NJ901234', 15000.00),
(6, 'TPL Insurance', 'TP567890', 35000.00),
(7, 'Pak Qatar', 'PQ234567', 45000.00),
(8, 'SLIC', 'SL123890', 22000.00),
(9, 'Askari Insurance', 'AS345123', 27000.00),
(10, 'Alfalah Insurance', 'AL678901', 32000.00);

-- Patient Insurance
INSERT INTO patient_insurance (patient_id, insurance_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 6),
(17, 7),
(18, 8),
(19, 9),
(20, 10),
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 5),
(26, 6),
(27, 7),
(28, 8),
(29, 9),
(30, 10),
(31, 1),
(32, 2),
(33, 3),
(34, 4),
(35, 5),
(36, 6),
(37, 7),
(38, 8),
(39, 9),
(40, 10),
(41, 1),
(42, 2),
(43, 3),
(44, 4);

-- Medicines
INSERT INTO medicines (id, name, description, stock) VALUES
(1, 'Paracetamol', 'Pain reliever', 500),
(2, 'Ibuprofen', 'Anti-inflammatory', 400),
(3, 'Amoxicillin', 'Antibiotic', 300),
(4, 'Cetirizine', 'Allergy medicine', 350),
(5, 'Metformin', 'Diabetes treatment', 200),
(6, 'Omeprazole', 'Acid reflux treatment', 250),
(7, 'Amlodipine', 'Blood pressure medication', 150),
(8, 'Salbutamol', 'Asthma inhaler', 180),
(9, 'Azithromycin', 'Antibiotic', 220),
(10, 'Diclofenac', 'Pain and inflammation', 170),
(11, 'Loratadine', 'Antihistamine', 400),
(12, 'Ciprofloxacin', 'Antibiotic', 190),
(13, 'Ranitidine', 'Acid reducer', 230),
(14, 'Hydrochlorothiazide', 'Diuretic', 120),
(15, 'Levothyroxine', 'Thyroid hormone', 210),
(16, 'Fluconazole', 'Antifungal', 160),
(17, 'Clindamycin', 'Antibiotic', 140),
(18, 'Nitroglycerin', 'Heart medication', 130),
(19, 'Gabapentin', 'Nerve pain relief', 170),
(20, 'Prednisone', 'Steroid anti-inflammatory', 150),
(21, 'Losartan', 'Blood pressure medication', 220),
(22, 'Warfarin', 'Blood thinner', 110),
(23, 'Sertraline', 'Antidepressant', 200),
(24, 'Tamsulosin', 'Urinary issues', 180),
(25, 'Furosemide', 'Diuretic', 160),
(26, 'Morphine', 'Pain reliever', 90),
(27, 'Doxycycline', 'Antibiotic', 200),
(28, 'Clopidogrel', 'Blood thinner', 140),
(29, 'Metoprolol', 'Beta blocker', 190),
(30, 'Pantoprazole', 'Acid reflux', 210),
(31, 'Tramadol', 'Pain reliever', 130),
(32, 'Allopurinol', 'Gout treatment', 170),
(33, 'Enalapril', 'Blood pressure medication', 150),
(34, 'Epinephrine', 'Allergy emergency', 120),
(35, 'Atenolol', 'Blood pressure medication', 160),
(36, 'Levocetirizine', 'Antihistamine', 190),
(37, 'Hydrocortisone', 'Steroid cream', 210),
(38, 'Melatonin', 'Sleep aid', 230),
(39, 'Clarithromycin', 'Antibiotic', 180),
(40, 'Ondansetron', 'Anti-nausea', 150),
(41, 'Budesonide', 'Asthma treatment', 170),
(42, 'Amiodarone', 'Heart rhythm', 110),
(43, 'Dexamethasone', 'Steroid', 160),
(44, 'Sildenafil', 'Erectile dysfunction', 130),
(45, 'Metronidazole', 'Antibiotic', 140),
(46, 'Bisoprolol', 'Beta blocker', 120),
(47, 'Famotidine', 'Acid reducer', 210),
(48, 'Valacyclovir', 'Antiviral', 150),
(49, 'Hydroxychloroquine', 'Autoimmune treatment', 170),
(50, 'Risperidone', 'Antipsychotic', 130),
(51, 'Alprazolam', 'Anxiety medication', 110),
(52, 'Clonazepam', 'Seizure control', 140),
(53, 'Aspirin', 'Pain reliever and blood thinner', 200),
(54, 'Dicloxacillin', 'Antibiotic', 160),
(55, 'Levothyroxine', 'Thyroid hormone', 190),
(56, 'Lisinopril', 'Blood pressure medication', 170),
(57, 'Metformin ER', 'Extended-release diabetes treatment', 210),
(58, 'Nifedipine', 'Blood pressure medication', 130),
(59, 'Propranolol', 'Beta blocker', 150),
(60, 'Zolpidem', 'Sleep aid', 120),
(61, 'Carbamazepine', 'Seizure medication', 110),
(62, 'Venlafaxine', 'Antidepressant', 140),
(63, 'Levofloxacin', 'Antibiotic', 190),
(64, 'Hydralazine', 'Blood pressure medication', 130),
(65, 'Phenobarbital', 'Seizure medication', 150),
(66, 'Olanzapine', 'Antipsychotic', 160),
(67, 'Methylprednisolone', 'Steroid', 170),
(68, 'Clopidogrel Bisulfate', 'Blood thinner', 180),
(69, 'Dabigatran', 'Blood thinner', 120),
(70, 'Sumatriptan', 'Migraine relief', 140);

-- Prescriptions
INSERT INTO prescriptions (patient_id, doctor_id, medicine_id, dosage, frequency, start_date, end_date) VALUES
(11, 1, 1, '500mg', 'Once daily', '2025-06-11', '2025-06-21'),
(12, 2, 2, '10mg', 'Twice daily', '2025-06-12', '2025-06-22'),
(13, 3, 3, '250mg', 'Three times daily', '2025-06-13', '2025-06-23'),
(14, 4, 4, '5mg', 'Once daily', '2025-06-14', '2025-06-24'),
(15, 5, 5, '850mg', 'Twice daily', '2025-06-15', '2025-06-25'),
(16, 6, 6, '20mg', 'Once daily', '2025-06-16', '2025-06-26'),
(17, 7, 7, '5mg', 'Once daily', '2025-06-17', '2025-06-27'),
(18, 8, 8, '2 puffs', 'As needed', '2025-06-18', '2025-06-28'),
(19, 9, 9, '250mg', 'Once daily', '2025-06-19', '2025-06-29'),
(20, 10, 10, '50mg', 'Twice daily', '2025-06-20', '2025-06-30'),
(21, 1, 1, '500mg', 'Once daily', '2025-06-21', '2025-07-01'),
(22, 2, 2, '10mg', 'Twice daily', '2025-06-22', '2025-07-02'),
(23, 3, 3, '500mg', 'Three times daily', '2025-06-23', '2025-07-03'),
(24, 4, 4, '5mg', 'Once daily', '2025-06-24', '2025-07-04'),
(25, 5, 5, '850mg', 'Twice daily', '2025-06-25', '2025-07-05'),
(26, 6, 6, '20mg', 'Once daily', '2025-06-26', '2025-07-06'),
(27, 7, 7, '5mg', 'Once daily', '2025-06-27', '2025-07-07'),
(28, 8, 8, '2 puffs', 'As needed', '2025-06-28', '2025-07-08'),
(29, 9, 9, '250mg', 'Once daily', '2025-06-29', '2025-07-09'),
(30, 10, 10, '50mg', 'Twice daily', '2025-06-30', '2025-07-10'),
(31, 1, 1, '500mg', 'Once daily', '2025-07-01', '2025-07-11'),
(32, 2, 2, '10mg', 'Twice daily', '2025-07-02', '2025-07-12'),
(33, 3, 3, '500mg', 'Three times daily', '2025-07-03', '2025-07-13'),
(34, 4, 4, '5mg', 'Once daily', '2025-07-04', '2025-07-14'),
(35, 5, 5, '850mg', 'Twice daily', '2025-07-05', '2025-07-15'),
(36, 6, 6, '20mg', 'Once daily', '2025-07-06', '2025-07-16'),
(37, 7, 7, '5mg', 'Once daily', '2025-07-07', '2025-07-17'),
(38, 8, 8, '2 puffs', 'As needed', '2025-07-08', '2025-07-18'),
(39, 9, 9, '250mg', 'Once daily', '2025-07-09', '2025-07-19'),
(40, 10, 10, '50mg', 'Twice daily', '2025-07-10', '2025-07-20');

-- Feedback
INSERT INTO feedback (patient_id, doctor_id, rating, comments) VALUES
(11, 1, 5, 'Outstanding consultation and diagnosis.'),
(12, 2, 4, 'Very polite and knowledgeable.'),
(13, 3, 3, 'Satisfactory treatment but room for improvement.'),
(14, 4, 5, 'Highly recommended pediatric care.'),
(15, 5, 4, 'Responsive and professional.'),
(16, 6, 5, 'Resolved my skin issues quickly.'),
(17, 7, 4, 'Skilled ENT specialist, good follow-up.'),
(18, 8, 5, 'Cancer treatment was handled excellently.'),
(19, 9, 3, 'Counseling sessions were useful but brief.'),
(20, 10, 4, 'Fast and detailed radiology services.'),
(21, 1, 5, 'Exceptional patient care.'),
(22, 2, 4, 'Good service with minor delays.'),
(23, 3, 3, 'Average experience overall.'),
(24, 4, 5, 'Very gentle with children.'),
(25, 5, 4, 'Clear communication and support.'),
(26, 6, 5, 'Great results with skin treatment.'),
(27, 7, 4, 'Effective ENT procedures.'),
(28, 8, 5, 'Highly competent oncology team.'),
(29, 9, 3, 'Helpful but could be more thorough.'),
(30, 10, 4, 'Detailed reports and explanations.'),
(31, 1, 5, 'Very satisfied with the care.'),
(32, 2, 4, 'Professional but waiting time could improve.'),
(33, 3, 3, 'Treatment was average.'),
(34, 4, 5, 'Excellent pediatrician.'),
(35, 5, 4, 'Attentive and caring staff.'),
(36, 6, 5, 'Skin condition improved significantly.'),
(37, 7, 4, 'Good experience with ENT specialist.'),
(38, 8, 5, 'Oncology services were top-notch.'),
(39, 9, 3, 'Counseling was somewhat helpful.'),
(40, 10, 4, 'Radiology department was efficient.'),
(41, 1, 5, 'Very professional doctor.'),
(42, 2, 4, 'Good but room for improvement.'),
(43, 3, 3, 'Average visit, nothing special.');

-- Rooms
INSERT INTO rooms (id, room_number, type, availability) VALUES
(11, '111', 'General', TRUE),
(12, '112', 'ICU', TRUE),
(13, '113', 'Operation Theater', FALSE),
(14, '114', 'General', TRUE),
(15, '115', 'ICU', TRUE),
(16, '116', 'General', TRUE),
(17, '117', 'Operation Theater', TRUE),
(18, '118', 'General', FALSE),
(19, '119', 'ICU', TRUE),
(20, '120', 'General', TRUE),
(21, '121', 'General', FALSE),
(22, '122', 'ICU', TRUE),
(23, '123', 'Operation Theater', TRUE),
(24, '124', 'General', TRUE),
(25, '125', 'ICU', FALSE),
(26, '126', 'General', TRUE),
(27, '127', 'Operation Theater', TRUE),
(28, '128', 'General', TRUE),
(29, '129', 'ICU', TRUE),
(30, '130', 'General', TRUE),
(31, '131', 'General', TRUE),
(32, '132', 'ICU', FALSE),
(33, '133', 'Operation Theater', TRUE),
(34, '134', 'General', TRUE),
(35, '135', 'ICU', TRUE),
(36, '136', 'General', TRUE),
(37, '137', 'Operation Theater', FALSE),
(38, '138', 'General', TRUE),
(39, '139', 'ICU', TRUE),
(40, '140', 'General', TRUE),
(41, '141', 'General', TRUE),
(42, '142', 'ICU', TRUE),
(43, '143', 'Operation Theater', TRUE),
(44, '144', 'General', FALSE),
(45, '145', 'ICU', TRUE),
(46, '146', 'General', TRUE),
(47, '147', 'Operation Theater', TRUE);

-- Schedules
INSERT INTO schedules (id, doctor_id, day_of_week, start_time, end_time) VALUES
(1, 1, 'Monday', '09:00:00', '17:00:00'),
(2, 2, 'Tuesday', '10:00:00', '18:00:00'),
(3, 3, 'Wednesday', '08:00:00', '16:00:00'),
(4, 4, 'Thursday', '09:00:00', '17:00:00'),
(5, 5, 'Friday', '10:00:00', '15:00:00'),
(6, 6, 'Monday', '11:00:00', '19:00:00'),
(7, 7, 'Tuesday', '09:00:00', '17:00:00'),
(8, 8, 'Wednesday', '10:00:00', '18:00:00'),
(9, 9, 'Thursday', '08:00:00', '16:00:00'),
(10, 10, 'Friday', '09:00:00', '14:00:00');

-- Test Results
INSERT INTO test_results (id, patient_id, test_name, result, test_date) VALUES
(11, 11, 'Cancer Marker Test', 'Elevated markers detected', '2025-06-11'),
(12, 12, 'HIV Test', 'Negative', '2025-06-12'),
(13, 13, 'Thalassemia Screening', 'Positive', '2025-06-13'),
(14, 14, 'Liver Function Test', 'Slightly elevated enzymes', '2025-06-14'),
(15, 15, 'Kidney Function Test', 'Normal', '2025-06-15'),
(16, 16, 'Blood Sugar Test', 'High sugar level', '2025-06-16'),
(17, 17, 'Cancer Biopsy', 'Malignant tumor confirmed', '2025-06-17'),
(18, 18, 'Hepatitis B Test', 'Positive', '2025-06-18'),
(19, 19, 'Cholesterol Test', 'Borderline high', '2025-06-19'),
(20, 20, 'Complete Blood Count', 'Anemia detected', '2025-06-20'),
(21, 21, 'COVID-19 PCR', 'Negative', '2025-06-21'),
(22, 22, 'Thyroid Function Test', 'Hypothyroidism', '2025-06-22'),
(23, 23, 'Bone Marrow Test', 'Normal', '2025-06-23'),
(24, 24, 'Pap Smear', 'Normal', '2025-06-24'),
(25, 25, 'Allergy Test', 'Positive for pollen', '2025-06-25'),
(26, 26, 'HIV Test', 'Positive', '2025-06-26'),
(27, 27, 'Cancer Screening', 'No signs', '2025-06-27'),
(28, 28, 'Vitamin D Test', 'Deficiency detected', '2025-06-28'),
(29, 29, 'Thalassemia Screening', 'Negative', '2025-06-29'),
(30, 30, 'Ultrasound Abdomen', 'Normal', '2025-06-30'),
(31, 31, 'Hepatitis C Test', 'Negative', '2025-07-01'),
(32, 32, 'Cancer Marker Test', 'Normal', '2025-07-02'),
(33, 33, 'Blood Culture', 'No growth', '2025-07-03'),
(34, 34, 'MRI Brain', 'No abnormalities', '2025-07-04'),
(35, 35, 'CT Chest', 'Mild infection', '2025-07-05'),
(36, 36, 'Thalassemia Screening', 'Carrier detected', '2025-07-06'),
(37, 37, 'HIV Test', 'Negative', '2025-07-07'),
(38, 38, 'Cancer Biopsy', 'Benign', '2025-07-08'),
(39, 39, 'Electrolyte Test', 'Normal', '2025-07-09'),
(40, 40, 'Lipid Profile', 'High LDL cholesterol', '2025-07-10'),
(41, 41, 'Blood Gas Analysis', 'Normal', '2025-07-11'),
(42, 42, 'Hepatitis B Test', 'Negative', '2025-07-12'),
(43, 43, 'Cancer Marker Test', 'Elevated', '2025-07-13'),
(44, 44, 'Thalassemia Screening', 'Positive', '2025-07-14'),
(45, 45, 'HIV Test', 'Positive', '2025-07-15'),
(46, 46, 'Complete Blood Count', 'Leukocytosis', '2025-07-16');

-- ----------------------------------------------QURIES---------------------------------------------------

SELECT 
    *
FROM
    Patients;
SELECT 
    *
FROM
    Doctors;
SELECT 
    *
FROM
    Departments;
SELECT 
    *
FROM
    Appointments;
SELECT 
    *
FROM
    Staff;
SELECT 
    *
FROM
    Medical_records;
SELECT 
    *
FROM
    Billing;
SELECT 
    *
FROM
    Insurance_provider;
SELECT 
    *
FROM
    Prescriptions;
SELECT 
    *
FROM
    Feedback;
SELECT 
    *
FROM
    test_results;


-- List all appointments for a specific patient
SELECT 
    *
FROM
    Appointments
WHERE
    ID = 1;

-- Get all doctors working in the Cardiology department
SELECT 
    *
FROM
    Doctors
WHERE
    ID = (SELECT 
            ID
        FROM
            Departments
        WHERE
            name = 'Cardiology');

-- Count how many patients are admitted
SELECT 
    COUNT(*) AS AdmittedPatients
FROM
    Patients;

-- Get total billing amount for a patient
SELECT 
    patient_id AS Patient_ID, SUM(amount) AS Total_Bill
FROM
    Billing
GROUP BY patient_id;

-- Show patient details along with their assigned doctor
SELECT 
    P.id AS Patient_ID,
    P.name AS Patient_Name,
    D.id AS Doctor_id,
    D.Name AS Doctor_Name
FROM
    Patients P
        JOIN
    Doctors D ON P.ID = D.patient_id;


-- List feedback ratings by patient
SELECT 
    P.name, F.Rating, F.comments
FROM
    Feedback F
        JOIN
    Patients P ON F.patient_id = P.id;


-- Show all prescriptions for a patient
SELECT 
    *
FROM
    Prescriptions
WHERE
    patient_id = 17 OR patient_id = 18;


-- Find all patients with insurance coverage greater than 90%
SELECT 
    *
FROM
    Insurance_provider
WHERE
    coverage_amount > 20000;


-- Total number of doctors per department
SELECT 
    department_id, COUNT(*) AS DoctorCount
FROM
    Doctors
GROUP BY department_id;

-- List all staff members who are nurses
SELECT 
    *
FROM
    Staff
WHERE
    Role = 'Nurse';


-- Latest appointment for each patient
SELECT 
    A1.*
FROM
    Appointments A1
        JOIN
    (SELECT 
        patient_id, MAX(appointment_date) AS Latest_date
    FROM
        Appointments
    GROUP BY patient_id) A2 ON A1.patient_id = A2.patient_id
        AND A1.appointment_date = A2.Latest_date;


-- INNER JOIN: Prescriptions with patient, doctor, and medicine info
SELECT 
    p.id AS prescription_id,
    pa.name AS patient_name,
    d.name AS doctor_name,
    m.name AS medicine_name,
    p.dosage,
    p.frequency,
    p.start_date,
    p.end_date
FROM
    prescriptions p
        JOIN
    patients pa ON p.patient_id = pa.id
        JOIN
    doctors d ON p.doctor_id = d.id
        JOIN
    medicines m ON p.medicine_id = m.id;

-- LEFT JOIN: Patients and their feedback (if any)
SELECT 
    p.id, p.name, f.rating, f.comments
FROM
    patients p
        LEFT JOIN
    feedback f ON p.id = f.patient_id;

-- Nested Query: Doctors who prescribed 'Paracetamol'
SELECT DISTINCT
    d.name
FROM
    doctors d
WHERE
    d.id IN (SELECT 
            p.doctor_id
        FROM
            prescriptions p
                JOIN
            medicines m ON p.medicine_id = m.id
        WHERE
            m.name = 'Paracetamol');

-- Doctors with no appointments
SELECT 
    d.name, d.specialty
FROM
    doctors d
        LEFT JOIN
    appointments a ON d.id = a.doctor_id
WHERE
    a.id IS NULL;


-- Stored Procedure: Get appointments for a doctor between dates
DELIMITER //
CREATE PROCEDURE Get_Appointment(
    IN doc_id INT, 
    IN start_date DATE, 
    IN end_date DATE
)
BEGIN
    SELECT a.id, p.name AS patient_name, a.appointment_date, a.status
    FROM appointments a
    JOIN patients p ON a.patient_id = p.id
    WHERE a.doctor_id = doc_id 
      AND a.appointment_date BETWEEN start_date AND end_date;
END //
DELIMITER ;


CALL Get_Appointment(3, '2025-06-01', '2025-06-30');



-- Patients with more than 3 prescriptions
SELECT 
    pa.name, COUNT(p.id) AS prescription_count
FROM
    patients pa
        JOIN
    prescriptions p ON pa.id = p.patient_id
GROUP BY pa.id , pa.name
HAVING COUNT(*) > 0;


-- Patients with insurance details (including no insurance)
SELECT 
    p.name, ip.provider, ip.policy_number
FROM
    patients p
        LEFT JOIN
    patient_insurance pi ON p.id = pi.patient_id
        LEFT JOIN
    insurance_provider ip ON pi.insurance_id = ip.id;

SELECT dep.name AS department, SUM(b.amount) AS total_revenue
FROM departments dep
JOIN doctors d ON dep.id = d.department_id
JOIN appointments a ON d.id = a.doctor_id
JOIN billing b ON a.patient_id = b.patient_id
WHERE b.paid = TRUE
GROUP BY dep.id
ORDER BY total_revenue DESC;

SELECT p.name, COUNT(mr.id) AS visit_count
FROM patients p
JOIN medical_records mr ON p.id = mr.patient_id
GROUP BY p.id
HAVING visit_count > 1
ORDER BY visit_count DESC;

SELECT dep.name AS department, COUNT(a.id) AS appointment_count
FROM departments dep
JOIN doctors d ON dep.id = d.department_id
JOIN appointments a ON d.id = a.doctor_id
GROUP BY dep.id
ORDER BY appointment_count DESC;

SELECT * FROM users 
WHERE role = 'admin';

SELECT role, COUNT(*) AS count
FROM staff
GROUP BY role;

SELECT * FROM staff 
WHERE role LIKE '%admin%' OR role LIKE '%administrative%';


SELECT * FROM test_results 
WHERE result LIKE '%abnormal%' OR result LIKE '%high%' OR result LIKE '%low%';

SELECT p.name AS patient_name
FROM patients p
JOIN prescriptions pr ON p.id = pr.patient_id
JOIN medicines m ON pr.medicine_id = m.id
WHERE m.name = 'abc';

SELECT dep.name AS department, AVG(b.amount) AS avg_bill
FROM billing b
JOIN patients p ON b.patient_id = p.id
JOIN appointments a ON p.id = a.patient_id
JOIN doctors d ON a.doctor_id = d.id
JOIN departments dep ON d.department_id = dep.id
GROUP BY dep.id;

SELECT ip.provider, COUNT(pi.patient_id) AS patient_count
FROM insurance_provider ip
JOIN patient_insurance pi ON ip.id = pi.insurance_id
GROUP BY ip.id
ORDER BY patient_count DESC;

SELECT SUM(amount) AS total_outstanding 
FROM billing 
WHERE paid = FALSE;


SELECT diagnosis, COUNT(*) AS count
FROM medical_records
GROUP BY diagnosis
ORDER BY count ;