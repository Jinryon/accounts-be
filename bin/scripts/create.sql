SET SCHEMA 'accounts_01';

DROP TABLE IF EXISTS t_det_details CASCADE;
DROP TABLE IF EXISTS t_ope_operations CASCADE;
DROP TABLE IF EXISTS t_acc_accounts CASCADE;
DROP TABLE IF EXISTS t_bud_budgets CASCADE;
DROP TABLE IF EXISTS t_usr_users CASCADE;
DROP TABLE IF EXISTS t_rmet_methods CASCADE;
DROP TABLE IF EXISTS t_rcat_categories CASCADE;
DROP EXTENSION IF EXISTS "uuid-ossp";


/*
 * Install extension for UUID
 */
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

/*
 * References tables
 * TODO Handle categories and methods by user
 */
CREATE TABLE IF NOT EXISTS t_rcat_categories(
  rcat_id SERIAL PRIMARY KEY,
  rcat_name VARCHAR(50) UNIQUE NOT NULL,
  rcat_comment TEXT
);


CREATE TABLE IF NOT EXISTS t_rmet_methods(
  rmet_id SERIAL PRIMARY KEY,
  rmet_name VARCHAR(20) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS t_usr_users(
  usr_uuid UUID PRIMARY KEY,
  usr_name VARCHAR(30) UNIQUE NOT NULL
);


/*
 * Configuration tables
 */
CREATE TABLE IF NOT EXISTS t_bud_budgets(
  bud_id SERIAL PRIMARY KEY,
  bud_name VARCHAR(50) UNIQUE NOT NULL,
  usr_uuid UUID NOT NULL
);
ALTER TABLE t_bud_budgets ADD CONSTRAINT bud_fk_usr FOREIGN KEY (usr_uuid) REFERENCES t_usr_users(usr_uuid);


CREATE TABLE IF NOT EXISTS t_acc_accounts(
  acc_uuid UUID PRIMARY KEY,
  acc_name VARCHAR(30) UNIQUE NOT NULL,
  usr_uuid UUID NOT NULL ,
  acc_initial_amount NUMERIC(2) NOT NULL
);
ALTER TABLE t_acc_accounts ADD CONSTRAINT acc_fk_usr FOREIGN KEY (usr_uuid) REFERENCES t_usr_users(usr_uuid);


/*
 * Operations tables
 */
 CREATE TABLE IF NOT EXISTS t_ope_operations(
  ope_uuid UUID PRIMARY KEY
);


CREATE TABLE IF NOT EXISTS t_det_details(
  det_uuid UUID PRIMARY KEY,
  ope_uuid UUID NOT NULL,
  det_date DATE NOT NULL,
  rcat_id INTEGER NOT NULL,
  det_amount NUMERIC(2) NOT NULL,
  det_comment TEXT,
  rmet_id INTEGER NOT NULL,
  acc_uuid UUID NOT NULL,
  det_pointed CHAR(1) NOT NULL,
  det_refunded CHAR(1) NOT NULL
);
ALTER TABLE t_det_details ADD CONSTRAINT det_fk_ope FOREIGN KEY (ope_uuid) REFERENCES t_ope_operations(ope_uuid);
ALTER TABLE t_det_details ADD CONSTRAINT det_fk_rcat FOREIGN KEY (rcat_id) REFERENCES t_rcat_categories(rcat_id);
ALTER TABLE t_det_details ADD CONSTRAINT det_fk_rmet FOREIGN KEY (rmet_id) REFERENCES t_rmet_methods(rmet_id);
ALTER TABLE t_det_details ADD CONSTRAINT det_fk_acc FOREIGN KEY (acc_uuid) REFERENCES t_acc_accounts(acc_uuid);
ALTER TABLE t_det_details ADD CONSTRAINT det_chk_pointed CHECK (det_pointed IN ('Y', 'N', '?'));
ALTER TABLE t_det_details ADD CONSTRAINT det_chk_refunded CHECK (det_pointed IN ('Y', 'N', '-', '?'));




/*
 * Init data
 */
INSERT INTO t_usr_users(usr_uuid, usr_name) VALUES
  (uuid_generate_v1(), 'Thomas'),
  (uuid_generate_v1(), 'Marie');
INSERT INTO t_rmet_methods(rmet_id, rmet_name) VALUES
  (1, 'Carte'),
  (2, 'Chèque');
INSERT INTO t_rcat_categories(rcat_id, rcat_name, rcat_comment) VALUES
  (1, 'Cat1', null),
  (2, 'Cat2', null);

INSERT INTO t_acc_accounts(acc_uuid, acc_name, usr_uuid, acc_initial_amount) VALUES
 (uuid_generate_v1(), 'Compte courant joint', (SELECT usr_uuid FROM t_usr_users WHERE usr_name = 'Thomas'), 0),
 (uuid_generate_v1(), 'Compte courant', (SELECT usr_uuid FROM t_usr_users WHERE usr_name = 'Marie'), 0);