--주석은  -- 두개 입니다
--20190114 DDL
--테이블 만들어 봅시다 (HR게정에 생성해보자)
--CREATE TABLE 테이블명 (컴럼명 타입(타입크기),....);
-- 유의 사항 ==> 오라클은 계정명과 테이블명은 대소문자 가리지 않음, 비밀번호는 구별함

--시나리오  TABLE명은 RAINBOW, 컬럼 이름 나이 생년월일 성별 
CREATE TABLE RAINBOW(
 NAME VARCHAR2(10), -- 가변길이
 AGE NUMBER(3), --숫자
 BIRTHDAY DATE,--날짜
 GENDER CHAR(2)--고정자리 
 );
 
--컬럼 정의 방식 :NAME VARCHAR2(2) NOT NULL
-- 테이블 정의 방식 : CREATE TABLE 테이블명 ( ~~~~
--                         CONSTRAINT RAINBOW_PK PRIMARY KEY(NAME) );

--20190116 
--삭제 : DROP DELETE TRUNCATE
--DROP : DROP TABLE CLOUD; <---테이블 구조 및 데이터삭제 
                                              <---  DDL TCL 취소불가능
 --DELETE VS TRUNCATE
 --  데이터 삭제 구조는 그대로 둠 
 -- 휴지통으로 감 하지만 삭제속도가 느림 VS 바로 삭제 복구 않됨 
 --DELETE FROM CLOUD , TRUNCATE TABLE CLOUD
 
 -- INSERT, UPDATE,DELETE
 --INSERT 는 테이블 값을 입력하는 명령어 
 --INSERT INTO  테이블명(컬럼, 컴럼....)
    --VALUES 값
 INSERT INTO HR.PLAYER
(PLAYER_ID, PLAYER_NAME, TEAM_ID, E_PLAYER_NAME, NICKNAME, JOIN_YYYY, "POSITION", BACK_NO, NATION, BIRTH_DATE, SOLAR, HEIGHT, WEIGHT)
VALUES('20190116', '위범진', 'K05', '', '', '', '', 0, '', '', '', 0, 0);
   

INSERT INTO PLAYER
VALUES('20190117', '위범진', 'K05', '', '', '', '', 0, '', '', '',0,0);

INSERT INTO PLAYER(PLAYER_ID, PLAYER_NAME, TEAM_ID)
VALUES('20190117', '위범진', 'K05');

--UPDATE  수정 
--생성된 ROW 모든 컴럼의 값을 선택적으로 수정할수있다 
--PLAYER 에 모근 사람의 이름 전민균
-- UPDATE TABLE명 SET 컴럼 = 바꿀값 [WHERE 조건절]
-- ** 값( 숫자 문자 날짜 ) 은 모두 '' 처리  
UPDATE PLAYER SET PLAYER_NAME = '전민균',TEAM_ID='K05';
--TCL ROLLBACK :최근 COMMIT  이전의 상태까지 취소 
ROLLBACK;
--실습 
--INSERT 문 PLAYER 2019120  홍길동 K05
--UPDATE HEIGHT 190
-- DELETE

DELETE FROM PLAYER;
ROLLBACK;
--SELECT 
--검색 
-- SELECT 컬럼명 컬럼명 FROM 테이블 [WHERE절]
-- 축구선수들 중 박지성 선수의 키와 영문이름을 알고 싶다

SELECT * FROM PLAYER WHERE PLAYER_NAME='박지성';

SELECT PLAYER_ID,NICKNAME,TEAM_ID FROM PLAYER WHERE PLAYER_NAME ='가비';
--가비 아이디 ,팀아이디 ,별명

--와일드 카드 * ( 모든것들) SELECT의 모든 컬럼
--ALIAS (알리 알스/별칭)
---SELECT AS 또는 한칸 뛰고 적는다 
---FROM  한칸 (알리알스와 혼영 사용 불가 ) 

SELECT PLAYER_ID AS 팀아이디,PLAYER_NAME 이름 FROM PLAYER;
SELECT * FROM PLAYER; -- 테이블명.* FROM 

-- 컴럼의 알리알스에 공백을 추가 할떄
--예약어가 컴럼혹은 테이블로 되어있을때
SELECT PLAYER_ID AS "팀 아이디",PLAYER_NAME 이름 FROM PLAYER;
SELECT * FROM PLAYER; 

--실습 
--입력한 선수들의 정보를 선수명,포지션,키, 몸무게로 
--컬럼명으로 만등어서 출력해주세요 

 SELECT PLAYER_NAME 선수명,"POSITION" 위치,HEIGHT 키,WEIGHT 몸무게 FROM PLAYER
 
 --연산의 최고봉은 () 이다 !!!!
 --연산은 숫자끼리만 발생한다..
 --문자랑 숫자 =--NULL과 숫자 문자와문자 
 
 
SELECT*FROM PLAYER

--문자형 숫자 문자랑 숫자
--문자가 포함되어 있지 않은 문자를 숫자로 자동 변환
--문자랑 숫자는 서로 다른 형을 보이기에 안됨//   
--|| (컨텍트 네이션) 보이는 문자그대로 보임// 연쇄적인 //
SELECT TEAM_ID + BACK_NO
   FROM PLAYER 
  		WHERE PLAYER_NAME='가비';
SELECT BACK_NO+BACK_NO
	FROM PLAYER 
		WHERE PLAYER_NAME='가비';
SELECT BIRTH_DATE +1
	FROM PLAYER 
		WHERE PLAYER_NAME='가비';
	-- SELECT 컬럼 , 컬럼//FROM 테이블명
	--[WHERE 조건식 ]
	--조건 >< = AND OR
	--()  가로가 우선 //
	
	--실습
	-- 소속팀이 삼성 블루윙즈이거나 전남드래곤즈에 소속된 선수이어야 하고
	--포지션이 미드필어이어야 한다
	--키는 170 cm 이상이어야 하고 180 이하 여야 한다.
	
	--1) 각단어 들이 연관된 ERD 와 매핑
	--2)사용되는 테이블을 찾는다 
	--3)사용되는 컴럼을 찾는다
--4) 조건을 분석하자 
-- 소속팀이 삼성 블루윙즈이거나 전남드래곤즈에 소속된 선수이어야 하고
--선수들(*)PLAYER/@소속팀 PLAYER(TEAM_ID) @ 팀명찾기 @TEAM 테이블에 NAME으로 ID를 찾응수 있응
--찾을값 * 선수들 

SELECT * FROM TEAM WHERE TEAM_NAME='삼성블루윙즈';
SELECT * FROM TEAM WHERE TEAM_NAME LIKE '%곤즈';
SELECT* FROM PLAYER WHERE TEAM_ID ='K02' OR TEAM_ID = 'K07';
SELECT* FROM PLAYER 
WHERE (TEAM_ID='K02'
OR TEAM_ID='K07')
AND "POSITION" = 'MF';
-- 실습 K02  이거나 K07  선수들 중에서 포지션이 MF 

SELECT *
	FROM PLAYER
		WHERE TEAM_ID IN ('K07','K02') AND "POSITION" = 'MF'
		
SELECT *
 FROM PLAYER
 		WHERE HEIGHT >=170 AND HEIGHT <=180;
SELECT *
 FROM PLAYER
 		WHERE HEIGHT <180  AND HEIGHT >170;
 	SELECT *
 	 FROM PLAYER
 	 	 WHERE HEIGHT BETWEEN 170 AND 180;
 	 	 	SELECT *
 	 FROM PLAYER
 	 	 WHERE HEIGHT BETWEEN 180 AND 170;
 	 	 	SELECT *
 	 FROM PLAYER
 	 	 WHERE NOT (HEIGHT BETWEEN 180 AND 170);
 	--20
	
 	 	-- 주석은 -- 입니다
-- 20190114 DDL
-- 테이블 만들어 봅시다(hr계정에 테이블을 생성)
-- CREATE TABLE 테이블명 (컬럼명 타입(타입크기), .....);
-- 오라클은 테이블명과  계정명 대소문자 없음, 비번 대소문자 필수

-- 시나리오 테이블명 RAINBOW, 컬럼 이름, 나이, 생년월일, 성별
CREATE TABLE RAINBOW(
	NAME VARCHAR2(10), --  가변길이 10 
	AGE NUMBER(3), -- 숫자 3자리  
	BIRTHDAY DATE, --  날짜
	GENDER CHAR(2) -- 고정 자리
);

-- 컬럼 정의 방식 : NAME VARCHAR2(2) NOT NULL
-- 테이블 정의 방식 : CREATE TABLE 테이블명(~~~~
--							CONSTRAINT RAINBOW_PK PRIMARY KEY (NAME)	); 

-- 20190115
CREATE TABLE CLOUD (
 ID VARCHAR2(20),
 STATUS CHAR(2),
 ETC VARCHAR2(500)
);

-- RAINBOW에 컬럼(헤더)를 추가 
ALTER TABLE RAINBOW ADD (ID VARCHAR2(20));

-- RAINBOW에 컬럼 삭제(ID 컬럼 삭제)
ALTER TABLE RAINBOW DROP COLUMN ID;

-- 수정
-- 제약조건 = contraints 
-- gender char(2) -> varchar2(4)
ALTER TABLE RAINBOW
MODIFY (GENDER VARCHAR2(4));
-- 
INSERT INTO RAINBOW
(NAME, AGE, BIRTHDAY)
VALUES('전민균1', 39, NULL);

-- MODIFY 기본값(DEFAULT)
ALTER TABLE RAINBOW 
MODIFY (GENDER DEFAULT '여');

-- NULL값이 있는데 NOT NULL로 바꿔보자 -> 실패
ALTER TABLE RAINBOW
MODIFY (BIRTHDAY NOT NULL);

-- NULL이 없는 컬럼 수정 NOT NULL
ALTER TABLE RAINBOW
MODIFY (AGE NOT NULL);

-- RENAME COLUMN
--ALTER TABLE RAINBOW
--RENAME COLUMN 변경전 TO 변경후 
ALTER TABLE CLOUD
RENAME COLUMN ETC TO AAA;

ALTER TABLE CLOUD
RENAME COLUMN AAA TO ETC;

-- 제약조건 삭제 : 테이블에서의 행동을 제한 하는 것
--                      EX) NULL 허용 안함, DEFAULT, CHECK
--                      164.PAGE

ALTER TABLE RAINBOW
DROP CONSTRAINT SYS_C007264;

-- 시나리오 (PPT 참조)
-- 컬럼 추가 
ALTER TABLE RAINBOW ADD (ID VARCHAR2(20));

-- 각테이블의 PK 설정
-- RAINBOW에 NAME을 PK
ALTER TABLE RAINBOW ADD CONSTRAINT
RAINBOW_PK PRIMARY KEY (NAME);
-- CLOUD에 ID를 PK로 설정
ALTER TABLE CLOUD ADD CONSTRAINT
CLOUD_PK PRIMARY KEY (ID);

-- FK을 연결 함 RAINBOW가 FK 가지고 있음
ALTER TABLE RAINBOW ADD CONSTRAINT
RAINBOW_FK FOREIGN KEY (ID) REFERENCES CLOUD(ID);


-- 테이블의 값은 다 지움
DELETE FROM RAINBOW;

-- 값을 넣어 보자 부모->자식
INSERT INTO CLOUD(ID, STATUS, ETC)
					VALUES('K01', 'A', '^^');
INSERT INTO RAINBOW(NAME, AGE, BIRTHDAY, GENDER, ID)
VALUES('홍길동', 13, SYSDATE, '여', 'K01');
	
-- 삭제해 보자 자식 ->부모
DELETE FROM RAINBOW;
DELETE FROM CLOUD;

-- 20190116 
-- 삭제 : drop delete truncate
-- drop : DROP TABLE CLOUD; <- 테이블 구조 및 데이터 삭제
--                                        <- DDL TCL 취소 불가능
-- DELETE vs TRUNCATE 
--  -> 데이터 삭제, 구조는 그대로 둠
--  -> 휴지통 으로 감 , 하지만 삭제 속도가 느림 vs 바로 삭제 복구 않됨
-- DELETE FROM CLOUD ,  TRUNCATE TABLE CLOUD

-- INSERT, UPDATE, DELETE
-- INSERT 는 테이블 값을 입력 하는 명령어
-- INSERT INTO 테이블명(컬럼, 컬럼....)
--                    VALUES(값,      값....) : 명시적 방법
-- INSERT INTO 테이블명
--                    VALUES(값,      값....)
INSERT INTO PLAYER
(PLAYER_ID, PLAYER_NAME, TEAM_ID, E_PLAYER_NAME, NICKNAME, JOIN_YYYY, "POSITION", BACK_NO, NATION, BIRTH_DATE, SOLAR, HEIGHT, WEIGHT)
VALUES('2019116', '전민균', 'K05', '', '', '', '', 0, '', '', '', 0, 0);

INSERT INTO PLAYER
VALUES('2019117', '전민균', 'K05', '', '', '', '', 0, '', '', '', 0,0);

INSERT INTO PLAYER(PLAYER_ID, PLAYER_NAME,TEAM_ID)
VALUES('2019118', '전민균', 'K05');

-- UPDATE 수정
-- 생성된 ROW의 모든 컬럼의 값을 선택으로 수정 할 수 있다.
-- PLAYER에 모든 사람의 이름 전민균
-- UPDATE TABLE명 SET 컬럼 = 바꿀값 [WHERE 조건절]
-- ** 값(숫자, 문자, 날짜)은 모두 '' 처리  
UPDATE PLAYER SET PLAYER_NAME = '전민균', TEAM_ID='K05';

--- TCL ROLLBACK : 최근 COMMIT 이전의 상태까지 취소 
ROLLBACK;

-- 실습
-- INSERT 문 PLAYER  2019120 홍길동 K05 
-- UPDATE HEIGHT 190 
-- DELETE 
INSERT INTO PLAYER(PLAYER_ID,PLAYER_NAME,TEAM_ID)
					VALUES('2019120', '홍길동', 'K05');
				
UPDATE PLAYER SET HEIGHT = '190';

-- DELETE 삭제 : 휴지통
-- DELECT FROM 테이블명 [WHERE 조건절]
 DELETE FROM PLAYER;

-- SELECT 
-- 검색
-- SELECT 컬럼명, 컴럼명 FROM 테이블 [WHERE 조건]
-- 축구선수들 중 박지성 선수의 키와 영문이름을 알고 싶다

SELECT * FROM PLAYER WHERE PLAYER_NAME='박지성';
-- 가비 아이디, 팀아이디, 별명

SELECT * FROM PLAYER WHERE PLAYER_NAME='가비';

SELECT PLAYER_ID, TEAM_ID, NICKNAME FROM PLAYER
WHERE PLAYER_NAME ='가비';

-- 와일드 카드 * 모든 것 (SELECT의 모든 컬럼)

-- 알리아스 (ALIAS) 별칭
-- SELECT AS 또는 한칸 작성
-- FROM 한칸 (ALIAS와 기존이름 혼용 사용 할 수 없다.)
SELECT P.* FROM PLAYER  P; --정상
SELECT PLAYER.* FROM PLAYER  P; -- 비정상
SELECT P.* FROM PLAYER AS P; -- 비정상

SELECT PLAYER_ID AS 팀아이디, PLAYER_NAME 이름 
		FROM PLAYER ;

-- "" 컬럼의 ALIAS에 공백을 추가 할때
-- 예약어가 컬럼 혹은 테이블로 되어 있을때
SELECT PLAYER_ID AS "팀 아이디", PLAYER_NAME 이름 
		FROM PLAYER ;
	
-- 실습
-- 입력한 선수들의 정보를 선수명, 위치, 키, 몸무게로 
-- 컬럼명으로 만들어서 출력 해주세요



SELECT HR."USER" FROM PLAYER

-- 20190117
-- 연산
-- () 최우선
-- 연산 숫자와 숫자가 연산
--  문자랑 숫자 -- NULL과 숫자 -- 문자와 문자
SELECT * FROM PLAYER; 

SELECT PLAYER_ID, TEAM_ID, BACK_NO, BIRTH_DATE FROM PLAYER
	WHERE PLAYER_NAME ='가비';

--문자형 숫자랑 숫자
-- 문자가 포함되어 있지 않은 문자를 숫자로 자동 변환
SELECT PLAYER_ID+BACK_NO 
	FROM PLAYER 
		WHERE PLAYER_NAME='가비';

-- 문자랑 숫자
-- 문자와 숫자는 서로 다른 형태를 보이기 때문에 안됨
SELECT TEAM_ID + BACK_NO
	FROM PLAYER 
		WHERE PLAYER_NAME='가비';

-- 숫자 + 숫자
SELECT BACK_NO + BACK_NO FROM PLAYER WHERE PLAYER_NAME='가비';
-- 191
-- 문자랑 숫자는 진정 같이 있을 수 없는가?
-- 보이는 그대로 문자로 변환 CONCATENATIONN 연쇄
-- EX) K01 + 10 -> K0110
-- ORACLE ||  , MSSQL + 
SELECT TEAM_ID || BACK_NO
	FROM PLAYER 
		WHERE PLAYER_NAME='가비';
	
SELECT PLAYER_NAME || '별명은' || NICKNAME AS 수정
	FROM PLAYER;

SELECT BIRTH_DATE +31
	FROM PLAYER 
		WHERE PLAYER_NAME='가비';

-- 더미테이블 ANSI 표준에 문법을 맞추기 위한 빈 테이블
-- 오라클은 문법상 더미테이블 필요, MSSQL 없어도 됨
SELECT SYSDATE +25 FROM DUAL;
SELECT * FROM TEAM;

-- 193 Transaction
-- ACID, savepoint[ {  <> } ]
-- TCL -> ROLLBACK(취소), COMMIT(적용)

-- 207 
-- SELECT 컬럼, 컬럼.. FROM 테이블명
 -- [WHERE 조건식]
 -- 조건 > < >= AND OR 
-- 209 PAGE 
-- () ->NOT->비교->AND -> OR

-- 실습
-- 소속팀이 삼성 블루윙즈이거나 전남드래곤즈에 소속된 선수들이어야 하고
-- 포지션이 미드필어 이어야 한다
-- 키는 170 센티미터 이상이고 180 이하여야 한다

--1) 각 단어 들이 연관된 ERD 와 매핑
--2) 사용되는 테이블 찾는다
--3) 사용되는 컬럼을 찾는다
--4) 조건을 분석한다

-- 소속팀이 삼성 블루윙즈이거(K02)"나" 전남드래곤즈(K07)에 소속된 선수들이어야 하고
-- 선수들(*): PLAYER / @소속팀 PLAYER(TEAM_ID)@
-- 팀명 찾기@TEAM 테이블에 NAME으로 ID를 찾을 수 있음@
-- 찾을 값 * 선수들

SELECT * FROM TEAM WHERE TEAM_NAME='삼성블루윙즈';
SELECT * FROM TEAM WHERE TEAM_NAME LIKE '%곤즈';

SELECT * FROM PLAYER WHERE TEAM_ID ='K02' OR TEAM_ID = 'K07';

-- 실습 :  K02 이거나 K07 인 선수들 중에서 POSITION MF
SELECT * 
	FROM PLAYER 
	WHERE (TEAM_ID ='K02'
		 	OR TEAM_ID = 'K07')
			AND  "POSITION" = 'MF';

-- IN : SQL 제공 우선순위서 AND OR 위에  
SELECT * 
	FROM PLAYER
		WHERE TEAM_ID IN ('K07','K02') AND "POSITION" = 'MF';


-- 포지션이 미드필더 이어야 한다
SELECT * FROM PLAYER WHERE "POSITION"='MF';

-- 키는 170 센티미터 이상이고 180 이하여야 한다
-- 이상 이하 : 자신을 포함  A >= 170
-- 미만 초과 : 자신을 포함 하지 않음  A>170
-- 컬럼 BETWEEN A AND B :  포함
	
SELECT * 
	FROM PLAYER
		WHERE HEIGHT >=170 AND HEIGHT <=180; -- 259명
		
SELECT * 
	FROM PLAYER
		WHERE HEIGHT <180 AND HEIGHT >170; -- 204명

SELECT *
	FROM PLAYER
		WHERE HEIGHT BETWEEN 170 AND 180; -- 이상 이하 와 같다
	
SELECT *
	FROM PLAYER
		WHERE NOT (HEIGHT BETWEEN 180 AND 170);

SELECT * FROM PLAYER;

--- ** 212 PAGE 
-- CHAR와 VHARCHAR2
-- CHAR(3)   'AA'  CHAR(5)'    A'

-- 이름, 포지션, 백넘버
-- 소속팀이 삼성 블루윙즈이거나 전남드래곤즈에 소속된 선수들이어야 하고
-- 포지션이 미드필어 이어야 한다
-- 키는 170 센티미터 이상이고 180 이하여야 한다

SELECT PLAYER_NAME, "POSITION", BACK_NO 
	FROM PLAYER
		WHERE (TEAM_ID = 'K02' OR TEAM_ID = 'K07')
				AND "POSITION" = 'MF'
				AND HEIGHT >=170 AND HEIGHT <=180;

SELECT PLAYER_NAME, "POSITION", BACK_NO 
	FROM PLAYER
		WHERE TEAM_ID IN ('K02','K07')
					AND "POSITION" = 'MF'
					AND HEIGHT BETWEEN 170 AND 180;

--- NULL, LIKE, IN 

-- NULL 비교연산(크다 작다) FALSE
-- NULL  연산(+) 결과 NULL 
SELECT PLAYER_ID, NICKNAME, BACK_NO FROM PLAYER;

SELECT NICKNAME + BACK_NO FROM PLAYER;
-- CONCATENATION은 NULL 없는값 으로 처리
SELECT PLAYER_ID || NICKNAME FROM PLAYER;

-- LIKE 포함된 문자열의 값을 찾음
-- % : 모든 것 , _ 한칸
-- '%A' : A로 끝나는 모든 값 (FDSAFDA,ASFA, WF4A)
-- '_A' : A로 끝나고 두자리인 값(AA, 2A, 5A)

 SELECT * FROM PLAYER WHERE PLAYER_NAME LIKE '김%';
 SELECT * FROM PLAYER WHERE PLAYER_NAME LIKE '김_';

-- IN 절
-- 사원테이블에서 JOB = MAMAGER AND DEPTNO = 20 이거나
--               JOB = CLERK AND DEPTNO 30   
SELECT * FROM EMP
	WHERE JOB = 'MANAGER' AND DEPTNO = '20';				
SELECT * FROM EMP
	WHERE JOB = 'CLERK' AND DEPTNO = '30';

SELECT * 
	FROM EMP
		WHERE (JOB = 'MANAGER'AND DEPTNO = '20')
			OR (JOB = 'CLERK' AND DEPTNO = '30');
		
SELECT * FROM EMP
	WHERE (JOB, DEPTNO) IN (('MANAGER','20') ,('CLERK','30') );
				
				
				
		
				
				
 	 	
 --20190121
 
 --CASE	 	조건문 / 선택 조건문
 --CASE 		WHEN THEN ELSE END
 --Search (범위), Simple (1:1매칭이 된다.)
 
 --CASE 		WHEN (이 뒤에 범위가 들어가면 SEARCH 이고) THEN ELSE END
 --Simple (1:1)
 --CASE 컬럼 WHEN 값 THEN ELSE END
 
 --부서 정보 중에서 부서 위치를 동부, 중부, 서부 
 --DEPT  부서 정보
 --NEWYORK 동부
 --BOSTON 중부
 --DALLAS 중부
 --나머진 서부
 SELECT DEPTNO, DNAME, LOC,
 		CASE LOC WHEN 'NEW YORK' THEN 'E'
 						WHEN 'BOSTON' THEN 'E'
						WHEN 'CHICAGO' THEN 'C'
						WHEN 'DALLAS' THEN 'C'		
 		ELSE 'W' END AS LOCNAME
 		FROM DEPT;
 	
--사원의 정보 중에서 급여가 3000이상이면 HIGH
--1000이상이면 MID
--나머지는 다 LOW 	 

SELECT EMPNO, ENAME, SAL,
		CASE WHEN SAL>=3000 THEN 'HIGH' 
				WHEN SAL>=1000 THEN 'MID'
		ELSE 'LOW' END
		FROM EMP; 	
 	 	
-- 시험 대비
--중첩 CASE문 P244 참고해서 그쪽만 참고하기
--사원의 정보에서 급여가 2000이상이면 보너스를 1000으로 
--1000이상이면 500으로 
--1000미만이면 0원으로 

SELECT  EMPNO, ENAME, SAL,
		CASE WHEN SAL>=2000 THEN 1000 
											ELSE(CASE WHEN SAL>=1000 THEN 500 
															ELSE 0 END)
															END
		FROM EMP;
	
--P.245

--NULL : 미지의 값     		CINSTRAINT (제약조건) <-> not null
--null을 찾는 방법 : is null 이라고 해야 찾을 수 있음
-- 미지의 값이기 때문에 연산을 하면 다 null로 나옴
--concatenation 을 하면 "" 값으로 만들어짐
--null 을 찾고, null 값을 변경하고자 한다.
--NVL : 값이 null이라면 변경해 주세요

SELECT * FROM PLAYER;
--NICKNAME 이 NULL 인 선수들의 아이디와 이름, 팀, 영문이름을 조회해 주세요

SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID,
		NVL(E_PLAYER_NAME, 'EMPTY')   --출력될때 이아이를 바꾸자
		FROM  PLAYER
		WHERE  E_PLAYER_NAME IS  NULL;
						
--NULLIF  거의 사용 안해
-- (컬럼1,컬럼2) 이게 문법임 -> 컬럼1= 컬럼2 같으면 NULL을 반환함
--	 										컬럼1= 컬럼2 다르면 컬럼1을 반환한다.

SELECT TEAM_ID, NULLIF(TEAM_ID, 'K02') FROM TEAM;
 	 	
 	 	
-- NVL -->  CASE 문으로 변경 시험에서만 거의 나옴
SELECT E_PLAYER_NAME FROM PLAYER; 	 	
SELECT E_PLAYER_NAME, NVL(E_PLAYER_NAME, 'EMPTY') FROM PLAYER; 	 	
 	 	
SELECT E_PLAYER_NAME, 
		--NVL(E_PLAYER_NAME, 'EMPTY') 
		CASE WHEN E_PLAYER_NAME IS NULL THEN 'EMPTY'
				ELSE E_PLAYER_NAME END
		FROM PLAYER;	 	

	--공집합, NULL
	--공집합은 값이 없는 상태임 
	--NULL은 미지의 값이 있는 상태(즉 공간은 차지하고 있다는 것이다.)
	
SELECT * FROM PLAYER WHERE TEAM_ID='K99'; --틀린것이 아니라 조건 자체가 없는것을 공
																	--공집합이라고 한다.

SELECT  NVL(PLAYER_ID, 0)
	FROM PLAYER 
			WHERE TEAM_ID='K99';
		
--없는 값을 집계함수 처리하면 NULL		
SELECT  MAX(PLAYER_ID), NVL(  SUM(PLAYER_ID),0)
	FROM PLAYER 
			WHERE TEAM_ID='K99';
		
-- COALECSCE
-- 1차 선택 2차 선택  모두 NULL이면 NULL을 반환한다.
--COMM 있다면 COMM을 출력, COMM이 없다면 SAL을 출력
SELECT COMM, SAL,
		COALESCE(COMM,SAL)
		FROM EMP;
--여기까지 254P		
 
--P 255 집계 함수 : 여러개의 값을 하나의 값으로 나타냄
--NULL 조심 : 대상에서 제외됨
-- 집계함수는 컬럼들하고 사용이 불가, 집계함수는 집계함수만 같이 사용 가능

	
	--사원 전체에 대한 SAL에대한 평균을 알고 싶다.
	-- 사원 전체의 팀별 SAL의 대한 평균을 알고 싶다.
--SELECT * FROM EMP;
--SELECT AVG(SAL), ENAME FROM EMP;

SELECT * FROM EMP;

--SELECT 컬럼명 FROM 테이블명 WHERE 조건절;
--FROM -> WHERE -> SELECT
SELECT AVG(SAL), ENAME FROM EMP;
	
	-- 사원 전체의 팀별 SAL의 대한 평균을 알고 싶다. ~별 로 끝나면 -> GROUP BY 생각!!
	-- WHERE절은 FROM절의 조건을 선언할 수 잇다.
	--  FROM -> WHERE -> GROUP BY -> HAVING -> SELECT (HAVING 절에서 만 작용)
	-- HAVING은 GROUP BY 된 값의 조건을 선언할 수 잇다.
	

--집계함수는 미지의 값.......           NULL은 계산에 넣지 않는다.
SELECT AVG(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
		   COUNT(*), COUNT(SAL)
		FROM EMP;
	
	
SELECT SAL FROM EMP WHERE SAL IS NULL; - 공집합	
	
SELECT COMM FROM EMP WHERE COMM IS NULL;	
	
SELECT COMM FROM EMP WHERE COMM IS NOT NULL;	


-- * 모든 집계 함수에서 COUNT(*) ROW의 갯수
--COUNT(컬럼) 컬럼의 값중 NULL 아닌 값의 갯수만 계산 가능하다
SELECT AVG(NVL(COMM,0)), COUNT(*), COUNT(COMM) FROM EMP;	



--GROUP BY 절은 NULL 을 제외하고 
--GROUP BY 가 되었다면 단일 값은 표출 할 수 없다.

--HAVING 절은 집계된 GROUP의 조건을 나타냄 -> 집계함수를 사용할 수 있다!!!

--선수들 중 포지션별, 최대키, 최소키, 평균키를 구하시오호 (~별 -> GROUP BY)
-- WHERE 조건에 가능하면 많은 값을 줄여주면 속도가 빠름
-- GROUP BY 다음에는 HAVING 절이 가능하고 WHERE 절은 불가능하다.
SELECT  "POSITION"
		FROM PLAYER
			--WHERE "POSITION" IS NOT NULL
				GROUP BY "POSITION";
			
--포지션별 ~~~,	평균키가 180 이상인 포지션만 조회
-- 묶인 상태에서 포지션별 조회해주어야함
SELECT  "POSITION", MAX(HEIGHT), MIN(HEIGHT), 
			 ROUND(AVG(HEIGHT),1)
		FROM PLAYER
				GROUP BY "POSITION"
				HAVING "POSITION" IS NOT NULL
				AND AVG(HEIGHT) > 180; --여기선 집계함수 사용 가능하다. 그룹바이이기 때문
														--원래 WHERE함수에서는 사용불가능하다.
														
				
-- 중요@@@@ 중요
-- SUB_QUERY : SQL문 내부에 SQL 문을 선언하는 것이다.
-- FROM 절에 사용하는 서브쿼리를 인라인뷰라고 한다. (안쪽 뷰!!)
--테이블의 변경된 SELECT 컬럼을 단순화 시키기 위해서
-- FROM절에는 TABLE 명을 선언
--TABLE에 없는 컬럼은 선택 불가
--TABLE ALIAS는 그 이름만 사용 가능				
	
				
				
--실습 : 김성환(DF), TEAM_ID
SELECT NEWPLAYER.CHK
	FROM(SELECT PLAYER_NAME||'('||"POSITION"||')' AS CHK, TEAM_ID
		FROM PLAYER) NEWPLAYER;

--162P 에서 CASE, NULL,GROUP, IN LINE VIEW
	
	SELECT ENAME, EMPNO, EXTRACT(MONTH FROM HIREDATE) 입사월,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 1 THEN  SAL END M1,
		CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 2 THEN  SAL END M2
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 3 THEN  SAL END M3,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 4 THEN  SAL END M4,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 5 THEN  SAL END M5,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 6 THEN  SAL END M6,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 7 THEN  SAL END M7,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 8 THEN  SAL END M8,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 9 THEN  SAL END M9,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 10 THEN  SAL END M10,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 11 THEN  SAL END M11,
		--CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 12 THEN  SAL END M12
		FROM EMP;
	
	-- 입사 월 별 급여를 출력을 했다면
	-- 각 부서별(EDPTNO) 월 평균 급여를 조회하라
	
	SELECT DEPTNO , TRUNC(AVG(SAL)),
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 1 THEN  SAL END),0) M1,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 2 THEN  SAL END),0) M2,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 3 THEN  SAL END),0) M3,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 4 THEN  SAL END),0) M4,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 5 THEN  SAL END),0) M5,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 6 THEN  SAL END),0) M6,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 7 THEN  SAL END),0) M7,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 8 THEN  SAL END),0) M8,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 9 THEN  SAL END),0) M9,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 10 THEN  SAL END),0) M10,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 11 THEN  SAL END),0) M11,
		NVL(AVG(CASE  EXTRACT(MONTH FROM HIREDATE) WHEN 12 THEN  SAL END),0) M12
		FROM EMP
			GROUP BY  DEPTNO ; 
		
	-- 인라인 뷰(테이블을 정제해서 새로운 테이블을 생성한 후 FROM절에 사용)
	-- EMP 에서 HIREDATE<-월만 정제되어 있는 값, DEPTNO, SAL
	
		SELECT DEPTNO , TRUNC(AVG(SAL)),
		NVL(AVG(CASE  EXM WHEN 1 THEN  SAL END),0) M1,
		NVL(AVG(CASE  EXM WHEN 2 THEN  SAL END),0) M2,
		NVL(AVG(CASE  EXM WHEN 3 THEN  SAL END),0) M3,
		NVL(AVG(CASE EXM WHEN 4 THEN  SAL END),0) M4,
		NVL(AVG(CASE  EXM WHEN 5 THEN  SAL END),0) M5,
		NVL(AVG(CASE  EXM WHEN 6 THEN  SAL END),0) M6,
		NVL(AVG(CASE EXM WHEN 7 THEN  SAL END),0) M7,
		NVL(AVG(CASE  EXM WHEN 8 THEN  SAL END),0) M8,
		NVL(AVG(CASE  EXM WHEN 9 THEN  SAL END),0) M9,
		NVL(AVG(CASE EXM WHEN 10 THEN  SAL END),0) M10,
		NVL(AVG(CASE EXM WHEN 11 THEN  SAL END),0) M11,
		NVL(AVG(CASE  EXM WHEN 12 THEN  SAL END),0) M12
		FROM (SELECT TO_NUMBER(TO_CHAR(HIREDATE,'MM')) EXM, DEPTNO, SAL 
		FROM EMP)
			GROUP BY  DEPTNO ;
		--** 만약에 CASE 문을 사용할때 ELSE 필수 인가요? -> 아니다.
		--ELSE문으로 작성 안하면 NULL
		SELECT CASE JOB WHEN 'CLERK' THEN ENAME END FROM  EMP;
		
		-- ELSE를 사용하면 값을 선택
		-- 반드시 THEN과 같은 타입의 값을 선택
		SELECT CASE JOB WHEN 'CLERK' THEN ENAME 
						ELSE '2' END FROM  EMP;
		-- 문제 : 
		-- 선수들의 포지션별 평균 키 및 전체 평균 키를 출력
		
		-- SCALA SUBQUERY 사용하여 내부에 다른 SQL을 생성 결과를 조회
		SELECT "POSITION" , AVG(HEIGHT),
																(SELECT AVG(HEIGHT) FROM PLAYER)
		FROM PLAYER
			WHERE "POSITION" IS NOT NULL
				GROUP BY "POSITION"; 
			
		-- 대체방안
		-- 가로 세로
		SELECT 
			AVG(CASE "POSITION" WHEN 'DF' THEN  HEIGHT END) 수비수,	
			AVG(CASE "POSITION" WHEN 'MF' THEN  HEIGHT END)  중간,
			AVG(CASE "POSITION" WHEN 'GK' THEN  HEIGHT END)  골키퍼,
			AVG(CASE "POSITION" WHEN 'FW' THEN  HEIGHT END)  공격수
			FROM PLAYER;
		--**********************
		--5 SELECT
		--1 FROM
		--2 WHERE
		--3 GROUP BY
		--4 HAVING
		--6 ORDER BY
		
		-- JOIN 280
		-- 제약조건에 의해 결합된 일대일 등가 조인(EQUI)
		-- 제약조건이 존재하지 않는 비등가 조인(NON-EQUI)
		
		-- ANSI/ISO 표준 : FROM 절 방식 
		 SELECT PLAYER_ID, P.PLAYER_NAME, T.TEAM_ID, TEAM_NAME
		 FROM PLAYER P JOIN TEAM T 
		  		ON P.TEAM_ID = T.TEAM_ID;
		  	
		-- 포지션이 GK인 선수들의 정보와 팀명을 알고 싶다.
		-- 포지션이 GK인 선수들의 정보 : PLAYER
		-- 팀명 : TEAM
		-- PLAYER - TEAM 관계 : TEAM_ID 
		
		 SELECT PLAYER_ID A, PLAYER_NAME, TEAM_NAME
		 FROM PLAYER P ,TEAM T
		 	WHERE P.TEAM_ID = T.TEAM_ID
		 	AND "POSITION" = 'GK'
		 	AND T.TEAM_ID = 'K02';
			ORDER BY A,2, TEAM_ID;	
													
-- 주석은 -- 입니다
-- 20190114 DDL
-- 테이블 만들어 봅시다(hr계정에 테이블을 생성)
-- CREATE TABLE 테이블명 (컬럼명 타입(타입크기), .....);
-- 오라클은 테이블명과  계정명 대소문자 없음, 비번 대소문자 필수
-- 시나리오 테이블명 RAINBOW, 컬럼 이름, 나이, 생년월일, 성별
CREATE TABLE RAINBOW(
    NAME VARCHAR2(10), --  가변길이 10 
    AGE NUMBER(3), -- 숫자 3자리  
    BIRTHDAY DATE, --  날짜
    GENDER CHAR(2) -- 고정 자리
);
-- 컬럼 정의 방식 : NAME VARCHAR2(2) NOT NULL
-- 테이블 정의 방식 : CREATE TABLE 테이블명(~~~~
--                            CONSTRAINT RAINBOW_PK PRIMARY KEY (NAME)    ); 
-- 20190115
CREATE TABLE CLOUD (
 ID VARCHAR2(20),
 STATUS CHAR(2),
 ETC VARCHAR2(500)
);
-- RAINBOW에 컬럼(헤더)를 추가 
ALTER TABLE RAINBOW ADD (ID VARCHAR2(20));
-- RAINBOW에 컬럼 삭제(ID 컬럼 삭제)
ALTER TABLE RAINBOW DROP COLUMN ID;
-- 수정
-- 제약조건 = contraints 
-- gender char(2) -> varchar2(4)
ALTER TABLE RAINBOW
MODIFY (GENDER VARCHAR2(4));
-- 
INSERT INTO RAINBOW
(NAME, AGE, BIRTHDAY)
VALUES('전민균1', 39, NULL);
-- MODIFY 기본값(DEFAULT)
ALTER TABLE RAINBOW 
MODIFY (GENDER DEFAULT '여');
-- NULL값이 있는데 NOT NULL로 바꿔보자 -> 실패
ALTER TABLE RAINBOW
MODIFY (BIRTHDAY NOT NULL);
-- NULL이 없는 컬럼 수정 NOT NULL
ALTER TABLE RAINBOW
MODIFY (AGE NOT NULL);
-- RENAME COLUMN
--ALTER TABLE RAINBOW
--RENAME COLUMN 변경전 TO 변경후 
ALTER TABLE CLOUD
RENAME COLUMN ETC TO AAA;
ALTER TABLE CLOUD
RENAME COLUMN AAA TO ETC;
-- 제약조건 삭제 : 테이블에서의 행동을 제한 하는 것
--                      EX) NULL 허용 안함, DEFAULT, CHECK
--                      164.PAGE
ALTER TABLE RAINBOW
DROP CONSTRAINT SYS_C007264;
-- 시나리오 (PPT 참조)
-- 컬럼 추가 
ALTER TABLE RAINBOW ADD (ID VARCHAR2(20));
-- 각테이블의 PK 설정
-- RAINBOW에 NAME을 PK
ALTER TABLE RAINBOW ADD CONSTRAINT
RAINBOW_PK PRIMARY KEY (NAME);
-- CLOUD에 ID를 PK로 설정
ALTER TABLE CLOUD ADD CONSTRAINT
CLOUD_PK PRIMARY KEY (ID);
-- FK을 연결 함 RAINBOW가 FK 가지고 있음
ALTER TABLE RAINBOW ADD CONSTRAINT
RAINBOW_FK FOREIGN KEY (ID) REFERENCES CLOUD(ID);

-- 테이블의 값은 다 지움
DELETE FROM RAINBOW;
-- 값을 넣어 보자 부모->자식
INSERT INTO CLOUD(ID, STATUS, ETC)
                    VALUES('K01', 'A', '^^');
INSERT INTO RAINBOW(NAME, AGE, BIRTHDAY, GENDER, ID)
VALUES('홍길동', 13, SYSDATE, '여', 'K01');
    
-- 삭제해 보자 자식 ->부모
DELETE FROM RAINBOW;
DELETE FROM CLOUD;
-- 20190116 
-- 삭제 : drop delete truncate
-- drop : DROP TABLE CLOUD; <- 테이블 구조 및 데이터 삭제
--                                        <- DDL TCL 취소 불가능
-- DELETE vs TRUNCATE 
--  -> 데이터 삭제, 구조는 그대로 둠
--  -> 휴지통 으로 감 , 하지만 삭제 속도가 느림 vs 바로 삭제 복구 않됨
-- DELETE FROM CLOUD ,  TRUNCATE TABLE CLOUD
-- INSERT, UPDATE, DELETE
-- INSERT 는 테이블 값을 입력 하는 명령어
-- INSERT INTO 테이블명(컬럼, 컬럼....)
--                    VALUES(값,      값....) : 명시적 방법
-- INSERT INTO 테이블명
--                    VALUES(값,      값....)
INSERT INTO PLAYER
(PLAYER_ID, PLAYER_NAME, TEAM_ID, E_PLAYER_NAME, NICKNAME, JOIN_YYYY, "POSITION", BACK_NO, NATION, BIRTH_DATE, SOLAR, HEIGHT, WEIGHT)
VALUES('2019116', '전민균', 'K05', '', '', '', '', 0, '', '', '', 0, 0);
INSERT INTO PLAYER
VALUES('2019117', '전민균', 'K05', '', '', '', '', 0, '', '', '', 0,0);
INSERT INTO PLAYER(PLAYER_ID, PLAYER_NAME,TEAM_ID)
VALUES('2019118', '전민균', 'K05');
-- UPDATE 수정
-- 생성된 ROW의 모든 컬럼의 값을 선택으로 수정 할 수 있다.
-- PLAYER에 모든 사람의 이름 전민균
-- UPDATE TABLE명 SET 컬럼 = 바꿀값 [WHERE 조건절]
-- ** 값(숫자, 문자, 날짜)은 모두 '' 처리  
UPDATE PLAYER SET PLAYER_NAME = '전민균', TEAM_ID='K05';
--- TCL ROLLBACK : 최근 COMMIT 이전의 상태까지 취소 
ROLLBACK;
-- 실습
-- INSERT 문 PLAYER  2019120 홍길동 K05 
-- UPDATE HEIGHT 190 
-- DELETE 
INSERT INTO PLAYER(PLAYER_ID,PLAYER_NAME,TEAM_ID)
                    VALUES('2019120', '홍길동', 'K05');
                
UPDATE PLAYER SET HEIGHT = '190';
-- DELETE 삭제 : 휴지통
-- DELECT FROM 테이블명 [WHERE 조건절]
 DELETE FROM PLAYER;
-- SELECT 
-- 검색
-- SELECT 컬럼명, 컴럼명 FROM 테이블 [WHERE 조건]
-- 축구선수들 중 박지성 선수의 키와 영문이름을 알고 싶다
SELECT * FROM PLAYER WHERE PLAYER_NAME='박지성';
-- 가비 아이디, 팀아이디, 별명
SELECT * FROM PLAYER WHERE PLAYER_NAME='가비';
SELECT PLAYER_ID, TEAM_ID, NICKNAME FROM PLAYER
WHERE PLAYER_NAME ='가비';
-- 와일드 카드 * 모든 것 (SELECT의 모든 컬럼)
-- 알리아스 (ALIAS) 별칭
-- SELECT AS 또는 한칸 작성
-- FROM 한칸 (ALIAS와 기존이름 혼용 사용 할 수 없다.)
SELECT P.* FROM PLAYER  P; --정상
SELECT PLAYER.* FROM PLAYER  P; -- 비정상
SELECT P.* FROM PLAYER AS P; -- 비정상
SELECT PLAYER_ID AS 팀아이디, PLAYER_NAME 이름 
        FROM PLAYER ;
-- "" 컬럼의 ALIAS에 공백을 추가 할때
-- 예약어가 컬럼 혹은 테이블로 되어 있을때
SELECT PLAYER_ID AS "팀 아이디", PLAYER_NAME 이름 
        FROM PLAYER ;
    
-- 실습
-- 입력한 선수들의 정보를 선수명, 위치, 키, 몸무게로 
-- 컬럼명으로 만들어서 출력 해주세요

SELECT HR."USER" FROM PLAYER
-- 20190117
-- 연산
-- () 최우선
-- 연산 숫자와 숫자가 연산
--  문자랑 숫자 -- NULL과 숫자 -- 문자와 문자
SELECT * FROM PLAYER; 
SELECT PLAYER_ID, TEAM_ID, BACK_NO, BIRTH_DATE FROM PLAYER
    WHERE PLAYER_NAME ='가비';
--문자형 숫자랑 숫자
-- 문자가 포함되어 있지 않은 문자를 숫자로 자동 변환
SELECT PLAYER_ID+BACK_NO 
    FROM PLAYER 
        WHERE PLAYER_NAME='가비';
-- 문자랑 숫자
-- 문자와 숫자는 서로 다른 형태를 보이기 때문에 안됨
SELECT TEAM_ID + BACK_NO
    FROM PLAYER 
        WHERE PLAYER_NAME='가비';
-- 숫자 + 숫자
SELECT BACK_NO + BACK_NO FROM PLAYER WHERE PLAYER_NAME='가비';
-- 191
-- 문자랑 숫자는 진정 같이 있을 수 없는가?
-- 보이는 그대로 문자로 변환 CONCATENATIONN 연쇄
-- EX) K01 + 10 -> K0110
-- ORACLE ||  , MSSQL + 
SELECT TEAM_ID || BACK_NO
    FROM PLAYER 
        WHERE PLAYER_NAME='가비';
    
SELECT PLAYER_NAME || '별명은' || NICKNAME AS 수정
    FROM PLAYER;
SELECT BIRTH_DATE +31
    FROM PLAYER 
        WHERE PLAYER_NAME='가비';
-- 더미테이블 ANSI 표준에 문법을 맞추기 위한 빈 테이블
-- 오라클은 문법상 더미테이블 필요, MSSQL 없어도 됨
SELECT SYSDATE +25 FROM DUAL;
SELECT * FROM TEAM;
-- 193 Transaction
-- ACID, savepoint[ {  <> } ]
-- TCL -> ROLLBACK(취소), COMMIT(적용)
-- 207 
-- SELECT 컬럼, 컬럼.. FROM 테이블명
 -- [WHERE 조건식]
 -- 조건 > < >= AND OR 
-- 209 PAGE 
-- () ->NOT->비교->AND -> OR
-- 실습
-- 소속팀이 삼성 블루윙즈이거나 전남드래곤즈에 소속된 선수들이어야 하고
-- 포지션이 미드필어 이어야 한다
-- 키는 170 센티미터 이상이고 180 이하여야 한다
--1) 각 단어 들이 연관된 ERD 와 매핑
--2) 사용되는 테이블 찾는다
--3) 사용되는 컬럼을 찾는다
--4) 조건을 분석한다
-- 소속팀이 삼성 블루윙즈이거(K02)"나" 전남드래곤즈(K07)에 소속된 선수들이어야 하고
-- 선수들(*): PLAYER / @소속팀 PLAYER(TEAM_ID)@
-- 팀명 찾기@TEAM 테이블에 NAME으로 ID를 찾을 수 있음@
-- 찾을 값 * 선수들
SELECT * FROM TEAM WHERE TEAM_NAME='삼성블루윙즈';
SELECT * FROM TEAM WHERE TEAM_NAME LIKE '%곤즈';
SELECT * FROM PLAYER WHERE TEAM_ID ='K02' OR TEAM_ID = 'K07';
-- 실습 :  K02 이거나 K07 인 선수들 중에서 POSITION MF
SELECT * 
    FROM PLAYER 
    WHERE (TEAM_ID ='K02'
             OR TEAM_ID = 'K07')
            AND  "POSITION" = 'MF';
-- IN : SQL 제공 우선순위서 AND OR 위에  
SELECT * 
    FROM PLAYER
        WHERE TEAM_ID IN ('K07','K02') AND "POSITION" = 'MF';

-- 포지션이 미드필더 이어야 한다
SELECT * FROM PLAYER WHERE "POSITION"='MF';
-- 키는 170 센티미터 이상이고 180 이하여야 한다
-- 이상 이하 : 자신을 포함  A >= 170
-- 미만 초과 : 자신을 포함 하지 않음  A>170
-- 컬럼 BETWEEN A AND B :  포함
    
SELECT * 
    FROM PLAYER
        WHERE HEIGHT >=170 AND HEIGHT <=180; -- 259명
        
SELECT * 
    FROM PLAYER
        WHERE HEIGHT <180 AND HEIGHT >170; -- 204명
SELECT *
    FROM PLAYER
        WHERE HEIGHT BETWEEN 170 AND 180; -- 이상 이하 와 같다
    
SELECT *
    FROM PLAYER
        WHERE NOT (HEIGHT BETWEEN 180 AND 170);
SELECT * FROM PLAYER;
--- ** 212 PAGE 
-- CHAR와 VHARCHAR2
-- CHAR(3)   'AA'  CHAR(5)'    A'
-- 이름, 포지션, 백넘버
-- 소속팀이 삼성 블루윙즈이거나 전남드래곤즈에 소속된 선수들이어야 하고
-- 포지션이 미드필어 이어야 한다
-- 키는 170 센티미터 이상이고 180 이하여야 한다
SELECT PLAYER_NAME, "POSITION", BACK_NO 
    FROM PLAYER
        WHERE (TEAM_ID = 'K02' OR TEAM_ID = 'K07')
                AND "POSITION" = 'MF'
                AND HEIGHT >=170 AND HEIGHT <=180;
SELECT PLAYER_NAME, "POSITION", BACK_NO 
    FROM PLAYER
        WHERE TEAM_ID IN ('K02','K07')
                    AND "POSITION" = 'MF'
                    AND HEIGHT BETWEEN 170 AND 180;
--- NULL, LIKE, IN 
-- NULL 비교연산(크다 작다) FALSE
-- NULL  연산(+) 결과 NULL 
SELECT PLAYER_ID, NICKNAME, BACK_NO FROM PLAYER;
SELECT NICKNAME + BACK_NO FROM PLAYER;
-- CONCATENATION은 NULL 없는값 으로 처리
SELECT PLAYER_ID || NICKNAME FROM PLAYER;
-- LIKE 포함된 문자열의 값을 찾음
-- % : 모든 것 , _ 한칸
-- '%A' : A로 끝나는 모든 값 (FDSAFDA,ASFA, WF4A)
-- '_A' : A로 끝나고 두자리인 값(AA, 2A, 5A)
 SELECT * FROM PLAYER WHERE PLAYER_NAME LIKE '김%';
 SELECT * FROM PLAYER WHERE PLAYER_NAME LIKE '김_';
-- IN 절
-- 사원테이블에서 JOB = MAMAGER AND DEPTNO = 20 이거나
--               JOB = CLERK AND DEPTNO 30   
SELECT * FROM EMP
    WHERE JOB = 'MANAGER' AND DEPTNO = '20';                
SELECT * FROM EMP
    WHERE JOB = 'CLERK' AND DEPTNO = '30';
SELECT * 
    FROM EMP
        WHERE (JOB = 'MANAGER'AND DEPTNO = '20')
            OR (JOB = 'CLERK' AND DEPTNO = '30');
        
SELECT * FROM EMP
    WHERE (JOB, DEPTNO) IN (('MANAGER','20') ,('CLERK','30') );
                
                
                
        
                
                
rem  DROP TABLES
DROP TABLE EMP;
DROP TABLE DEPT;
rem  create TABLES
CREATE TABLE DEPT
        (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
         DNAME VARCHAR2(14),
     LOC   VARCHAR2(13) ) ;
CREATE TABLE EMP
        (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
     ENAME VARCHAR2(10),
      JOB   VARCHAR2(9),
     MGR   NUMBER(4),
     HIREDATE DATE,
     SAL   NUMBER(7,2),
     COMM  NUMBER(7,2),
     DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
rem  insert DEPT 4 data
INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');
rem  insert EMP  14 data
INSERT INTO EMP  VALUES (7369,'SMITH','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'), 800,NULL,20);
INSERT INTO EMP  VALUES (7499,'ALLEN','SALESMAN', 7698,to_date('20-2-1981', 'dd-mm-yyyy'),1600,300, 30);
INSERT INTO EMP  VALUES (7521,'WARD','SALESMAN',  7698,to_date('22-2-1981', 'dd-mm-yyyy'),1250,500, 30);
INSERT INTO EMP  VALUES (7566,'JONES','MANAGER',  7839,to_date('2-4-1981',  'dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP  VALUES (7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981', 'dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP  VALUES (7698,'BLAKE','MANAGER',  7839,to_date('1-5-1981',  'dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP  VALUES (7782,'CLARK','MANAGER',  7839,to_date('9-6-1981',  'dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP  VALUES (7788,'SCOTT','ANALYST',  7566,to_date('13-07-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP  VALUES (7839,'KING','PRESIDENT', NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP  VALUES (7844,'TURNER','SALESMAN',7698,to_date('8-9-1981',  'dd-mm-yyyy'),1500,0,   30);
INSERT INTO EMP  VALUES (7876,'ADAMS','CLERK',    7788,to_date('13-07-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMP  VALUES (7900,'JAMES','CLERK',    7698,to_date('3-12-1981', 'dd-mm-yyyy'), 950,NULL,30);
INSERT INTO EMP  VALUES (7902,'FORD','ANALYST',   7566,to_date('3-12-1981', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP  VALUES (7934,'MILLER','CLERK',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300,NULL,10);
COMMIT;
SELECT * FROM EMP;
-- 2019.01.23
-- DK, BI 시스템? 
-- 테이블, 엔티티 엔티티가 저장되는 곳이 테이블 DBF(DATA BASE FILE)
-- 피터첸, 아이크로스, 바커
-- 모델링의 목적 : 주제가 선정되면 그 안에 정보를 모으기위해서
-- 구조화된 것들을 
-- ROW, COL, FILED(타입, 도메인, 크기??)
-- 아주 복잡한 자료도 테이블은 하나만 만드는 것이 바람직하다.(입력, 수정, 삭제, 조회) > 이거 틀린보기
-- 금융권은 디비가 다 함께 되어있음. 입출력 정보는 따로지만,, JOIN을 하지 않음
-- 속도가 중요하고 트랜젝션걸릴까봐,, 
-- 식별자
-- 1인지 char의 1인지 몰라 컴퓨터는 > 그래서 식별자에 숫자가 먼저 나올 수 없음
-- 특수문자 디비(오라클)에서는 _ $ #
-- DML : INSERT, UPDATE, DELETE, SELECT
-- DDL : ALTER, CREATE, DROP
-- DCL : COMMIT, ROLLBACK, REVOKE, GRANT
-- COMMIT은 영구적인 변경임
-- ACID : 원자성(ATOMIC), 지속성(CONSISTENCY), 독립성(ISOLATION), 영속성(DURABILITY)
-- STDDEV : 표준편차
-- 조건을 처리하는 친구들 : WHERE, HAVING, ON

-- JOIN EQJOIN NON-EQJOIN
-- JOIN (BI 개발 DW 개발에서는 없음 100% 관계형 데이터 베이스시스템에서 발생)
-- -> 정규화(테이블 편리하게 만듦 : 1차 ~ 5차 정규화까지 있음
-- -> 이상현상 제거(수정,삽입,삭제)
-- 예전엔 생년월일과 나이가 따로 저장돼있어서 따로 수정해줘야했었음.
-- -> 무결성 제약조건 디게 중요행(CONSTRAINT : PK, FK, CHECK, NOT NULL 등)
-- -> 일관성, 중복성을 위해서 사용함
-- -> LAST!! 입력, 수정, 삭제의 성능을 향상시키키위해서 만들어짐
-- 붙여서 가져와야한다는 단점이 있음 그래서 SELECT 할 때는 테이블이 너무 많이 쪼개져 있으면 느림
-- 역정규화를 하든지, INDEX를(풀스캔 안하려고) 생성하든지, 옵티마이저(최적화)를 함 <= DBA가 하는일
-- 옵티마이저 튜닝의 기본, 최적화 THINK) 겨울 옷 정리 : CBO(COST BASE OPTIMIZER), RBO(RULE BASE)
-- 테이블 만들려면 식별자가 필수
-- RBO는 예전에 많이 사용, 최근에는 대부분 CBO
-- 등가조인 EQJOIN(1:1) : A라는 곳의 pk와 B라고 하는 fk를 가지고 1:1로 조인을 하겠다.
-- 비등가조인(1:1이 아닌 범위) : 테이블들간의 관곈 필요없다.
-- 사원정보테이블 (EMP), 부서테이블(DEPT)
SELECT * FROM EMP; -- DEPTNO가 부서번호임
SELECT * FROM DEPT; 
-- 질문 ) 사원들의 부서명과 지역을 알고 싶다.
-- 조건 :  부서명이 ACCOUNTING인 팀을 보고싶다.
-- FROM절 사용 조인방법
SELECT  EMPNO, ENAME, E.DEPTNO, DNAME, LOC--AMBIOUS COLUME DEPTNO 가져올때 명확히 안 해주면,
    FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO -- 카티시안 프로덕트 나열 방식 : 조인이 될 수 있는 모든 조건을 출력
        AND DNAME = 'ACCOUNTING';
        
-- ANSI 표준 조인방법
SELECT  EMPNO, ENAME, E.DEPTNO, DNAME, LOC
    FROM EMP E  JOIN DEPT D -- FROM절에서는 여기까지 하면 카티전프로덕트 발생하는데
    --안시 표준에서는 발생 안함 그래서 얘의 원래이름은 이너조인
    ON E.DEPTNO = D.DEPTNO
    WHERE DNAME = 'ACCOUNTING';    
-- 조건절중에서 연속으로 붙일 수 있는애는 WHERE과 HAVING 뿐입니다.
-- ON절은 연속으로 붙일 수 없기 때문에 WHERE을 써서 조건을 붙여줍니다.
-- EMPLOYEES, DEPARTMENT 테이블 사용할 거임
-- 조회 ) 사원 ID, 성, 이름, 부서 코드, 부서 이름 출력을 원함
-- 조건 1 - 위에서 사용한 이름으로 컬럼명을 ALIAS 처리
-- 조건 2 - 성, 이름 : CONCAT 해서 출력

-- FROM절 활용
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, E.DEPARTMENT_ID, DEPARTMENT_NAME
    FROM EMPLOYEES E, DEPARTMENTS D
    WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- ANSI 표준
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, E.DEPARTMENT_ID, DEPARTMENT_NAME
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON  E.DEPARTMENT_ID = D.DEPARTMENT_ID;
    
--------------
SELECT EMPLOYEE_ID 사원ID, CONCAT(FIRST_NAME , LAST_NAME) "성 이름",
    E.DEPARTMENT_ID 부서코드, DEPARTMENT_NAME 부서이름
    FROM EMPLOYEES E, DEPARTMENTS D;
SELECT EMPLOYEE_ID 사원ID, CONCAT(FIRST_NAME , LAST_NAME) "성 이름",
    E.DEPARTMENT_ID 부서코드, DEPARTMENT_NAME 부서이름
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- 계층형 쿼리 : 손으로 작성해가면서 공부하기(오라클에서만 사용하는데 그냥 시험용)
-- 비등가 조인 : 연관관계가 없구(FK 관계가 아님), 범위
-- 사원테이블(EMP)의 급여를 700 ~ 1000 이면 1(등급), 1001 ~ 3000 2, 2001 ~ 3000 3
-- 3001 ~ 9999 4
CREATE TABLE SAL_GRADE(
    GRADE NUMBER(1),
    LOSAL NUMBER,
    HISAL NUMBER
);
INSERT INTO SAL_GRADE VALUES (1,700, 1000);
INSERT INTO SAL_GRADE VALUES (2,1001,2000);
INSERT INTO SAL_GRADE VALUES (3,2001,3000);
INSERT INTO SAL_GRADE VALUES (4,3001,9999);
SELECT * FROM SAL_GRADE;

SELECT EMPNO, SAL, GRADE
    FROM EMP, SAL_GRADE
        WHERE SAL BETWEEN LOSAL AND HISAL;
        
SELECT EMPNO, SAL, GRADE
    FROM EMP JOIN SAL_GRADE
        ON SAL BETWEEN LOSAL AND HISAL;
        
-- 스케줄 테이블에서 스타디음 이름과 팀이름을 알고 싶다. 
-- ON절 혹은 WHERE절에서 제어
-- 데이터의 흐름은 한 방향으로 가야 문제가 없다. 꼬여 있으면 정규화에 문제가 있는것이다.
-- THINK ) 구매 목록 - 옥션 - 송장번호 / 구매 목록 - 송장 번호
            
-- 3중 조인 선생님 풀이
-- 순서대로 생각해요. (작은 것 부터 하는게 조건이 줄어들어서 좋다)
-- SCHEDULE(STADIUM_ID) - STADIUM -> STADIUM_NAME
-- SCHEDULE(HOMETEAM_ID) - TEAM -> TEAM_NAME
-- SCHEDULE(AWAYTEAM_ID) - TEAM -> TEAM_NAME
            
SELECT S.STADIUM_ID, ST.STADIUM_NAME,
        S.HOMETEAM_ID, HT.TEAM_NAME,
        S.AWAYTEAM_ID, "AT".TEAM_NAME
    FROM SCHEDULE S, STADIUM ST, TEAM HT, TEAM "AT"
        WHERE S.STADIUM_ID = ST.STADIUM_ID
            AND S.HOMETEAM_ID =HT.TEAM_ID
            AND S.AWAYTEAM_ID = "AT".TEAM_ID;
            
-- --> ANSI 표준으로 보면 되게 쉽다.
SELECT S.HOMETEAM_ID, HT.TEAM_NAME,
          S.AWAYTEAM_ID, "AT".TEAM_NAME,
          S.STADIUM_ID, ST.STADIUM_NAME
    FROM SCHEDULE S JOIN TEAM HT
                                ON S.HOMETEAM_ID =HT.TEAM_ID
                             JOIN TEAM "AT"
                                ON S.AWAYTEAM_ID = "AT".TEAM_ID
                             JOIN STADIUM ST
                                ON S.STADIUM_ID = ST.STADIUM_ID;

-- 20190124
-- < JOIN의 종류 >
-- 하나만 딱 보면 됩니다아아
-- INNER JOIN 교재 302page = STANDARD JOIN(표준 조인)
-- INNER JOIN ON 조건
-- NATURAL JOIN : 자동으로 같은 이름의 컬럼 같은 타입이라면 자동으로 맞춰줌
-- CROSS JOIN : 발생될 수 있는 모든 조인 조건에 대한 조인 성립
--                      CARTESIAN PRODUCT
-- OUTER JOIN : LEFT OUTER JOIN
--                      RIGHT OUTER JOIN
--                       FULL OUTER JOIN
                                
-- ** ON절
-- ** USING절
SELECT * FROM RAINBOW;                    
-- 사원테이블과 부서테이블을 JOIN해서 부서명을 알고 싶다.
SELECT E.EMPNO, E.ENAME, D.DNAME
    FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO;
-- INNER JOIN : ON절 사용
-- JOIN절에선 카테시안 프로덕트가 일어나지 않음
-- 반드시 ON이 있어야함.
SELECT E.EMPNO, E.ENAME, D.DNAME
    FROM EMP E INNER JOIN DEPT D
        ON E.DEPTNO = D.DEPTNO;
-- INNER JOIN : USING절 사용
-- 같은 컬럼의 이름과 같은 컬럼을 합쳐줌
-- 중복되는 컬럼을 맨 앞으로 출력됨
-- 주의점 : 컬럼 이름과 타입이 모두 같아야함
SELECT *
    FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO;
                     
SELECT *
    FROM EMP E INNER JOIN DEPT D
         USING (DEPTNO);
         
-- NATURAL JOIN
-- 두 개의 (선행 후행) 테이블을 자동 검색하여 USING 조건에 맞는 컬럼이 있다면 모두 JOIN
SELECT *
    FROM EMP E NATURAL JOIN DEPT D;
-- WHERE EMP.DEPTNO = DEPT.DEPTNO
-- ON EMP.DEPTNO = DEPT.DEPTNO
-- USING (DEPT)
-- NATURAL 조인은 자동으로 USING
-- CTAS라는 문법사용할 거야
-- CTAS : 테스트 테이블을 사용할 때
-- 스키마 값은 같고, 제약조건은 없이 테이블을 복사
-- CREATE TABLE AS SELECT;
CREATE TABLE DEPT_COPY AS SELECT * FROM DEPT;
DROP TABLE DEPT_COPY;
         
UPDATE DEPT_COPY
SET DEPTNO= DEPTNO + 10;

     10    ACCOUNTING    NEW YORK
20    RESEARCH    DALLAS
30    SALES    CHICAGO
40    OPERATIONS    BOSTON

SELECT *
    FROM DEPT D JOIN DEPT_COPY DC
        ON D.DEPTNO = DC.DEPTNO;
    
SELECT *
    FROM DEPT D JOIN DEPT_COPY DC
        USING (DEPTNO);
    
SELECT *
    FROM DEPT D JOIN DEPT_COPY DC
        ON D.DNAME = DC.DNAME AND
            D.LOC = DC.LOC;
        
SELECT *
    FROM DEPT D JOIN DEPT_COPY DC
        USING (DNAME, LOC);
    
SELECT *
    FROM DEPT D NATURAL JOIN DEPT_COPY DC;
CREATE TABLE RAINBOW(
NAME VARCHAR2(10), --  가변길이 10 
AGE NUMBER(3), -- 숫자 3자리  
BIRTHDAY DATE, --  날짜
GENDER CHAR(2) -- 고정 자리
);
-- 컬럼 정의 방식 : NAME VARCHAR2(2) NOT NULL
-- 테이블 정의 방식 : CREATE TABLE 테이블명(~~~~
--CONSTRAINT RAINBOW_PK PRIMARY KEY (NAME)); 
-- 20190115
CREATE TABLE CLOUD (
 ID VARCHAR2(20),
 STATUS CHAR(2),
 ETC VARCHAR2(500)
);
DELETE FROM DEPT_COPY;
    
INSERT INTO HR.DEPT_COPY
(DEPTNO, DNAME, LOC)
VALUES(20, 'AA', '가');
INSERT INTO HR.DEPT_COPY
(DEPTNO, DNAME, LOC)
VALUES(30, 'BB', '나');
INSERT INTO HR.DEPT_COPY
(DEPTNO, DNAME, LOC)
VALUES(40, 'CC', '다');
INSERT INTO HR.DEPT_COPY
(DEPTNO, DNAME, LOC)
VALUES(50, 'DD', '라');
SELECT * FROM DEPT_COPY;
SELECT LOC, DNAME, DEPTNO FROM DEPT;
    FROM DEPT D JOIN DEPT_COPY DC
        ON D.DEPTNO = DC.DEPTNO;
-- LEFT OUTER JOIN
SELECT D.LOC, D.DNAME, D.DEPTNO, DC.*
    FROM DEPT D LEFT OUTER JOIN DEPT_COPY DC -- OUTER 안써도 됨
        ON D.DEPTNO = DC.DEPTNO;
-- FROM절을 이용해서 LEFT OUTER JOIN할 때는 옮겨오는 애한테 표시
SELECT D.LOC, D.DNAME, D.DEPTNO, DC.*
    FROM DEPT D, DEPT_COPY DC
        WHERE D.DEPTNO = DC.DEPTNO(+);
    
-- RIGHT OUTER JOIN
SELECT D.LOC, D.DNAME, D.DEPTNO, DC.*
    FROM DEPT D RIGHT JOIN DEPT_COPY DC
        ON D.DEPTNO = DC.DEPTNO;
SELECT D.LOC, D.DNAME, D.DEPTNO, DC.*
    FROM DEPT D, DEPT_COPY DC
        WHERE D.DEPTNO(+) = DC.DEPTNO;
    
-- JOIN
SELECT *
    FROM DEPT D CROSS JOIN DEPT_COPY DC;
    
-- 3중 조인
-- 홈팀이 3점이상 차이로 승리한 경기의
-- 경기장이름, 경기 일정, 홈팀 이름, 원정팀 이름 출력
SELECT STADIUM_NAME, SCHE_DATE, HT.TEAM_NAME, "AT".TEAM_NAME,
    S.HOME_SCORE, AWAY_SCORE
    FROM SCHEDULE S JOIN STADIUM ST
                                ON S.STADIUM_ID = ST.STADIUM_ID
                              JOIN TEAM HT
                                 ON HT.TEAM_ID = S.HOMETEAM_ID
                              JOIN TEAM "AT"
                                  ON "AT".TEAM_ID = S.AWAYTEAM_ID
    WHERE HOME_SCORE >= AWAY_SCORE + 3
    
-- SET OPERATION (집합연산자)
-- 교집합, 차집합
-- UNION, UNION ALL, INTERSECT
    
-- 오늘의 문제!!! )
-- 1) K-리그 소속 선수들 중에서 삼성 블루윙즈(K02) 선수들과
--     전남드래곤즈 선수들에 대한 내용을 모두 보고 싶다.
SELECT *
    FROM PLAYER
        WHERE TEAM_ID IN ('K02', 'K07')
        ORDER BY TEAM_ID;
        
-- K02 선수들 + K07 선수들
-- UNION에서는 각각 SQL 문장에선 ORDER BY를 사용할 수 없다.
-- UNION의 컬럼 각각의 SELECT 절의 갯수와 타입이 같아야 한다.
-- 표현되는 컬럼은 선행된 결과의 컬럼을 따라간다.
-- 상반기 하반기 교육들었던 애들, 합칠 때
-- 곁다리 걸친 애들 때문에 테이블 따로 쪼개서 UNION 사용함    
    
SELECT PLAYER_ID 아이디, PLAYER_NAME, TEAM_ID
    FROM PLAYER
        WHERE TEAM_ID = 'K02'
--            ORDER BY 1 UNION은 ORDER BY를 넣을 수 없다.    
UNION
--SELECT *
SELECT "POSITION" 포지션, PLAYER_NAME, PLAYER_ID
    FROM PLAYER
        WHERE TEAM_ID = 'K07';
            ORDER BY 3;
-- 2) K - 리그 소속 선수들 중에서 소속이 삼성블루윈즈팀인 선수들과
-- 포지션이 골키퍼인 선수들을 모두 보고싶다.
-- 삼성블루윙즈이면서 골키퍼 -- 2007035, 067, 203 2009004
SELECT *
    FROM     PLAYER
        WHERE TEAM_ID = 'K02'
            AND
        "POSITION" = 'GK';
    
-- 삼성블루윙즈 선수 : 49명
SELECT *
    FROM PLAYER
        WHERE TEAM_ID = 'K02';
-- 골키퍼    : 43명
SELECT *
    FROM PLAYER
        WHERE "POSITION" = 'GK';
    
-- UNION은 서로 같은 결과에 대해서는 중복으로 처리한다.
-- 따라서 K02 49 + GK 43 = 92명이 아니라
-- K02이면서, GK인 4명을 제외한 88이 조회된다.
                    
SELECT *
    FROM PLAYER
        WHERE TEAM_ID = 'K02'
UNION
SELECT *
    FROM PLAYER
        WHERE "POSITION" = 'GK'; -- 88명
--    WHERE  컬럼명을 필요로함
-- UNION은 그게 불가해 ORDER BY만 됌 > 회사에서는 INLINE VIEW를 사용
        
-- UNION ALL은 단순히 결과를 부어서 표현함
-- K리그 소속 선수들 중에서 소속이 K02이면서 포지션이 MF가 아닌
선수들의 정보를 보고싶다.
SELECT *
    FROM PLAYER
        WHERE TEAM_ID = 'K02'
            AND "POSITION" ^= 'MF';

SELECT *
    FROM (SELECT *
                FROM PLAYER
                WHERE TEAM_ID = 'K02'
        UNION ALL
        SELECT *
            FROM PLAYER
                WHERE "POSITION" = 'GK')
   WHERE PLAYER_ID IN(2007035, 2007067, 2007203, 2009004) ;

-- 20190125
-- UNION, UNIALL
-- UNION : SQL문 두개를 같은 컬럼의 갯수와 타입으로 묶는다.
--  			ORDER BY는 마지막에 한 번
-- 컬럼명은 선행 SQL문의 컬럼명으로 따라감
-- 중복은 하나로 나옴
-- K02인 선수들과 GK를 보고싶다. 88명 ->K02이면서 GK 4명
-- UNION ALL
-- SQL문 두개를 중복 생각 없이 그냥 붙임.
-- K02인 선수들과 GK를 보고싶다. 92명 ->K02이면서 GK 4명 포함

-- 실습)   -- 나와 선임의 소스코드 스타일이 다를때,, 좀.. 맞추자..

-- K리그 소속 선수들에 대한 정보중에서 포지션별 평균키와 팀별 평균키를 알고싶다.
-- UNION이 아니면 풀 수 없는 문제

SELECT "POSITION", AVG(HEIGHT)
	FROM PLAYER
		WHERE "POSITION" IS NOT NULL
		GROUP BY "POSITION"
	UNION
SELECT TEAM_ID, AVG(HEIGHT)
	FROM PLAYER
		GROUP BY TEAM_ID;
		
	
SELECT 'PO' 구분코드, "POSITION", AVG(HEIGHT)
	FROM PLAYER
		WHERE "POSITION" IS NOT NULL
		GROUP BY "POSITION"
	UNION
SELECT 'TEM' TEST, TEAM_ID, AVG(HEIGHT)
	FROM PLAYER
		GROUP BY TEAM_ID;
		
--MINUS // 다른데에서는 EXCEPT -- 퍼포먼스 좋음 근데 회사에서 잘 안쓴데.. 왜?

-- 문제 4번 K-리그 소속 선수들 중에서 소속이 삼성 블루윙즈팀이면서 포지션이 MF가 아닌
-- 선수들의 정보를 보고싶다.

SELECT *
	FROM PLAYER
		WHERE TEAM_ID = 'K02' AND "POSITION" <> 'MF';
	
SELECT *
	FROM PLAYER
		WHERE TEAM_ID = 'K02' --K02 FW, MF, GK, DF
MINUS
SELECT *
	FROM PLAYER
		WHERE "POSITION" = 'MF';
	
-- 갱장히 어려운 문법 340, 연관서브쿼리 ROWNUM
-- ***************************************************
-- 연관서브쿼리
-- FROM 절에 테이블의 정제해서 사용하는 IN LINE VIEW
-- SELECT WHERE 절에 사용되는 SCALA SUBQUERY

	
-- EX-1 )
	SELECT *
		FROM (SELECT TO_CHAR(HIREDATE, 'YYYY-MM-DD') HDATE
			FROM EMP);
			
--EX-2 ) 선수들의 선수들의 전체 평균키보다 큰 선수 조회.
	SELECT * FROM PLAYER
		WHERE HEIGHT > (SELECT AVG(HEIGHT) FROM PLAYER);
		
	
-- K02 인데  MF는 빼고
SELECT *
	FROM PLAYER P1
		WHERE TEAM_ID = 'K02'
			AND NOT EXISTS(SELECT 12345678910 -- 존재여부를 나타냄
										FROM PLAYER P2
											WHERE P1.PLAYER_ID =P2.PLAYER_ID
												AND "POSITION" = 'MF');

-- 5문제)
-- K - 리그 소속 중에서 삼성블루윙즈팀이면서
-- 포지션이 (GK)인 선수들 --> 4명
										
SELECT *
	FROM PLAYER
		WHERE TEAM_ID = 'K02' AND "POSITION" = 'GK';

-- 위와 같은 집합	
SELECT *
	FROM PLAYER
		WHERE TEAM_ID = 'K02'
INTERSECT
SELECT *
	FROM PLAYER
		WHERE "POSITION" = 'GK';
		
SELECT *
	FROM PLAYER P1
		WHERE TEAM_ID = 'K02'
			AND EXISTS(SELECT 'D'
									FROM PLAYER P2
											WHERE P1.PLAYER_ID = P2.PLAYER_ID
											AND "POSITION" = 'GK');
											
-- 계층형 쿼리 : 나 - 팀장 - 인사과 - 재경팀 ..... 이렇게 결제 받을 때처럼... 사용함... 그룹웨어, PDM(물류관리시스템)
-- HIERARCHY 순환 쿼리

-- SELECT * FROM EMP 가끔은 이렇게 묶어놓기도 함..

-- CONNECT BY를 외우면 돼

-- DB관리 도구 SQLGATE, TOAD -> 퍼포먼스가 좋음
					
-- 형상관리도구 SVN, GITHUB, 프로젝트관리도구 MAVEN, GRADLE, JENKINS, WAS
										
CREATE TABLE TEST01(
	EMP VARCHAR2(10),
	MGR VARCHAR2(10)
);

INSERT INTO TEST01 VALUES ('A',NULL);
INSERT INTO TEST01 VALUES ('B','A');
INSERT INTO TEST01 VALUES ('C','A');
INSERT INTO TEST01 VALUES ('D','C');
INSERT INTO TEST01 VALUES ('E','C');

INSERT INTO TEST01 VALUES ('A',NULL);

INSERT INTO TEST01 VALUES ('A', NULL);


SELECT COUNT(*) FROM TEST01;

-- 계층형 질의
-- 문법 START WITH CONNECT BY PRIOR;
-- 옵션 : LEVEL 1 -> 2
-- 			CONNECT_BY_ISLEAF 끝에 찾는거
-- CYCLE?? 외우지마센

-- 순차방향 위 -> 아래로
SELECT * FROM TEST01;

SELECT LEVEL
	FROM TEST01;

DROP TABLE TEST02;

CREATE TABLE TEST02(
EMP VARCHAR(10),
MGR VARCHAR(10)
)

INSERT INTO TEST02 VALUES('A', NULL);
INSERT INTO TEST02 VALUES('B', 'A');
INSERT INTO TEST02 VALUES('C', 'A');
INSERT INTO TEST02 VALUES('D', 'C');
INSERT INTO TEST02 VALUES('E', 'C');



SELECT *
	FROM TEST02
	START WITH MGR IS NULL --<-- NULL인 값의 사원이 최상위
	CONNECT BY PRIOR EMP = 'MGR';

SELECT LEVEL, EMP, MGR,
	LPAD(' ', 4*(LEVEL-1))||EMP,
	CONNECT_BY_ISLEAF
FROM TEST02
	START WITH MGR IS NULL --<-- NULL인 값의 사원이 최상위
	CONNECT BY MGR = PRIOR 'MGR'; -- PRIOR EMP 이거랑 = PRIOR이랑 별관엄..
	
-- 역방향 쿼리,, 상사들 찾을 때 사용
SELECT *
	FROM TEST01
		START WITH EMP = 'E'
		CONNECT BY PRIOR MGR = EMP;
		
SELECT *
	FROM TEST01
		START WITH EMP = 'E'
		CONNECT BY PRIOR MGR = EMP;

SELECT LEVEL, EMP, MGR,
	LPAD(' ', 4*(LEVEL-1))||EMP,
	CONNECT_BY_ISLEAF
FROM TEST02
	START WITH EMP = 'E' --<-- NULL인 값의 사원이 최상위
	CONNECT BY PRIOR MGR =  'EMP'; -- PRIOR EMP 이거랑 = PRIOR이랑 별관엄..

	
-- 추적 데이터를 만들자 SYS_CONNCT_BY_PATH
-- CONNECT_BY_ROOT
 
-- SYSOUT과 유사함!!!

 SELECT LEVEL, CONNECTI.BY_ROOT 
 	SYSY_CONNECT_BY_PATH(EMP,'>')	
 FROM TEST01
 	START WITH
 	CONNECT BY MGR IS NULL;
	
 -- 190128
 ------- 355
 -- sub 쿼리 : main 안에 sub 쿼리 (sql문이 추가로 있는 것)
 -- 서브쿼리는 두가지 방법으로 나뉨
 -- 스칼라, 인라인 뷰(from절에만 사용)
 
 -- 연관서브쿼리와 비연관서브쿼리가 있는데 대부분은 비연관서브쿼리
 -- 연관서브쿼리 (main 쿼리에 있는 row와 관계 : exists)
 -- 비연관서브쿼리(단독으로 값을 표출)
 
-- 단일 값을 Single row, 다중 multi row



-- 연관서브쿼리
-- MAIN 쿼리의 ROW를 SUB 쿼리에서 사용하는 것
-- 자신이 속한 팀의 평균키보다 큰 선수들을 조회해 주세요
-- 짱 좋은 예시
SELECT *
	FROM PLAYER P1
		WHERE P1.HEIGHT > (SELECT AVG(HEIGHT)
										FROM PLAYER P2
											WHERE P1.TEAM_ID = P2.TEAM_ID);
										
-- 자신이 속한 팀!!!! 어려워
-- 연관서브쿼리를 사용하자!!!

-- EXISTS

--  갱장히 좋은 예시에요
SELECT *
	FROM STADIUM; -- STADIUM  정보

SELECT *
	FROM SCHEDULE; -- STATIUM 의 경기일정
	
-- 경기장 중 경기 일정이 20120501 부터 20120502 사이에 있는 경기장을 알고싶다.
 SELECT STADIUM_ID
 	FROM SCHEDULE
 		WHERE SCHE_DATE BETWEEN '20120501' AND '20120502';
 		
 SELECT *
	FROM STADIUM S1
		WHERE EXISTS( SELECT 'DDDD' FROM SCHEDULE S2
								WHERE S1.STADIUM_ID= S2.STADIUM_ID
								AND S2.SCHE_DATE BETWEEN '20120501' AND '20120502');
							
-- 선수들의 정보를 출력하는데 축구 선수의 평균키를 같이 출력하고 싶다. > 단일과 여러 항목의 조화 ㅋ 서브쿼리를 쓰면 좋아
SELECT (SELECT AVG(HEIGHT) FROM PLAYER), P.*
	FROM PLAYER P;

-- 선수들 중 BMI 지수를 계산하여 25 이상을 출력하고 싶다.
-- 체중(kg)/신장(m) 나누기 신장(m)
SELECT (WEIGHT/(HEIGHT*HEIGHT) * 10000), P.*
	FROM PLAYER P
		WHERE (WEIGHT/(HEIGHT*HEIGHT) * 10000) > 25 -- 지저분해

-- 인라인 뷰의 장점 : ORDER BY 사용 할 수 있음
-- 코드의 간결성 및 계산의 중복을 피함
SELECT *
	FROM (SELECT (WEIGHT/(HEIGHT*HEIGHT) * 10000) BMI, P.*
					FROM PLAYER P)
	WHERE BMI > 25;	

-- 인라인 뷰의 장점 : ORDER BY 사용 할 수 있음	
-- 사원 테이블에서 SAL이 높은 상위 5명을 출력하고 싶다.
-- ORDER BY 는 가장 마지막에 실행되는 놈 > SELECT 절 다음
SELECT ROWNUM, A.*
	FROM (SELECT * FROM EMP
				ORDER BY SAL DESC) A
	WHERE ROWNUM <= 5; -- ROWNUM은 큰거는 안됨. 1번이 있어야 2번이 있는거다
	
-- 	팀별 평균키가 전체 선수의 평균 키보다 큰 팀의 팀 아이디와 팀이름과 평균키를 알고싶다.
SELECT TEAM_ID, AVG(HEIGHT), TEAM_NAME
	FROM PLAYER JOIN TEAM
		USING (TEAM_ID)
		GROUP BY TEAM_ID, TEAM_NAME
			HAVING AVG(HEIGHT) > (SELECT AVG(HEIGHT) FROM PLAYER);
		
-- INNER, LEFT OUTER, RIGHT OUTER, FULL OUTER, 등등

-- UPDATE, INSERT
-- 연관서브쿼리
-- 367page 반정규화
-- team 테이블 stadium_id에 맞는 stadium_name을 생성하고 
-- stadium에서 이름을 검색해서 각가에 맞는 이름을 넣어주세요.

ALTER TABLE TEAM ADD (STADIUM_NAME VARCHAR2(40)); -- DDL이라서 커밋 필요 없음 수정되면 바로 들어감

-- UPDATE 테이블명 SET 컬럼 = 값 WHERE 조건절
UPDATE TEAM T1 SET T1.STADIUM_NAME = (SELECT STADIUM_NAME
																FROM STADIUM S1
																		WHERE T1.STADIUM_ID = S1.STADIUM_ID); -- 엑셀 VLOOKUP
											
ALTER TABLE TEAM DROP (STADIUM_NAME);

ALTER TABLE TEAM ADD(STATDIUM_NAME VARCHAR2(40));

-- INSERT : 답변형 게시판에서 겁~~~나 마니 사용함
-- ID를 사용하는데 : 자동으로 1씩 증가되게 만들거임
-- 1 -> 2 -> 3 MAX(ID) + 1

--> SEQUENCE 테이블을 생성하는 것 --> 무결성 제약조건
SELECT *
	FROM CLOUD;

DELETE FROM CLOUD;
							
-- 공집합, NULL의 차이, NULL 처리 함수

 -- COUNT는 아무것도 없는 상태에서 증가하지 않음 
 
INSERT INTO CLOUD VALUES (
(SELECT NVL(MAX(ID), 0)+ 1
	FROM CLOUD), 'A', 'BB'
);

SELECT NVL(MAX(ID), 0)+ 1
	FROM CLOUD;
	
-- VIEW : 가상으로 만들어 놓은것
-- 독립성 : 다른 곳에서 변경하지 못하도록
-- 편리성 : RAINBOWVIEW <- SELECT * FROM (SELECT (WEIGHT/(HEIGHT*HEIGHT) * 10000) BMI, P.* FROM PLAYER P) WHERE BMI > 25;	
-- 보안성 : 쿼리가 보이지 않음
SELECT *
	FROM (SELECT (WEIGHT/(HEIGHT*HEIGHT) * 10000) BMI, P.*
					FROM PLAYER P)
	WHERE BMI > 25;	
	
 CREATE VIEW RAINBOWVIEW
 		AS (SELECT (WEIGHT/(HEIGHT*HEIGHT) * 10000) BMI, P.*
					FROM PLAYER P);

				
-- 20190129
-- 370 page
-- GROUP BY 테이블을 어떠한 값에 의해서 묶음으로 만들어주는 것
-- 통계의 정보를 나타내기 위해서  사용함
-- HAVING GROUP BY가 되어있는 집합의 조건을 설정 중요한 거는 !!!
--> HAVING 절 다음에는 WHERE 절이 올 수가 없음
-- DISTINCT 같은 경우에는 조금 애매해여..
-- 묶어버리면 단일값을 알수는 없음..

-- GROUP BY와 반드시 같이 써야하는 옵션!!!! ROLLUP, CUBE, GROUPING

-- 문제 ) 부서명과 업무명을 기준으로 사원수와 급여합
-- ~~*별, 어떠한 (상위)기준, SELECT 집계함수 함수의 결과 (AVG, SUM, MAX)
-- 값에 대한 통계는 ROLLUP CUBE를 이용해서 나타내쟈 UNION을 쉽게
SELECT DNAME, JOB, COUNT(*), SUM(SAL)
	FROM EMP JOIN DEPT
		USING(DEPTNO)
	GROUP BY DNAME, JOB
	ORDER BY 1;

--  그룹으로 묶은 거에서도 합계 알고 싶고
--  JOB으로 묶은 거에서도 합계 알고 싶어..

-- ** 시험에 맨~~~~날 나오심
--  1) DNAME에 대한 합 (ACCOUNT, RESEARCH, SALES)
--  2) DNAME 이면서 JOB에 대한 합(SALES&SALESMAN)
DROP VIEW ENPD;

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT *
	FROM EMP JOIN DEPT
		USING(DEPTNO);

CREATE VIEW EMPD AS (SELECT *
									FROM EMP JOIN DEPT
										USING(DEPTNO));

-- 1)
SELECT DNAME, SUM(SAL)
	FROM EMPD GROUP BY DNAME;

-- 2)
SELECT DNAME, JOB, SUM(SAL)
	FROM EMPD GROUP BY DNAME, JOB;

-- 3)
SELECT SUM(SAL) FROM EMPD;

------------------------------------------------ 구할거 다 구했음 ~~~ 유니온은 칼럼이 맞아야함
SELECT DNAME, JOB, SUM(SAL), COUNT(*) 인원
	FROM EMPD GROUP BY DNAME, JOB
UNION
SELECT DNAME, '부서합', SUM(SAL), COUNT(*)
	FROM EMPD GROUP BY DNAME
UNION
SELECT '전체', '합', SUM(SAL), COUNT(*)
	FROM EMPD;


-- ROLLUP
SELECT DNAME, JOB, SUM(SAL), MGR ,COUNT(*)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
			GROUP BY ROLLUP (DNAME, JOB, MGR);

SELECT DNAME, JOB, SUM(SAL), MGR ,COUNT(*)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
			GROUP BY ROLLUP (DNAME, (JOB, MGR));
		
SELECT DNAME, JOB, SUM(SAL), MGR ,COUNT(*)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
			GROUP BY ROLLUP ((DNAME, JOB), MGR)
ORDER BY 1;		

SELECT DNAME, GROUPING(DNAME), -- 그룹핑 되면 1이라고 표시해줌
		  JOB, GROUPING(JOB),
		  SUM(SAL), COUNT(*)
	FROM EMP E JOIN DEPT D
		ON E.DEPTNO = D.DEPTNO
			GROUP BY ROLLUP (DNAME, JOB); 
			
-- SIMPLE SEARCHED
-- 1. MESSAGE, DNAME | JOB
		
SELECT --DNAME, GROUPING(DNAME), -- 그룹핑 되면 1이라고 표시해줌
		 CASE GROUPING(DNAME) WHEN 1 THEN 'DVALUE' ELSE DNAME END,
		  --JOB, GROUPING(JOB),
		 DECODE(GROUPING(JOB),1,'JVALUE', JOB), -- ORCLE에만 있고 SIMPLE CASE만 됨
		  SUM(SAL), COUNT(*)
	FROM EMP E JOIN DEPT D
		ON E.DEPTNO = D.DEPTNO
			GROUP BY ROLLUP (DNAME, JOB); 
		
-- ROLLUP의 결론 : DNAME + JOB인거 하나, JOB인거 하나, DNAME인거 하나  => 이게 보여주고 시픈 결과들.. 뭔솔..?

-- DNAME에 대한 통계는 필요없다!!!!
SELECT DNAME, JOB, GROUPING(JOB), SUM(SAL), COUNT(*)
	FROM EMP JOIN DEPT
		ON EMP.DEPTNO = DEPT.DEPTNO
			GROUP BY DNAME, ROLLUP(JOB)
			ORDER BY 3;
		
-- ROLLUP에 선언된 컬럼만이 통계를 표출해준다.!!!!!!!!!!

-- ROLLUP에서 넣었던애를 볼 수 있는건 GROUPING 밖에 없음.

-- UNION으로 다시 한 번!!!!!!!!!!!
-- 1) DNAME + JOB
-- 2) DNAME
-- 3) JOB
-- 4) 전체
		
SELECT DNAME, JOB, SUM(SAL), COUNT(*) FROM EMPD GROUP BY DNAME, JOB;
SELECT DNAME      , SUM(SAL), COUNT(* )FROM EMPD GROUP BY DNAME;
SELECT            JOB, SUM(SAL), COUNT(*)	FROM EMPD GROUP BY JOB;
SELECT 					SUM(SAL), COUNT(*) FROM EMPD;

SELECT DNAME, JOB, 	   SUM(SAL), COUNT(*) FROM EMPD GROUP BY DNAME, JOB
UNION
SELECT DNAME, 'ALLJOB',  SUM(SAL), COUNT(*) FROM EMPD GROUP BY DNAME
UNION
SELECT 'ALLD',   JOB,        SUM(SAL), COUNT(*)	FROM EMPD GROUP BY JOB
UNION
SELECT 'ALLD',  'ALLJOB',   SUM(SAL), COUNT(*) FROM EMPD
ORDER BY 1, 2 DESC;

-- GROUPING SET
-- 세부적인 소계를 선택적으로 나타냄
-- DNAME에 대한 소계, JOB에 대한 소계

SELECT * FROM EMPD;

SELECT DNAME, '부서에 묶인 업무' JOB, SUM(SAL), COUNT(*)
	FROM EMPD
		GROUP BY DNAME
UNION
SELECT JOB, '업무에 묶인 부서', SUM(SAL), COUNT(*)
	FROM EMPD
		GROUP BY JOB
	ORDER BY 2;
	

SELECT DNAME, GROUPING(DNAME),SUM(SAL), COUNT(*) -- DNAME에 대한 통계
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
			GROUP BY GROUPING SETS(DNAME);

SELECT DNAME, GROUPING(DNAME),SUM(SAL), COUNT(*), -- DNAME에 대한 통계 JOB에대한 통계가 나옴
		JOB, GROUPING(JOB)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
			GROUP BY GROUPING SETS(DNAME, JOB);		
-- ROLLUP이나 GROUPING SET 을 사용할 때 쓸 수 있는애는 GROUPING
				
-- ROLLUP과의 차이 : ROLLUP은 묶여있는 애(연관성) 있는 애들과의 통계이고
-- GROUPING SET은 각각의 소계이다.
		
SELECT DNAME, GROUPING(DNAME),SUM(SAL), COUNT(*), -- DNAME에 대한 통계 JOB에대한 통계가 나옴
		JOB, GROUPING(JOB)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
			GROUP BY GROUPING SETS(JOB, DNAME); -- GROUPING SET은 순서가 바뀌더라도 관계없음. ROLLUP은 엄청 많이 차이남
			
-- 시험에 가끔씩 나오는데,,,???
-- GROUPING SET인데,,
SELECT DNAME, GROUPING(DNAME),SUM(SAL), COUNT(*), -- DNAME에 대한 통계 JOB에대한 통계가 나옴
		JOB, GROUPING(JOB)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
			GROUP BY GROUPING SETS((JOB, DNAME))
			ORDER BY 1; -- ROLLUP은 사이에 통계정보는 안 보여줌.

-- GROUPING SET(DNAME, JOB) : DNAME 따로 JOB 따로
-- GROUPING SET((DNAME, JOB)) : DNAME 이면서 JOB인 값

			
SELECT DNAME, GROUPING(DNAME),SUM(SAL), COUNT(*), -- DNAME에 대한 통계 JOB에대한 통계가 나옴
		JOB, GROUPING(JOB)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
			GROUP BY GROUPING SETS((JOB, DNAME),JOB,DNAME, (JOB,DNAME,MGR))
			ORDER BY 1; -- ROLLUP은 사이에 통계정보는 안 보여줌.			
			
-- 위에거 얼마나 힘들어 다차원적인 모든 통계정보를 보여주는 것 CUBE			
SELECT DNAME, JOB, SUM(SAL), COUNT(*)
	FROM EMP JOIN DEPT
		USING(DEPTNO)
			GROUP BY CUBE (DNAME, JOB)
			ORDER BY 1;

SELECT DNAME, JOB, SUM(SAL), COUNT(*)
	FROM EMP JOIN DEPT
		USING(DEPTNO)
			GROUP BY DNAME CUBE (JOB)
			ORDER BY 1; -- 롤업하고 그룹바이는 무조건 앞에있는 컬럼을 따라감.
			-- 그룹핑셋이랑, 큐브는 자기가 알아서 다차원적으로 발생시키니까 상관없음.
			
-- 20190130 385page
-- WINDOW 함수 built-IN 함수랑 같은거 빌트인 함수는 안시표준
			
-- PL/SQL 많이 쓰는 것들을 빼낸것이 WINDOW 함수
-- 종류별로 5가지 있는데 구분 안해도 됑
-- 근데 책에서 구분했는데 괜춘해서 나눌게여

-- 첫번째 : 순위 RANK, DENSE_RANK, ROW_NUMBER
			
-- 사원테이블에서 급여에 따라 순위를 보고싶다.
-- IN LINE VIEW를 통해서 데이터를 정제하고 그리고 나가면서
-- 순서를 매겨주는 ROWNUM을 사용해서 숫자  COUNT
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) NUM, EMP.*
	FROM EMP;
	
SELECT ROWNUM, E.*
	FROM (SELECT * 
				FROM EMP
					ORDER BY SAL DESC) E
	WHERE ROWNUM < 6

-- ** PARTITION BY -> WINDOW 함수에서 GROUP BY와 같은 역할을 하는 친구
SELECT RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC), EMP.*
	FROM EMP;
	
SELECT RANK() OVER(ORDER BY SAL DESC), EMP.* -- 숫자 뛰어넘기
	FROM EMP;
	
SELECT DENSE_RANK() OVER(ORDER BY SAL DESC), EMP.*
	FROM EMP;

-- 진짜 어려워서 나오면 패스 할지 선택 해여..
-- 프리센딩 --> 앞과 뒤의...??????? 뭐?
-- WINDOWING 절
-- ROW, RANGE
-- UNBOUNDED FOLLOWING(다음), PRECENDING(이전)	
-- 집계함수(SUM, AVG, MAX, MIN, COUNT) -- 단일 이랑 안합쳐짐
-- 사원 테이블에서 급여와 같은 매니저를 두고 있는 사원들의 SALARY 급여합

SELECT DISTINCT E1.MGR, E1.EMPNO, E1.SAL, E2.CALSUM
	FROM EMP E1, (SELECT MGR, SUM(SAL) CALSUM
						FROM EMP
							WHERE MGR IS NOT NULL
							GROUP BY MGR) E2
	WHERE E1.MGR = E2.MGR
		ORDER BY 1, 2;
	
SELECT MGR, EMPNO, SAL,
	SUM(SAL) OVER(PARTITION BY MGR)
	FROM EMP;

-- 책에서는 0-- RANGE UNBOUNCED PRECEDING <- DEFAULT 설정
-- 값(RANGE)) 범위(UNBOUNDED) 이전까지(PRECENDING)
-- SUM(SAL)  OVER(PARTITION BY MGR RANGE UNBOUNDED PRECEDING) -- 기본이 RANGE UNBOUNDED PRECEDING
-- MGR이 같은 값을 만들고 그 범위에 있는 모든 SAL을 더함

-- 예제 ) 사원들의 급여와 같은 매니저를 가지고 있는 사원들의 급여중 최대
SELECT EMPNO, SAL, 
	MAX(SAL) OVER(PARTITION BY MGR)
 		FROM EMP;

-- 예제)  사원들의 급여
-- 			같은 MGR
--			입사일자를 기준으로 정렬
-- 			SAL의 최소값
SELECT DEPTNO, ENAME, HIREDATE, SAL,
	MIN(SAL) OVER(PARTITION BY MGR)
 		FROM EMP
			ORDER BY HIREDATE;
			
		
-- 예제 ) 사원 테이블에서 같은 MGR
--			평균을 구하는 MGR이 같은 조건에서 자신의 ROW 앞 뒤 1개의 평균
SELECT SAL, MGR, EMPNO, HIREDATE,
	AVG(SAL) OVER(PARTITION BY MGR ORDER BY HIREDATE
							ROWS UNBOUNDED PRECEDING) A
FROM EMP;
--  위와 같음
SELECT SAL, MGR, EMPNO, HIREDATE,
	AVG(SAL) OVER(PARTITION BY MGR ORDER BY HIREDATE) A
FROM EMP;

-- PPT에 그림 있음
SELECT SAL, MGR, EMPNO, HIREDATE,
	AVG(SAL) OVER(PARTITION BY MGR ORDER BY HIREDATE
							ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) A
	FROM EMP;
	
-- 예제 ) 사원을 급여 기준으로 정렬
-- 본인의 급여보다 50이하 적거나 150 이상 받는 인원을 구하라

SELECT EMPNO, SAL,
	COUNT(*) OVER(ORDER BY SAL
							RANGE BETWEEN 50 PRECEDING AND 150 FOLLOWING) A
		FROM EMP;						
	
							
-- 그룹내에서 행을 찾는 것(첫번째 값, 마지막 값)
-- 예제 ) 부서별 직원들을 연봉이 높은 순을 정렬
--          그 파티션 중에서 처음 나온(연봉이 가장 높은 사람을 출력해주세요.)

SELECT DEPTNO, SAL, ENAME
	
	
SELECT DEPTNO, SAL,
	FIRST_VALUE(ENAME) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC, ENAME DESC)
	FROM EMP;

-- MAX 함수 사용하는 법
SELECT EMPNO, ENAME,
	CASE WHEN THEN ELSE,
	FROM EMP E, (SELECT DEPTNO, MAX(SAL) MS FROM EMP
						GROUP BY DEPTNO) E2
	WHERE E.DEPTNO = E2.DEPTNO
	ORDER BY 8; -- 망함
	
-- 마지막 값을 찾는 것
-- LAST_VALUS, 범위가 읽혀지지 않은 다음 값 WINDOWING절에 대한 설정
-- ROW BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING;
	
-- 예제 ) 부서별 직원
--			연봉이 높은 순서로 정렬
--			파티션 내에서 가장 급여가 낮은 사람
SELECT EMPNO, DEPTNO, SAL,
LAST_VALUE(ENAME)
	 OVER(PARTITION BY DEPTNO ORDER BY SAL DESC
			ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
		FROM EMP;
		
--LAG, LEAD : 뒤 OR 앞의 값을 가져옴
SELECT ENAME, HIREDATE, SAL,
--	LAG(SAL) OVER(ORDER BY HIREDATE)
--	LAG(SAL, 2) OVER(ORDER BY HIREDATE)
	LAG(SAL ,3, 0) OVER(ORDER BY HIREDATE)
		FROM EMP;

-- 비율 함수
-- 전체에서 자신의 비율을 나타냄
SELECT ENAME, SAL, RATIO_TO_REPORT(SAL) OVER() * 100
	FROM EMP;

-- 첫 값을 0 마지막 값 1 나머지 가운데 부분을 1/N 으로 하여
-- 자신의 소속된 곳의 위치를 알 수 있음
SELECT DEPTNO, SAL,
	PERCENT_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)
	FROM EMP;

SELECT DEPTNO, SAL,
	CUME_DIST() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)
	FROM EMP;