SELECT * FROM T1;
SELECT * FROM T2;


SELECT *
	FROM T1 JOIN T2
		ON T1.EX_ID = T2.EX;
		
CREATE TABLE SQLD_21_01(
	N1 NUMBER(1),
	V1 CHAR(1)
);

INSERT INTO SQLD_21_01(N1, V1) VALUES(1,'A');
INSERT INTO SQLD_21_01(N1, V1) VALUES(2,NULL);
INSERT INTO SQLD_21_01(N1, V1) VALUES(3,'B');
INSERT INTO SQLD_21_01(N1, V1) VALUES(4,'C');

DROP TABLE SQLD_21_01;

CREATE TABLE SQLD_21_02(
	N1 NUMBER(1),
	V1 CHAR(1)
);

INSERT INTO SQLD_21_02(N1, V1) VALUES(1,'A');
INSERT INTO SQLD_21_02(N1, V1) VALUES(2,NULL);
INSERT INTO SQLD_21_02(N1, V1) VALUES(3,'B');

SELECT * FROM SQLD_21_01
WHERE V1 IN (SELECT V1 FROM SQLD_21_02);

SELECT * FROM SQLD_21_01
WHERE V1 NOT IN (SELECT V1 FROM SQLD_21_02);

SELECT * FROM SQLD_21_01 A
WHERE EXISTS (SELECT 'X' FROM SQLD_21_02 B
WHERE A.V1 = B.V1);

SELECT * FROM SQLD_21_01 A
WHERE NOT EXISTS (SELECT 'X' FROM SQLD_21_02 B
WHERE A.V1 = B.V1);

SELECT DNAME, JOB, COUNT(*), SUM(SAL)
	FROM EMP, DEPT
		WHERE EMP.DEPTNO = DEPT.DEPTNO
			GROUP BY ROLLUP(DNAME, JOB);
		
SELECT JOB, ENAME, SAL FROM EMP ORDER BY SAL;

SELECT JOB, ENAME, SAL, RANK() OVER (ORDER BY SAL) ALL_RANK,
	RANK() OVER(PARTITION BY JOB ORDER BY SAL) JOB_RANK FROM EMP ORDER BY JOB DESC;

SELECT JOB, ENAME, SAL, DENSE_RANK() OVER (ORDER BY SAL) FROM EMP;

SELECT MGR, ENAME, SAL, SUM(SAL) OVER(PARTITION BY MGR ORDER BY SAL RANGE UNBOUNDED PRECEDING) FROM EMP;
		
SELECT MGR, SAL, MAX(SAL) OVER(PARTITION BY MGR) MAX_SAL FROM EMP; -- 같은 매니저를 두고 있는 사원 중 가장 많은 월급을 받는 사원의 컬럼 추가

-- 같은 매니저를 둔 사원 중 가장 많은 월급을 가진 사원만 출력하기
SELECT MGR, ENAME, SAL FROM EMP WHERE SAL IN (SELECT MAX(SAL) OVER(PARTITION BY MGR) MAX_SAL FROM EMP) ORDER BY MGR;

SELECT MGR, ENAME, SAL
	FROM (SELECT MGR, ENAME, SAL, MAX(SAL) OVER(PARTITION BY MGR) MAX_SAL FROM EMP)
		WHERE SAL = MAX_SAL;

SELECT MGR, ENAME, HIREDATE, SAL, AVG(SAL) OVER(PARTITION BY MGR ORDER BY SAL ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AVG_SAL FROM EMP;


SELECT MGR, ENAME, HIREDATE, SAL, AVG(SAL) OVER(PARTITION BY MGR ORDER BY SAL ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AVG_SAL FROM EMP;
SELECT MGR, ENAME, HIREDATE, SAL, AVG(SAL) OVER(PARTITION BY MGR ORDER BY SAL RANGE BETWEEN 1 PRECEDING AND 2 FOLLOWING) AVG_SAL FROM EMP;




SELECT MGR, ENAME, HIREDATE, SAL, AVG(SAL) OVER(PARTITION BY MGR ORDER BY SAL) AVG_SAL FROM EMP;

SELECT DEPTNO, SAL, ENAME FROM EMP ORDER BY DEPTNO, SAL;

SELECT DEPTNO, ENAME, SAL,
           SUM(SAL) OVER ( PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING ) AS SUM_SAL
     FROM EMP ;
 
SELECT DEPTNO, ENAME, SAL,
           SUM(SAL) OVER ( PARTITION BY DEPTNO ORDER BY SAL DESC RANGE UNBOUNDED PRECEDING ) AS SUM_SAL
     FROM EMP ;

    
    SELECT PLAYER_NAME, POSITION, TEAM_ID, HEIGHT
FROM (SELECT PLAYER_NAME, POSITION, TEAM_ID,
HEIGHT FROM PLAYER ORDER BY HEIGHT DESC)
WHERE HEIGHT IS NOT NULL
AND ROWNUM < 6 ORDER BY PLAYER_NAME;

SELECT PLAYER_NAME, TEAM_ID,
(SELECT ROUND(AVG(HEIGHT),2) FROM PLAYER ORDER BY PLAYER_NAME) "
AS 전체 평균키"
FROM PLAYER;

 SELECT CEIL(11.01) FROM DUAL;
 
SELECT TRUNC(345.123, 1), TRUNC(345.123, 0), TRUNC(345.123, -1) FROM DUAL;

SELECT POWER(3, 2), POWER(3, -2) FROM DUAL;


CREATE TABLE SQLD_30_30_고객
(
  고객ID NUMBER,
  고객명 VARCHAR2(30)
);

CREATE TABLE SQLD_30_30_상품
(
  상품ID NUMBER,
  상품명 VARCHAR2(30),
  상품가격 NUMBER
);

CREATE TABLE SQLD_30_30_주문
(
  주문ID NUMBER,
  고객ID NUMBER,
  상품ID NUMBER,
  수량 NUMBER,
  주문일자 VARCHAR2(8)
);

INSERT INTO SQLD_30_30_고객 VALUES(1, 'A');
INSERT INTO SQLD_30_30_고객 VALUES(2, 'B');
INSERT INTO SQLD_30_30_고객 VALUES(3, 'C');
INSERT INTO SQLD_30_30_고객 VALUES(4, 'D');
INSERT INTO SQLD_30_30_고객 VALUES(5, 'E');
INSERT INTO SQLD_30_30_고객 VALUES(6, 'F');

INSERT INTO SQLD_30_30_상품 VALUES(100, 'P01',1000);
INSERT INTO SQLD_30_30_상품 VALUES(101, 'P02',2000);
INSERT INTO SQLD_30_30_상품 VALUES(102, 'P03',3000);
INSERT INTO SQLD_30_30_상품 VALUES(103, 'P04',4000);
INSERT INTO SQLD_30_30_상품 VALUES(200, 'X01',10000);
INSERT INTO SQLD_30_30_상품 VALUES(201, 'X02',100);
INSERT INTO SQLD_30_30_상품 VALUES(202, 'X03',23000);

TRUNCATE TABLE SQLD_30_30_주문;
INSERT INTO SQLD_30_30_주문 VALUES(1001, 1,100, 2,'20171201');
INSERT INTO SQLD_30_30_주문 VALUES(1002, 1,101, 1,'20171201');
INSERT INTO SQLD_30_30_주문 VALUES(1003, 2,200, 3,'20171201');
INSERT INTO SQLD_30_30_주문 VALUES(1004, 3,202, 1,'20171201');
INSERT INTO SQLD_30_30_주문 VALUES(1005, 4,103, 5,'20180504');
INSERT INTO SQLD_30_30_주문 VALUES(1006, 5,102, 2,'20180504');

INSERT INTO SQLD_30_30_주문 VALUES(1007, 1,200, 2,'20180504');
INSERT INTO SQLD_30_30_주문 VALUES(1008, 4,100, 1,'20180504');
INSERT INTO SQLD_30_30_주문 VALUES(1009, 4,200, 2,'20180806');
INSERT INTO SQLD_30_30_주문 VALUES(1010, 5,102, 3,'20180806');
INSERT INTO SQLD_30_30_주문 VALUES(1011, 5,101, 1,'20180806');
INSERT INTO SQLD_30_30_주문 VALUES(1012, 5,201, 1,'20190102');

INSERT INTO SQLD_30_30_주문 VALUES(1013, 2,103, 4,'20190102');
INSERT INTO SQLD_30_30_주문 VALUES(1014, 2,102, 1,'20190102');
INSERT INTO SQLD_30_30_주문 VALUES(1015, 1,202, 3,'20190102');

COMMIT;

SELECT * FROM SQLD_30_30_고객;
SELECT * FROM SQLD_30_30_상품;
SELECT * FROM SQLD_30_30_주문;

SELECT A.고객명,
NVL(SUM(C.수량*B.상품가격),0) AS 총주문금액
FROM SQLD_30_30_고객 A
INNER JOIN SQLD_30_30_주문 C ON A.고객ID = C.고객ID
INNER JOIN SQLD_30_30_상품 B ON C.상품ID = B.상품ID
WHERE 1=1
GROUP BY A.고객명
ORDER BY 1,2;

SELECT A.고객명,
NVL((
SELECT SUM(C.수량 * B.상품가격)
FROM SQLD_30_30_주문 C
LEFT JOIN SQLD_30_30_상품 B ON C.상품ID = B.상품ID
WHERE C.고객ID = A.고객ID),0 ) AS 총주문금액
FROM SQLD_30_30_고객 A
WHERE 1=1
ORDER BY 1,2;

SELECT A.고객명,
NVL(SUM(총가격),0) AS 총주문금액
FROM SQLD_30_30_고객 A
LEFT OUTER JOIN
(
SELECT C.고객ID, C.수량 * B.상품가격 AS 총가격
FROM SQLD_30_30_주문 C
INNER JOIN SQLD_30_30_상품 B ON C.상품ID = B.상품ID) D
ON A.고객ID = D.고객ID
WHERE 1=1
GROUP BY A.고객명
ORDER BY 1,2;

SELECT A.고객명,
NVL(SUM(C.수량*B.상품가격),0) AS 총주문금액
FROM SQLD_30_30_고객 A
LEFT OUTER JOIN SQLD_30_30_주문 C ON A.고객ID = C.고객ID
LEFT OUTER JOIN SQLD_30_30_상품 B ON C.상품ID = B.상품ID
WHERE 1=1
GROUP BY A.고객명
ORDER BY 1,2;

