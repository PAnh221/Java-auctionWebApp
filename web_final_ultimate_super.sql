-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 30, 2021 lúc 10:06 PM
-- Phiên bản máy phục vụ: 10.4.20-MariaDB
-- Phiên bản PHP: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `web_final`
--
CREATE DATABASE IF NOT EXISTS `web_final` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `web_final`;

DELIMITER $$
--
-- Thủ tục
--
DROP PROCEDURE IF EXISTS `updateEndDateProductStatus`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEndDateProductStatus` ()  UPDATE web_final.product SET product.Status = 1 WHERE product.EndDate <= NOW() AND product.Status = 0$$

DROP PROCEDURE IF EXISTS `updateFailedAuctionProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateFailedAuctionProduct` ()  UPDATE web_final.product SET product.Status = 2 WHERE product.Status = 1 AND (SELECT EXISTS(SELECT * FROM bid WHERE bid.ProductID = product.ProID)) = 0$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ban`
--

DROP TABLE IF EXISTS `ban`;
CREATE TABLE `ban` (
  `BanID` int(11) NOT NULL,
  `BidderBannedID` int(11) NOT NULL COMMENT 'ID của bidder bị ban',
  `ProductID` int(11) NOT NULL COMMENT 'ID của product mà bidder bị ban'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bid`
--

DROP TABLE IF EXISTS `bid`;
CREATE TABLE `bid` (
  `BidID` int(11) NOT NULL COMMENT 'ID Bid',
  `BidderID` int(11) NOT NULL COMMENT 'ID người ra giá',
  `ProductID` int(11) NOT NULL COMMENT 'ID sản phẩm được ra giá',
  `Time` datetime NOT NULL COMMENT 'Thời gian ra giá',
  `MaxBid` bigint(20) NOT NULL COMMENT 'Giá tối đa người ra giá sẽ trả'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `bid`
--

INSERT INTO `bid` (`BidID`, `BidderID`, `ProductID`, `Time`, `MaxBid`) VALUES
(22, 4, 44, '2021-12-30 21:46:02', 500000000),
(23, 3, 44, '2021-12-30 21:46:31', 600000000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `CatID` int(11) NOT NULL,
  `CatName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`CatID`, `CatName`) VALUES
(1, 'Thiết Bị Điện Tử'),
(2, 'Thời Trang'),
(3, 'Bách Hóa'),
(4, 'Phương Tiện');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ProID` int(11) NOT NULL COMMENT 'ID sản phẩm',
  `ProName` varchar(255) NOT NULL COMMENT 'Tên sản phẩm',
  `SubCatID` int(11) NOT NULL COMMENT 'ID subcategory',
  `SellerID` int(11) NOT NULL COMMENT 'ID người đăng sản phẩm',
  `StartPrice` bigint(11) NOT NULL COMMENT 'Giá khởi điểm',
  `StepPrice` bigint(11) NOT NULL COMMENT 'Bước giá',
  `TinyDes` varchar(255) NOT NULL COMMENT 'Mô tả ngắn gọn',
  `FullDes` varchar(5000) NOT NULL COMMENT 'Mô tả chi tiết',
  `Bin` bigint(20) DEFAULT NULL COMMENT 'giá mua ngay',
  `UploadDate` datetime NOT NULL COMMENT 'Thời gian đăng sản phẩm',
  `EndDate` datetime NOT NULL COMMENT 'Thời gian kết thúc đấu giá',
  `ImgIndex` int(11) NOT NULL COMMENT 'Tên thư mục chứa ảnh',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '0 - đang đấu giá, 1 - đấu giá thành công, 2 - đấu giá thất bại\r\n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`ProID`, `ProName`, `SubCatID`, `SellerID`, `StartPrice`, `StepPrice`, `TinyDes`, `FullDes`, `Bin`, `UploadDate`, `EndDate`, `ImgIndex`, `Status`) VALUES
(19, 'Iphone 13', 1, 1, 1000000, 500000, 'Điện thoại đời mới', '<p class=\"parameter__title\"><strong>Cấu h&igrave;nh Điện thoại <span style=\"color: #f8cac6;\">iPhone 13 512GB</span></strong></p>\r\n<div class=\"parameter\">\r\n<p class=\"lileft\"><em>M&agrave;n h&igrave;nh:</em> <span class=\"comma\">OLED</span><span class=\"comma\">6.1\"</span><span class=\"\">Super Retina XDR</span></p>\r\n<p class=\"lileft\"><em>Hệ điều h&agrave;nh:</em> <span class=\"\">iOS 15</span></p>\r\n<p class=\"lileft\"><em>Camera sau:</em> <span class=\"\">2 camera 12 MP</span></p>\r\n<p class=\"lileft\"><em>Camera trước:</em> <span class=\"\">12 MP</span></p>\r\n<p class=\"lileft\"><em>Chip:</em> <span class=\"\">Apple A15 Bionic</span></p>\r\n<p class=\"lileft\"><em>RAM:</em> <span class=\"\">4 GB</span></p>\r\n<p class=\"lileft\"><em>Bộ nhớ trong:</em> <span class=\"\">512 GB</span></p>\r\n<p class=\"lileft\"><em>SIM:</em> <span class=\"comma\">1 Nano SIM &amp; 1 eSIM</span><span class=\"\">Hỗ trợ 5G</span></p>\r\n<p class=\"lileft\"><em>Pin, Sạc: </em><span class=\"comma\">3240 mAh</span><span class=\"\">20 W</span></p>\r\n</div>', 20000000, '2021-12-31 01:31:17', '2022-01-07 01:31:17', 1, 0),
(20, 'Samsung Zfip 2', 1, 1, 1700000, 600000, 'Điện thoại phiên bản giới hạn', '<p><strong>Cấu h&igrave;nh Điện thoại <span style=\"color: #b96ad9;\">Samsung Galaxy Z Flip 2 </span></strong></p>\r\n<p><em>M&agrave;n h&igrave;nh</em>: Full HD+</p>\r\n<p><em>Chip</em>: Snapdragon 888</p>\r\n<p><em>RAM</em>: 8 GB</p>\r\n<p><em>Bộ nhớ tron</em>g: 256 GB</p>\r\n<p><em>SIM</em>: 2 Micro SIM</p>\r\n<p><em>Hỗ trợ 5G</em></p>', 50000000, '2021-12-31 01:40:34', '2022-01-07 01:40:34', 20, 0),
(21, 'Xiaomi Note 10', 1, 3, 1000000, 200000, 'Điện thoại chính hãng mới nhất của ', '<p><strong>Cấu h&igrave;nh Điện thoại <span style=\"color: #7e8c8d;\">Xiaomi Redmi Note 10</span> (6GB/128GB) </strong></p>\r\n<p><em>M&agrave;n h&igrave;nh</em>: AMOLED6.43\"Full HD</p>\r\n<p><em>Hệ điều h&agrave;nh</em>: Android 11</p>\r\n<p><em>Camera sau</em>: Ch&iacute;nh 48 MP &amp; Phụ 8 MP, 2 MP, 2 MP</p>\r\n<p><em>Camera trước</em>: 13 MP</p>\r\n<p><em>Chip:</em> Snapdragon 678</p>\r\n<p><em>RAM</em>: 6 GB</p>\r\n<p><em>Bộ nhớ trong</em>: 128 GB</p>\r\n<p><em>SIM:</em> 2 Nano SIM</p>\r\n<p><em>Hỗ trợ 4G </em></p>\r\n<p><em>Pin, Sạc:</em> 5000 mAh 33 W</p>\r\n<p><em>H&atilde;ng:</em> Xiaomi.</p>', 6000000, '2021-12-31 01:44:43', '2022-01-07 01:44:43', 21, 0),
(22, 'Ipad Pro 11', 3, 1, 5000000, 1500000, 'Máy tính bảng vừa ra mắt của nhà Apple', '<p><strong>Cấu h&igrave;nh M&aacute;y t&iacute;nh bảng<span style=\"color: #7e8c8d;\"> iPad Pro 11</span> inch Wifi 128GB (2020) </strong></p>\r\n<p><em>M&agrave;n h&igrave;nh</em>: 11\"Liquid Retina</p>\r\n<p><em>Hệ điều h&agrave;nh</em>: iPadOS 15</p>\r\n<p><em>Chip: </em>Apple A12Z Bionic</p>\r\n<p><em>RAM:</em> 6 GB</p>\r\n<p><em>Bộ nhớ trong</em>: 128 GB</p>\r\n<p><em>Kết nối:</em> Nghe gọi qua FaceTime</p>\r\n<p><em>Camera sau: </em>Ch&iacute;nh 12 MP &amp; Phụ 10 MP</p>\r\n<p><em>Camera trước: </em>7 MP</p>\r\n<p><em>Pin, Sạc: </em>28.65 Wh (~ 7600 mAh) 18 W</p>', 60000000, '2021-12-31 01:47:53', '2022-01-07 01:47:53', 22, 0),
(23, 'Samsung Galaxy Tab A7', 3, 1, 2100000, 700000, 'Máy tính bảng của Samsung ', '<p><strong>Cấu h&igrave;nh M&aacute;y t&iacute;nh bảng <span style=\"color: #f8cac6;\">Samsung Galaxy Tab A7 </span></strong></p>\r\n<p><em>M&agrave;n h&igrave;nh: </em>10.4\"TFT LCD</p>\r\n<p><em>Hệ điều h&agrave;nh</em>: Android 10</p>\r\n<p><em>Chip</em>: Snapdragon 662</p>\r\n<p><em>RAM: </em>3 GB</p>\r\n<p><em>Bộ nhớ trong: </em>64 GB</p>\r\n<p><em>Kết nối: </em>Hỗ trợ 4G C&oacute; nghe gọi</p>\r\n<p><em>SIM: </em>1 Nano SIM</p>\r\n<p><em>Camera sau:</em> 8 MP</p>\r\n<p><em>Camera trước:</em> 5 MP</p>\r\n<p><em>Pin, Sạc:</em> 7040 mAh10 W</p>', 45000000, '2021-12-31 01:52:52', '2022-01-07 01:52:52', 23, 0),
(24, 'Xiaomi Mi Pad 5', 3, 1, 1300000, 350000, 'Máy tính bảng của hãng Xiaomi', '<p><strong>Cấu h&igrave;nh: M&aacute;y t&iacute;nh bảng <span style=\"color: #169179;\">Xiaomi Mi Pad 5 </span></strong></p>\n<p><em>K&iacute;ch thước m&agrave;n h&igrave;nh:</em> 11 inches</p>\n<p><em>C&ocirc;ng nghệ m&agrave;n h&igrave;nh:</em> IPS LCD</p>\n<p><em>Camera sau: </em>Ch&iacute;nh 50 MP &amp; Phụ 5 MP</p>\n<p><em>Camera trước</em>: 8 MP</p>\n<p><em>Chipset</em>: Snapdragon 870 8 nh&acirc;n</p>\n<p><em>Dung lượng RAM: </em>6 GB</p>\n<p><em>Bộ nhớ trong: </em>128 GB</p>\n<p><em>Pin: </em>8600 mAh</p>', 15000000, '2021-12-31 01:58:42', '2022-01-07 01:58:42', 24, 0),
(25, 'Laptop Acer Nitro 5', 2, 1, 5000000, 500000, 'Laptop mạnh mẽ của Acer', '<p><strong>Cấu h&igrave;nh <span style=\"color: #ba372a;\">Laptop Acer Nitro 5 </span></strong></p>\r\n<p><em>CPU:</em> i7 11800H 2.30 GHz</p>\r\n<p><em>RAM:</em> 8 GB DDR4 2 khe</p>\r\n<p><em>Ổ cứng:</em> 512 GB SSD NVMe PCIe</p>\r\n<p><em>M&agrave;n h&igrave;nh:</em> 15.6\"Full HD (1920 x 1080) 144Hz</p>\r\n<p><em>Card m&agrave;n h&igrave;nh</em>: Card rời RTX 3050Ti 4GB</p>\r\n<p><em>Đặc biệt:</em> C&oacute; đ&egrave;n b&agrave;n ph&iacute;m</p>\r\n<p><em>Hệ điều h&agrave;nh:</em> Windows 10 Home SL</p>\r\n<p><em>Thiết kế:</em> Vỏ nhựa&nbsp;</p>', 25000000, '2021-12-31 02:02:34', '2022-01-07 02:02:34', 25, 0),
(26, 'Surface Pro 6', 2, 3, 3500000, 1200000, 'Laptop của Microsoft', '<p><strong>Cấu h&igrave;nh <span style=\"color: #7e8c8d;\">Surface Pro 6 </span></strong></p>\r\n<p><em>CPU</em>: Intel Core i5-8250U</p>\r\n<p><em>RAM</em>: 8 GB DDR4 2 khe</p>\r\n<p><em>Ổ cứng</em>: 512 GB SSD NVMe PCIe</p>\r\n<p><em>M&agrave;n h&igrave;nh:</em> 12.3\" IPS (2736 x 1824), gương, cảm ứng</p>\r\n<p><em>Card m&agrave;n h&igrave;nh</em>: Intel UHD 620</p>\r\n<p><em>Đặc biệt:</em> C&oacute; đ&egrave;n b&agrave;n ph&iacute;m</p>\r\n<p><em>Hệ điều h&agrave;nh:</em> Windows 10 Home SL</p>\r\n<p><em>Thiết kế:</em> Vỏ kim loại</p>', 0, '2021-12-31 02:07:03', '2022-01-07 02:07:03', 26, 0),
(28, 'Laptop Dell Latitude 3520', 2, 1, 4200000, 1500000, 'Laptop của Dell', '<p><strong>Cấu h&igrave;nh <span style=\"color: #7e8c8d;\">Laptop Dell Latitude 3520 </span></strong></p>\r\n<p><em>CPU</em>: Intel Core i7 1165G7 2.8GHz</p>\r\n<p><em>RAM:</em> 8 GB DDR4 2 khe</p>\r\n<p><em>Ổ cứng</em>: 512 GB SSD NVMe PCIe</p>\r\n<p><em>M&agrave;n h&igrave;nh:</em> 15.6\" Full HD</p>\r\n<p><em>Card m&agrave;n h&igrave;nh</em>: Intel Iris Xe</p>\r\n<p><em>Đặc biệt:</em> C&oacute; đ&egrave;n b&agrave;n ph&iacute;m</p>\r\n<p><em>Hệ điều h&agrave;nh: </em>Windows 10 Pro</p>\r\n<p><em>Thiết kế</em>: Vỏ nhựa</p>', 0, '2021-12-31 02:16:06', '2022-01-07 02:16:06', 27, 0),
(29, 'Dây chuyền kim cương', 4, 3, 10000000, 2000000, 'Sản phẩm thủ công có một không hai', '<p><strong><em>D&acirc;y chuyền Kim cương độc nhất </em></strong></p>\r\n<p><em>Loại: D&acirc;y chuyền </em></p>\r\n<p><em>Chất liệu: Mặt kim cương </em></p>\r\n<p><em>Khối lượng: 2 cara </em></p>\r\n<p><em>Xuất xứ: Nam Phi </em></p>\r\n<p><em>Giấy ph&eacute;p: Đầy đủ </em></p>\r\n<p><em>Bảo h&agrave;nh: Trọn đời</em></p>', 0, '2021-12-31 02:18:05', '2022-01-07 02:18:05', 29, 0),
(30, 'Vòng tay Handmade', 4, 1, 20000, 10000, 'Vòng tay nhà làm xinh như nhà làm', '<div class=\"oIy2qc\" data-message-text=\"V&ograve;ng tay Handmade tặng người y&ecirc;u\nLoại: V&ograve;ng tay\nChất liệu: Champ handmade\nKhối lượng: 100g\nXuất xứ: Việt Nam\nBảo h&agrave;nh: Trọn đời\nTr&aacute;nh tiếp x&uacute;c nước l&acirc;u\"><strong><em>V&ograve;ng tay Handmade tặng người y&ecirc;u </em></strong></div>\n<div class=\"oIy2qc\" data-message-text=\"V&ograve;ng tay Handmade tặng người y&ecirc;u\nLoại: V&ograve;ng tay\nChất liệu: Champ handmade\nKhối lượng: 100g\nXuất xứ: Việt Nam\nBảo h&agrave;nh: Trọn đời\nTr&aacute;nh tiếp x&uacute;c nước l&acirc;u\"><em>Loại: V&ograve;ng tay </em></div>\n<div class=\"oIy2qc\" data-message-text=\"V&ograve;ng tay Handmade tặng người y&ecirc;u\nLoại: V&ograve;ng tay\nChất liệu: Champ handmade\nKhối lượng: 100g\nXuất xứ: Việt Nam\nBảo h&agrave;nh: Trọn đời\nTr&aacute;nh tiếp x&uacute;c nước l&acirc;u\"><em>Chất liệu: Champ handmade </em></div>\n<div class=\"oIy2qc\" data-message-text=\"V&ograve;ng tay Handmade tặng người y&ecirc;u\nLoại: V&ograve;ng tay\nChất liệu: Champ handmade\nKhối lượng: 100g\nXuất xứ: Việt Nam\nBảo h&agrave;nh: Trọn đời\nTr&aacute;nh tiếp x&uacute;c nước l&acirc;u\"><em>Khối lượng: 100g </em></div>\n<div class=\"oIy2qc\" data-message-text=\"V&ograve;ng tay Handmade tặng người y&ecirc;u\nLoại: V&ograve;ng tay\nChất liệu: Champ handmade\nKhối lượng: 100g\nXuất xứ: Việt Nam\nBảo h&agrave;nh: Trọn đời\nTr&aacute;nh tiếp x&uacute;c nước l&acirc;u\"><em>Xuất xứ: Việt Nam </em></div>\n<div class=\"oIy2qc\" data-message-text=\"V&ograve;ng tay Handmade tặng người y&ecirc;u\nLoại: V&ograve;ng tay\nChất liệu: Champ handmade\nKhối lượng: 100g\nXuất xứ: Việt Nam\nBảo h&agrave;nh: Trọn đời\nTr&aacute;nh tiếp x&uacute;c nước l&acirc;u\"><em>Tr&aacute;nh tiếp x&uacute;c nước l&acirc;u</em></div>', 500000, '2021-12-31 02:22:30', '2022-01-07 02:22:30', 30, 0),
(31, 'Nhẫn titan', 4, 1, 200000, 150000, 'Hàng limited', '<p><strong><em>Nhẫn đầu rồng uy quyền </em></strong></p>\r\n<p><em>Loại: Nhẫn </em></p>\r\n<p><em>Chất liệu: Titan </em></p>\r\n<p><em>Khối lượng: 40g </em></p>\r\n<p><em>Xuất xứ: Mỹ </em></p>\r\n<p><em>Giấy ph&eacute;p: Đầy đủ </em></p>\r\n<p><em>Bảo h&agrave;nh: Trọn đời </em></p>\r\n<p><em>Miễn ph&iacute; đ&aacute;nh b&oacute;ng tại cửa h&agrave;ng</em></p>', 3499998, '2021-12-31 02:25:43', '2022-01-07 02:25:43', 31, 0),
(32, 'Áo da Addict Clothes', 5, 1, 500000, 100000, 'Áo da bò', '<p><strong><em>&Aacute;o da b&ograve; Nam Phi </em></strong></p>\r\n<p><em>Loại: Quần &aacute;o </em></p>\r\n<p><em>Chất liệu: Da b&ograve; 99% </em></p>\r\n<p><em>Xuất xứ: Nam Phi </em></p>\r\n<p><em>Size: M </em></p>\r\n<p><em>M&agrave;u: Đen</em></p>', 2150000, '2021-12-31 02:28:34', '2022-01-07 02:28:34', 32, 0),
(33, 'Áo len Addict Clothes ', 5, 1, 230000, 150000, 'Áo len vintage của Addict Clothes ', '<p>&Aacute;o len chống đệm tay Size: L M&agrave;u: Đen x&aacute;m Chất liệu: Len kết hợp da Xuất xứ: Trung Quốc N&ecirc;n ủi bằng b&agrave;n ủi hơi nước</p>', 1900000, '2021-12-31 02:30:32', '2022-01-07 02:30:32', 33, 0),
(34, 'Áo len Addict Clothes ', 5, 1, 230000, 150000, 'Áo len vintage của Addict Clothes ', '<p><strong><em>&Aacute;o len chống đệm tay </em></strong></p>\r\n<p><em>Size: L </em></p>\r\n<p><em>M&agrave;u: Đen x&aacute;m </em></p>\r\n<p><em>Chất liệu: Len kết hợp da </em></p>\r\n<p><em>Xuất xứ: Trung Quốc </em></p>\r\n<p><em>N&ecirc;n ủi bằng b&agrave;n ủi hơi nước</em></p>', 1900000, '2021-12-31 02:30:55', '2022-01-07 02:30:55', 34, 0),
(35, 'Quần Jeans vintage', 5, 3, 310000, 200000, 'Quần đã qua sử dụng ', '<p><strong><em>Quần Jeans cao bồi miền T&acirc;y </em></strong></p>\r\n<p><em>Loại: Quần &aacute;o </em></p>\r\n<p><em>Size: 30 </em></p>\r\n<p><em>M&agrave;u: Xanh đen</em></p>\r\n<p><em>Xuất xứ: Miền viễn t&acirc;y </em></p>\r\n<p><em>D&agrave;y dặn, t&eacute; kh&ocirc;ng r&aacute;ch</em></p>', 2400000, '2021-12-31 02:33:47', '2022-01-07 02:33:47', 35, 0),
(36, 'Nước ngọt Sprite Nhật ', 7, 1, 120000, 20000, 'Sản phẩm trong bộ sưu tập nước ngọt', '<p><strong><em>Lon nước chanh chua Sprite 340ml </em></strong></p>\r\n<p><em>Loại: Nước uống </em></p>\r\n<p><em>Thể t&iacute;ch: 340ml </em></p>\r\n<p><em>Nguy&ecirc;n liệu ch&iacute;nh: Soda, nước v&agrave; chanh </em></p>\r\n<p><em>Vỏ nh&ocirc;m m&agrave;u xanh chủ đạo </em></p>\r\n<p><em>Sản phẩm giới hạn to&agrave;n quốc</em></p>', 510000, '2021-12-31 02:36:26', '2022-01-07 02:36:26', 36, 0),
(37, 'Bia Premium malts Premium', 7, 1, 30000, 15000, 'Bia uống dô bị say', '<p><strong><em>Bia Premium malts đặc biệt </em></strong></p>\r\n<p><em>Thể t&iacute;ch: 330ml </em></p>\r\n<p><em>Nồng độ cồn: 5% </em></p>\r\n<p><em>Xuất xứ: Nhật Bản </em></p>\r\n<p><em>Sản xuất từ l&uacute;a mạch </em></p>\r\n<p><em>Vỏ: nh&ocirc;m, xanh dương </em></p>\r\n<p><em>Uống kh&ocirc;ng sau kh&ocirc;ng t&iacute;nh tiền</em></p>', 220000, '2021-12-31 02:38:46', '2022-01-07 02:38:46', 37, 0),
(38, 'Bánh ngọt HomeMade', 6, 1, 35000, 5000, 'Bánh rất ngon', '<p>B&aacute;nh ngọt tr&ograve;n vu&ocirc;ng</p>\r\n<p>M&agrave;u: V&agrave;ng, Đen</p>\r\n<p>Nguy&ecirc;n liệu: Bột m&igrave;, trứng g&agrave;</p>\r\n<p>Khối lượng: 200g</p>\r\n<p>Cung cấp 1000kalo</p>\r\n<p>HSD: 7 ng&agrave;y kể từ ng&agrave;y sản xuất</p>\r\n<p>NSX: In tr&ecirc;n bao b&igrave;a</p>', 115000, '2021-12-31 02:40:40', '2022-01-07 02:40:40', 38, 0),
(39, 'Bánh ngọt tổng hợp', 6, 1, 85000, 10000, 'Bánh để ăn', '<p><strong><em>Combo b&aacute;nh custom hoa quả </em></strong></p>\r\n<p><em>M&agrave;u sắc sống động </em></p>\r\n<p><em>Nguy&ecirc;n liệu: Hoa quả nhập khẩu từ Mỹ </em></p>\r\n<p><em>Số lượng: 6 b&aacute;nh </em></p>\r\n<p><em>Khối lượng 30g/1 b&aacute;nh </em></p>\r\n<p><em>Cung cấp: 200 kalo </em></p>\r\n<p><em>HSD: 7 ng&agrave;y kể từ ng&agrave;y sản xuất </em></p>\r\n<p><em>NSX: In tr&ecirc;n bao b&igrave;a</em></p>', 0, '2021-12-31 02:42:08', '2022-01-07 02:42:08', 39, 0),
(40, 'Bánh gato', 6, 3, 1000, 5000, 'Bánh mặn', '<p><strong><em>B&aacute;nh Gato ch&agrave; b&ocirc;ng </em></strong></p>\r\n<p><em>Nguy&ecirc;n liệu: Bột m&igrave;, trứng, ch&agrave; b&ocirc;ng </em></p>\r\n<p><em>Khối lượng: 100g </em></p>\r\n<p><em>Cung cấp: 100 kalo </em></p>\r\n<p><em>HSD: 7 ng&agrave;y kể từ ng&agrave;y sản xuất </em></p>\r\n<p><em>NSX: In tr&ecirc;n bao b&igrave;a</em></p>', 65000, '2021-12-31 02:43:43', '2022-01-07 02:43:43', 40, 0),
(41, 'Xe Airblade 150', 8, 1, 11000000, 1500000, 'Xe lưỡi dao chém gió', '<p><strong><em>Xe Airblade 150</em></strong></p>\r\n<p><em>Khối lượng 113kg </em></p>\r\n<p><em>D&agrave;i x Rộng x Cao Air Blade 150cc: 1.870mm x 686mm x 1.112mm </em></p>\r\n<p><em>Khoảng c&aacute;ch trục b&aacute;nh xe 1.286mm </em></p>\r\n<p><em>Độ cao y&ecirc;n&nbsp;Air Blade 150cc: 775mm </em></p>\r\n<p><em>Khoảng s&aacute;ng gầm xe 125mm </em></p>\r\n<p><em>Dung t&iacute;ch b&igrave;nh xăng 4,4 l&iacute;t</em></p><p>&nbsp;</p> <p>✏️ 31-12-2021</p><p>Xe đ&atilde; bị ăn trộm, kh&ocirc;ng c&ograve;n h&agrave;ng</p>', 55000000, '2021-12-31 02:48:15', '2022-01-07 02:48:15', 41, 0),
(42, 'Motor CB1000R', 8, 3, 15000000, 5000000, 'Xe để chạy', '<p><em>Khối lượng bản th&acirc;n 213 kg </em></p>\r\n<p><em>D&agrave;i x Rộng x Cao 2.120 x 789 x 1.090 mm </em></p>\r\n<p><em>Khoảng c&aacute;ch trục b&aacute;nh xe 1.455 mm </em></p>\r\n<p><em>Độ cao y&ecirc;n 830 mm </em></p>\r\n<p><em>Khoảng s&aacute;ng gầm xe 135 mm </em></p>\r\n<p><em>Dung t&iacute;ch b&igrave;nh xăng 16,2 l&iacute;t </em></p>\r\n<p><em>K&iacute;ch cỡ lốp trước/ sau Lốp trước: 120/70ZR17 Lốp sau: 190/55ZR17</em></p>', 350000000, '2021-12-31 02:50:57', '2022-01-07 02:50:57', 42, 0),
(43, 'CRV Car', 9, 1, 360000000, 25000000, 'Xe để đi chợ', '<p><em>Kiểu động cơ 1.5L DOHC VTEC TURBO, 4 xi-lanh thẳng h&agrave;ng, 16 van </em></p>\r\n<p><em>Hộp số V&ocirc; cấp CVT </em></p>\r\n<p><em>Dung t&iacute;ch xi lanh (cm3) 1.498 </em></p>\r\n<p><em>C&ocirc;ng suất cực đại (Hp/rpm) 188 (140 kW)/5.600 </em></p>\r\n<p><em>M&ocirc;-men xoắn cực đại (Nm/rpm) 240/2.000-5.000 </em></p>\r\n<p><em>Dung t&iacute;ch th&ugrave;ng nhi&ecirc;n liệu (L&iacute;t) 57 </em></p>\r\n<p><em>Hệ thống nhi&ecirc;n liệu Phun xăng điện tử/PGM-FI</em></p>', 0, '2021-12-31 02:53:35', '2021-12-31 02:53:35', 43, 2),
(44, 'Accord Car', 9, 1, 240000000, 20000000, 'Xe để di chuyển', '<div class=\"oIy2qc\" data-message-text=\"K&iacute;ch cỡ/Sizes	S, M, L, XL\r\nM&agrave;u sắc/Colors	Charcoal, Blue Ashes\r\nChất liệu khung/Frame	ALUXX-Grade Aluminum\r\nPhuộc/Fork	High-tensile steel, rack mount\r\nGiảm x&oacute;c/Shock	N/A\"><em>Số chỗ ngồi 7 </em></div>\r\n<div class=\"oIy2qc\" data-message-text=\"K&iacute;ch cỡ/Sizes	S, M, L, XL\r\nM&agrave;u sắc/Colors	Charcoal, Blue Ashes\r\nChất liệu khung/Frame	ALUXX-Grade Aluminum\r\nPhuộc/Fork	High-tensile steel, rack mount\r\nGiảm x&oacute;c/Shock	N/A\"><em>K&iacute;ch thước DxRxC(mm) 4.584 x 1.855 x 1.679 mm </em></div>\r\n<div class=\"oIy2qc\" data-message-text=\"K&iacute;ch cỡ/Sizes	S, M, L, XL\r\nM&agrave;u sắc/Colors	Charcoal, Blue Ashes\r\nChất liệu khung/Frame	ALUXX-Grade Aluminum\r\nPhuộc/Fork	High-tensile steel, rack mount\r\nGiảm x&oacute;c/Shock	N/A\"><em>Chiều d&agrave;i cơ sở 2660mm </em></div>\r\n<div class=\"oIy2qc\" data-message-text=\"K&iacute;ch cỡ/Sizes	S, M, L, XL\r\nM&agrave;u sắc/Colors	Charcoal, Blue Ashes\r\nChất liệu khung/Frame	ALUXX-Grade Aluminum\r\nPhuộc/Fork	High-tensile steel, rack mount\r\nGiảm x&oacute;c/Shock	N/A\"><em>Khoảng s&aacute;ng gầm 198mm</em></div>', 0, '2021-12-31 02:56:25', '2021-12-31 03:55:00', 44, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rating`
--

DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating` (
  `RateID` int(11) NOT NULL COMMENT 'ID phiếu đánh giá',
  `IdRated` int(11) NOT NULL COMMENT 'ID người được đánh giá',
  `IdRating` int(11) NOT NULL COMMENT 'ID người đánh giá',
  `IdProduct` int(11) NOT NULL COMMENT 'Mỗi sản phẩm chỉ được đánh giá một lần ',
  `Vote` int(11) NOT NULL COMMENT '0 = -1, 1 = +1 điểm vote',
  `FeedBack` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'Nội dung đánh giá',
  `Time` datetime NOT NULL COMMENT 'Thời gian đánh giá'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `rating`
--

INSERT INTO `rating` (`RateID`, `IdRated`, `IdRating`, `IdProduct`, `Vote`, `FeedBack`, `Time`) VALUES
(4, 3, 1, 44, 0, 'mua mà không trả tiền !!!', '2021-12-31 04:04:13');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `request`
--

DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
  `IdRequest` int(11) NOT NULL COMMENT 'ID của request',
  `IdBidder` int(11) NOT NULL COMMENT 'ID người gửi request'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `subcategory`
--

DROP TABLE IF EXISTS `subcategory`;
CREATE TABLE `subcategory` (
  `SubCatID` int(11) NOT NULL,
  `SubCatName` varchar(255) NOT NULL,
  `CatID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `subcategory`
--

INSERT INTO `subcategory` (`SubCatID`, `SubCatName`, `CatID`) VALUES
(1, 'Điện Thoại', 1),
(2, 'Laptop', 1),
(3, 'Máy Tính Bảng', 1),
(4, 'Trang Sức', 2),
(5, 'Quần Áo', 2),
(6, 'Bánh Kẹo', 3),
(7, 'Nước Uống', 3),
(8, 'Xe Máy', 4),
(9, 'Ô Tô', 4),
(10, 'Xe Đạp', 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `UserID` int(11) NOT NULL,
  `UserName` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Dob` datetime NOT NULL,
  `Permission` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`UserID`, `UserName`, `Name`, `Password`, `Address`, `Email`, `Dob`, `Permission`) VALUES
(1, 'doanhovy', 'Đoàn Hồ Vĩ', '$2a$12$XeyvEmNPBA2G/IGK5YOFDuQE9FWaA5QM6F16ZFUPXczl.6z5iBOVC', 'Canada', 'doanhovy188@gmail.com', '2001-01-29 00:00:00', 1),
(2, 'thanhnha', 'Mai Thanh Nhã', '$2a$12$mMrZw5dJeReoriwoxOM5IueI.VZuaR4/f4tGzzWG9yT45qzK/5Tee', 'Phú Yên', 'maithanhnha12345pyl@gmail.com', '2001-03-06 00:00:00', 0),
(3, 'phianh', 'Phạm Phi Anh', '$2a$12$x6riueB.Yn9MNzrM0881Ge43.Dc4bDsqBwvd37zLiGqM/LKUyEQoS', 'TP Hồ Chí Minh', 'phianh5@gmail.com', '2001-01-29 00:00:00', 1),
(4, 'hunganh', 'Lê Nguyễn Hùng Anh', '$2a$12$epMRpHKPthnwYlqV4zUM3eJCfb9312nqACZnQDnNAsWyW4XT6lonC', 'Vũng Tàu', 'lnha@gmail.com', '2001-01-29 00:00:00', 0),
(5, 'admin', 'Ad Văn Min', '$2a$12$WF7EcInHgtSis1KmnNot7OdaEqkNi86m9TGLFApAXmuMJF13.aNjO', 'America', 'nhamt@gmail.com', '2001-06-03 00:00:00', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `watchlist`
--

DROP TABLE IF EXISTS `watchlist`;
CREATE TABLE `watchlist` (
  `UserID` int(11) NOT NULL,
  `ProID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `ban`
--
ALTER TABLE `ban`
  ADD PRIMARY KEY (`BanID`),
  ADD KEY `ban_Bidder` (`BidderBannedID`) USING BTREE,
  ADD KEY `ban_Product` (`ProductID`);

--
-- Chỉ mục cho bảng `bid`
--
ALTER TABLE `bid`
  ADD PRIMARY KEY (`BidID`) USING BTREE,
  ADD KEY `bid_ibfk_1` (`BidderID`) USING BTREE,
  ADD KEY `bid_Product` (`ProductID`);

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`CatID`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ProID`) USING BTREE,
  ADD KEY `SellerID` (`SellerID`) USING BTREE,
  ADD KEY `SubCatID` (`SubCatID`) USING BTREE;
ALTER TABLE `product` ADD FULLTEXT KEY `ProName` (`ProName`,`TinyDes`,`FullDes`);

--
-- Chỉ mục cho bảng `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`RateID`),
  ADD KEY `rating_Bidder` (`IdRated`),
  ADD KEY `rating_Seller` (`IdRating`),
  ADD KEY `rating_Product` (`IdProduct`);

--
-- Chỉ mục cho bảng `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`IdRequest`),
  ADD KEY `request_Bidder` (`IdBidder`);

--
-- Chỉ mục cho bảng `subcategory`
--
ALTER TABLE `subcategory`
  ADD PRIMARY KEY (`SubCatID`) USING BTREE,
  ADD KEY `CatID` (`CatID`) USING BTREE;

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`) USING BTREE;

--
-- Chỉ mục cho bảng `watchlist`
--
ALTER TABLE `watchlist`
  ADD KEY `UserID` (`UserID`) USING BTREE,
  ADD KEY `ProID` (`ProID`) USING BTREE;

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `ban`
--
ALTER TABLE `ban`
  MODIFY `BanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `bid`
--
ALTER TABLE `bid`
  MODIFY `BidID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Bid', AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `CatID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `ProID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID sản phẩm', AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT cho bảng `rating`
--
ALTER TABLE `rating`
  MODIFY `RateID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID phiếu đánh giá', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `request`
--
ALTER TABLE `request`
  MODIFY `IdRequest` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID của request', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `subcategory`
--
ALTER TABLE `subcategory`
  MODIFY `SubCatID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `ban`
--
ALTER TABLE `ban`
  ADD CONSTRAINT `ban_bidderbanned` FOREIGN KEY (`BidderBannedID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `ban_product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProID`);

--
-- Các ràng buộc cho bảng `bid`
--
ALTER TABLE `bid`
  ADD CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`BidderID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `bid_product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProID`);

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`SellerID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `product_subcat` FOREIGN KEY (`SubCatID`) REFERENCES `subcategory` (`SubCatID`);

--
-- Các ràng buộc cho bảng `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_Bidder` FOREIGN KEY (`IdRated`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `rating_Product` FOREIGN KEY (`IdProduct`) REFERENCES `product` (`ProID`),
  ADD CONSTRAINT `rating_Seller` FOREIGN KEY (`IdRating`) REFERENCES `user` (`UserID`);

--
-- Các ràng buộc cho bảng `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `request_Bidder` FOREIGN KEY (`IdBidder`) REFERENCES `user` (`UserID`);

--
-- Các ràng buộc cho bảng `watchlist`
--
ALTER TABLE `watchlist`
  ADD CONSTRAINT `watchlist_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `watchlist_product` FOREIGN KEY (`ProID`) REFERENCES `product` (`ProID`);

DELIMITER $$
--
-- Sự kiện
--
DROP EVENT IF EXISTS `checkEndDateAuction`$$
CREATE DEFINER=`root`@`localhost` EVENT `checkEndDateAuction` ON SCHEDULE EVERY 1 SECOND STARTS '2021-12-29 22:10:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
CALL updateEndDateProductStatus;
CALL updateFailedAuctionProduct;
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
