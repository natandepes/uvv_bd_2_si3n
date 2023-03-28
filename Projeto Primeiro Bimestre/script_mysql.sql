USE bank;

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

SELECT DISTINCT 
     'FIS' Type
,    CONCAT(ind.fname,' ', ind.lname) AS Clients
FROM individual     ind
INNER JOIN customer cs  ON (cs.cust_id = ind.cust_id)
INNER JOIN account  acc ON (acc.cust_id = cs.cust_id)
INNER JOIN branch   bc  ON (bc.branch_id = acc.open_branch_id)
WHERE cs.city != bc.city
UNION
SELECT DISTINCT 
      'FIS' Type
,     bi.name AS Clients
FROM business 	    bi
INNER JOIN customer cs  ON (cs.cust_id = bi.cust_id)
INNER JOIN account  acc ON (acc.cust_id = cs.cust_id)
INNER JOIN branch   bc  ON (bc.branch_id = acc.open_branch_id)
WHERE cs.city != bc.city;





-- ------------------------------------------------------------------------------------------------------ --
-- 3) Escreva uma consulta que retorne os nome de todos os funcionários com, se for o caso, os números de --
-- transações por ano envolvendo as contas que eles abriram (usando open_emp_id). Ordene os resultados    --
-- por ordem alfabética, e depois por ano (do mais antigo para o mais recente).                           --                            
-- ------------------------------------------------------------------------------------------------------ --

SELECT
	CONCAT(emp.fname,' ', emp.lname) AS Name
, COUNT(trn.txn_id) 				       AS Transactions
FROM employee 		    emp
LEFT JOIN account 	  acc ON (acc.open_emp_id = emp.emp_id)
LEFT JOIN transaction trn ON (trn.account_id = acc.account_id)
GROUP BY Name
ORDER BY Name, trn.txn_date;
