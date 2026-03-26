-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2026 at 09:46 AM
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
-- Database: `localfoodies`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `address_line` text NOT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pincode` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `label`, `address_line`, `landmark`, `city`, `latitude`, `longitude`, `area`, `state`, `pincode`, `created_at`, `updated_at`) VALUES
(1, 21, 'Home', 'Poongavanapuram, Tamil Nadu', '', 'Tiruvallur', 13.0827, 80.2707, 'Kuttambakkam', 'Tamil Nadu', '600124', '2026-03-20 05:52:31', '2026-03-20 05:52:31'),
(2, 21, 'Current Selection', 'Kuthambakkam, Tamil Nadu', NULL, 'Tamil Nadu', 13.0283, 80.0158, NULL, NULL, '000000', '2026-03-23 07:41:50', '2026-03-23 07:41:50'),
(3, 21, 'Current Selection', 'Chembarambakkam, Tamil Nadu', NULL, 'Tamil Nadu', 13.0369, 80.039, NULL, NULL, '000000', '2026-03-23 08:00:20', '2026-03-23 08:00:20'),
(4, 21, 'Current Selection', 'Poongavanapuram, Tamil Nadu', NULL, 'Tamil Nadu', 13.0827, 80.2707, NULL, NULL, '000000', '2026-03-23 09:10:43', '2026-03-23 09:10:43'),
(5, 21, 'Current Selection', 'Kuthambakkam, Tamil Nadu', NULL, 'Tamil Nadu', 13.0282, 80.0158, NULL, NULL, '000000', '2026-03-23 09:11:16', '2026-03-23 09:11:16'),
(6, 27, 'Home', 'santrocity', 'siddu', 'Tiruvallur', NULL, NULL, 'Kuttambakkam', 'Tamil Nadu', '600124', '2026-03-23 15:15:20', '2026-03-23 15:15:20'),
(7, 27, 'Home', 'santrocity', 'ganesh shop', 'Tiruvallur', NULL, NULL, 'Kuttambakkam', 'Tamil Nadu', '600124', '2026-03-24 02:47:15', '2026-03-24 02:47:15'),
(8, 27, 'Home', 'badvel', '', 'Tiruvallur', NULL, NULL, 'Kuttambakkam', 'Tamil Nadu', '600124', '2026-03-24 08:07:30', '2026-03-24 08:07:30'),
(9, 30, 'Current Selection', 'Kuthambakkam, Tamil Nadu', NULL, 'Tamil Nadu', 13.0266, 80.016, NULL, NULL, '000000', '2026-03-25 04:08:01', '2026-03-25 04:08:01'),
(10, 30, 'Current Selection', 'Kuthambakkam, Tamil Nadu', NULL, 'Tamil Nadu', 13.0265, 80.016, NULL, NULL, '000000', '2026-03-25 04:11:19', '2026-03-25 04:11:19'),
(11, 27, 'Current Selection', 'Kuthambakkam, Tamil Nadu', NULL, 'Tamil Nadu', 13.0283, 80.0159, NULL, NULL, '000000', '2026-03-25 05:04:17', '2026-03-25 05:04:17'),
(12, 27, 'Home', 'santrocity', '', 'Tiruvallur', NULL, NULL, 'Kuttambakkam', 'Tamil Nadu', '600124', '2026-03-25 05:04:42', '2026-03-25 05:04:42'),
(13, 27, 'Current Selection', 'Chennai, Tamil Nadu', NULL, 'Tamil Nadu', 13.0547, 80.0604, NULL, NULL, '000000', '2026-03-25 16:45:13', '2026-03-25 16:45:13'),
(14, 27, 'Work', 'badvel', '', 'Tiruvallur', NULL, NULL, 'Malayambakkam', 'Tamil Nadu', '600123', '2026-03-25 16:58:46', '2026-03-25 16:58:46'),
(15, 27, 'Current Selection', 'Chembarambakkam, Tamil Nadu', NULL, 'Tamil Nadu', 13.0438, 80.0524, NULL, NULL, '000000', '2026-03-25 16:59:26', '2026-03-25 16:59:26');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 27, '2026-03-24 14:58:36', '2026-03-25 15:22:30'),
(2, 30, '2026-03-25 03:56:41', '2026-03-25 03:56:41');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `dish_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` float NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chefs`
--

CREATE TABLE `chefs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `rating` float DEFAULT NULL,
  `cuisines` varchar(255) DEFAULT NULL,
  `delivery_time` varchar(50) DEFAULT NULL,
  `is_online` tinyint(1) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `kitchen_name` varchar(100) DEFAULT NULL,
  `experience` varchar(50) DEFAULT NULL,
  `daily_meals` varchar(50) DEFAULT NULL,
  `cuisine_type` varchar(100) DEFAULT NULL,
  `food_category` varchar(100) DEFAULT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'chef',
  `status` enum('online','offline') DEFAULT 'offline',
  `area` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `pricing` float DEFAULT 0,
  `availability` text DEFAULT NULL,
  `service_radius` float DEFAULT 5,
  `opening_time` varchar(10) DEFAULT NULL,
  `closing_time` varchar(10) DEFAULT NULL,
  `specialities` text DEFAULT NULL,
  `fssai_number` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chefs`
--

INSERT INTO `chefs` (`id`, `user_id`, `name`, `rating`, `cuisines`, `delivery_time`, `is_online`, `image_url`, `latitude`, `longitude`, `address`, `bio`, `kitchen_name`, `experience`, `daily_meals`, `cuisine_type`, `food_category`, `full_name`, `email`, `phone`, `password`, `role`, `status`, `area`, `city`, `state`, `pincode`, `pricing`, `availability`, `service_radius`, `opening_time`, `closing_time`, `specialities`, `fssai_number`) VALUES
(1, 5, 'Maria\'s Home Kitchen', 4.8, 'South Indian, Home Style', '30-45 min', 1, 'https://images.unsplash.com/photo-1556910103-1c02745aae4d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'chef1@example.com', '00000001', 'hashed_dummy_password', 'chef', 'offline', NULL, NULL, NULL, NULL, 0, NULL, 5, NULL, NULL, NULL, NULL),
(2, 4, 'Rahul\'s Punjabi Rasoi', 4.7, 'North Indian, Punjabi', '40-50 min', 1, 'https://images.unsplash.com/photo-1585937421612-70a008356fbe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'chef2@example.com', '00000002', 'hashed_dummy_password', 'chef', 'offline', NULL, NULL, NULL, NULL, 0, NULL, 5, NULL, NULL, NULL, NULL),
(3, 10, 'Li\'s Dragon Wok', 4.6, 'Chinese, Thai', '25-35 min', 1, 'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'chef3@example.com', '00000003', 'hashed_dummy_password', 'chef', 'offline', NULL, NULL, NULL, NULL, 0, NULL, 5, NULL, NULL, NULL, NULL),
(4, 11, 'Sofia\'s Dessert Studio', 4.9, 'Cakes, Pastries, Desserts', '20-30 min', 1, 'https://images.unsplash.com/photo-1488477181946-6428a0291777', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'chef4@example.com', '00000004', 'hashed_dummy_password', 'chef', 'offline', NULL, NULL, NULL, NULL, 0, NULL, 5, NULL, NULL, NULL, NULL),
(6, 7, 'mariyam\'s kitchen', 0, NULL, NULL, 1, 'http://10.164.109.239:8000/uploads/20260301150844_upload_image_1772357924009.jpg', 12.9716, 77.5946, '1-99, Chettipedu , Chennai  - 600123', NULL, 'mariyam\'s kitchen', '0', '1', 'South Indian', 'Both', '', 'chef6@example.com', '00000006', 'hashed_dummy_password', 'chef', 'offline', NULL, NULL, NULL, NULL, 0, NULL, 5, NULL, NULL, NULL, NULL),
(8, NULL, 'panda\'s', 0, NULL, NULL, 1, 'http://10.164.109.239:8000/uploads/20260301220907_upload_image_1772383148334.jpg', 12.9716, 77.5946, '1-67, Chembberambakam, Chennai  - 600124', NULL, 'panda\'s', '0', '1', 'South Indian', 'Veg', 'Yaswanth', 'yaswanthchanda60@gmail.com', '9177506887', '1234567', 'chef', 'online', NULL, NULL, NULL, NULL, 0, NULL, 5, NULL, NULL, NULL, NULL),
(9, NULL, 'chaloo Hyderabadi', 4, NULL, NULL, 1, 'http://10.164.109.239:8000/uploads/20260302092356_upload_image_1772423635009.jpg', 12.9716, 77.5946, 'siddavatam main road , badvel, kadapa - 516227', NULL, 'chaloo Hyderabadi', '10', '50', 'Homemade Meals', 'Both', 'chaloo Hyderabadi', 'punaganiravi@gmail.com', '9866887994', '......', 'chef', 'online', 'santrocity', NULL, NULL, NULL, 0, NULL, 5, '11:16', '15:16', NULL, '1999383');

-- --------------------------------------------------------

--
-- Table structure for table `dishes`
--

CREATE TABLE `dishes` (
  `id` int(11) NOT NULL,
  `chef_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `price` float NOT NULL,
  `rating` float DEFAULT NULL,
  `is_veg` tinyint(1) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `cuisine` varchar(50) DEFAULT NULL,
  `food_type` varchar(50) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `prep_time` varchar(20) DEFAULT '15m'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dishes`
--

INSERT INTO `dishes` (`id`, `chef_id`, `name`, `price`, `rating`, `is_veg`, `category`, `image_url`, `tag`, `description`, `cuisine`, `food_type`, `is_available`, `prep_time`) VALUES
(1, 1, 'Masala Dosa', 60, 4.9, 1, 'Breakfast', 'https://images.unsplash.com/photo-1589302168068-964664d93dc0', 'Best Seller', NULL, NULL, NULL, 1, '15m'),
(2, 1, 'Idli Sambhar', 40, 4.7, 1, 'Breakfast', 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc', NULL, NULL, NULL, NULL, 1, '15m'),
(3, 1, 'Pongal', 50, 4.6, 1, 'Breakfast', 'https://images.unsplash.com/photo-1610192244261-3f33de3f55e4', NULL, NULL, NULL, NULL, 1, '15m'),
(4, 1, 'Home Style Meals', 120, 4.9, 1, 'Lunch', 'https://images.unsplash.com/photo-1546833999-b9f581a1996d', NULL, NULL, NULL, NULL, 1, '15m'),
(5, 1, 'Filter Coffee', 25, 4.8, 1, 'Beverages', 'https://images.unsplash.com/photo-1544787210-2213d84ad96b', 'Fresh', NULL, NULL, NULL, 1, '15m'),
(6, 1, 'Payasam', 45, 4.7, 1, 'Dessert', 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4', NULL, NULL, NULL, NULL, 1, '15m'),
(7, 2, 'Butter Chicken', 250, 4.9, 0, 'Main Course', 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398', 'Must Try', NULL, NULL, NULL, 1, '15m'),
(8, 2, 'Paneer Butter Masala', 180, 4.8, 1, 'Main Course', 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7', 'Creamy', NULL, NULL, NULL, 1, '15m'),
(9, 2, 'Dal Makhani', 160, 4.7, 1, 'Main Course', 'https://images.unsplash.com/photo-1546833999-b9f581a1996d', NULL, NULL, NULL, NULL, 1, '15m'),
(10, 2, 'Garlic Naan', 40, 4.6, 1, 'Bread', 'https://images.unsplash.com/photo-1601050690597-df0568f70950', NULL, NULL, NULL, NULL, 1, '15m'),
(11, 2, 'Lassi', 50, 4.8, 1, 'Beverages', 'https://images.unsplash.com/photo-1550583760-705990264b38', 'Chilled', NULL, NULL, NULL, 1, '15m'),
(12, 3, 'Veg Manchurian', 140, 4.5, 1, 'Starters', 'https://images.unsplash.com/photo-1512058564366-18510be2db19', NULL, NULL, NULL, NULL, 1, '15m'),
(13, 3, 'Chicken Hakka Noodles', 160, 4.7, 0, 'Main Course', 'https://images.unsplash.com/photo-1585032226651-759b368d7246', 'Sizzling', NULL, NULL, NULL, 1, '15m'),
(14, 3, 'Schezwan Fried Rice', 150, 4.6, 1, 'Main Course', 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec', 'Spicy', NULL, NULL, NULL, 1, '15m'),
(15, 3, 'Spring Rolls', 100, 4.4, 1, 'Starters', 'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf', 'Crunchy', NULL, NULL, NULL, 1, '15m'),
(16, 4, 'Chocolate Lava Cake', 120, 5, 1, 'Dessert', 'https://images.unsplash.com/photo-1624353365286-3f8d62daad51', 'Heavenly', NULL, NULL, NULL, 1, '15m'),
(17, 4, 'Blueberry Cheesecake', 150, 4.8, 1, 'Dessert', 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad', 'Creamy', NULL, NULL, NULL, 1, '15m'),
(18, 4, 'Red Velvet Pastry', 80, 4.7, 1, 'Dessert', 'https://images.unsplash.com/photo-1616541823729-00fe0aacd32c', NULL, NULL, NULL, NULL, 1, '15m'),
(19, 9, 'tandoori', 100, 4, 0, 'Starters', 'http://10.164.109.239:8000/uploads/20260302140055_upload_image_1772440254550.jpg', NULL, '5 pieces', 'Continental', 'Non-Veg', 1, '15m'),
(20, 8, 'Dosa rava', 15, 0, 1, 'Breakfast', 'http://10.164.109.239:8000/uploads/20260302215847_upload_image_1772468927150.jpg', NULL, 'Spicy Fresh dosa with peanut chetney', 'South Indian', 'Veg', 1, '15m'),
(21, 9, 'filter coffee ☕️', 20, 0, 1, 'Main Course', 'http://10.164.109.239:8000/uploads/20260303100150_upload_image_1772512309813.jpg', NULL, 'Pure authentic  filter coffee', 'Continental', 'Veg', 0, '15m'),
(22, 9, 'bike', 25000, 0, 0, 'Desserts', 'http://10.164.109.239:8000/uploads/20260303144403_upload_image_1772529241776.jpg', NULL, 'enjoy your ride', 'South Indian', 'Non-Veg', 1, '15m'),
(23, 9, 'grill chicken', 300, 0, 0, 'Starters', 'http://10.164.109.239:8000/uploads/20260306150333_upload_image_1772789615988.jpg', NULL, 'full body', 'Other', 'Non-Veg', 1, '15m'),
(24, 9, 'cake', 500, 0, 1, 'Desserts', 'http://10.164.109.239:8000/uploads/20260317091955_upload_image_1773719399338.jpg', NULL, 'cool cake', 'Other', 'Veg', 1, '15m'),
(25, 8, 'biriyani', 114, 0, 0, 'main-course', 'http://10.164.109.239:8000/uploads/20260324132759_Screenshot 2026-02-20 090201.png', '', 'spicy', 'south-indian', 'Non-Veg', 1, '15m'),
(26, 8, 'sambar idly', 30, 0, 1, 'Breakfast', 'http://172.25.88.77:8000/uploads/20260325092852_upload_image_1774411123911.jpg', NULL, '3 idly with some flavour sambar', 'South Indian', 'Veg', 1, '15m'),
(27, 8, '65 biryani', 120, 0, 1, 'Main Course', 'http://172.25.88.77:8000/uploads/20260325093023_upload_image_1774411219734.jpg', NULL, 'chettinad 65 biryani', 'South Indian', 'Veg', 1, '15m');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `chef_id` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `total_amount` float NOT NULL,
  `customer_rating` float DEFAULT NULL,
  `customer_note` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `delivery_fee` float DEFAULT 30,
  `platform_fee` float DEFAULT 21,
  `chef_earnings` float DEFAULT NULL,
  `payment_method` varchar(100) DEFAULT NULL,
  `delivery_address` varchar(255) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `customer_name` varchar(100) DEFAULT NULL,
  `customer_phone` varchar(20) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `preparing_at` datetime DEFAULT NULL,
  `out_for_delivery_at` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL,
  `special_instructions` text DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pincode` varchar(20) DEFAULT NULL,
  `package_fee` float DEFAULT 10,
  `ready_at` datetime DEFAULT NULL,
  `current_latitude` double DEFAULT NULL,
  `current_longitude` double DEFAULT NULL,
  `destination_latitude` double DEFAULT NULL,
  `destination_longitude` double DEFAULT NULL,
  `tracking_enabled` tinyint(1) DEFAULT 0,
  `last_location_updated_at` datetime DEFAULT NULL,
  `estimated_arrival_minutes` int(11) DEFAULT NULL,
  `remaining_distance_km` double DEFAULT NULL,
  `ready_for_delivery_at` datetime DEFAULT NULL,
  `near_you_at` datetime DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `chef_id`, `status`, `total_amount`, `customer_rating`, `customer_note`, `created_at`, `delivery_fee`, `platform_fee`, `chef_earnings`, `payment_method`, `delivery_address`, `latitude`, `longitude`, `customer_name`, `customer_phone`, `updated_at`, `accepted_at`, `preparing_at`, `out_for_delivery_at`, `delivered_at`, `special_instructions`, `address_id`, `landmark`, `area`, `city`, `state`, `pincode`, `package_fee`, `ready_at`, `current_latitude`, `current_longitude`, `destination_latitude`, `destination_longitude`, `tracking_enabled`, `last_location_updated_at`, `estimated_arrival_minutes`, `remaining_distance_km`, `ready_for_delivery_at`, `near_you_at`, `cancelled_at`) VALUES
(1, 7, 8, 'delivered', 15, NULL, NULL, '2026-03-02 17:04:25', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 7, 8, 'delivered', 15, NULL, NULL, '2026-03-02 17:52:50', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-26 05:18:14', '2026-03-19 03:56:03', '2026-03-26 05:18:02', '2026-03-26 05:18:14', '2026-03-26 05:18:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 21, 3, 'pending', 460, NULL, NULL, '2026-03-03 03:05:26', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 21, 1, 'pending', 60, NULL, NULL, '2026-03-03 03:10:03', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 21, 1, 'pending', 160, NULL, NULL, '2026-03-03 03:41:22', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 21, 9, 'delivered', 100, NULL, NULL, '2026-03-03 04:28:27', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 22, 9, 'delivered', 20, NULL, NULL, '2026-03-03 04:45:44', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 21, 1, 'pending', 40, NULL, NULL, '2026-03-03 07:19:56', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 24, 1, 'pending', 60, NULL, NULL, '2026-03-03 09:08:39', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 21, 9, 'declined', 25000, NULL, NULL, '2026-03-03 09:20:45', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 21, 9, 'delivered', 120, NULL, NULL, '2026-03-04 07:38:31', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 25, 9, 'delivered', 25120, NULL, NULL, '2026-03-04 08:26:31', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 25, 9, 'delivered', 100, NULL, NULL, '2026-03-04 08:31:15', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 25, 9, 'delivered', 25000, NULL, NULL, '2026-03-04 08:34:02', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 21, 1, 'pending', 120, NULL, NULL, '2026-03-04 09:59:29', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 21, 1, 'pending', 100, NULL, NULL, '2026-03-04 16:17:03', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 21, 1, 'pending', 100, NULL, NULL, '2026-03-04 16:51:04', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 21, 1, 'pending', 60, NULL, NULL, '2026-03-04 17:21:41', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 21, 9, 'delivered', 200, NULL, NULL, '2026-03-05 03:00:58', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 21, 9, 'delivered', 60, NULL, NULL, '2026-03-05 03:39:57', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 21, 9, 'delivered', 40, NULL, NULL, '2026-03-05 03:54:04', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 21, 1, 'pending', 60, NULL, NULL, '2026-03-05 03:56:57', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 21, 9, 'delivered', 100, NULL, NULL, '2026-03-05 03:57:50', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 21, 9, 'delivered', 200, NULL, NULL, '2026-03-05 04:16:02', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 21, 9, 'delivered', 300, NULL, NULL, '2026-03-05 07:11:06', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 21, 9, 'delivered', 100, NULL, NULL, '2026-03-05 07:55:22', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 21, 9, 'delivered', 100, 5, NULL, '2026-03-05 08:44:27', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 21, 3, 'pending', 140, NULL, NULL, '2026-03-05 08:49:50', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 21, 3, 'pending', 150, NULL, NULL, '2026-03-06 03:50:42', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 21, 9, 'delivered', 100, NULL, NULL, '2026-03-06 04:00:54', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 21, 1, 'pending', 60, NULL, NULL, '2026-03-06 04:27:23', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 21, 9, 'delivered', 100, NULL, NULL, '2026-03-06 07:10:45', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 21, 9, 'delivered', 100, NULL, NULL, '2026-03-06 07:23:16', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(34, 21, 9, 'delivered', 25000, NULL, NULL, '2026-03-06 07:37:29', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(35, 21, 9, 'delivered', 25000, NULL, NULL, '2026-03-06 08:18:32', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 21, 9, 'delivered', 100, 3, 'nb', '2026-03-06 09:30:12', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(37, 21, 9, 'accepted', 200, NULL, NULL, '2026-03-11 04:43:00', 30, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 21, 9, 'preparing', 251, NULL, '', '2026-03-17 08:06:34', 30, 21, 179, 'COD', 'Home: Flat 203, Santro City Apartments, Miyapur, Hyderabad - 500049', NULL, NULL, 'Customer', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 21, 1, 'pending', 96, NULL, '', '2026-03-18 04:06:12', 30, 21, 24, 'Razorpay:pay_SSYC5nG4nieDwK', 'Home: Flat 203, Santro City Apartments, Miyapur, Hyderabad - 500049', NULL, NULL, 'Customer', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 21, 1, 'pending', 111, NULL, '', '2026-03-18 05:09:41', 30, 21, 39, 'COD', 'Home: Kuthambakkam, Tamil Nadu', 13.0283, 80.0157, 'Customer', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 21, 2, 'pending', 301, NULL, '', '2026-03-18 09:16:19', 30, 21, 229, 'Razorpay:pay_SSdTg4ASOd07sw', 'Home: Flat 203, Santro City Apartments, Miyapur, Hyderabad - 500049', NULL, NULL, 'Ravi', '9866887894', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(45, 21, 2, 'pending', 211, NULL, '', '2026-03-19 04:07:06', 30, 21, 139, 'Razorpay:pay_SSwk9cMWSXm5ue', 'Home: Kuthambakkam, Tamil Nadu', 13.0283, 80.0157, 'Ravi', '9866887894', '2026-03-19 04:07:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(46, 21, 9, 'preparing', 151, NULL, '', '2026-03-19 04:09:11', 30, 21, 79, 'Razorpay:pay_SSwmMtZR2ccRpD', 'Home: Flat 203, Santro City Apartments, Miyapur, Hyderabad - 500049', NULL, NULL, 'Ravi', '9866887894', '2026-03-19 04:09:51', '2026-03-19 04:09:46', '2026-03-19 04:09:51', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 21, 9, 'delivered', 551, NULL, 'hii', '2026-03-19 04:46:08', 30, 21, 479, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0284, 80.0157, 'Ravi', '9866887894', '2026-03-20 05:45:37', '2026-03-20 05:45:21', '2026-03-20 05:45:34', '2026-03-20 05:45:36', '2026-03-20 05:45:37', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 21, 9, 'declined', 251, NULL, 'hii', '2026-03-19 04:54:39', 30, 21, 179, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0284, 80.0157, 'Ravi', '9866887894', '2026-03-20 04:56:26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 21, 1, 'pending', 70, NULL, '', '2026-03-20 05:16:15', 0, 0, 60, 'Razorpay:pay_STMSL9IJeq5X4q', 'Flat 203, Santro City Apartments, Miyapur, Hyderabad - 500049', NULL, NULL, 'Ravi', '9866887894', '2026-03-20 05:16:15', NULL, NULL, NULL, NULL, '', 1, NULL, NULL, 'Hyderabad', NULL, '500049', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 21, 9, 'out_for_delivery', 30, NULL, 'I want spicy', '2026-03-20 05:52:42', 0, 0, 20, 'COD', 'Poongavanapuram, Tamil Nadu', 13.0827, 80.2707, 'Ravi', '9866887894', '2026-03-23 03:30:54', '2026-03-20 05:53:19', '2026-03-20 05:53:20', '2026-03-23 03:30:54', NULL, 'I want spicy', 1, '', 'Kuttambakkam', 'Tiruvallur', 'Tamil Nadu', '600124', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(51, 21, 9, 'delivered', 110, NULL, NULL, '2026-03-23 07:25:23', 0, 0, 100, 'upi', NULL, NULL, NULL, NULL, NULL, '2026-03-23 11:18:57', '2026-03-23 09:16:16', '2026-03-23 09:16:20', '2026-03-23 11:18:56', '2026-03-23 11:18:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(52, 21, 9, 'ready', 210, NULL, NULL, '2026-03-23 11:29:56', 0, 0, 200, 'cod', NULL, NULL, NULL, NULL, NULL, '2026-03-23 11:31:09', NULL, '2026-03-23 11:31:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 21, 9, 'delivered', 25010, NULL, 'need sipcy', '2026-03-23 11:41:39', 0, 0, 25000, 'Razorpay:pay_SUecsDQMlgpYLp', 'Kuthambakkam, Tamil Nadu', 13.0282, 80.0158, 'Ravi', '9866887894', '2026-03-23 11:43:24', NULL, '2026-03-23 11:43:08', NULL, '2026-03-23 11:43:24', 'need sipcy', 5, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(54, 27, 9, 'pending', 510, NULL, NULL, '2026-03-23 17:26:34', 0, 0, 500, 'cod', NULL, NULL, NULL, NULL, NULL, '2026-03-23 17:26:34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 27, 9, 'pending', 110, NULL, NULL, '2026-03-24 02:48:26', 0, 0, 100, 'cod', NULL, NULL, NULL, NULL, NULL, '2026-03-24 02:48:26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 27, 9, 'pending', 510, NULL, NULL, '2026-03-24 04:03:56', 0, 0, 500, 'cod', NULL, NULL, NULL, NULL, NULL, '2026-03-24 04:03:56', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(57, 27, 2, 'pending', 50, NULL, NULL, '2026-03-24 07:20:23', 0, 0, 40, 'cod', NULL, NULL, NULL, NULL, NULL, '2026-03-24 07:20:23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(58, 27, 8, 'declined', 25, NULL, NULL, '2026-03-24 07:20:49', 0, 0, 15, 'cod', NULL, NULL, NULL, NULL, NULL, '2026-03-25 03:57:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(59, 27, 8, 'declined', 124, NULL, '', '2026-03-24 08:06:50', 0, 0, 114, 'Razorpay:pay_SUzUkc2FqLP0iz', 'santrocity', NULL, NULL, 'siddu', '1234567848', '2026-03-25 03:57:24', NULL, NULL, NULL, NULL, '', 7, 'ganesh shop', 'Kuttambakkam', 'Tiruvallur', 'Tamil Nadu', '600124', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(60, 27, 2, 'pending', 260, NULL, '', '2026-03-24 08:07:33', 0, 0, 250, 'COD', 'badvel', 0, 0, 'siddu', '1234567848', '2026-03-24 08:07:33', NULL, NULL, NULL, NULL, '', 8, '', 'Kuttambakkam', 'Tiruvallur', 'Tamil Nadu', '600124', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(61, 27, 3, 'pending', 160, NULL, NULL, '2026-03-24 09:27:37', 0, 0, 150, 'cod', NULL, NULL, NULL, NULL, NULL, '2026-03-24 09:27:37', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(76, 30, 1, 'pending', 70, NULL, '', '2026-03-25 04:08:16', 0, 0, 60, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0266, 80.016, 'Ravi', '8074869069', '2026-03-25 04:08:16', NULL, NULL, NULL, NULL, '', 9, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(77, 30, 8, 'delivered', 130, NULL, '', '2026-03-25 04:09:19', 0, 0, 120, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0266, 80.016, 'Ravi', '8074869069', '2026-03-26 05:18:01', '2026-03-25 04:16:26', '2026-03-26 05:18:00', '2026-03-26 05:18:00', '2026-03-26 05:18:01', '', 9, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(78, 27, 1, 'pending', 70, NULL, '', '2026-03-25 05:04:45', 0, 0, 60, 'COD', 'santrocity', 0, 0, 'siddu', '1234567848', '2026-03-25 05:04:45', NULL, NULL, NULL, NULL, '', 12, '', 'Kuttambakkam', 'Tiruvallur', 'Tamil Nadu', '600124', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(79, 27, 1, 'pending', 70, NULL, '', '2026-03-25 05:17:05', 0, 0, 60, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0283, 80.0159, 'siddu', '1234567848', '2026-03-25 05:17:05', NULL, NULL, NULL, NULL, '', 11, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(80, 27, 8, 'delivered', 130, NULL, '', '2026-03-25 08:44:20', 0, 0, 120, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0283, 80.0159, 'siddu', '1234567848', '2026-03-26 05:17:57', '2026-03-25 15:29:50', '2026-03-25 15:29:57', '2026-03-26 05:17:57', '2026-03-26 05:17:57', '', 11, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(84, 27, 1, 'pending', 50, NULL, '', '2026-03-25 15:27:38', 0, 0, 40, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0283, 80.0159, 'siddu', '1234567848', '2026-03-25 15:27:38', NULL, NULL, NULL, NULL, '', 11, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(85, 27, 8, 'delivered', 40, NULL, '', '2026-03-25 16:45:20', 0, 0, 30, 'COD', 'Chennai, Tamil Nadu', 13.0547, 80.0604, 'siddu', '1234567848', '2026-03-26 05:18:08', '2026-03-26 05:18:06', '2026-03-26 05:18:06', '2026-03-26 05:18:07', '2026-03-26 05:18:08', '', 13, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(86, 27, 9, 'pending', 30, NULL, '', '2026-03-25 16:54:43', 0, 0, 20, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0283, 80.0159, 'siddu', '1234567848', '2026-03-25 16:54:43', NULL, NULL, NULL, NULL, '', 11, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(87, 27, 8, 'delivered', 25, NULL, '', '2026-03-25 16:55:56', 0, 0, 15, 'COD', 'santrocity', NULL, NULL, 'siddu', '1234567848', '2026-03-26 05:18:10', '2026-03-26 05:18:09', '2026-03-26 05:18:09', '2026-03-26 05:18:10', '2026-03-26 05:18:10', '', 6, 'siddu', 'Kuttambakkam', 'Tiruvallur', 'Tamil Nadu', '600124', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(88, 27, 8, 'delivered', 124, NULL, '', '2026-03-25 16:59:32', 0, 0, 114, 'COD', 'Chembarambakkam, Tamil Nadu', 13.0438, 80.0524, 'siddu', '1234567848', '2026-03-26 05:18:11', '2026-03-25 16:59:56', '2026-03-25 16:59:58', '2026-03-26 05:18:11', '2026-03-26 05:18:11', '', 15, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(89, 27, 8, 'delivered', 25, NULL, '', '2026-03-25 17:16:30', 0, 0, 15, 'COD', 'Chembarambakkam, Tamil Nadu', 13.0438, 80.0524, 'siddu', '1234567848', '2026-03-26 05:18:12', '2026-03-26 05:17:41', '2026-03-26 05:17:42', '2026-03-26 05:18:11', '2026-03-26 05:18:12', '', 15, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(90, 27, 2, 'pending', 170, NULL, '', '2026-03-26 04:19:21', 0, 0, 160, 'COD', 'Chembarambakkam, Tamil Nadu', 13.0438, 80.0524, 'siddu', '1234567848', '2026-03-26 04:19:21', NULL, NULL, NULL, NULL, '', 15, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(91, 27, 2, 'pending', 260, NULL, '', '2026-03-26 04:56:27', 0, 0, 250, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0283, 80.0159, 'siddu', '1234567848', '2026-03-26 04:56:27', NULL, NULL, NULL, NULL, '', 11, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, 13.0283, 80.0159, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(92, 27, 3, 'pending', 160, NULL, '', '2026-03-26 05:10:14', 0, 0, 150, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0283, 80.0159, 'siddu', '1234567848', '2026-03-26 05:10:14', NULL, NULL, NULL, NULL, '', 11, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, 13.0283, 80.0159, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(93, 27, 1, 'pending', 70, NULL, '', '2026-03-26 08:12:45', 0, 0, 60, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0283, 80.0159, 'siddu', '1234567848', '2026-03-26 08:12:45', NULL, NULL, NULL, NULL, '', 11, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, 13.0283, 80.0159, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(94, 27, 8, 'ready_for_delivery', 40, NULL, '', '2026-03-26 08:13:32', 0, 0, 30, 'COD', 'Kuthambakkam, Tamil Nadu', 13.0283, 80.0159, 'siddu', '1234567848', '2026-03-26 08:14:49', '2026-03-26 08:14:09', '2026-03-26 08:14:24', NULL, NULL, '', 11, NULL, NULL, 'Tamil Nadu', NULL, '000000', 10, NULL, NULL, NULL, 13.0283, 80.0159, 1, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `dish_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `dish_id`, `quantity`, `price`) VALUES
(1, 1, 20, 1, 15),
(2, 2, 20, 1, 15),
(3, 3, 14, 2, 150),
(4, 3, 9, 1, 160),
(5, 4, 1, 1, 60),
(6, 5, 1, 2, 60),
(7, 5, 2, 1, 40),
(8, 6, 19, 1, 100),
(9, 7, 21, 1, 20),
(10, 8, 2, 1, 40),
(11, 9, 1, 1, 60),
(12, 10, 22, 1, 25000),
(13, 11, 19, 1, 100),
(14, 11, 21, 1, 20),
(15, 12, 19, 1, 100),
(16, 12, 21, 1, 20),
(17, 12, 22, 1, 25000),
(18, 13, 19, 1, 100),
(19, 14, 22, 1, 25000),
(20, 15, 4, 1, 120),
(21, 16, 1, 1, 60),
(22, 16, 2, 1, 40),
(23, 17, 1, 1, 60),
(24, 17, 2, 1, 40),
(25, 18, 1, 1, 60),
(26, 19, 19, 2, 100),
(27, 20, 21, 3, 20),
(28, 21, 21, 2, 20),
(29, 22, 1, 1, 60),
(30, 23, 19, 1, 100),
(31, 24, 19, 2, 100),
(32, 25, 19, 3, 100),
(33, 26, 19, 1, 100),
(34, 27, 19, 1, 100),
(35, 28, 12, 1, 140),
(36, 29, 14, 1, 150),
(37, 30, 19, 1, 100),
(38, 31, 1, 1, 60),
(39, 32, 19, 1, 100),
(40, 33, 19, 1, 100),
(41, 34, 22, 1, 25000),
(42, 35, 22, 1, 25000),
(43, 36, 19, 1, 100),
(44, 37, 19, 2, 100),
(45, 41, 19, 2, 100),
(46, 42, 6, 1, 45),
(47, 43, 1, 1, 60),
(48, 44, 7, 1, 250),
(49, 45, 9, 1, 160),
(50, 46, 19, 1, 100),
(51, 47, 24, 1, 500),
(52, 48, 19, 2, 100),
(53, 49, 1, 1, 60),
(54, 50, 21, 1, 20),
(55, 51, 19, 1, 100),
(56, 52, 19, 2, 100),
(57, 53, 22, 1, 25000),
(58, 54, 24, 1, 500),
(59, 55, 19, 1, 100),
(60, 56, 24, 1, 500),
(61, 57, 10, 1, 40),
(62, 58, 20, 1, 15),
(63, 59, 25, 1, 114),
(64, 60, 7, 1, 250),
(65, 61, 14, 1, 150),
(66, 76, 1, 1, 60),
(67, 77, 27, 1, 120),
(68, 78, 1, 1, 60),
(69, 79, 1, 1, 60),
(70, 80, 27, 1, 120),
(71, 84, 2, 1, 40),
(72, 85, 26, 1, 30),
(73, 86, 21, 1, 20),
(74, 87, 20, 1, 15),
(75, 88, 25, 1, 114),
(76, 89, 20, 1, 15),
(77, 90, 9, 1, 160),
(78, 91, 7, 1, 250),
(79, 92, 14, 1, 150),
(80, 93, 1, 1, 60),
(81, 94, 20, 2, 15);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_verified` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `otp`, `expires_at`, `is_verified`) VALUES
(1, 'manukondatarun5@gmail.com', '425932', '2026-03-01 18:32:42', 0),
(4, 'punaganiravi@gmail.com', '704317', '2026-03-02 08:50:49', 0);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `dish_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `rating` float NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `dish_id`, `order_id`, `rating`, `comment`, `created_at`) VALUES
(1, 21, 19, 27, 5, NULL, '2026-03-06 03:20:42'),
(2, 21, 19, 36, 3, 'nb', '2026-03-07 17:00:43');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `wallet_id` int(11) DEFAULT NULL,
  `amount` float NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `otp_code` varchar(10) DEFAULT NULL,
  `otp_expiry` datetime DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `password`, `role`, `created_at`, `otp_code`, `otp_expiry`, `image_url`) VALUES
(4, 'Ravi', 'ravi123@gmail.com', '9876543210', 'chaloo', 'customer', '2026-02-27 07:39:15', NULL, NULL, NULL),
(5, 'pookie', 'pookie@gmail.com', '1234567890', '1234567', 'customer', '2026-02-27 08:25:15', NULL, NULL, NULL),
(6, 'siddu', 'siddu123@gmail.com', '9866040621', '12341234', 'customer', '2026-02-27 08:27:31', NULL, NULL, NULL),
(7, 'Tarun', 'manukondatarun5@gmail.com', '7893978256', '123456', 'customer', '2026-02-28 14:51:43', NULL, NULL, NULL),
(10, 'Chef Li', 'li@example.com', '1122334455', 'password123', 'chef', '2026-02-28 15:36:34', NULL, NULL, NULL),
(11, 'Chef Sofia', 'sofia@example.com', '5544332211', 'password123', 'chef', '2026-02-28 15:36:34', NULL, NULL, NULL),
(12, 'Test Customer', 'test@example.com', '0000000000', 'password123', 'customer', '2026-02-28 15:36:34', NULL, NULL, NULL),
(17, 'mariyamasssssss', 'mariyamassssss@gmail.com', '9059671651', '123456', 'customer', '2026-03-01 13:56:33', NULL, NULL, NULL),
(19, 'mariyamasssssss', 'gogo@gmail.com', '9059671655', '123456', 'customer', '2026-03-01 14:05:25', NULL, NULL, NULL),
(20, 'mariyamasssssss', 'go77go@gmail.com', '9059671566', '123456', 'customer', '2026-03-01 14:06:39', NULL, NULL, NULL),
(21, 'Ravi', 'punaganiravi@gmail.com', '9866887894', 'siddu123', 'customer', '2026-03-02 04:03:04', NULL, NULL, NULL),
(22, 'swagath', 'swagath@gmail.com', '1234567899', '......', 'customer', '2026-03-03 04:42:39', NULL, NULL, NULL),
(23, 'srinivas', 'srinivasvellaturi61@gmail.com', '1324567980', '111111', 'customer', '2026-03-03 07:52:42', NULL, NULL, NULL),
(24, 'layna', 'layna4115@gmail.com', '6374258264', 'Layna@123', 'customer', '2026-03-03 09:07:04', NULL, NULL, NULL),
(25, 'DEVAAA!!!!', 'punugotideva618@gmail.com', '7993537243', 'Deva@0000', 'customer', '2026-03-04 08:25:37', NULL, NULL, NULL),
(26, 'Ravi chandra', 'chandra@gmail.com', '8074869061', '000000', 'customer', '2026-03-17 03:47:15', NULL, NULL, NULL),
(27, 'siddu', 'siddu@outlook.com', '1234567848', 'Siddu123@', 'customer', '2026-03-23 15:02:19', NULL, NULL, NULL),
(28, 'Uyyala Siddu Siddu', 'uyyalasiddu4260.sse@saveetha.com', '9392684984', 'siddu123', 'customer', '2026-03-23 15:06:46', NULL, NULL, NULL),
(29, 'ravi', 'punagani@gmail.com', '9866887890', 'ravi46143', 'customer', '2026-03-24 03:08:06', NULL, NULL, NULL),
(30, 'Ravi', 'punaganiravi17@gmail.com', '8074869069', 'Ravi46143@', 'customer', '2026-03-25 03:55:47', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `user_id` int(11) NOT NULL,
  `balance` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`user_id`, `balance`) VALUES
(17, 0),
(19, 0),
(20, 0),
(21, 0),
(22, 0),
(23, 0),
(24, 0),
(25, 0),
(26, 0),
(27, 0),
(28, 0),
(29, 0),
(30, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_addresses_id` (`id`),
  ADD KEY `fk_addresses_user` (`user_id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `ix_carts_id` (`id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `dish_id` (`dish_id`),
  ADD KEY `ix_cart_items_id` (`id`);

--
-- Indexes for table `chefs`
--
ALTER TABLE `chefs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `ix_chefs_id` (`id`);

--
-- Indexes for table `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chef_id` (`chef_id`),
  ADD KEY `ix_dishes_id` (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_orders_id` (`id`),
  ADD KEY `fk_orders_user` (`user_id`),
  ADD KEY `fk_orders_chef` (`chef_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_order_items_id` (`id`),
  ADD KEY `fk_order_items_order` (`order_id`),
  ADD KEY `fk_order_items_dish` (`dish_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_password_resets_id` (`id`),
  ADD KEY `ix_password_resets_email` (`email`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `dish_id` (`dish_id`),
  ADD KEY `ix_reviews_id` (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallet_id` (`wallet_id`),
  ADD KEY `ix_transactions_id` (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_users_phone` (`phone`),
  ADD UNIQUE KEY `ix_users_email` (`email`),
  ADD KEY `ix_users_id` (`id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `chefs`
--
ALTER TABLE `chefs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `dishes`
--
ALTER TABLE `dishes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_addresses_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`);

--
-- Constraints for table `chefs`
--
ALTER TABLE `chefs`
  ADD CONSTRAINT `chefs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `dishes`
--
ALTER TABLE `dishes`
  ADD CONSTRAINT `dishes_ibfk_1` FOREIGN KEY (`chef_id`) REFERENCES `chefs` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_chef` FOREIGN KEY (`chef_id`) REFERENCES `chefs` (`id`),
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`chef_id`) REFERENCES `chefs` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_dish` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`),
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`user_id`);

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
