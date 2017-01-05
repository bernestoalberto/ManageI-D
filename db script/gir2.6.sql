

CREATE TABLE `gir_assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set parent.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `level` int(10) unsigned NOT NULL COMMENT 'The cached level in the nested tree.',
  `name` varchar(50) NOT NULL COMMENT 'The unique name for the asset.\n',
  `title` varchar(100) NOT NULL COMMENT 'The descriptive title for the asset.',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_name` (`name`),
  KEY `idx_lft_rgt` (`lft`,`rgt`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_associations` table : 
#

DROP TABLE IF EXISTS `gir_associations`;

CREATE TABLE `gir_associations` (
  `id` int(11) NOT NULL COMMENT 'A reference to the associated item.',
  `context` varchar(50) NOT NULL COMMENT 'The context of the associated item.',
  `key` char(32) NOT NULL COMMENT 'The key for the association computed from an md5 on associated ids.',
  PRIMARY KEY (`context`,`id`),
  KEY `idx_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_banner_clients` table : 
#

DROP TABLE IF EXISTS `gir_banner_clients`;

CREATE TABLE `gir_banner_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `contact` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `extrainfo` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `metakey` text NOT NULL,
  `own_prefix` tinyint(4) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_banner_tracks` table : 
#

DROP TABLE IF EXISTS `gir_banner_tracks`;

CREATE TABLE `gir_banner_tracks` (
  `track_date` datetime NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`track_date`,`track_type`,`banner_id`),
  KEY `idx_track_date` (`track_date`),
  KEY `idx_track_type` (`track_type`),
  KEY `idx_banner_id` (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_banners` table : 
#

DROP TABLE IF EXISTS `gir_banners`;

CREATE TABLE `gir_banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `imptotal` int(11) NOT NULL DEFAULT '0',
  `impmade` int(11) NOT NULL DEFAULT '0',
  `clicks` int(11) NOT NULL DEFAULT '0',
  `clickurl` varchar(200) NOT NULL DEFAULT '',
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `custombannercode` varchar(2048) NOT NULL,
  `sticky` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `params` text NOT NULL,
  `own_prefix` tinyint(1) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reset` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` char(7) NOT NULL DEFAULT '',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`),
  KEY `idx_banner_catid` (`catid`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_categories` table : 
#

DROP TABLE IF EXISTS `gir_categories`;

CREATE TABLE `gir_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '',
  `extension` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `metadesc` varchar(1024) NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `cat_idx` (`extension`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_contact_details` table : 
#

DROP TABLE IF EXISTS `gir_contact_details`;

CREATE TABLE `gir_contact_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `con_position` varchar(255) DEFAULT NULL,
  `address` text,
  `suburb` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `misc` mediumtext,
  `image` varchar(255) DEFAULT NULL,
  `email_to` varchar(255) DEFAULT NULL,
  `default_con` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `catid` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `mobile` varchar(255) NOT NULL DEFAULT '',
  `webpage` varchar(255) NOT NULL DEFAULT '',
  `sortname1` varchar(255) NOT NULL,
  `sortname2` varchar(255) NOT NULL,
  `sortname3` varchar(255) NOT NULL,
  `language` char(7) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_content` table : 
#

DROP TABLE IF EXISTS `gir_content`;

CREATE TABLE `gir_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `title` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` varchar(5120) NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `language` char(7) NOT NULL COMMENT 'The language code for the article.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_content_frontpage` table : 
#

DROP TABLE IF EXISTS `gir_content_frontpage`;

CREATE TABLE `gir_content_frontpage` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_content_rating` table : 
#

DROP TABLE IF EXISTS `gir_content_rating`;

CREATE TABLE `gir_content_rating` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `rating_sum` int(10) unsigned NOT NULL DEFAULT '0',
  `rating_count` int(10) unsigned NOT NULL DEFAULT '0',
  `lastip` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_content_types` table : 
#

DROP TABLE IF EXISTS `gir_content_types`;

CREATE TABLE `gir_content_types` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_title` varchar(255) NOT NULL DEFAULT '',
  `type_alias` varchar(255) NOT NULL DEFAULT '',
  `table` varchar(255) NOT NULL DEFAULT '',
  `rules` text NOT NULL,
  `field_mappings` text NOT NULL,
  `router` varchar(255) NOT NULL DEFAULT '',
  `content_history_options` varchar(5120) DEFAULT NULL COMMENT 'JSON string for com_contenthistory options',
  PRIMARY KEY (`type_id`),
  KEY `idx_alias` (`type_alias`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_contentitem_tag_map` table : 
#

DROP TABLE IF EXISTS `gir_contentitem_tag_map`;

CREATE TABLE `gir_contentitem_tag_map` (
  `type_alias` varchar(255) NOT NULL DEFAULT '',
  `core_content_id` int(10) unsigned NOT NULL COMMENT 'PK from the core content table',
  `content_item_id` int(11) NOT NULL COMMENT 'PK from the content type table',
  `tag_id` int(10) unsigned NOT NULL COMMENT 'PK from the tag table',
  `tag_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of most recent save for this tag-item',
  `type_id` mediumint(8) NOT NULL COMMENT 'PK from the content_type table',
  UNIQUE KEY `uc_ItemnameTagid` (`type_id`,`content_item_id`,`tag_id`),
  KEY `idx_tag_type` (`tag_id`,`type_id`),
  KEY `idx_date_id` (`tag_date`,`tag_id`),
  KEY `idx_tag` (`tag_id`),
  KEY `idx_type` (`type_id`),
  KEY `idx_core_content_id` (`core_content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps items from content tables to tags';

#
# Structure for the `gir_core_log_searches` table : 
#

DROP TABLE IF EXISTS `gir_core_log_searches`;

CREATE TABLE `gir_core_log_searches` (
  `search_term` varchar(128) NOT NULL DEFAULT '',
  `hits` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_csoap_webservices` table : 
#

DROP TABLE IF EXISTS `gir_csoap_webservices`;

CREATE TABLE `gir_csoap_webservices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` tinyint(4) NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_createdby` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_extensions` table : 
#

DROP TABLE IF EXISTS `gir_extensions`;

CREATE TABLE `gir_extensions` (
  `extension_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `element` varchar(100) NOT NULL,
  `folder` varchar(100) NOT NULL,
  `client_id` tinyint(3) NOT NULL,
  `enabled` tinyint(3) NOT NULL DEFAULT '1',
  `access` int(10) unsigned NOT NULL DEFAULT '1',
  `protected` tinyint(3) NOT NULL DEFAULT '0',
  `manifest_cache` text NOT NULL,
  `params` text NOT NULL,
  `custom_data` text NOT NULL,
  `system_data` text NOT NULL,
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`extension_id`),
  KEY `element_clientid` (`element`,`client_id`),
  KEY `element_folder_clientid` (`element`,`folder`,`client_id`),
  KEY `extension` (`type`,`element`,`folder`,`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10086 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_filters` table : 
#

DROP TABLE IF EXISTS `gir_finder_filters`;

CREATE TABLE `gir_finder_filters` (
  `filter_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL,
  `created_by_alias` varchar(255) NOT NULL,
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `map_count` int(10) unsigned NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `params` mediumtext,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links` table : 
#

DROP TABLE IF EXISTS `gir_finder_links`;

CREATE TABLE `gir_finder_links` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `route` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `indexdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `md5sum` varchar(32) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `state` int(5) DEFAULT '1',
  `access` int(5) DEFAULT '0',
  `language` varchar(8) NOT NULL,
  `publish_start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `list_price` double unsigned NOT NULL DEFAULT '0',
  `sale_price` double unsigned NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL,
  `object` mediumblob NOT NULL,
  PRIMARY KEY (`link_id`),
  KEY `idx_type` (`type_id`),
  KEY `idx_title` (`title`),
  KEY `idx_md5` (`md5sum`),
  KEY `idx_url` (`url`(75)),
  KEY `idx_published_list` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`list_price`),
  KEY `idx_published_sale` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`sale_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms0` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms0`;

CREATE TABLE `gir_finder_links_terms0` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms1` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms1`;

CREATE TABLE `gir_finder_links_terms1` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms2` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms2`;

CREATE TABLE `gir_finder_links_terms2` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms3` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms3`;

CREATE TABLE `gir_finder_links_terms3` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms4` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms4`;

CREATE TABLE `gir_finder_links_terms4` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms5` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms5`;

CREATE TABLE `gir_finder_links_terms5` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms6` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms6`;

CREATE TABLE `gir_finder_links_terms6` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms7` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms7`;

CREATE TABLE `gir_finder_links_terms7` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms8` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms8`;

CREATE TABLE `gir_finder_links_terms8` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_terms9` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_terms9`;

CREATE TABLE `gir_finder_links_terms9` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_termsa` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_termsa`;

CREATE TABLE `gir_finder_links_termsa` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_termsb` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_termsb`;

CREATE TABLE `gir_finder_links_termsb` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_termsc` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_termsc`;

CREATE TABLE `gir_finder_links_termsc` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_termsd` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_termsd`;

CREATE TABLE `gir_finder_links_termsd` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_termse` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_termse`;

CREATE TABLE `gir_finder_links_termse` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_links_termsf` table : 
#

DROP TABLE IF EXISTS `gir_finder_links_termsf`;

CREATE TABLE `gir_finder_links_termsf` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_taxonomy` table : 
#

DROP TABLE IF EXISTS `gir_finder_taxonomy`;

CREATE TABLE `gir_finder_taxonomy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `access` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `state` (`state`),
  KEY `ordering` (`ordering`),
  KEY `access` (`access`),
  KEY `idx_parent_published` (`parent_id`,`state`,`access`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_taxonomy_map` table : 
#

DROP TABLE IF EXISTS `gir_finder_taxonomy_map`;

CREATE TABLE `gir_finder_taxonomy_map` (
  `link_id` int(10) unsigned NOT NULL,
  `node_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`node_id`),
  KEY `link_id` (`link_id`),
  KEY `node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_terms` table : 
#

DROP TABLE IF EXISTS `gir_finder_terms`;

CREATE TABLE `gir_finder_terms` (
  `term_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '0',
  `soundex` varchar(75) NOT NULL,
  `links` int(10) NOT NULL DEFAULT '0',
  `language` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `idx_term` (`term`),
  KEY `idx_term_phrase` (`term`,`phrase`),
  KEY `idx_stem_phrase` (`stem`,`phrase`),
  KEY `idx_soundex_phrase` (`soundex`,`phrase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_terms_common` table : 
#

DROP TABLE IF EXISTS `gir_finder_terms_common`;

CREATE TABLE `gir_finder_terms_common` (
  `term` varchar(75) NOT NULL,
  `language` varchar(3) NOT NULL,
  KEY `idx_word_lang` (`term`,`language`),
  KEY `idx_lang` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_tokens` table : 
#

DROP TABLE IF EXISTS `gir_finder_tokens`;

CREATE TABLE `gir_finder_tokens` (
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '1',
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `language` char(3) NOT NULL DEFAULT '',
  KEY `idx_word` (`term`),
  KEY `idx_context` (`context`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_tokens_aggregate` table : 
#

DROP TABLE IF EXISTS `gir_finder_tokens_aggregate`;

CREATE TABLE `gir_finder_tokens_aggregate` (
  `term_id` int(10) unsigned NOT NULL,
  `map_suffix` char(1) NOT NULL,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `term_weight` float unsigned NOT NULL,
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `context_weight` float unsigned NOT NULL,
  `total_weight` float unsigned NOT NULL,
  `language` char(3) NOT NULL DEFAULT '',
  KEY `token` (`term`),
  KEY `keyword_id` (`term_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

#
# Structure for the `gir_finder_types` table : 
#

DROP TABLE IF EXISTS `gir_finder_types`;

CREATE TABLE `gir_finder_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `mime` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_aliases` table : 
#

DROP TABLE IF EXISTS `gir_kunena_aliases`;

CREATE TABLE `gir_kunena_aliases` (
  `alias` varchar(255) NOT NULL,
  `type` varchar(10) NOT NULL,
  `item` varchar(32) NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '0',
  UNIQUE KEY `alias` (`alias`),
  KEY `state` (`state`),
  KEY `item` (`item`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_announcement` table : 
#

DROP TABLE IF EXISTS `gir_kunena_announcement`;

CREATE TABLE `gir_kunena_announcement` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `title` tinytext NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT '0',
  `sdescription` text NOT NULL,
  `description` text NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `ordering` tinyint(4) NOT NULL DEFAULT '0',
  `showdate` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_attachments` table : 
#

DROP TABLE IF EXISTS `gir_kunena_attachments`;

CREATE TABLE `gir_kunena_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mesid` int(11) NOT NULL DEFAULT '0',
  `userid` int(11) NOT NULL DEFAULT '0',
  `hash` char(32) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `folder` varchar(255) NOT NULL,
  `filetype` varchar(20) NOT NULL,
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mesid` (`mesid`),
  KEY `userid` (`userid`),
  KEY `hash` (`hash`),
  KEY `filename` (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_categories` table : 
#

DROP TABLE IF EXISTS `gir_kunena_categories`;

CREATE TABLE `gir_kunena_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `name` tinytext,
  `alias` varchar(255) NOT NULL,
  `icon_id` tinyint(4) NOT NULL DEFAULT '0',
  `locked` tinyint(4) NOT NULL DEFAULT '0',
  `accesstype` varchar(20) NOT NULL DEFAULT 'joomla.level',
  `access` int(11) NOT NULL DEFAULT '0',
  `pub_access` int(11) NOT NULL DEFAULT '1',
  `pub_recurse` tinyint(4) DEFAULT '1',
  `admin_access` int(11) NOT NULL DEFAULT '0',
  `admin_recurse` tinyint(4) DEFAULT '1',
  `ordering` smallint(6) NOT NULL DEFAULT '0',
  `published` tinyint(4) NOT NULL DEFAULT '0',
  `channels` text,
  `checked_out` tinyint(4) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `review` tinyint(4) NOT NULL DEFAULT '0',
  `allow_anonymous` tinyint(4) NOT NULL DEFAULT '0',
  `post_anonymous` tinyint(4) NOT NULL DEFAULT '0',
  `hits` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `headerdesc` text NOT NULL,
  `class_sfx` varchar(20) NOT NULL,
  `allow_polls` tinyint(4) NOT NULL DEFAULT '0',
  `topic_ordering` varchar(16) NOT NULL DEFAULT 'lastpost',
  `numTopics` mediumint(8) NOT NULL DEFAULT '0',
  `numPosts` mediumint(8) NOT NULL DEFAULT '0',
  `last_topic_id` int(11) NOT NULL DEFAULT '0',
  `last_post_id` int(11) NOT NULL DEFAULT '0',
  `last_post_time` int(11) NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `category_access` (`accesstype`,`access`),
  KEY `published_pubaccess_id` (`published`,`pub_access`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_configuration` table : 
#

DROP TABLE IF EXISTS `gir_kunena_configuration`;

CREATE TABLE `gir_kunena_configuration` (
  `id` int(11) NOT NULL DEFAULT '0',
  `params` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_keywords` table : 
#

DROP TABLE IF EXISTS `gir_kunena_keywords`;

CREATE TABLE `gir_kunena_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `public_count` int(11) NOT NULL,
  `total_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `public_count` (`public_count`),
  KEY `total_count` (`total_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_keywords_map` table : 
#

DROP TABLE IF EXISTS `gir_kunena_keywords_map`;

CREATE TABLE `gir_kunena_keywords_map` (
  `keyword_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  UNIQUE KEY `keyword_user_topic` (`keyword_id`,`user_id`,`topic_id`),
  KEY `user_id` (`user_id`),
  KEY `topic_user` (`topic_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_messages` table : 
#

DROP TABLE IF EXISTS `gir_kunena_messages`;

CREATE TABLE `gir_kunena_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent` int(11) DEFAULT '0',
  `thread` int(11) DEFAULT '0',
  `catid` int(11) NOT NULL DEFAULT '0',
  `name` tinytext,
  `userid` int(11) NOT NULL DEFAULT '0',
  `email` tinytext,
  `subject` tinytext,
  `time` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(128) DEFAULT NULL,
  `topic_emoticon` int(11) NOT NULL DEFAULT '0',
  `locked` tinyint(4) NOT NULL DEFAULT '0',
  `hold` tinyint(4) NOT NULL DEFAULT '0',
  `ordering` int(11) DEFAULT '0',
  `hits` int(11) DEFAULT '0',
  `moved` tinyint(4) DEFAULT '0',
  `modified_by` int(7) DEFAULT NULL,
  `modified_time` int(11) DEFAULT NULL,
  `modified_reason` tinytext,
  PRIMARY KEY (`id`),
  KEY `thread` (`thread`),
  KEY `ip` (`ip`),
  KEY `userid` (`userid`),
  KEY `time` (`time`),
  KEY `locked` (`locked`),
  KEY `hold_time` (`hold`,`time`),
  KEY `parent_hits` (`parent`,`hits`),
  KEY `catid_parent` (`catid`,`parent`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_messages_text` table : 
#

DROP TABLE IF EXISTS `gir_kunena_messages_text`;

CREATE TABLE `gir_kunena_messages_text` (
  `mesid` int(11) NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  PRIMARY KEY (`mesid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_polls` table : 
#

DROP TABLE IF EXISTS `gir_kunena_polls`;

CREATE TABLE `gir_kunena_polls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `threadid` int(11) NOT NULL,
  `polltimetolive` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `threadid` (`threadid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_polls_options` table : 
#

DROP TABLE IF EXISTS `gir_kunena_polls_options`;

CREATE TABLE `gir_kunena_polls_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pollid` int(11) DEFAULT NULL,
  `text` varchar(100) DEFAULT NULL,
  `votes` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pollid` (`pollid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_polls_users` table : 
#

DROP TABLE IF EXISTS `gir_kunena_polls_users`;

CREATE TABLE `gir_kunena_polls_users` (
  `pollid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `votes` int(11) DEFAULT NULL,
  `lasttime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastvote` int(11) DEFAULT NULL,
  UNIQUE KEY `pollid` (`pollid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_ranks` table : 
#

DROP TABLE IF EXISTS `gir_kunena_ranks`;

CREATE TABLE `gir_kunena_ranks` (
  `rank_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `rank_title` varchar(255) NOT NULL DEFAULT '',
  `rank_min` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `rank_special` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `rank_image` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`rank_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_sessions` table : 
#

DROP TABLE IF EXISTS `gir_kunena_sessions`;

CREATE TABLE `gir_kunena_sessions` (
  `userid` int(11) NOT NULL DEFAULT '0',
  `allowed` text,
  `lasttime` int(11) NOT NULL DEFAULT '0',
  `readtopics` text,
  `currvisit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`),
  KEY `currvisit` (`currvisit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_smileys` table : 
#

DROP TABLE IF EXISTS `gir_kunena_smileys`;

CREATE TABLE `gir_kunena_smileys` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `code` varchar(12) NOT NULL DEFAULT '',
  `location` varchar(50) NOT NULL DEFAULT '',
  `greylocation` varchar(60) NOT NULL DEFAULT '',
  `emoticonbar` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_thankyou` table : 
#

DROP TABLE IF EXISTS `gir_kunena_thankyou`;

CREATE TABLE `gir_kunena_thankyou` (
  `postid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `targetuserid` int(11) NOT NULL,
  `time` datetime NOT NULL,
  UNIQUE KEY `postid` (`postid`,`userid`),
  KEY `userid` (`userid`),
  KEY `targetuserid` (`targetuserid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_topics` table : 
#

DROP TABLE IF EXISTS `gir_kunena_topics`;

CREATE TABLE `gir_kunena_topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT '0',
  `subject` tinytext,
  `icon_id` int(11) NOT NULL DEFAULT '0',
  `locked` tinyint(4) NOT NULL DEFAULT '0',
  `hold` tinyint(4) NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `posts` int(11) NOT NULL DEFAULT '0',
  `hits` int(11) NOT NULL DEFAULT '0',
  `attachments` int(11) NOT NULL DEFAULT '0',
  `poll_id` int(11) NOT NULL DEFAULT '0',
  `moved_id` int(11) NOT NULL DEFAULT '0',
  `first_post_id` int(11) NOT NULL DEFAULT '0',
  `first_post_time` int(11) NOT NULL DEFAULT '0',
  `first_post_userid` int(11) NOT NULL DEFAULT '0',
  `first_post_message` text,
  `first_post_guest_name` tinytext,
  `last_post_id` int(11) NOT NULL DEFAULT '0',
  `last_post_time` int(11) NOT NULL DEFAULT '0',
  `last_post_userid` int(11) NOT NULL DEFAULT '0',
  `last_post_message` text,
  `last_post_guest_name` tinytext,
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `locked` (`locked`),
  KEY `hold` (`hold`),
  KEY `posts` (`posts`),
  KEY `hits` (`hits`),
  KEY `first_post_userid` (`first_post_userid`),
  KEY `last_post_userid` (`last_post_userid`),
  KEY `first_post_time` (`first_post_time`),
  KEY `last_post_time` (`last_post_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_user_categories` table : 
#

DROP TABLE IF EXISTS `gir_kunena_user_categories`;

CREATE TABLE `gir_kunena_user_categories` (
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `role` tinyint(4) NOT NULL DEFAULT '0',
  `allreadtime` datetime DEFAULT NULL,
  `subscribed` tinyint(4) NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  PRIMARY KEY (`user_id`,`category_id`),
  KEY `category_subscribed` (`category_id`,`subscribed`),
  KEY `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_user_read` table : 
#

DROP TABLE IF EXISTS `gir_kunena_user_read`;

CREATE TABLE `gir_kunena_user_read` (
  `user_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  UNIQUE KEY `user_topic_id` (`user_id`,`topic_id`),
  KEY `category_user_id` (`category_id`,`user_id`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_user_topics` table : 
#

DROP TABLE IF EXISTS `gir_kunena_user_topics`;

CREATE TABLE `gir_kunena_user_topics` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `topic_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL,
  `posts` mediumint(8) NOT NULL DEFAULT '0',
  `last_post_id` int(11) NOT NULL DEFAULT '0',
  `owner` tinyint(4) NOT NULL DEFAULT '0',
  `favorite` tinyint(4) NOT NULL DEFAULT '0',
  `subscribed` tinyint(4) NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  UNIQUE KEY `user_topic_id` (`user_id`,`topic_id`),
  KEY `topic_id` (`topic_id`),
  KEY `posts` (`posts`),
  KEY `owner` (`owner`),
  KEY `favorite` (`favorite`),
  KEY `subscribed` (`subscribed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_users` table : 
#

DROP TABLE IF EXISTS `gir_kunena_users`;

CREATE TABLE `gir_kunena_users` (
  `userid` int(11) NOT NULL DEFAULT '0',
  `view` varchar(8) NOT NULL DEFAULT '',
  `signature` text,
  `moderator` int(11) DEFAULT '0',
  `banned` datetime DEFAULT NULL,
  `ordering` int(11) DEFAULT '0',
  `posts` int(11) DEFAULT '0',
  `avatar` varchar(255) DEFAULT NULL,
  `karma` int(11) DEFAULT '0',
  `karma_time` int(11) DEFAULT '0',
  `group_id` int(4) DEFAULT '1',
  `uhits` int(11) DEFAULT '0',
  `personalText` tinytext,
  `gender` tinyint(4) NOT NULL DEFAULT '0',
  `birthdate` date NOT NULL DEFAULT '0001-01-01',
  `location` varchar(50) DEFAULT NULL,
  `icq` varchar(50) DEFAULT NULL,
  `aim` varchar(50) DEFAULT NULL,
  `yim` varchar(50) DEFAULT NULL,
  `msn` varchar(50) DEFAULT NULL,
  `skype` varchar(50) DEFAULT NULL,
  `twitter` varchar(50) DEFAULT NULL,
  `facebook` varchar(50) DEFAULT NULL,
  `gtalk` varchar(50) DEFAULT NULL,
  `myspace` varchar(50) DEFAULT NULL,
  `linkedin` varchar(50) DEFAULT NULL,
  `delicious` varchar(50) DEFAULT NULL,
  `friendfeed` varchar(50) DEFAULT NULL,
  `digg` varchar(50) DEFAULT NULL,
  `blogspot` varchar(50) DEFAULT NULL,
  `flickr` varchar(50) DEFAULT NULL,
  `bebo` varchar(50) DEFAULT NULL,
  `websitename` varchar(50) DEFAULT NULL,
  `websiteurl` varchar(50) DEFAULT NULL,
  `rank` tinyint(4) NOT NULL DEFAULT '0',
  `hideEmail` tinyint(1) NOT NULL DEFAULT '1',
  `showOnline` tinyint(1) NOT NULL DEFAULT '1',
  `thankyou` int(11) DEFAULT '0',
  PRIMARY KEY (`userid`),
  KEY `group_id` (`group_id`),
  KEY `posts` (`posts`),
  KEY `uhits` (`uhits`),
  KEY `banned` (`banned`),
  KEY `moderator` (`moderator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_users_banned` table : 
#

DROP TABLE IF EXISTS `gir_kunena_users_banned`;

CREATE TABLE `gir_kunena_users_banned` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `ip` varchar(128) DEFAULT NULL,
  `blocked` tinyint(4) NOT NULL DEFAULT '0',
  `expiration` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_time` datetime NOT NULL,
  `reason_private` text,
  `reason_public` text,
  `modified_by` int(11) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `comments` text,
  `params` text,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `ip` (`ip`),
  KEY `expiration` (`expiration`),
  KEY `created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_kunena_version` table : 
#

DROP TABLE IF EXISTS `gir_kunena_version`;

CREATE TABLE `gir_kunena_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(20) NOT NULL,
  `versiondate` date NOT NULL,
  `installdate` date NOT NULL,
  `build` varchar(20) NOT NULL,
  `versionname` varchar(40) DEFAULT NULL,
  `state` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_languages` table : 
#

DROP TABLE IF EXISTS `gir_languages`;

CREATE TABLE `gir_languages` (
  `lang_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang_code` char(7) NOT NULL,
  `title` varchar(50) NOT NULL,
  `title_native` varchar(50) NOT NULL,
  `sef` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `description` varchar(512) NOT NULL,
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `sitename` varchar(1024) NOT NULL DEFAULT '',
  `published` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lang_id`),
  UNIQUE KEY `idx_sef` (`sef`),
  UNIQUE KEY `idx_image` (`image`),
  UNIQUE KEY `idx_langcode` (`lang_code`),
  KEY `idx_access` (`access`),
  KEY `idx_ordering` (`ordering`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_menu` table : 
#

DROP TABLE IF EXISTS `gir_menu`;

CREATE TABLE `gir_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL COMMENT 'The type of menu this item belongs to. FK to #__menu_types.menutype',
  `title` varchar(255) NOT NULL COMMENT 'The display title of the menu item.',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The SEF alias of the menu item.',
  `note` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(1024) NOT NULL COMMENT 'The computed path of the menu item based on the alias field.',
  `link` varchar(1024) NOT NULL COMMENT 'The actually link the menu item refers to.',
  `type` varchar(16) NOT NULL COMMENT 'The type of link: Component, URL, Alias, Separator',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The published state of the menu link.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The parent menu item in the menu tree.',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The relative level in the tree.',
  `component_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__extensions.id',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__users.id',
  `checked_out_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The time the menu item was checked out.',
  `browserNav` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The click behaviour of the link.',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The access level required to view the menu item.',
  `img` varchar(255) NOT NULL COMMENT 'The image of the menu item.',
  `template_style_id` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL COMMENT 'JSON encoded data for the menu item.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `home` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicates if this menu item is the home or default page.',
  `language` char(7) NOT NULL DEFAULT '',
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_client_id_parent_id_alias_language` (`client_id`,`parent_id`,`alias`,`language`),
  KEY `idx_componentid` (`component_id`,`menutype`,`published`,`access`),
  KEY `idx_menutype` (`menutype`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_path` (`path`(255)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=568 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_menu_types` table : 
#

DROP TABLE IF EXISTS `gir_menu_types`;

CREATE TABLE `gir_menu_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL,
  `title` varchar(48) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_menutype` (`menutype`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_messages` table : 
#

DROP TABLE IF EXISTS `gir_messages`;

CREATE TABLE `gir_messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id_from` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id_to` int(10) unsigned NOT NULL DEFAULT '0',
  `folder_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `useridto_state` (`user_id_to`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_messages_cfg` table : 
#

DROP TABLE IF EXISTS `gir_messages_cfg`;

CREATE TABLE `gir_messages_cfg` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cfg_name` varchar(100) NOT NULL DEFAULT '',
  `cfg_value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_modules` table : 
#

DROP TABLE IF EXISTS `gir_modules`;

CREATE TABLE `gir_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `title` varchar(100) NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  `position` varchar(50) NOT NULL DEFAULT '',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `module` varchar(50) DEFAULT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `showtitle` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_modules_menu` table : 
#

DROP TABLE IF EXISTS `gir_modules_menu`;

CREATE TABLE `gir_modules_menu` (
  `moduleid` int(11) NOT NULL DEFAULT '0',
  `menuid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`moduleid`,`menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_newsfeeds` table : 
#

DROP TABLE IF EXISTS `gir_newsfeeds`;

CREATE TABLE `gir_newsfeeds` (
  `catid` int(11) NOT NULL DEFAULT '0',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `link` varchar(200) NOT NULL DEFAULT '',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `numarticles` int(10) unsigned NOT NULL DEFAULT '1',
  `cache_time` int(10) unsigned NOT NULL DEFAULT '3600',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rtl` tinyint(4) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `description` text NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `images` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_overrider` table : 
#

DROP TABLE IF EXISTS `gir_overrider`;

CREATE TABLE `gir_overrider` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `constant` varchar(255) NOT NULL,
  `string` text NOT NULL,
  `file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_postinstall_messages` table : 
#

DROP TABLE IF EXISTS `gir_postinstall_messages`;

CREATE TABLE `gir_postinstall_messages` (
  `postinstall_message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `extension_id` bigint(20) NOT NULL DEFAULT '700' COMMENT 'FK to #__extensions',
  `title_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'Lang key for the title',
  `description_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'Lang key for description',
  `action_key` varchar(255) NOT NULL DEFAULT '',
  `language_extension` varchar(255) NOT NULL DEFAULT 'com_postinstall' COMMENT 'Extension holding lang keys',
  `language_client_id` tinyint(3) NOT NULL DEFAULT '1',
  `type` varchar(10) NOT NULL DEFAULT 'link' COMMENT 'Message type - message, link, action',
  `action_file` varchar(255) DEFAULT '' COMMENT 'RAD URI to the PHP file containing action method',
  `action` varchar(255) DEFAULT '' COMMENT 'Action method name or URL',
  `condition_file` varchar(255) DEFAULT NULL COMMENT 'RAD URI to file holding display condition method',
  `condition_method` varchar(255) DEFAULT NULL COMMENT 'Display condition method, must return boolean',
  `version_introduced` varchar(50) NOT NULL DEFAULT '3.2.0' COMMENT 'Version when this message was introduced',
  `enabled` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`postinstall_message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_redirect_links` table : 
#

DROP TABLE IF EXISTS `gir_redirect_links`;

CREATE TABLE `gir_redirect_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(255) NOT NULL,
  `new_url` varchar(255) DEFAULT NULL,
  `referer` varchar(150) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(4) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `header` smallint(3) NOT NULL DEFAULT '301',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_link_old` (`old_url`),
  KEY `idx_link_modifed` (`modified_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_schemas` table : 
#

DROP TABLE IF EXISTS `gir_schemas`;

CREATE TABLE `gir_schemas` (
  `extension_id` int(11) NOT NULL,
  `version_id` varchar(20) NOT NULL,
  PRIMARY KEY (`extension_id`,`version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_session` table : 
#

DROP TABLE IF EXISTS `gir_session`;

CREATE TABLE `gir_session` (
  `session_id` varchar(200) NOT NULL DEFAULT '',
  `client_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `guest` tinyint(4) unsigned DEFAULT '1',
  `time` varchar(14) DEFAULT '',
  `data` mediumtext,
  `userid` int(11) DEFAULT '0',
  `username` varchar(150) DEFAULT '',
  PRIMARY KEY (`session_id`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_tags` table : 
#

DROP TABLE IF EXISTS `gir_tags`;

CREATE TABLE `gir_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `metadesc` varchar(1024) NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tag_idx` (`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_template_styles` table : 
#

DROP TABLE IF EXISTS `gir_template_styles`;

CREATE TABLE `gir_template_styles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) NOT NULL DEFAULT '',
  `client_id` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `home` char(7) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template` (`template`),
  KEY `idx_home` (`home`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_ucm_base` table : 
#

DROP TABLE IF EXISTS `gir_ucm_base`;

CREATE TABLE `gir_ucm_base` (
  `ucm_id` int(10) unsigned NOT NULL,
  `ucm_item_id` int(10) NOT NULL,
  `ucm_type_id` int(11) NOT NULL,
  `ucm_language_id` int(11) NOT NULL,
  PRIMARY KEY (`ucm_id`),
  KEY `idx_ucm_item_id` (`ucm_item_id`),
  KEY `idx_ucm_type_id` (`ucm_type_id`),
  KEY `idx_ucm_language_id` (`ucm_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_ucm_content` table : 
#

DROP TABLE IF EXISTS `gir_ucm_content`;

CREATE TABLE `gir_ucm_content` (
  `core_content_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `core_type_alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'FK to the content types table',
  `core_title` varchar(255) NOT NULL,
  `core_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `core_body` mediumtext NOT NULL,
  `core_state` tinyint(1) NOT NULL DEFAULT '0',
  `core_checked_out_time` varchar(255) NOT NULL DEFAULT '',
  `core_checked_out_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `core_access` int(10) unsigned NOT NULL DEFAULT '0',
  `core_params` text NOT NULL,
  `core_featured` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `core_metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `core_created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `core_created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `core_created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `core_modified_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Most recent user that modified',
  `core_modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `core_language` char(7) NOT NULL,
  `core_publish_up` datetime NOT NULL,
  `core_publish_down` datetime NOT NULL,
  `core_content_item_id` int(10) unsigned DEFAULT NULL COMMENT 'ID from the individual type table',
  `asset_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the #__assets table.',
  `core_images` text NOT NULL,
  `core_urls` text NOT NULL,
  `core_hits` int(10) unsigned NOT NULL DEFAULT '0',
  `core_version` int(10) unsigned NOT NULL DEFAULT '1',
  `core_ordering` int(11) NOT NULL DEFAULT '0',
  `core_metakey` text NOT NULL,
  `core_metadesc` text NOT NULL,
  `core_catid` int(10) unsigned NOT NULL DEFAULT '0',
  `core_xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `core_type_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`core_content_id`),
  KEY `tag_idx` (`core_state`,`core_access`),
  KEY `idx_access` (`core_access`),
  KEY `idx_alias` (`core_alias`),
  KEY `idx_language` (`core_language`),
  KEY `idx_title` (`core_title`),
  KEY `idx_modified_time` (`core_modified_time`),
  KEY `idx_created_time` (`core_created_time`),
  KEY `idx_content_type` (`core_type_alias`),
  KEY `idx_core_modified_user_id` (`core_modified_user_id`),
  KEY `idx_core_checked_out_user_id` (`core_checked_out_user_id`),
  KEY `idx_core_created_user_id` (`core_created_user_id`),
  KEY `idx_core_type_id` (`core_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains core content data in name spaced fields';

#
# Structure for the `gir_ucm_history` table : 
#

DROP TABLE IF EXISTS `gir_ucm_history`;

CREATE TABLE `gir_ucm_history` (
  `version_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ucm_item_id` int(10) unsigned NOT NULL,
  `ucm_type_id` int(10) unsigned NOT NULL,
  `version_note` varchar(255) NOT NULL DEFAULT '' COMMENT 'Optional version name',
  `save_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `editor_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `character_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of characters in this version.',
  `sha1_hash` varchar(50) NOT NULL DEFAULT '' COMMENT 'SHA1 hash of the version_data column.',
  `version_data` mediumtext NOT NULL COMMENT 'json-encoded string of version data',
  `keep_forever` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=auto delete; 1=keep',
  PRIMARY KEY (`version_id`),
  KEY `idx_ucm_item_id` (`ucm_type_id`,`ucm_item_id`),
  KEY `idx_save_date` (`save_date`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_update_sites` table : 
#

DROP TABLE IF EXISTS `gir_update_sites`;

CREATE TABLE `gir_update_sites` (
  `update_site_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `location` text NOT NULL,
  `enabled` int(11) DEFAULT '0',
  `last_check_timestamp` bigint(20) DEFAULT '0',
  `extra_query` varchar(1000) DEFAULT '',
  PRIMARY KEY (`update_site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Update Sites';

#
# Structure for the `gir_update_sites_extensions` table : 
#

DROP TABLE IF EXISTS `gir_update_sites_extensions`;

CREATE TABLE `gir_update_sites_extensions` (
  `update_site_id` int(11) NOT NULL DEFAULT '0',
  `extension_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`update_site_id`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Links extensions to update sites';

#
# Structure for the `gir_updates` table : 
#

DROP TABLE IF EXISTS `gir_updates`;

CREATE TABLE `gir_updates` (
  `update_id` int(11) NOT NULL AUTO_INCREMENT,
  `update_site_id` int(11) DEFAULT '0',
  `extension_id` int(11) DEFAULT '0',
  `name` varchar(100) DEFAULT '',
  `description` text NOT NULL,
  `element` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `folder` varchar(20) DEFAULT '',
  `client_id` tinyint(3) DEFAULT '0',
  `version` varchar(32) DEFAULT '',
  `data` text NOT NULL,
  `detailsurl` text NOT NULL,
  `infourl` text NOT NULL,
  `extra_query` varchar(1000) DEFAULT '',
  PRIMARY KEY (`update_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Available Updates';

#
# Structure for the `gir_user_keys` table : 
#

DROP TABLE IF EXISTS `gir_user_keys`;

CREATE TABLE `gir_user_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `series` varchar(255) NOT NULL,
  `invalid` tinyint(4) NOT NULL,
  `time` varchar(200) NOT NULL,
  `uastring` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `series` (`series`),
  UNIQUE KEY `series_2` (`series`),
  UNIQUE KEY `series_3` (`series`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_user_notes` table : 
#

DROP TABLE IF EXISTS `gir_user_notes`;

CREATE TABLE `gir_user_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL,
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `review_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_category_id` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_user_profiles` table : 
#

DROP TABLE IF EXISTS `gir_user_profiles`;

CREATE TABLE `gir_user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) NOT NULL,
  `profile_value` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Simple user profile storage table';

#
# Structure for the `gir_user_usergroup_map` table : 
#

DROP TABLE IF EXISTS `gir_user_usergroup_map`;

CREATE TABLE `gir_user_usergroup_map` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gir_usergroups` table : 
#

DROP TABLE IF EXISTS `gir_usergroups`;

CREATE TABLE `gir_usergroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Adjacency List Reference Id',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `title` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_usergroup_parent_title_lookup` (`parent_id`,`title`),
  KEY `idx_usergroup_title_lookup` (`title`),
  KEY `idx_usergroup_adjacency_lookup` (`parent_id`),
  KEY `idx_usergroup_nested_set_lookup` (`lft`,`rgt`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_users` table : 
#

DROP TABLE IF EXISTS `gir_users`;

CREATE TABLE `gir_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(150) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `block` tinyint(4) NOT NULL DEFAULT '0',
  `sendEmail` tinyint(4) DEFAULT '0',
  `registerDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `lastResetTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of last password reset',
  `resetCount` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of password resets since lastResetTime',
  `otpKey` varchar(1000) NOT NULL DEFAULT '' COMMENT 'Two factor authentication encrypted keys',
  `otep` varchar(1000) NOT NULL DEFAULT '' COMMENT 'One time emergency passwords',
  `requireReset` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Require user to reset password on next login',
  `photo` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_block` (`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=547 DEFAULT CHARSET=utf8;

#
# Structure for the `gir_viewlevels` table : 
#

DROP TABLE IF EXISTS `gir_viewlevels`;

CREATE TABLE `gir_viewlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `title` varchar(100) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

#
# Data for the `gir_assets` table  (LIMIT 0,500)
#

INSERT INTO `gir_assets` (`id`, `parent_id`, `lft`, `rgt`, `level`, `name`, `title`, `rules`) VALUES 
  (1,0,1,550,0,'root.1','Root Asset','{\"core.login.site\":{\"6\":1,\"2\":1},\"core.login.admin\":{\"1\":1,\"13\":0,\"6\":1,\"21\":0,\"23\":0,\"22\":0,\"18\":0,\"17\":0,\"19\":0,\"20\":0},\"core.login.offline\":[],\"core.admin\":{\"8\":1},\"core.manage\":{\"7\":1,\"19\":0},\"core.create\":{\"6\":1,\"3\":1},\"core.delete\":{\"6\":1},\"core.edit\":{\"6\":1,\"4\":1},\"core.edit.state\":{\"6\":1,\"5\":1},\"core.edit.own\":{\"6\":1,\"3\":1}}'),
  (2,1,2,3,1,'com_admin','com_admin','{}'),
  (3,1,4,11,1,'com_banners','com_banners','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (4,1,12,13,1,'com_cache','com_cache','{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}'),
  (5,1,14,15,1,'com_checkin','com_checkin','{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}'),
  (6,1,16,17,1,'com_config','com_config','{}'),
  (7,1,18,87,1,'com_contact','com_contact','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (8,1,88,301,1,'com_content','com_content','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.delete\":[],\"core.edit\":{\"4\":1},\"core.edit.state\":{\"5\":1},\"core.edit.own\":[]}'),
  (9,1,302,303,1,'com_cpanel','com_cpanel','{}'),
  (10,1,304,305,1,'com_installer','com_installer','{\"core.admin\":[],\"core.manage\":{\"7\":0},\"core.delete\":{\"7\":0},\"core.edit.state\":{\"7\":0}}'),
  (11,1,306,307,1,'com_languages','com_languages','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (12,1,308,309,1,'com_login','com_login','{}'),
  (13,1,310,311,1,'com_mailto','com_mailto','{}'),
  (14,1,312,313,1,'com_massmail','com_massmail','{}'),
  (15,1,314,315,1,'com_media','com_media','{\"core.admin\":{\"7\":1},\"core.options\":[],\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.delete\":{\"5\":1}}'),
  (16,1,316,317,1,'com_menus','com_menus','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (17,1,37,38,1,'com_messages','com_messages','{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}'),
  (18,1,320,321,1,'com_modules','com_modules','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (19,1,322,329,1,'com_newsfeeds','com_newsfeeds','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (20,1,330,331,1,'com_plugins','com_plugins','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (21,1,332,333,1,'com_redirect','com_redirect','{\"core.admin\":{\"7\":1},\"core.options\":[],\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (22,1,334,335,1,'com_search','com_search','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}'),
  (23,1,336,337,1,'com_templates','com_templates','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (24,1,338,341,1,'com_users','com_users','{\"core.admin\":{\"7\":1},\"core.options\":[],\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (26,1,342,343,1,'com_wrapper','com_wrapper','{}'),
  (33,1,422,423,1,'com_finder','com_finder','{\"core.admin\":{\"7\":1},\"core.options\":[],\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (34,8,105,108,2,'com_content.category.9','Uncategorised','{\"core.create\":{\"10\":0,\"12\":0},\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (35,3,7,8,2,'com_banners.category.10','Uncategorised','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (36,7,23,24,2,'com_contact.category.11','Uncategorised','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (37,19,325,326,2,'com_newsfeeds.category.12','Uncategorised','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (39,8,109,298,2,'com_content.category.14','Sample Data-Articles','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (40,3,9,10,2,'com_banners.category.15','Sample Data-Banners','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (41,7,25,86,2,'com_contact.category.16','Sample Data-Contact','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (42,19,327,328,2,'com_newsfeeds.category.17','Sample Data-Newsfeeds','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (44,39,110,245,3,'com_content.category.19','Joomla!','{\"core.create\":{\"10\":0,\"12\":0},\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (45,44,111,222,4,'com_content.category.20','Extensions','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (46,45,112,127,5,'com_content.category.21','Components','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),
  (47,45,128,189,5,'com_content.category.22','Modules','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),
  (48,45,190,199,5,'com_content.category.23','Templates','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),
  (49,45,200,201,5,'com_content.category.24','Languages','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),
  (50,45,202,221,5,'com_content.category.25','Plugins','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),
  (51,39,246,277,3,'com_content.category.26','Park Site','{\"core.create\":{\"10\":0,\"12\":0},\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (52,51,247,252,4,'com_content.category.27','Park Blog','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (53,51,253,274,4,'com_content.category.28','Photo Gallery','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),
  (54,39,278,291,3,'com_content.category.29','Fruit Shop Site','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (55,54,279,284,4,'com_content.category.30','Growers','{\"core.create\":{\"12\":0},\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":{\"10\":1}}'),
  (59,41,26,27,3,'com_contact.category.34','Park Site','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (60,41,28,85,3,'com_contact.category.35','Shop Site','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (61,60,29,30,4,'com_contact.category.36','Staff','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (62,60,31,84,4,'com_contact.category.37','Fruit Encyclopedia','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (63,62,32,33,5,'com_contact.category.38','A','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (64,62,34,35,5,'com_contact.category.39','B','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (65,62,36,37,5,'com_contact.category.40','C','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (66,62,38,39,5,'com_contact.category.41','D','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (67,62,40,41,5,'com_contact.category.42','E','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (68,62,42,43,5,'com_contact.category.43','F','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (69,62,44,45,5,'com_contact.category.44','G','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (70,62,46,47,5,'com_contact.category.45','H','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (71,62,48,49,5,'com_contact.category.46','I','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (72,62,50,51,5,'com_contact.category.47','J','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (73,62,52,53,5,'com_contact.category.48','K','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (74,62,54,55,5,'com_contact.category.49','L','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (75,62,56,57,5,'com_contact.category.50','M','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (76,62,58,59,5,'com_contact.category.51','N','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (77,62,60,61,5,'com_contact.category.52','O','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (78,62,62,63,5,'com_contact.category.53','P','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (79,62,64,65,5,'com_contact.category.54','Q','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (80,62,66,67,5,'com_contact.category.55','R','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (81,62,68,69,5,'com_contact.category.56','S','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (82,62,70,71,5,'com_contact.category.57','T','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (83,62,72,73,5,'com_contact.category.58','U','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (84,62,74,75,5,'com_contact.category.59','V','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (85,62,76,77,5,'com_contact.category.60','W','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (86,62,78,79,5,'com_contact.category.61','X','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (87,62,80,81,5,'com_contact.category.62','Y','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (88,62,82,83,5,'com_contact.category.63','Z','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (89,46,113,114,6,'com_content.article.1','Administrator Components','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (90,93,130,131,7,'com_content.article.2','Archive Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (91,93,132,133,7,'com_content.article.3','Article Categories Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (92,93,134,135,7,'com_content.article.4','Articles Category Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (93,47,129,144,6,'com_content.category.64','Content Modules','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (94,47,145,152,6,'com_content.category.65','User Modules','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (95,47,153,166,6,'com_content.category.66','Display Modules','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (96,47,167,180,6,'com_content.category.67','Utility Modules','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (98,48,191,192,6,'com_content.category.69','Beez3','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),
  (100,48,193,194,6,'com_content.category.71','Milky Way','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (101,50,203,204,6,'com_content.article.5','Authentication','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (102,51,275,276,4,'com_content.article.6','Australian Parks ','{\"core.delete\":[],\"core.edit\":{\"2\":1},\"core.edit.state\":[]}'),
  (103,95,154,155,7,'com_content.article.7','Banner Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (104,44,223,224,4,'com_content.article.8','Beginners','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (105,46,115,116,6,'com_content.article.9','Contact','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (106,46,117,118,6,'com_content.article.10','Content','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (107,109,265,266,6,'com_content.article.11','Cradle Mountain','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (108,53,254,263,5,'com_content.category.72','Animals','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (109,53,264,273,5,'com_content.category.73','Scenery','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (110,95,156,157,7,'com_content.article.12','Custom HTML Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (111,54,285,286,4,'com_content.article.13','Directions','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (112,50,205,206,6,'com_content.article.14','Editors','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (113,50,207,208,6,'com_content.article.15','Editors-xtd','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (114,95,158,159,7,'com_content.article.16','Feed Display','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (115,52,248,249,5,'com_content.article.17','First Blog Post','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (116,52,250,251,5,'com_content.article.18','Second Blog Post','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (117,95,160,161,7,'com_content.article.19','Footer Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (118,54,287,288,4,'com_content.article.20','Fruit Shop','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (119,44,225,226,4,'com_content.article.21','Getting Help','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (120,44,227,228,4,'com_content.article.22','Getting Started','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (121,55,280,281,5,'com_content.article.23','Happy Orange Orchard','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (122,44,229,230,4,'com_content.article.24','Joomla!','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (123,108,255,256,6,'com_content.article.25','Koala','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (124,96,168,169,7,'com_content.article.26','Language Switcher','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (125,93,136,137,7,'com_content.article.27','Latest Articles Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (126,94,146,147,7,'com_content.article.28','Login Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (127,166,184,185,7,'com_content.article.29','Menu Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (128,93,138,139,7,'com_content.article.30','Most Read Content','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (129,93,140,141,7,'com_content.article.31','News Flash','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (130,44,231,232,4,'com_content.article.32','Parameters','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (131,108,257,258,6,'com_content.article.33','Phyllopteryx','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (132,109,267,268,6,'com_content.article.34','Pinnacles','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (133,44,233,234,4,'com_content.article.35','Professionals','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (134,95,162,163,7,'com_content.article.36','Random Image Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (135,93,142,143,7,'com_content.article.37','Related Items Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (136,44,235,236,4,'com_content.article.38','Sample Sites','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (137,46,119,120,6,'com_content.article.39','Search','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (138,96,170,171,7,'com_content.article.40','Search Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (139,50,209,210,6,'com_content.article.41','Search ','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (140,39,292,293,3,'com_content.article.42','Site Map','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (141,108,259,260,6,'com_content.article.43','Spotted Quoll','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (142,96,172,173,7,'com_content.article.44','Statistics Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (143,96,174,175,7,'com_content.article.45','Syndicate Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (144,50,211,212,6,'com_content.article.46','System','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (145,44,237,238,4,'com_content.article.47','The Joomla! Community','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (146,44,239,240,4,'com_content.article.48','The Joomla! Project','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (147,48,195,196,6,'com_content.article.49','Typography','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (148,44,241,242,4,'com_content.article.50','Upgraders','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (149,50,213,214,6,'com_content.article.51','User','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (150,46,121,122,6,'com_content.article.52','Users','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (151,44,243,244,4,'com_content.article.53','Using Joomla!','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (154,94,148,149,7,'com_content.article.56','Who''s Online','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (155,108,261,262,6,'com_content.article.57','Wobbegone','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (156,55,282,283,5,'com_content.article.58','Wonderful Watermelon','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (157,96,176,177,7,'com_content.article.59','Wrapper Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (158,46,125,126,6,'com_content.article.60','News Feeds','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (159,166,186,187,7,'com_content.article.61','Breadcrumbs Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (160,50,215,216,6,'com_content.article.62','Content','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (162,109,269,270,6,'com_content.article.64','Blue Mountain Rain Forest','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (163,109,271,272,6,'com_content.article.65','Ormiston Pound','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (165,94,150,151,7,'com_content.article.66','Latest Users Module','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (166,47,183,188,6,'com_content.category.75','Navigation Modules','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),
  (167,54,289,290,4,'com_content.category.76','Recipes','{\"core.create\":{\"12\":1,\"10\":1},\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":{\"12\":1,\"10\":1}}'),
  (168,34,106,107,3,'com_content.article.67','What''s New in 1.5?','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (169,24,339,340,2,'com_users.category.77','Uncategorised',''),
  (170,50,217,218,6,'com_content.article.68','Captcha','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (171,50,219,220,6,'com_content.article.69','Quick Icons','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (172,96,178,179,7,'com_content.article.70','Smart Search','{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),
  (173,1,424,425,1,'com_joomlaupdate','com_joomlaupdate','{\"core.admin\":[],\"core.manage\":[],\"core.delete\":[],\"core.edit.state\":[]}'),
  (174,48,197,198,6,'com_content.category.78','Protostar','{\"core.create\":{\"6\":1,\"3\":1},\"core.delete\":{\"6\":1},\"core.edit\":{\"6\":1,\"4\":1},\"core.edit.state\":{\"6\":1,\"5\":1},\"core.edit.own\":{\"6\":1,\"3\":1}}'),
  (175,1,426,427,1,'com_tags','com_tags','{\"core.admin\":{\"8\":1},\"core.manage\":{\"7\":1},\"core.create\":{\"6\":1,\"3\":1},\"core.delete\":{\"6\":1},\"core.edit\":{\"6\":1,\"4\":1},\"core.edit.state\":{\"6\":1,\"5\":1}}'),
  (176,1,428,429,1,'com_contenthistory','com_contenthistory','{}'),
  (177,1,430,431,1,'com_ajax','com_ajax','{}'),
  (178,1,432,433,1,'com_postinstall','com_postinstall','{}'),
  (179,1,434,435,1,'com_prioridad','Prioridad','{}'),
  (180,8,299,300,2,'com_content.category.79','mic','{\"core.create\":{\"6\":1,\"3\":1},\"core.delete\":{\"6\":1},\"core.edit\":{\"6\":1,\"4\":1},\"core.edit.state\":{\"6\":1,\"5\":1},\"core.edit.own\":{\"6\":1,\"3\":1}}'),
  (181,39,296,297,3,'com_content.article.71','MINCOM','{\"core.delete\":{\"6\":1},\"core.edit\":{\"6\":1,\"4\":1},\"core.edit.state\":{\"6\":1,\"5\":1}}'),
  (182,1,436,437,1,'com_perfil_programa','Perfil_programa','{}'),
  (183,1,438,439,1,'com_indicadores_impacto','Indicadores_impacto','{}'),
  (184,1,440,441,1,'com_kunena','com_kunena','{}'),
  (189,1,442,443,1,'com_marco_regulatorio','marco_regulatorio','{}'),
  (190,1,444,445,1,'com_persona','Persona','{}'),
  (191,1,446,447,1,'com_entidad','Entidad','{}'),
  (192,1,448,449,1,'com_provincia','Provincia','{}'),
  (194,1,450,451,1,'com_programa','Programa','{}'),
  (195,1,452,453,1,'com_convocatoria','Convocatoria','{}'),
  (196,1,454,455,1,'com_ejecutora','Ejecutora','{}'),
  (198,1,456,457,1,'com_jefeproyecto','Jefeproyecto','{}'),
  (199,1,458,459,1,'com_tipo_proyecto','Tipo_proyecto','{}'),
  (200,1,460,461,1,'com_clasificacion','Clasificacion','{}'),
  (201,1,462,463,1,'com_perfil_proyecto','Perfil_proyecto','{}'),
  (202,1,464,465,1,'com_cat_cientifica','Cat_cientifica','{}'),
  (203,1,466,467,1,'com_grado_cientifico','Grado_cientifico','{}'),
  (204,1,468,469,1,'com_traza','Traza','{}'),
  (206,1,470,471,1,'com_ayuda','Ayuda','{}'),
  (207,1,472,473,1,'com_dictamen_eval_perfil_proy','Dictamen_eval_perfil_proy','{}'),
  (208,1,474,475,1,'com_contrato','Contrato','{}'),
  (209,1,476,477,1,'com_i_d','I_d','{}'),
  (210,1,478,479,1,'com_innovacion','Innovacion','{}'),
  (211,1,480,481,1,'com_forma_entrega','Forma_entrega','{}'),
  (212,1,482,483,1,'com_proyecto','Proyecto','{}'),
  (213,1,484,485,1,'com_evaluacion','Evaluacion','{}'),
  (214,1,486,487,1,'com_anticipo','Anticipo','{}'),
  (215,1,488,489,1,'com_control_ejecucion_presupuesto','Control_ejecucion_presupuesto','{}'),
  (216,1,490,491,1,'com_financista','Financista','{}'),
  (217,1,492,493,1,'com_informe_ejecucion_programa','Informe_ejecucion_programa','{}'),
  (218,1,494,495,1,'com_informe_etapa','Informe_etapa','{}'),
  (219,1,496,497,1,'com_notificacion_ingreso_gastos','Notificacion_ingreso_gastos','{}'),
  (220,1,498,499,1,'com_oponencia_informe_etapa','Oponencia_informe_etapa','{}'),
  (221,1,500,501,1,'com_dictamen_grupo_expertos_inf_etapa','Dictamen_grupo_expertos_inf_etapa','{}'),
  (222,1,502,503,1,'com_certificacion_activdades_resultados','Certificacion_activdades_resultados','{}'),
  (223,1,504,505,1,'com_estado_ejecucion_proyecto','Estado_ejecucion_proyecto','{}'),
  (225,1,506,507,1,'com_control_programa_proyecto','Control_programa_proyecto','{}'),
  (226,1,508,509,1,'com_problemas_detectados','Problemas_detectados','{}'),
  (227,1,510,511,1,'com_auditoria','Auditoria','{}'),
  (228,1,512,513,1,'com_documentacion_evidencias_objetivas','Documentacion_evidencias_objetivas','{}'),
  (229,1,514,515,1,'com_informe_auditoria','Informe_auditoria','{}'),
  (230,1,516,517,1,'com_lista_chequeo_auditoria','Lista_chequeo_auditoria','{}'),
  (231,1,518,519,1,'com_plan_auditoria','Plan_auditoria','{}'),
  (232,1,520,521,1,'com_rep_convocatoria','rep_convocatoria','{}'),
  (234,1,522,523,1,'com_informe_etapa_proyecto','informe_etapa_proyecto','{}'),
  (235,1,524,525,1,'com_anticipo_ejecutora','anticipo_ejecutora','{}'),
  (236,1,526,527,1,'com_certificn_actvs_resultds','certificn_actvs_resultds','{}'),
  (237,1,528,529,1,'com_csoap','COM_CSOAP','{}'),
  (238,1,530,531,1,'com_flujo_presupuesto','flujo_presupuesto','{}'),
  (239,1,532,533,1,'com_financiamiento_programa_proyecto','financiamiento_programa_proyecto','{}'),
  (240,1,534,535,1,'com_rep_dictmn_evl_gexp','rep_dictmn_evl_gexp','{}'),
  (241,1,536,537,1,'com_deficiencias_proyectos','deficiencias_proyectos','{}'),
  (242,1,538,539,1,'com_rep_informe_ejecucion_programa','rep_informe_ejecucion_programa','{}'),
  (243,1,540,541,1,'com_estado_ejecucion_programa_proyecto','estado_ejecucion_programa_proyecto','{}'),
  (244,1,542,543,1,'com_control_presupuestal','control_presupuestal','{}'),
  (245,1,544,545,1,'com_programa_auditoria','programa_auditoria','{}'),
  (246,1,546,547,1,'com_logs','logs','{}'),
  (247,1,548,549,1,'com_rep_informe_auditoria','rep_informe_auditoria','{}');

COMMIT;

#
# Data for the `gir_banner_clients` table  (LIMIT 0,500)
#

INSERT INTO `gir_banner_clients` (`id`, `name`, `contact`, `email`, `extrainfo`, `state`, `checked_out`, `checked_out_time`, `metakey`, `own_prefix`, `metakey_prefix`, `purchase_type`, `track_clicks`, `track_impressions`) VALUES 
  (1,'Joomla!','Administrator','banner@example.com','',1,0,'0000-00-00','',0,'',-1,-1,-1),
  (2,'Shop','Example','banner@example.com','',1,0,'0000-00-00','',0,'',-1,0,0),
  (3,'Bookstore','Bookstore Example','banner@example.com','',1,0,'0000-00-00','',0,'',-1,0,0);

COMMIT;

#
# Data for the `gir_banners` table  (LIMIT 0,500)
#

INSERT INTO `gir_banners` (`id`, `cid`, `type`, `name`, `alias`, `imptotal`, `impmade`, `clicks`, `clickurl`, `state`, `catid`, `description`, `custombannercode`, `sticky`, `ordering`, `metakey`, `params`, `own_prefix`, `metakey_prefix`, `purchase_type`, `track_clicks`, `track_impressions`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `reset`, `created`, `language`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `version`) VALUES 
  (2,3,0,'Shop 1','shop-1',0,7,0,'http://shop.joomla.org/amazoncom-bookstores.html',1,15,'Get books about Joomla! at the Joomla! Book Shop.','',0,1,'','{\"imageurl\":\"images\\/banners\\/white.png\",\"width\":\"\",\"height\":\"\",\"alt\":\"Joomla! Books\"}',0,'',-1,0,0,0,'0000-00-00','0000-00-00','0000-00-00','0000-00-00','2011-01-01 00:00:01','en-GB',42,'Joomla','0000-00-00',0,1),
  (3,2,0,'Shop 2','shop-2',0,7,0,'http://shop.joomla.org',1,15,'T Shirts, caps and more from the Joomla! Shop.','',0,2,'','{\"imageurl\":\"images\\/banners\\/white.png\",\"width\":\"\",\"height\":\"\",\"alt\":\"Joomla! Shop\"}',0,'',-1,0,0,0,'0000-00-00','0000-00-00','0000-00-00','0000-00-00','2011-01-01 00:00:01','en-GB',42,'Joomla','0000-00-00',0,1),
  (4,1,0,'Support Joomla!','support-joomla',0,7,0,'http://contribute.joomla.org',1,15,'Your contributions of time, talent and money make Joomla possible.','',0,3,'','{\"imageurl\":\"images\\/banners\\/white.png\",\"width\":\"\",\"height\":\"\",\"alt\":\"\"}',0,'',-1,0,0,0,'0000-00-00','0000-00-00','0000-00-00','0000-00-00','2011-01-01 00:00:01','en-GB',42,'Joomla','0000-00-00',0,1);

COMMIT;

#
# Data for the `gir_categories` table  (LIMIT 0,500)
#

INSERT INTO `gir_categories` (`id`, `asset_id`, `parent_id`, `lft`, `rgt`, `level`, `path`, `extension`, `title`, `alias`, `note`, `description`, `published`, `checked_out`, `checked_out_time`, `access`, `params`, `metadesc`, `metakey`, `metadata`, `created_user_id`, `created_time`, `modified_user_id`, `modified_time`, `hits`, `language`, `version`) VALUES 
  (1,0,0,0,135,0,'','system','ROOT','root','','',1,0,'0000-00-00',1,'{}','','','',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (9,34,1,129,130,1,'uncategorised','com_content','Uncategorised','uncategorised','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (10,35,1,127,128,1,'uncategorised','com_banners','Uncategorised','uncategorised','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\",\"foobar\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (11,36,1,123,124,1,'uncategorised','com_contact','Uncategorised','uncategorised','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (12,37,1,59,60,1,'uncategorised','com_newsfeeds','Uncategorised','uncategorised','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (14,39,1,9,54,1,'sample-data-articles','com_content','Sample Data-Articles','sample-data-articles','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (15,40,1,125,126,1,'sample-data-banners','com_banners','Sample Data-Banners','sample-data-banners','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\",\"foobar\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (16,41,1,61,122,1,'sample-data-contact','com_contact','Sample Data-Contact','sample-data-contact','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (17,42,1,57,58,1,'sample-data-newsfeeds','com_newsfeeds','Sample Data-Newsfeeds','sample-data-newsfeeds','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (19,44,14,10,37,2,'sample-data-articles/joomla','com_content','Joomla!','joomla','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (20,45,19,11,36,3,'sample-data-articles/joomla/extensions','com_content','Extensions','extensions','','<p>The Joomla! content management system lets you create webpages of various types using extensions. There are 5 basic types of extensions: components, modules, templates, languages, and plugins. Your website includes the extensions you need to create a basic website in English, but thousands of additional extensions of all types are available. The <a href=\"http://extensions.joomla.org\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\">Joomla! Extensions Directory</a> is the largest directory of Joomla extensions.</p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (21,46,20,12,13,4,'sample-data-articles/joomla/extensions/components','com_content','Components','components','','<p>Components are larger extensions that produce the major content for your site. Each component has one or more \"views\" that control how content is displayed. In the Joomla administrator there are additional extensions such as Menus, Redirection, and the extension managers.</p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',123,'2012-09-25 06:33:59',0,'*',1),
  (22,47,20,14,25,4,'sample-data-articles/joomla/extensions/modules','com_content','Modules','modules','','<p>Modules are small blocks of content that can be displayed in positions on a web page. The menus on this site are displayed in modules. The core of Joomla! includes 24 separate modules ranging from login to search to random images. Each module has a name that starts mod_ but when it displays it has a title. In the descriptions in this section, the titles are the same as the names.</p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',123,'2012-09-25 06:34:18',0,'*',1),
  (23,48,20,26,31,4,'sample-data-articles/joomla/extensions/templates','com_content','Templates','templates','','<p>Templates give your site its look and feel. They determine layout, colours, typefaces, graphics and other aspects of design that make your site unique. Your installation of Joomla comes prepackaged with three front end templates and two backend templates. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Template_Manager_Templates\">Help</a></p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',123,'2012-09-25 06:36:13',0,'*',1),
  (24,49,20,32,33,4,'sample-data-articles/joomla/extensions/languages','com_content','Languages','languages','','<p>Joomla! installs in English, but translations of the interfaces, sample data and help screens are available in dozens of languages. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Language_Manager_Installed\">Help</a></p><p><a href=\"http://community.joomla.org/translations.html\">Translation information</a></p><p>If there is no language pack available for your language, instructions are available for creating your own translation, which you can also contribute to the community by starting a translation team to create an accredited translation.</p><p>Translations of the interfaces are installed using the extensions manager in the site administrator and then managed using the language manager.</p><p>If you have two or more languages installed you may enable the language switcher plugin and module. They should always be used together. If you create multilingual content and mark your content, menu items or modules as being in specific languages and follow <a href=\"https://docs.joomla.org/Language_Switcher_Tutorial\">the complete instructions</a> your users will be able to select a specific content language using the module. By default both the plugin and module are disabled.</p><p>Joomla 2.5 installs with a language override manager that allows you to change the specific words (such as Edit or Search) used in the Joomla application.</p><p>There are a number of extensions that can help you manage translations of content available in the<a href=\"http://extensions.joomla.org\"> Joomla! Extensions Directory</a>.</p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',123,'2012-09-25 06:37:26',0,'*',1),
  (25,50,20,34,35,4,'sample-data-articles/joomla/extensions/plugins','com_content','Plugins','plugins','','<p>Plugins are small task oriented extensions that enhance the Joomla! framework. Some are associated with particular extensions and others, such as editors, are used across all of Joomla. Most beginning users do not need to change any of the plugins that install with Joomla. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Plugin_Manager_Edit\">Help</a></p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',123,'2012-09-25 06:36:50',0,'*',1),
  (26,51,14,38,47,2,'sample-data-articles/park-site','com_content','Park Site','park-site','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'en-GB',1),
  (27,52,26,39,40,3,'sample-data-articles/park-site/park-blog','com_content','Park Blog','park-blog','','<p><span style=\"font-size: 12px;\">Here is where I will blog all about the parks of Australia.</span></p><p><em>You can make a blog on your website by creating a category to write your blog posts in (this one is called Park Blog). Each blog post will be an article in that category. If you make a category blog menu link with 1 column it will look like this page, if you display the category description then this part is displayed. </em></p><p><em>To enhance your blog you may want to add extensions for <a href=\"http://extensions.joomla.org/extensions/contacts-and-feedback/articles-comments\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\">comments</a>,<a href=\"http://extensions.joomla.org/extensions/social-web\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\"> interacting with social network sites</a>, <a href=\"http://extensions.joomla.org/extensions/content-sharing\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\">tagging</a>, and <a href=\"http://extensions.joomla.org/extensions/content-sharing\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\">keeping in contact with your readers</a>. You can also enable the syndication that is included in Joomla (in the Integration Options set Show Feed Link to Show and make sure to display the syndication module on the page).</em></p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"images\\/sampledata\\/parks\\/banner_cradle.jpg\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'en-GB',1),
  (28,53,26,41,46,3,'sample-data-articles/park-site/photo-gallery','com_content','Photo Gallery','photo-gallery','','<p>These are my photos from parks I have visited (I didn''t take them, they are all from <a href=\"http://commons.wikimedia.org/wiki/Main_Page\">Wikimedia Commons</a>).</p><p><em>This shows you how to make a simple image gallery using articles in com_content. </em></p><p><em>In each article put a thumbnail image before a \"readmore\" and the full size image after it. Set the article to Show Intro Text: Hide. </em></p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',123,'2012-09-25 11:05:37',0,'en-GB',1),
  (29,54,14,48,53,2,'sample-data-articles/fruit-shop-site','com_content','Fruit Shop Site','fruit-shop-site','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (30,55,29,49,50,3,'sample-data-articles/fruit-shop-site/growers','com_content','Growers','growers','','<p>We search the whole countryside for the best fruit growers.</p><p><em>You can let each supplier have a page that he or she can edit. To see this in action you will need to create a user who is in the suppliers group.  </em></p><p><em>Create one page in the growers category for that user and make that supplier the author of the page. That user will be able to edit his or her page. </em></p><p><em>This illustrates the use of the Edit Own permission. </em></p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (34,59,16,62,63,2,'sample-data-contact/park-site','com_contact','Park Site','park-site','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'en-GB',1),
  (35,60,16,64,121,2,'sample-data-contact/shop-site','com_contact','Shop Site','shop-site','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (36,61,35,65,66,3,'sample-data-contact/shop-site/staff','com_contact','Staff','staff','','<p>Please feel free to contact our staff at any time should you need assistance.</p>',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (37,62,35,67,120,3,'sample-data-contact/shop-site/fruit-encyclopedia','com_contact','Fruit Encyclopedia','fruit-encyclopedia','','<p> </p><p>Our directory of information about different kinds of fruit.</p><p>We love fruit and want the world to know more about all of its many varieties.</p><p>Although it is small now, we work on it whenever we have a chance.</p><p>All of the images can be found in <a href=\"http://commons.wikimedia.org/wiki/Main_Page\">Wikimedia Commons</a>.</p><p><img src=\"images/sampledata/fruitshop/apple.jpg\" border=\"0\" alt=\"Apples\" title=\"Apples\" /></p><p><em>This encyclopedia is implemented using the contact component, each fruit a separate contact and a category for each letter. A CSS style is used to create the horizontal layout of the alphabet headings. </em></p><p><em>If you wanted to, you could allow some users (such as your growers) to have access to just this category in the contact component and let them help you to create new content for the encyclopedia.</em></p><p> </p>',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (38,63,37,68,69,4,'sample-data-contact/shop-site/fruit-encyclopedia/a','com_contact','A','a','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (39,64,37,70,71,4,'sample-data-contact/shop-site/fruit-encyclopedia/b','com_contact','B','b','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (40,65,37,72,73,4,'sample-data-contact/shop-site/fruit-encyclopedia/c','com_contact','C','c','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (41,66,37,74,75,4,'sample-data-contact/shop-site/fruit-encyclopedia/d','com_contact','D','d','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (42,67,37,76,77,4,'sample-data-contact/shop-site/fruit-encyclopedia/e','com_contact','E','e','','',0,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (43,68,37,78,79,4,'sample-data-contact/shop-site/fruit-encyclopedia/f','com_contact','F','f','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (44,69,37,80,81,4,'sample-data-contact/shop-site/fruit-encyclopedia/g','com_contact','G','g','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (45,70,37,82,83,4,'sample-data-contact/shop-site/fruit-encyclopedia/h','com_contact','H','h','','',0,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (46,71,37,84,85,4,'sample-data-contact/shop-site/fruit-encyclopedia/i','com_contact','I','i','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (47,72,37,86,87,4,'sample-data-contact/shop-site/fruit-encyclopedia/j','com_contact','J','j','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (48,73,37,88,89,4,'sample-data-contact/shop-site/fruit-encyclopedia/k','com_contact','K','k','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (49,74,37,90,91,4,'sample-data-contact/shop-site/fruit-encyclopedia/l','com_contact','L','l','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (50,75,37,92,93,4,'sample-data-contact/shop-site/fruit-encyclopedia/m','com_contact','M','m','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (51,76,37,94,95,4,'sample-data-contact/shop-site/fruit-encyclopedia/n','com_contact','N','n','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (52,77,37,96,97,4,'sample-data-contact/shop-site/fruit-encyclopedia/o','com_contact','O','o','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (53,78,37,98,99,4,'sample-data-contact/shop-site/fruit-encyclopedia/p','com_contact','P','p','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (54,79,37,100,101,4,'sample-data-contact/shop-site/fruit-encyclopedia/q','com_contact','Q','q','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (55,80,37,102,103,4,'sample-data-contact/shop-site/fruit-encyclopedia/r','com_contact','R','r','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (56,81,37,104,105,4,'sample-data-contact/shop-site/fruit-encyclopedia/s','com_contact','S','s','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (57,82,37,106,107,4,'sample-data-contact/shop-site/fruit-encyclopedia/t','com_contact','T','t','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (58,83,37,108,109,4,'sample-data-contact/shop-site/fruit-encyclopedia/u','com_contact','U','u','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (59,84,37,110,111,4,'sample-data-contact/shop-site/fruit-encyclopedia/v','com_contact','V','v','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (60,85,37,112,113,4,'sample-data-contact/shop-site/fruit-encyclopedia/w','com_contact','W','w','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (61,86,37,114,115,4,'sample-data-contact/shop-site/fruit-encyclopedia/x','com_contact','X','x','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (62,87,37,116,117,4,'sample-data-contact/shop-site/fruit-encyclopedia/y','com_contact','Y','y','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (63,88,37,118,119,4,'sample-data-contact/shop-site/fruit-encyclopedia/z','com_contact','Z','z','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (64,93,22,15,16,5,'sample-data-articles/joomla/extensions/modules/articles-modules','com_content','Content Modules','articles-modules','','<p>Content modules display article and other information from the content component.</p>',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (65,94,22,17,18,5,'sample-data-articles/joomla/extensions/modules/user-modules','com_content','User Modules','user-modules','','<p>User modules interact with the user system, allowing users to login, show who is logged-in, and showing the most recently registered users.</p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (66,95,22,19,20,5,'sample-data-articles/joomla/extensions/modules/display-modules','com_content','Display Modules','display-modules','','<p>These modules display information from components other than content and user. These include weblinks, news feeds and the media manager.</p>',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (67,96,22,21,22,5,'sample-data-articles/joomla/extensions/modules/utility-modules','com_content','Utility Modules','utility-modules','','<p>Utility modules provide useful functionality such as search, syndication and statistics.</p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (69,98,23,27,28,5,'sample-data-articles/joomla/extensions/templates/beez3','com_content','Beez3','beez3','','<p>Beez3 is a versatile, easy to customise template that works for a variety of sites. It meets major accessibility standards and demonstrates a range of css and javascript techniques.</p><ul><li><a href=\"index.php?Itemid=424\">Home Page</a></li><li><a href=\"index.php?Itemid=423\">Typography</a></li></ul>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',123,'2012-09-25 11:47:38',0,'*',1),
  (72,108,28,42,43,4,'sample-data-articles/park-site/photo-gallery/animals','com_content','Animals','animals','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'en-GB',1),
  (73,109,28,44,45,4,'sample-data-articles/park-site/photo-gallery/scenery','com_content','Scenery','scenery','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'en-GB',1),
  (75,166,22,23,24,5,'sample-data-articles/joomla/extensions/modules/navigation-modules','com_content','Navigation Modules','navigation-modules','','<p>Navigation modules help your visitors move through your site and find what they need.</p><p>Menus provide your site with structure and help your visitors navigate your site.  Although they are all based on the same menu module, the variety of ways menus are used in the sample data show how flexible this module is.</p><p>A menu can range from extremely simple (for example the top menu or the menu for the Australian Parks sample site) to extremely complex (for example the About Joomla! menu with its many levels). They can also be used for other types of presentation such as the site map linked from the \"This Site\" menu.</p><p>Breadcrumbs provide users with information about where they are in a site.</p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (76,167,29,51,52,3,'sample-data-articles/fruit-shop-site/recipes','com_content','Recipes','recipes','','<p>Customers and suppliers can post their favorite recipes for fruit here.</p><p>A good idea is to promote the use of metadata keywords to make finding other recipes for the same fruit easier.</p><p><em>To see this in action, create a user assigned to the customer group and a user assigned to the suppliers group. These users will be able to create their own recipe pages and edit those pages. They will not be able to edit other users'' pages.</em><br /><br /></p>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (77,169,1,131,132,1,'uncategorised','com_users','Uncategorised','uncategorised','','',1,0,'0000-00-00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',540,'2011-01-01 00:00:01',0,'0000-00-00',0,'*',1),
  (78,174,23,29,30,5,'sample-data-articles/joomla/extensions/templates/protostar','com_content','Protostar','protostar','','<p>Protostar is a mobile ready template designed using Twitter Bootstrap. It is sleek and easily to customise. It is the default template for Joomla 3.</p><ul><li><a href=\"index.php?Itemid=469\">Home Page</a></li><li><a href=\"index.php?option=com_content&amp;view=article&amp;id=49&amp;catid=23&amp;Itemid=470\">Typography</a></li></ul>',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2012-09-25 11:50:03',123,'2012-09-25 12:13:14',0,'*',1),
  (79,180,1,133,134,1,'mic','com_content','mic','mic','','',1,0,'0000-00-00',1,'{\"category_layout\":\"\",\"image\":\"\",\"image_alt\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',540,'2015-11-26 09:17:03',0,'2015-11-26 09:17:03',0,'*',1);

COMMIT;

#
# Data for the `gir_contact_details` table  (LIMIT 0,500)
#

INSERT INTO `gir_contact_details` (`id`, `name`, `alias`, `con_position`, `address`, `suburb`, `state`, `country`, `postcode`, `telephone`, `fax`, `misc`, `image`, `email_to`, `default_con`, `published`, `checked_out`, `checked_out_time`, `ordering`, `params`, `user_id`, `catid`, `access`, `mobile`, `webpage`, `sortname1`, `sortname2`, `sortname3`, `language`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `metakey`, `metadesc`, `metadata`, `featured`, `xreference`, `publish_up`, `publish_down`, `version`, `hits`) VALUES 
  (1,'Contact Name Here','name','Position','Street Address','Suburb','State','Country','Zip Code','Telephone','Fax','<p>Information about or by the contact.</p>','images/powered_by.png','email@example.com',1,1,0,'0000-00-00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"1\",\"linka_name\":\"Twitter\",\"linka\":\"http:\\/\\/twitter.com\\/joomla\",\"linkb_name\":\"YouTube\",\"linkb\":\"http:\\/\\/www.youtube.com\\/user\\/joomla\",\"linkc_name\":\"Facebook\",\"linkc\":\"http:\\/\\/www.facebook.com\\/joomla\",\"linkd_name\":\"FriendFeed\",\"linkd\":\"http:\\/\\/friendfeed.com\\/joomla\",\"linke_name\":\"Scribed\",\"linke\":\"http:\\/\\/www.scribd.com\\/people\\/view\\/504592-joomla\",\"contact_layout\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,16,1,'','','last','first','middle','en-GB','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00','0000-00-00',1,0),
  (2,'Webmaster','webmaster','','','','','','','','','','','webmaster@example.com',0,1,0,'0000-00-00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"\",\"linka_name\":\"\",\"linka\":\"\",\"linkb_name\":\"\",\"linkb\":\"\",\"linkc_name\":\"\",\"linkc\":\"\",\"linkd_name\":\"\",\"linkd\":\"\",\"linke_name\":\"\",\"linke\":\"\",\"show_email_form\":\"1\",\"show_email_copy\":\"1\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"1\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,34,1,'','','','','','en-GB','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00','0000-00-00',1,0),
  (3,'Owner','owner','','','','','','','','','<p>I''m the owner of this store.</p>','','',0,1,0,'0000-00-00',2,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"\",\"linka_name\":\"\",\"linka\":\"\",\"linkb_name\":\"\",\"linkb\":\"\",\"linkc_name\":\"\",\"linkc\":\"\",\"linkd_name\":\"\",\"linkd\":\"\",\"linke_name\":\"\",\"linke\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,36,1,'','','','','','*','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00','0000-00-00',1,0),
  (4,'Buyer','buyer','','','','','','','','','<p>I am in charge of buying fruit. If you sell good fruit, contact me.</p>','','',0,1,0,'0000-00-00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"0\",\"linka_name\":\"\",\"linka\":\"\",\"linkb_name\":\"\",\"linkb\":\"\",\"linkc_name\":\"\",\"linkc\":\"\",\"linkd_name\":\"\",\"linkd\":\"\",\"linke_name\":\"\",\"linke\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,36,1,'','','','','','*','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00','0000-00-00',1,0),
  (5,'Bananas','bananas','Scientific Name: Musa','Image Credit: EnzikRights: Creative Commons Share Alike Unported 3.0Source: http://commons.wikimedia.org/wiki/File:Bananas_-_Morocco.jpg','','Type: Herbaceous','Large Producers: India, China, Brasil','','','','<p>Bananas are a great source of potassium.</p><p> </p>','images/sampledata/fruitshop/bananas_2.jpg','',0,1,0,'0000-00-00',1,'{\"show_contact_category\":\"show_with_link\",\"show_contact_list\":\"\",\"presentation_style\":\"plain\",\"show_name\":\"\",\"show_position\":\"1\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"1\",\"show_postcode\":\"\",\"show_country\":\"1\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"1\",\"linka_name\":\"Wikipedia: Banana English\",\"linka\":\"http:\\/\\/en.wikipedia.org\\/wiki\\/Banana\",\"linkb_name\":\"Wikipedia:  \\u0939\\u093f\\u0928\\u094d\\u0926\\u0940 \\u0915\\u0947\\u0932\\u093e\",\"linkb\":\"http:\\/\\/hi.wikipedia.org\\/wiki\\/%E0%A4%95%E0%A5%87%E0%A4%B2%E0%A4%BE\",\"linkc_name\":\"Wikipedia:Banana Portugu\\u00eas\",\"linkc\":\"http:\\/\\/pt.wikipedia.org\\/wiki\\/Banana\",\"linkd_name\":\"Wikipedia: \\u0411\\u0430\\u043d\\u0430\\u043d  \\u0420\\u0443\\u0441\\u0441\\u043a\\u0438\\u0439\",\"linkd\":\"http:\\/\\/ru.wikipedia.org\\/\\u0411\\u0430\\u043d\\u0430\\u043d\",\"linke_name\":\"\",\"linke\":\"\",\"contact_layout\":\"beez5:encyclopedia\"}',0,39,1,'','','','','','*','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}',0,'','0000-00-00','0000-00-00',1,0),
  (6,'Apples','apples','Scientific Name: Malus domestica','Image Credit: FievetRights: Public DomainSource: http://commons.wikimedia.org/wiki/File:Pommes_vertes.JPG','','Family: Rosaceae','Large: Producers: China, United States','','','','<p>Apples are a versatile fruit, used for eating, cooking, and preserving.</p><p>There are more that 7500 different kinds of apples grown around the world.</p>','images/sampledata/fruitshop/apple.jpg','',0,1,0,'0000-00-00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"plain\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"1\",\"linka_name\":\"Wikipedia: Apples English\",\"linka\":\"http:\\/\\/en.wikipedia.org\\/wiki\\/Apple\",\"linkb_name\":\"Wikipedia: Manzana Espa\\u00f1ol \",\"linkb\":\"http:\\/\\/es.wikipedia.org\\/wiki\\/Manzana\",\"linkc_name\":\"Wikipedia: \\u82f9\\u679c \\u4e2d\\u6587\",\"linkc\":\"http:\\/\\/zh.wikipedia.org\\/zh\\/\\u82f9\\u679c\",\"linkd_name\":\"Wikipedia: Tofaa Kiswahili\",\"linkd\":\"http:\\/\\/sw.wikipedia.org\\/wiki\\/Tofaa\",\"linke_name\":\"\",\"linke\":\"\",\"contact_layout\":\"beez5:encyclopedia\"}',0,38,1,'','','','','','*','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}',0,'','0000-00-00','0000-00-00',1,0),
  (7,'Tamarind','tamarind','Scientific Name: Tamarindus indica','Image Credit: Franz Eugen Köhler, Köhler''s Medizinal-Pflanzen Rights: Public DomainSource:http://commons.wikimedia.org/wiki/File:Koeh-134.jpg','','Family: Fabaceae','Large Producers: India, United States','','','','<p>Tamarinds are a versatile fruit used around the world. In its young form it is used in hot sauces; ripened it is the basis for many refreshing drinks.</p><p> </p>','images/sampledata/fruitshop/tamarind.jpg','',0,1,0,'0000-00-00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"plain\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"1\",\"linka_name\":\"Wikipedia: Tamarind English\",\"linka\":\"http:\\/\\/en.wikipedia.org\\/wiki\\/Tamarind\",\"linkb_name\":\"Wikipedia: \\u09a4\\u09c7\\u0981\\u09a4\\u09c1\\u09b2  \\u09ac\\u09be\\u0982\\u09b2\\u09be  \",\"linkb\":\"http:\\/\\/bn.wikipedia.org\\/wiki\\/\\u09a4\\u09c7\\u0981\\u09a4\\u09c1\\u09b2 \",\"linkc_name\":\"Wikipedia: Tamarinier Fran\\u00e7ais\",\"linkc\":\"http:\\/\\/fr.wikipedia.org\\/wiki\\/Tamarinier\",\"linkd_name\":\"Wikipedia:Tamaline lea faka-Tonga\",\"linkd\":\"http:\\/\\/to.wikipedia.org\\/wiki\\/Tamaline\",\"linke_name\":\"\",\"linke\":\"\",\"contact_layout\":\"beez5:encyclopedia\"}',0,57,1,'','','','','','*','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}',0,'','0000-00-00','0000-00-00',1,0),
  (8,'Shop Address','shop-address','','','Our City','Our Province','Our Country','','555-555-5555','','<p>Here are directions for how to get to our shop.</p>','','',0,1,0,'0000-00-00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"\",\"linka_name\":\"\",\"linka\":\"\",\"linkb_name\":\"\",\"linkb\":\"\",\"linkc_name\":\"\",\"linkc\":\"\",\"linkd_name\":\"\",\"linkd\":\"\",\"linke_name\":\"\",\"linke\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,35,1,'','','','','','*','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00','0000-00-00',1,0);

COMMIT;

#
# Data for the `gir_content` table  (LIMIT 0,500)
#

INSERT INTO `gir_content` (`id`, `asset_id`, `title`, `alias`, `introtext`, `fulltext`, `state`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`, `featured`, `language`, `xreference`) VALUES 
  (1,89,'Administrator Components','administrator-components','<p>All components are also used in the administrator area of your website. In addition to the ones listed here, there are components in the administrator that do not have direct front end displays, but do help shape your site. The most important ones for most users are</p><ul><li>Media Manager</li><li>Extensions Manager</li><li>Menu Manager</li><li>Global Configuration</li><li>Banners</li><li>Redirect</li></ul><hr title=\"Media Manager\" alt=\"Media Manager\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" /><p> </p><h3>Media Manager</h3><p>The media manager component lets you upload and insert images into content throughout your site. Optionally, you can enable the flash uploader which will allow you to to upload multiple images. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Content_Media_Manager\">Help</a></p><hr title=\"Extensions Manager\" alt=\"Extensions Manager\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" /><h3>Extensions Manager</h3><p>The extensions manager lets you install, update, uninstall and manage all of your extensions. The extensions manager has been extensively redesigned, although the core install and uninstall functionality remains the same as in Joomla! 1.5. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Extension_Manager_Install\">Help</a></p><hr title=\"Menu Manager\" alt=\"Menu Manager\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" /><h3>Menu Manager</h3><p>The menu manager lets you create the menus you see displayed on your site. It also allows you to assign modules and template styles to specific menu links. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Menus_Menu_Manager\">Help</a></p><hr title=\"Global Configuration\" alt=\"Global Configuration\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" /><h3>Global Configuration</h3><p>The global configuration is where the site administrator configures things such as whether search engine friendly urls are enabled, the site meta data (descriptive text used by search engines and indexers) and other functions. For many beginning users simply leaving the settings on default is a good way to begin, although when your site is ready for the public you will want to change the meta data to match its content. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Site_Global_Configuration\">Help</a></p><hr title=\"Banners\" alt=\"Banners\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" /><h3>Banners</h3><p>The banners component provides a simple way to display a rotating image in a module and, if you wish to have advertising, a way to track the number of times an image is viewed and clicked. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Components_Banners_Banners_Edit\">Help</a></p><hr title=\"Redirect\" class=\"system-pagebreak\" /><h3><br />Redirect</h3><p>The redirect component is used to manage broken links that produce Page Not Found (404) errors. If enabled it will allow you to redirect broken links to specific pages. It can also be used to manage migration related URL changes. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Components_Redirect_Manager\">Help</a></p>','',1,21,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,7,'','',1,6,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (2,90,'Archive Module','archive-module','<p>This module shows a list of the calendar months containing archived articles. After you have changed the status of an article to archived, this list will be automatically generated. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Articles_Archive\" title=\"Archive Module\">Help</a></p><div class=\"sample-module\">{loadmodule articles_archive,Archived Articles}</div>','',1,64,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,5,'modules, content','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (3,91,'Article Categories Module','article-categories-module','<p>This module displays a list of categories from one parent category. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Articles_Categories\" title=\"Categories Module\">Help</a></p><div class=\"sample-module\">{loadmodule articles_categories,Articles Categories}</div><p> </p>','',1,64,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,6,'modules, content','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (4,92,'Articles Category Module','articles-category-module','<p>This module allows you to display the articles in a specific category. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Articles_Category\">Help</a></p><div class=\"sample-module\">{loadmodule articles_category,Articles Category}</div>','',1,64,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,7,'','articles,content',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (5,101,'Authentication','authentication','<p>The authentication plugins operate when users login to your site or administrator. The Joomla! authentication plugin is in operation by default but you can enable Gmail or LDAP or install a plugin for a different system. An example is included that may be used to create a new authentication plugin.</p><p>Default on:</p><ul><li>Joomla <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Authentication_-_GMail\">Help</a></li></ul><p>Default off:</p><ul><li>Gmail <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Authentication_-_GMail\">Help</a></li><li>LDAP <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Authentication_-_LDAP\">Help</a></li></ul>','',1,25,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,3,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (6,102,'Australian Parks ','australian-parks','<p>Welcome!</p><p>This is a basic site about the beautiful and fascinating parks of Australia.</p><p>On this site you can read all about my travels to different parks, see photos, and find links to park websites.</p><p><em>This sample site is an example of using the core of Joomla! to create a basic website, whether a \"brochure site,\" a personal blog, or as a way to present information on a topic you are interested in.</em></p><p><em> Read more about the site in the About Parks module.</em></p><p></p>','',1,26,'2011-01-01 00:00:01',540,'Joomla','2012-09-25 11:04:30',123,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":null,\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":null,\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":null,\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"0\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,1,'','',1,14,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (7,103,'Banner Module','banner-module','<p>The banner module is used to display the banners that are managed by the banners component in the site administrator. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Banners\">Help</a>.</p><div class=\"sample-module\">{loadmodule banners,Banners}</div>','',1,66,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,6,'','',1,0,'',0,'*',''),
  (8,104,'Beginners','beginners','<p>If this is your first Joomla! site or your first web site, you have come to the right place. Joomla will help you get your website up and running quickly and easily.</p><p>Start off using your site by logging in using the administrator account you created when you installed Joomla.</p>','<p>Explore the articles and other resources right here on your site data to learn more about how Joomla works. (When you''re done reading, you can delete or archive all of this.) You will also probably want to visit the Beginners'' Areas of the <a href=\"https://docs.joomla.org/Beginners\">Joomla documentation</a> and <a href=\"http://forum.joomla.org\">support forums</a>.</p><p>You''ll also want to sign up for the Joomla Security Mailing list and the Announcements mailing list. For inspiration visit the <a href=\"http://community.joomla.org/showcase/\">Joomla! Site Showcase</a> to see an amazing array of ways people use Joomla to tell their stories on the web.</p><p>The basic Joomla installation will let you get a great site up and running, but when you are ready for more features the power of Joomla is in the creative ways that developers have extended it to do all kinds of things. Visit the <a href=\"http://extensions.joomla.org/\">Joomla! Extensions Directory</a> to see thousands of extensions that can do almost anything you could want on a website. Can''t find what you need? You may want to find a Joomla professional in the <a href=\"http://resources.joomla.org/\">Joomla! Resource Directory</a>.</p><p>Want to learn more? Consider attending a <a href=\"http://community.joomla.org/events.html\">Joomla! Day</a> or other event or joining a local <a href=\"http://community.joomla.org/user-groups.html\">Joomla! Users Group</a>. Can''t find one near you? Start one yourself.</p>',1,19,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,4,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',1,'*',''),
  (9,105,'Contacts','contact','<p>The contact component provides a way to provide contact forms and information for your site or to create a complex directory that can be used for many different purposes. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Components_Contacts_Contacts\">Help</a></p>','',1,21,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',1,2,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (10,106,'Content','content','<p>The content component (com_content) is what you use to write articles. It is extremely flexible and has the largest number of built in views. Articles can be created and edited from the front end, making content the easiest component to use to create your site content. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Content_Article_Manager\">Help</a></p>','',1,21,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',1,1,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (11,107,'Cradle Mountain','cradle-mountain','<p> </p>','<p> </p>',1,73,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"images\\/sampledata\\/parks\\/landscape\\/250px_cradle_mountain_seen_from_barn_bluff.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Cradle Mountain\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/landscape\\/800px_cradle_mountain_seen_from_barn_bluff.jpg\",\"float_fulltext\":\"none\",\"image_fulltext_alt\":\"Cradle Mountain\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Rainforest,bluemountainsNSW.jpg Author: Alan J.W.C. License: GNU Free Documentation License v . 1.2 or later\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,1,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (12,110,'Custom HTML Module','custom-html-module','<p>This module allows you to create your own HTML Module using a WYSIWYG editor. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Custom_HTML\" title=\"Custom HTML Module\">Help</a></p><div class=\"sample-module\">{loadmodule custom,Custom HTML}</div>','',1,66,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,1,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (13,111,'Directions','directions','<p>Here''s how to find our shop.</p><p>By car</p><p>Drive along Main Street to the intersection with First Avenue.  Look for our sign.</p><p>By foot</p><p>From the center of town, walk north on Main Street until you see our sign.</p><p>By bus</p><p>Take the #73 Bus to the last stop. We are on the north east corner.</p>','',1,29,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,2,'','',1,3,'',0,'*',''),
  (14,112,'Editors','editors','<p>Editors are used thoughout Joomla! where content is created. TinyMCE is the default choice in most locations although CodeMirror is used in the template manager. No Editor provides a text box for html content.</p><p>Default on:</p><ul><li>CodeMirror <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Editor_-_CodeMirror\">Help</a></li><li>TinyMCE<a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Editor_-_TinyMCE\"> Help</a></li><li>No Editor <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Editor_-_None\">Help</a></li></ul><p>Default off:</p><ul><li>None</li></ul>','',1,25,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,5,'','',1,0,'',0,'*',''),
  (15,113,'Editors-xtd','editors-xtd','<p>These plugins are the buttons found beneath your editor. They only run when an editor plugin runs.</p><p>Default on:</p><ul><li>Editor Button: Image<a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Button_-_Image\"> Help</a></li><li>Editor Button: Readmore <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Button_-_Readmore\">Help</a></li><li>Editor Button: Page Break <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Button_-_Pagebreak\">Help</a></li><li>Editor Button: Article <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Button_-_Article\">Help</a></li></ul><p>Default off:</p><ul><li>None</li></ul>','',1,25,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,6,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (16,114,'Feed Display','feed-display','<p>This module allows the displaying of a syndicated feed. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Feed_Display\" title=\"Feed Display Module\">Help</a></p><div class=\"sample-module\">{loadmodule feed,Feed Display}</div>','',1,66,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,2,'','',1,0,'',0,'*',''),
  (17,115,'First Blog Post','first-blog-post','<p><em>Lorem Ipsum is filler text that is commonly used by designers before the content for a new site is ready.</em></p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus purus vitae diam posuere nec eleifend elit dictum. Aenean sit amet erat purus, id fermentum lorem. Integer elementum tristique lectus, non posuere quam pretium sed. Quisque scelerisque erat at urna condimentum euismod. Fusce vestibulum facilisis est, a accumsan massa aliquam in. In auctor interdum mauris a luctus. Morbi euismod tempor dapibus. Duis dapibus posuere quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In eu est nec erat sollicitudin hendrerit. Pellentesque sed turpis nunc, sit amet laoreet velit. Praesent vulputate semper nulla nec varius. Aenean aliquam, justo at blandit sodales, mauris leo viverra orci, sed sodales mauris orci vitae magna.</p>','<p>Quisque a massa sed libero tristique suscipit. Morbi tristique molestie metus, vel vehicula nisl ultrices pretium. Sed sit amet est et sapien condimentum viverra. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus viverra tortor porta orci convallis ac cursus erat sagittis. Vivamus aliquam, purus non luctus adipiscing, orci urna imperdiet eros, sed tincidunt neque sapien et leo. Cras fermentum, dolor id tempor vestibulum, neque lectus luctus mauris, nec congue tellus arcu nec augue. Nulla quis mi arcu, in bibendum quam. Sed placerat laoreet fermentum. In varius lobortis consequat. Proin vulputate felis ac arcu lacinia adipiscing. Morbi molestie, massa id sagittis luctus, sem sapien sollicitudin quam, in vehicula quam lectus quis augue. Integer orci lectus, bibendum in fringilla sit amet, rutrum eget enim. Curabitur at libero vitae lectus gravida luctus. Nam mattis, ligula sit amet vestibulum feugiat, eros sem sodales mi, nec dignissim ante elit quis nisi. Nulla nec magna ut leo convallis sagittis ac non erat. Etiam in augue nulla, sed tristique orci. Vestibulum quis eleifend sapien.</p><p>Nam ut orci vel felis feugiat posuere ut eu lorem. In risus tellus, sodales eu eleifend sed, imperdiet id nulla. Nunc at enim lacus. Etiam dignissim, arcu quis accumsan varius, dui dui faucibus erat, in molestie mauris diam ac lacus. Sed sit amet egestas nunc. Nam sollicitudin lacinia sapien, non gravida eros convallis vitae. Integer vehicula dui a elit placerat venenatis. Nullam tincidunt ligula aliquet dui interdum feugiat. Maecenas ultricies, lacus quis facilisis vehicula, lectus diam consequat nunc, euismod eleifend metus felis eu mauris. Aliquam dapibus, ipsum a dapibus commodo, dolor arcu accumsan neque, et tempor metus arcu ut massa. Curabitur non risus vitae nisl ornare pellentesque. Pellentesque nec ipsum eu dolor sodales aliquet. Vestibulum egestas scelerisque tincidunt. Integer adipiscing ultrices erat vel rhoncus.</p><p>Integer ac lectus ligula. Nam ornare nisl id magna tincidunt ultrices. Phasellus est nisi, condimentum at sollicitudin vel, consequat eu ipsum. In venenatis ipsum in ligula tincidunt bibendum id et leo. Vivamus quis purus massa. Ut enim magna, pharetra ut condimentum malesuada, auctor ut ligula. Proin mollis, urna a aliquam rutrum, risus erat cursus odio, a convallis enim lectus ut lorem. Nullam semper egestas quam non mattis. Vestibulum venenatis aliquet arcu, consectetur pretium erat pulvinar vel. Vestibulum in aliquet arcu. Ut dolor sem, pellentesque sit amet vestibulum nec, tristique in orci. Sed lacinia metus vel purus pretium sit amet commodo neque condimentum.</p><p>Aenean laoreet aliquet ullamcorper. Nunc tincidunt luctus tellus, eu lobortis sapien tincidunt sed. Donec luctus accumsan sem, at porttitor arcu vestibulum in. Sed suscipit malesuada arcu, ac porttitor orci volutpat in. Vestibulum consectetur vulputate eros ut porttitor. Aenean dictum urna quis erat rutrum nec malesuada tellus elementum. Quisque faucibus, turpis nec consectetur vulputate, mi enim semper mi, nec porttitor libero magna ut lacus. Quisque sodales, leo ut fermentum ullamcorper, tellus augue gravida magna, eget ultricies felis dolor vitae justo. Vestibulum blandit placerat neque, imperdiet ornare ipsum malesuada sed. Quisque bibendum quam porta diam molestie luctus. Sed metus lectus, ornare eu vulputate vel, eleifend facilisis augue. Maecenas eget urna velit, ac volutpat velit. Nam id bibendum ligula. Donec pellentesque, velit eu convallis sodales, nisi dui egestas nunc, et scelerisque lectus quam ut ipsum.</p>',1,27,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,2,'','',1,1,'',0,'*',''),
  (18,116,'Second Blog Post','second-blog-post','<p><em>Lorem Ipsum is text that is traditionally used by designers when working on a site before the content is ready.</em></p><p>Pellentesque bibendum metus ut dolor fermentum ut pulvinar tortor hendrerit. Nam vel odio vel diam tempus iaculis in non urna. Curabitur scelerisque, nunc id interdum vestibulum, felis elit luctus dui, ac dapibus tellus mauris tempus augue. Duis congue facilisis lobortis. Phasellus neque erat, tincidunt non lacinia sit amet, rutrum vitae nunc. Sed placerat lacinia fermentum. Integer justo sem, cursus id tristique eget, accumsan vel sapien. Curabitur ipsum neque, elementum vel vestibulum ut, lobortis a nisl. Fusce malesuada mollis purus consectetur auctor. Morbi tellus nunc, dapibus sit amet rutrum vel, laoreet quis mauris. Aenean nec sem nec purus bibendum venenatis. Mauris auctor commodo libero, in adipiscing dui adipiscing eu. Praesent eget orci ac nunc sodales varius.</p>','<p>Nam eget venenatis lorem. Vestibulum a interdum sapien. Suspendisse potenti. Quisque auctor purus nec sapien venenatis vehicula malesuada velit vehicula. Fusce vel diam dolor, quis facilisis tortor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque libero nisi, pellentesque quis cursus sit amet, vehicula vitae nisl. Curabitur nec nunc ac sem tincidunt auctor. Phasellus in mattis magna. Donec consequat orci eget tortor ultricies rutrum. Mauris luctus vulputate molestie. Proin tincidunt vehicula euismod. Nam congue leo non erat cursus a adipiscing ipsum congue. Nulla iaculis purus sit amet turpis aliquam sit amet dapibus odio tincidunt. Ut augue diam, congue ut commodo pellentesque, fermentum mattis leo. Sed iaculis urna id enim dignissim sodales at a ipsum. Quisque varius lobortis mollis. Nunc purus magna, pellentesque pellentesque convallis sed, varius id ipsum. Etiam commodo mi mollis erat scelerisque fringilla. Nullam bibendum massa sagittis diam ornare rutrum.</p><p>Praesent convallis metus ut elit faucibus tempus in quis dui. Donec fringilla imperdiet nibh, sit amet fringilla velit congue et. Quisque commodo luctus ligula, vitae porttitor eros venenatis in. Praesent aliquet commodo orci id varius. Nulla nulla nibh, varius id volutpat nec, sagittis nec eros. Cras et dui justo. Curabitur malesuada facilisis neque, sed tempus massa tincidunt ut. Sed suscipit odio in lacus auctor vehicula non ut lacus. In hac habitasse platea dictumst. Sed nulla nisi, lacinia in viverra at, blandit vel tellus. Nulla metus erat, ultrices non pretium vel, varius nec sem. Morbi sollicitudin mattis lacus quis pharetra. Donec tincidunt mollis pretium. Proin non libero justo, vitae mattis diam. Integer vel elit in enim varius posuere sed vitae magna. Duis blandit tempor elementum. Vestibulum molestie dui nisi.</p><p>Curabitur volutpat interdum lorem sed tempus. Sed placerat quam non ligula lacinia sodales. Cras ultrices justo at nisi luctus hendrerit. Quisque sit amet placerat justo. In id sapien eu neque varius pharetra sed in sapien. Etiam nisl nunc, suscipit sed gravida sed, scelerisque ut nisl. Mauris quis massa nisl, aliquet posuere ligula. Etiam eget tortor mauris. Sed pellentesque vestibulum commodo. Mauris vitae est a libero dapibus dictum fringilla vitae magna.</p><p>Nulla facilisi. Praesent eget elit et mauris gravida lobortis ac nec risus. Ut vulputate ullamcorper est, volutpat feugiat lacus convallis non. Maecenas quis sem odio, et aliquam libero. Integer vel tortor eget orci tincidunt pulvinar interdum at erat. Integer ullamcorper consequat eros a pellentesque. Cras sagittis interdum enim in malesuada. Etiam non nunc neque. Fusce non ligula at tellus porta venenatis. Praesent tortor orci, fermentum sed tincidunt vel, varius vel dui. Duis pulvinar luctus odio, eget porta justo vulputate ac. Nulla varius feugiat lorem sed tempor. Phasellus pulvinar dapibus magna eget egestas. In malesuada lectus at justo pellentesque vitae rhoncus nulla ultrices. Proin ut sem sem. Donec eu suscipit ipsum. Cras eu arcu porttitor massa feugiat aliquet at quis nisl.</p>',1,27,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,1,'','',1,2,'',0,'*',''),
  (19,117,'Footer Module','footer-module','<p>This module shows the Joomla! copyright information. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Footer\" title=\"Footer Module\">Help</a></p><div class=\"sample-module\">{loadmodule footer,Footer}</div>','',1,66,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,3,'','',1,0,'',0,'*',''),
  (20,118,'Fruit Shop','fruit-shop','<h2>Welcome to the Fruit Shop</h2><p>We sell fruits from around the world. Please use our website to learn more about our business. We hope you will come to our shop and buy some fruit.</p><p><em>This mini site will show you how you might want to set up a site for a business, in this example one selling fruit. It shows how to use access controls to manage your site content. If you were building a real site, you might want to extend it with e-commerce, a catalog, mailing lists or other enhancements, many of which are available through the</em><a href=\"http://extensions.joomla.org\"><em> Joomla! Extensions Directory</em></a>.</p><p><em>To understand this site you will probably want to make one user with group set to customer and one with group set to grower. By logging in with different privileges you can see how access control works.</em></p>','',1,29,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,1,'','',1,10,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (21,119,'Getting Help','getting-help','<p>There are lots of places you can get help with Joomla!. In many places in your site administrator you will see the help icon. Click on this for more information about the options and functions of items on your screen. Other places to get help are:</p><ul><li><a href=\"http://forum.joomla.org\">Support Forums</a></li><li><a href=\"https://docs.joomla.org\">Documentation</a></li><li><a href=\"http://resources.joomla.org\">Professionals</a></li><li><a href=\"http://shop.joomla.org/amazoncom-bookstores.html\">Books</a></li></ul>','',1,19,'2011-01-01 00:00:01',540,'Joomla','2012-09-25 07:39:17',123,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":null,\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":null,\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":null,\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"0\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,8,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (22,120,'Getting Started','getting-started','<p>It''s easy to get started creating your website. Knowing some of the basics will help.</p><h3>What is a Content Management System?</h3><p>A content management system is software that allows you to create and manage webpages easily by separating the creation of your content from the mechanics required to present it on the web.</p><p>In this site, the content is stored in a <em>database</em>. The look and feel are created by a <em>template</em>. The Joomla! software brings together the template and the content to create web pages.</p><h3>Site and Administrator</h3><p>Your site actually has two separate sites. The site (also called the front end) is what visitors to your site will see. The administrator (also called the back end) is only used by people managing your site. You can access the administrator by clicking the \"Site Administrator\" link on the \"This Site\" menu or by adding /administrator to the end of you domain name.</p><p>Log in to the administrator using the username and password created during the installation of Joomla.</p><h3>Logging in</h3><p>To login to the front end of your site use the login form or the login menu link on the \"This Site\" menu. Use the user name and password that were created as part of the installation process. Once logged-in you will be able to create and edit articles.</p><p>In managing your site, you will be able to create content that only logged-in users are able to see.</p><h3>Creating an article</h3><p>Once you are logged-in, a new menu will be visible. To create a new article, click on the \"submit article\" link on that menu.</p><p>The new article interface gives you a lot of options, but all you need to do is add a title and put something in the content area. To make it easy to find, set the state to published and put it in the Joomla category.</p><div>You can edit an existing article by clicking on the edit icon (this only displays to users who have the right to edit).</div><h3>Learn more</h3><p>There is much more to learn about how to use Joomla! to create the web site you envision. You can learn much more at the <a href=\"https://docs.joomla.org\">Joomla! documentation site</a> and on the<a href=\"http://forum.joomla.org\"> Joomla! forums</a>.</p>','',1,19,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,9,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (23,121,'Happy Orange Orchard','happy-orange-orchard','<p>At our orchard we grow the world''s best oranges as well as other citrus fruit such as lemons and grapefruit. Our family has been tending this orchard for generations.</p>','',1,30,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,2,'','',1,0,'',0,'*',''),
  (24,122,'Joomla!','joomla','<p>Congratulations! You have a Joomla site! Joomla makes it easy to build a website just the way you want it and keep it simple to update and maintain.</p><p>Joomla is a flexible and powerful platform, whether you are building a small site for yourself or a huge site with hundreds of thousands of visitors. Joomla is open source, which means you can make it work just the way you want it to.</p><p>The content in this installation of Joomla has been designed to give you an in depth tour of Joomla''s features.</p>','',1,19,'2011-01-01 00:00:01',540,'Joomla','2012-09-25 12:19:00',123,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":null,\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":null,\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":null,\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"0\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,2,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',1,'*',''),
  (25,123,'Koala','koala','<p> </p><p> </p><p> </p><p> </p><p> </p>','<p> </p>',1,72,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"images\\/sampledata\\/parks\\/animals\\/180px_koala_ag1.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Koala  Thumbnail\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/animals\\/800px_koala_ag1.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Koala Climbing Tree\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Koala-ag1.jpg Author: Arnaud Gaillard License: Creative Commons Share Alike Attribution Generic 1.0\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,2,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (26,124,'Language Switcher','language-switcher','<p>The language switcher module allows you to take advantage of the language tags that are available when content, modules and menu links are created.</p><p>This module displays a list of available Content Languages for switching between them.</p><p>When switching languages, it redirects to the Home page, or associated menu item, defined for the chosen language. Thereafter, the navigation will be the one defined for that language.</p><p><strong>The language filter plugin must be enabled for this module to work properly.</strong></p><p><strong></strong> <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Language_Switcher\" title=\"Language Switcher Module\">Help</a></p><p>To view an example of the language switch moduler module, go to the site administrator and enable the language filter plugin and the language switcher module labelled \"language switcher\" and visit the fruit shop or park sample sites. Then follow<a href=\"https://docs.joomla.org/Language_Switcher_Tutorial_for_Joomla_1.6\"> the instructions in this tutorial</a>.</p>','',1,67,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,3,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (27,125,'Latest Articles Module','latest-articles-module','<p>This module shows a list of the most recently published and current Articles. Some that are shown may have expired even though they are the most recent. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Latest_News\" title=\"Latest Articles\">Help</a></p><div class=\"sample-module\">{loadmodule articles_latest,Latest News}</div>','',1,64,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,1,'modules, content','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (28,126,'Login Module','login-module','<p>This module displays a username and password login form. It also displays a link to retrieve a forgotten password. If user registration is enabled (in the Global Configuration settings), another link will be shown to enable self-registration for users. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Login\" title=\"Login\">Help</a></p><div class=\"sample-module\">{loadmodule login,login}</div>','',1,65,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,2,'','',1,0,'',0,'*',''),
  (29,127,'Menu Module','menu-module','<p>This module displays a menu on the site (frontend).  Menus can be displayed in a wide variety of ways by using the menu options and css menu styles. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Menu\">Help</a></p><div class=\"sample-module\">{loadmodule mod_menu,Menu Example}</div>','',1,75,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,1,'','',1,0,'',0,'*',''),
  (30,128,'Most Read Content','most-read-content','<p>This module shows a list of the currently published Articles which have the highest number of page views. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Most_Read\" title=\"Most Read Content\">Help</a></p><div class=\"sample-module\">{loadmodule articles_popular,Articles Most Read}</div>','',1,64,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,2,'modules, content','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (31,129,'News Flash','news-flash','<p>Displays a set number of articles from a category based on date or random selection. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Articles_Newsflash\" title=\"News Flash Module\">Help</a></p><div class=\"sample-module\">{loadmodule articles_news,News Flash}</div>','',1,64,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,3,'modules, content','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (32,130,'Options','options','<p>As you make your Joomla! site you will control the details of the display using <em>options</em> also referred to as <em>parameter</em><strong>s</strong>. Options control everything from whether the author''s name is displayed to who can view what to the number of items shown on a list.</p><p>Default options for each component are changed using the Options button on the component toolbar.</p><p>Options can also be set on an individual item, such as an article or contact and in menu links.</p><p>If you are happy with how your site looks, it is fine to leave all of the options set to the defaults that were created when your site was installed. As you become more experienced with Joomla you will use options more.</p><p> </p>','',1,19,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,10,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (33,131,'Phyllopteryx','phyllopteryx','<p> </p>','<p> </p>',1,72,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"images\\/sampledata\\/parks\\/animals\\/200px_phyllopteryx_taeniolatus1.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Phyllopteryx\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/animals\\/800px_phyllopteryx_taeniolatus1.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Phyllopteryx\",\"image_fulltext_caption\":\"Source: http:\\/\\/en.wikipedia.org\\/wiki\\/File:Phyllopteryx_taeniolatus1.jpg Author: Richard Ling License: GNU Free Documentation License v 1.2 or later\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,3,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (34,132,'Pinnacles','pinnacles','<p> </p>','<p> </p>',1,73,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"images\\/sampledata\\/parks\\/landscape\\/120px_pinnacles_western_australia.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Kings Canyon\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/landscape\\/800px_pinnacles_western_australia.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Kings Canyon\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Pinnacles_Western_Australia.jpg  Author: Martin Gloss  License: GNU Free Documentation license v 1.2 or later.\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,4,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (35,133,'Professionals','professionals','<p>Joomla! 3 continues development of the Joomla Platform and CMS as a powerful and flexible way to bring your vision of the web to reality. With the new administrator interface and adoption of Twitter Bootstrap, the ability to control its look and the management of extensions is now complete.</p>','<p>Working with multiple template styles and overrides for the same views, creating the design you want is easier than it has ever been. Limiting support to PHP 5.3.10 and above makes Joomla lighter and faster than ever.</p><p>The separation of the Joomla! Platform project from the Joomla! CMS project makes continuous development of new, powerful APIs and continuous improvement of existing APIs possible while maintaining the stability of the CMS that millions of webmasters and professionals rely upon.</p>',1,19,'2011-01-01 00:00:01',540,'Joomla','2012-09-25 07:14:30',123,0,'0000-00-00','2011-01-09 16:41:13','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":null,\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":null,\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":null,\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"0\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,5,'','',1,3,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',1,'*',''),
  (36,134,'Random Image Module','random-image-module','<p>This module displays a random image from your chosen image directory. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Random_Image\" title=\"Random Image Module\">Help</a></p><div class=\"sample-module\">{loadmodule random_image,Random Image}</div>','',1,66,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,4,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (37,135,'Related Items Module','related-items-module','<p>This module displays other Articles that are related to the one currently being viewed. These relations are established by the Meta Keywords.  All the keywords of the current Article are searched against all the keywords of all other published articles. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Articles_Related\" title=\"Related Items Module\">Help</a></p><div class=\"sample-module\">{loadmodule related_items,Articles Related Items}</div>','',1,64,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,4,'modules, content','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (38,136,'Sample Sites','sample-sites','<p>Your installation includes sample data, designed to show you some of the options you have for building your website. In addition to information about Joomla! there are two sample \"sites within a site\" designed to help you get started with building your own site.</p><p>The first site is a simple site about <a href=\"index.php?Itemid=243\">Australian Parks</a>. It shows how you can quickly and easily build a personal site with just the building blocks that are part of Joomla. It includes a personal blog, weblinks, and a very simple image gallery.</p><p>The second site is slightly more complex and represents what you might do if you are building a site for a small business, in this case a <a href=\"index.php/welcome.html\"></a><a href=\"index.php?Itemid=429\">Fruit Shop</a>.</p><p>In building either style site, or something completely different, you will probably want to add <a href=\"http://extensions.joomla.org\">extensions</a> and either create or purchase your own template. Many Joomla users start by modifying the <a href=\"https://docs.joomla.org/How_do_you_modify_a_template%3F\">templates</a> that come with the core distribution so that they include special images and other design elements that relate to their site''s focus.</p>','',1,19,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,11,'','',1,15,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (39,137,'Search','search-component','<p>Joomla! 2.5 offers two search options.</p><p>The Basic Search component provides basic search functionality for the information contained in your core components. Many extensions can also be searched by the search component. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Components_Search\">Help</a></p><p>The Smart Search component offers searching similar to that found in major search engines. Smart Search is disabled by default. If you choose to enable it you will need to take several steps. First, enable the Smart Search Plugin in the plugin manager. Then, if you are using the Basic Search Module replace it with the Smart Search Module. Finally, if you have already created content, go to the Smart Search component in your site administrator and click the Index icon. Once indexing of your content is complete, Smart Search will be ready to use. Help.</p>','',1,21,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,3,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (40,138,'Search Module','search-module','<p>This module will display a search box. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Search\" title=\"Search\">Help</a></p><div class=\"sample-module\">{loadmodule search,Search}</div>','',1,67,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,4,'','',1,0,'',0,'*',''),
  (41,139,'Search ','search-plugin','<p>The search component uses plugins to control which parts of your Joomla! site are searched. You may choose to turn off some areas to improve performance or for other reasons. Many third party Joomla! extensions have search plugins that extend where search takes place.</p><p>Default On:</p><ul><li>Content <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Search_-_Content\">Help</a></li><li>Contacts <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Search_-_Contacts\">Help</a></li><li>Weblinks <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Search_-_Weblinks\">Help</a></li><li>News Feeds <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Search_-_Newsfeeds\">Help</a></li><li>Categories <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Search_-_Categories\">Help</a></li></ul>','',1,25,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,1,'','',1,0,'',0,'*',''),
  (42,140,'Site Map','site-map','<p>{loadposition sitemapload}</p><p><em>By putting all of your content into nested categories you can give users and search engines access to everything using a menu.</em></p>','',1,14,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,1,'','',1,3,'',0,'*',''),
  (43,141,'Spotted Quoll','spotted-quoll','<p> </p><p> </p>','<p> </p>',1,72,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"images\\/sampledata\\/parks\\/animals\\/220px_spottedquoll_2005_seanmcclean.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Spotted Quoll\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/animals\\/789px_spottedquoll_2005_seanmcclean.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Spotted Quoll\",\"image_fulltext_caption\":\"Source: http:\\/\\/en.wikipedia.org\\/wiki\\/File:SpottedQuoll_2005_SeanMcClean.jpg Author: Sean McClean License: GNU Free Documentation License v 1.2 or later\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,4,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (44,142,'Statistics Module','statistics','<p>This module shows information about your server installation together with statistics on the Web site users, number of Articles in your database and the number of Web links you provide.</p><div class=\"sample-module\">{loadmodule mod_stats,Statistics}</div>','',1,67,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,5,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (45,143,'Syndicate Module','syndicate-module','<p>The syndicate module will display a link that allows users to take a feed from your site. It will only display on pages for which feeds are possible. That means it will not display on single article, contact or weblinks pages, such as this one. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Syndication_Feeds\" title=\"Synicate Module\">Help</a></p><div class=\"sample-module\">{loadposition syndicate,Syndicate}</div>','',1,67,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,6,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (46,144,'System','system','<p>System plugins operate every time a page on your site loads. They control such things as your URLS, whether users can check a \"remember me\" box on the login module, and whether caching is enabled. New is the redirect plugin that together with the redirect component will assist you in managing changes in URLs.</p><p>Default on:</p><ul><li>Remember me <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#System_-_Remember_Me\">Help</a></li><li>SEF <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#System_-_SEF\">Help</a></li><li>Debug <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#System_-_Debug\">Help</a></li></ul><p>Default off:</p><ul><li>Cache <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#System_-_Cache\">Help</a></li><li>Log <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#System_-_Log\">Help</a></li><li>Redirect <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#System_-_Redirect\">Help</a></li></ul>','',1,25,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,2,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (47,145,'The Joomla! Community','the-joomla-community','<p>Joomla means All Together, and it is a community of people all working and having fun together that makes Joomla possible. Thousands of people each year participate in the Joomla community, and we hope you will be one of them.</p><p>People with all kinds of skills, of all skill levels and from around the world are welcome to join in. Participate in the <a href=\"http://joomla.org\">Joomla.org</a> family of websites (the<a href=\"http://forum.joomla.org\"> forum </a>is a great place to start). Come to a <a href=\"http://community.joomla.org/events.html\">Joomla! event</a>. Join or start a <a href=\"http://community.joomla.org/user-groups.html\">Joomla! Users Group</a>. Whether you are a developer, site administrator, designer, end user or fan, there are ways for you to participate and contribute.</p>','',1,19,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,3,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (48,146,'The Joomla! Project','the-joomla-project','<p>The Joomla Project consists of all of the people who make and support the Joomla Web Platform and Content Management System.</p><p>Our mission is to provide a flexible platform for digital publishing and collaboration.</p><p>The core values are:</p><ul><li>Freedom</li><li>Equality</li><li>Trust</li><li>Community</li><li>Collaboration</li><li>Usability</li></ul><p>In our vision, we see:</p><ul><li>People publishing and collaborating in their communities and around the world</li><li>Software that is free, secure, and high-quality</li><li>A community that is enjoyable and rewarding to participate in</li><li>People around the world using their preferred languages</li><li>A project that acts autonomously</li><li>A project that is socially responsible</li><li>A project dedicated to maintaining the trust of its users</li></ul><p>There are millions of users around the world and thousands of people who contribute to the Joomla Project. They work in three main groups: the Production Working Group, responsible for everything that goes into software and documentation; the Community Working Group, responsible for creating a nurturing the community; and Open Source Matters, the non profit organization responsible for managing legal, financial and organizational issues.</p><p>Joomla is a free and open source project, which uses the GNU General Public License version 2 or later.</p>','',1,19,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,1,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (49,147,'Typography','typography','<h1>H1 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h1><h2>H2 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h2><h3>H3 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h3><h4>H4 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h4><h5>H5 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h5><h6>H6 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h6><p>P The quick brown fox ran over the lazy dog. THE QUICK BROWN FOX RAN OVER THE LAZY DOG.</p><ul><li>Item</li><li>Item</li><li>Item<br /> <ul><li>Item</li><li>Item</li><li>Item<br /> <ul><li>Item</li><li>Item</li><li>Item</li></ul></li></ul></li></ul><ol><li>tem</li><li>Item</li><li>Item<br /> <ol><li>Item</li><li>Item</li><li>Item<br /><ol><li>Item</li><li>Item</li><li>Item</li></ol></li></ol> </li></ol>','',1,23,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,1,'','',1,8,'',0,'*',''),
  (50,148,'Upgraders','upgraders','<p>If you are an experienced Joomla! user, this Joomla site will seem very familiar but also very different. The biggest change is the new administrator interface and the adoption of responsive design. Hundreds of other improvements have been made.</p><p></p><p></p>','',1,19,'2011-01-01 00:00:01',540,'Joomla','2012-09-25 07:12:10',123,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":null,\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":null,\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":null,\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"0\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,6,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',1,'*',''),
  (51,149,'User','user-plugins','<p>Default on:</p><ul><li>Joomla <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#User_-_Joomla.21\">Help</a></li></ul><p>Default off:</p><p>Two new plugins are available but are disabled by default.</p><ul><li>Contact Creator <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#User_-_Contact_Creator\">Help</a><br />Creates a new linked contact record for each new user created.</li><li>Profile <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#User_-_Profile\">Help</a><br />This example profile plugin allows you to insert additional fields into user registration and profile display. This is intended as an example of the types of extensions to the profile you might want to create.</li></ul>','',1,25,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,4,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (52,150,'Users','users-component','<p>The users extension lets your site visitors register, login and logout, change their passwords and other information, and recover lost passwords. In the administrator it allows you to create, block and manage users and create user groups and access levels. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Users_User_Manager\">Help</a></p><p>Please note that some of the user views will not display if you are not logged-in to the site.</p>','',1,21,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',1,5,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (53,151,'Using Joomla!','using-joomla','<p>With Joomla you can create anything from a simple personal website to a complex ecommerce or social site with millions of visitors.</p><p>This section of the sample data provides you with a brief introduction to Joomla concepts and reference material to help you understand how Joomla works.</p><p><em>When you no longer need the sample data, you can can simply unpublish the sample data category found within each extension in the site administrator or you may completely delete each item and all of the categories. </em></p>','',1,19,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,7,'','',1,5,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (56,154,'Who''s Online','whos-online','<p>The Who''s Online Module displays the number of Anonymous Users (e.g. Guests) and Registered Users (ones logged-in) that are currently accessing the Web site. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Who_Online\" title=\"Who''s Online\">Help</a></p><div class=\"sample-module\">{loadmodule whosonline,Who''s Online}</div>','',1,65,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,1,'','',1,0,'',0,'*',''),
  (57,155,'Wobbegone','wobbegone','<p> </p>','<p> </p>',1,72,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"images\\/sampledata\\/parks\\/animals\\/180px_wobbegong.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Wobbegon\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/animals\\/800px_wobbegong.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Wobbegon\",\"image_fulltext_caption\":\"Source: http:\\/\\/en.wikipedia.org\\/wiki\\/File:Wobbegong.jpg Author: Richard Ling Rights: GNU Free Documentation License v 1.2 or later\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,1,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (58,156,'Wonderful Watermelon','wonderful-watermelon','<p>Watermelon is a wonderful and healthy treat. We grow the world''s sweetest watermelon. We have the largest watermelon patch in our country.</p>','',1,30,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,1,'','',1,0,'',0,'*',''),
  (59,157,'Wrapper Module','wrapper-module','<p>This module shows an iFrame window to specified location. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Wrapper\" title=\"Wrapper Module\">Help</a></p><div class=\"sample-module\">{loadmodule wrapper,Wrapper}</div>','',1,67,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,1,'','',1,0,'',0,'*',''),
  (60,158,'News Feeds','news-feeds','<p>News Feeds (com_newsfeeds) provides a way to organize and present news feeds. News feeds are a way that you present information from another site on your site. For example, the joomla.org website has numerous feeds that you can incorporate on your site. You an use menus to present a single feed, a list of feeds in a category, or a list of all feed categories. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Components_Newsfeeds_Feeds\">Help</a></p>','',1,21,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,4,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (61,159,'Breadcrumbs Module','breadcrumbs-module','<p>Breadcrumbs provide a pathway for users to navigate through the site. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Breadcrumbs\" title=\"Breacrumbs Module\">Help</a></p><div class=\"sample-module\">{loadmodule breadcrumbs,breadcrumbs}</div>','',1,75,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',1,2,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (62,160,'Content','content-plugins','<p>Content plugins run when specific kinds of pages are loaded. They do things ranging from protecting email addresses from harvesters to creating page breaks.</p><p>Default on:</p><ul><li>Email Cloaking <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Content_-_Email_Cloaking\">Help</a></li><li>Load Module <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Content_-_Load_Modules\">Help</a></li><li>Page Break <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Content_-_Pagebreak\">Help</a></li><li>Page Navigation<a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Content_-_Page_Navigation\"> Help</a></li><li>Vote <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit#Content_-_Vote\">Help</a></li></ul>','',1,25,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,7,'','',1,0,'',0,'*',''),
  (64,162,'Blue Mountain Rain Forest','blue-mountain-rain-forest','<p> </p>','<p> </p>',1,73,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"images\\/sampledata\\/parks\\/landscape\\/120px_rainforest_bluemountainsnsw.jpg\",\"float_intro\":\"none\",\"image_intro_alt\":\"Rain Forest Blue Mountains\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/landscape\\/727px_rainforest_bluemountainsnsw.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Rain Forest Blue Mountains\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Rainforest,bluemountainsNSW.jpg Author: Adam J.W.C. License: GNU Free Documentation License\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,2,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (65,163,'Ormiston Pound','ormiston-pound','<p> </p>','<p> </p>',1,73,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','{\"image_intro\":\"images\\/sampledata\\/parks\\/landscape\\/180px_ormiston_pound.jpg\",\"float_intro\":\"none\",\"image_intro_alt\":\"Ormiston Pound\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/landscape\\/800px_ormiston_pound.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Ormiston Pound\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Ormiston_Pound.JPG Author: License: GNU Free Public Documentation License\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,3,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (66,165,'Latest Users Module','latest-users-module','<p>This module displays the latest registered users. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help31:Extensions_Module_Manager_Latest_Users\">Help</a></p><div class=\"sample-module\">{loadmodule users_latest,Users Latest}</div>','',1,65,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"1\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,3,'','',1,0,'',0,'*',''),
  (67,168,'What''s New in 1.5?','whats-new-in-15','<p>This article deliberately archived as an example.</p><p>As with previous releases, Joomla! provides a unified and easy-to-use framework for delivering content for Web sites of all kinds. To support the changing nature of the Internet and emerging Web technologies, Joomla! required substantial restructuring of its core functionality and we also used this effort to simplify many challenges within the current user interface. Joomla! 1.5 has many new features.</p><p style=\"margin-bottom: 0in;\">In Joomla! 1.5, you''''ll notice:</p><ul><li>Substantially improved usability, manageability, and scalability far beyond the original Mambo foundations</li><li>Expanded accessibility to support internationalisation, double-byte characters and right-to-left support for Arabic, Farsi, and Hebrew languages among others</li><li>Extended integration of external applications through Web services</li><li>Enhanced content delivery, template and presentation capabilities to support accessibility standards and content delivery to any destination</li><li>A more sustainable and flexible framework for Component and Extension developers</li><li>Backward compatibility with previous releases of Components, Templates, Modules, and other Extensions</li></ul>','',2,9,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2011-01-01 00:00:01','0000-00-00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,0,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (68,170,'Captcha','captcha','<p>The Captcha plugins are used to prevent spam submissions on your forms such as registration, contact and login. You basic installation of Joomla includes one Captcha plugin which leverages the ReCaptcha&reg; service but you may install other plugins connecting to different Captcha systems.</p><p>Default on:</p><ul><li>ReCaptcha <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit\">help</a></li></ul><p>Note: ReCaptcha is a the trademark of Google Inc. and is an independent product not associated with or endorsed by the Joomla Project. You will need to register and agree to the Terms of Service at Recaptcha.net to use this plugin. Complete instructions are available if you edit the ReCaptcha plugin in the Plugin Manager.</p>','',1,25,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2012-01-17 03:20:45','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,1,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (69,171,'Quick Icons','quick-icons','<p> The Quick Icon plugin group is used to provide notification that updates to Joomla! or installed extensions are available and should be applied. These notifications display on your administrator control panel, which is the page you see when you first log in to your site administrator.</p><p>Default on:</p><ul><li>Quick icon - Joomla! extensions updates notification <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit\">Help</a>.</li><li>Quick icon - Joomla! update notification <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Plugin_Manager_Edit\">Help</a></li></ul>','',1,25,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2012-01-17 03:27:39','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,0,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (70,170,'Smart Search','smart-search','<p>This module provides search using the Smart Search component. You should only use it if you have indexed your content and either have enabled the Smart Search content plugin or are keeping the index of your site updated manually. <a href=\"https://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help31:Extensions_Module_Manager_Smart_Search\">Help</a>.</p><div class=\"sample-module\">{loadmodule finder,Smart Search}</div>','',1,67,'2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,0,'0000-00-00','2012-01-17 03:42:36','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,0,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),
  (71,181,'MINCOM','mincom','','',1,14,'2015-11-26 09:17:41',540,'','2016-02-22 13:29:15',540,0,'0000-00-00','2015-11-26 09:17:41','0000-00-00','{\"image_intro\":\"\",\"float_intro\":\"left\",\"image_intro_alt\":\"\\tTomar en cuenta las tendencias mundiales en la esfera de la organización del desarrollo científico y tecnológico en una época de creciente globalización del mismo. \\tSubrayar el papel de la empresa en los procesos de innovación tecnológica, incluso como agente financiador de proyectos. \\tSubrayar la búsqueda de efectividad y competitividad de la misma y va contra el estereotipo de la empresa estatal ineficiente. \\tTomar en cuenta la existencia de elementos de mercado en el sistema económico cubano. \\tDenotar el reconocimiento de que la innovación tecnológica tiene otras fuentes además de la I+D y, por tanto, múltiples agentes. \\tComportar un énfasis en el financiamiento por proyectos respecto al financiamiento institucional. \\tReforzar el principio de evaluación integral ex-ante de los impactos de los proyectos. \\tFormar parte de una estrategia de preservación del poder popular, necesario para continuar el proyecto socialista cubano.\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/logo.jpg\",\"float_fulltext\":\"right\",\"image_fulltext_alt\":\"El Ministerio de la Informática y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la política del Estado y el Gobierno para el Sistema Único de Comunicaciones del País, que comprende las telecomunicaciones, la informática, las radiocomunicaciones, los servicios postales, la automática para los sistemas de comunicaciones, la gestión del espectro radioeléctrico y el aseguramiento técnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\",\"image_fulltext_caption\":\"El Ministerio de la Informática y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la política del Estado y el Gobierno para el Sistema Único de Comunicaciones del País, que comprende las telecomunicaciones, la informática, las radiocomunicaciones, los servicios postales, la automática para los sistemas de comunicaciones, la gestión del espectro radioeléctrico y el aseguramiento técnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\"}','{\"urla\":false,\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"http:\\/\\/www.mic.gov.cu\\/sitiomic\\/servlet\\/home\",\"urlbtext\":\"El Ministerio de la Informática y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la política del Estado y el Gobierno para el Sistema Único de Comunicaciones del País, que comprende las telecomunicaciones, la informática, las radiocomunicaciones, los servicios postales, la automática para los sistemas de comunicaciones, la gestión del espectro radioeléctrico y el aseguramiento técnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\",\"targetb\":\"2\",\"urlc\":false,\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"0\",\"link_titles\":\"0\",\"show_intro\":\"0\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_vote\":\"0\",\"show_hits\":\"0\",\"show_noauth\":\"0\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"0\",\"show_article_options\":\"0\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"0\"}',24,0,'','',1,1188,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*','');

COMMIT;

#
# Data for the `gir_content_frontpage` table  (LIMIT 0,500)
#

INSERT INTO `gir_content_frontpage` (`content_id`, `ordering`) VALUES 
  (8,2),
  (24,1),
  (35,4),
  (50,3);

COMMIT;

#
# Data for the `gir_content_types` table  (LIMIT 0,500)
#

INSERT INTO `gir_content_types` (`type_id`, `type_title`, `type_alias`, `table`, `rules`, `field_mappings`, `router`, `content_history_options`) VALUES 
  (1,'Article','com_content.article','{\"special\":{\"dbtable\":\"#__content\",\"key\":\"id\",\"type\":\"Content\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"state\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"introtext\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"attribs\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"urls\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"asset_id\"}, \"special\":{\"fulltext\":\"fulltext\"}}','ContentHelperRoute::getArticleRoute','{\"formFile\":\"administrator\\/components\\/com_content\\/models\\/forms\\/article.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\"],\"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"],\"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}'),
  (2,'Contact','com_contact.contact','{\"special\":{\"dbtable\":\"#__contact_details\",\"key\":\"id\",\"type\":\"Contact\",\"prefix\":\"ContactTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"address\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"image\", \"core_urls\":\"webpage\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"null\"}, \"special\":{\"con_position\":\"con_position\",\"suburb\":\"suburb\",\"state\":\"state\",\"country\":\"country\",\"postcode\":\"postcode\",\"telephone\":\"telephone\",\"fax\":\"fax\",\"misc\":\"misc\",\"email_to\":\"email_to\",\"default_con\":\"default_con\",\"user_id\":\"user_id\",\"mobile\":\"mobile\",\"sortname1\":\"sortname1\",\"sortname2\":\"sortname2\",\"sortname3\":\"sortname3\"}}','ContactHelperRoute::getContactRoute','{\"formFile\":\"administrator\\/components\\/com_contact\\/models\\/forms\\/contact.xml\",\"hideFields\":[\"default_con\",\"checked_out\",\"checked_out_time\",\"version\",\"xreference\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\"],\"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"], \"displayLookup\":[ {\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ] }'),
  (3,'Newsfeed','com_newsfeeds.newsfeed','{\"special\":{\"dbtable\":\"#__newsfeeds\",\"key\":\"id\",\"type\":\"Newsfeed\",\"prefix\":\"NewsfeedsTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"link\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"null\"}, \"special\":{\"numarticles\":\"numarticles\",\"cache_time\":\"cache_time\",\"rtl\":\"rtl\"}}','NewsfeedsHelperRoute::getNewsfeedRoute','{\"formFile\":\"administrator\\/components\\/com_newsfeeds\\/models\\/forms\\/newsfeed.xml\",\"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\"],\"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"],\"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}'),
  (4,'User','com_users.user','{\"special\":{\"dbtable\":\"#__users\",\"key\":\"id\",\"type\":\"User\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"null\",\"core_alias\":\"username\",\"core_created_time\":\"registerdate\",\"core_modified_time\":\"lastvisitDate\",\"core_body\":\"null\", \"core_hits\":\"null\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"access\":\"null\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"null\", \"core_language\":\"null\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"null\", \"core_ordering\":\"null\", \"core_metakey\":\"null\", \"core_metadesc\":\"null\", \"core_catid\":\"null\", \"core_xreference\":\"null\", \"asset_id\":\"null\"}, \"special\":{}}','UsersHelperRoute::getUserRoute',''),
  (5,'Article Category','com_content.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','ContentHelperRoute::getCategoryRoute','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}'),
  (6,'Contact Category','com_contact.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','ContactHelperRoute::getCategoryRoute','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}'),
  (7,'Newsfeeds Category','com_newsfeeds.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','NewsfeedsHelperRoute::getCategoryRoute','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}'),
  (8,'Tag','com_tags.tag','{\"special\":{\"dbtable\":\"#__tags\",\"key\":\"tag_id\",\"type\":\"Tag\",\"prefix\":\"TagsTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"urls\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"null\", \"core_xreference\":\"null\", \"asset_id\":\"null\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\"}}','TagsHelperRoute::getTagRoute','{\"formFile\":\"administrator\\/components\\/com_tags\\/models\\/forms\\/tag.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\",\"version\", \"lft\", \"rgt\", \"level\", \"path\", \"urls\", \"publish_up\", \"publish_down\"],\"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}, {\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}]}'),
  (9,'Banner','com_banners.banner','{\"special\":{\"dbtable\":\"#__banners\",\"key\":\"id\",\"type\":\"Banner\",\"prefix\":\"BannersTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"description\", \"core_hits\":\"null\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"link\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"null\", \"asset_id\":\"null\"}, \"special\":{\"imptotal\":\"imptotal\", \"impmade\":\"impmade\", \"clicks\":\"clicks\", \"clickurl\":\"clickurl\", \"custombannercode\":\"custombannercode\", \"cid\":\"cid\", \"purchase_type\":\"purchase_type\", \"track_impressions\":\"track_impressions\", \"track_clicks\":\"track_clicks\"}}','','{\"formFile\":\"administrator\\/components\\/com_banners\\/models\\/forms\\/banner.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\",\"version\", \"reset\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"imptotal\", \"impmade\", \"reset\"], \"convertToInt\":[\"publish_up\", \"publish_down\", \"ordering\"], \"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}, {\"sourceColumn\":\"cid\",\"targetTable\":\"#__banner_clients\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}'),
  (10,'Banners Category','com_banners.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\": {\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"], \"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}'),
  (11,'Banner Client','com_banners.client','{\"special\":{\"dbtable\":\"#__banner_clients\",\"key\":\"id\",\"type\":\"Client\",\"prefix\":\"BannersTable\"}}','','','','{\"formFile\":\"administrator\\/components\\/com_banners\\/models\\/forms\\/client.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\"], \"ignoreChanges\":[\"checked_out\", \"checked_out_time\"], \"convertToInt\":[], \"displayLookup\":[]}'),
  (12,'User Notes','com_users.note','{\"special\":{\"dbtable\":\"#__user_notes\",\"key\":\"id\",\"type\":\"Note\",\"prefix\":\"UsersTable\"}}','','','','{\"formFile\":\"administrator\\/components\\/com_users\\/models\\/forms\\/note.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\", \"publish_up\", \"publish_down\"],\"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\"], \"convertToInt\":[\"publish_up\", \"publish_down\"],\"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}, {\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}]}'),
  (13,'User Notes Category','com_users.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"], \"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}');

COMMIT;

#
# Data for the `gir_csoap_webservices` table  (LIMIT 0,500)
#

INSERT INTO `gir_csoap_webservices` (`id`, `title`, `alias`, `namespace`, `state`, `checked_out`, `checked_out_time`, `access`, `ordering`, `archived`, `approved`, `params`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `metadata`, `publish_up`, `publish_down`) VALUES 
  (1,'Hello World','helloworld','helloworld',1,0,'0000-00-00',1,1,0,1,'{}','2012-07-20 14:13:07',42,'','2012-07-20 16:08:15',42,'','0000-00-00','0000-00-00'),
  (2,'Hello Complex World','hellocomplexworld','hellocomplexworld',1,0,'0000-00-00',1,1,0,1,'{}','2012-07-20 14:13:07',42,'','2012-07-20 16:08:15',42,'','0000-00-00','0000-00-00');

COMMIT;

#
# Data for the `gir_extensions` table  (LIMIT 0,500)
#

INSERT INTO `gir_extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES 
  (1,'com_mailto','component','com_mailto','',0,1,1,1,'{\"name\":\"com_mailto\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MAILTO_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mailto\"}','','','',0,'0000-00-00',0,0),
  (2,'com_wrapper','component','com_wrapper','',0,1,1,1,'{\"name\":\"com_wrapper\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_WRAPPER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"wrapper\"}','','','',0,'0000-00-00',0,0),
  (3,'com_admin','component','com_admin','',1,1,1,1,'{\"name\":\"com_admin\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_ADMIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (4,'com_banners','component','com_banners','',1,1,1,0,'{\"name\":\"com_banners\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_BANNERS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"banners\"}','{\"purchase_type\":\"3\",\"track_impressions\":\"0\",\"track_clicks\":\"0\",\"metakey_prefix\":\"\",\"save_history\":\"1\",\"history_limit\":10}','','',0,'0000-00-00',0,0),
  (5,'com_cache','component','com_cache','',1,1,1,1,'{\"name\":\"com_cache\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CACHE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (6,'com_categories','component','com_categories','',1,1,1,1,'{\"name\":\"com_categories\",\"type\":\"component\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (7,'com_checkin','component','com_checkin','',1,1,1,1,'{\"name\":\"com_checkin\",\"type\":\"component\",\"creationDate\":\"Unknown\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CHECKIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (8,'com_contact','component','com_contact','',1,1,1,0,'{\"name\":\"com_contact\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CONTACT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contact\"}','{\"show_contact_category\":\"hide\",\"save_history\":\"1\",\"history_limit\":10,\"show_contact_list\":\"0\",\"presentation_style\":\"sliders\",\"show_name\":\"1\",\"show_position\":\"1\",\"show_email\":\"0\",\"show_street_address\":\"1\",\"show_suburb\":\"1\",\"show_state\":\"1\",\"show_postcode\":\"1\",\"show_country\":\"1\",\"show_telephone\":\"1\",\"show_mobile\":\"1\",\"show_fax\":\"1\",\"show_webpage\":\"1\",\"show_misc\":\"1\",\"show_image\":\"1\",\"image\":\"\",\"allow_vcard\":\"0\",\"show_articles\":\"0\",\"show_profile\":\"0\",\"show_links\":\"0\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"contact_icons\":\"0\",\"icon_address\":\"\",\"icon_email\":\"\",\"icon_telephone\":\"\",\"icon_mobile\":\"\",\"icon_fax\":\"\",\"icon_misc\":\"\",\"show_headings\":\"1\",\"show_position_headings\":\"1\",\"show_email_headings\":\"0\",\"show_telephone_headings\":\"1\",\"show_mobile_headings\":\"0\",\"show_fax_headings\":\"0\",\"allow_vcard_headings\":\"0\",\"show_suburb_headings\":\"1\",\"show_state_headings\":\"1\",\"show_country_headings\":\"1\",\"show_email_form\":\"1\",\"show_email_copy\":\"1\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"1\",\"custom_reply\":\"0\",\"redirect\":\"\",\"show_category_crumb\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}','','',0,'0000-00-00',0,0),
  (9,'com_cpanel','component','com_cpanel','',1,1,1,1,'{\"name\":\"com_cpanel\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CPANEL_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (10,'com_installer','component','com_installer','',1,1,1,1,'{\"name\":\"com_installer\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_INSTALLER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (11,'com_languages','component','com_languages','',1,1,1,1,'{\"name\":\"com_languages\",\"type\":\"component\",\"creationDate\":\"2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\"}','{\"administrator\":\"en-GB\",\"site\":\"es-ES\"}','','',0,'0000-00-00',0,0),
  (12,'com_login','component','com_login','',1,1,1,1,'{\"name\":\"com_login\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (13,'com_media','component','com_media','',1,1,0,1,'{\"name\":\"com_media\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MEDIA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"media\"}','{\"upload_extensions\":\"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS\",\"upload_maxsize\":\"10\",\"file_path\":\"images\",\"image_path\":\"images\",\"restrict_uploads\":\"1\",\"check_mime\":\"1\",\"image_extensions\":\"bmp,gif,jpg,png\",\"ignore_extensions\":\"\",\"upload_mime\":\"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip\",\"upload_mime_illegal\":\"text\\/html\"}','','',0,'0000-00-00',0,0),
  (14,'com_menus','component','com_menus','',1,1,1,1,'{\"name\":\"com_menus\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MENUS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (15,'com_messages','component','com_messages','',1,1,1,1,'{\"name\":\"com_messages\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MESSAGES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (16,'com_modules','component','com_modules','',1,1,1,1,'{\"name\":\"com_modules\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MODULES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (17,'com_newsfeeds','component','com_newsfeeds','',1,1,1,0,'{\"name\":\"com_newsfeeds\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"newsfeeds\"}','{\"newsfeed_layout\":\"_:default\",\"save_history\":\"1\",\"history_limit\":5,\"show_feed_image\":\"1\",\"show_feed_description\":\"1\",\"show_item_description\":\"1\",\"feed_character_count\":\"0\",\"feed_display_order\":\"des\",\"float_first\":\"right\",\"float_second\":\"right\",\"show_tags\":\"1\",\"category_layout\":\"_:default\",\"show_category_title\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"0\",\"show_subcat_desc\":\"1\",\"show_cat_items\":\"1\",\"show_cat_tags\":\"1\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"0\",\"show_subcat_desc_cat\":\"1\",\"show_cat_items_cat\":\"1\",\"filter_field\":\"1\",\"show_pagination_limit\":\"1\",\"show_headings\":\"1\",\"show_articles\":\"0\",\"show_link\":\"1\",\"show_pagination\":\"1\",\"show_pagination_results\":\"1\"}','','',0,'0000-00-00',0,0),
  (18,'com_plugins','component','com_plugins','',1,1,1,1,'{\"name\":\"com_plugins\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_PLUGINS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (19,'com_search','component','com_search','',1,1,1,0,'{\"name\":\"com_search\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_SEARCH_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"search\"}','{\"enabled\":\"0\",\"show_date\":\"1\"}','','',0,'0000-00-00',0,0),
  (20,'com_templates','component','com_templates','',1,1,1,1,'{\"name\":\"com_templates\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_TEMPLATES_XML_DESCRIPTION\",\"group\":\"\"}','{\"template_positions_display\":\"0\",\"upload_limit\":\"2\",\"image_formats\":\"gif,bmp,jpg,jpeg,png\",\"source_formats\":\"txt,less,ini,xml,js,php,css\",\"font_formats\":\"woff,ttf,otf\",\"compressed_formats\":\"zip\"}','','',0,'0000-00-00',0,0),
  (22,'com_content','component','com_content','',1,1,0,1,'{\"name\":\"com_content\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CONTENT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"content\"}','{\"article_layout\":\"_:default\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"1\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"1\",\"show_item_navigation\":\"1\",\"show_vote\":\"0\",\"show_readmore\":\"1\",\"show_readmore_title\":\"1\",\"readmore_limit\":\"100\",\"show_icons\":\"1\",\"show_print_icon\":\"1\",\"show_email_icon\":\"1\",\"show_hits\":\"1\",\"show_noauth\":\"0\",\"show_publishing_options\":\"1\",\"show_article_options\":\"1\",\"save_history\":\"1\",\"history_limit\":10,\"show_urls_images_frontend\":\"0\",\"show_urls_images_backend\":\"1\",\"targeta\":0,\"targetb\":0,\"targetc\":0,\"float_intro\":\"left\",\"float_fulltext\":\"left\",\"category_layout\":\"_:blog\",\"show_category_title\":\"0\",\"show_description\":\"0\",\"show_description_image\":\"0\",\"maxLevel\":\"1\",\"show_empty_categories\":\"0\",\"show_no_articles\":\"1\",\"show_subcat_desc\":\"1\",\"show_cat_num_articles\":\"0\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"0\",\"show_subcat_desc_cat\":\"1\",\"show_cat_num_articles_cat\":\"1\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"0\",\"show_subcategory_content\":\"0\",\"show_pagination_limit\":\"1\",\"filter_field\":\"hide\",\"show_headings\":\"1\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"1\",\"list_show_author\":\"1\",\"orderby_pri\":\"order\",\"orderby_sec\":\"rdate\",\"order_date\":\"published\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"show_feed_link\":\"1\",\"feed_summary\":\"0\"}','','',0,'0000-00-00',0,0),
  (23,'com_config','component','com_config','',1,1,0,1,'{\"name\":\"com_config\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CONFIG_XML_DESCRIPTION\",\"group\":\"\"}','{\"filters\":{\"1\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"13\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"6\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"7\":{\"filter_type\":\"NONE\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"21\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"23\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"22\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"18\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"17\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"2\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"3\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"4\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"5\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"10\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"12\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"19\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"20\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"8\":{\"filter_type\":\"NONE\",\"filter_tags\":\"\",\"filter_attributes\":\"\"}}}','','',0,'0000-00-00',0,0),
  (24,'com_redirect','component','com_redirect','',1,1,0,1,'{\"name\":\"com_redirect\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_REDIRECT_XML_DESCRIPTION\",\"group\":\"\"}','{\"mode\":\"1\"}','','',0,'0000-00-00',0,0),
  (25,'com_users','component','com_users','',1,1,0,1,'{\"name\":\"com_users\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_USERS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"users\"}','{\"allowUserRegistration\":\"0\",\"new_usertype\":\"2\",\"guest_usergroup\":\"13\",\"sendpassword\":\"1\",\"useractivation\":\"1\",\"mail_to_admin\":\"0\",\"captcha\":\"\",\"frontend_userparams\":\"1\",\"site_language\":\"0\",\"change_login_name\":\"0\",\"reset_count\":\"10\",\"reset_time\":\"1\",\"minimum_length\":\"4\",\"minimum_integers\":\"0\",\"minimum_symbols\":\"0\",\"minimum_uppercase\":\"0\",\"save_history\":\"1\",\"history_limit\":5,\"mailSubjectPrefix\":\"\",\"mailBodySuffix\":\"\"}','','',0,'0000-00-00',0,0),
  (27,'com_finder','component','com_finder','',1,1,0,0,'{\"name\":\"com_finder\",\"type\":\"component\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_FINDER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"finder\"}','{\"enabled\":\"1\",\"show_description\":\"1\",\"description_length\":255,\"allow_empty_query\":\"0\",\"show_url\":\"1\",\"show_autosuggest\":\"1\",\"show_suggested_query\":\"1\",\"show_explained_query\":\"1\",\"show_advanced\":\"1\",\"show_advanced_tips\":\"1\",\"expand_advanced\":\"0\",\"show_date_filters\":\"0\",\"sort_order\":\"relevance\",\"sort_direction\":\"desc\",\"highlight_terms\":\"1\",\"opensearch_name\":\"\",\"opensearch_description\":\"\",\"batch_size\":\"50\",\"memory_table_limit\":30000,\"title_multiplier\":\"1.7\",\"text_multiplier\":\"0.7\",\"meta_multiplier\":\"1.2\",\"path_multiplier\":\"2.0\",\"misc_multiplier\":\"0.3\",\"stem\":\"1\",\"stemmer\":\"snowball\",\"enable_logging\":\"0\"}','','',0,'0000-00-00',0,0),
  (28,'com_joomlaupdate','component','com_joomlaupdate','',1,1,0,1,'{\"name\":\"com_joomlaupdate\",\"type\":\"component\",\"creationDate\":\"February 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (29,'com_tags','component','com_tags','',1,1,1,1,'{\"name\":\"com_tags\",\"type\":\"component\",\"creationDate\":\"December 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.1.0\",\"description\":\"COM_TAGS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"tags\"}','{\"tag_layout\":\"_:default\",\"save_history\":\"1\",\"history_limit\":5,\"show_tag_title\":\"0\",\"tag_list_show_tag_image\":\"0\",\"tag_list_show_tag_description\":\"0\",\"tag_list_image\":\"\",\"show_tag_num_items\":\"0\",\"tag_list_orderby\":\"title\",\"tag_list_orderby_direction\":\"ASC\",\"show_headings\":\"0\",\"tag_list_show_date\":\"0\",\"tag_list_show_item_image\":\"0\",\"tag_list_show_item_description\":\"0\",\"tag_list_item_maximum_characters\":0,\"return_any_or_all\":\"1\",\"include_children\":\"0\",\"maximum\":200,\"tag_list_language_filter\":\"all\",\"tags_layout\":\"_:default\",\"all_tags_orderby\":\"title\",\"all_tags_orderby_direction\":\"ASC\",\"all_tags_show_tag_image\":\"0\",\"all_tags_show_tag_descripion\":\"0\",\"all_tags_tag_maximum_characters\":20,\"all_tags_show_tag_hits\":\"0\",\"filter_field\":\"1\",\"show_pagination_limit\":\"1\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"tag_field_ajax_mode\":\"1\",\"show_feed_link\":\"1\"}','','',0,'0000-00-00',0,0),
  (30,'com_contenthistory','component','com_contenthistory','',1,1,1,0,'{\"name\":\"com_contenthistory\",\"type\":\"component\",\"creationDate\":\"May 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"COM_CONTENTHISTORY_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contenthistory\"}','','','',0,'0000-00-00',0,0),
  (31,'com_ajax','component','com_ajax','',1,1,1,0,'{\"name\":\"com_ajax\",\"type\":\"component\",\"creationDate\":\"August 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"COM_AJAX_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"ajax\"}','','','',0,'0000-00-00',0,0),
  (32,'com_postinstall','component','com_postinstall','',1,1,1,1,'{\"name\":\"com_postinstall\",\"type\":\"component\",\"creationDate\":\"September 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"COM_POSTINSTALL_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (101,'SimplePie','library','simplepie','',0,1,1,1,'{\"name\":\"SimplePie\",\"type\":\"library\",\"creationDate\":\"2004\",\"author\":\"SimplePie\",\"copyright\":\"Copyright (c) 2004-2009, Ryan Parman and Geoffrey Sneddon\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/simplepie.org\\/\",\"version\":\"1.2\",\"description\":\"LIB_SIMPLEPIE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"simplepie\"}','','','',0,'0000-00-00',0,0),
  (102,'phputf8','library','phputf8','',0,1,1,1,'{\"name\":\"phputf8\",\"type\":\"library\",\"creationDate\":\"2006\",\"author\":\"Harry Fuecks\",\"copyright\":\"Copyright various authors\",\"authorEmail\":\"hfuecks@gmail.com\",\"authorUrl\":\"http:\\/\\/sourceforge.net\\/projects\\/phputf8\",\"version\":\"0.5\",\"description\":\"LIB_PHPUTF8_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"phputf8\"}','','','',0,'0000-00-00',0,0),
  (103,'Joomla! Platform','library','joomla','',0,1,1,1,'{\"name\":\"Joomla! Platform\",\"type\":\"library\",\"creationDate\":\"2008\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"http:\\/\\/www.joomla.org\",\"version\":\"13.1\",\"description\":\"LIB_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','{\"mediaversion\":\"507c3b055fdee45353ac4d7afc403aa5\"}','','',0,'0000-00-00',0,0),
  (104,'IDNA Convert','library','idna_convert','',0,1,1,1,'{\"name\":\"IDNA Convert\",\"type\":\"library\",\"creationDate\":\"2004\",\"author\":\"phlyLabs\",\"copyright\":\"2004-2011 phlyLabs Berlin, http:\\/\\/phlylabs.de\",\"authorEmail\":\"phlymail@phlylabs.de\",\"authorUrl\":\"http:\\/\\/phlylabs.de\",\"version\":\"0.8.0\",\"description\":\"LIB_IDNA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"idna_convert\"}','','','',0,'0000-00-00',0,0),
  (105,'FOF','library','fof','',0,1,1,1,'{\"name\":\"FOF\",\"type\":\"library\",\"creationDate\":\"2015-04-22 13:15:32\",\"author\":\"Nicholas K. Dionysopoulos \\/ Akeeba Ltd\",\"copyright\":\"(C)2011-2015 Nicholas K. Dionysopoulos\",\"authorEmail\":\"nicholas@akeebabackup.com\",\"authorUrl\":\"https:\\/\\/www.akeebabackup.com\",\"version\":\"2.4.3\",\"description\":\"LIB_FOF_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"fof\"}','','','',0,'0000-00-00',0,0),
  (106,'PHPass','library','phpass','',0,1,1,1,'{\"name\":\"PHPass\",\"type\":\"library\",\"creationDate\":\"2004-2006\",\"author\":\"Solar Designer\",\"copyright\":\"\",\"authorEmail\":\"solar@openwall.com\",\"authorUrl\":\"http:\\/\\/www.openwall.com\\/phpass\\/\",\"version\":\"0.3\",\"description\":\"LIB_PHPASS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"phpass\"}','','','',0,'0000-00-00',0,0),
  (200,'mod_articles_archive','module','mod_articles_archive','',0,1,1,0,'{\"name\":\"mod_articles_archive\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_ARCHIVE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_archive\"}','','','',0,'0000-00-00',0,0),
  (201,'mod_articles_latest','module','mod_articles_latest','',0,1,1,0,'{\"name\":\"mod_articles_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LATEST_NEWS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_latest\"}','','','',0,'0000-00-00',0,0),
  (202,'mod_articles_popular','module','mod_articles_popular','',0,1,1,0,'{\"name\":\"mod_articles_popular\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_popular\"}','','','',0,'0000-00-00',0,0),
  (203,'mod_banners','module','mod_banners','',0,1,1,0,'{\"name\":\"mod_banners\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_BANNERS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_banners\"}','','','',0,'0000-00-00',0,0),
  (204,'mod_breadcrumbs','module','mod_breadcrumbs','',0,1,1,1,'{\"name\":\"mod_breadcrumbs\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_BREADCRUMBS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_breadcrumbs\"}','','','',0,'0000-00-00',0,0),
  (205,'mod_custom','module','mod_custom','',0,1,1,1,'{\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_custom\"}','','','',0,'0000-00-00',0,0),
  (206,'mod_feed','module','mod_feed','',0,1,1,0,'{\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_feed\"}','','','',0,'0000-00-00',0,0),
  (207,'mod_footer','module','mod_footer','',0,1,1,0,'{\"name\":\"mod_footer\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FOOTER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_footer\"}','','','',0,'0000-00-00',0,0),
  (208,'mod_login','module','mod_login','',0,1,1,1,'{\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_login\"}','','','',0,'0000-00-00',0,0),
  (209,'mod_menu','module','mod_menu','',0,1,1,1,'{\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_menu\"}','','','',0,'0000-00-00',0,0),
  (210,'mod_articles_news','module','mod_articles_news','',0,1,1,0,'{\"name\":\"mod_articles_news\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_NEWS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_news\"}','','','',0,'0000-00-00',0,0),
  (211,'mod_random_image','module','mod_random_image','',0,1,1,0,'{\"name\":\"mod_random_image\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_RANDOM_IMAGE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_random_image\"}','','','',0,'0000-00-00',0,0),
  (212,'mod_related_items','module','mod_related_items','',0,1,1,0,'{\"name\":\"mod_related_items\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_RELATED_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_related_items\"}','','','',0,'0000-00-00',0,0),
  (213,'mod_search','module','mod_search','',0,1,1,0,'{\"name\":\"mod_search\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_SEARCH_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_search\"}','','','',0,'0000-00-00',0,0),
  (214,'mod_stats','module','mod_stats','',0,1,1,0,'{\"name\":\"mod_stats\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_STATS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_stats\"}','','','',0,'0000-00-00',0,0),
  (215,'mod_syndicate','module','mod_syndicate','',0,1,1,1,'{\"name\":\"mod_syndicate\",\"type\":\"module\",\"creationDate\":\"May 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_SYNDICATE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_syndicate\"}','','','',0,'0000-00-00',0,0),
  (216,'mod_users_latest','module','mod_users_latest','',0,1,1,0,'{\"name\":\"mod_users_latest\",\"type\":\"module\",\"creationDate\":\"December 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_USERS_LATEST_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_users_latest\"}','','','',0,'0000-00-00',0,0),
  (218,'mod_whosonline','module','mod_whosonline','',0,1,1,0,'{\"name\":\"mod_whosonline\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_WHOSONLINE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_whosonline\"}','','','',0,'0000-00-00',0,0),
  (219,'mod_wrapper','module','mod_wrapper','',0,1,1,0,'{\"name\":\"mod_wrapper\",\"type\":\"module\",\"creationDate\":\"October 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_WRAPPER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_wrapper\"}','','','',0,'0000-00-00',0,0),
  (220,'mod_articles_category','module','mod_articles_category','',0,1,1,0,'{\"name\":\"mod_articles_category\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_CATEGORY_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_category\"}','','','',0,'0000-00-00',0,0),
  (221,'mod_articles_categories','module','mod_articles_categories','',0,1,1,0,'{\"name\":\"mod_articles_categories\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_categories\"}','','','',0,'0000-00-00',0,0),
  (222,'mod_languages','module','mod_languages','',0,1,1,1,'{\"name\":\"mod_languages\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_languages\"}','','','',0,'0000-00-00',0,0),
  (223,'mod_finder','module','mod_finder','',0,1,0,0,'{\"name\":\"mod_finder\",\"type\":\"module\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FINDER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_finder\"}','','','',0,'0000-00-00',0,0),
  (300,'mod_custom','module','mod_custom','',1,1,1,1,'{\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_custom\"}','','','',0,'0000-00-00',0,0),
  (301,'mod_feed','module','mod_feed','',1,1,1,0,'{\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_feed\"}','','','',0,'0000-00-00',0,0),
  (302,'mod_latest','module','mod_latest','',1,1,1,0,'{\"name\":\"mod_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LATEST_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_latest\"}','','','',0,'0000-00-00',0,0),
  (303,'mod_logged','module','mod_logged','',1,1,1,0,'{\"name\":\"mod_logged\",\"type\":\"module\",\"creationDate\":\"January 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LOGGED_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_logged\"}','','','',0,'0000-00-00',0,0),
  (304,'mod_login','module','mod_login','',1,1,1,1,'{\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"March 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_login\"}','','','',0,'0000-00-00',0,0),
  (305,'mod_menu','module','mod_menu','',1,1,1,0,'{\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_menu\"}','','','',0,'0000-00-00',0,0),
  (307,'mod_popular','module','mod_popular','',1,1,1,0,'{\"name\":\"mod_popular\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_popular\"}','','','',0,'0000-00-00',0,0),
  (308,'mod_quickicon','module','mod_quickicon','',1,1,1,1,'{\"name\":\"mod_quickicon\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_QUICKICON_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_quickicon\"}','','','',0,'0000-00-00',0,0),
  (309,'mod_status','module','mod_status','',1,1,1,0,'{\"name\":\"mod_status\",\"type\":\"module\",\"creationDate\":\"Feb 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_STATUS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_status\"}','','','',0,'0000-00-00',0,0),
  (310,'mod_submenu','module','mod_submenu','',1,1,1,0,'{\"name\":\"mod_submenu\",\"type\":\"module\",\"creationDate\":\"Feb 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_SUBMENU_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_submenu\"}','','','',0,'0000-00-00',0,0),
  (311,'mod_title','module','mod_title','',1,1,1,0,'{\"name\":\"mod_title\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_TITLE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_title\"}','','','',0,'0000-00-00',0,0),
  (312,'mod_toolbar','module','mod_toolbar','',1,1,1,1,'{\"name\":\"mod_toolbar\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_TOOLBAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_toolbar\"}','','','',0,'0000-00-00',0,0),
  (313,'mod_multilangstatus','module','mod_multilangstatus','',1,1,1,0,'{\"name\":\"mod_multilangstatus\",\"type\":\"module\",\"creationDate\":\"September 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_MULTILANGSTATUS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_multilangstatus\"}','{\"cache\":\"0\"}','','',0,'0000-00-00',0,0),
  (314,'mod_version','module','mod_version','',1,1,1,0,'{\"name\":\"mod_version\",\"type\":\"module\",\"creationDate\":\"January 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_VERSION_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_version\"}','{\"format\":\"short\",\"product\":\"1\",\"cache\":\"0\"}','','',0,'0000-00-00',0,0),
  (315,'mod_stats_admin','module','mod_stats_admin','',1,1,1,0,'{\"name\":\"mod_stats_admin\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_STATS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_stats_admin\"}','{\"serverinfo\":\"0\",\"siteinfo\":\"0\",\"counter\":\"0\",\"increase\":\"0\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}','','',0,'0000-00-00',0,0),
  (316,'mod_tags_popular','module','mod_tags_popular','',0,1,1,0,'{\"name\":\"mod_tags_popular\",\"type\":\"module\",\"creationDate\":\"January 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.1.0\",\"description\":\"MOD_TAGS_POPULAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_tags_popular\"}','{\"maximum\":\"5\",\"timeframe\":\"alltime\",\"owncache\":\"1\"}','','',0,'0000-00-00',0,0),
  (317,'mod_tags_similar','module','mod_tags_similar','',0,1,1,0,'{\"name\":\"mod_tags_similar\",\"type\":\"module\",\"creationDate\":\"January 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.1.0\",\"description\":\"MOD_TAGS_SIMILAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_tags_similar\"}','{\"maximum\":\"5\",\"matchtype\":\"any\",\"owncache\":\"1\"}','','',0,'0000-00-00',0,0),
  (400,'plg_authentication_gmail','plugin','gmail','authentication',0,0,1,0,'{\"name\":\"plg_authentication_gmail\",\"type\":\"plugin\",\"creationDate\":\"February 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_GMAIL_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"gmail\"}','{\"applysuffix\":\"0\",\"suffix\":\"\",\"verifypeer\":\"1\",\"user_blacklist\":\"\"}','','',0,'0000-00-00',1,0),
  (401,'plg_authentication_joomla','plugin','joomla','authentication',0,1,1,1,'{\"name\":\"plg_authentication_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_AUTH_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','','','',0,'0000-00-00',0,0),
  (402,'plg_authentication_ldap','plugin','ldap','authentication',0,0,1,0,'{\"name\":\"plg_authentication_ldap\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_LDAP_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"ldap\"}','{\"host\":\"\",\"port\":\"389\",\"use_ldapV3\":\"0\",\"negotiate_tls\":\"0\",\"no_referrals\":\"0\",\"auth_method\":\"bind\",\"base_dn\":\"\",\"search_string\":\"\",\"users_dn\":\"\",\"username\":\"admin\",\"password\":\"bobby7\",\"ldap_fullname\":\"fullName\",\"ldap_email\":\"mail\",\"ldap_uid\":\"uid\"}','','',0,'0000-00-00',3,0),
  (403,'plg_content_contact','plugin','contact','content',0,1,1,0,'{\"name\":\"plg_content_contact\",\"type\":\"plugin\",\"creationDate\":\"January 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.2\",\"description\":\"PLG_CONTENT_CONTACT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contact\"}','','','',0,'0000-00-00',1,0),
  (404,'plg_content_emailcloak','plugin','emailcloak','content',0,1,1,0,'{\"name\":\"plg_content_emailcloak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_EMAILCLOAK_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"emailcloak\"}','{\"mode\":\"1\"}','','',0,'0000-00-00',1,0),
  (406,'plg_content_loadmodule','plugin','loadmodule','content',0,1,1,0,'{\"name\":\"plg_content_loadmodule\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_LOADMODULE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"loadmodule\"}','{\"style\":\"xhtml\"}','','',0,'2011-09-18 15:22:50',0,0),
  (407,'plg_content_pagebreak','plugin','pagebreak','content',0,1,1,0,'{\"name\":\"plg_content_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"pagebreak\"}','{\"title\":\"1\",\"multipage_toc\":\"1\",\"showall\":\"1\"}','','',0,'0000-00-00',4,0),
  (408,'plg_content_pagenavigation','plugin','pagenavigation','content',0,1,1,0,'{\"name\":\"plg_content_pagenavigation\",\"type\":\"plugin\",\"creationDate\":\"January 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_PAGENAVIGATION_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"pagenavigation\"}','{\"position\":\"1\"}','','',0,'0000-00-00',5,0),
  (409,'plg_content_vote','plugin','vote','content',0,1,1,0,'{\"name\":\"plg_content_vote\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_VOTE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"vote\"}','','','',0,'0000-00-00',6,0),
  (410,'plg_editors_codemirror','plugin','codemirror','editors',0,1,1,1,'{\"name\":\"plg_editors_codemirror\",\"type\":\"plugin\",\"creationDate\":\"28 March 2011\",\"author\":\"Marijn Haverbeke\",\"copyright\":\"Copyright (C) 2014 by Marijn Haverbeke <marijnh@gmail.com> and others\",\"authorEmail\":\"marijnh@gmail.com\",\"authorUrl\":\"http:\\/\\/codemirror.net\\/\",\"version\":\"5.6\",\"description\":\"PLG_CODEMIRROR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"codemirror\"}','{\"lineNumbers\":\"1\",\"lineWrapping\":\"1\",\"matchTags\":\"1\",\"matchBrackets\":\"1\",\"marker-gutter\":\"1\",\"autoCloseTags\":\"1\",\"autoCloseBrackets\":\"1\",\"autoFocus\":\"1\",\"theme\":\"default\",\"tabmode\":\"indent\"}','','',0,'0000-00-00',1,0),
  (411,'plg_editors_none','plugin','none','editors',0,1,1,1,'{\"name\":\"plg_editors_none\",\"type\":\"plugin\",\"creationDate\":\"September 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_NONE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"none\"}','','','',0,'0000-00-00',2,0),
  (412,'plg_editors_tinymce','plugin','tinymce','editors',0,1,1,0,'{\"name\":\"plg_editors_tinymce\",\"type\":\"plugin\",\"creationDate\":\"2005-2014\",\"author\":\"Moxiecode Systems AB\",\"copyright\":\"Moxiecode Systems AB\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"tinymce.moxiecode.com\",\"version\":\"4.1.7\",\"description\":\"PLG_TINY_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"tinymce\"}','{\"mode\":\"1\",\"skin\":\"0\",\"mobile\":\"0\",\"entity_encoding\":\"raw\",\"lang_mode\":\"1\",\"text_direction\":\"ltr\",\"content_css\":\"1\",\"content_css_custom\":\"\",\"relative_urls\":\"1\",\"newlines\":\"0\",\"invalid_elements\":\"script,applet,iframe\",\"extended_elements\":\"\",\"html_height\":\"550\",\"html_width\":\"750\",\"resizing\":\"1\",\"element_path\":\"1\",\"fonts\":\"1\",\"paste\":\"1\",\"searchreplace\":\"1\",\"insertdate\":\"1\",\"colors\":\"1\",\"table\":\"1\",\"smilies\":\"1\",\"hr\":\"1\",\"link\":\"1\",\"media\":\"1\",\"print\":\"1\",\"directionality\":\"1\",\"fullscreen\":\"1\",\"alignment\":\"1\",\"visualchars\":\"1\",\"visualblocks\":\"1\",\"nonbreaking\":\"1\",\"template\":\"1\",\"blockquote\":\"1\",\"wordcount\":\"1\",\"advlist\":\"1\",\"autosave\":\"1\",\"contextmenu\":\"1\",\"inlinepopups\":\"1\",\"custom_plugin\":\"\",\"custom_button\":\"\"}','','',0,'0000-00-00',3,0),
  (413,'plg_editors-xtd_article','plugin','article','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_article\",\"type\":\"plugin\",\"creationDate\":\"October 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_ARTICLE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"article\"}','','','',0,'0000-00-00',1,0),
  (414,'plg_editors-xtd_image','plugin','image','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_image\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_IMAGE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"image\"}','','','',0,'0000-00-00',2,0),
  (415,'plg_editors-xtd_pagebreak','plugin','pagebreak','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_EDITORSXTD_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"pagebreak\"}','','','',0,'0000-00-00',3,0),
  (416,'plg_editors-xtd_readmore','plugin','readmore','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_readmore\",\"type\":\"plugin\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_READMORE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"readmore\"}','','','',0,'0000-00-00',4,0),
  (417,'plg_search_categories','plugin','categories','search',0,1,1,0,'{\"name\":\"plg_search_categories\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"categories\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00',0,0),
  (418,'plg_search_contacts','plugin','contacts','search',0,1,1,0,'{\"name\":\"plg_search_contacts\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_CONTACTS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contacts\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00',0,0),
  (419,'plg_search_content','plugin','content','search',0,1,1,0,'{\"name\":\"plg_search_content\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_CONTENT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"content\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00',0,0),
  (420,'plg_search_newsfeeds','plugin','newsfeeds','search',0,1,1,0,'{\"name\":\"plg_search_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"newsfeeds\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00',0,0),
  (422,'plg_system_languagefilter','plugin','languagefilter','system',0,0,1,1,'{\"name\":\"plg_system_languagefilter\",\"type\":\"plugin\",\"creationDate\":\"July 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_LANGUAGEFILTER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"languagefilter\"}','','','',0,'0000-00-00',1,0),
  (423,'plg_system_p3p','plugin','p3p','system',0,0,1,0,'{\"name\":\"plg_system_p3p\",\"type\":\"plugin\",\"creationDate\":\"September 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_P3P_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"p3p\"}','{\"headers\":\"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM\"}','','',0,'0000-00-00',2,0),
  (424,'plg_system_cache','plugin','cache','system',0,0,1,1,'{\"name\":\"plg_system_cache\",\"type\":\"plugin\",\"creationDate\":\"February 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CACHE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"cache\"}','{\"browsercache\":\"0\",\"cachetime\":\"15\"}','','',0,'0000-00-00',9,0),
  (425,'plg_system_debug','plugin','debug','system',0,1,1,0,'{\"name\":\"plg_system_debug\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_DEBUG_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"debug\"}','{\"profile\":\"1\",\"queries\":\"1\",\"memory\":\"1\",\"language_files\":\"1\",\"language_strings\":\"1\",\"strip-first\":\"1\",\"strip-prefix\":\"\",\"strip-suffix\":\"\"}','','',0,'0000-00-00',4,0),
  (426,'plg_system_log','plugin','log','system',0,1,1,1,'{\"name\":\"plg_system_log\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_LOG_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"log\"}','','','',0,'0000-00-00',5,0),
  (427,'plg_system_redirect','plugin','redirect','system',0,0,1,1,'{\"name\":\"plg_system_redirect\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_REDIRECT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"redirect\"}','','','',0,'0000-00-00',6,0),
  (428,'plg_system_remember','plugin','remember','system',0,1,1,1,'{\"name\":\"plg_system_remember\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_REMEMBER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"remember\"}','','','',0,'0000-00-00',7,0),
  (429,'plg_system_sef','plugin','sef','system',0,1,1,0,'{\"name\":\"plg_system_sef\",\"type\":\"plugin\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEF_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"sef\"}','','','',0,'0000-00-00',8,0),
  (430,'plg_system_logout','plugin','logout','system',0,1,1,1,'{\"name\":\"plg_system_logout\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_LOGOUT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"logout\"}','','','',0,'0000-00-00',3,0),
  (431,'plg_user_contactcreator','plugin','contactcreator','user',0,0,1,0,'{\"name\":\"plg_user_contactcreator\",\"type\":\"plugin\",\"creationDate\":\"August 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTACTCREATOR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contactcreator\"}','{\"autowebpage\":\"\",\"category\":\"34\",\"autopublish\":\"0\"}','','',0,'0000-00-00',1,0),
  (432,'plg_user_joomla','plugin','joomla','user',0,1,1,0,'{\"name\":\"plg_user_joomla\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_USER_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','{\"autoregister\":\"1\",\"mail_to_user\":\"1\",\"forceLogout\":\"1\"}','','',0,'0000-00-00',2,0),
  (433,'plg_user_profile','plugin','profile','user',0,0,1,0,'{\"name\":\"plg_user_profile\",\"type\":\"plugin\",\"creationDate\":\"January 2008\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_USER_PROFILE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"profile\"}','{\"register-require_address1\":\"1\",\"register-require_address2\":\"1\",\"register-require_city\":\"1\",\"register-require_region\":\"1\",\"register-require_country\":\"1\",\"register-require_postal_code\":\"1\",\"register-require_phone\":\"1\",\"register-require_website\":\"1\",\"register-require_favoritebook\":\"1\",\"register-require_aboutme\":\"1\",\"register-require_tos\":\"1\",\"register-require_dob\":\"1\",\"profile-require_address1\":\"1\",\"profile-require_address2\":\"1\",\"profile-require_city\":\"1\",\"profile-require_region\":\"1\",\"profile-require_country\":\"1\",\"profile-require_postal_code\":\"1\",\"profile-require_phone\":\"1\",\"profile-require_website\":\"1\",\"profile-require_favoritebook\":\"1\",\"profile-require_aboutme\":\"1\",\"profile-require_tos\":\"1\",\"profile-require_dob\":\"1\"}','','',0,'0000-00-00',0,0),
  (434,'plg_extension_joomla','plugin','joomla','extension',0,1,1,1,'{\"name\":\"plg_extension_joomla\",\"type\":\"plugin\",\"creationDate\":\"May 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_EXTENSION_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','','','',0,'0000-00-00',1,0),
  (435,'plg_content_joomla','plugin','joomla','content',0,1,1,0,'{\"name\":\"plg_content_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','','','',0,'0000-00-00',0,0),
  (436,'plg_system_languagecode','plugin','languagecode','system',0,0,1,0,'{\"name\":\"plg_system_languagecode\",\"type\":\"plugin\",\"creationDate\":\"November 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_LANGUAGECODE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"languagecode\"}','','','',0,'0000-00-00',10,0),
  (437,'plg_quickicon_joomlaupdate','plugin','joomlaupdate','quickicon',0,1,1,1,'{\"name\":\"plg_quickicon_joomlaupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_QUICKICON_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomlaupdate\"}','','','',0,'0000-00-00',0,0),
  (438,'plg_quickicon_extensionupdate','plugin','extensionupdate','quickicon',0,1,1,1,'{\"name\":\"plg_quickicon_extensionupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_QUICKICON_EXTENSIONUPDATE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"extensionupdate\"}','','','',0,'0000-00-00',0,0),
  (439,'plg_captcha_recaptcha','plugin','recaptcha','captcha',0,0,1,0,'{\"name\":\"plg_captcha_recaptcha\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.4.0\",\"description\":\"PLG_CAPTCHA_RECAPTCHA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"recaptcha\"}','{\"public_key\":\"\",\"private_key\":\"\",\"theme\":\"clean\"}','','',0,'0000-00-00',0,0),
  (440,'plg_system_highlight','plugin','highlight','system',0,1,1,0,'{\"name\":\"plg_system_highlight\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_HIGHLIGHT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"highlight\"}','','','',0,'0000-00-00',7,0),
  (441,'plg_content_finder','plugin','finder','content',0,0,1,0,'{\"name\":\"plg_content_finder\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_FINDER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"finder\"}','','','',0,'0000-00-00',0,0),
  (442,'plg_finder_categories','plugin','categories','finder',0,1,1,0,'{\"name\":\"plg_finder_categories\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"categories\"}','','','',0,'0000-00-00',1,0),
  (443,'plg_finder_contacts','plugin','contacts','finder',0,1,1,0,'{\"name\":\"plg_finder_contacts\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_CONTACTS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contacts\"}','','','',0,'0000-00-00',2,0),
  (444,'plg_finder_content','plugin','content','finder',0,1,1,0,'{\"name\":\"plg_finder_content\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_CONTENT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"content\"}','','','',0,'0000-00-00',3,0),
  (445,'plg_finder_newsfeeds','plugin','newsfeeds','finder',0,1,1,0,'{\"name\":\"plg_finder_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"newsfeeds\"}','','','',0,'0000-00-00',4,0),
  (447,'plg_finder_tags','plugin','tags','finder',0,1,1,0,'{\"name\":\"plg_finder_tags\",\"type\":\"plugin\",\"creationDate\":\"February 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_TAGS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"tags\"}','','','',0,'0000-00-00',0,0),
  (448,'plg_twofactorauth_totp','plugin','totp','twofactorauth',0,1,1,0,'{\"name\":\"plg_twofactorauth_totp\",\"type\":\"plugin\",\"creationDate\":\"August 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"PLG_TWOFACTORAUTH_TOTP_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"totp\"}','','','',0,'0000-00-00',0,0),
  (449,'plg_authentication_cookie','plugin','cookie','authentication',0,1,1,0,'{\"name\":\"plg_authentication_cookie\",\"type\":\"plugin\",\"creationDate\":\"July 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_AUTH_COOKIE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"cookie\"}','','','',0,'0000-00-00',0,0),
  (450,'plg_twofactorauth_yubikey','plugin','yubikey','twofactorauth',0,1,1,0,'{\"name\":\"plg_twofactorauth_yubikey\",\"type\":\"plugin\",\"creationDate\":\"September 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"PLG_TWOFACTORAUTH_YUBIKEY_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"yubikey\"}','','','',0,'0000-00-00',0,0),
  (451,'plg_search_tags','plugin','tags','search',0,1,1,0,'{\"name\":\"plg_search_tags\",\"type\":\"plugin\",\"creationDate\":\"March 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_TAGS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"tags\"}','{\"search_limit\":\"50\",\"show_tagged_items\":\"1\"}','','',0,'0000-00-00',0,0),
  (503,'beez3','template','beez3','',0,1,1,0,'{\"name\":\"beez3\",\"type\":\"template\",\"creationDate\":\"25 November 2009\",\"author\":\"Angie Radtke\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"a.radtke@derauftritt.de\",\"authorUrl\":\"http:\\/\\/www.der-auftritt.de\",\"version\":\"3.1.0\",\"description\":\"TPL_BEEZ3_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"templateDetails\"}','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"sitetitle\":\"\",\"sitedescription\":\"\",\"navposition\":\"center\",\"templatecolor\":\"nature\"}','','',0,'0000-00-00',0,0),
  (504,'hathor','template','hathor','',1,1,1,0,'{\"name\":\"hathor\",\"type\":\"template\",\"creationDate\":\"May 2010\",\"author\":\"Andrea Tarr\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"hathor@tarrconsulting.com\",\"authorUrl\":\"http:\\/\\/www.tarrconsulting.com\",\"version\":\"3.0.0\",\"description\":\"TPL_HATHOR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"templateDetails\"}','{\"showSiteName\":\"0\",\"colourChoice\":\"0\",\"boldText\":\"0\"}','','',0,'0000-00-00',0,0),
  (506,'protostar','template','protostar','',0,1,1,0,'{\"name\":\"protostar\",\"type\":\"template\",\"creationDate\":\"4\\/30\\/2012\",\"author\":\"Kyle Ledbetter\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"\",\"version\":\"1.0\",\"description\":\"TPL_PROTOSTAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"templateDetails\"}','{\"templateColor\":\"\",\"logoFile\":\"\",\"googleFont\":\"1\",\"googleFontName\":\"Open+Sans\",\"fluidContainer\":\"0\"}','','',0,'0000-00-00',0,0),
  (507,'isis','template','isis','',1,1,1,0,'{\"name\":\"isis\",\"type\":\"template\",\"creationDate\":\"3\\/30\\/2012\",\"author\":\"Kyle Ledbetter\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"\",\"version\":\"1.0\",\"description\":\"TPL_ISIS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"templateDetails\"}','{\"templateColor\":\"\",\"logoFile\":\"\"}','','',0,'0000-00-00',0,0),
  (600,'English (en-GB)','language','en-GB','',0,1,1,1,'{\"name\":\"English (en-GB)\",\"type\":\"language\",\"creationDate\":\"2013-03-07\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.4.3\",\"description\":\"en-GB site language\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (601,'English (en-GB)','language','en-GB','',1,1,1,1,'{\"name\":\"English (en-GB)\",\"type\":\"language\",\"creationDate\":\"2013-03-07\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.4.3\",\"description\":\"en-GB administrator language\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (700,'files_joomla','file','joomla','',0,1,1,1,'{\"name\":\"files_joomla\",\"type\":\"file\",\"creationDate\":\"October 2015\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2015 Open Source Matters. All rights reserved\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.4.5\",\"description\":\"FILES_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (10000,'SpanishES','language','es-ES','',0,1,0,0,'{\"name\":\"Spanish (ES)\",\"type\":\"language\",\"creationDate\":\"2014-3-7\",\"author\":\"Spanish Translation Team: Comunidad Joomla\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters and comunidadjoomla.org. All rights reserved.\",\"authorEmail\":\"info@comunidadjoomla.org\",\"authorUrl\":\"www.comunidadjoomla.org\",\"version\":\"3.2.3.1\",\"description\":\"Spanish language pack for Joomla! 3.2.3 - Site\",\"group\":\"\",\"filename\":\"install\"}','{}','','',0,'0000-00-00',0,0),
  (10001,'SpanishES','language','es-ES','',1,1,0,0,'{\"name\":\"Spanish (ES)\",\"type\":\"language\",\"creationDate\":\"2014-3-7\",\"author\":\"Spanish Translation Team: Comunidad Joomla\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters and comunidadjoomla.org. All rights reserved.\",\"authorEmail\":\"info@comunidadjoomla.org\",\"authorUrl\":\"www.comunidadjoomla.org\",\"version\":\"3.2.3.1\",\"description\":\"Spanish language pack for Joomla! 3.2.3 - Administrator\",\"group\":\"\",\"filename\":\"install\"}','{}','','',0,'0000-00-00',0,0),
  (10002,'Spanish Language Pack','package','pkg_es-ES','',0,1,1,0,'{\"name\":\"Spanish Language Pack\",\"type\":\"package\",\"creationDate\":\"7 de marzo del 2014\",\"author\":\"Spanish Translation Team: comunidadjoomla.org\",\"copyright\":\"Copyright (C) 2005 - 2014 comunidadjoomla.org and Open Source Matters. All rights reserved.\",\"authorEmail\":\"info@comunidadjoomla.org\",\"authorUrl\":\"www.comunidadjoomla.org\",\"version\":\"3.2.3.1\",\"description\":\"\\n\\t\\t<div style=\\\"text-align:left;\\\">\\n\\t\\t<h2>Successfully installed the spanish language pack for Joomla! 3.2.3.<\\/h2>\\n\\t\\t<p><\\/p>\\n\\t\\t<p>Please report any bugs or issues at the Comunidad Joomla! <a href=\\\"http:\\/\\/foro.comunidadjoomla.org\\/traduccion-ext\\/\\\" target=\\\"_blank\\\">Translation forum<\\/a><\\/p>\\n\\t\\t<p><\\/p>\\n\\t\\t<p>Translated by: <a href=\\\"http:\\/\\/www.comunidadjoomla.org\\\" target=\\\"_blank\\\" title=\\\"\\\">The spanish translation team of Comunidad Joomla!<\\/a><\\/p>\\n\\t\\t<h2>El paquete en espa\\u00f1ol para Joomla! 3.2.3 se ha instalado correctamente.<\\/h2>\\n\\t\\t<p><\\/p>\\n\\t\\t<p>Por favor, reporte cualquier bug o asunto relacionado a nuestro <a href=\\\"http:\\/\\/foro.comunidadjoomla.org\\/traduccion-ext\\/\\\" target=\\\"_blank\\\">Foro de traducciones<\\/a><\\/p>\\n\\t\\t<p><\\/p>\\n\\t\\t<p>Traducci\\u00f3n: <a href=\\\"http:\\/\\/www.comunidadjoomla.org\\\" target=\\\"_blank\\\" title=\\\"\\\">El equipo de traducci\\u00f3n de Comunidad Joomla!<\\/a><\\/p>\\n\\t\\t<\\/div>\\n\\t\\t\",\"group\":\"\",\"filename\":\"pkg_es-ES\"}','{}','','',0,'0000-00-00',0,0),
  (10003,'Prioridad','component','com_prioridad','',1,1,0,0,'{\"name\":\"Prioridad\",\"type\":\"component\",\"creationDate\":\"26-nov-2015 3:36:46\",\"author\":\"Charlietyn\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"charlietyn@yahoo.es\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Prioridad\",\"group\":\"\",\"filename\":\"prioridad\"}','{}','','',0,'0000-00-00',0,0),
  (10004,'MetroUI by Ernesto Bonet','template','metrouibyernestobonet','',0,1,1,0,'{\"name\":\"MetroUI by Ernesto Bonet\",\"type\":\"template\",\"creationDate\":\"Agosto 2015\",\"author\":\"Ernesto\",\"copyright\":\"Copyright (C) 2015 EABM team\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"3.0.0\",\"description\":\"Template for Joomla 3.x deverloped by ernesto\",\"group\":\"\",\"filename\":\"templateDetails\"}','{}','','',0,'0000-00-00',0,0),
  (10005,'Perfil_programa','component','com_perfil_programa','',1,1,0,0,'{\"name\":\"Perfil_programa\",\"type\":\"component\",\"creationDate\":\"03-dic-2015 5:29:11\",\"author\":\"Charlietyn\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"charlietyn@yahoo.es\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Perfil_programa\",\"group\":\"\",\"filename\":\"perfil_programa\"}','{}','','',0,'0000-00-00',0,0),
  (10006,'Indicadores_impacto','component','com_indicadores_impacto','',1,1,0,0,'{\"name\":\"Indicadores_impacto\",\"type\":\"component\",\"creationDate\":\"03-dic-2015 13:50:15\",\"author\":\"Charlietyn\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"charlietyn@yahoo.es\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Indicadores_impacto\",\"group\":\"\",\"filename\":\"indicadores_impacto\"}','{}','','',0,'0000-00-00',0,0),
  (10007,'plg_system_kunena','plugin','kunena','system',0,1,1,0,'{\"name\":\"plg_system_kunena\",\"type\":\"plugin\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"www.kunena.org\",\"authorEmail\":\"Kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"PLG_SYSTEM_KUNENA_DESC\",\"group\":\"\",\"filename\":\"kunena\"}','{\"jcontentevents\":\"0\",\"jcontentevent_target\":\"body\"}','','',0,'0000-00-00',0,0),
  (10008,'plg_quickicon_kunena','plugin','kunena','quickicon',0,1,1,0,'{\"name\":\"plg_quickicon_kunena\",\"type\":\"plugin\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"www.kunena.org\",\"authorEmail\":\"Kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"PLG_QUICKICON_KUNENA_DESC\",\"group\":\"\",\"filename\":\"kunena\"}','{\"context\":\"mod_quickicon\"}','','',0,'0000-00-00',0,0),
  (10009,'Kunena Framework','library','kunena','',0,1,1,0,'{\"name\":\"Kunena Framework\",\"type\":\"library\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"(C) 2008 - 2013 Kunena Team. All rights reserved.\",\"authorEmail\":\"kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"Kunena Framework.\",\"group\":\"\",\"filename\":\"kunena\"}','{}','','',0,'0000-00-00',0,0),
  (10010,'Kunena Media Files','file','KunenaMediaFiles','',0,1,0,0,'{\"name\":\"Kunena Media Files\",\"type\":\"file\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"(C) 2008 - 2013 Kunena Team. All rights reserved.\",\"authorEmail\":\"kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"Kunena media files.\",\"group\":\"\"}','','','',0,'0000-00-00',0,0),
  (10011,'com_kunena','component','com_kunena','',1,1,0,0,'{\"name\":\"com_kunena\",\"type\":\"component\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"(C) 2008 - 2013 Kunena Team. All rights reserved.\",\"authorEmail\":\"kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"COM_KUNENA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"kunena\"}','{}','','',0,'0000-00-00',0,0),
  (10012,'Kunena Forum Package','package','pkg_kunena','',0,1,1,0,'{\"name\":\"Kunena Forum Package\",\"type\":\"package\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"(C) 2008 - 2013 Kunena Team. All rights reserved.\",\"authorEmail\":\"kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"Kunena Forum Package.\",\"group\":\"\",\"filename\":\"pkg_kunena\"}','{}','','',0,'0000-00-00',0,0),
  (10013,'plg_kunena_alphauserpoints','plugin','alphauserpoints','kunena',0,0,1,0,'{\"name\":\"plg_kunena_alphauserpoints\",\"type\":\"plugin\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"www.kunena.org\",\"authorEmail\":\"Kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"PLG_KUNENA_ALPHAUSERPOINTS_DESCRIPTION\",\"group\":\"\",\"filename\":\"alphauserpoints\"}','{\"activity\":\"1\",\"avatar\":\"1\",\"profile\":\"1\",\"activity_points_limit\":\"0\"}','','',0,'0000-00-00',1,0),
  (10014,'plg_kunena_community','plugin','community','kunena',0,0,1,0,'{\"name\":\"plg_kunena_community\",\"type\":\"plugin\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"www.kunena.org\",\"authorEmail\":\"Kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"PLG_KUNENA_COMMUNITY_DESCRIPTION\",\"group\":\"\",\"filename\":\"community\"}','{\"access\":\"1\",\"login\":\"1\",\"activity\":\"1\",\"avatar\":\"1\",\"profile\":\"1\",\"private\":\"1\",\"activity_points_limit\":\"0\",\"activity_stream_limit\":\"0\"}','','',0,'0000-00-00',2,0),
  (10015,'plg_kunena_comprofiler','plugin','comprofiler','kunena',0,0,1,0,'{\"name\":\"plg_kunena_comprofiler\",\"type\":\"plugin\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"www.kunena.org\",\"authorEmail\":\"Kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"PLG_KUNENA_COMPROFILER_DESCRIPTION\",\"group\":\"\",\"filename\":\"comprofiler\"}','{\"access\":\"1\",\"login\":\"1\",\"activity\":\"1\",\"avatar\":\"1\",\"profile\":\"1\",\"private\":\"1\"}','','',0,'0000-00-00',3,0),
  (10016,'plg_kunena_gravatar','plugin','gravatar','kunena',0,0,1,0,'{\"name\":\"plg_kunena_gravatar\",\"type\":\"plugin\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"www.kunena.org\",\"authorEmail\":\"Kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"PLG_KUNENA_GRAVATAR_DESCRIPTION\",\"group\":\"\",\"filename\":\"gravatar\"}','{\"avatar\":\"1\"}','','',0,'0000-00-00',4,0),
  (10017,'plg_kunena_uddeim','plugin','uddeim','kunena',0,0,1,0,'{\"name\":\"plg_kunena_uddeim\",\"type\":\"plugin\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"www.kunena.org\",\"authorEmail\":\"Kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"PLG_KUNENA_UDDEIM_DESCRIPTION\",\"group\":\"\",\"filename\":\"uddeim\"}','{\"private\":\"1\"}','','',0,'0000-00-00',5,0),
  (10018,'plg_kunena_kunena','plugin','kunena','kunena',0,1,1,0,'{\"name\":\"plg_kunena_kunena\",\"type\":\"plugin\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"www.kunena.org\",\"authorEmail\":\"Kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"PLG_KUNENA_KUNENA_DESCRIPTION\",\"group\":\"\",\"filename\":\"kunena\"}','{\"avatar\":\"1\",\"profile\":\"1\"}','','',0,'0000-00-00',6,0),
  (10019,'plg_kunena_joomla','plugin','joomla','kunena',0,1,1,0,'{\"name\":\"plg_kunena_joomla\",\"type\":\"plugin\",\"creationDate\":\"2014-03-09\",\"author\":\"Kunena Team\",\"copyright\":\"www.kunena.org\",\"authorEmail\":\"Kunena@kunena.org\",\"authorUrl\":\"http:\\/\\/www.kunena.org\",\"version\":\"3.0.5\",\"description\":\"PLG_KUNENA_JOOMLA_25_30_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','{\"access\":\"1\",\"login\":\"1\"}','','',0,'0000-00-00',7,0),
  (10024,'marco_regulatorio','component','com_marco_regulatorio','',1,1,0,0,'{\"name\":\"marco_regulatorio\",\"type\":\"component\",\"creationDate\":\"03-dic-2015 13:50:16\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@yahoo.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de marco_regulatorio\",\"group\":\"\",\"filename\":\"marco_regulatorio\"}','{}','','',0,'0000-00-00',0,0),
  (10025,'Persona','component','com_persona','',1,1,0,0,'{\"name\":\"Persona\",\"type\":\"component\",\"creationDate\":\"08-dic-2015 10:03:16\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@yahoo.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Persona\",\"group\":\"\",\"filename\":\"persona\"}','{}','','',0,'0000-00-00',0,0),
  (10026,'Entidad','component','com_entidad','',1,1,0,0,'{\"name\":\"Entidad\",\"type\":\"component\",\"creationDate\":\"10-dic-2015 7:34:42\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Entidad\",\"group\":\"\",\"filename\":\"entidad\"}','{}','','',0,'0000-00-00',0,0),
  (10027,'Provincia','component','com_provincia','',1,1,0,0,'{\"name\":\"Provincia\",\"type\":\"component\",\"creationDate\":\"10-dic-2015 7:34:44\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Provincia\",\"group\":\"\",\"filename\":\"provincia\"}','{}','','',0,'0000-00-00',0,0),
  (10029,'Programa','component','com_programa','',1,1,0,0,'{\"name\":\"Programa\",\"type\":\"component\",\"creationDate\":\"10-dic-2015 7:34:44\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Programa\",\"group\":\"\",\"filename\":\"programa\"}','{}','','',0,'0000-00-00',0,0),
  (10030,'Convocatoria','component','com_convocatoria','',1,1,0,0,'{\"name\":\"Convocatoria\",\"type\":\"component\",\"creationDate\":\"10-dic-2015 7:34:41\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Convocatoria\",\"group\":\"\",\"filename\":\"convocatoria\"}','{}','','',0,'0000-00-00',0,0),
  (10031,'Ejecutora','component','com_ejecutora','',1,1,0,0,'{\"name\":\"Ejecutora\",\"type\":\"component\",\"creationDate\":\"12-dic-2015 6:42:17\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Ejecutora\",\"group\":\"\",\"filename\":\"ejecutora\"}','{}','','',0,'0000-00-00',0,0),
  (10033,'Jefeproyecto','component','com_jefeproyecto','',1,1,0,0,'{\"name\":\"Jefeproyecto\",\"type\":\"component\",\"creationDate\":\"15-dic-2015 13:20:59\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Jefeproyecto\",\"group\":\"\",\"filename\":\"jefeproyecto\"}','{}','','',0,'0000-00-00',0,0),
  (10034,'Tipo_proyecto','component','com_tipo_proyecto','',1,1,0,0,'{\"name\":\"Tipo_proyecto\",\"type\":\"component\",\"creationDate\":\"15-dic-2015 13:21:00\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Tipo_proyecto\",\"group\":\"\",\"filename\":\"tipo_proyecto\"}','{}','','',0,'0000-00-00',0,0),
  (10035,'Clasificacion','component','com_clasificacion','',1,1,0,0,'{\"name\":\"Clasificacion\",\"type\":\"component\",\"creationDate\":\"15-dic-2015 13:20:56\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Clasificacion\",\"group\":\"\",\"filename\":\"clasificacion\"}','{}','','',0,'0000-00-00',0,0),
  (10036,'Perfil_proyecto','component','com_perfil_proyecto','',1,1,0,0,'{\"name\":\"Perfil_proyecto\",\"type\":\"component\",\"creationDate\":\"15-dic-2015 13:20:59\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Perfil_proyecto\",\"group\":\"\",\"filename\":\"perfil_proyecto\"}','{}','','',0,'0000-00-00',0,0),
  (10037,'Cat_cientifica','component','com_cat_cientifica','',1,1,0,0,'{\"name\":\"Cat_cientifica\",\"type\":\"component\",\"creationDate\":\"15-dic-2015 13:20:56\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Cat_cientifica\",\"group\":\"\",\"filename\":\"cat_cientifica\"}','{}','','',0,'0000-00-00',0,0),
  (10038,'Grado_cientifico','component','com_grado_cientifico','',1,1,0,0,'{\"name\":\"Grado_cientifico\",\"type\":\"component\",\"creationDate\":\"15-dic-2015 13:20:58\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Grado_cientifico\",\"group\":\"\",\"filename\":\"grado_cientifico\"}','{}','','',0,'0000-00-00',0,0),
  (10039,'Traza','component','com_traza','',1,1,0,0,'{\"name\":\"Traza\",\"type\":\"component\",\"creationDate\":\"20-dic-2015 5:16:19\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Traza\",\"group\":\"\",\"filename\":\"traza\"}','{}','','',0,'0000-00-00',0,0),
  (10041,'Ayuda','component','com_ayuda','',1,1,0,0,'{\"name\":\"Ayuda\",\"type\":\"component\",\"creationDate\":\"20-dic-2015 6:17:30\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Ayuda\",\"group\":\"\",\"filename\":\"ayuda\"}','{}','','',0,'0000-00-00',0,0),
  (10042,'Dictamen_eval_perfil_proy','component','com_dictamen_eval_perfil_proy','',1,1,0,0,'{\"name\":\"Dictamen_eval_perfil_proy\",\"type\":\"component\",\"creationDate\":\"27-dic-2015 0:49:36\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Dictamen_eval_perfil_proy\",\"group\":\"\",\"filename\":\"dictamen_eval_perfil_proy\"}','{}','','',0,'0000-00-00',0,0),
  (10043,'Contrato','component','com_contrato','',1,1,0,0,'{\"name\":\"Contrato\",\"type\":\"component\",\"creationDate\":\"27-dic-2015 0:49:35\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Contrato\",\"group\":\"\",\"filename\":\"contrato\"}','{}','','',0,'0000-00-00',0,0),
  (10044,'I_d','component','com_i_d','',1,1,0,0,'{\"name\":\"I_d\",\"type\":\"component\",\"creationDate\":\"27-dic-2015 0:49:38\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de I_d\",\"group\":\"\",\"filename\":\"i_d\"}','{}','','',0,'0000-00-00',0,0),
  (10045,'Innovacion','component','com_innovacion','',1,1,0,0,'{\"name\":\"Innovacion\",\"type\":\"component\",\"creationDate\":\"27-dic-2015 0:49:39\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Innovacion\",\"group\":\"\",\"filename\":\"innovacion\"}','{}','','',0,'0000-00-00',0,0),
  (10046,'Forma_entrega','component','com_forma_entrega','',1,1,0,0,'{\"name\":\"Forma_entrega\",\"type\":\"component\",\"creationDate\":\"27-dic-2015 0:49:38\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Forma_entrega\",\"group\":\"\",\"filename\":\"forma_entrega\"}','{}','','',0,'0000-00-00',0,0),
  (10047,'Proyecto','component','com_proyecto','',1,1,0,0,'{\"name\":\"Proyecto\",\"type\":\"component\",\"creationDate\":\"27-dic-2015 0:49:42\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Proyecto\",\"group\":\"\",\"filename\":\"proyecto\"}','{}','','',0,'0000-00-00',0,0),
  (10048,'Evaluacion','component','com_evaluacion','',1,1,0,0,'{\"name\":\"Evaluacion\",\"type\":\"component\",\"creationDate\":\"28-dic-2015 13:27:35\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Evaluacion\",\"group\":\"\",\"filename\":\"evaluacion\"}','{}','','',0,'0000-00-00',0,0),
  (10049,'Anticipo','component','com_anticipo','',1,1,0,0,'{\"name\":\"Anticipo\",\"type\":\"component\",\"creationDate\":\"01-ene-2016 7:05:04\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Anticipo\",\"group\":\"\",\"filename\":\"anticipo\"}','{}','','',0,'0000-00-00',0,0),
  (10050,'Control_ejecucion_presupuesto','component','com_control_ejecucion_presupuesto','',1,1,0,0,'{\"name\":\"Control_ejecucion_presupuesto\",\"type\":\"component\",\"creationDate\":\"01-ene-2016 7:05:05\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Control_ejecucion_presupuesto\",\"group\":\"\",\"filename\":\"control_ejecucion_presupuesto\"}','{}','','',0,'0000-00-00',0,0),
  (10051,'Financista','component','com_financista','',1,1,0,0,'{\"name\":\"Financista\",\"type\":\"component\",\"creationDate\":\"13-dic-2015 1:57:35\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Financista\",\"group\":\"\",\"filename\":\"financista\"}','{}','','',0,'0000-00-00',0,0),
  (10052,'Informe_ejecucion_programa','component','com_informe_ejecucion_programa','',1,1,0,0,'{\"name\":\"Informe_ejecucion_programa\",\"type\":\"component\",\"creationDate\":\"01-ene-2016 7:05:08\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Informe_ejecucion_programa\",\"group\":\"\",\"filename\":\"informe_ejecucion_programa\"}','{}','','',0,'0000-00-00',0,0),
  (10053,'Informe_etapa','component','com_informe_etapa','',1,1,0,0,'{\"name\":\"Informe_etapa\",\"type\":\"component\",\"creationDate\":\"01-ene-2016 7:05:08\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Informe_etapa\",\"group\":\"\",\"filename\":\"informe_etapa\"}','{}','','',0,'0000-00-00',0,0),
  (10054,'Notificacion_ingreso_gastos','component','com_notificacion_ingreso_gastos','',1,1,0,0,'{\"name\":\"Notificacion_ingreso_gastos\",\"type\":\"component\",\"creationDate\":\"01-ene-2016 7:05:08\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Notificacion_ingreso_gastos\",\"group\":\"\",\"filename\":\"notificacion_ingreso_gastos\"}','{}','','',0,'0000-00-00',0,0),
  (10055,'Oponencia_informe_etapa','component','com_oponencia_informe_etapa','',1,1,0,0,'{\"name\":\"Oponencia_informe_etapa\",\"type\":\"component\",\"creationDate\":\"01-ene-2016 7:05:09\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Oponencia_informe_etapa\",\"group\":\"\",\"filename\":\"oponencia_informe_etapa\"}','{}','','',0,'0000-00-00',0,0),
  (10056,'Dictamen_grupo_expertos_inf_etapa','component','com_dictamen_grupo_expertos_inf_etapa','',1,1,0,0,'{\"name\":\"Dictamen_grupo_expertos_inf_etapa\",\"type\":\"component\",\"creationDate\":\"01-ene-2016 7:05:06\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Dictamen_grupo_expertos_inf_etapa\",\"group\":\"\",\"filename\":\"dictamen_grupo_expertos_inf_etapa\"}','{}','','',0,'0000-00-00',0,0),
  (10057,'Certificacion_activdades_resultados','component','com_certificacion_activdades_resultados','',1,1,0,0,'{\"name\":\"Certificacion_activdades_resultados\",\"type\":\"component\",\"creationDate\":\"01-ene-2016 7:05:05\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Certificacion_activdades_resultados\",\"group\":\"\",\"filename\":\"certificacion_activdades_resultados\"}','{}','','',0,'0000-00-00',0,0),
  (10058,'Estado_ejecucion_proyecto','component','com_estado_ejecucion_proyecto','',1,1,0,0,'{\"name\":\"Estado_ejecucion_proyecto\",\"type\":\"component\",\"creationDate\":\"01-ene-2016 7:05:07\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Estado_ejecucion_proyecto\",\"group\":\"\",\"filename\":\"estado_ejecucion_proyecto\"}','{}','','',0,'0000-00-00',0,0),
  (10060,'Control_programa_proyecto','component','com_control_programa_proyecto','',1,1,0,0,'{\"name\":\"Control_programa_proyecto\",\"type\":\"component\",\"creationDate\":\"03-ene-2016 23:17:50\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Control_programa_proyecto\",\"group\":\"\",\"filename\":\"control_programa_proyecto\"}','{}','','',0,'0000-00-00',0,0),
  (10061,'Problemas_detectados','component','com_problemas_detectados','',1,1,0,0,'{\"name\":\"Problemas_detectados\",\"type\":\"component\",\"creationDate\":\"03-ene-2016 23:17:53\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Problemas_detectados\",\"group\":\"\",\"filename\":\"problemas_detectados\"}','{}','','',0,'0000-00-00',0,0),
  (10062,'Auditoria','component','com_auditoria','',1,1,0,0,'{\"name\":\"Auditoria\",\"type\":\"component\",\"creationDate\":\"03-ene-2016 23:17:49\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Auditoria\",\"group\":\"\",\"filename\":\"auditoria\"}','{}','','',0,'0000-00-00',0,0),
  (10063,'Documentacion_evidencias_objetivas','component','com_documentacion_evidencias_objetivas','',1,1,0,0,'{\"name\":\"Documentacion_evidencias_objetivas\",\"type\":\"component\",\"creationDate\":\"03-ene-2016 23:17:50\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Documentacion_evidencias_objetivas\",\"group\":\"\",\"filename\":\"documentacion_evidencias_objetivas\"}','{}','','',0,'0000-00-00',0,0),
  (10064,'Informe_auditoria','component','com_informe_auditoria','',1,1,0,0,'{\"name\":\"Informe_auditoria\",\"type\":\"component\",\"creationDate\":\"03-ene-2016 23:17:52\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Informe_auditoria\",\"group\":\"\",\"filename\":\"informe_auditoria\"}','{}','','',0,'0000-00-00',0,0),
  (10065,'Lista_chequeo_auditoria','component','com_lista_chequeo_auditoria','',1,1,0,0,'{\"name\":\"Lista_chequeo_auditoria\",\"type\":\"component\",\"creationDate\":\"03-ene-2016 23:17:52\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Lista_chequeo_auditoria\",\"group\":\"\",\"filename\":\"lista_chequeo_auditoria\"}','{}','','',0,'0000-00-00',0,0),
  (10066,'Plan_auditoria','component','com_plan_auditoria','',1,1,0,0,'{\"name\":\"Plan_auditoria\",\"type\":\"component\",\"creationDate\":\"03-ene-2016 23:17:53\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de Plan_auditoria\",\"group\":\"\",\"filename\":\"plan_auditoria\"}','{}','','',0,'0000-00-00',0,0),
  (10067,'rep_convocatoria','component','com_rep_convocatoria','',1,1,0,0,'{\"name\":\"rep_convocatoria\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de reporte de convocatoria\",\"group\":\"\",\"filename\":\"rep_convocatoria\"}','{}','','',0,'0000-00-00',0,0),
  (10069,'informe_etapa_proyecto','component','com_informe_etapa_proyecto','',1,1,0,0,'{\"name\":\"informe_etapa_proyecto\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de informe_etapa_proyecto\",\"group\":\"\",\"filename\":\"informe_etapa_proyecto\"}','{}','','',0,'0000-00-00',0,0),
  (10070,'anticipo_ejecutora','component','com_anticipo_ejecutora','',1,1,0,0,'{\"name\":\"anticipo_ejecutora\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de anticipo_ejecutora\",\"group\":\"\",\"filename\":\"anticipo_ejecutora\"}','{}','','',0,'0000-00-00',0,0),
  (10071,'certificn_actvs_resultds','component','com_certificn_actvs_resultds','',1,1,0,0,'{\"name\":\"certificn_actvs_resultds\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de reporte de certificn_actvs_resultds\",\"group\":\"\",\"filename\":\"certificn_actvs_resultds\"}','{}','','',0,'0000-00-00',0,0),
  (10072,'COM_CSOAP','component','com_csoap','',1,1,0,0,'{\"name\":\"COM_CSOAP\",\"type\":\"component\",\"creationDate\":\"July 2012\",\"author\":\"Conflate\",\"copyright\":\"Copyright (c) 2012 Conflate\",\"authorEmail\":\"info@conflate.nl\",\"authorUrl\":\"http:\\/\\/www.conflate.nl\",\"version\":\"1.0\",\"description\":\"COM_CSOAP_DESC\",\"group\":\"\",\"filename\":\"csoap\"}','{}','','',0,'0000-00-00',0,0),
  (10074,'PKG_CSOAP','package','pkg_csoap','',0,1,1,0,'{\"name\":\"PKG_CSOAP\",\"type\":\"package\",\"creationDate\":\"July 2012\",\"author\":\"Conflate\",\"copyright\":\"\",\"authorEmail\":\"info@conflate.nl\",\"authorUrl\":\"http:\\/\\/www.conflate.nl\",\"version\":\"0.4.5\",\"description\":\"PKG_CSOAP_DESC\",\"group\":\"\",\"filename\":\"pkg_csoap\"}','{}','','',0,'0000-00-00',0,0),
  (10075,'NuSOAP - SOAP Toolkit for PHP','library','nusoap','',0,1,1,0,'{\"name\":\"NuSOAP - SOAP Toolkit for PHP\",\"type\":\"library\",\"creationDate\":\"July 2012\",\"author\":\"Conflate (created the package)\",\"copyright\":\"Copyright (c) 2012 Conflate\",\"authorEmail\":\"info@conflate.nl\",\"authorUrl\":\"http:\\/\\/nusoap.sourceforge.net\\/\",\"version\":\"0.9.5\",\"description\":\"NuSOAP is a rewrite of SOAPx4, provided by NuSphere and Dietrich Ayala. It is a set of PHP classes - no PHP extensions required - that allow developers to create and consume web services based on SOAP 1.1, WSDL 1.1 and HTTP 1.0\\/1.1.\",\"group\":\"\",\"filename\":\"nusoap\"}','{}','','',0,'0000-00-00',0,0),
  (10076,'flujo_presupuesto','component','com_flujo_presupuesto','',1,1,0,0,'{\"name\":\"flujo_presupuesto\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente  reporte de flujo del presupuesto \",\"group\":\"\",\"filename\":\"flujo_presupuesto\"}','{}','','',0,'0000-00-00',0,0),
  (10077,'financiamiento_programa_proyecto','component','com_financiamiento_programa_proyecto','',1,1,0,0,'{\"name\":\"financiamiento_programa_proyecto\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de reporte de financiamiento_programa_proyecto\",\"group\":\"\",\"filename\":\"financiamiento_programa_proyecto\"}','{}','','',0,'0000-00-00',0,0),
  (10078,'rep_dictmn_evl_gexp','component','com_rep_dictmn_evl_gexp','',1,1,0,0,'{\"name\":\"rep_dictmn_evl_gexp\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de rep_dictmn_evl_gexp\",\"group\":\"\",\"filename\":\"rep_dictmn_evl_gexp\"}','{}','','',0,'0000-00-00',0,0),
  (10079,'deficiencias_proyectos','component','com_deficiencias_proyectos','',1,1,0,0,'{\"name\":\"deficiencias_proyectos\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de deficiencias_proyectos\",\"group\":\"\",\"filename\":\"deficiencias_proyectos\"}','{}','','',0,'0000-00-00',0,0),
  (10080,'rep_informe_ejecucion_programa','component','com_rep_informe_ejecucion_programa','',1,1,0,0,'{\"name\":\"rep_informe_ejecucion_programa\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de rep_informe_ejecucion_programa\",\"group\":\"\",\"filename\":\"rep_informe_ejecucion_programa\"}','{}','','',0,'0000-00-00',0,0),
  (10081,'estado_ejecucion_programa_proyecto','component','com_estado_ejecucion_programa_proyecto','',1,1,0,0,'{\"name\":\"estado_ejecucion_programa_proyecto\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de reporte de convocatoria\",\"group\":\"\",\"filename\":\"estado_ejecucion_programa_proyecto\"}','{}','','',0,'0000-00-00',0,0),
  (10082,'control_presupuestal','component','com_control_presupuestal','',1,1,0,0,'{\"name\":\"control_presupuestal\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de reporte de control_presupuestal\",\"group\":\"\",\"filename\":\"control_presupuestal\"}','{}','','',0,'0000-00-00',0,0),
  (10083,'programa_auditoria','component','com_programa_auditoria','',1,1,0,0,'{\"name\":\"programa_auditoria\",\"type\":\"component\",\"creationDate\":\"19-ene-2016 12:30:57\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de reporte programa_auditoria\",\"group\":\"\",\"filename\":\"programa_auditoria\"}','{}','','',0,'0000-00-00',0,0),
  (10084,'logs','component','com_logs','',1,1,0,0,'{\"name\":\"logs\",\"type\":\"component\",\"creationDate\":\"02-feb-2016 17:18:13\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de logs\",\"group\":\"\",\"filename\":\"logs\"}','{}','','',0,'0000-00-00',0,0),
  (10085,'rep_informe_auditoria','component','com_rep_informe_auditoria','',1,1,0,0,'{\"name\":\"rep_informe_auditoria\",\"type\":\"component\",\"creationDate\":\"20-feb-2016 23:15:36\",\"author\":\"Ernesto\",\"copyright\":\"Copyright Info\",\"authorEmail\":\"bernestoalberto@gmail.com\",\"authorUrl\":\"\",\"version\":\"1.1\",\"description\":\"Componente de rep_informe_auditoria\",\"group\":\"\",\"filename\":\"informe_auditoria\"}','{}','','',0,'0000-00-00',0,0);

COMMIT;

#
# Data for the `gir_finder_taxonomy` table  (LIMIT 0,500)
#

INSERT INTO `gir_finder_taxonomy` (`id`, `parent_id`, `title`, `state`, `access`, `ordering`) VALUES 
  (1,0,'ROOT',0,0,0);

COMMIT;

#
# Data for the `gir_finder_terms_common` table  (LIMIT 0,500)
#

INSERT INTO `gir_finder_terms_common` (`term`, `language`) VALUES 
  ('a','en'),
  ('about','en'),
  ('after','en'),
  ('ago','en'),
  ('all','en'),
  ('am','en'),
  ('an','en'),
  ('and','en'),
  ('ani','en'),
  ('any','en'),
  ('are','en'),
  ('aren''t','en'),
  ('as','en'),
  ('at','en'),
  ('be','en'),
  ('but','en'),
  ('by','en'),
  ('for','en'),
  ('from','en'),
  ('get','en'),
  ('go','en'),
  ('how','en'),
  ('if','en'),
  ('in','en'),
  ('into','en'),
  ('is','en'),
  ('isn''t','en'),
  ('it','en'),
  ('its','en'),
  ('me','en'),
  ('more','en'),
  ('most','en'),
  ('must','en'),
  ('my','en'),
  ('new','en'),
  ('no','en'),
  ('none','en'),
  ('not','en'),
  ('noth','en'),
  ('nothing','en'),
  ('of','en'),
  ('off','en'),
  ('often','en'),
  ('old','en'),
  ('on','en'),
  ('onc','en'),
  ('once','en'),
  ('onli','en'),
  ('only','en'),
  ('or','en'),
  ('other','en'),
  ('our','en'),
  ('ours','en'),
  ('out','en'),
  ('over','en'),
  ('page','en'),
  ('she','en'),
  ('should','en'),
  ('small','en'),
  ('so','en'),
  ('some','en'),
  ('than','en'),
  ('thank','en'),
  ('that','en'),
  ('the','en'),
  ('their','en'),
  ('theirs','en'),
  ('them','en'),
  ('then','en'),
  ('there','en'),
  ('these','en'),
  ('they','en'),
  ('this','en'),
  ('those','en'),
  ('thus','en'),
  ('time','en'),
  ('times','en'),
  ('to','en'),
  ('too','en'),
  ('true','en'),
  ('under','en'),
  ('until','en'),
  ('up','en'),
  ('upon','en'),
  ('use','en'),
  ('user','en'),
  ('users','en'),
  ('veri','en'),
  ('version','en'),
  ('very','en'),
  ('via','en'),
  ('want','en'),
  ('was','en'),
  ('way','en'),
  ('were','en'),
  ('what','en'),
  ('when','en'),
  ('where','en'),
  ('whi','en'),
  ('which','en'),
  ('who','en'),
  ('whom','en'),
  ('whose','en'),
  ('why','en'),
  ('wide','en'),
  ('will','en'),
  ('with','en'),
  ('within','en'),
  ('without','en'),
  ('would','en'),
  ('yes','en'),
  ('yet','en'),
  ('you','en'),
  ('your','en'),
  ('yours','en');

COMMIT;

#
# Data for the `gir_kunena_aliases` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_aliases` (`alias`, `type`, `item`, `state`) VALUES 
  ('announcement','view','announcement',1),
  ('bienvenido-mat','catid','2',1),
  ('buzon-de-sugerencias','catid','3',1),
  ('category','view','category',1),
  ('category/create','layout','category.create',1),
  ('category/default','layout','category.default',1),
  ('category/edit','layout','category.edit',1),
  ('category/manage','layout','category.manage',1),
  ('category/moderate','layout','category.moderate',1),
  ('category/user','layout','category.user',1),
  ('common','view','common',1),
  ('create','layout','category.create',0),
  ('credits','view','credits',1),
  ('default','layout','category.default',0),
  ('edit','layout','category.edit',0),
  ('foro-principal','catid','1',1),
  ('home','view','home',1),
  ('manage','layout','category.manage',0),
  ('misc','view','misc',1),
  ('moderate','layout','category.moderate',0),
  ('search','view','search',1),
  ('statistics','view','statistics',1),
  ('topic','view','topic',1),
  ('topics','view','topics',1),
  ('user','view','user',1);

COMMIT;

#
# Data for the `gir_kunena_categories` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_categories` (`id`, `parent_id`, `name`, `alias`, `icon_id`, `locked`, `accesstype`, `access`, `pub_access`, `pub_recurse`, `admin_access`, `admin_recurse`, `ordering`, `published`, `channels`, `checked_out`, `checked_out_time`, `review`, `allow_anonymous`, `post_anonymous`, `hits`, `description`, `headerdesc`, `class_sfx`, `allow_polls`, `topic_ordering`, `numTopics`, `numPosts`, `last_topic_id`, `last_post_id`, `last_post_time`, `params`) VALUES 
  (1,0,'Foro Principal','foro-principal',0,0,'joomla.group',0,1,1,0,1,1,1,NULL,0,'0000-00-00',0,0,0,0,'Este es el foro principal de la categoría. Es creada el nivel de una categoría que sirve como un contenedor para cada tema o foros. También se le conoce como una categoría de nivel 1 y es la que debe tener cualquier Foro Kunena en su configuración.','A fin de proporcionar información adicional para todos los invitados y los miembros, La cabecera del foro se puede aprovechar para mostrar texto en la parte superior de una categoría.','',0,'lastpost',0,0,0,0,0,''),
  (2,1,'Bienvenido Mat','bienvenido-mat',0,0,'joomla.group',0,1,1,0,1,1,1,NULL,0,'0000-00-00',0,0,0,0,'Alentamos a los nuevos miembros a enviar una breve introducción de sí mismos en esta categoría del foro. Para así llegar a conocerse y compartir los intereses que posean en común.','[b]Bienvenido al foro Kunena![/B] \n\n Cuéntanos a todos acerca de quién eres, qué te gusta y por qué te has convertido en miembro de este sitio. \n Damos la bienvenida a todos los nuevos miembros y esperamos verlos siempre por aquí!','',0,'lastpost',1,1,1,1,1449575088,''),
  (3,1,'Buzón de Sugerencias','buzon-de-sugerencias',0,0,'joomla.group',0,1,1,0,1,2,1,NULL,0,'0000-00-00',0,0,0,0,'Tienes algún comentario o aporte para compartir? \n No sea tímido y envíenos una nota. Queremos saber de ti y tratar de hacer de nuestro sitio el mejor y más fácil de usar para nuestros miembros e invitados en general.','Este es el encabezado opcional del foro para el buzón de sugerencias.','',1,'lastpost',0,0,0,0,0,'');

COMMIT;

#
# Data for the `gir_kunena_messages` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_messages` (`id`, `parent`, `thread`, `catid`, `name`, `userid`, `email`, `subject`, `time`, `ip`, `topic_emoticon`, `locked`, `hold`, `ordering`, `hits`, `moved`, `modified_by`, `modified_time`, `modified_reason`) VALUES 
  (1,0,1,2,'Kunena',540,NULL,'Bienvenido a Kunena!',1449575088,'127.0.0.1',0,0,0,0,0,0,NULL,NULL,NULL);

COMMIT;

#
# Data for the `gir_kunena_messages_text` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_messages_text` (`mesid`, `message`) VALUES 
  (1,'[size=4][b]¡Bienvenido a Kunena![/b][/size] \n\n Gracias por elegir Kunena para las necesidades de creación de foros para su comunidad en Joomla. \n\n Kunena, que traducido del Swahili significa “hablar”, se construyó por un equipo de profesionales en código abierto con el propósito de proporcionar una solución para crear foros de alta calidad, serio y unificado en Joomla.\n\n\n [size=4][b]Fuentes Adicionales de Kunena[/b][/size] \n\n [b]Documentación de Kunena:[/b] [url]http://www.kunena.org/docs[/url] \n\n [b]Foro de Soporte de Kunena[/b]: [url]http://www.kunena.org/forum[/url] \n\n [b]Descargas para Kunena:[/b] [url]http://www.kunena.org/download[/url] \n\n [b]Blog de Kunena:[/b] [url]http://www.kunena.org/blog[/url] \n\n [b]Siga a Kunena en Twitter:[/b] [url]http://www.kunena.org/twitter[/url]');

COMMIT;

#
# Data for the `gir_kunena_ranks` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_ranks` (`rank_id`, `rank_title`, `rank_min`, `rank_special`, `rank_image`) VALUES 
  (1,'Navegador Iniciado',0,0,'rank1.gif'),
  (2,'Navegador Junior',20,0,'rank2.gif'),
  (3,'Navegador Senior',40,0,'rank3.gif'),
  (4,'Navegador Experto',80,0,'rank4.gif'),
  (5,'Navegador Dorado',160,0,'rank5.gif'),
  (6,'Navegador Platino',320,0,'rank6.gif'),
  (7,'Administrador',0,1,'rankadmin.gif'),
  (8,'Moderador',0,1,'rankmod.gif'),
  (9,'Spammer',0,1,'rankspammer.gif'),
  (10,'Sancionado',0,1,'rankbanned.gif');

COMMIT;

#
# Data for the `gir_kunena_sessions` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_sessions` (`userid`, `allowed`, `lasttime`, `readtopics`, `currvisit`) VALUES 
  (540,'na',1451571106,'0',1454184783),
  (541,'na',1454963331,'0',1456172933);

COMMIT;

#
# Data for the `gir_kunena_smileys` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_smileys` (`id`, `code`, `location`, `greylocation`, `emoticonbar`) VALUES 
  (1,'B)','cool.png','cool-grey.png',1),
  (2,'8)','cool.png','cool-grey.png',0),
  (3,'8-)','cool.png','cool-grey.png',0),
  (4,':-(','sad.png','sad-grey.png',0),
  (5,':(','sad.png','sad-grey.png',1),
  (6,':sad:','sad.png','sad-grey.png',0),
  (7,':cry:','sad.png','sad-grey.png',0),
  (8,':)','smile.png','smile-grey.png',1),
  (9,':-)','smile.png','smile-grey.png',0),
  (10,':cheer:','cheerful.png','cheerful-grey.png',1),
  (11,';)','wink.png','wink-grey.png',1),
  (12,';-)','wink.png','wink-grey.png',0),
  (13,':wink:','wink.png','wink-grey.png',0),
  (14,';-)','wink.png','wink-grey.png',0),
  (15,':P','tongue.png','tongue-grey.png',1),
  (16,':p','tongue.png','tongue-grey.png',0),
  (17,':-p','tongue.png','tongue-grey.png',0),
  (18,':-P','tongue.png','tongue-grey.png',0),
  (19,':razz:','tongue.png','tongue-grey.png',0),
  (20,':angry:','angry.png','angry-grey.png',1),
  (21,':mad:','angry.png','angry-grey.png',0),
  (22,':unsure:','unsure.png','unsure-grey.png',1),
  (23,':o','shocked.png','shocked-grey.png',0),
  (24,':-o','shocked.png','shocked-grey.png',0),
  (25,':O','shocked.png','shocked-grey.png',0),
  (26,':-O','shocked.png','shocked-grey.png',0),
  (27,':eek:','shocked.png','shocked-grey.png',0),
  (28,':ohmy:','shocked.png','shocked-grey.png',1),
  (29,':huh:','wassat.png','wassat-grey.png',1),
  (30,':?','confused.png','confused-grey.png',0),
  (31,':-?','confused.png','confused-grey.png',0),
  (32,':???','confused.png','confused-grey.png',0),
  (33,':dry:','ermm.png','ermm-grey.png',1),
  (34,':ermm:','ermm.png','ermm-grey.png',0),
  (35,':lol:','grin.png','grin-grey.png',1),
  (36,':X','sick.png','sick-grey.png',0),
  (37,':x','sick.png','sick-grey.png',0),
  (38,':sick:','sick.png','sick-grey.png',1),
  (39,':silly:','silly.png','silly-grey.png',1),
  (40,':y32b4:','silly.png','silly-grey.png',0),
  (41,':blink:','blink.png','blink-grey.png',1),
  (42,':blush:','blush.png','blush-grey.png',1),
  (43,':oops:','blush.png','blush-grey.png',1),
  (44,':kiss:','kissing.png','kissing-grey.png',1),
  (45,':rolleyes:','blink.png','blink-grey.png',0),
  (46,':roll:','blink.png','blink-grey.png',0),
  (47,':woohoo:','w00t.png','w00t-grey.png',1),
  (48,':side:','sideways.png','sideways-grey.png',1),
  (49,':S','dizzy.png','dizzy-grey.png',1),
  (50,':s','dizzy.png','dizzy-grey.png',0),
  (51,':evil:','devil.png','devil-grey.png',1),
  (52,':twisted:','devil.png','devil-grey.png',0),
  (53,':whistle:','whistling.png','whistling-grey.png',1),
  (54,':pinch:','pinch.png','pinch-grey.png',1),
  (55,':D','laughing.png','laughing-grey.png',0),
  (56,':-D','laughing.png','laughing-grey.png',0),
  (57,':grin:','laughing.png','laughing-grey.png',0),
  (58,':laugh:','laughing.png','laughing-grey.png',0),
  (59,':|','neutral.png','neutral-grey.png',0),
  (60,':-|','neutral.png','neutral-grey.png',0),
  (61,':neutral:','neutral.png','neutral-grey.png',0),
  (62,':mrgreen:','mrgreen.png','mrgreen-grey.png',0),
  (63,':?:','question.png','question-grey.png',0),
  (64,':!:','exclamation.png','exclamation-grey.png',0),
  (65,':arrow:','arrow.png','arrow-grey.png',0),
  (66,':idea:','idea.png','idea-grey.png',0);

COMMIT;

#
# Data for the `gir_kunena_topics` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_topics` (`id`, `category_id`, `subject`, `icon_id`, `locked`, `hold`, `ordering`, `posts`, `hits`, `attachments`, `poll_id`, `moved_id`, `first_post_id`, `first_post_time`, `first_post_userid`, `first_post_message`, `first_post_guest_name`, `last_post_id`, `last_post_time`, `last_post_userid`, `last_post_message`, `last_post_guest_name`, `params`) VALUES 
  (1,2,'Bienvenido a Kunena!',0,0,0,0,1,0,0,0,0,1,1449575088,540,'[size=4][b]¡Bienvenido a Kunena![/b][/size] \n\n Gracias por elegir Kunena para las necesidades de creación de foros para su comunidad en Joomla. \n\n Kunena, que traducido del Swahili significa “hablar”, se construyó por un equipo de profesionales en código abierto con el propósito de proporcionar una solución para crear foros de alta calidad, serio y unificado en Joomla.\n\n\n [size=4][b]Fuentes Adicionales de Kunena[/b][/size] \n\n [b]Documentación de Kunena:[/b] [url]http://www.kunena.org/docs[/url] \n\n [b]Foro de Soporte de Kunena[/b]: [url]http://www.kunena.org/forum[/url] \n\n [b]Descargas para Kunena:[/b] [url]http://www.kunena.org/download[/url] \n\n [b]Blog de Kunena:[/b] [url]http://www.kunena.org/blog[/url] \n\n [b]Siga a Kunena en Twitter:[/b] [url]http://www.kunena.org/twitter[/url]','Kunena',1,1449575088,540,'[size=4][b]¡Bienvenido a Kunena![/b][/size] \n\n Gracias por elegir Kunena para las necesidades de creación de foros para su comunidad en Joomla. \n\n Kunena, que traducido del Swahili significa “hablar”, se construyó por un equipo de profesionales en código abierto con el propósito de proporcionar una solución para crear foros de alta calidad, serio y unificado en Joomla.\n\n\n [size=4][b]Fuentes Adicionales de Kunena[/b][/size] \n\n [b]Documentación de Kunena:[/b] [url]http://www.kunena.org/docs[/url] \n\n [b]Foro de Soporte de Kunena[/b]: [url]http://www.kunena.org/forum[/url] \n\n [b]Descargas para Kunena:[/b] [url]http://www.kunena.org/download[/url] \n\n [b]Blog de Kunena:[/b] [url]http://www.kunena.org/blog[/url] \n\n [b]Siga a Kunena en Twitter:[/b] [url]http://www.kunena.org/twitter[/url]','Kunena','');

COMMIT;

#
# Data for the `gir_kunena_user_topics` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_user_topics` (`user_id`, `topic_id`, `category_id`, `posts`, `last_post_id`, `owner`, `favorite`, `subscribed`, `params`) VALUES 
  (540,1,2,1,1,1,0,0,'');

COMMIT;

#
# Data for the `gir_kunena_users` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_users` (`userid`, `view`, `signature`, `moderator`, `banned`, `ordering`, `posts`, `avatar`, `karma`, `karma_time`, `group_id`, `uhits`, `personalText`, `gender`, `birthdate`, `location`, `icq`, `aim`, `yim`, `msn`, `skype`, `twitter`, `facebook`, `gtalk`, `myspace`, `linkedin`, `delicious`, `friendfeed`, `digg`, `blogspot`, `flickr`, `bebo`, `websitename`, `websiteurl`, `rank`, `hideEmail`, `showOnline`, `thankyou`) VALUES 
  (540,'',NULL,0,NULL,0,1,NULL,0,0,1,0,NULL,0,'0001-01-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,1,0),
  (541,'',NULL,0,NULL,0,0,NULL,0,0,1,0,NULL,0,'0001-01-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,1,0),
  (542,'',NULL,0,NULL,0,0,NULL,0,0,1,0,NULL,0,'0001-01-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,1,0),
  (543,'',NULL,0,NULL,0,0,NULL,0,0,1,0,NULL,0,'0001-01-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,1,0),
  (544,'',NULL,0,NULL,0,0,NULL,0,0,1,0,NULL,0,'0001-01-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,1,0),
  (545,'',NULL,0,NULL,0,0,NULL,0,0,1,0,NULL,0,'0001-01-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,1,0),
  (546,'',NULL,0,NULL,0,0,NULL,0,0,1,0,NULL,0,'0001-01-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,1,0);

COMMIT;

#
# Data for the `gir_kunena_version` table  (LIMIT 0,500)
#

INSERT INTO `gir_kunena_version` (`id`, `version`, `versiondate`, `installdate`, `build`, `versionname`, `state`) VALUES 
  (1,'3.0.5','2014-03-09','2015-12-08','','Invecchiato','');

COMMIT;

#
# Data for the `gir_languages` table  (LIMIT 0,500)
#

INSERT INTO `gir_languages` (`lang_id`, `lang_code`, `title`, `title_native`, `sef`, `image`, `description`, `metakey`, `metadesc`, `sitename`, `published`, `access`, `ordering`) VALUES 
  (1,'en-GB','English (UK)','English (UK)','en','en','','','','',1,1,1);

COMMIT;

#
# Data for the `gir_menu` table  (LIMIT 0,500)
#

INSERT INTO `gir_menu` (`id`, `menutype`, `title`, `alias`, `note`, `path`, `link`, `type`, `published`, `parent_id`, `level`, `component_id`, `checked_out`, `checked_out_time`, `browserNav`, `access`, `img`, `template_style_id`, `params`, `lft`, `rgt`, `home`, `language`, `client_id`) VALUES 
  (1,'','Menu_Item_Root','root','','','','',1,0,0,0,0,'0000-00-00',0,0,'',0,'',0,423,0,'*',0),
  (2,'menu','com_banners','Banners','','Banners','index.php?option=com_banners','component',0,1,1,4,0,'0000-00-00',0,0,'class:banners',0,'',11,20,0,'*',1),
  (3,'menu','com_banners','Banners','','Banners/Banners','index.php?option=com_banners','component',0,2,2,4,0,'0000-00-00',0,0,'class:banners',0,'',12,13,0,'*',1),
  (4,'menu','com_banners_categories','Categories','','Banners/Categories','index.php?option=com_categories&extension=com_banners','component',0,2,2,6,0,'0000-00-00',0,0,'class:banners-cat',0,'',14,15,0,'*',1),
  (5,'menu','com_banners_clients','Clients','','Banners/Clients','index.php?option=com_banners&view=clients','component',0,2,2,4,0,'0000-00-00',0,0,'class:banners-clients',0,'',16,17,0,'*',1),
  (6,'menu','com_banners_tracks','Tracks','','Banners/Tracks','index.php?option=com_banners&view=tracks','component',0,2,2,4,0,'0000-00-00',0,0,'class:banners-tracks',0,'',18,19,0,'*',1),
  (7,'menu','com_contact','Contacts','','Contacts','index.php?option=com_contact','component',0,1,1,8,0,'0000-00-00',0,0,'class:contact',0,'',21,26,0,'*',1),
  (8,'menu','com_contact','Contacts','','Contacts/Contacts','index.php?option=com_contact','component',0,7,2,8,0,'0000-00-00',0,0,'class:contact',0,'',22,23,0,'*',1),
  (9,'menu','com_contact_categories','Categories','','Contacts/Categories','index.php?option=com_categories&extension=com_contact','component',0,7,2,6,0,'0000-00-00',0,0,'class:contact-cat',0,'',24,25,0,'*',1),
  (10,'menu','com_messages','Messaging','','Messaging','index.php?option=com_messages','component',0,1,1,15,0,'0000-00-00',0,0,'class:messages',0,'',27,32,0,'*',1),
  (11,'menu','com_messages_add','New Private Message','','Messaging/New Private Message','index.php?option=com_messages&task=message.add','component',0,10,2,15,0,'0000-00-00',0,0,'class:messages-add',0,'',28,29,0,'*',1),
  (12,'menu','com_messages_read','Read Private Message','','Messaging/Read Private Message','index.php?option=com_messages','component',0,10,2,15,0,'0000-00-00',0,0,'class:messages-read',0,'',30,31,0,'*',1),
  (13,'menu','com_newsfeeds','News Feeds','','News Feeds','index.php?option=com_newsfeeds','component',0,1,1,17,0,'0000-00-00',0,0,'class:newsfeeds',0,'',33,38,0,'*',1),
  (14,'menu','com_newsfeeds_feeds','Feeds','','News Feeds/Feeds','index.php?option=com_newsfeeds','component',0,13,2,17,0,'0000-00-00',0,0,'class:newsfeeds',0,'',34,35,0,'*',1),
  (15,'menu','com_newsfeeds_categories','Categories','','News Feeds/Categories','index.php?option=com_categories&extension=com_newsfeeds','component',0,13,2,6,0,'0000-00-00',0,0,'class:newsfeeds-cat',0,'',36,37,0,'*',1),
  (16,'menu','com_redirect','Redirect','','Redirect','index.php?option=com_redirect','component',0,1,1,24,0,'0000-00-00',0,0,'class:redirect',0,'',47,48,0,'*',1),
  (17,'menu','com_search','Basic Search','','Basic Search','index.php?option=com_search','component',0,1,1,19,0,'0000-00-00',0,0,'class:search',0,'',43,44,0,'*',1),
  (21,'menu','com_finder','Smart Search','','Smart Search','index.php?option=com_finder','component',0,1,1,27,0,'0000-00-00',0,0,'class:finder',0,'',39,40,0,'*',1),
  (22,'menu','com_joomlaupdate','Joomla! Update','','Joomla! Update','index.php?option=com_joomlaupdate','component',0,1,1,28,0,'0000-00-00',0,0,'class:joomlaupdate',0,'',41,42,0,'*',1),
  (201,'usermenu','Your Profile','your-profile','','your-profile','index.php?option=com_users&view=profile','component',1,1,1,25,0,'0000-00-00',0,2,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',231,232,0,'*',0),
  (207,'top','Joomla.org','joomlaorg','','joomlaorg','http://joomla.org','url',-2,1,1,0,0,'0000-00-00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',229,230,0,'*',0),
  (229,'aboutjoomla','Single Contact','single-contact','','using-joomla/extensions/components/contact-component/single-contact','index.php?option=com_contact&view=contact&id=1','component',1,270,5,8,0,'0000-00-00',0,1,'',0,'{\"show_category_crumb\":\"\",\"presentation_style\":\"\",\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',73,74,0,'*',0),
  (233,'mainmenu','Login','login','','login','index.php?option=com_users&view=login','component',1,1,1,25,0,'0000-00-00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',9,10,0,'*',0),
  (238,'mainmenu','Sample Sites','sample-sites','','sample-sites','index.php?option=com_content&view=article&id=38','component',1,1,1,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',233,238,0,'*',0),
  (251,'aboutjoomla','Contact Categories','contact-categories','','using-joomla/extensions/components/contact-component/contact-categories','index.php?option=com_contact&view=categories&id=16','component',1,270,5,8,0,'0000-00-00',0,1,'',0,'{\"show_base_description\":\"\",\"categories_description\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"filter_field\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"presentation_style\":\"sliders\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',69,70,0,'*',0),
  (252,'aboutjoomla','News Feed Categories','new-feed-categories','','using-joomla/extensions/components/news-feeds-component/new-feed-categories','index.php?option=com_newsfeeds&view=categories&id=0','component',1,267,5,17,0,'0000-00-00',0,1,'',0,'{\"show_base_description\":\"1\",\"categories_description\":\"Because this links to the root category the \"uncategorised\" category is displayed. \",\"maxLevel\":\"-1\",\"show_empty_categories\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_cat_num_articles\":\"1\",\"display_num\":\"\",\"show_headings\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',79,80,0,'*',0),
  (253,'aboutjoomla','News Feed Category','news-feed-category','','using-joomla/extensions/components/news-feeds-component/news-feed-category','index.php?option=com_newsfeeds&view=category&id=17','component',1,267,5,17,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',83,84,0,'*',0),
  (254,'aboutjoomla','Single News Feed','single-news-feed','','using-joomla/extensions/components/news-feeds-component/single-news-feed','index.php?option=com_newsfeeds&view=newsfeed&id=4','component',1,267,5,17,0,'0000-00-00',0,1,'',0,'{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',81,82,0,'*',0),
  (255,'aboutjoomla','Search','search','','using-joomla/extensions/components/search-component/search','index.php?option=com_search&view=search','component',1,276,5,19,0,'0000-00-00',0,1,'',0,'{\"search_areas\":\"1\",\"show_date\":\"1\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',101,102,0,'*',0),
  (256,'aboutjoomla','Archived Articles','archived-articles','','using-joomla/extensions/components/content-component/archived-articles','index.php?option=com_content&view=archive','component',1,266,5,22,0,'0000-00-00',0,1,'',0,'{\"orderby_sec\":\"\",\"order_date\":\"\",\"display_num\":\"\",\"filter_field\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_hits\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',63,64,0,'*',0),
  (257,'aboutjoomla','Single Article','single-article','','using-joomla/extensions/components/content-component/single-article','index.php?option=com_content&view=article&id=6','component',1,266,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',53,54,0,'*',0),
  (259,'aboutjoomla','Article Category Blog','article-category-blog','','using-joomla/extensions/components/content-component/article-category-blog','index.php?option=com_content&view=category&layout=blog&id=27','component',1,266,5,22,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"0\",\"show_description_image\":\"0\",\"show_category_title\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',57,58,0,'*',0),
  (260,'aboutjoomla','Article Category List','article-category-list','','using-joomla/extensions/components/content-component/article-category-list','index.php?option=com_content&view=category&id=19','component',1,266,5,22,0,'0000-00-00',0,1,'',0,'{\"show_category_title\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_no_articles\":\"\",\"show_subcat_desc\":\"\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"show_pagination_limit\":\"\",\"filter_field\":\"\",\"show_headings\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"alpha\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"display_num\":\"10\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_readmore_title\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',59,60,0,'*',0),
  (262,'aboutjoomla','Featured Articles','featured-articles','','using-joomla/extensions/components/content-component/featured-articles','index.php?option=com_content&view=featured','component',1,266,5,22,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',61,62,0,'*',0),
  (263,'aboutjoomla','Submit Article','submit-article','','using-joomla/extensions/components/content-component/submit-article','index.php?option=com_content&view=form&layout=edit','component',1,266,5,22,0,'0000-00-00',0,3,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',65,66,0,'*',0),
  (266,'aboutjoomla','Content Component','content-component','','using-joomla/extensions/components/content-component','index.php?option=com_content&view=article&id=10','component',1,268,4,22,0,'0000-00-00',0,1,'',0,'{\"article-allow_ratings\":\"\",\"article-allow_comments\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',52,67,0,'*',0),
  (267,'aboutjoomla','News Feeds Component','news-feeds-component','','using-joomla/extensions/components/news-feeds-component','index.php?option=com_content&view=article&id=60','component',1,268,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"Newsfeeds Categories View \",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',78,85,0,'*',0),
  (268,'aboutjoomla','Components','components','','using-joomla/extensions/components','index.php?option=com_content&view=category&layout=blog&id=21','component',1,277,3,22,0,'0000-00-00',0,1,'',0,'{\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_subcat_desc\":\"\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"num_leading_articles\":\"0\",\"num_intro_articles\":\"7\",\"num_columns\":\"1\",\"num_links\":\"0\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"0\",\"show_pagination_results\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_readmore\":\"\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',51,108,0,'*',0),
  (270,'aboutjoomla','Contact Component','contact-component','','using-joomla/extensions/components/contact-component','index.php?option=com_content&view=article&id=9','component',1,268,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',68,77,0,'*',0),
  (271,'aboutjoomla','Users Component','users-component','','using-joomla/extensions/components/users-component','index.php?option=com_content&view=article&id=52','component',1,268,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',86,99,0,'*',0),
  (272,'aboutjoomla','Article Categories','article-categories','','using-joomla/extensions/components/content-component/article-categories','index.php?option=com_content&view=categories&id=14','component',1,266,5,22,0,'0000-00-00',0,1,'',0,'{\"show_base_description\":\"\",\"categories_description\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"category_layout\":\"\",\"show_headings\":\"\",\"show_date\":\"\",\"date_format\":\"\",\"filter_field\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',55,56,0,'*',0),
  (273,'aboutjoomla','Administrator Components','administrator-components','','using-joomla/extensions/components/administrator-components','index.php?option=com_content&view=article&id=1','component',1,268,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',106,107,0,'*',0),
  (275,'aboutjoomla','Contact Single Category','contact-single-category','','using-joomla/extensions/components/contact-component/contact-single-category','index.php?option=com_contact&view=category&catid=26&id=36','component',1,270,5,8,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"20\",\"show_headings\":\"\",\"filter_field\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"presentation_style\":\"sliders\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',71,72,0,'*',0),
  (276,'aboutjoomla','Search Components','search-component','','using-joomla/extensions/components/search-component','index.php?option=com_content&view=article&id=39','component',1,268,4,22,0,'0000-00-00',0,1,'',0,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',100,105,0,'*',0),
  (277,'aboutjoomla','Using Extensions','extensions','','using-joomla/extensions','index.php?option=com_content&view=categories&id=20','component',1,280,2,22,0,'0000-00-00',0,1,'',0,'{\"show_base_description\":\"1\",\"categories_description\":\"\",\"maxLevelcat\":\"1\",\"show_empty_categories_cat\":\"1\",\"show_subcat_desc_cat\":\"1\",\"show_cat_num_articles_cat\":\"0\",\"drill_down_layout\":\"0\",\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"1\",\"show_empty_categories\":\"1\",\"show_subcat_desc\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"show_pagination_limit\":\"\",\"filter_field\":\"\",\"show_headings\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',50,199,0,'*',0),
  (278,'aboutjoomla','The Joomla! Project','the-joomla-project','','the-joomla-project','index.php?option=com_content&view=article&id=48','component',1,1,1,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"1\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"1\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',223,224,0,'*',0),
  (279,'aboutjoomla','The Joomla! Community','the-joomla-community','','the-joomla-community','index.php?option=com_content&view=article&id=47','component',1,1,1,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"0\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',225,226,0,'*',0),
  (280,'aboutjoomla','Using Joomla!','using-joomla','','using-joomla','index.php?option=com_content&view=article&id=53','component',1,1,1,22,0,'0000-00-00',0,1,'',0,'{\"show_title\":\"1\",\"link_titles\":\"0\",\"show_intro\":\"1\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"show_noauth\":\"0\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',49,204,0,'*',0),
  (281,'aboutjoomla','Modules','modules','','using-joomla/extensions/modules','index.php?option=com_content&view=category&id=22','component',1,277,3,22,0,'0000-00-00',0,1,'',0,'{\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"1\",\"show_empty_categories\":\"1\",\"show_no_articles\":\"0\",\"show_subcat_desc\":\"1\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"show_pagination_limit\":\"\",\"filter_field\":\"\",\"show_headings\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"show_title\":\"1\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_vote\":\"\",\"show_readmore\":\"0\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',109,166,0,'*',0),
  (282,'aboutjoomla','Templates','templates','','using-joomla/extensions/templates','index.php?option=com_content&view=category&id=23','component',1,277,3,22,0,'0000-00-00',0,1,'',0,'{\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"maxLevel\":\"2\",\"show_empty_categories\":\"1\",\"show_no_articles\":\"0\",\"show_subcat_desc\":\"1\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"show_pagination_limit\":\"0\",\"filter_field\":\"hide\",\"show_headings\":\"0\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"show_pagination\":\"0\",\"show_pagination_results\":\"\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"Templates\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',167,180,0,'*',0),
  (283,'aboutjoomla','Languages','languages','','using-joomla/extensions/languages','index.php?option=com_content&view=category&layout=blog&id=24','component',1,277,3,22,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_category_title\":\"1\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',181,182,0,'*',0),
  (284,'aboutjoomla','Plugins','plugins','','using-joomla/extensions/plugins','index.php?option=com_content&view=category&layout=blog&id=25','component',1,277,3,22,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_category_title\":\"1\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"0\",\"num_intro_articles\":\"7\",\"num_columns\":\"1\",\"num_links\":\"0\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',183,198,0,'*',0),
  (290,'mainmenu','Articles','articles','','site-map/articles','index.php?option=com_content&view=categories&id=0','component',1,294,2,22,0,'0000-00-00',0,1,'',0,'{\"categories_description\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"category_layout\":\"\",\"show_headings\":\"\",\"show_date\":\"\",\"date_format\":\"\",\"filter_field\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"article-allow_ratings\":\"\",\"article-allow_comments\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',4,5,0,'*',0),
  (294,'mainmenu','Site Map','site-map','','site-map','index.php?option=com_content&view=article&id=42','component',1,1,1,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',3,8,0,'*',0),
  (300,'aboutjoomla','Latest Users','latest-users','','using-joomla/extensions/modules/user-modules/latest-users','index.php?option=com_content&view=article&id=66','component',1,412,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',133,134,0,'*',0),
  (301,'aboutjoomla','Who''s Online','whos-online','','using-joomla/extensions/modules/user-modules/whos-online','index.php?option=com_content&view=article&id=56','component',1,412,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',135,136,0,'*',0),
  (302,'aboutjoomla','Most Read','most-read','','using-joomla/extensions/modules/content-modules/most-read','index.php?option=com_content&view=article&id=30','component',1,411,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',117,118,0,'*',0),
  (303,'aboutjoomla','Menu','menu','','using-joomla/extensions/modules/navigation-modules/menu','index.php?option=com_content&view=article&id=29','component',1,415,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',111,112,0,'*',0),
  (304,'aboutjoomla','Statistics','statistics','','using-joomla/extensions/modules/utility-modules/statistics','index.php?option=com_content&view=article&id=44','component',1,414,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',155,156,0,'*',0),
  (305,'aboutjoomla','Banner','banner','','using-joomla/extensions/modules/display-modules/banner','index.php?option=com_content&view=article&id=7','component',1,413,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',143,144,0,'*',0),
  (306,'aboutjoomla','Search','search','','using-joomla/extensions/modules/utility-modules/search','index.php?option=com_content&view=article&id=40','component',1,414,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',157,158,0,'*',0),
  (307,'aboutjoomla','Random Image','random-image','','using-joomla/extensions/modules/display-modules/random-image','index.php?option=com_content&view=article&id=36','component',1,413,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',141,142,0,'*',0),
  (309,'aboutjoomla','News Flash','news-flash','','using-joomla/extensions/modules/content-modules/news-flash','index.php?option=com_content&view=article&id=31','component',1,411,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',119,120,0,'*',0),
  (310,'aboutjoomla','Latest Articles','latest-articles','','using-joomla/extensions/modules/content-modules/latest-articles','index.php?option=com_content&view=article&id=27','component',1,411,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',121,122,0,'*',0),
  (311,'aboutjoomla','Syndicate','syndicate','','using-joomla/extensions/modules/utility-modules/syndicate','index.php?option=com_content&view=article&id=45','component',1,414,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',153,154,0,'*',0),
  (312,'aboutjoomla','Login','login','','using-joomla/extensions/modules/user-modules/login','index.php?option=com_content&view=article&id=28','component',1,412,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',137,138,0,'*',0),
  (313,'aboutjoomla','Wrapper','wrapper','','using-joomla/extensions/modules/utility-modules/wrapper','index.php?option=com_content&view=article&id=59','component',1,414,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',161,162,0,'*',0),
  (317,'aboutjoomla','System','system','','using-joomla/extensions/plugins/system','index.php?option=com_content&view=article&id=46','component',1,284,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',196,197,0,'*',0),
  (318,'aboutjoomla','Authentication','authentication','','using-joomla/extensions/plugins/authentication','index.php?option=com_content&view=article&id=5','component',1,284,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',184,185,0,'*',0),
  (319,'aboutjoomla','Content','content','','using-joomla/extensions/plugins/content','index.php?option=com_content&view=article&id=62','component',1,284,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',186,187,0,'*',0),
  (320,'aboutjoomla','Editors','editors','','using-joomla/extensions/plugins/editors','index.php?option=com_content&view=article&id=14','component',1,284,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',188,189,0,'*',0),
  (321,'aboutjoomla','Editors Extended','editors-extended','','using-joomla/extensions/plugins/editors-extended','index.php?option=com_content&view=article&id=15','component',1,284,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',190,191,0,'*',0),
  (322,'aboutjoomla','Search','search','','using-joomla/extensions/plugins/search','index.php?option=com_content&view=article&id=41','component',1,284,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',192,193,0,'*',0),
  (323,'aboutjoomla','User','user','','using-joomla/extensions/plugins/user','index.php?option=com_content&view=article&id=51','component',1,284,4,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',194,195,0,'*',0),
  (324,'aboutjoomla','Footer','footer','','using-joomla/extensions/modules/display-modules/footer','index.php?option=com_content&view=article&id=19','component',1,413,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',147,148,0,'*',0),
  (325,'aboutjoomla','Archive','archive','','using-joomla/extensions/modules/content-modules/archive','index.php?option=com_content&view=article&id=2','component',1,411,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',123,124,0,'*',0),
  (326,'aboutjoomla','Related Items','related-items','','using-joomla/extensions/modules/content-modules/related-items','index.php?option=com_content&view=article&id=37','component',1,411,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',125,126,0,'*',0),
  (402,'aboutjoomla','Login Form','login-form','','using-joomla/extensions/components/users-component/login-form','index.php?option=com_users&view=login','component',1,271,5,25,0,'0000-00-00',0,1,'',0,'{\"login_redirect_url\":\"\",\"logindescription_show\":\"1\",\"login_description\":\"\",\"login_image\":\"\",\"logout_redirect_url\":\"\",\"logoutdescription_show\":\"1\",\"logout_description\":\"\",\"logout_image\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',87,88,0,'*',0),
  (403,'aboutjoomla','User Profile','user-profile','','using-joomla/extensions/components/users-component/user-profile','index.php?option=com_users&view=profile','component',1,271,5,25,0,'0000-00-00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',89,90,0,'*',0),
  (404,'aboutjoomla','Edit User Profile','edit-user-profile','','using-joomla/extensions/components/users-component/edit-user-profile','index.php?option=com_users&view=profile&layout=edit','component',1,271,5,25,0,'0000-00-00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',91,92,0,'*',0),
  (405,'aboutjoomla','Registration Form','registration-form','','using-joomla/extensions/components/users-component/registration-form','index.php?option=com_users&view=registration','component',1,271,5,25,0,'0000-00-00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',93,94,0,'*',0),
  (406,'aboutjoomla','Username Reminder Request','username-reminder','','using-joomla/extensions/components/users-component/username-reminder','index.php?option=com_users&view=remind','component',1,271,5,25,0,'0000-00-00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',95,96,0,'*',0),
  (409,'aboutjoomla','Password Reset','password-reset','','using-joomla/extensions/components/users-component/password-reset','index.php?option=com_users&view=reset','component',1,271,5,25,0,'0000-00-00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',97,98,0,'*',0),
  (410,'aboutjoomla','Feed Display','feed-display','','using-joomla/extensions/modules/display-modules/feed-display','index.php?option=com_content&view=article&id=16','component',1,413,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',145,146,0,'*',0),
  (411,'aboutjoomla','Content Modules','content-modules','','using-joomla/extensions/modules/content-modules','index.php?option=com_content&view=category&id=64','component',1,281,4,22,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"0\",\"show_category_title\":\"1\",\"page_subheading\":\"\",\"show_empty_categories\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"0\",\"show_headings\":\"0\",\"list_show_title\":\"1\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"filter_field\":\"hide\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"0\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',116,131,0,'*',0),
  (412,'aboutjoomla','User Modules','user-modules','','using-joomla/extensions/modules/user-modules','index.php?option=com_content&view=category&id=65','component',1,281,4,22,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"0\",\"show_category_title\":\"1\",\"page_subheading\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"0\",\"show_headings\":\"0\",\"list_show_title\":\"1\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"filter_field\":\"hide\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"0\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',132,139,0,'*',0),
  (413,'aboutjoomla','Display Modules','display-modules','','using-joomla/extensions/modules/display-modules','index.php?option=com_content&view=category&id=66','component',1,281,4,22,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"0\",\"show_category_title\":\"1\",\"page_subheading\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_cat_num_articles\":\"\",\"display_num\":\"0\",\"show_headings\":\"0\",\"list_show_title\":\"1\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"filter_field\":\"hide\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"0\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',140,151,0,'*',0),
  (414,'aboutjoomla','Utility Modules','utility-modules','','using-joomla/extensions/modules/utility-modules','index.php?option=com_content&view=category&id=67','component',1,281,4,22,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"0\",\"show_category_title\":\"1\",\"page_subheading\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_cat_num_articles\":\"\",\"display_num\":\"0\",\"show_headings\":\"0\",\"list_show_title\":\"0\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"filter_field\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"0\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',152,165,0,'*',0),
  (415,'aboutjoomla','Navigation Modules','navigation-modules','','using-joomla/extensions/modules/navigation-modules','index.php?option=com_content&view=category&id=75','component',1,281,4,22,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"\",\"show_category_title\":\"\",\"page_subheading\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"list_show_title\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"filter_field\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',110,115,0,'*',0),
  (416,'aboutjoomla','Breadcrumbs','breadcrumbs','','using-joomla/extensions/modules/navigation-modules/breadcrumbs','index.php?option=com_content&view=article&id=61','component',1,415,5,22,0,'0000-00-00',0,1,'',0,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',113,114,0,'*',0),
  (418,'aboutjoomla','Custom HTML','custom-html','','using-joomla/extensions/modules/display-modules/custom-html','index.php?option=com_content&view=article&id=12','component',1,413,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',149,150,0,'*',0),
  (419,'aboutjoomla','Beez3','beez3','','using-joomla/extensions/templates/beez3','index.php?option=com_content&view=category&layout=blog&id=69','component',1,282,4,22,0,'0000-00-00',0,1,'',9,'{\"layout_type\":\"blog\",\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_no_articles\":\"\",\"show_subcat_desc\":\"\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"show_subcategory_content\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"info_bloc_position\":\"0\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_readmore_title\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',168,173,0,'*',0),
  (423,'aboutjoomla','Typography Beez 3','typography-beez-3','','using-joomla/extensions/templates/beez3/typography-beez-3','index.php?option=com_content&view=article&id=49','component',1,419,5,22,0,'0000-00-00',0,1,'',4,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"0\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',169,170,0,'*',0),
  (424,'aboutjoomla','Home Page Beez 3','home-page-beez-3','','using-joomla/extensions/templates/beez3/home-page-beez-3','index.php?option=com_content&view=featured','component',1,419,5,22,0,'0000-00-00',0,1,'',4,'{\"featured_categories\":[\"\"],\"layout_type\":\"blog\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"3\",\"num_columns\":\"3\",\"num_links\":\"0\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_pagination_results\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"info_bloc_position\":\"0\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_readmore_title\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',171,172,0,'*',0),
  (435,'mainmenu','Home','homepage','','homepage','index.php?option=com_content&view=featured','component',1,1,1,22,0,'0000-00-00',0,1,'',0,'{\"featured_categories\":[\"\"],\"num_leading_articles\":\"1\",\"num_intro_articles\":\"3\",\"num_columns\":\"3\",\"num_links\":\"0\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_pagination_results\":\"\",\"show_title\":\"1\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_vote\":\"\",\"show_readmore\":\"1\",\"show_readmore_title\":\"\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_noauth\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',1,2,0,'*',0),
  (436,'aboutjoomla','Getting Help','getting-help','','using-joomla/getting-help','index.php?option=com_content&view=article&id=21','component',1,280,2,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',202,203,0,'*',0),
  (437,'aboutjoomla','Getting Started','getting-started','','getting-started','index.php?option=com_content&view=article&id=22','component',1,1,1,22,0,'0000-00-00',0,1,'',0,'{\"show_title\":\"1\",\"link_titles\":\"0\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"show_noauth\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',45,46,0,'*',0),
  (439,'mainmenu','Contacts','contacts','','site-map/contacts','index.php?option=com_contact&view=categories&id=0','component',1,294,2,8,0,'0000-00-00',0,1,'',0,'{\"categories_description\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"filter_field\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"article-allow_ratings\":\"\",\"article-allow_comments\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',6,7,0,'*',0),
  (443,'aboutjoomla','Article Categories','article-categories-view','','using-joomla/extensions/modules/content-modules/article-categories-view','index.php?option=com_content&view=article&id=3','component',1,411,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',127,128,0,'*',0),
  (444,'top','Sample Sites','sample-sites-2','','sample-sites-2','index.php?Itemid=','alias',-2,1,1,0,0,'0000-00-00',0,1,'',0,'{\"aliasoptions\":\"238\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',227,228,0,'*',0),
  (445,'mainmenu','Parks','parks','','sample-sites/parks','index.php?Itemid=','alias',1,238,2,0,0,'0000-00-00',0,1,'',0,'{\"aliasoptions\":\"243\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',234,235,0,'*',0),
  (446,'mainmenu','Shop','shop','','sample-sites/shop','index.php?Itemid=','alias',1,238,2,0,0,'0000-00-00',0,1,'',0,'{\"aliasoptions\":\"429\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',236,237,0,'*',0),
  (447,'aboutjoomla','Language Switcher','language-switcher','','using-joomla/extensions/modules/utility-modules/language-switcher','index.php?option=com_content&view=article&id=26','component',1,414,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',159,160,0,'*',0),
  (448,'mainmenu','Site Administrator','site-administrator','','site-administrator','administrator','url',1,1,1,0,0,'0000-00-00',1,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',239,240,0,'*',0),
  (449,'usermenu','Submit an Article','submit-an-article','','submit-an-article','index.php?option=com_content&view=form&layout=edit','component',1,1,1,22,0,'0000-00-00',0,3,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',241,242,0,'*',0),
  (452,'aboutjoomla','Featured Contacts','featured-contacts','','using-joomla/extensions/components/contact-component/featured-contacts','index.php?option=com_contact&view=featured&id=16','component',1,270,5,8,0,'0000-00-00',0,1,'',0,'{\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"filter_field\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"presentation_style\":\"sliders\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',75,76,0,'*',0),
  (453,'aboutjoomla','Parameters','parameters','','using-joomla/parameters','index.php?option=com_content&view=article&id=32','component',1,280,2,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"1\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"1\",\"link_parent_category\":\"1\",\"show_author\":\"1\",\"link_author\":\"1\",\"show_create_date\":\"1\",\"show_modify_date\":\"1\",\"show_publish_date\":\"1\",\"show_item_navigation\":\"1\",\"show_icons\":\"1\",\"show_print_icon\":\"1\",\"show_email_icon\":\"1\",\"show_hits\":\"1\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',200,201,0,'*',0),
  (455,'mainmenu','Example Pages','example-pages','','example-pages','index.php?Itemid=','alias',1,1,1,0,0,'0000-00-00',0,1,'',0,'{\"aliasoptions\":\"268\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',243,244,0,'*',0),
  (459,'aboutjoomla','Article Category','article-category','','using-joomla/extensions/modules/content-modules/article-category','index.php?option=com_content&view=article&id=4','component',1,411,5,22,0,'0000-00-00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',129,130,0,'*',0),
  (464,'top','Inicio','home','','home','index.php?option=com_content&view=article&id=71','component',1,1,1,22,0,'0000-00-00',0,1,' ',0,'{\"show_title\":\"0\",\"link_titles\":\"0\",\"show_intro\":\"0\",\"info_block_position\":\"1\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_vote\":\"0\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_tags\":\"0\",\"show_noauth\":\"0\",\"urls_position\":\"1\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"0\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":1}',205,206,1,'*',0),
  (466,'aboutjoomla','Smart Search','smart-search','','using-joomla/extensions/components/search-component/smart-search','index.php?option=com_finder&view=search&q=&f=','component',1,276,5,27,0,'0000-00-00',0,1,'',0,'{\"show_date_filters\":\"\",\"show_advanced\":\"\",\"expand_advanced\":\"\",\"show_description\":\"\",\"description_length\":255,\"show_url\":\"\",\"show_pagination_limit\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"allow_empty_query\":\"0\",\"search_order\":\"\",\"show_feed\":\"0\",\"show_feed_text\":\"0\",\"show_feed_link\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',103,104,0,'*',0),
  (467,'aboutjoomla','Smart Search','smart-search','','using-joomla/extensions/modules/utility-modules/smart-search','index.php?option=com_content&view=article&id=70','component',1,414,5,22,0,'0000-00-00',0,1,'',0,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',163,164,0,'*',0),
  (468,'aboutjoomla','Protostar','protostar','','using-joomla/extensions/templates/protostar','index.php?option=com_content&view=category&layout=blog&id=78','component',1,282,4,22,0,'0000-00-00',0,1,'',0,'{\"layout_type\":\"blog\",\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_no_articles\":\"\",\"show_subcat_desc\":\"\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"num_leading_articles\":\"\",\"num_intro_articles\":\"\",\"num_columns\":\"\",\"num_links\":\"\",\"multi_column_order\":\"\",\"show_subcategory_content\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"info_bloc_position\":\"0\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_readmore_title\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',174,179,0,'*',0),
  (469,'aboutjoomla','Home Page Protostar','home-page-protostar','','using-joomla/extensions/templates/protostar/home-page-protostar','index.php?option=com_content&view=featured','component',1,468,5,22,0,'0000-00-00',0,1,'',7,'{\"featured_categories\":[\"\"],\"layout_type\":\"blog\",\"num_leading_articles\":\"\",\"num_intro_articles\":\"\",\"num_columns\":\"\",\"num_links\":\"\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"info_bloc_position\":\"0\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_readmore_title\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',175,176,0,'*',0),
  (470,'aboutjoomla','Typography Protostar','typography-protostar','','using-joomla/extensions/templates/protostar/typography-protostar','index.php?option=com_content&view=article&id=49','component',1,468,5,22,0,'0000-00-00',0,1,'',7,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"0\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',177,178,0,'*',0),
  (471,'menu','com_tags','com-tags','','com-tags','index.php?option=com_tags','component',0,1,1,29,0,'0000-00-00',0,1,'class:tags',0,'',245,246,0,'',1),
  (472,'main','com_postinstall','Post-installation messages','','Post-installation messages','index.php?option=com_postinstall','component',0,1,1,32,0,'0000-00-00',0,1,'class:postinstall',0,'',247,248,0,'*',1),
  (473,'top','prioridad','prioridad','','nomenclador/prioridad','index.php?option=com_prioridad&view=prioridad','component',1,477,2,10003,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',330,331,0,'*',0),
  (474,'top','Programa','programa','','programa','#','url',1,1,1,22,0,'0000-00-00',0,16,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',207,222,0,'*',0),
  (475,'top','Proyecto','proyecto','','proyecto','#','url',1,1,1,22,0,'0000-00-00',0,17,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',249,266,0,'*',0),
  (476,'top','perfil de programa','perfil-programa','','programa/perfil-programa','index.php?option=com_perfil_programa&view=perfil_programa','component',1,474,2,10005,0,'0000-00-00',0,13,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',208,209,0,'*',0),
  (477,'top','Nomencladores','nomenclador','','nomenclador','#','url',1,1,1,0,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',329,360,0,'*',0),
  (478,'top','indicadores impacto','indicadores-impacto','','nomenclador/indicadores-impacto','index.php?option=com_indicadores_impacto&view=indicadores_impacto','component',1,477,2,10006,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',332,333,0,'*',0),
  (479,'main','COM_KUNENA','com-kunena','','com-kunena','index.php?option=com_kunena','component',0,1,1,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-logo-white.png',0,'{}',361,384,0,'',1),
  (480,'main','COM_KUNENA_DASHBOARD','com-kunena-dashboard','','com-kunena/com-kunena-dashboard','index.php?option=com_kunena&view=cpanel','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-logo-white.png',0,'{}',362,363,0,'',1),
  (481,'main','COM_KUNENA_CATEGORY_MANAGER','com-kunena-category-manager','','com-kunena/com-kunena-category-manager','index.php?option=com_kunena&view=categories','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-categories.png',0,'{}',364,365,0,'',1),
  (482,'main','COM_KUNENA_USER_MANAGER','com-kunena-user-manager','','com-kunena/com-kunena-user-manager','index.php?option=com_kunena&view=users','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-users.png',0,'{}',366,367,0,'',1),
  (483,'main','COM_KUNENA_FILE_MANAGER','com-kunena-file-manager','','com-kunena/com-kunena-file-manager','index.php?option=com_kunena&view=attachments','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-files.png',0,'{}',368,369,0,'',1),
  (484,'main','COM_KUNENA_EMOTICON_MANAGER','com-kunena-emoticon-manager','','com-kunena/com-kunena-emoticon-manager','index.php?option=com_kunena&view=smilies','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-smileys.png',0,'{}',370,371,0,'',1),
  (485,'main','COM_KUNENA_RANK_MANAGER','com-kunena-rank-manager','','com-kunena/com-kunena-rank-manager','index.php?option=com_kunena&view=ranks','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-ranks.png',0,'{}',372,373,0,'',1),
  (486,'main','COM_KUNENA_TEMPLATE_MANAGER','com-kunena-template-manager','','com-kunena/com-kunena-template-manager','index.php?option=com_kunena&view=templates','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-templates.png',0,'{}',374,375,0,'',1),
  (487,'main','COM_KUNENA_CONFIGURATION','com-kunena-configuration','','com-kunena/com-kunena-configuration','index.php?option=com_kunena&view=config','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-prune.png',0,'{}',376,377,0,'',1),
  (488,'main','COM_KUNENA_PLUGIN_MANAGER','com-kunena-plugin-manager','','com-kunena/com-kunena-plugin-manager','index.php?option=com_kunena&view=plugins','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-plugins.png',0,'{}',378,379,0,'',1),
  (489,'main','COM_KUNENA_FORUM_TOOLS','com-kunena-forum-tools','','com-kunena/com-kunena-forum-tools','index.php?option=com_kunena&view=tools','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-config.png',0,'{}',380,381,0,'',1),
  (490,'main','COM_KUNENA_TRASH_MANAGER','com-kunena-trash-manager','','com-kunena/com-kunena-trash-manager','index.php?option=com_kunena&view=trash','component',0,479,2,10011,0,'0000-00-00',0,1,'components/com_kunena/media/icons/favicons/kunena-trash.png',0,'{}',382,383,0,'',1),
  (491,'kunenamenu','Foro','foro','','foro','index.php?option=com_kunena&view=home&defaultmenu=493','component',1,1,1,10011,0,'0000-00-00',0,1,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0,\"catids\":0}',385,402,0,'*',0),
  (492,'kunenamenu','Categorías','categorias','','foro/categorias','index.php?option=com_kunena&view=category&layout=list','component',1,491,2,10011,0,'0000-00-00',0,1,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',386,387,0,'*',0),
  (493,'kunenamenu','Mensajes Recientes','recientes','','foro/recientes','index.php?option=com_kunena&view=topics&mode=replies','component',1,491,2,10011,0,'0000-00-00',0,1,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0,\"topics_catselection\":\"\",\"topics_categories\":\"\",\"topics_time\":720}',388,389,0,'*',0),
  (494,'kunenamenu','Nuevo Tema','nuevo-tema','','foro/nuevo-tema','index.php?option=com_kunena&view=topic&layout=create','component',1,491,2,10011,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',390,391,0,'*',0),
  (495,'kunenamenu','Sin Respuesta','sin-respuestas','','foro/sin-respuestas','index.php?option=com_kunena&view=topics&mode=noreplies','component',1,491,2,10011,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0,\"topics_catselection\":\"\",\"topics_categories\":\"\",\"topics_time\":-1}',392,393,0,'*',0),
  (496,'kunenamenu','Mis Temas','mis-temas','','foro/mis-temas','index.php?option=com_kunena&view=topics&layout=user&mode=default','component',1,491,2,10011,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0,\"topics_catselection\":\"2\",\"topics_categories\":\"0\",\"topics_time\":-1}',394,395,0,'*',0),
  (497,'kunenamenu','Perfil','perfil','','foro/perfil','index.php?option=com_kunena&view=user','component',1,491,2,10011,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0,\"integration\":1}',396,397,0,'*',0),
  (498,'kunenamenu','Ayuda','ayuda','','foro/ayuda','index.php?option=com_kunena&view=misc','component',1,491,2,10011,0,'0000-00-00',0,3,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0,\"body\":\"Esta página de ayuda es un elemento de menú dentro del [b]Menú Kunena[\\/b], que permite una fácil navegación en su foro.\\n\\nUsted puede utilizar el Gestor de Menús de Joomla para editar los elementos en este menú. Por favor, vaya a [b]Administración[\\/b] >> [b]Menús[\\/b] >> [b]Menú Kunena[\\/b] >> [b]Ayuda[\\/b] para editar o eliminar este elemento del menú.\\n\\n En este elemento de menú puede utilizar texto sin formato, HTML o BBCode. Si desea enlazar un artículo a esta página, usted puede usar el artículo BBCode (con artículo id): [code][article=full]123[\\/article][\\/code]\\n\\n Si desea crear su propio menú para Kunena, por favor, empiece por crear el elemento [b]Inicio[\\/b] en primer lugar. En esa página se puede seleccionar un elemento de menú predeterminado, que será mostrado al ingresar a Kunena.\",\"body_format\":\"bbcode\"}',398,399,0,'*',0),
  (499,'kunenamenu','Buscar','buscar','','foro/buscar','index.php?option=com_kunena&view=search','component',1,491,2,10011,0,'0000-00-00',0,1,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',400,401,0,'*',0),
  (500,'mainmenu','Foro','kunena-2015-12-08','','kunena-2015-12-08','index.php?Itemid=491','alias',0,1,1,0,0,'0000-00-00',0,1,' ',0,'{\"aliasoptions\":\"491\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',403,404,0,'*',0),
  (501,'top','Ayuda','ayuda','','ayuda','#','url',1,1,1,0,0,'0000-00-00',2,22,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',405,412,0,'*',0),
  (502,'top','foro','forum','','ayuda/forum','index.php?option=com_kunena&view=home&defaultmenu=437','component',1,501,2,10011,0,'0000-00-00',0,2,' ',0,'{\"catids\":[\"0\"],\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',406,407,0,'*',0),
  (503,'top','Trazas','traza','','traza','index.php?option=com_traza&view=traza','component',1,1,1,10039,0,'0000-00-00',0,6,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',413,414,0,'*',0),
  (504,'top','programa','programa','','programa/programa','index.php?option=com_programa&view=programa','component',1,474,2,10029,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',218,219,0,'*',0),
  (505,'top','Jefe_Programa','jefeprograma','','programa/jefeprograma','#','url',-2,474,2,10020,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',214,215,0,'*',0),
  (506,'top','Secretario_Programa','secretario-programa','','programa/secretario-programa','#','url',-2,474,2,10021,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',216,217,0,'*',0),
  (507,'top','convocatoria','convocatoria','','programa/convocatoria','index.php?option=com_convocatoria&view=convocatoria','component',1,474,2,10030,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',220,221,0,'*',0),
  (508,'top','ayuda','ayuda','','ayuda/ayuda','index.php?option=com_ayuda&view=ayuda','component',1,501,2,10041,0,'0000-00-00',2,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',408,409,0,'*',0),
  (509,'top','marco regulatorio','marco-regulatorio','','ayuda/marco-regulatorio','index.php?option=com_marco_regulatorio&view=marco_regulatorio','component',1,501,2,10024,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',410,411,0,'*',0),
  (510,'top','persona','persona','','persona/persona','#','url',-2,514,2,10025,0,'0000-00-00',0,6,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',416,417,0,'*',0),
  (511,'top','entidad','entidad','','nomenclador/entidad','index.php?option=com_entidad&view=entidad','component',1,477,2,10026,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',334,335,0,'*',0),
  (512,'top','anno','anno','','nomenclador/anno','index.php?option=com_anno&view=anno','component',-2,477,2,10040,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',336,337,0,'*',0),
  (513,'top','provincia','provincia','','nomenclador/provincia','index.php?option=com_provincia&view=provincia','component',1,477,2,10027,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',338,339,0,'*',0),
  (514,'top','Roles','persona','','persona','index.php?option=com_persona&view=persona','component',1,1,1,10025,0,'0000-00-00',0,6,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',415,418,0,'*',0),
  (515,'top','entidad ejecutora','ejecutora','','proyecto/ejecutora','index.php?option=com_ejecutora&view=ejecutora','component',1,475,2,10031,0,'0000-00-00',0,12,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',252,253,0,'*',0),
  (516,'top','grado científico','grado-cientifico','','nomenclador/grado-cientifico','index.php?option=com_grado_cientifico&view=grado_cientifico','component',1,477,2,10038,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',340,341,0,'*',0),
  (517,'top','categoria científica','categoria-cientifica','','nomenclador/categoria-cientifica','index.php?option=com_cat_cientifica&view=cat_cientifica','component',1,477,2,10037,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',342,343,0,'*',0),
  (518,'top','perfil de proyecto','perfil-proyecto','','proyecto/perfil-proyecto','index.php?option=com_perfil_proyecto&view=perfil_proyecto','component',1,475,2,10036,0,'0000-00-00',0,12,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',254,255,0,'*',0),
  (519,'top','clasificación','clasificacion','','nomenclador/clasificacion','index.php?option=com_clasificacion&view=clasificacion','component',1,477,2,10035,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',344,345,0,'*',0),
  (520,'top','tipo de proyecto','tipo-proyecto','','nomenclador/tipo-proyecto','index.php?option=com_tipo_proyecto&view=tipo_proyecto','component',1,477,2,10034,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',346,347,0,'*',0),
  (521,'top','jefe de proyecto','jefeproyecto','','proyecto/jefeproyecto','index.php?option=com_jefeproyecto&view=jefeproyecto','component',1,475,2,10033,0,'0000-00-00',0,12,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',250,251,0,'*',0),
  (522,'top','dictámen evaluativo','dictamen-eval-perfil-proy','','proyecto/dictamen-eval-perfil-proy','index.php?option=com_dictamen_eval_perfil_proy&view=dictamen_eval_perfil_proy','component',1,475,2,10042,540,'2016-02-22 01:34:17',0,13,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',256,257,0,'*',0),
  (523,'top','contrato','contrato','','proyecto/contrato','index.php?option=com_contrato&view=contrato','component',1,475,2,10043,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',264,265,0,'*',0),
  (524,'top','forma entrega','forma-entrega','','nomenclador/forma-entrega','index.php?option=com_forma_entrega&view=forma_entrega','component',1,477,2,10046,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',350,351,0,'*',0),
  (525,'top','proyecto de innovación','innovacion','','proyecto/innovacion','index.php?option=com_innovacion&view=innovacion','component',1,475,2,10045,0,'0000-00-00',0,12,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',260,261,0,'*',0),
  (526,'top','proyecto de i+d','i-d','','proyecto/i-d','index.php?option=com_i_d&view=i_d','component',1,475,2,10044,0,'0000-00-00',0,12,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',258,259,0,'*',0),
  (527,'top','proyectos seleccionados','proyecto','','reportes/proyecto','index.php?option=com_proyecto&view=proyecto','component',1,531,2,10047,0,'0000-00-00',0,21,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',324,325,0,'*',0),
  (528,'top','evaluación','evaluacion','','nomenclador/evaluacion','index.php?option=com_evaluacion&view=evaluacion','component',1,477,2,10048,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',348,349,0,'*',0),
  (529,'top','Ejecución','ejecucion','','ejecucion','#','url',1,1,1,22,0,'0000-00-00',0,18,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',267,284,0,'*',0),
  (530,'top','Control','control','','control','#','url',1,1,1,22,0,'0000-00-00',0,19,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',285,298,0,'*',0),
  (531,'top','Reportes','reportes','','reportes','#','url',1,1,1,0,0,'0000-00-00',0,21,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1}',299,328,0,'*',0),
  (532,'top','financista','financista','','proyecto/financista','index.php?option=com_financista&view=financista','component',1,475,2,10051,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',262,263,0,'*',0),
  (533,'top','año','anyo','','nomenclador/anyo','index.php?option=com_anno&view=anno','component',-2,477,2,10040,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',352,353,0,'*',0),
  (534,'top','estado ejecución proyecto','estado-ejecucion-proyecto','','nomenclador/estado-ejecucion-proyecto','index.php?option=com_estado_ejecucion_proyecto&view=estado_ejecucion_proyecto','component',1,477,2,10058,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',354,355,0,'*',0),
  (535,'top','anticipo','anticipo','','ejecucion/anticipo','index.php?option=com_anticipo&view=anticipo','component',1,529,2,10049,0,'0000-00-00',0,13,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',268,269,0,'*',0),
  (536,'top','control ejecución del presupuesto','control-ejecucion-presupuesto','','ejecucion/control-ejecucion-presupuesto','index.php?option=com_control_ejecucion_presupuesto&view=control_ejecucion_presupuesto','component',1,529,2,10050,0,'0000-00-00',0,12,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',274,275,0,'*',0),
  (537,'top','informe de etapa','informe-etapa','','ejecucion/informe-etapa','index.php?option=com_informe_etapa&view=informe_etapa','component',1,529,2,10053,0,'0000-00-00',0,12,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',276,277,0,'*',0),
  (538,'top','informe ejecución del programa','informe-ejecucion-programa','','ejecucion/informe-ejecucion-programa','index.php?option=com_informe_ejecucion_programa&view=informe_ejecucion_programa','component',1,529,2,10052,0,'0000-00-00',0,13,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',282,283,0,'*',0),
  (539,'top','notificación ingreso y gastos','notificacion-ingreso-gastos','','ejecucion/notificacion-ingreso-gastos','index.php?option=com_notificacion_ingreso_gastos&view=notificacion_ingreso_gastos','component',1,529,2,10054,0,'0000-00-00',0,13,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',272,273,0,'*',0),
  (540,'top','oponencia informe etapa','oponencia-informe-etapa','','ejecucion/oponencia-informe-etapa','index.php?option=com_oponencia_informe_etapa&view=oponencia_informe_etapa','component',1,529,2,10055,0,'0000-00-00',0,13,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',278,279,0,'*',0),
  (541,'top','dictámen grupo experto','dictamen-grupo-expertos-inf-etapa','','ejecucion/dictamen-grupo-expertos-inf-etapa','index.php?option=com_dictamen_grupo_expertos_inf_etapa&view=dictamen_grupo_expertos_inf_etapa','component',1,529,2,10056,0,'0000-00-00',0,13,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',280,281,0,'*',0),
  (542,'top','certificación actividades y resultdos','certificacion-activdades-resultados','','ejecucion/certificacion-activdades-resultados','index.php?option=com_certificacion_activdades_resultados&view=certificacion_activdades_resultados','component',1,529,2,10057,0,'0000-00-00',0,12,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',270,271,0,'*',0),
  (543,'top','mes','mes','','nomenclador/mes','index.php?option=com_mes&view=mes','component',-2,477,2,10059,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',356,357,0,'*',0),
  (544,'top','control a programa y proyecto','control-programa-proyecto','','control/control-programa-proyecto','index.php?option=com_control_programa_proyecto&view=control_programa_proyecto','component',1,530,2,10060,0,'0000-00-00',0,19,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',286,287,0,'*',0),
  (545,'top','gestionadora','ejecutora','','programa/ejecutora','index.php?option=com_ejecutora&view=ejecutora','component',-2,474,2,10031,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',210,211,0,'*',0),
  (546,'top','financiero','financista','','programa/financista','index.php?option=com_financista&view=financista','component',-2,474,2,10051,0,'0000-00-00',0,2,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',212,213,0,'*',0),
  (547,'top','problemas detectados','problemas-detectados','','nomenclador/problemas-detectados','index.php?option=com_problemas_detectados&view=problemas_detectados','component',1,477,2,10061,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',358,359,0,'*',0),
  (548,'top','plan de auditoria','plan-auditoria','','control/plan-auditoria','index.php?option=com_plan_auditoria&view=plan_auditoria','component',1,530,2,10066,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',288,289,0,'*',0),
  (549,'top','programa auditoria','auditoria','','control/auditoria','index.php?option=com_auditoria&view=auditoria','component',1,530,2,10062,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',290,291,0,'*',0),
  (550,'top','lista chequeo','lista-chequeo-auditoria','','control/lista-chequeo-auditoria','index.php?option=com_lista_chequeo_auditoria&view=lista_chequeo_auditoria','component',1,530,2,10065,540,'2016-02-18 02:46:07',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',292,293,0,'*',0),
  (551,'top','evidencias objetivas','documentacion-evidencias-objetivas','','control/documentacion-evidencias-objetivas','index.php?option=com_documentacion_evidencias_objetivas&view=documentacion_evidencias_objetivas','component',1,530,2,10063,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',294,295,0,'*',0),
  (552,'top','informe auditoria','informe-auditoria','','control/informe-auditoria','index.php?option=com_informe_auditoria&view=informe_auditoria','component',1,530,2,10064,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',296,297,0,'*',0),
  (553,'top','convocatoria','rep-convocatoria','','reportes/rep-convocatoria','index.php?option=com_rep_convocatoria&view=rep_convocatoria','component',1,531,2,10067,0,'0000-00-00',2,21,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',300,301,0,'*',0),
  (554,'top','informe etapa proyecto','informe-etapa-proyecto','','reportes/informe-etapa-proyecto','index.php?option=com_informe_etapa_proyecto&view=informe_etapa_proyecto','component',1,531,2,10069,0,'0000-00-00',1,21,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',302,303,0,'*',0),
  (555,'top','anticipo a ejecutora','anticipo-ejecutora','','reportes/anticipo-ejecutora','index.php?option=com_anticipo_ejecutora&view=anticipo_ejecutora','component',1,531,2,10070,0,'0000-00-00',0,19,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',304,305,0,'*',0),
  (556,'top','actividades y resultados','certificacion','','reportes/certificacion','index.php?option=com_certificn_actvs_resultds&view=certificn_actvs_resultds','component',1,531,2,10071,0,'0000-00-00',0,21,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',306,307,0,'*',0),
  (557,'main','COM_CSOAP','com-csoap','','com-csoap','index.php?option=com_csoap','component',0,1,1,10072,0,'0000-00-00',0,1,'components/com_csoap/assets/images/icon-16-conflate-ext.png',0,'{}',419,420,0,'',1),
  (558,'top','flujo presupuesto proyecto','flujo-presupuesto','','reportes/flujo-presupuesto','index.php?option=com_flujo_presupuesto&view=flujo_presupuesto','component',1,531,2,10076,0,'0000-00-00',0,19,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',308,309,0,'*',0),
  (559,'top','Registros(Logs)','log','','log','index.php?option=com_logs&view=logs','component',1,1,1,10084,0,'0000-00-00',0,6,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',421,422,0,'*',0),
  (560,'top','informe ejecución programa','rep-informe-ejecucion-programa','','reportes/rep-informe-ejecucion-programa','index.php?option=com_rep_informe_ejecucion_programa&view=rep_informe_ejecucion_programa','component',1,531,2,10080,0,'0000-00-00',0,19,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',310,311,0,'*',0),
  (561,'top','dictámen grupo expertos','rep-dictmn-evl-gexp','','reportes/rep-dictmn-evl-gexp','index.php?option=com_rep_dictmn_evl_gexp&view=rep_dictmn_evl_gexp','component',1,531,2,10078,0,'0000-00-00',0,15,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',312,313,0,'*',0),
  (562,'top','auditoria','programa-auditoria','','reportes/programa-auditoria','index.php?option=com_programa_auditoria&view=programa_auditoria','component',1,531,2,10083,0,'0000-00-00',0,19,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',314,315,0,'*',0),
  (563,'top','financiamiento de programa y proyecto','financiamiento-programa-proyecto','','reportes/financiamiento-programa-proyecto','index.php?option=com_financiamiento_programa_proyecto&view=financiamiento_programa_proyecto','component',1,531,2,10077,0,'0000-00-00',0,19,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',316,317,0,'*',0),
  (564,'top','control presupuesto proyecto','control-presupuestal','','reportes/control-presupuestal','index.php?option=com_control_presupuestal&view=control_presupuestal','component',1,531,2,10082,0,'0000-00-00',0,19,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',318,319,0,'*',0),
  (565,'top','estado ejecución proyecto','estado-ejecucion-programa-proyecto','','reportes/estado-ejecucion-programa-proyecto','index.php?option=com_estado_ejecucion_programa_proyecto&view=estado_ejecucion_programa_proyecto','component',1,531,2,10081,0,'0000-00-00',0,21,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',320,321,0,'*',0),
  (566,'top','deficiencias proyectos','deficiencias-proyectos','','reportes/deficiencias-proyectos','index.php?option=com_deficiencias_proyectos&view=deficiencias_proyectos','component',1,531,2,10079,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',322,323,0,'*',0),
  (567,'top','informe auditoria','rep-informe-auditoria','','reportes/rep-informe-auditoria','index.php?option=com_rep_informe_auditoria&view=rep_informe_auditoria','component',1,531,2,10085,0,'0000-00-00',0,9,' ',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',326,327,0,'*',0);

COMMIT;

#
# Data for the `gir_menu_types` table  (LIMIT 0,500)
#

INSERT INTO `gir_menu_types` (`id`, `menutype`, `title`, `description`) VALUES 
  (2,'usermenu','User Menu','A Menu for logged-in Users'),
  (3,'top','Top','Links for major types of users'),
  (4,'aboutjoomla','About Joomla','All about Joomla!'),
  (6,'mainmenu','Main Menu','Simple Home Menu'),
  (7,'kunenamenu','Menú Kunena','Este es el menú predeterminado de Kunena. Es usado como el menú de navegación superior de Kunena. Se puede publicar en cualquier posición de módulo. Simplemente despublique los artículos que no sean necesarios.');

COMMIT;

#
# Data for the `gir_modules` table  (LIMIT 0,500)
#

INSERT INTO `gir_modules` (`id`, `asset_id`, `title`, `note`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `published`, `module`, `access`, `showtitle`, `params`, `client_id`, `language`) VALUES 
  (1,0,'Main Menu','','',1,'position-7',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_menu',1,1,'{\"menutype\":\"mainmenu\",\"startLevel\":\"0\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (2,0,'Login','','',1,'login',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_login',1,1,'',1,'*'),
  (3,0,'Popular Articles','','',3,'cpanel',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_popular',3,1,'{\"count\":\"5\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),
  (4,0,'Recently Added Articles','','',4,'cpanel',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_latest',3,1,'{\"count\":\"5\",\"ordering\":\"c_dsc\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),
  (8,0,'Toolbar','','',1,'toolbar',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_toolbar',3,1,'',1,'*'),
  (9,0,'Quick Icons','','',1,'icon',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_quickicon',3,1,'',1,'*'),
  (10,0,'Logged-in Users','','',2,'cpanel',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_logged',3,1,'{\"count\":\"5\",\"name\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),
  (12,0,'Admin Menu','','',1,'menu',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_menu',3,1,'{\"layout\":\"\",\"moduleclass_sfx\":\"\",\"shownew\":\"1\",\"showhelp\":\"1\",\"cache\":\"0\"}',1,'*'),
  (13,0,'Admin Submenu','','',1,'submenu',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_submenu',3,1,'',1,'*'),
  (14,0,'User Status','','',2,'status',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_status',3,1,'',1,'*'),
  (15,0,'Title','','',1,'title',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_title',3,1,'',1,'*'),
  (16,0,'Login Form','','',7,'position-7',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_login',1,1,'{\"greeting\":\"1\",\"name\":\"0\"}',0,'*'),
  (17,0,'Breadcrumbs','','',1,'position-2',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_breadcrumbs',1,1,'{\"moduleclass_sfx\":\"\",\"showHome\":\"1\",\"homeText\":\"\",\"showComponent\":\"1\",\"separator\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (18,0,'Book Store','','',1,'position-10',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_banners',1,0,'{\"target\":\"1\",\"count\":\"1\",\"cid\":\"3\",\"catid\":[\"\"],\"tag_search\":\"0\",\"ordering\":\"0\",\"header_text\":\"\",\"footer_text\":\"Books!\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),
  (19,0,'User Menu','','',3,'position-7',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_menu',2,1,'{\"menutype\":\"usermenu\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (20,0,'Top','','',1,'position-1',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_menu',1,1,'{\"menutype\":\"top\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\" nav-pills\",\"window_open\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\",\"module_tag\":\"div\",\"bootstrap_size\":\"0\",\"header_tag\":\"h3\",\"header_class\":\"\",\"style\":\"0\"}',0,'*'),
  (23,0,'About Joomla!','','',4,'position-7',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_menu',1,1,'{\"menutype\":\"aboutjoomla\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (25,0,'Site Map','','',1,'sitemapload',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_menu',1,0,'{\"menutype\":\"mainmenu\",\"startLevel\":\"2\",\"endLevel\":\"3\",\"showAllChildren\":\"1\",\"tag_id\":\"\",\"class_sfx\":\"sitemap\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (26,0,'This Site','','',5,'position-7',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_menu',1,1,'{\"menutype\":\"mainmenu\",\"startLevel\":\"1\",\"endLevel\":\"1\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (27,0,'Archived Articles','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_articles_archive',1,1,'{\"count\":\"10\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (28,0,'Latest News','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_articles_latest',1,1,'{\"catid\":[\"19\"],\"count\":\"5\",\"show_featured\":\"\",\"ordering\":\"c_dsc\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (29,0,'Articles Most Read','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_articles_popular',1,1,'{\"catid\":[\"26\",\"29\"],\"count\":\"5\",\"show_front\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (30,0,'Feed Display','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_feed',1,1,'{\"rssurl\":\"http:\\/\\/community.joomla.org\\/blogs\\/community.feed?type=rss\",\"rssrtl\":\"0\",\"rsstitle\":\"1\",\"rssdesc\":\"1\",\"rssimage\":\"1\",\"rssitems\":\"3\",\"rssitemdesc\":\"1\",\"word_count\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),
  (31,0,'News Flash','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_articles_news',1,1,'{\"catid\":[\"19\"],\"image\":\"0\",\"item_title\":\"0\",\"link_titles\":\"\",\"item_heading\":\"h4\",\"showLastSeparator\":\"1\",\"readmore\":\"1\",\"count\":\"1\",\"ordering\":\"a.publish_up\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (33,0,'Random Image','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_random_image',1,1,'{\"type\":\"jpg\",\"folder\":\"images\\/sampledata\\/parks\\/animals\",\"link\":\"\",\"width\":\"180\",\"height\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),
  (34,0,'Articles Related Items','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_related_items',1,1,'{\"showDate\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"owncache\":\"1\"}',0,'*'),
  (35,0,'Search','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_search',1,1,'{\"label\":\"\",\"width\":\"20\",\"text\":\"\",\"button\":\"\",\"button_pos\":\"right\",\"imagebutton\":\"\",\"button_text\":\"\",\"opensearch\":\"1\",\"opensearch_title\":\"\",\"set_itemid\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (36,0,'Statistics','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_stats',1,1,'{\"serverinfo\":\"1\",\"siteinfo\":\"1\",\"counter\":\"1\",\"increase\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (37,0,'Syndicate Feeds','','',1,'syndicateload',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_syndicate',1,1,'{\"text\":\"Feed Entries\",\"format\":\"rss\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),
  (38,0,'Users Latest','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_users_latest',1,1,'{\"shownumber\":\"5\",\"linknames\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (39,0,'Who''s Online','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_whosonline',1,1,'{\"showmode\":\"2\",\"linknames\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),
  (40,0,'Wrapper','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_wrapper',1,1,'{\"url\":\"http:\\/\\/www.youtube.com\\/embed\\/vb2eObvmvdI\",\"add\":\"1\",\"scrolling\":\"auto\",\"width\":\"640\",\"height\":\"390\",\"height_auto\":\"1\",\"target\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (41,0,'Footer','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_footer',1,1,'{\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (44,0,'Login','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_login',1,1,'{\"pretext\":\"\",\"posttext\":\"\",\"login\":\"280\",\"logout\":\"280\",\"greeting\":\"1\",\"name\":\"0\",\"usesecure\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),
  (45,0,'Menu Example','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_menu',1,1,'{\"menutype\":\"mainmenu\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (47,0,'Latest Park Blogs','','',6,'position-7',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_articles_latest',1,1,'{\"catid\":[\"27\"],\"count\":\"5\",\"show_featured\":\"\",\"ordering\":\"c_dsc\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\",\"module_tag\":\"div\",\"bootstrap_size\":\"0\",\"header_tag\":\"h3\",\"header_class\":\"\",\"style\":\"0\"}',0,'en-GB'),
  (48,0,'Custom HTML','','<p>This is a custom html module. That means you can enter whatever content you want.</p>',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_custom',1,1,'{\"prepare_content\":\"1\",\"backgroundimage\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (52,0,'Breadcrumbs','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_breadcrumbs',1,1,'{\"showHere\":\"1\",\"showHome\":\"1\",\"homeText\":\"Home\",\"showLast\":\"1\",\"separator\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (56,0,'Banners','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_banners',1,1,'{\"target\":\"1\",\"count\":\"1\",\"cid\":\"1\",\"catid\":[\"15\"],\"tag_search\":\"0\",\"ordering\":\"random\",\"header_text\":\"\",\"footer_text\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),
  (58,0,'Special!','','<h1>This week we have a special, half price on delicious oranges!</h1><div>Only for our special customers!</div><div>Use the code: Joomla! when ordering</div><p><em>This module can only be seen by people in the customers group or higher.</em></p>',1,'position-12',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_custom',4,1,'{\"prepare_content\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (61,0,'Articles Categories','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_articles_categories',1,1,'{\"parent\":\"29\",\"show_description\":\"0\",\"show_children\":\"0\",\"count\":\"0\",\"maxlevel\":\"0\",\"layout\":\"_:default\",\"item_heading\":\"4\",\"moduleclass_sfx\":\"\",\"owncache\":\"1\",\"cache_time\":\"900\"}',0,'*'),
  (62,0,'Language Switcher','','',3,'position-4',0,'0000-00-00','0000-00-00','0000-00-00',0,'mod_languages',1,1,'{\"header_text\":\"\",\"footer_text\":\"\",\"image\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (63,0,'Search','','',1,'position-0',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_search',1,1,'{\"width\":\"20\",\"text\":\"\",\"button\":\"\",\"button_pos\":\"right\",\"imagebutton\":\"1\",\"button_text\":\"\",\"set_itemid\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (64,0,'Language Switcher','','',1,'languageswitcherload',0,'0000-00-00','0000-00-00','0000-00-00',0,'mod_languages',1,1,'{\"header_text\":\"\",\"footer_text\":\"\",\"image\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (65,0,'About Fruit Shop','','<p>The Fruit Shop site shows a number of Joomla! features.</p><p>The template uses classes in cascading style sheets to change the layout of items, such as creating the horizontal alphabetical list in the Fruit Encyclopedia.</p><p> </p>',1,'position-4',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_custom',1,1,'{\"prepare_content\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),
  (67,0,'Extensions','','',2,'position-7',0,'0000-00-00','0000-00-00','0000-00-00',0,'mod_menu',1,1,'{\"menutype\":\"aboutjoomla\",\"startLevel\":\"1\",\"endLevel\":\"6\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"-menu\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),
  (68,0,'About Parks','','<p>The Parks sample site is designed as a simple site that can be routinely updated from the front end of Joomla!.</p><p>As a site, it is largely focused on a blog which can be updated using the front end article submission.</p><p>New weblinks can also be added through the front end.</p><p>A simple image gallery uses com_content with thumbnails displayed in a blog layout and full size images shown in article layout.</p>',2,'position-2',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_custom',1,1,'{\"prepare_content\":\"1\",\"backgroundimage\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\",\"module_tag\":\"div\",\"bootstrap_size\":\"0\",\"header_tag\":\"h3\",\"header_class\":\"\",\"style\":\"Protostar-well\"}',0,'*'),
  (69,0,'Articles Category','','',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_articles_category',1,1,'{\"mode\":\"normal\",\"show_on_article_page\":\"1\",\"show_front\":\"show\",\"count\":\"0\",\"category_filtering_type\":\"1\",\"catid\":[\"72\"],\"show_child_category_articles\":\"0\",\"levels\":\"1\",\"author_filtering_type\":\"1\",\"created_by\":[\"\"],\"author_alias_filtering_type\":\"1\",\"created_by_alias\":[\"\"],\"excluded_articles\":\"\",\"date_filtering\":\"off\",\"date_field\":\"a.created\",\"start_date_range\":\"\",\"end_date_range\":\"\",\"relative_date\":\"30\",\"article_ordering\":\"a.title\",\"article_ordering_direction\":\"ASC\",\"article_grouping\":\"none\",\"article_grouping_direction\":\"ksort\",\"month_year_format\":\"F Y\",\"item_heading\":\"4\",\"link_titles\":\"1\",\"show_date\":\"0\",\"show_date_field\":\"created\",\"show_date_format\":\"Y-m-d H:i:s\",\"show_category\":\"0\",\"show_hits\":\"0\",\"show_author\":\"0\",\"show_introtext\":\"0\",\"introtext_limit\":\"100\",\"show_readmore\":\"0\",\"show_readmore_title\":\"1\",\"readmore_limit\":\"15\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"owncache\":\"1\",\"cache_time\":\"900\"}',0,'*'),
  (77,0,'Shop','','',1,'position-11',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_banners',1,0,'{\"target\":\"1\",\"count\":\"1\",\"cid\":\"2\",\"catid\":[\"15\"],\"tag_search\":\"0\",\"ordering\":\"0\",\"header_text\":\"\",\"footer_text\":\"Shop!\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),
  (78,0,'Contribute','','',1,'position-9',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_banners',1,0,'{\"target\":\"1\",\"count\":\"1\",\"cid\":\"1\",\"catid\":[\"15\"],\"tag_search\":\"0\",\"ordering\":\"0\",\"header_text\":\"\",\"footer_text\":\"Contribute! \",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),
  (79,0,'Multilanguage status','','',1,'status',0,'0000-00-00','0000-00-00','0000-00-00',0,'mod_multilangstatus',3,1,'{\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),
  (84,0,'Smart Search Module','','',2,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_finder',1,1,'{\"searchfilter\":\"\",\"show_autosuggest\":\"1\",\"show_advanced\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"field_size\":20,\"alt_label\":\"\",\"show_label\":\"0\",\"label_pos\":\"top\",\"show_button\":\"0\",\"button_pos\":\"right\",\"opensearch\":\"1\",\"opensearch_title\":\"\"}',0,'*'),
  (86,0,'Joomla Version','','',1,'footer',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_version',3,1,'{\"format\":\"short\",\"product\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),
  (88,0,'Image Module','','<p><img src=\"images/headers/maple.jpg\" alt=\"\" /></p>',1,'position-3',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_custom',1,0,'{\"prepare_content\":\"1\",\"backgroundimage\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\",\"module_tag\":\"div\",\"bootstrap_size\":\"0\",\"header_tag\":\"h3\",\"header_class\":\"\",\"style\":\"0\"}',0,'*'),
  (89,0,'Custom HTML','','<p>In this module you can put whatever text or other content you would like.</p>',1,'',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_custom',1,1,'{\"prepare_content\":\"1\",\"backgroundimage\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\",\"module_tag\":\"div\",\"bootstrap_size\":\"0\",\"header_tag\":\"h3\",\"header_class\":\"\",\"style\":\"0\"}',0,'*'),
  (90,0,'Parks Image Module','','<p><img src=\"images/sampledata/parks/banner_cradle.jpg\" alt=\"\" /></p>',1,'position-3',0,'0000-00-00','0000-00-00','0000-00-00',1,'mod_custom',1,1,'{\"prepare_content\":\"1\",\"backgroundimage\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\",\"module_tag\":\"div\",\"bootstrap_size\":\"0\",\"header_tag\":\"h3\",\"header_class\":\"\",\"style\":\"0\"}',0,'*');

COMMIT;

#
# Data for the `gir_modules_menu` table  (LIMIT 0,500)
#

INSERT INTO `gir_modules_menu` (`moduleid`, `menuid`) VALUES 
  (1,101),
  (2,0),
  (3,0),
  (4,0),
  (6,0),
  (7,0),
  (8,0),
  (9,0),
  (10,0),
  (12,0),
  (13,0),
  (14,0),
  (15,0),
  (16,205),
  (16,435),
  (17,0),
  (18,0),
  (19,-463),
  (19,-462),
  (19,-433),
  (19,-432),
  (19,-431),
  (19,-430),
  (19,-429),
  (19,-427),
  (19,-400),
  (19,-399),
  (19,-296),
  (19,-244),
  (19,-243),
  (19,-242),
  (19,-234),
  (20,0),
  (22,234),
  (22,238),
  (22,242),
  (22,243),
  (22,244),
  (22,296),
  (22,399),
  (22,400),
  (23,-463),
  (23,-462),
  (23,-433),
  (23,-432),
  (23,-431),
  (23,-430),
  (23,-429),
  (23,-427),
  (23,-400),
  (23,-399),
  (23,-296),
  (23,-244),
  (23,-243),
  (23,-242),
  (23,-238),
  (23,-234),
  (25,294),
  (26,-463),
  (26,-462),
  (26,-433),
  (26,-432),
  (26,-431),
  (26,-430),
  (26,-429),
  (26,-427),
  (26,-400),
  (26,-399),
  (26,-296),
  (26,-244),
  (26,-243),
  (26,-242),
  (26,-238),
  (26,-234),
  (27,325),
  (28,310),
  (29,302),
  (30,410),
  (31,309),
  (32,309),
  (33,307),
  (34,326),
  (35,306),
  (36,304),
  (37,311),
  (38,300),
  (39,301),
  (40,313),
  (41,324),
  (44,312),
  (45,303),
  (47,234),
  (47,242),
  (47,243),
  (47,244),
  (47,296),
  (47,399),
  (47,400),
  (48,418),
  (52,416),
  (56,305),
  (57,238),
  (57,427),
  (57,429),
  (57,430),
  (57,431),
  (57,432),
  (57,433),
  (57,462),
  (57,463),
  (58,427),
  (58,429),
  (58,430),
  (58,431),
  (58,432),
  (58,433),
  (58,462),
  (58,463),
  (61,443),
  (62,231),
  (62,234),
  (62,242),
  (62,243),
  (62,244),
  (62,296),
  (62,399),
  (62,400),
  (63,0),
  (64,447),
  (65,427),
  (65,429),
  (65,430),
  (65,431),
  (65,432),
  (65,433),
  (65,462),
  (65,463),
  (68,243),
  (69,459),
  (77,0),
  (78,0),
  (79,0),
  (84,467),
  (86,0),
  (87,238),
  (87,427),
  (87,429),
  (87,430),
  (87,431),
  (87,432),
  (87,433),
  (87,462),
  (87,463),
  (88,-463),
  (88,-462),
  (88,-433),
  (88,-432),
  (88,-431),
  (88,-430),
  (88,-429),
  (88,-427),
  (88,-400),
  (88,-399),
  (88,-296),
  (88,-244),
  (88,-243),
  (88,-242),
  (88,-234),
  (89,-463),
  (89,-462),
  (89,-433),
  (89,-432),
  (89,-431),
  (89,-430),
  (89,-429),
  (89,-427),
  (89,-418),
  (89,-400),
  (89,-399),
  (89,-296),
  (89,-244),
  (89,-243),
  (89,-242),
  (89,-234),
  (90,234),
  (90,242),
  (90,243),
  (90,244),
  (90,296),
  (90,399),
  (90,400);

COMMIT;

#
# Data for the `gir_newsfeeds` table  (LIMIT 0,500)
#

INSERT INTO `gir_newsfeeds` (`catid`, `id`, `name`, `alias`, `link`, `published`, `numarticles`, `cache_time`, `checked_out`, `checked_out_time`, `ordering`, `rtl`, `access`, `language`, `params`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `metakey`, `metadesc`, `metadata`, `xreference`, `publish_up`, `publish_down`, `description`, `version`, `hits`, `images`) VALUES 
  (17,1,'Joomla! Announcements','joomla-announcements','http://feeds.joomla.org/JoomlaAnnouncements',1,5,3600,0,'0000-00-00',1,1,1,'en-GB','{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"newsfeed_layout\":\"\",\"feed_display_order\":\"\"}','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}','','0000-00-00','0000-00-00','',1,0,''),
  (17,2,'New Joomla! Extensions','new-joomla-extensions','http://feeds.joomla.org/JoomlaExtensions',1,5,3600,0,'0000-00-00',4,1,1,'en-GB','{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"newsfeed_layout\":\"\",\"feed_display_order\":\"\"}','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}','','0000-00-00','0000-00-00','',1,0,''),
  (17,3,'Joomla! Security News','joomla-security-news','http://feeds.joomla.org/JoomlaSecurityNews',1,5,3600,0,'0000-00-00',2,1,1,'en-GB','{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"newsfeed_layout\":\"\",\"feed_display_order\":\"\"}','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}','','0000-00-00','0000-00-00','',1,0,''),
  (17,4,'Joomla! Connect','joomla-connect','http://feeds.joomla.org/JoomlaConnect',1,5,3600,0,'0000-00-00',3,1,1,'en-GB','{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"newsfeed_layout\":\"\",\"feed_display_order\":\"\"}','2011-01-01 00:00:01',540,'Joomla','0000-00-00',0,'','','{\"robots\":\"\",\"rights\":\"\"}','','0000-00-00','0000-00-00','',1,0,'');

COMMIT;

#
# Data for the `gir_postinstall_messages` table  (LIMIT 0,500)
#

INSERT INTO `gir_postinstall_messages` (`postinstall_message_id`, `extension_id`, `title_key`, `description_key`, `action_key`, `language_extension`, `language_client_id`, `type`, `action_file`, `action`, `condition_file`, `condition_method`, `version_introduced`, `enabled`) VALUES 
  ('1',700,'PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_TITLE','PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_BODY','PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_ACTION','plg_twofactorauth_totp',1,'action','site://plugins/twofactorauth/totp/postinstall/actions.php','twofactorauth_postinstall_action','site://plugins/twofactorauth/totp/postinstall/actions.php','twofactorauth_postinstall_condition','3.2.0',1),
  ('2',700,'COM_CPANEL_WELCOME_BEGINNERS_TITLE','COM_CPANEL_WELCOME_BEGINNERS_MESSAGE','','com_cpanel',1,'message','','','','','3.2.0',0);

COMMIT;

#
# Data for the `gir_schemas` table  (LIMIT 0,500)
#

INSERT INTO `gir_schemas` (`extension_id`, `version_id`) VALUES 
  (700,'3.4.0-2015-02-26');

COMMIT;

#
# Data for the `gir_session` table  (LIMIT 0,500)
#

INSERT INTO `gir_session` (`session_id`, `client_id`, `guest`, `time`, `data`, `userid`, `username`) VALUES 
  ('lmj8pkv59md9p7c5eqrjej1mf3',0,0,'1456466160','__default|a:8:{s:15:\"session.counter\";i:5;s:19:\"session.timer.start\";i:1456466123;s:18:\"session.timer.last\";i:1456466149;s:17:\"session.timer.now\";i:1456466154;s:22:\"session.client.browser\";s:110:\"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36\";s:8:\"registry\";O:24:\"Joomla\\Registry\\Registry\":2:{s:7:\"\\0\\0\\0data\";O:8:\"stdClass\":1:{s:5:\"users\";O:8:\"stdClass\":1:{s:5:\"login\";O:8:\"stdClass\":1:{s:4:\"form\";O:8:\"stdClass\":2:{s:6:\"return\";s:47:\"index.php?option=com_content&view=article&id=71\";s:4:\"data\";a:0:{}}}}}s:9:\"separator\";s:1:\".\";}s:4:\"user\";O:5:\"JUser\":29:{s:9:\"\\0\\0\\0isRoot\";b:0;s:2:\"id\";s:3:\"545\";s:4:\"name\";s:28:\"Marta Aleida Rodriguez Perez\";s:8:\"username\";s:5:\"marta\";s:5:\"email\";s:16:\"marta@hec.sld.cu\";s:8:\"password\";s:60:\"$2y$10$fFc1fy1vN6wT5hljdQPEcOxNenmumMH8SoyrWjbRv42PyZhY8AOVy\";s:14:\"password_clear\";s:0:\"\";s:5:\"block\";s:1:\"0\";s:9:\"sendEmail\";s:1:\"0\";s:12:\"registerDate\";s:19:\"2016-01-01 18:44:43\";s:13:\"lastvisitDate\";s:19:\"2016-02-26 05:54:21\";s:10:\"activation\";s:0:\"\";s:6:\"params\";s:92:\"{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}\";s:6:\"groups\";a:1:{i:23;s:2:\"23\";}s:5:\"guest\";i:0;s:13:\"lastResetTime\";s:19:\"0000-00-00 00:00:00\";s:10:\"resetCount\";s:1:\"0\";s:12:\"requireReset\";s:1:\"0\";s:10:\"\\0\\0\\0_params\";O:24:\"Joomla\\Registry\\Registry\":2:{s:7:\"\\0\\0\\0data\";O:8:\"stdClass\":6:{s:11:\"admin_style\";s:0:\"\";s:14:\"admin_language\";s:0:\"\";s:8:\"language\";s:0:\"\";s:6:\"editor\";s:0:\"\";s:8:\"helpsite\";s:0:\"\";s:8:\"timezone\";s:0:\"\";}s:9:\"separator\";s:1:\".\";}s:14:\"\\0\\0\\0_authGroups\";a:3:{i:0;i:1;i:1;i:2;i:2;i:23;}s:14:\"\\0\\0\\0_authLevels\";a:11:{i:0;i:1;i:1;i:1;i:2;i:2;i:3;i:9;i:4;i:15;i:5;i:16;i:6;i:17;i:7;i:19;i:8;i:20;i:9;i:21;i:10;i:22;}s:15:\"\\0\\0\\0_authActions\";N;s:12:\"\\0\\0\\0_errorMsg\";N;s:13:\"\\0\\0\\0userHelper\";O:18:\"JUserWrapperHelper\":0:{}s:10:\"\\0\\0\\0_errors\";a:0:{}s:3:\"aid\";i:0;s:6:\"otpKey\";s:0:\"\";s:4:\"otep\";s:0:\"\";s:5:\"photo\";N;}s:13:\"session.token\";s:32:\"8914810e9e24a36d377208a747e19802\";}',545,'marta');

COMMIT;

#
# Data for the `gir_tags` table  (LIMIT 0,500)
#

INSERT INTO `gir_tags` (`id`, `parent_id`, `lft`, `rgt`, `level`, `path`, `title`, `alias`, `note`, `description`, `published`, `checked_out`, `checked_out_time`, `access`, `params`, `metadesc`, `metakey`, `metadata`, `created_user_id`, `created_time`, `created_by_alias`, `modified_user_id`, `modified_time`, `images`, `urls`, `hits`, `language`, `version`, `publish_up`, `publish_down`) VALUES 
  (1,0,0,1,0,'','ROOT','root','','',1,0,'0000-00-00',1,'','','','',540,'2011-01-01 00:00:01','',0,'0000-00-00','','',0,'*',1,'0000-00-00','0000-00-00');

COMMIT;

#
# Data for the `gir_template_styles` table  (LIMIT 0,500)
#

INSERT INTO `gir_template_styles` (`id`, `template`, `client_id`, `home`, `title`, `params`) VALUES 
  (4,'beez3',0,'0','Beez3 - Fruit Shop','{\"wrapperSmall\":53,\"wrapperLarge\":72,\"logo\":\"\",\"sitetitle\":\"Fruit Shop\",\"sitedescription\":\"The freshest fruit for you\",\"navposition\":\"left\",\"bootstrap\":\"\",\"templatecolor\":\"red\",\"headerImage\":\"\",\"backgroundcolor\":\"#eee\"}'),
  (5,'hathor',1,'0','Hathor - Default','{\"showSiteName\":\"0\",\"colourChoice\":\"\",\"boldText\":\"0\"}'),
  (7,'protostar',0,'0','protostar - Default','{\"templateColor\":\"\",\"logoFile\":\"\",\"googleFont\":\"1\",\"googleFontName\":\"Open+Sans\",\"fluidContainer\":\"0\"}'),
  (8,'isis',1,'1','isis - Default','{\"templateColor\":\"\",\"logoFile\":\"\"}'),
  (9,'beez3',0,'0','Beez3 - Default','{\"wrapperSmall\":53,\"wrapperLarge\":72,\"logo\":\"\",\"sitetitle\":\"Joomla!\",\"sitedescription\":\"Open Source Content Management\",\"navposition\":\"left\",\"bootstrap\":\"\",\"templatecolor\":\"personal\",\"headerImage\":\"\",\"backgroundcolor\":\"#eee\"}'),
  (10,'metrouibyernestobonet',0,'1','MetroUI by Ernesto Bonet - Default','{}');

COMMIT;

#
# Data for the `gir_ucm_history` table  (LIMIT 0,500)
#

INSERT INTO `gir_ucm_history` (`version_id`, `ucm_item_id`, `ucm_type_id`, `version_note`, `save_date`, `editor_user_id`, `character_count`, `sha1_hash`, `version_data`, `keep_forever`) VALUES 
  (1,79,5,'','2015-11-26 09:17:03',540,545,'418d96053fd483473ccd14e6708d3d947906718a','{\"id\":79,\"asset_id\":180,\"parent_id\":\"1\",\"lft\":\"133\",\"rgt\":134,\"level\":1,\"path\":null,\"extension\":\"com_content\",\"title\":\"mic\",\"alias\":\"mic\",\"note\":\"\",\"description\":\"\",\"published\":\"1\",\"checked_out\":null,\"checked_out_time\":null,\"access\":\"1\",\"params\":\"{\\\"category_layout\\\":\\\"\\\",\\\"image\\\":\\\"\\\",\\\"image_alt\\\":\\\"\\\"}\",\"metadesc\":\"\",\"metakey\":\"\",\"metadata\":\"{\\\"author\\\":\\\"\\\",\\\"robots\\\":\\\"\\\"}\",\"created_user_id\":540,\"created_time\":\"2015-11-26 09:17:03\",\"modified_user_id\":null,\"modified_time\":\"2015-11-26 09:17:03\",\"hits\":\"0\",\"language\":\"*\",\"version\":null}',0),
  (13,71,1,'','2016-01-25 02:19:47',540,2339,'7f5c5f7cd8f95654fc5d1778bcd8f6f4baae0ade','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-01-25 02:19:47\",\"modified_by\":\"540\",\"checked_out\":\"540\",\"checked_out_time\":\"2016-01-25 02:17:50\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"left\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":false,\\\"urlbtext\\\":\\\"\\\",\\\"targetb\\\":\\\"\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_tags\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"info_block_position\\\":\\\"1\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"urls_position\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":13,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"499\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0),
  (14,71,1,'','2016-01-25 02:21:03',540,2954,'49542ca9dddfe9efbb0c373c7b1d37f74455b668','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-01-25 02:21:03\",\"modified_by\":\"540\",\"checked_out\":\"540\",\"checked_out_time\":\"2016-01-25 02:19:47\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"left\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":false,\\\"urlbtext\\\":\\\"\\\",\\\"targetb\\\":\\\"\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_tags\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"info_block_position\\\":\\\"1\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"urls_position\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":14,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"500\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0),
  (15,71,1,'','2016-01-25 02:21:51',540,3598,'87e998b7dd09641e84c6c5d3dbc265e8a17f3e3e','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-01-25 02:21:51\",\"modified_by\":\"540\",\"checked_out\":\"540\",\"checked_out_time\":\"2016-01-25 02:21:03\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"left\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":\\\"\\\\\\/gestionando\\\\\\/www.mic.gov\\\",\\\"urlbtext\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"targetb\\\":\\\"\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_tags\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"info_block_position\\\":\\\"1\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"urls_position\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":15,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"501\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0),
  (16,71,1,'','2016-01-25 02:23:57',540,4172,'050ed827f9d6fd4ebc014b6ec5777c664453938c','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-01-25 02:23:57\",\"modified_by\":\"540\",\"checked_out\":\"540\",\"checked_out_time\":\"2016-01-25 02:22:16\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"left\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":\\\"\\\\\\/gestionando\\\\\\/www.mic.gov\\\",\\\"urlbtext\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional. Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"targetb\\\":\\\"2\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_tags\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"info_block_position\\\":\\\"1\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"urls_position\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":16,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"502\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0),
  (17,71,1,'','2016-01-25 02:24:53',540,3599,'2910fe442a801b353e27194f1f1d0a2d25308f92','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-01-25 02:24:53\",\"modified_by\":\"540\",\"checked_out\":\"540\",\"checked_out_time\":\"2016-01-25 02:23:57\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"left\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":\\\"\\\\\\/gestionando\\\\\\/www.mic.gov\\\",\\\"urlbtext\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"targetb\\\":\\\"2\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_tags\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"info_block_position\\\":\\\"1\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"urls_position\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":17,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"503\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0),
  (18,71,1,'','2016-02-08 00:14:13',540,4685,'66da394224e6fb380855498cd1857bf91e1b550e','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-02-08 00:14:13\",\"modified_by\":\"540\",\"checked_out\":\"540\",\"checked_out_time\":\"2016-02-08 00:13:41\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\uf0d8\\\\tTomar en cuenta las tendencias mundiales en la esfera de la organizaci\\u00f3n del desarrollo cient\\u00edfico y tecnol\\u00f3gico en una \\u00e9poca de creciente globalizaci\\u00f3n del mismo. \\uf0d8\\\\tSubrayar el papel de la empresa en los procesos de innovaci\\u00f3n tecnol\\u00f3gica, incluso como agente financiador de proyectos. \\uf0d8\\\\tSubrayar la b\\u00fasqueda de efectividad y competitividad de la misma y va contra el estereotipo de la empresa estatal ineficiente. \\uf0d8\\\\tTomar en cuenta la existencia de elementos de mercado en el sistema econ\\u00f3mico cubano. \\uf0d8\\\\tDenotar el reconocimiento de que la innovaci\\u00f3n tecnol\\u00f3gica tiene otras fuentes adem\\u00e1s de la I+D y, por tanto, m\\u00faltiples agentes. \\uf0d8\\\\tComportar un \\u00e9nfasis en el financiamiento por proyectos respecto al financiamiento institucional. \\uf0d8\\\\tReforzar el principio de evaluaci\\u00f3n integral ex-ante de los impactos de los proyectos. \\uf0d8\\\\tFormar parte de una estrategia de preservaci\\u00f3n del poder popular, necesario para continuar el proyecto socialista cubano.\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"right\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":\\\"\\\\\\/gestionando\\\\\\/www.mic.gov\\\",\\\"urlbtext\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"targetb\\\":\\\"2\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_tags\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"info_block_position\\\":\\\"1\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"urls_position\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":19,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"827\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0),
  (19,71,1,'','2016-02-22 13:07:25',540,4689,'dcde0465f55c791baf1ce5cde5bdecd2e7fc7d32','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-02-22 13:07:25\",\"modified_by\":\"540\",\"checked_out\":\"540\",\"checked_out_time\":\"2016-02-22 13:06:22\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\uf0d8\\\\tTomar en cuenta las tendencias mundiales en la esfera de la organizaci\\u00f3n del desarrollo cient\\u00edfico y tecnol\\u00f3gico en una \\u00e9poca de creciente globalizaci\\u00f3n del mismo. \\uf0d8\\\\tSubrayar el papel de la empresa en los procesos de innovaci\\u00f3n tecnol\\u00f3gica, incluso como agente financiador de proyectos. \\uf0d8\\\\tSubrayar la b\\u00fasqueda de efectividad y competitividad de la misma y va contra el estereotipo de la empresa estatal ineficiente. \\uf0d8\\\\tTomar en cuenta la existencia de elementos de mercado en el sistema econ\\u00f3mico cubano. \\uf0d8\\\\tDenotar el reconocimiento de que la innovaci\\u00f3n tecnol\\u00f3gica tiene otras fuentes adem\\u00e1s de la I+D y, por tanto, m\\u00faltiples agentes. \\uf0d8\\\\tComportar un \\u00e9nfasis en el financiamiento por proyectos respecto al financiamiento institucional. \\uf0d8\\\\tReforzar el principio de evaluaci\\u00f3n integral ex-ante de los impactos de los proyectos. \\uf0d8\\\\tFormar parte de una estrategia de preservaci\\u00f3n del poder popular, necesario para continuar el proyecto socialista cubano.\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"right\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":\\\"\\\\\\/gestionando\\\\\\/www.mic.gov\\\",\\\"urlbtext\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"targetb\\\":\\\"2\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_tags\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"info_block_position\\\":\\\"1\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"0\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"urls_position\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"0\\\",\\\"show_article_options\\\":\\\"0\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"0\\\"}\",\"version\":20,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"940\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0),
  (20,71,1,'','2016-02-22 13:23:15',540,4615,'bcd488f97698ae7573be4d000765eebdb8364b3c','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-02-22 13:23:15\",\"modified_by\":\"540\",\"checked_out\":\"540\",\"checked_out_time\":\"2016-02-22 13:07:25\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\uf0d8\\\\tTomar en cuenta las tendencias mundiales en la esfera de la organizaci\\u00f3n del desarrollo cient\\u00edfico y tecnol\\u00f3gico en una \\u00e9poca de creciente globalizaci\\u00f3n del mismo. \\uf0d8\\\\tSubrayar el papel de la empresa en los procesos de innovaci\\u00f3n tecnol\\u00f3gica, incluso como agente financiador de proyectos. \\uf0d8\\\\tSubrayar la b\\u00fasqueda de efectividad y competitividad de la misma y va contra el estereotipo de la empresa estatal ineficiente. \\uf0d8\\\\tTomar en cuenta la existencia de elementos de mercado en el sistema econ\\u00f3mico cubano. \\uf0d8\\\\tDenotar el reconocimiento de que la innovaci\\u00f3n tecnol\\u00f3gica tiene otras fuentes adem\\u00e1s de la I+D y, por tanto, m\\u00faltiples agentes. \\uf0d8\\\\tComportar un \\u00e9nfasis en el financiamiento por proyectos respecto al financiamiento institucional. \\uf0d8\\\\tReforzar el principio de evaluaci\\u00f3n integral ex-ante de los impactos de los proyectos. \\uf0d8\\\\tFormar parte de una estrategia de preservaci\\u00f3n del poder popular, necesario para continuar el proyecto socialista cubano.\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"right\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":\\\"\\\\\\/gestionando\\\\\\/www.mic.gov\\\",\\\"urlbtext\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"targetb\\\":\\\"2\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"0\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"0\\\",\\\"show_article_options\\\":\\\"0\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"0\\\"}\",\"version\":21,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"941\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0),
  (21,71,1,'','2016-02-22 13:26:59',540,4644,'f9b08de077b9011c5acf7525d6cd470ee9e4b974','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-02-22 13:26:59\",\"modified_by\":\"540\",\"checked_out\":\"540\",\"checked_out_time\":\"2016-02-22 13:26:40\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\uf0d8\\\\tTomar en cuenta las tendencias mundiales en la esfera de la organizaci\\u00f3n del desarrollo cient\\u00edfico y tecnol\\u00f3gico en una \\u00e9poca de creciente globalizaci\\u00f3n del mismo. \\uf0d8\\\\tSubrayar el papel de la empresa en los procesos de innovaci\\u00f3n tecnol\\u00f3gica, incluso como agente financiador de proyectos. \\uf0d8\\\\tSubrayar la b\\u00fasqueda de efectividad y competitividad de la misma y va contra el estereotipo de la empresa estatal ineficiente. \\uf0d8\\\\tTomar en cuenta la existencia de elementos de mercado en el sistema econ\\u00f3mico cubano. \\uf0d8\\\\tDenotar el reconocimiento de que la innovaci\\u00f3n tecnol\\u00f3gica tiene otras fuentes adem\\u00e1s de la I+D y, por tanto, m\\u00faltiples agentes. \\uf0d8\\\\tComportar un \\u00e9nfasis en el financiamiento por proyectos respecto al financiamiento institucional. \\uf0d8\\\\tReforzar el principio de evaluaci\\u00f3n integral ex-ante de los impactos de los proyectos. \\uf0d8\\\\tFormar parte de una estrategia de preservaci\\u00f3n del poder popular, necesario para continuar el proyecto socialista cubano.\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"right\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":\\\"http:\\\\\\/\\\\\\/www.mic.gov.cu\\\\\\/sitiomic\\\\\\/servlet\\\\\\/hhome\\\",\\\"urlbtext\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"targetb\\\":\\\"2\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"0\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"0\\\",\\\"show_article_options\\\":\\\"0\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"0\\\"}\",\"version\":22,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"941\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0),
  (22,71,1,'','2016-02-22 13:29:15',540,4641,'9974e01b538bf1e40135504be9f5ff98359c2ba3','{\"id\":71,\"asset_id\":\"181\",\"title\":\"MINCOM\",\"alias\":\"mincom\",\"introtext\":\"\",\"fulltext\":\"\",\"state\":1,\"catid\":\"14\",\"created\":\"2015-11-26 09:17:41\",\"created_by\":\"540\",\"created_by_alias\":\"\",\"modified\":\"2016-02-22 13:29:15\",\"modified_by\":\"540\",\"checked_out\":\"0\",\"checked_out_time\":\"0000-00-00 00:00:00\",\"publish_up\":\"2015-11-26 09:17:41\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"left\\\",\\\"image_intro_alt\\\":\\\"\\uf0d8\\\\tTomar en cuenta las tendencias mundiales en la esfera de la organizaci\\u00f3n del desarrollo cient\\u00edfico y tecnol\\u00f3gico en una \\u00e9poca de creciente globalizaci\\u00f3n del mismo. \\uf0d8\\\\tSubrayar el papel de la empresa en los procesos de innovaci\\u00f3n tecnol\\u00f3gica, incluso como agente financiador de proyectos. \\uf0d8\\\\tSubrayar la b\\u00fasqueda de efectividad y competitividad de la misma y va contra el estereotipo de la empresa estatal ineficiente. \\uf0d8\\\\tTomar en cuenta la existencia de elementos de mercado en el sistema econ\\u00f3mico cubano. \\uf0d8\\\\tDenotar el reconocimiento de que la innovaci\\u00f3n tecnol\\u00f3gica tiene otras fuentes adem\\u00e1s de la I+D y, por tanto, m\\u00faltiples agentes. \\uf0d8\\\\tComportar un \\u00e9nfasis en el financiamiento por proyectos respecto al financiamiento institucional. \\uf0d8\\\\tReforzar el principio de evaluaci\\u00f3n integral ex-ante de los impactos de los proyectos. \\uf0d8\\\\tFormar parte de una estrategia de preservaci\\u00f3n del poder popular, necesario para continuar el proyecto socialista cubano.\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"images\\\\\\/logo.jpg\\\",\\\"float_fulltext\\\":\\\"right\\\",\\\"image_fulltext_alt\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"image_fulltext_caption\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":\\\"http:\\\\\\/\\\\\\/www.mic.gov.cu\\\\\\/sitiomic\\\\\\/servlet\\\\\\/home\\\",\\\"urlbtext\\\":\\\"El Ministerio de la Inform\\u00e1tica y las Comunicaciones es el organismo encargado de proponer, y una vez aprobada, dirigir y controlar la pol\\u00edtica del Estado y el Gobierno para el Sistema \\u00danico de Comunicaciones del Pa\\u00eds, que comprende las telecomunicaciones, la inform\\u00e1tica, las radiocomunicaciones, los servicios postales, la autom\\u00e1tica para los sistemas de comunicaciones, la gesti\\u00f3n del espectro radioel\\u00e9ctrico y el aseguramiento t\\u00e9cnico y de soporte asociado, asegurando, desde tiempo de paz, la infraestructura y los servicios para la seguridad y la defensa nacional.\\\",\\\"targetb\\\":\\\"2\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"show_title\\\":\\\"0\\\",\\\"link_titles\\\":\\\"0\\\",\\\"show_intro\\\":\\\"0\\\",\\\"show_category\\\":\\\"0\\\",\\\"link_category\\\":\\\"0\\\",\\\"show_parent_category\\\":\\\"0\\\",\\\"link_parent_category\\\":\\\"0\\\",\\\"show_author\\\":\\\"0\\\",\\\"link_author\\\":\\\"0\\\",\\\"show_create_date\\\":\\\"0\\\",\\\"show_modify_date\\\":\\\"0\\\",\\\"show_publish_date\\\":\\\"0\\\",\\\"show_item_navigation\\\":\\\"0\\\",\\\"show_icons\\\":\\\"0\\\",\\\"show_print_icon\\\":\\\"0\\\",\\\"show_email_icon\\\":\\\"0\\\",\\\"show_vote\\\":\\\"0\\\",\\\"show_hits\\\":\\\"0\\\",\\\"show_noauth\\\":\\\"0\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_layout\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"0\\\",\\\"show_article_options\\\":\\\"0\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"0\\\"}\",\"version\":24,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"942\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\"}',0);

COMMIT;

#
# Data for the `gir_update_sites` table  (LIMIT 0,500)
#

INSERT INTO `gir_update_sites` (`update_site_id`, `name`, `type`, `location`, `enabled`, `last_check_timestamp`, `extra_query`) VALUES 
  (1,'Joomla! Core','collection','http://update.joomla.org/core/list.xml',1,1456147455,''),
  (2,'Joomla! Extension Directory','collection','http://update.joomla.org/jed/list.xml',1,1456147455,''),
  (3,'Accredited Joomla! Translations','collection','http://update.joomla.org/language/translationlist_3.xml',1,0,''),
  (4,'Joomla! Update Component Update Site','extension','http://update.joomla.org/core/extensions/com_joomlaupdate.xml',0,0,''),
  (5,'Kunena 3.0 Update Site','collection','http://update.kunena.org/3.0/list.xml',1,0,''),
  (6,'Conflate Extension Updates','collection','http://www.conflate.nl/extensions/updates/conflate.xml',0,0,'');

COMMIT;

#
# Data for the `gir_update_sites_extensions` table  (LIMIT 0,500)
#

INSERT INTO `gir_update_sites_extensions` (`update_site_id`, `extension_id`) VALUES 
  (1,700),
  (2,700),
  (3,600),
  (3,10002),
  (4,28),
  (5,10012),
  (6,10074);

COMMIT;

#
# Data for the `gir_user_usergroup_map` table  (LIMIT 0,500)
#

INSERT INTO `gir_user_usergroup_map` (`user_id`, `group_id`) VALUES 
  (540,7),
  (540,8),
  (541,22),
  (542,25),
  (543,17),
  (544,21),
  (545,23),
  (546,26);

COMMIT;

#
# Data for the `gir_usergroups` table  (LIMIT 0,500)
#

INSERT INTO `gir_usergroups` (`id`, `parent_id`, `lft`, `rgt`, `title`) VALUES 
  (1,0,1,34,'Public'),
  (2,1,8,31,'Registered'),
  (3,2,9,16,'Author'),
  (4,3,10,13,'Editor'),
  (5,4,11,12,'Publisher'),
  (6,1,4,7,'Manager'),
  (7,6,5,6,'Administrator'),
  (8,1,32,33,'Super Users'),
  (10,3,14,15,'Shop Suppliers (Example)'),
  (12,2,19,20,'Customer Group (Example)'),
  (13,1,2,3,'Guest'),
  (17,2,27,28,'Entidad Ejecutora'),
  (21,2,17,18,'Cliente'),
  (22,2,29,30,'Equipo Dirección'),
  (23,2,21,22,'DDTI'),
  (25,2,23,24,'Directivo_Entidad_Ejecutora'),
  (26,2,25,26,'Directivo_Entidad_Gestionadora');

COMMIT;

#
# Data for the `gir_users` table  (LIMIT 0,500)
#

INSERT INTO `gir_users` (`id`, `name`, `username`, `email`, `password`, `block`, `sendEmail`, `registerDate`, `lastvisitDate`, `activation`, `params`, `lastResetTime`, `resetCount`, `otpKey`, `otep`, `requireReset`, `photo`) VALUES 
  (540,'Ernesto','ernesto','bernestoalberto@gmail.com','$2y$10$hZekFNTk/WJ1rten0OyV6u/5WBVoaHSCI/dQd7DvBjQJiKDqLRP8y',0,1,'2015-11-26 08:45:11','2016-02-25 22:53:33','0','{\"admin_style\":\"\",\"admin_language\":\"es-ES\",\"language\":\"es-ES\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00',0,'','',0,NULL),
  (541,'gaby bonet moncada','gaby','gaby@hec.sld.cu','$2y$10$9HKlRQ9DoqlECK5PXlN8juTihwvK8D2xMxXmVZJK0llGD4oGNQcy6',0,0,'2015-12-09 07:01:58','2016-02-26 05:55:23','','{\"admin_style\":\"\",\"admin_language\":\"es-ES\",\"language\":\"es-ES\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00',0,'','',0,NULL),
  (542,'isabel ','isabel','isamon@infomed.sld.cu','$2y$10$tB7Coq5t3JKCUhlisPJEG.YgQDbOwE94LWZhC2m8.Xv8oJCO4KO3C',0,0,'2015-12-09 14:41:08','2016-01-21 05:57:35','','{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00',0,'','',0,NULL),
  (543,'ruperto ','ruperto','brupertopedro@yahoo.es','$2y$10$scIAHvCBoz.KcrZ2btNoLePKZ4TDM1HFF515ERcxyFR/ZRhmcMuU2',0,0,'2015-12-22 15:20:47','2016-02-26 05:20:44','','{\"admin_style\":\"\",\"admin_language\":\"es-ES\",\"language\":\"es-ES\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00',0,'','',0,NULL),
  (544,'carlos','carlos','carlos@ceis.cujae.educ.cu','$2y$10$iHdqdwgqh4MIgzMkQPd6y.hli1PlSUNdaORaa13NH203JfGEk8ZB2',0,1,'2015-12-22 16:54:07','2016-02-06 18:03:46','','{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00',0,'','',0,NULL),
  (545,'Marta Aleida Rodriguez Perez','marta','marta@hec.sld.cu','$2y$10$fFc1fy1vN6wT5hljdQPEcOxNenmumMH8SoyrWjbRv42PyZhY8AOVy',0,0,'2016-01-01 18:44:43','2016-02-26 05:55:37','','{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00',0,'','',0,NULL),
  (546,'abel alejandro yanez moncada','abelito','abel.yanez@etecsa.cu','$2y$10$wDgmyPIynyb8b68Zd.Ain.4DRQfhR1.H0.8kBxnk0hUUp0ogNG9Au',0,0,'2016-02-01 19:48:53','2016-02-02 00:20:01','','{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00',0,'','',0,NULL);

COMMIT;

#
# Data for the `gir_viewlevels` table  (LIMIT 0,500)
#

INSERT INTO `gir_viewlevels` (`id`, `title`, `ordering`, `rules`) VALUES 
  (1,'Public',0,'[1]'),
  (2,'Registered',2,'[6,2,8]'),
  (3,'Special',4,'[6,3,8]'),
  (4,'Customer Access Level (Example)',3,'[6,3,12]'),
  (5,'Guest',1,'[13]'),
  (6,'Super Users',5,'[8]'),
  (9,'DDTI',0,'[23]'),
  (12,'Entidad Ejecutora',0,'[17]'),
  (13,'Equipo Dirección',0,'[22]'),
  (15,'plus DEGYDDTI',0,'[23,26]'),
  (16,'Programa',0,'[23,22]'),
  (17,'Proyecto',0,'[23,17,22]'),
  (18,'Ejecucion',0,'[17,22]'),
  (19,'Control',0,'[23,22]'),
  (20,'Nomencladores',0,'[23]'),
  (21,'Reportes',0,'[21,23,25,26,22]'),
  (22,'Ayuda',0,'[21,23,25,26,17,22]');

COMMIT;

