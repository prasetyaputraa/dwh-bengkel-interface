-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 19, 2019 at 04:54 AM
-- Server version: 5.7.28
-- PHP Version: 7.0.33-11+0~20190923.20+debian9~1.gbpd05c7e

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
  `jenis_kendaraan` enum('Motor','Mobil') NOT NULL,
  `harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dim_pegawai`
--

CREATE TABLE `dim_pegawai` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `no_telepon` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `jabatan` enum('Mekanik','Operator') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dim_pelanggan`
--

CREATE TABLE `dim_pelanggan` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `no_telepon` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `kota` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dim_sparepart`
--

CREATE TABLE `dim_sparepart` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jenis_kendaraan` enum('Motor','Mobil') NOT NULL,
  `harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

-- --------------------------------------------------------

--
-- Table structure for table `dim_waktu`
--

CREATE TABLE `dim_waktu` (
  `id` int(11) UNSIGNED NOT NULL,
  `mulai` date NOT NULL,
  `akhir` date NOT NULL,
  `periode` enum('Hari','Minggu','Bulan','Kuartal','Tahun') NOT NULL,
  `keterangan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `id_waktu` int(11) NOT NULL,
  `jumlah` tinyint(4) NOT NULL,
  `total_harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Indexes for table `dim_waktu`
--
ALTER TABLE `dim_waktu`
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
  ADD KEY `id_tanggal` (`id_waktu`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dim_jasa`
--
ALTER TABLE `dim_jasa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `dim_pegawai`
--
ALTER TABLE `dim_pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `dim_pelanggan`
--
ALTER TABLE `dim_pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;
--
-- AUTO_INCREMENT for table `dim_sparepart`
--
ALTER TABLE `dim_sparepart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `dim_supplier`
--
ALTER TABLE `dim_supplier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;
--
-- AUTO_INCREMENT for table `dim_waktu`
--
ALTER TABLE `dim_waktu`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
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
