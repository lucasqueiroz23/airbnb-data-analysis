-- 1) Média de avaliações por mês
SELECT
    AVG(qtd_ava_mes) AS media_avaliacoes_por_mes
FROM
    dw.fat_anu AS fato_anuncio;


-- 2) Soma do número de avaliações
SELECT
    SUM(qtd_tot_ava) AS soma_total_avaliacoes
FROM
    dw.fat_anu AS fato_anuncio;


-- 3) Contagem de SUB REGIÕES POR BAIRRO
SELECT
    grp_bai,
    COUNT(DISTINCT nom_bai) AS quantidade_bairros
FROM
    dw.dim_loc
WHERE
    grp_bai IS NOT NULL
GROUP BY
    grp_bai
ORDER BY
    quantidade_bairros DESC;


-- 4) Contagem de anfitriões
SELECT
    COUNT(DISTINCT srk_anf) AS quantidade_anfitrioes
FROM
    dw.dim_anf AS dimensao_anfitriao;


-- 5) Total de últimas avaliações por ano
SELECT
    dimensao_ultima_avaliacao.num_ano AS ano,
    COUNT(fato_anuncio.srk_fat) AS total_ultimas_avaliacoes
FROM 
    dw.fat_anu AS fato_anuncio
JOIN 
    dw.dim_ult_ava AS dimensao_ultima_avaliacao 
    ON fato_anuncio.srk_ava = dimensao_ultima_avaliacao.srk_ava
WHERE dimensao_ultima_avaliacao.num_ano IS NOT NULL
GROUP BY dimensao_ultima_avaliacao.num_ano
ORDER BY dimensao_ultima_avaliacao.num_ano;


-- 6) Total de reservas/anúncios por grupo de bairro
SELECT
    dimensao_localizacao.grp_bai AS grupo_bairro,
    COUNT(fato_anuncio.srk_fat) AS total_anuncios
FROM
    dw.fat_anu AS fato_anuncio
JOIN
    dw.dim_loc AS dimensao_localizacao 
    ON fato_anuncio.srk_loc = dimensao_localizacao.srk_loc
GROUP BY
    dimensao_localizacao.grp_bai
ORDER BY
    total_anuncios DESC;


-- 7) Total de avaliações por mês
SELECT
    dimensao_ultima_avaliacao.num_mes AS mes,
    TO_CHAR(TO_DATE(dimensao_ultima_avaliacao.num_mes::text, 'MM'), 'Month') AS nome_mes,
    COUNT(fato_anuncio.srk_fat) AS total_ultimas_avaliacoes
FROM 
    dw.fat_anu AS fato_anuncio
JOIN 
    dw.dim_ult_ava AS dimensao_ultima_avaliacao 
    ON fato_anuncio.srk_ava = dimensao_ultima_avaliacao.srk_ava
WHERE dimensao_ultima_avaliacao.num_mes IS NOT NULL
GROUP BY dimensao_ultima_avaliacao.num_mes
ORDER BY dimensao_ultima_avaliacao.num_mes;


-- 8) Preço médio por bairro
SELECT
    dimensao_localizacao.nom_bai AS bairro,
    AVG(fato_anuncio.val_pre) AS media_preco
FROM
    dw.fat_anu AS fato_anuncio
JOIN
    dw.dim_loc AS dimensao_localizacao 
    ON fato_anuncio.srk_loc = dimensao_localizacao.srk_loc
GROUP BY
    dimensao_localizacao.nom_bai
ORDER BY
    media_preco DESC;


-- 9) Top anfitriões por total de avaliações
SELECT
    dimensao_anfitriao.nom_anf AS nome_anfitriao,
    SUM(fato_anuncio.qtd_tot_ava) AS total_avaliacoes_anfitriao
FROM
    dw.fat_anu AS fato_anuncio
JOIN
    dw.dim_anf AS dimensao_anfitriao 
    ON fato_anuncio.srk_anf = dimensao_anfitriao.srk_anf
GROUP BY
    dimensao_anfitriao.nom_anf
ORDER BY
    total_avaliacoes_anfitriao DESC;


-- 10) Preço médio por grupo de bairro e tipo de quarto
SELECT
    dimensao_localizacao.grp_bai AS grupo_bairro,
    dimensao_propriedade.tip_qto AS tipo_quarto,
    AVG(fato_anuncio.val_pre) AS media_preco
FROM
    dw.fat_anu AS fato_anuncio
JOIN
    dw.dim_loc AS dimensao_localizacao 
    ON fato_anuncio.srk_loc = dimensao_localizacao.srk_loc
JOIN
    dw.dim_pro AS dimensao_propriedade 
    ON fato_anuncio.srk_pro = dimensao_propriedade.srk_pro
GROUP BY
    dimensao_localizacao.grp_bai,
    dimensao_propriedade.tip_qto
ORDER BY
    dimensao_localizacao.grp_bai,
    dimensao_propriedade.tip_qto;


-- 11) Média de avaliações por mês por grupo de bairro e tipo de quarto
SELECT
    dimensao_localizacao.grp_bai AS grupo_bairro,
    dimensao_propriedade.tip_qto AS tipo_quarto,
    AVG(fato_anuncio.qtd_ava_mes) AS media_avaliacoes_por_mes
FROM
    dw.fat_anu AS fato_anuncio
JOIN
    dw.dim_loc AS dimensao_localizacao 
    ON fato_anuncio.srk_loc = dimensao_localizacao.srk_loc
JOIN
    dw.dim_pro AS dimensao_propriedade 
    ON fato_anuncio.srk_pro = dimensao_propriedade.srk_pro
GROUP BY
    dimensao_localizacao.grp_bai,
    dimensao_propriedade.tip_qto
ORDER BY
    dimensao_localizacao.grp_bai,
    dimensao_propriedade.tip_qto;
