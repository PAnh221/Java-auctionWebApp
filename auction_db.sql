/*
 Navicat Premium Data Transfer

 Source Server         : finalproject
 Source Server Type    : MySQL
 Source Server Version : 100420
 Source Host           : localhost:3306
 Source Schema         : ecauctionwebapp

 Target Server Type    : MySQL
 Target Server Version : 100420
 File Encoding         : 65001

 Date: 18/12/2021 12:20:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auction
-- ----------------------------
DROP TABLE IF EXISTS `auction`;
CREATE TABLE `auction`  (
  `AuctionID` int NOT NULL,
  `ProID` int NOT NULL,
  `StartPrice` bigint NOT NULL,
  `CurrentPrice` bigint NOT NULL,
  `StepPrice` bigint NOT NULL,
  `BidCount` int NOT NULL,
  `CurrentBid` int NULL DEFAULT NULL,
  PRIMARY KEY (`AuctionID`) USING BTREE,
  INDEX `ProID`(`ProID`) USING BTREE,
  INDEX `CurrentBid`(`CurrentBid`) USING BTREE,
  CONSTRAINT `auction_ibfk_1` FOREIGN KEY (`ProID`) REFERENCES `product` (`ProID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auction
-- ----------------------------

-- ----------------------------
-- Table structure for bid
-- ----------------------------
DROP TABLE IF EXISTS `bid`;
CREATE TABLE `bid`  (
  `BidID` int NOT NULL,
  `AuctionID` int NOT NULL,
  `BidderID` int NOT NULL,
  `BidAmount` bigint NOT NULL,
  `Time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MaxBid` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`BidID`) USING BTREE,
  INDEX `AuctionID`(`AuctionID`) USING BTREE,
  INDEX `bid_ibfk_1`(`BidderID`) USING BTREE,
  CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`BidderID`) REFERENCES `user` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`AuctionID`) REFERENCES `auction` (`AuctionID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bid_ibfk_3` FOREIGN KEY (`BidID`) REFERENCES `bidlog` (`bidID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bid
-- ----------------------------

-- ----------------------------
-- Table structure for bidlog
-- ----------------------------
DROP TABLE IF EXISTS `Bidlog`;
CREATE TABLE `bidlog`  (
  `BidID` int NOT NULL,
  `BidPrice` bigint NULL DEFAULT NULL,
  `BidTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`BidID`) USING BTREE,
  CONSTRAINT `bidlog_ibfk_1` FOREIGN KEY (`BidID`) REFERENCES `auction` (`CurrentBid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bidlog
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `CatID` int NOT NULL,
  `CatName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`CatID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'Đồ cổ');
INSERT INTO `category` VALUES (2, 'Đồ điện tử');
INSERT INTO `category` VALUES (3, 'Thời trang');
INSERT INTO `category` VALUES (4, 'Sách');
INSERT INTO `category` VALUES (5, 'Đồ gia dụng');
INSERT INTO `category` VALUES (6, 'Bất động sản');
INSERT INTO `category` VALUES (7, 'Phương tiện');

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `ProID` int NOT NULL,
  `ProName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SubCatID` int NOT NULL,
  `SellerID` int NOT NULL,
  `TinyDes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FullDes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Bin` bigint NOT NULL COMMENT 'giá mua ngay',
  `UploadDate` datetime NOT NULL,
  `CatID` int NOT NULL,
  `ImgIndex` int NULL DEFAULT NULL,
  PRIMARY KEY (`ProID`) USING BTREE,
  INDEX `SellerID`(`SellerID`) USING BTREE,
  INDEX `SubCatID`(`SubCatID`) USING BTREE,
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`SellerID`) REFERENCES `user` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`SubCatID`) REFERENCES `subcategory` (`SubCatID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `product` VALUES (1, 'Ấm cổ', 1, 1, 'Đồ cổ rất cổ', 'Đồ cổ này đã có từ thời Ai Cập cổ đại với những đường nét thiết kế rất đặc trưng', 100000000, '2021-11-26', 1, NULL);
INSERT INTO `product` VALUES (2, 'Xiaomi Redmi Note 10', 3, 1, 'Điện thoại hiện đại', 'Điện thoại mới được ra mắt với những tính năng mới', 5000000, '2021-11-26', 2, NULL);
INSERT INTO `product` VALUES (3, 'Quần siêu đẹp', 5, 1, 'Quần Gucci', 'Được may thủ công từ nhà thiết kế nổi tiếng hàng đầu thế giới', 10000000, '2021-11-26', 3, NULL);
INSERT INTO `product` VALUES (4, 'Cải thiện cuộc sống với thần số học', 7, 1, 'Một cuốn sách tuyệt vời', 'Sách nói về những bí mật của con số đối với vận mệnh con người', 50000, '2021-11-26', 4, NULL);
INSERT INTO `product` VALUES (5, 'Bếp thông minh', 9, 1, 'Một chiếc bếp hiện đại', 'Tiết kiệm sức lực con người với một chiếc bếp thông minh hoàn toàn mới', 30000000, '2021-11-26', 5, NULL);
INSERT INTO `product` VALUES (6, 'Căn hộ Vinhome', 11, 1, 'Căn hộ hiện đại', 'Một cuộc sống hoàn toàn mới tại khu đô thị xa hoa bậc nhất TPHCM', 8000000000, '2021-11-26', 6, NULL);
INSERT INTO `product` VALUES (7, 'Honda Airblade', 13, 1, 'Honda Airblade 2020', 'Nâng tầm trải nghiệm với những công nghệ hoàn toàn mới', 32000000, '2021-11-26', 7, NULL);

-- ----------------------------
-- Table structure for subcategory
-- ----------------------------
DROP TABLE IF EXISTS `subcategory`;
CREATE TABLE `subcategory`  (
  `SubCatID` int NOT NULL,
  `SubCatName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CatID` int NOT NULL,
  PRIMARY KEY (`SubCatID`) USING BTREE,
  INDEX `CatID`(`CatID`) USING BTREE,
  CONSTRAINT `subcategory_ibfk_1` FOREIGN KEY (`CatID`) REFERENCES `Category` (`CatID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subcategory
-- ----------------------------
INSERT INTO `subcategory` VALUES (1, 'Đồ cổ loại 1', 1);
INSERT INTO `subcategory` VALUES (2, 'Đồ cổ loại 2', 1);
INSERT INTO `subcategory` VALUES (3, 'Đồ điện tử loại 1', 2);
INSERT INTO `subcategory` VALUES (4, 'Đồ điện tử loại 2', 2);
INSERT INTO `subcategory` VALUES (5, 'Thời trang loại 1', 3);
INSERT INTO `subcategory` VALUES (6, 'Thời trang loại 2', 3);
INSERT INTO `subcategory` VALUES (7, 'Sách loại 1', 4);
INSERT INTO `subcategory` VALUES (8, 'Sách loại 2', 4);
INSERT INTO `subcategory` VALUES (9, 'Đồ gia dụng loại 1', 5);
INSERT INTO `subcategory` VALUES (10, 'Đồ gia dụng loại 2', 5);
INSERT INTO `subcategory` VALUES (11, 'Bất động sản loại 1', 6);
INSERT INTO `subcategory` VALUES (12, 'Bất động sản loại 2', 6);
INSERT INTO `subcategory` VALUES (13, 'Phương tiện loại 1', 7);
INSERT INTO `subcategory` VALUES (14, 'Phương tiện loại 2', 7);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Dob` datetime NOT NULL,
  `Permission` int NOT NULL,
  `Rating` int NOT NULL,
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'user1', 'Mylie Hodges', '123456789', '', 'user1@gmail.com', '1995-09-01', 0, 10);
INSERT INTO `user` VALUES (2, 'user2', 'Maiya Bannister', '987654321', '', 'user2@gmail.com', '1999-03-13', 0, 10);

-- watchlist
DROP TABLE IF EXISTS `watchlist`;
CREATE TABLE `watchlist`  (
  `UserID` int NOT NULL,
  `ProID` int NOT NULL,

  INDEX `UserID`(`UserID`) USING BTREE,
  INDEX `ProID`(`ProID`) USING BTREE,
  CONSTRAINT `watchlist_ibfk_1` FOREIGN KEY (`ProID`) REFERENCES `product` (`ProID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `watchlist_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;


SET FOREIGN_KEY_CHECKS = 1;
