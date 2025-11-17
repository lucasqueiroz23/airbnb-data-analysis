CREATE SCHEMA IF NOT EXISTS dw;

DROP TABLE IF EXISTS dw.fat_anu;
DROP TABLE IF EXISTS dw.dim_anf;
DROP TABLE IF EXISTS dw.dim_loc;
DROP TABLE IF EXISTS dw.dim_pro;
DROP TABLE IF EXISTS dw.dim_ult_ava;

CREATE TABLE dw.dim_anf (
    srk_anf BIGSERIAL PRIMARY KEY,
    nom_anf VARCHAR(255),
    ind_ver_anf BOOLEAN,
    qtd_anu_anf INTEGER
);

CREATE TABLE dw.dim_loc (
    srk_loc BIGSERIAL PRIMARY KEY,
    num_lat NUMERIC(10, 7),
    num_lon NUMERIC(10, 7),
    nom_bai VARCHAR(255),
    grp_bai VARCHAR(255)
);

CREATE TABLE dw.dim_ult_ava (
    srk_ava BIGSERIAL PRIMARY KEY,
    dat_ava DATE,
    num_ano INTEGER,
    num_mes INTEGER,
    num_tri INTEGER
);

CREATE TABLE dw.dim_pro (
    srk_pro BIGSERIAL PRIMARY KEY,
    nom_anu TEXT,
    tip_qto VARCHAR(100),
    qtd_min_noi INTEGER,
    des_pol_can VARCHAR(100),
    ind_res_ins BOOLEAN,
    ano_con INTEGER,
    ind_tem_reg BOOLEAN
);

CREATE TABLE dw.fat_anu (
    srk_fat BIGSERIAL PRIMARY KEY,
    srk_anf BIGINT NOT NULL,
    srk_loc BIGINT NOT NULL,
    srk_ava BIGINT NOT NULL,
    srk_pro BIGINT NOT NULL,

    qtd_dia_dis INTEGER,
    val_pre NUMERIC(10, 2),
    val_tax_ser NUMERIC(10, 2),
    qtd_tot_ava INTEGER,
    qtd_ava_mes NUMERIC(5, 2),
    val_not_ava NUMERIC(10, 2)
);
 
ALTER TABLE dw.fat_anu ADD CONSTRAINT srk_fat_anu_anf
    FOREIGN KEY (srk_anf)
    REFERENCES dw.dim_anf (srk_anf)
    ON DELETE RESTRICT;
 
ALTER TABLE dw.fat_anu ADD CONSTRAINT srk_fat_anu_loc
    FOREIGN KEY (srk_loc)
    REFERENCES dw.dim_loc (srk_loc)
    ON DELETE RESTRICT;
 
ALTER TABLE dw.fat_anu ADD CONSTRAINT srk_fat_anu_ava
    FOREIGN KEY (srk_ava)
    REFERENCES dw.dim_ult_ava (srk_ava)
    ON DELETE RESTRICT;
 
ALTER TABLE dw.fat_anu ADD CONSTRAINT srk_fat_anu_pro
    FOREIGN KEY (srk_pro)
    REFERENCES dw.dim_pro (srk_pro)
    ON DELETE RESTRICT;

ALTER TABLE dw.fat_anu ADD CONSTRAINT chk_fat_qtd_ava_mes_not_nan CHECK (qtd_ava_mes IS NULL OR qtd_ava_mes::text !~* '^(nan|inf|-inf)$');
ALTER TABLE dw.fat_anu ADD CONSTRAINT chk_fat_val_pre_not_nan   CHECK (val_pre IS NULL OR val_pre::text !~* '^(nan|inf|-inf)$');
ALTER TABLE dw.fat_anu ADD CONSTRAINT chk_fat_val_tax_ser_not_nan  CHECK (val_tax_ser IS NULL OR val_tax_ser::text !~* '^(nan|inf|-inf)$');
ALTER TABLE dw.fat_anu ADD CONSTRAINT chk_fat_qtd_tot_ava_not_nan  CHECK (qtd_tot_ava IS NULL OR qtd_tot_ava::text !~* '^(nan|inf|-inf)$');
ALTER TABLE dw.fat_anu ADD CONSTRAINT chk_fat_val_not_ava_not_nan CHECK (val_not_ava IS NULL OR val_not_ava::text !~* '^(nan|inf|-inf)$');

CREATE INDEX idx_fat_fk_anf ON dw.fat_anu(srk_anf);
CREATE INDEX idx_fat_fk_loc ON dw.fat_anu(srk_loc);
CREATE INDEX idx_fat_fk_ava ON dw.fat_anu(srk_ava);
CREATE INDEX idx_fat_fk_pro ON dw.fat_anu(srk_pro);
