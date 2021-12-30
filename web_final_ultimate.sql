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
