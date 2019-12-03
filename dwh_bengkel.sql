-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 03, 2019 at 08:56 AM
-- Server version: 5.7.28
-- PHP Version: 7.0.33-13+0~20191128.24+debian9~1.gbp832d85

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dwh_bengkel`
--

-- --------------------------------------------------------

--
-- Table structure for table `dim_jasa`
--

CREATE TABLE `dim_jasa` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jenis_kendaraan` varchar(255) NOT NULL,
  `harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dim_jasa`
--

INSERT INTO `dim_jasa` (`id`, `nama`, `jenis_kendaraan`, `harga`) VALUES
(1, 'Pasang lampu', 'Vario', 10000),
(2, 'Ganti ban', 'Supra', 20000),
(3, 'Ganti oli', 'Jupiter', 15000),
(4, 'Ganti kampas rem', 'Ninja', 10000),
(5, 'Ganti spion', 'Nmax', 5000),
(6, 'Pasang aki', 'Xmax', 50000),
(7, 'Ganti busi', 'Scoopy', 45000);

-- --------------------------------------------------------

--
-- Table structure for table `dim_pegawai`
--

CREATE TABLE `dim_pegawai` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `no_telepon` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `jabatan` enum('Mechanical','Operator') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dim_pegawai`
--

INSERT INTO `dim_pegawai` (`id`, `nama`, `no_telepon`, `alamat`, `jabatan`) VALUES
(1, 'Doni Ryandi', '082245467892', 'JL. Pulau Kapuk No. 12', 'Operator'),
(2, 'Amalia Siti', '0818973878221', 'JL. Pulau Morotai No. 76', 'Operator'),
(3, 'Abdul Fajar', '087890093233', 'JL. Hayam Wuruk No. 87', 'Mechanical'),
(4, 'Maya Amalia Dina', '081672548765', 'JL. Nusa Kambangan No. 99', 'Mechanical'),
(5, 'Agung Bahari Putra', '087223467892', 'Jl. Pulau Buntar No 23', 'Mechanical'),
(6, 'Kurnia Adi Indra', '0818273418111', 'Jl. Kebo Iwa No. 45', 'Mechanical'),
(7, 'Fajar Abdulah', '08927218292', 'Jl. Suli No. 99\r\n', 'Operator'),
(8, 'Deni Utama', '087621628291', 'Jl. Kudanil No. 653', 'Mechanical'),
(9, 'Bahari Santoso', '08972372822', 'Jl. Bypass Ngr Rai No. 67', 'Mechanical'),
(10, 'Guntur Treman', '08172366337', 'Jl. Sesetan No. 189', 'Mechanical'),
(11, 'Donir', '0812123434', 'Badung', 'Operator');

-- --------------------------------------------------------

--
-- Table structure for table `dim_pelanggan`
--

CREATE TABLE `dim_pelanggan` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `no_telepon` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `kota` varchar(255) NOT NULL DEFAULT 'Denpasar'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dim_pelanggan`
--

INSERT INTO `dim_pelanggan` (`id`, `nama`, `no_telepon`, `alamat`, `kota`) VALUES
(1, 'Made Adhi', '087232418842', 'Jl. WR. Supratman No 3', 'Denpasar'),
(2, 'Pratiwi Ashari', '081252415542', 'Jl. Sudirman No 4', 'Denpasar'),
(3, 'Pradnyani Wulantari', '0852326878342', 'Jl. Kamboja No 5', 'Denpasar'),
(4, 'Kadek Sastrawan', '089983923922', 'Jl. Jepun No 6', 'Denpasar'),
(5, 'Adi Wira', '087675248412', 'Jl. Ahmad Yani No 7', 'Denpasar'),
(6, 'Ratna', '08153521546634', 'Jl. Jempiring No 8', 'Denpasar'),
(7, 'Dhani Prasetya', '082245467892', 'Jl. Gatot Subroto No 412', 'Denpasar'),
(8, 'Naomi Sudana', '0878973878111', 'Jl. Kamboja No 123', 'Denpasar'),
(9, 'Dede Hadi', '081249561111', 'Jl. Hayam Wuruk No 61', 'Denpasar'),
(10, 'Rafi Rudika', '081672548765', 'Jl. Ahmad Yani No 74', 'Denpasar'),
(11, 'Rahmawati Kususma', '089364728291', 'Jl. Nuansa Indah No. 99\r\n', 'Denpasar'),
(12, 'Bayu Fajar Setiabudi', '08936272839', 'Jl. Hangtuah No. 87\r\n', 'Denpasar'),
(13, 'Diah Intan', '08123754983', 'Jl. Sumatra No. 55', 'Denpasar'),
(14, 'Widya Agustina', '08762527288', 'Jl. Sulawesi No. 98', 'Denpasar'),
(15, 'Fitri Retno Utami', '08563728392', 'Jl. Sumatra No. 88', 'Denpasar'),
(16, 'Devi Lestari', '08912343219', 'Jl. Wijaya Kusuma No. 87', 'Denpasar'),
(17, 'Retno Agustino', '0823457819', 'Jl. Hayam Wuruk No. 72', 'Denpasar'),
(18, 'Made Arta', '08238576192', 'Jl. Budiman No. 123', 'Denpasar'),
(19, 'Eko Aditya Kurnia', '089726281819', 'Jl. WR. Supratman No. 534', 'Denpasar'),
(20, 'Putra Arif Pratama', '08765277272', 'Jl. Sakura No. 111', 'Denpasar'),
(21, 'Aditya Yudistira', '091021920182', 'Jl. Sading Mengwi', 'Denpasar');

-- --------------------------------------------------------

--
-- Table structure for table `dim_sparepart`
--

CREATE TABLE `dim_sparepart` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jenis_kendaraan` varchar(255) NOT NULL,
  `harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dim_sparepart`
--

INSERT INTO `dim_sparepart` (`id`, `nama`, `jenis_kendaraan`, `harga`) VALUES
(1, 'Busi', 'Suku Cadang', 150000),
(2, 'Aki', 'Suku Cadang', 300000),
(3, 'Karburator', 'Suku Cadang', 230000),
(4, 'Ban', 'Suku Cadang', 175000),
(5, 'Lampu', 'Suku Cadang', 12000),
(6, 'Tali Gas', 'Suku Cadang', 45000),
(7, 'Rantai', 'Suku Cadang', 50000),
(8, 'Knalpot', 'Suku Cadang', 350000),
(9, 'Spion', 'Suku Cadang', 35000),
(10, 'Kampas Rem', 'Suku Cadang', 55000),
(11, 'Oli', 'Suku Cadang', 40000),
(12, 'Minyak Rem', 'Suku Cadang', 50000);

-- --------------------------------------------------------

--
-- Table structure for table `dim_supplier`
--

CREATE TABLE `dim_supplier` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `no_telepon` varchar(255) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dim_supplier`
--

INSERT INTO `dim_supplier` (`id`, `nama`, `no_telepon`, `alamat`) VALUES
(1, 'Puji Utama', '80976328239239', 'Jl. Gurita Besaar No. 67'),
(2, 'Setiawan Budi Utama', '085176326732', 'JL. Seruni No. 55'),
(3, 'Deni Putra Budi', '089726475823', 'JL. Hangtuah No. 45'),
(4, 'Muhamad Zainudin ', '08123454378', 'JL. Cok Agung Tresna No. 76'),
(5, 'Agus Dwi Wahyu ', '089763748392', 'JL. Trenggana No. 524'),
(6, 'Mekar Abadi Jaya', '0827372372', 'Jl. Hayam Wuruk No 33');

-- --------------------------------------------------------

--
-- Table structure for table `extraction_history`
--

CREATE TABLE `extraction_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `extraction_type` enum('Facts','Dimensions') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `extraction_history`
--

INSERT INTO `extraction_history` (`id`, `extraction_type`, `created_at`) VALUES
(2, 'Dimensions', '2019-12-02 13:54:48'),
(4, 'Dimensions', '2019-12-02 15:05:52'),
(6, 'Facts', '2019-12-02 13:54:48');

-- --------------------------------------------------------

--
-- Table structure for table `fact_pembelian_sparepart`
--

CREATE TABLE `fact_pembelian_sparepart` (
  `id_supplier` int(11) DEFAULT NULL,
  `id_operator` int(11) DEFAULT NULL,
  `id_sparepart` int(11) DEFAULT NULL,
  `id_waktu` int(11) DEFAULT NULL,
  `jumlah` tinyint(4) NOT NULL,
  `total_harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fact_penjualan_jasa`
--

CREATE TABLE `fact_penjualan_jasa` (
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_mekanik` int(11) DEFAULT NULL,
  `id_operator` int(11) DEFAULT NULL,
  `id_jasa` int(11) DEFAULT NULL,
  `id_waktu` int(11) NOT NULL,
  `total_harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fact_penjualan_sparepart`
--

CREATE TABLE `fact_penjualan_sparepart` (
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_mekanik` int(11) DEFAULT NULL,
  `id_operator` int(11) DEFAULT NULL,
  `id_sparepart` int(11) DEFAULT NULL,
  `tanggal` date NOT NULL,
  `jumlah` tinyint(4) NOT NULL,
  `total_harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fact_penjualan_sparepart`
--

INSERT INTO `fact_penjualan_sparepart` (`id_pelanggan`, `id_mekanik`, `id_operator`, `id_sparepart`, `tanggal`, `jumlah`, `total_harga`) VALUES
(1, 3, 1, 5, '2018-10-08', 1, 12000),
(1, 3, 1, 2, '2018-10-08', 1, 300000),
(3, 3, 1, 5, '2018-10-10', 1, 12000),
(2, 3, 1, 6, '2018-10-09', 1, 45000),
(4, 4, 2, 11, '2018-10-11', 2, 80000),
(5, 4, 2, 11, '2018-10-12', 3, 120000),
(7, 4, 2, 5, '2018-10-15', 1, 12000),
(8, 5, 1, 1, '2018-10-16', 1, 150000),
(6, 4, 2, 4, '2018-10-13', 1, 175000),
(9, 5, 1, 9, '2018-10-17', 2, 70000),
(10, 6, 1, 9, '2018-10-18', 2, 70000),
(2, 6, 1, 1, '2018-11-09', 1, 150000),
(3, 3, 2, 3, '2018-11-10', 2, 460000),
(4, 3, 2, 3, '2018-11-10', 3, 690000),
(5, 3, 2, 1, '2018-11-12', 3, 450000),
(6, 6, 1, 3, '2018-11-13', 3, 690000),
(6, 6, 1, 6, '2018-11-13', 5, 225000),
(7, 6, 2, 2, '2018-11-14', 2, 600000),
(8, 5, 1, 2, '2018-11-15', 1, 300000),
(6, 6, 1, 2, '2018-11-13', 3, 900000),
(7, 6, 2, 2, '2018-11-14', 3, 900000),
(8, 5, 1, 2, '2018-11-15', 1, 300000),
(9, 5, 1, 3, '2018-11-15', 3, 690000),
(10, 5, 1, 3, '2018-11-16', 1, 230000),
(8, 4, 2, 1, '2018-11-19', 2, 300000),
(11, 3, 1, 8, '2018-11-19', 3, 1050000),
(12, 3, 1, 9, '2018-11-19', 3, 105000),
(13, 3, 1, 6, '2018-11-20', 1, 45000),
(14, 3, 2, 10, '2018-11-20', 3, 165000),
(15, 6, 2, 3, '2018-11-20', 1, 230000),
(16, 4, 2, 1, '2018-11-21', 1, 150000),
(17, 4, 2, 1, '2018-11-21', 1, 150000),
(18, 4, 1, 1, '2018-11-21', 1, 150000),
(19, 5, 1, 2, '2018-11-22', 2, 600000),
(20, 5, 1, 2, '2018-11-23', 2, 600000),
(2, 5, 2, 7, '2018-11-26', 2, 100000),
(2, 3, 1, 2, '2018-11-27', 1, 300000),
(4, 4, 1, 7, '2018-11-28', 8, 400000),
(5, 4, 2, 2, '2018-11-28', 1, 300000),
(7, 4, 1, 1, '2018-11-29', 1, 150000),
(8, 3, 1, 2, '2018-11-30', 2, 600000),
(10, 3, 2, 1, '2018-12-01', 5, 750000),
(11, 4, 1, 1, '2018-12-03', 8, 1200000),
(13, 5, 2, 1, '2018-12-04', 2, 300000),
(11, 5, 2, 1, '2018-12-07', 3, 450000),
(12, 8, 7, 11, '2018-12-08', 2, 80000),
(14, 8, 7, 11, '2018-12-08', 2, 80000),
(15, 8, 7, 11, '2018-12-10', 5, 200000),
(3, 8, 2, 1, '2018-12-10', 2, 30000),
(16, 9, 2, 6, '2018-12-10', 3, 135000),
(6, 9, 2, 1, '2018-12-11', 1, 150000),
(18, 10, 2, 3, '2018-12-11', 3, 690000),
(19, 10, 1, 7, '2018-12-12', 6, 300000),
(9, 10, 1, 6, '2018-12-12', 5, 225000),
(20, 5, 1, 2, '2018-12-12', 1, 300000),
(10, 3, 2, 2, '2018-12-21', 4, 1200000),
(10, 3, 2, 2, '2018-12-21', 4, 1200000);

-- --------------------------------------------------------

--
-- Table structure for table `fact_penjualan_sparepart_bulanan`
--

CREATE TABLE `fact_penjualan_sparepart_bulanan` (
  `id_pelanggan` int(10) UNSIGNED DEFAULT NULL,
  `id_mekanik` int(10) UNSIGNED DEFAULT NULL,
  `id_operator` int(10) UNSIGNED DEFAULT NULL,
  `id_sparepart` int(10) UNSIGNED NOT NULL,
  `bulan` enum('January','February','March','April','May','June','July','Augustus','September','October','November','December') NOT NULL,
  `tahun` year(4) NOT NULL,
  `jumlah` tinyint(4) NOT NULL,
  `total_harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fact_penjualan_sparepart_bulanan`
--

INSERT INTO `fact_penjualan_sparepart_bulanan` (`id_pelanggan`, `id_mekanik`, `id_operator`, `id_sparepart`, `bulan`, `tahun`, `jumlah`, `total_harga`) VALUES
(1, 3, 1, 2, 'October', 2018, 1, 300000),
(1, 3, 1, 5, 'October', 2018, 1, 12000),
(2, 3, 1, 2, 'November', 2018, 1, 300000),
(2, 3, 1, 6, 'October', 2018, 1, 45000),
(3, 3, 1, 5, 'October', 2018, 1, 12000),
(8, 3, 1, 2, 'November', 2018, 2, 600000),
(11, 3, 1, 8, 'November', 2018, 3, 1050000),
(12, 3, 1, 9, 'November', 2018, 3, 105000),
(13, 3, 1, 6, 'November', 2018, 1, 45000),
(3, 3, 2, 3, 'November', 2018, 2, 460000),
(4, 3, 2, 3, 'November', 2018, 3, 690000),
(5, 3, 2, 1, 'November', 2018, 3, 450000),
(10, 3, 2, 1, 'December', 2018, 5, 750000),
(10, 3, 2, 2, 'December', 2018, 8, 2400000),
(14, 3, 2, 10, 'November', 2018, 3, 165000),
(4, 4, 1, 7, 'November', 2018, 8, 400000),
(7, 4, 1, 1, 'November', 2018, 1, 150000),
(11, 4, 1, 1, 'December', 2018, 8, 1200000),
(18, 4, 1, 1, 'November', 2018, 1, 150000),
(4, 4, 2, 11, 'October', 2018, 2, 80000),
(5, 4, 2, 2, 'November', 2018, 1, 300000),
(5, 4, 2, 11, 'October', 2018, 3, 120000),
(6, 4, 2, 4, 'October', 2018, 1, 175000),
(7, 4, 2, 5, 'October', 2018, 1, 12000),
(8, 4, 2, 1, 'November', 2018, 2, 300000),
(16, 4, 2, 1, 'November', 2018, 1, 150000),
(17, 4, 2, 1, 'November', 2018, 1, 150000),
(8, 5, 1, 1, 'October', 2018, 1, 150000),
(8, 5, 1, 2, 'November', 2018, 2, 600000),
(9, 5, 1, 3, 'November', 2018, 3, 690000),
(9, 5, 1, 9, 'October', 2018, 2, 70000),
(10, 5, 1, 3, 'November', 2018, 1, 230000),
(19, 5, 1, 2, 'November', 2018, 2, 600000),
(20, 5, 1, 2, 'December', 2018, 1, 300000),
(20, 5, 1, 2, 'November', 2018, 2, 600000),
(2, 5, 2, 7, 'November', 2018, 2, 100000),
(11, 5, 2, 1, 'December', 2018, 3, 450000),
(13, 5, 2, 1, 'December', 2018, 2, 300000),
(2, 6, 1, 1, 'November', 2018, 1, 150000),
(6, 6, 1, 2, 'November', 2018, 3, 900000),
(6, 6, 1, 3, 'November', 2018, 3, 690000),
(6, 6, 1, 6, 'November', 2018, 5, 225000),
(10, 6, 1, 9, 'October', 2018, 2, 70000),
(7, 6, 2, 2, 'November', 2018, 5, 1500000),
(15, 6, 2, 3, 'November', 2018, 1, 230000),
(3, 8, 2, 1, 'December', 2018, 2, 30000),
(12, 8, 7, 11, 'December', 2018, 2, 80000),
(14, 8, 7, 11, 'December', 2018, 2, 80000),
(15, 8, 7, 11, 'December', 2018, 5, 200000),
(6, 9, 2, 1, 'December', 2018, 1, 150000),
(16, 9, 2, 6, 'December', 2018, 3, 135000),
(9, 10, 1, 6, 'December', 2018, 5, 225000),
(19, 10, 1, 7, 'December', 2018, 6, 300000),
(18, 10, 2, 3, 'December', 2018, 3, 690000);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dim_jasa`
--
ALTER TABLE `dim_jasa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dim_pegawai`
--
ALTER TABLE `dim_pegawai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dim_pelanggan`
--
ALTER TABLE `dim_pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dim_sparepart`
--
ALTER TABLE `dim_sparepart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dim_supplier`
--
ALTER TABLE `dim_supplier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extraction_history`
--
ALTER TABLE `extraction_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fact_pembelian_sparepart`
--
ALTER TABLE `fact_pembelian_sparepart`
  ADD KEY `id_supplier` (`id_supplier`),
  ADD KEY `id_operator` (`id_operator`),
  ADD KEY `id_sparepart` (`id_sparepart`),
  ADD KEY `id_tanggal` (`id_waktu`);

--
-- Indexes for table `fact_penjualan_jasa`
--
ALTER TABLE `fact_penjualan_jasa`
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_mekanik` (`id_mekanik`),
  ADD KEY `id_operator` (`id_operator`),
  ADD KEY `id_jasa` (`id_jasa`),
  ADD KEY `id_tanggal` (`id_waktu`);

--
-- Indexes for table `fact_penjualan_sparepart`
--
ALTER TABLE `fact_penjualan_sparepart`
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_mekanik` (`id_mekanik`),
  ADD KEY `id_operator` (`id_operator`),
  ADD KEY `id_sparepart` (`id_sparepart`),
  ADD KEY `id_tanggal` (`tanggal`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dim_jasa`
--
ALTER TABLE `dim_jasa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `dim_pegawai`
--
ALTER TABLE `dim_pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `dim_pelanggan`
--
ALTER TABLE `dim_pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `dim_sparepart`
--
ALTER TABLE `dim_sparepart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `dim_supplier`
--
ALTER TABLE `dim_supplier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `extraction_history`
--
ALTER TABLE `extraction_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `fact_pembelian_sparepart`
--
ALTER TABLE `fact_pembelian_sparepart`
  ADD CONSTRAINT `fact_pembelian_sparepart_ibfk_1` FOREIGN KEY (`id_supplier`) REFERENCES `dim_supplier` (`id`),
  ADD CONSTRAINT `fact_pembelian_sparepart_ibfk_2` FOREIGN KEY (`id_operator`) REFERENCES `dim_pegawai` (`id`),
  ADD CONSTRAINT `fact_pembelian_sparepart_ibfk_3` FOREIGN KEY (`id_sparepart`) REFERENCES `dim_sparepart` (`id`);

--
-- Constraints for table `fact_penjualan_jasa`
--
ALTER TABLE `fact_penjualan_jasa`
  ADD CONSTRAINT `fact_penjualan_jasa_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `dim_pelanggan` (`id`),
  ADD CONSTRAINT `fact_penjualan_jasa_ibfk_2` FOREIGN KEY (`id_mekanik`) REFERENCES `dim_pegawai` (`id`),
  ADD CONSTRAINT `fact_penjualan_jasa_ibfk_3` FOREIGN KEY (`id_operator`) REFERENCES `dim_pegawai` (`id`),
  ADD CONSTRAINT `fact_penjualan_jasa_ibfk_4` FOREIGN KEY (`id_jasa`) REFERENCES `dim_jasa` (`id`);

--
-- Constraints for table `fact_penjualan_sparepart`
--
ALTER TABLE `fact_penjualan_sparepart`
  ADD CONSTRAINT `fact_penjualan_sparepart_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `dim_pelanggan` (`id`),
  ADD CONSTRAINT `fact_penjualan_sparepart_ibfk_2` FOREIGN KEY (`id_mekanik`) REFERENCES `dim_pegawai` (`id`),
  ADD CONSTRAINT `fact_penjualan_sparepart_ibfk_3` FOREIGN KEY (`id_operator`) REFERENCES `dim_pegawai` (`id`),
  ADD CONSTRAINT `fact_penjualan_sparepart_ibfk_4` FOREIGN KEY (`id_sparepart`) REFERENCES `dim_sparepart` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
