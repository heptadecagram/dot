-- 
-- Project  Name: None
-- File / Folder: base-structure.sql
-- File Language: sql
-- Copyright (C): 2005 Richard Group, Inc.
-- First  Author: Liam Bryan
-- First Created: 2005.06.21 12:36:17
-- Last Modifier: Liam Bryan
-- Last Modified: 2005.06.21 15:43:41

CREATE TABLE user (
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(32) UNIQUE NOT NULL,
	real_name VARCHAR(128),
	password VARCHAR(32),
	email VARCHAR(128) UNIQUE NOT NULL
);

CREATE TABLE page (
	page_id SERIAL PRIMARY KEY,
	page_name VARCHAR(128),


);

CREATE TABLE revision (
	page_id INTEGER REFERENCES page(page_id) NOT NULL,
	revision_id SERIAL,
	"text" TEXT,
	changed_on TIMESTAMP WITH TIME ZONE,
	user_id INTEGER REFERENCES user(user_id) NOT NULL,
	PRIMARY KEY(page_id, revision_id)
);
