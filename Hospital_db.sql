-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2025 at 10:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `healthcare_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `PayBill` (IN `bid` INT)   BEGIN
    UPDATE Bills
    SET status = 'Paid'
    WHERE bill_id = bid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `patient_id`, `doctor_id`, `appointment_date`, `reason`, `status`) VALUES
(1, 1, 1, '2025-07-09', 'Routine Checkup', 'Scheduled'),
(2, 2, 2, '2025-07-09', 'Headache and dizziness', 'Scheduled'),
(3, 3, 3, '2025-07-09', 'Fever and cold', 'Completed'),
(4, 4, 1, '2025-07-09', 'Chest Pain', 'Completed'),
(5, 5, 4, '2025-07-09', 'Child Vaccination', 'Scheduled');

--
-- Triggers `appointments`
--
DELIMITER $$
CREATE TRIGGER `bill_after_appointment` AFTER INSERT ON `appointments` FOR EACH ROW BEGIN
    INSERT INTO Bills (patient_id, bill_date, amount, status)
    VALUES (NEW.patient_id, CURDATE(), 500.00, 'Unpaid');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `bill_id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `bill_date` date DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`bill_id`, `patient_id`, `bill_date`, `amount`, `status`) VALUES
(1, 1, '2025-07-09', 500.00, 'Unpaid'),
(2, 2, '2025-07-09', 800.00, 'Paid'),
(3, 3, '2025-07-09', 300.00, 'Paid'),
(4, 4, '2025-07-09', 700.00, 'Unpaid'),
(5, 5, '2025-07-09', 450.00, 'Paid');

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `hire_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`doctor_id`, `name`, `specialization`, `phone`, `email`, `hire_date`) VALUES
(1, 'Dr. Mehta', 'Cardiologist', '9811122233', 'mehta@example.com', '2025-07-09'),
(2, 'Dr. Rao', 'Neurologist', '9822233445', 'rao@example.com', '2025-07-09'),
(3, 'Dr. Khan', 'General Physician', '9833344556', 'khan@example.com', '2025-07-09'),
(4, 'Dr. Roy', 'Pediatrician', '9844455667', 'roy@example.com', '2025-07-09');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `registration_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `name`, `dob`, `gender`, `phone`, `address`, `registration_date`) VALUES
(1, 'Anita Desai', '1990-05-21', 'Female', '9123456789', 'Delhi, India', '2025-07-09'),
(2, 'Ravi Verma', '1985-10-02', 'Male', '9876543210', 'Mumbai, India', '2025-07-09'),
(3, 'Neha Sharma', '1992-12-15', 'Female', '9988776655', 'Bangalore, India', '2025-07-09'),
(4, 'Amit Kumar', '1978-07-08', 'Male', '9112233445', 'Hyderabad, India', '2025-07-09'),
(5, 'Pooja Reddy', '1988-03-19', 'Female', '9001122334', 'Chennai, India', '2025-07-09');

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `prescription_id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `medication` text DEFAULT NULL,
  `dosage` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `issue_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`prescription_id`, `appointment_id`, `medication`, `dosage`, `notes`, `issue_date`) VALUES
(1, 3, 'Paracetamol', '500mg twice a day', 'Drink plenty of fluids', '2025-07-09'),
(2, 4, 'Aspirin', '75mg daily', 'Avoid oily food', '2025-07-09');

-- --------------------------------------------------------

--
-- Stand-in structure for view `upcoming_appointments`
-- (See below for the actual view)
--
CREATE TABLE `upcoming_appointments` (
`appointment_id` int(11)
,`patient_name` varchar(100)
,`doctor_name` varchar(100)
,`appointment_date` date
,`status` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure for view `upcoming_appointments`
--
DROP TABLE IF EXISTS `upcoming_appointments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `upcoming_appointments`  AS SELECT `a`.`appointment_id` AS `appointment_id`, `p`.`name` AS `patient_name`, `d`.`name` AS `doctor_name`, `a`.`appointment_date` AS `appointment_date`, `a`.`status` AS `status` FROM ((`appointments` `a` join `patients` `p` on(`a`.`patient_id` = `p`.`patient_id`)) join `doctors` `d` on(`a`.`doctor_id` = `d`.`doctor_id`)) WHERE `a`.`status` = 'Scheduled' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`bill_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctor_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`prescription_id`),
  ADD KEY `appointment_id` (`appointment_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `prescription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`);

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`);

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
