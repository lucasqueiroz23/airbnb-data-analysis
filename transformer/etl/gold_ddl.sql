-- Conteúdo para salvar em gold_ddl.sql
CREATE SCHEMA IF NOT EXISTS gold;

DROP TABLE IF EXISTS gold.FATO_ANUNCIO;
DROP TABLE IF EXISTS gold.DIM_HOST;
DROP TABLE IF EXISTS gold.DIM_LOCALIZACAO;
DROP TABLE IF EXISTS gold.DIM_PROPRIEDADE;
DROP TABLE IF EXISTS gold.DIM_ULTIMA_AVALIACAO;

CREATE TABLE gold.DIM_HOST (
    id_host BIGINT PRIMARY KEY,
    host_name VARCHAR(255),
    host_identity_verified BOOLEAN,
    calculated_host_listings_count INTEGER
);

CREATE TABLE gold.DIM_LOCALIZACAO (
    id_localizacao BIGSERIAL PRIMARY KEY,
    lat NUMERIC(10, 7),
    long NUMERIC(10, 7),
    neighbourhood VARCHAR(255),
    neighbourhood_group VARCHAR(255)
);

CREATE TABLE gold.DIM_ULTIMA_AVALIACAO (
    id_avaliacao BIGSERIAL PRIMARY KEY,
    last_review DATE,
    ano INTEGER,
    mes INTEGER,
    trimestre INTEGER
);

CREATE TABLE gold.DIM_PROPRIEDADE (
    id_propriedade BIGSERIAL PRIMARY KEY,
    name TEXT,
    room_type VARCHAR(100),
    minimum_nights INTEGER,
    cancellation_policy VARCHAR(100),
    instant_bookable BOOLEAN,
    construction_year INTEGER,
    has_house_rules BOOLEAN
);

CREATE TABLE gold.FATO_ANUNCIO (
    id_fato BIGSERIAL PRIMARY KEY,
    availability_365 INTEGER,
    price NUMERIC(10, 2),
    service_fee NUMERIC(10, 2),
    number_of_reviews INTEGER,
    reviews_per_month NUMERIC(5, 2),
    review_rate_number NUMERIC(10, 2),
    FK_DIM_HOST_id_host BIGINT NOT NULL,
    FK_DIM_LOCALIZACAO_id_localizacao BIGINT NOT NULL,
    FK_DIM_ULTIMA_AVALIACAO_id_avaliacao BIGINT NOT NULL,
    FK_DIM_PROPRIEDADE_id_propriedade BIGINT NOT NULL
);
 
ALTER TABLE gold.FATO_ANUNCIO ADD CONSTRAINT FK_FATO_ANUNCIO_2
    FOREIGN KEY (FK_DIM_HOST_id_host)
    REFERENCES gold.DIM_HOST (id_host)
    ON DELETE RESTRICT;
 
ALTER TABLE gold.FATO_ANUNCIO ADD CONSTRAINT FK_FATO_ANUNCIO_3
    FOREIGN KEY (FK_DIM_LOCALIZACAO_id_localizacao)
    REFERENCES gold.DIM_LOCALIZACAO (id_localizacao)
    ON DELETE RESTRICT;
 
ALTER TABLE gold.FATO_ANUNCIO ADD CONSTRAINT FK_FATO_ANUNCIO_4
    FOREIGN KEY (FK_DIM_ULTIMA_AVALIACAO_id_avaliacao)
    REFERENCES gold.DIM_ULTIMA_AVALIACAO (id_avaliacao)
    ON DELETE RESTRICT;
 
ALTER TABLE gold.FATO_ANUNCIO ADD CONSTRAINT FK_FATO_ANUNCIO_5
    FOREIGN KEY (FK_DIM_PROPRIEDADE_id_propriedade)
    REFERENCES gold.DIM_PROPRIEDADE (id_propriedade)
    ON DELETE RESTRICT;

CREATE INDEX idx_fato_anuncio_fk_host ON gold.FATO_ANUNCIO(FK_DIM_HOST_id_host);
CREATE INDEX idx_fato_anuncio_fk_localizacao ON gold.FATO_ANUNCIO(FK_DIM_LOCALIZACAO_id_localizacao);
CREATE INDEX idx_fato_anuncio_fk_avaliacao ON gold.FATO_ANUNCIO(FK_DIM_ULTIMA_AVALIACAO_id_avaliacao);
CREATE INDEX idx_fato_anuncio_fk_propriedade ON gold.FATO_ANUNCIO(FK_DIM_PROPRIEDADE_id_propriedade);