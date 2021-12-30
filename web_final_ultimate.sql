-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 30, 2021 lúc 05:07 AM
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
CREATE TABLE IF NOT EXISTS `ban` (
  `BanID` int(11) NOT NULL AUTO_INCREMENT,
  `BidderBannedID` int(11) NOT NULL COMMENT 'ID của bidder bị ban',
  `ProductID` int(11) NOT NULL COMMENT 'ID của product mà bidder bị ban',
  PRIMARY KEY (`BanID`),
  KEY `ban_Bidder` (`BidderBannedID`) USING BTREE,
  KEY `ban_Product` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `ban`
--

INSERT INTO `ban` (`BanID`, `BidderBannedID`, `ProductID`) VALUES
(3, 3, 6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bid`
--

DROP TABLE IF EXISTS `bid`;
CREATE TABLE IF NOT EXISTS `bid` (
  `BidID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Bid',
  `BidderID` int(11) NOT NULL COMMENT 'ID người ra giá',
  `ProductID` int(11) NOT NULL COMMENT 'ID sản phẩm được ra giá',
  `Time` datetime NOT NULL COMMENT 'Thời gian ra giá',
  `MaxBid` bigint(20) NOT NULL COMMENT 'Giá tối đa người ra giá sẽ trả',
  PRIMARY KEY (`BidID`) USING BTREE,
  KEY `bid_ibfk_1` (`BidderID`) USING BTREE,
  KEY `bid_Product` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `bid`
--

INSERT INTO `bid` (`BidID`, `BidderID`, `ProductID`, `Time`, `MaxBid`) VALUES
(1, 4, 5, '2021-12-27 15:08:01', 50000000),
(2, 3, 5, '2021-12-27 09:09:18', 45000000),
(3, 1, 5, '2021-12-27 09:12:59', 40000000),
(4, 2, 5, '2021-12-27 09:14:25', 50300000),
(6, 4, 17, '2021-12-29 17:53:30', 11),
(7, 3, 17, '2021-12-29 17:56:02', 110),
(10, 258, 17, '2021-12-29 18:05:00', 1000),
(14, 258, 16, '2021-12-29 18:37:55', 213545),
(15, 258, 3, '2021-12-29 18:39:09', 9500000),
(16, 4, 3, '2021-12-29 18:40:18', 10000000),
(17, 3, 14, '2021-12-29 23:58:16', 213215346),
(18, 2, 6, '2021-12-30 00:08:05', 1000),
(20, 4, 6, '2021-12-30 02:32:19', 100000000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `CatID` int(11) NOT NULL AUTO_INCREMENT,
  `CatName` varchar(255) NOT NULL,
  PRIMARY KEY (`CatID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
CREATE TABLE IF NOT EXISTS `product` (
  `ProID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID sản phẩm',
  `ProName` varchar(255) NOT NULL COMMENT 'Tên sản phẩm',
  `SubCatID` int(11) NOT NULL COMMENT 'ID subcategory',
  `SellerID` int(11) NOT NULL COMMENT 'ID người đăng sản phẩm',
  `StartPrice` bigint(11) NOT NULL COMMENT 'Giá khởi điểm',
  `StepPrice` bigint(11) NOT NULL COMMENT 'Bước giá',
  `TinyDes` varchar(255) NOT NULL COMMENT 'Mô tả ngắn gọn',
  `FullDes` varchar(1500) NOT NULL COMMENT 'Mô tả chi tiết',
  `Bin` bigint(20) DEFAULT NULL COMMENT 'giá mua ngay',
  `UploadDate` datetime NOT NULL COMMENT 'Thời gian đăng sản phẩm',
  `EndDate` datetime NOT NULL COMMENT 'Thời gian kết thúc đấu giá',
  `ImgIndex` int(11) NOT NULL COMMENT 'Tên thư mục chứa ảnh',
  `Status` int(11) NOT NULL DEFAULT 0 COMMENT '0 - đang đấu giá, 1 - đấu giá thành công, 2 - đấu giá thất bại\r\n',
  PRIMARY KEY (`ProID`) USING BTREE,
  KEY `SellerID` (`SellerID`) USING BTREE,
  KEY `SubCatID` (`SubCatID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`ProID`, `ProName`, `SubCatID`, `SellerID`, `StartPrice`, `StepPrice`, `TinyDes`, `FullDes`, `Bin`, `UploadDate`, `EndDate`, `ImgIndex`, `Status`) VALUES
(1, 'Ấm cổ', 1, 1, 0, 0, 'Đồ cổ rất cổ', 'Đồ cổ này đã có từ thời Ai Cập cổ đại với những đường nét thiết kế rất đặc trưng', 100000000, '2022-01-26 00:00:00', '2022-02-02 00:00:00', 0, 0),
(2, 'Xiaomi Redmi Note 10', 3, 1, 0, 0, 'Điện thoại hiện đại', 'Điện thoại mới được ra mắt với những tính năng mới', 5000000, '2022-02-15 00:00:00', '2021-12-29 07:00:00', 0, 2),
(3, 'Quần siêu đẹp', 5, 1, 0, 1000000, 'Quần Gucci', 'Được may thủ công từ nhà thiết kế nổi tiếng hàng đầu thế giới', 10000000, '2021-12-30 00:00:00', '2021-12-29 22:11:00', 0, 1),
(4, 'Cải thiện cuộc sống với thần số học', 7, 1, 0, 0, 'Một cuốn sách tuyệt vời', 'Sách nói về những bí mật của con số đối với vận mệnh con người', 50000, '2022-01-14 00:00:00', '2022-01-21 00:00:00', 0, 0),
(5, 'Bếp thông minh', 9, 1, 15000000, 500000, 'Một chiếc bếp hiện đại', 'Tiết kiệm sức lực con người với một chiếc bếp thông minh hoàn toàn mới', 30000000, '2022-02-28 00:00:00', '2021-12-29 22:11:00', 0, 1),
(6, 'Căn hộ Vinhome', 11, 1, 0, 0, 'Căn hộ hiện đại', 'Một cuộc sống hoàn toàn mới tại khu đô thị xa hoa bậc nhất TPHCM', 8000000000, '2022-01-03 00:00:00', '2022-01-10 00:00:00', 0, 0),
(7, 'Honda Airblade', 13, 1, 0, 0, 'Honda Airblade 2020', 'Nâng tầm trải nghiệm với những công nghệ hoàn toàn mới', 32000000, '2022-02-11 00:00:00', '2022-02-18 00:00:00', 0, 0),
(8, 'Chén cổ', 2, 1, 0, 0, 'Đồ cổ rất cổ', 'Đồ cổ này đã có từ thời Ai Cập cổ đại với những đường nét thiết kế rất đặc trưng', 100000000, '2022-01-26 00:00:00', '2022-02-02 00:00:00', 0, 0),
(14, 'Bình Gốm', 1, 4, 12135, 21, 'Bình gốm víp pờ rồ đã sửa 123', '<p>asdasda dasd asd ASd ASd asd</p><p>&nbsp;</p> <p>✏️ 29-12-2021</p> <p>&nbsp;</p><p>sản phẩm đ&atilde; <strong><span style=\"color: #ba372a;\">hết h&agrave;ng</span></strong></p><p>&nbsp;</p> <p>✏️ 29-12-2021</p><p>alo <em>alo <span style=\"background-color: #e03e2d;\">123</span></em></p>', 213215346, '2021-12-28 16:51:01', '2022-01-04 16:51:01', 9, 1),
(15, 'Bình Gốm', 1, 4, 121, 21, 'Bình gốm víp pờ rồ', '<p>asdasda dasd asd ASd ASd asd</p>', 213215346, '2021-12-28 16:52:17', '2021-12-29 22:00:00', 15, 2),
(16, 'Bình Gốm', 1, 4, 1231, 2, 'Bình áhjdio ád', '<p>asdasdas das das&nbsp;</p>', 213545, '2021-12-28 16:55:50', '2022-01-04 16:55:50', 16, 1),
(17, 'Bình Gốm Pha ke', 1, 4, 10, 1, 'bla', '<p>&nbsp; &nbsp; &nbsp;&nbsp;</p>\n<p>✏️ 31/10/2019</p>\n<p>&nbsp; &nbsp; &nbsp; &nbsp;</p>', 1000, '2021-12-29 13:08:07', '2022-01-05 13:08:07', 17, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rating`
--

DROP TABLE IF EXISTS `rating`;
CREATE TABLE IF NOT EXISTS `rating` (
  `RateID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID phiếu đánh giá',
  `IdRated` int(11) NOT NULL COMMENT 'ID người được đánh giá',
  `IdRating` int(11) NOT NULL COMMENT 'ID người đánh giá',
  `IdProduct` int(11) NOT NULL COMMENT 'Mỗi sản phẩm chỉ được đánh giá một lần ',
  `Vote` int(11) NOT NULL COMMENT '0 = -1, 1 = +1 điểm vote',
  `FeedBack` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'Nội dung đánh giá',
  `Time` datetime NOT NULL COMMENT 'Thời gian đánh giá',
  PRIMARY KEY (`RateID`),
  KEY `rating_Bidder` (`IdRated`),
  KEY `rating_Seller` (`IdRating`),
  KEY `rating_Product` (`IdProduct`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `rating`
--

INSERT INTO `rating` (`RateID`, `IdRated`, `IdRating`, `IdProduct`, `Vote`, `FeedBack`, `Time`) VALUES
(1, 3, 4, 5, 0, 'alo alo', '2021-12-30 00:38:20'),
(2, 3, 2, 15, 1, 'oke', '2021-12-30 00:38:43'),
(3, 3, 1, 2, 1, 'very good', '2021-12-30 00:39:04');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `request`
--

DROP TABLE IF EXISTS `request`;
CREATE TABLE IF NOT EXISTS `request` (
  `IdRequest` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID của request',
  `IdBidder` int(11) NOT NULL COMMENT 'ID người gửi request',
  PRIMARY KEY (`IdRequest`),
  KEY `request_Bidder` (`IdBidder`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

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
CREATE TABLE IF NOT EXISTS `subcategory` (
  `SubCatID` int(11) NOT NULL AUTO_INCREMENT,
  `SubCatName` varchar(255) NOT NULL,
  `CatID` int(11) NOT NULL,
  PRIMARY KEY (`SubCatID`) USING BTREE,
  KEY `CatID` (`CatID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
CREATE TABLE IF NOT EXISTS `user` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Dob` datetime NOT NULL,
  `Permission` int(11) NOT NULL,
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`UserID`, `UserName`, `Name`, `Password`, `Address`, `Email`, `Dob`, `Permission`) VALUES
(1, 'user1', 'Mylie Hodges', '$2a$12$mUVR9CRHpBiXfESZuu/4QeRRNw.AxEmt2ZZ1uXZXtu2bAKEHtgViK\n', '', 'user1@gmail.com', '1995-09-01 00:00:00', 0),
(2, 'user2', 'Maiya Bannister', '$2a$12$flU9aE1ez0EAE2fMyjCq9O1IzefrsEImjlpLfraaDOkLnXVHdnTsK\n', '', 'user2@gmail.com', '1999-03-13 00:00:00', 0),
(3, 'doanhovy', 'Doan Ho Vi', '$2a$12$xjveCD1BhcAw3S67ESSOROGQuj97a4Lh58FtsxsEMmyfF8VyTrBIi\n', 'Binh Duong', 'doanhovy188@gmail.com', '2001-08-18 00:00:00', 0),
(4, 'testlogin', 'test1', '$2a$12$FKL10g5ajOvu0r54pDMGXuuVvwEs9irLMsiTvqZL638wHkeQd2MbG\n', 'BD', 'mothaiba@gmail.com', '2021-12-26 17:23:38', 1),
(258, 'testregister', 'alo', '$2a$12$WP8gKbYGGaVde9NS7EwK1u4ZvScc1h6rcs1s3myKWCElL30NK8o3e', 'TP HCM', 'test@gmail.com', '2001-12-11 00:00:00', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `watchlist`
--

DROP TABLE IF EXISTS `watchlist`;
CREATE TABLE IF NOT EXISTS `watchlist` (
  `UserID` int(11) NOT NULL,
  `ProID` int(11) NOT NULL,
  KEY `UserID` (`UserID`) USING BTREE,
  KEY `ProID` (`ProID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Đang đổ dữ liệu cho bảng `watchlist`
--

INSERT INTO `watchlist` (`UserID`, `ProID`) VALUES
(4, 6),
(4, 7),
(4, 3),
(3, 1),
(3, 2),
(258, 14),
(258, 3);

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

--
-- Fulltext search cho bảng `product`
--
Alter table product add fulltext(ProName,TinyDes,FullDes);


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
