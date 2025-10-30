
-- 1) Média de avaliações por mês
SELECT
    AVG(rev_mes) AS average_reviews_per_month
FROM
    gold.FATO_ANUNCIO;


-- 2) Soma do número de avaliações
SELECT
    SUM(tot_rev) AS sum_of_reviews
FROM
    gold.FATO_ANUNCIO;


-- 3) Contagem de bairros
SELECT
    COUNT(DISTINCT bairro) AS count_of_neighbourhood
FROM
    gold.DIM_LOCALIZACAO;


-- 4) Contagem de anfitriões
SELECT
    COUNT(DISTINCT SRK_anfi) AS count_of_hosts
FROM
    gold.DIM_ANFITRIAO;


-- 5) Total de últimas avaliações por ano
SELECT
    ano,
    COUNT(SRK_aval) AS total_ultimas_avaliacoes
FROM
    gold.DIM_ULTIMA_AVALIACAO
GROUP BY
    ano
ORDER BY
    ano ASC;


-- 6) Total de reservas/anúncios por grupo de bairro
SELECT
    T_LOCAL.grp_bairro,
    COUNT(T_FATO.SRK_fato_anuncio) AS total_anuncios
FROM
    gold.FATO_ANUNCIO AS T_FATO
JOIN
    gold.DIM_LOCALIZACAO AS T_LOCAL ON T_FATO.SRK_local = T_LOCAL.SRK_local
GROUP BY
    T_LOCAL.grp_bairro
ORDER BY
    total_anuncios DESC;


-- 7)Total de avaliações por mês
SELECT
    mes,
    -- Para formatar o nome do mês (Opcional, pode ser feito no BI):
    TO_CHAR(TO_DATE(mes::text, 'MM'), 'Month') AS nome_mes,
    COUNT(SRK_aval) AS total_ultimas_avaliacoes
FROM
    gold.DIM_ULTIMA_AVALIACAO
GROUP BY
    mes
ORDER BY
    mes ASC;


-- 8) Preço médio por bairro
SELECT
    T_LOCAL.bairro,
    AVG(T_FATO.preco) AS media_preco
FROM
    gold.FATO_ANUNCIO AS T_FATO
JOIN
    gold.DIM_LOCALIZACAO AS T_LOCAL ON T_FATO.SRK_local = T_LOCAL.SRK_local
GROUP BY
    T_LOCAL.bairro
ORDER BY
    media_preco DESC
LIMIT 5;


-- 9) Top 10 anfitriões por total de avaliações
SELECT
    T_ANFI.nm_anfi,
    SUM(T_FATO.tot_rev) AS total_reviews_do_host
FROM
    gold.FATO_ANUNCIO AS T_FATO
JOIN
    gold.DIM_ANFITRIAO AS T_ANFI ON T_FATO.SRK_anfi = T_ANFI.SRK_anfi
GROUP BY
    T_ANFI.nm_anfi
ORDER BY
    total_reviews_do_host DESC
LIMIT 10;


-- 10) Preço médio por grupo de bairro e tipo de quarto
SELECT
    T_LOCAL.grp_bairro,
    T_PROP.tipo_qto,
    AVG(T_FATO.preco) AS media_preco
FROM
    gold.FATO_ANUNCIO AS T_FATO
JOIN
    gold.DIM_LOCALIZACAO AS T_LOCAL ON T_FATO.SRK_local = T_LOCAL.SRK_local
JOIN
    gold.DIM_PROPRIEDADE AS T_PROP ON T_FATO.SRK_prop = T_PROP.SRK_prop
GROUP BY
    T_LOCAL.grp_bairro,
    T_PROP.tipo_qto
ORDER BY
    T_LOCAL.grp_bairro,
    T_PROP.tipo_qto;

-- 11)Média de avaliações por mês por grupo de bairro e tipo de quarto
SELECT
    T_LOCAL.grp_bairro,
    T_PROP.tipo_qto,
    AVG(T_FATO.rev_mes) AS media_reviews_mes
FROM
    gold.FATO_ANUNCIO AS T_FATO
JOIN
    gold.DIM_LOCALIZACAO AS T_LOCAL ON T_FATO.SRK_local = T_LOCAL.SRK_local
JOIN
    gold.DIM_PROPRIEDADE AS T_PROP ON T_FATO.SRK_prop = T_PROP.SRK_prop
GROUP BY
    T_LOCAL.grp_bairro,
    T_PROP.tipo_qto
ORDER BY
    T_LOCAL.grp_bairro,
    T_PROP.tipo_qto;