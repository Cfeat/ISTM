-- 更新class_plan表结构以适应现有的后端模型
ALTER TABLE `class_plan` CHANGE `plan_name` `title` varchar(255) NOT NULL COMMENT '教案标题';
ALTER TABLE `class_plan` ADD COLUMN `people_count` int DEFAULT '0' COMMENT '适用人数' AFTER `downloads`;
ALTER TABLE `class_plan` ADD COLUMN `grade` varchar(20) DEFAULT NULL COMMENT '适用年级' AFTER `plan_type`;
ALTER TABLE `class_plan` CHANGE `plan_desc` `content` text COMMENT '教案内容';
ALTER TABLE `class_plan` CHANGE `plan_purpose` `note1` text COMMENT '教学目标';
ALTER TABLE `class_plan` CHANGE `plan_process` `note2` text COMMENT '教学过程';
ALTER TABLE `class_plan` CHANGE `cover_img` `avatar` varchar(255) DEFAULT NULL COMMENT '封面图片地址';
ALTER TABLE `class_plan` ADD COLUMN `note3` varchar(255) DEFAULT NULL COMMENT '备用字段';

