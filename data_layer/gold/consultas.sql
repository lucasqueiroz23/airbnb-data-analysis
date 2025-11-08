-- 1) Média de avaliações por mês
SELECT
    AVG(rev_mes) AS media_avaliacoes_por_mes
FROM
    dw.FATO_ANUNCIO AS fato_anuncio;


-- 2) Soma do número de avaliações
SELECT
    SUM(tot_rev) AS soma_total_avaliacoes
FROM
    dw.FATO_ANUNCIO AS fato_anuncio;


-- 3) Contagem de SUB REGIÕES POR BAIRRO
SELECT
    grp_bairro,
    COUNT(DISTINCT bairro) AS quantidade_bairros
FROM
    dw.dim_localizacao
WHERE
    grp_bairro IS NOT NULL
GROUP BY
    grp_bairro
ORDER BY
    quantidade_bairros DESC;


-- 4) Contagem de anfitriões
SELECT
    COUNT(DISTINCT SRK_anfi) AS quantidade_anfitrioes
FROM
    dw.DIM_ANFITRIAO AS dimensao_anfitriao;


-- 5) Total de últimas avaliações por ano
SELECT
    dimensao_ultima_avaliacao.ano AS ano,
    COUNT(fato_anuncio.SRK_fato_anuncio) AS total_ultimas_avaliacoes
FROM 
    dw.FATO_ANUNCIO AS fato_anuncio
JOIN 
    dw.DIM_ULTIMA_AVALIACAO AS dimensao_ultima_avaliacao 
    ON fato_anuncio.SRK_aval = dimensao_ultima_avaliacao.SRK_aval
WHERE dimensao_ultima_avaliacao.ano IS NOT NULL
GROUP BY dimensao_ultima_avaliacao.ano
ORDER BY dimensao_ultima_avaliacao.ano;


-- 6) Total de reservas/anúncios por grupo de bairro
SELECT
    dimensao_localizacao.grp_bairro AS grupo_bairro,
    COUNT(fato_anuncio.SRK_fato_anuncio) AS total_anuncios
FROM
    dw.FATO_ANUNCIO AS fato_anuncio
JOIN
    dw.DIM_LOCALIZACAO AS dimensao_localizacao 
    ON fato_anuncio.SRK_local = dimensao_localizacao.SRK_local
GROUP BY
    dimensao_localizacao.grp_bairro
ORDER BY
    total_anuncios DESC;


-- 7) Total de avaliações por mês
SELECT
    dimensao_ultima_avaliacao.mes AS mes,
    TO_CHAR(TO_DATE(dimensao_ultima_avaliacao.mes::text, 'MM'), 'Month') AS nome_mes,
    COUNT(fato_anuncio.SRK_fato_anuncio) AS total_ultimas_avaliacoes
FROM 
    dw.FATO_ANUNCIO AS fato_anuncio
JOIN 
    dw.DIM_ULTIMA_AVALIACAO AS dimensao_ultima_avaliacao 
    ON fato_anuncio.SRK_aval = dimensao_ultima_avaliacao.SRK_aval
WHERE dimensao_ultima_avaliacao.mes IS NOT NULL
GROUP BY dimensao_ultima_avaliacao.mes
ORDER BY dimensao_ultima_avaliacao.mes;


-- 8) Preço médio por bairro
SELECT
    dimensao_localizacao.bairro AS bairro,
    AVG(fato_anuncio.preco) AS media_preco
FROM
    dw.FATO_ANUNCIO AS fato_anuncio
JOIN
    dw.DIM_LOCALIZACAO AS dimensao_localizacao 
    ON fato_anuncio.SRK_local = dimensao_localizacao.SRK_local
GROUP BY
    dimensao_localizacao.bairro
ORDER BY
    media_preco DESC;


-- 9) Top 10 anfitriões por total de avaliações
SELECT
    dimensao_anfitriao.nm_anfi AS nome_anfitriao,
    SUM(fato_anuncio.tot_rev) AS total_avaliacoes_anfitriao
FROM
    dw.FATO_ANUNCIO AS fato_anuncio
JOIN
    dw.DIM_ANFITRIAO AS dimensao_anfitriao 
    ON fato_anuncio.SRK_anfi = dimensao_anfitriao.SRK_anfi
GROUP BY
    dimensao_anfitriao.nm_anfi
ORDER BY
    total_avaliacoes_anfitriao DESC;


-- 10) Preço médio por grupo de bairro e tipo de quarto
SELECT
    dimensao_localizacao.grp_bairro AS grupo_bairro,
    dimensao_propriedade.tipo_qto AS tipo_quarto,
    AVG(fato_anuncio.preco) AS media_preco
FROM
    dw.FATO_ANUNCIO AS fato_anuncio
JOIN
    dw.DIM_LOCALIZACAO AS dimensao_localizacao 
    ON fato_anuncio.SRK_local = dimensao_localizacao.SRK_local
JOIN
    dw.DIM_PROPRIEDADE AS dimensao_propriedade 
    ON fato_anuncio.SRK_prop = dimensao_propriedade.SRK_prop
GROUP BY
    dimensao_localizacao.grp_bairro,
    dimensao_propriedade.tipo_qto
ORDER BY
    dimensao_localizacao.grp_bairro,
    dimensao_propriedade.tipo_qto;


-- 11) Média de avaliações por mês por grupo de bairro e tipo de quarto
SELECT
    dimensao_localizacao.grp_bairro AS grupo_bairro,
    dimensao_propriedade.tipo_qto AS tipo_quarto,
    AVG(fato_anuncio.rev_mes) AS media_avaliacoes_por_mes
FROM
    dw.FATO_ANUNCIO AS fato_anuncio
JOIN
    dw.DIM_LOCALIZACAO AS dimensao_localizacao 
    ON fato_anuncio.SRK_local = dimensao_localizacao.SRK_local
JOIN
    dw.DIM_PROPRIEDADE AS dimensao_propriedade 
    ON fato_anuncio.SRK_prop = dimensao_propriedade.SRK_prop
GROUP BY
    dimensao_localizacao.grp_bairro,
    dimensao_propriedade.tipo_qto
ORDER BY
    dimensao_localizacao.grp_bairro,
    dimensao_propriedade.tipo_qto;
