-- 
-- Project  Name: KB
-- File / Folder: t/sql/base-structure.sql
-- File Language: sql
-- Copyright (C): 2005 Richard Group, Inc.
-- First  Author: Liam Bryan
-- First Created: 2005.06.21 12:36:17
-- Last Modifier: Liam Bryan
-- Last Modified: 2005.07.13 14:57:20
--

\c kb
\c - kb

CREATE TABLE page (
	title VARCHAR(128),
	revision_id INTEGER NOT NULL,
	"text" TEXT,
	change_log VARCHAR(256),
	"when" TIMESTAMP WITH TIME ZONE,
	PRIMARY KEY(title, revision_id)
);
