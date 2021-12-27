-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 27, 2021 lúc 03:39 PM
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
(1, 4, 5, '2021-12-27 15:08:01', 50000000),
(2, 3, 5, '2021-12-27 09:09:18', 45000000),
(3, 1, 5, '2021-12-27 09:12:59', 40000000),
(4, 2, 5, '2021-12-27 09:14:25', 50300000);

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
(1, 'Đồ cổ'),
(2, 'Đồ điện tử'),
(3, 'Thời trang'),
(4, 'Sách'),
(5, 'Đồ gia dụng'),
(6, 'Bất động sản'),
(7, 'Phương tiện');

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
  `FullDes` varchar(255) NOT NULL COMMENT 'Mô tả chi tiết',
  `Bin` bigint(20) DEFAULT NULL COMMENT 'giá mua ngay',
  `UploadDate` datetime NOT NULL COMMENT 'Thời gian đăng sản phẩm',
  `EndDate` datetime NOT NULL COMMENT 'Thời gian kết thúc đấu giá',
  `ImgIndex` int(11) NOT NULL COMMENT 'Tên ảnh',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '0 - đang đấu giá, 1 - đấu giá thành công, 2 - đấu giá thất bại\r\n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`ProID`, `ProName`, `SubCatID`, `SellerID`, `StartPrice`, `StepPrice`, `TinyDes`, `FullDes`, `Bin`, `UploadDate`, `EndDate`, `ImgIndex`, `Status`) VALUES
(1, 'Ấm cổ', 1, 1, 0, 0, 'Đồ cổ rất cổ', 'Đồ cổ này đã có từ thời Ai Cập cổ đại với những đường nét thiết kế rất đặc trưng', 100000000, '2022-01-26 00:00:00', '2022-02-02 00:00:00', 0, 0),
(2, 'Xiaomi Redmi Note 10', 3, 1, 0, 0, 'Điện thoại hiện đại', 'Điện thoại mới được ra mắt với những tính năng mới', 5000000, '2022-02-15 00:00:00', '2022-02-22 00:00:00', 0, 0),
(3, 'Quần siêu đẹp', 5, 1, 0, 0, 'Quần Gucci', 'Được may thủ công từ nhà thiết kế nổi tiếng hàng đầu thế giới', 10000000, '2021-12-30 00:00:00', '2022-01-06 00:00:00', 0, 0),
(4, 'Cải thiện cuộc sống với thần số học', 7, 1, 0, 0, 'Một cuốn sách tuyệt vời', 'Sách nói về những bí mật của con số đối với vận mệnh con người', 50000, '2022-01-14 00:00:00', '2022-01-21 00:00:00', 0, 0),
(5, 'Bếp thông minh', 9, 1, 15000000, 500000, 'Một chiếc bếp hiện đại', 'Tiết kiệm sức lực con người với một chiếc bếp thông minh hoàn toàn mới', 30000000, '2022-02-28 00:00:00', '2022-03-07 00:00:00', 0, 0),
(6, 'Căn hộ Vinhome', 11, 1, 0, 0, 'Căn hộ hiện đại', 'Một cuộc sống hoàn toàn mới tại khu đô thị xa hoa bậc nhất TPHCM', 8000000000, '2022-01-03 00:00:00', '2022-01-10 00:00:00', 0, 0),
(7, 'Honda Airblade', 13, 1, 0, 0, 'Honda Airblade 2020', 'Nâng tầm trải nghiệm với những công nghệ hoàn toàn mới', 32000000, '2022-02-11 00:00:00', '2022-02-18 00:00:00', 0, 0),
(8, 'Chén cổ', 2, 1, 0, 0, 'Đồ cổ rất cổ', 'Đồ cổ này đã có từ thời Ai Cập cổ đại với những đường nét thiết kế rất đặc trưng', 100000000, '2022-01-26 00:00:00', '2022-02-02 00:00:00', 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rating`
--

DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating` (
  `RateID` int(11) NOT NULL COMMENT 'ID phiếu đánh giá',
  `IdBidder` int(11) NOT NULL COMMENT 'ID người được đánh giá',
  `IdSeller` int(11) NOT NULL COMMENT 'ID người đánh giá',
  `Vote` bit(1) NOT NULL COMMENT 'đánh giá +1 hay -1 cho bidder',
  `FeedBack` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Nội dung đánh giá'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `rating`
--

INSERT INTO `rating` (`RateID`, `IdBidder`, `IdSeller`, `Vote`, `FeedBack`) VALUES
(1, 2, 4, b'0', 'Người thắng không thanh toán');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `request`
--

DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
  `IdRequest` int(11) NOT NULL COMMENT 'ID của request',
  `IdBidder` int(11) NOT NULL COMMENT 'ID người gửi request'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `request`
--

INSERT INTO `request` (`IdRequest`, `IdBidder`) VALUES
(1, 1),
(2, 3);

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
(1, 'Đồ cổ loại 1', 1),
(2, 'Đồ cổ loại 2', 1),
(3, 'Đồ điện tử loại 1', 2),
(4, 'Đồ điện tử loại 2', 2),
(5, 'Thời trang loại 1', 3),
(6, 'Thời trang loại 2', 3),
(7, 'Sách loại 1', 4),
(8, 'Sách loại 2', 4),
(9, 'Đồ gia dụng loại 1', 5),
(10, 'Đồ gia dụng loại 2', 5),
(11, 'Bất động sản loại 1', 6),
(12, 'Bất động sản loại 2', 6),
(13, 'Phương tiện loại 1', 7),
(14, 'Phương tiện loại 2', 7);

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
(1, 'user1', 'Mylie Hodges', '$2a$12$mUVR9CRHpBiXfESZuu/4QeRRNw.AxEmt2ZZ1uXZXtu2bAKEHtgViK\n', '', 'user1@gmail.com', '1995-09-01 00:00:00', 0),
(2, 'user2', 'Maiya Bannister', '$2a$12$flU9aE1ez0EAE2fMyjCq9O1IzefrsEImjlpLfraaDOkLnXVHdnTsK\n', '', 'user2@gmail.com', '1999-03-13 00:00:00', 0),
(3, 'doanhovy', 'Doan Ho Vi', '$2a$12$xjveCD1BhcAw3S67ESSOROGQuj97a4Lh58FtsxsEMmyfF8VyTrBIi\n', 'Binh Duong', 'doanhovy188@gmail.com', '2001-08-18 00:00:00', 0),
(4, 'testlogin', 'test1', '$2a$12$FKL10g5ajOvu0r54pDMGXuuVvwEs9irLMsiTvqZL638wHkeQd2MbG\n', 'BD', 'mothaiba@gmail.com', '2021-12-26 17:23:38', 2),
(258, 'testregister', 'alo', '$2a$12$WP8gKbYGGaVde9NS7EwK1u4ZvScc1h6rcs1s3myKWCElL30NK8o3e', 'TP HCM', 'test@gmail.com', '2001-12-11 00:00:00', 0);

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
-- Đang đổ dữ liệu cho bảng `watchlist`
--

INSERT INTO `watchlist` (`UserID`, `ProID`) VALUES
(4, 6),
(4, 7),
(4, 3),
(3, 1),
(3, 2);

--
-- Chỉ mục cho các bảng đã đổ
--

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

--
-- Chỉ mục cho bảng `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`RateID`),
  ADD KEY `rating_Bidder` (`IdBidder`),
  ADD KEY `rating_Seller` (`IdSeller`);

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
-- AUTO_INCREMENT cho bảng `bid`
--
ALTER TABLE `bid`
  MODIFY `BidID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Bid', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `CatID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `ProID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID sản phẩm', AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `rating`
--
ALTER TABLE `rating`
  MODIFY `RateID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID phiếu đánh giá', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `request`
--
ALTER TABLE `request`
  MODIFY `IdRequest` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID của request', AUTO_INCREMENT=3;

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
  ADD CONSTRAINT `rating_Bidder` FOREIGN KEY (`IdBidder`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `rating_Seller` FOREIGN KEY (`IdSeller`) REFERENCES `user` (`UserID`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
