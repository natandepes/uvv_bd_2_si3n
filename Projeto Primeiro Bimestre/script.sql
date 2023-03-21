use bank;

-- ------------------------------------------------------------------------------------------------------- --
-- 1) Escreva uma consulta que retorne o nome e sobrenome de todos os administradores (officer) com o nome --
-- da empresa que eles administram (business.name) e cidade onde ela está presente (customer.city).        --                                                    --
-- ------------------------------------------------------------------------------------------------------- --
SELECT 	ofc.fname AS First_Name
, 		ofc.lname AS Last_Name
, 		bi.name	  AS Business_Name
, 		cs.city   AS City
FROM officer 		ofc
INNER JOIN business bi ON (ofc.cust_id = bi.cust_id)
INNER JOIN customer cs ON (cs.cust_id = bi.cust_id);



-- -------------------------------------------------------------------------------------------------------- --
-- 2) Escreva uma consulta que retorne os nome dos clientes (nome das pessoas jurídicas ou nome + sobrenome --	
-- das pessoas físicas) que possuem uma conta em uma cidade diferente da cidade de estabelecimento          --                                                    --
-- -------------------------------------------------------------------------------------------------------- --
DESC customer;

SELECT 
	CASE
		WHEN cs.cust_type_cd = 'I' THEN CONCAT(ind.fname,'',ind.lname)
        WHEN cs.cust_type_cd = 'B' THEN bi.name						
	END AS Name
FROM customer 		  cs
INNER JOIN individual ind 	ON (cs.cust_id = ind.cust_id)
INNER JOIN business   bi    ON (cs.cust_id = bi.cust_id)                    -- AINDA NÃO FUNCIONANDO !!!!!!
INNER JOIN account 	  acc 	ON (cs.cust_id = acc.cust_id)
INNER JOIN branch	  bc  	ON (acc.open_branch_id = bc.branch_id)
WHERE cs.city != bc.city;