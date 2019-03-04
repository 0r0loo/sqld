-------------------------20190121--------------------------
-- SELECT USERNAME, PASSWORD FROM DBA_USERS; // SYSTEM 계정
-- 182쪽
-- INSERT(입력)
-- 1) 테이블명 2) 컬럼명
-- 1) PLAYER 2) PLAYER_ID, PLAYER_NAME, TEAM_NAME
-- ** 디비의 SQL 문 값을 모두 '' 처리
-- ''와 NULL은 다른 의미 : 입력을할 때 '' 입력을 하기 때문에 NULL로 입력됨
--                    : NUMBER는 초기값인 0이 들어감
--                          반드시 NULL로 선언해야함
-- ' ' 띄고
-- SYNTEX :
-- 익명적(컬럼 갯수 타입)
-- INSERT INTO PLAYER
-- VALUES('', '', '', '', '', '', '', 0, '', '', '', 0, 0);
-- 명시적(필요한 컬럼입력
-- SELECT USERNAME,PASSWORD FROM DBA_USERS;
-- INSERT INTO HR.PLAYER
-- (PLAYER_ID, PLAYER_NAME, TEAM_ID, E_PLAYER_NAME, NICKNAME, JOIN_YYYY, "POSITION", BACK_NO, NATION, BIRTH_DATE, SOLAR, HEIGHT, WEIGHT)
-- VALUES('', '', '', '', '', '', '', 0, '', '', '', 0, 0);

-- PLAYER_ID CHAR(7), PLAYER_NAME VARCHAR2(20), TEAM_ID CHAR(3)
INSERT INTO HR.PLAYER
VALUES('2019121', '코리아', 'K01', '', '', '', '', 0, '', '', '', 0, 0);
-- SQL Error [1] [23000]: ORA-00001: unique constraint (HR.PLAYER_PK) violated : 식별자는 한 번만 입력됨
INSERT INTO HR.PLAYER
VALUES('2019121', '코리아', 'K01');
--SQL Error [947] [42000]: ORA-00947: not enough VALUES
--: 익명적 방법을 사용했을 때 컬럼의 갯수와 타입을 모름 그래서 입력이 되지 않음
-- 명시적 방법을 사용하면 NULL이 허용된 값은 모두 NULL로 입력됨
INSERT INTO HR.PLAYER(PLAYER_ID, PLAYER_NAME, TEAM_ID)
VALUES('2019122', '코리아', 'K01');
-- 컬럼의 허용 값보다 큰 경우 TO LARGE VALUE의 오류가 발생됨
INSERT INTO HR.PLAYER(PLAYER_ID, PLAYER_NAME, TEAM_ID)
VALUES('20191222', '코리아', 'K01');
-- 익명적 방법 연습
INSERT INTO HR.PLAYER
VALUES ('1994106', '헨메이', 'K01', '', '', '', '', 0, '', '', '', 0, 0);
-- 183page
-- update
-- 값을 수정 : 입력된 값을 수정
-- SINTEXT : UPDATE 테이블명 SET 컬럼 = 값, 컬럼 = 값, ... [조건절];
UPDATE PLAYER SET
    PLAYER_NAME = '코리아',
    TEAM_ID = 'K04';
--ROLLBACK
UPDATE PLAYER SET
    PLAYER_NAME = '코리아it',
    TEAM_ID = 'K10';
--ROLLBACK
-- 삭제
-- 값을 삭제(DELETE -> 휴지통(로그파일로감), TRUNCATE -> 바로 삭제)
-- 테이블, 제약조건(DROP)
-- VIORATE 위법 -> 자식이 삭제되지 않으면 부모가 삭제되지않음

-- 시나리오
-- 자식의 테이블(PLAYER)를 다 지움 -> TEAM을 다 지움
-- SYNTEXT : DELETE FROM 테이블명[조건절]
DELETE FROM PLAYER;
DELETE FROM TEAM; -- 무결성 제약조건
ROLLBACK;
-- SELECT 조건: RDBMS에서는 내용이 분리되어 있다.
--               합쳐서 가지고 오면 됨(JOIN)
SELECT PLAYER_ID,PLAYER_NAME,TEAM_ID FROM PLAYER; -- 481
-- 시나리오 PLAYER_ID가 2011075인 선수의
-- 아이디, 이름,팀명을 알고싶다.
SELECT TEAM_ID,TEAM_NAME FROM TEAM; --15
-- TABLE명에 ALIAS(별명, 별칭, 변수, 변경된 이름) 사용하면
-- 모든 SQL에서 ALIAS로 사용해야함
SELECT PLAYER_ID,PLAYER_NAME,P.TEAM_ID,TEAM_NAME
    FROM PLAYER P,TEAM T
    WHERE P.TEAM_ID =T.TEAM_ID
    AND PLAYER_ID = '2011075';
    
SELECT ENAME, DNAME FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;
SELECT TEAM.* FROM TEAM;
SELECT A.TEAM_ID, A.TEAM_NAME FROM TEAM A;
-- * 와일드카드(모든것을 의미) - SELECT절에 사용 : 문법에맞진 않지만 추가적으로 사용할 수 있는 애  _ % (LIKE문에 사용)가 있습니다.
-- SELECT DISTINCT(컬럼명) FROM TEAM; - 검색된 컬럼의 값을 중복 제거 함
SELECT DISTINCT (TEAM_ID),PLAYER_ID FROM PLAYER; -- 다른 친구랑 써버리면 DISTINCT 깨져버림
-- ALIAS SELECT 절의 컬럼을 출력할 때 변경하기 위해서 사용
-- ** SELECT 절의 컬럼은 순서가 없다.
SELECT BACK_NO, PLAYER_ID FROM PLAYER; -- SELECT 절은 표출되는 친구
-- SQL 문장에서 ""을 사용하는 경우는 딱 두 가지
-- 1) 공백, 특수문자를 사용하기 위해서(우리가 알고있는 엔티티 태그랑 비슷하다고 인식하면 됨)
-- 2) 예약어를 예약어가 아닌것으로 인식시키기 위해서
SELECT BACK_NO 등번호, PLAYER_ID AS "선수^이름" FROM PLAYER; -- SELECT 절은 표출되는 친구
SELECT "POSITION" FROM PLAYER;
-- 산술 연산자 (* / + -) : MOD() 나머지
SELECT HEIGHT*WEIGHT FROM PLAYER;
SELECT HEIGHT/WEIGHT FROM PLAYER;
SELECT HEIGHT+WEIGHT FROM PLAYER;
SELECT HEIGHT-WEIGHT FROM PLAYER;
SELECT HEIGHT || WEIGHT FROM PLAYER;
SELECT CONCAT(HEIGHT,WEIGHT) HEIGHT || WEIGHT FROM PLAYER;
-- 192
-----------------------------190122-----------------------------------
-- 207
-- SELECT, UPDATE, DELETE, INSERT
-- WHERE 조건절
-- SELECT 컬럼 FROM 테이블명 WHERE 조건 (테이블명 > 조건 > 컬럼순)
-- FTS(FULL TABLE SCAN) : 나쁜애 -> OPTIMIZER(INDEX, WHERE)
-- 오라클에만 있는데 시험에 가끔 나오는 애
SELECT * FROM DUAL; -- DUAL 더미테이블 : 문법을 맞추기 위해서 사용하는 테이블, MSSQL에서는 SELECT *; 이라고만 해도 가능함
-- 연산자 우선 순위
-- 10 + 4 * 2 = 18
-- () -> NOT -> SQL 연산자, 비교연산자 -> AND -> OR : 쌤이 신입 때 제일 어려워했던 부분
-- 실습
-- 비교연산자(> < <= >= =)
-- NULL : 미지의 값(타입, 크기를 알 수 없음 / 비교 연산자(=)로 찾아낼 수 없음 -> is null로 비교함)
-- 자바에서는 널 판단하려면 어떻게했더라?
-- A a = NEW a();
-- if(a == null){};
SELECT * FROM EMP;
SELECT * FROM EMP WHERE NOT (SAL >= '1250'); -- SAL이 2000 이상 값 조회
SELECT * FROM EMP WHERE (SAL > '1250'); -- 9 SAL이 2000 초과 값 조회
SELECT * FROM EMP WHERE SAL <= '1250'; -- 5 SAL이 2000 이하 값 조회
SELECT * FROM EMP WHERE SAL < '1250'; -- 3 SAL이 2000 미만 값 조회
SELECT * FROM EMP WHERE SAL = '1250'; -- 2 SAL이 1500 같은 값 조회
-- DB에서는 자동형변환이 일어남(원쿼테이션으로 안 해도 괜찮은데 하는게 좋아)
-- 이거할거였으면 시작도 안함ㅋ
-- AND를 부정하면 OR, DB는 결과를 예측할 수 없어서 조심해야돼, 통계정보가 아예 달라질 수 있음
-- 임금 지급시 하도급 업체에 지급한 임금은 0이 아니라 NULL로 하는데 지급하였지만, 따로 생각으 해줘야함. 세무조사들어가..
-- AND -> OR
-- 사원테이블에서 부서가 20이면서 점원, 분석가를 검색해주세요.
SELECT *
    FROM EMP
        WHERE DEPTNO = '20'
            AND JOB = 'CLERK'
            OR JOB = 'ANALYST';
            
SELECT *
    FROM EMP
        WHERE DEPTNO = '20'
            AND (JOB = 'CLERK'
            OR JOB = 'ANALYST');
            
SELECT *
    FROM EMP
        WHERE (DEPTNO = '20'
            AND JOB = 'CLERK'
            OR JOB = 'ANALYST');
-- 위의 세 개의 쿼리가 다 같은 연산이지만 나중에가면 골치아파질 수도
        
SELECT * FROM EMP -- 12명
    WHERE NOT (DEPTNO = '20' AND JOB ='CLERK');
SELECT * FROM EMP -- 12명
    WHERE DEPTNO != '20' OR JOB != 'CLERK';
-- NOT은 연산자까지 부정함

-- 부정연산자
-- != ^= <> NOT(다 부정하기때문에 애매하지만 여기 붙여줄게, 무조건 컬럼 앞에 있어야함)
SELECT *
    FROM PLAYER    
        WHERE "POSITION" != 'MF';
--        WHERE "POSITION" ^= 'MF';
--        WHERE "POSITION" <> 'MF';
--        WHERE NOT "POSITION" = 'MF';
--         WHERE NOT "POSITION" <> 'MF'; // 이거 아님
-- NULL, 공집합(어떠한 결과도 도출되지 않은 상태)
SELECT * -- 공집합
    FROM PLAYER
        WHERE PLAYER_ID = '1111111'; -- 결과값이 없다고 옳지 않은 쿼리가 아니지 않음
        
SELECT MAX(PLAYER_ID)
    FROM PLAYER
        WHERE TEAM_ID ='K99'; -- 공집합에서 최댓값을 뽑으려면 없어.
        
-- 실습
-- 소속팀이 삼성블루윙즈이거나 전남드래곤즈에 소속된 선수들 이어야하고
-- 포지션이 미드필드이어야한다.
-- 키는 170이상 180이하 이어야 한다.
        
SELECT * FROM PLAYER;
SELECT * FROM TEAM;
-- 내가 실습한 거
SELECT PLAYER_NAME, T.TEAM_NAME, HEIGHT
    FROM PLAYER P,TEAM T
        WHERE P.TEAM_ID = T.TEAM_ID;
SELECT PLAYER_NAME, TEAM_NAME, "POSITION", HEIGHT
    FROM PLAYER P, TEAM T
        WHERE P.TEAM_ID = T.TEAM_ID
            AND (TEAM_NAME = '삼성블루윙즈' OR TEAM_NAME = '드래곤즈')
            AND "POSITION" = 'MF'
            AND HEIGHT BETWEEN 170 AND 180;
            
-- 쌤이 알려주시는 거
-- 1) 필요 값들이 있는 테이블을 찾는 TEAM, PLAYER
-- 2) 필요 조건 > TEAM 이름 : 삼성블루윙즈, 드래곤즈
--               PLAYER : 포지션(POSITION) MF
--               PLAYER : HEIGHT 170이상 180 이하
-- 실습
-- 소속팀이 삼성블루윙즈(K02)이거나 전남드래곤즈(K07)에 소속된 선수들 이어야하고
-- 포지션이 미드필드이어야한다.
-- 키는 170이상 180이하 이어야 한다.
        
-- 항상 시작할 때는 SELECT * FROM 테이블
SELECT TEAM_ID, TEAM_NAME FROM TEAM;
SELECT TEAM_ID, TEAM_NAME
    FROM TEAM
        WHERE TEAM_NAME = '전남드래곤즈'; -- 전남드래곤즈 없네?
-- LIKE : _ %
    SELECT TEAM_ID, TEAM_NAME
    FROM TEAM
        WHERE TEAM_NAME LIKE '%곤즈'; -- K07 드래곤즈 였구나 (특이한 애로..)
-- 소속팀이 삼성블루윙즈(K02)이거나 전남드래곤즈(K07)에 소속된 선수들 이어야하고
SELECT *
    FROM PLAYER
        WHERE TEAM_ID = 'K02' OR TEAM_ID ='K07'; -- K07 드래곤즈 였구나 (특이한 애로..)
    
-- ** IN절(향상된 FOR문) - 연산자 우선순위 3순위
SELECT *
    FROM PLAYER
        WHERE TEAM_ID IN ('K02','K07');
-- 추가 문제
-- 선수들 중에서 TEAM이 KO2 이면서 MF이거나 K07이면서 DF인애
SELECT *
    FROM PLAYER
        WHERE TEAM_ID = 'K02' AND "POSITION" = 'MF'
            OR
            TEAM_ID = 'K02' AND "POSITION" = 'DF';
-- 위와 대응하는 친구임. 깔끔하게~ 뙇
SELECT *
    FROM PLAYER
        WHERE (TEAM_ID, "POSITION") IN (('K02','MF'),('K07','DF'));
    
-- NOT은 컬럼 앞에 사용하는데 IN과 SQL 연산자랑은 앞에 사용할 수 있음
SELECT *
    FROM PLAYER
        WHERE NOT (TEAM_ID, "POSITION") IN (('K02','MF'),('K07','DF'));
SELECT *
    FROM PLAYER
        WHERE (TEAM_ID, "POSITION") NOT IN (('K02','MF'),('K07','DF'));
        
-- 미드필더
SELECT *
    FROM PLAYER
        WHERE "POSITIO" = 'MF'; -- <> != ^= 아닌거 찾을 때
        
-- 키는 170이상 180이하 이어야 한다.
SELECT *
    FROM PLAYER
        WHERE HEIGHT >= '170'
            AND HEIGHT <= '180';
SELECT *
    FROM PLAYER
        WHERE HEIGHT <= '180'
            AND HEIGHT >= '170';
        
-- 위의 쿼리는 같은 결과를 도출함 (BETWEEN과 비교하여 생각하세요.)
-- SQL 연산자는 3순위
-- BETWEEN A AND B
-- 이상 이하의 결과를 나타냄. -> 미만, 초과이면 사용할 수 없음
-- A, B -> 무조건 A가 작아야 됨
SELECT *
    FROM PLAYER
        WHERE HEIGHT BETWEEN '170'
            AND '180';
--------------------------------------
SELECT *
    FROM PLAYER
        WHERE HEIGHT > '180'
            OR HEIGHT < '170';
SELECT *
    FROM PLAYER
        WHERE NOT HEIGHT BETWEEN '170'
            AND '180';
-- 같은 놈들임 ** 중요하다 이해해하자
--------------------------------------
        
SELECT *
    FROM PLAYER
        WHERE HEIGHT NOT BETWEEN '180'
            AND '170'; -- 170인 애와 180인 애가 빠짐            
-- 다합쳐보자
-- 아래 쿼리 해설
-- KO2가 모두 포함되고 + (K07, MF, 170>=, 180<=) // 02에 관한 놈들은 다 나옴
SELECT *
    FROM PLAYER
        WHERE TEAM_ID='K02' OR TEAM_ID = 'K07'
            AND "POSITION" ='MF'
            AND HEIGHT >= '170' AND HEIGHT <= '180';
            
SELECT * -- 33 나와야하는데 // 위에 연산이랑 다릅니다.
    FROM PLAYER
        WHERE TEAM_ID='K02' OR TEAM_ID = 'K07'
            AND "POSITION" ='MF'
            AND HEIGHT >= '170' AND HEIGHT <= '180';
            
-- SQL연산자 사용 이유 : 매우 빠름
SELECT *
    FROM PLAYER
        WHERE TEAM_ID IN ('K02','K07')
            AND "POSITION" = 'MF'
            AND HEIGHT BETWEEN 70 AND 180;
            
SELECT * FROM PLAYER WHERE TEAM_ID = 'K07' AND "POSITION" = 'MF';
-- LIKE : 와일드 카드를 사용해서 검색
-- _(한 칸), %(모든것)
-- 회사에서 주의해야할 것
-- 첫자리가 % _ 인 검색은 사용하지 말자 > 하드웨어의 부하가 너무 커짐 > 포트폴리오에넣지 말아야 할 쿼리 '%%' 무한대임
SELECT * FROM PLAYER WHERE PLAYER_NAME LIKE '김%'; 
SELECT * FROM PLAYER WHERE PLAYER_NAME LIKE '김_';
-- 255page-----------------------------------------------------------------------------
-- 이거 이해하면 강자
-- ROWNUM : TABLE에서 조회된 ROW를 반환해서 SELECT에 생성할 때 번호를 생성해줌(COUNT 해줌) : SELECT에 생성할 때가 핵심
-- => FROM 절에서 테이블을 읽어오면 나가면서 순서를 COUNT 해줌
-- INSERT문을 통해서 하나의 ROW를 입력하면 순서는 어떻게 될까? -> 순서는 없음
-- ROW의순서 아님 1위부터 5위까지 안됨(아예! 쓸데없는 쿼리)
SELECT ROWNUM, TEAM.* FROM TEAM; --TEAM.* 은 그냥 테스트용임 회사에서 쓰면 사장됨.
SELECT ROWNUM, TEAM.* FROM TEAM WHERE ROWNUM BETWEEN 1 AND 5; -- R <= 1 AND R <= 5
SELECT ROWNUM, TEAM.* FROM TEAM WHERE ROWNUM BETWEEN 2 AND 5; -- 안되는 쿼리
SELECT ROWNUM, TEAM.* FROM TEAM WHERE ROWNUM = 2; -- 1이 만들어지지않았기 때문에 절대 안됨 이거 이해하면 디비 이해하는거임
----------------------------------------------------------------------------------------
-- 여기부터는 드럽게 재미없으거야(그래도 나는 잼있을거야) -> 아니 졸리네..
-- ANSI/ISO에서 제공하고 있는 기본 메소드
-- 메소드 :(), 블럭, 접근제한자, 반환, 이름 <- 개발에서 필요한 애들
-- 메소드를 사용하려면? 객체(Class)명.메소드()
-- 디비에선 메소드명(아규먼트) 이렇게 사용함
-- str.subString(3) -> SUBSTR(str,3) // 객체라는 개념이 없어서
-- built in 함수, implicit 함수, 내장 객체
-- -> 사용자가 만들어 사용하는 언어  Pl/SQL 요즘은 걷어내는 추세(느리고 잘하는 애 없고, 다른 시스템에 적용 힘듦) 
-- 전자정부프레임워크를 사용하는 이유!? 베트남에도 팔았음
-- 단일행함수 : argument 1개, 다중행함수 : argument 여러개 / argument의 종류를 이야기함
-- 문자, 숫자, 날짜, 형변환, null(특별해서 나중에)
-- 소대문자, 자르기, CHAR -> 숫자, 길이
SELECT --LOWER('LEX'),UPPER(LAST_NAME),SUBSTR(LAST_NAME,4,3),
 --SUBSTR(LAST_NAME,4,3),
-- ASCII(SUBSTR(LAST_NAME,4,1)),
-- LENGTH(FIRST_NAME),
-- TRIM('　　DE HAAN　　'),LENGTH(TRIM('　　DE HAAN　　')),
-- LTRIM('AAAABAAATTTT     ','A'),
-- CONCATENATION
    CONCAT('HAPPY','.COM'), FIRST_NAME||' '||LAST_NAME,
     EMPLOYEES.*
     FROM EMPLOYEES
         WHERE LOWER (FIRST_NAME)=LOWER('LEX');
 
SELECT LOWER('LEX'), EMPLOYEES.* FROM EMPLOYEES;
-- 숫자
-- 어렵진 않은데 많이들 틀리더라고
-- 반올림, 올림, 버림(TRUNK)이 핸들링이 까다로움 -> 3.151515 3번째 자리에서 반올림 한 값은 ? 3.152
-- CEIL, FLOOR(얘네만 유념해서 봐주셈)
-- SIGN
-- MOD
SELECT * FROM DUAL; -- 더미 테이블 생성
SELECT TRUNC(3.145), TRUNC(3.145, 1) FROM DUAL;
SELECT ROUND(3.51515), ROUND(3.51515,4) FROM DUAL;
-- CEIL(최근접 최상위 정수값), FLOOR(최근접 최하위 정수값)
SELECT CEIL(3.14), CEIL(-3.14) FROM DUAL;
SELECT FLOOR(3.14), FLOOR(-3.14) FROM DUAL;
SELECT MOD(10,3) FROM DUAL; --10%3;
-- 자! 이제 시작이야
-- 날짜형 함수 되게 되게 많이쓴다
-- 일정게시판 만들 때 무너지지마!!!
-- 숫자냐 문자냐가 중요해(숫자는 오른쪽에 붙고, 문자는 왼쪽에 붙음)
-- 현재 날짜 : 오라클 기준 SYSDATE, MSSQL : GETDATE, MYSQL : NOWDATE
SELECT * FROM DUAL;
SELECT HIREDATE, SYSDATE
    FROM EMP;
    
-- 회사에서 한 번도 써본적은 없지만,
SELECT EXTRACT(YEAR FROM HIREDATE) FROM EMP;
--SELECT EXTRACT(YEAR MONTH FROM HIREDATE) FROM EMP; 이거 같이는 못쓰고 따로 써줘야함
SELECT EXTRACT(MONTH FROM HIREDATE) FROM EMP;
SELECT EXTRACT(DAY FROM HIREDATE) FROM EMP; -- 년월일만 가능함
-- 회사에서 사용하는 방법
-- DATE -> 문자 -> PATTERN(년/월/일/시/분/초) -> 숫자로 형변환
-- 2019-01-22 -> 01 -> 1
SELECT TO_CHAR(HIREDATE,'YYYYMMDD HH24:MI-SS') FROM EMP;
SELECT TO_CHAR(HIREDATE,'MM')+1 FROM EMP; -- 숫자를 더하면 숫자가 됨 욕먹을 수도 있는 방법
SELECT TO_NUMBER(TO_CHAR(HIREDATE,'MM')) FROM EMP; -- 숫자를 더하면 숫자가 됨 욕먹을 수도 있는 방법

-- 되게 재밌는거
SELECT SYSDATE + 15 FROM DUAL;
SELECT SYSDATE +3.5/24 FROM DUAL; -- 24로 나누면 시간이 됨
-- 변환 함수
-- TO_CHAR, TO_NUMBER, TO_DATE
-- TO_CHAR -> 숫자를 문자, DATE 패턴 형태로 변환
-- TO_NUMBER -> 타입문자(숫자형) 01 -> 1
SELECT PLAYER_ID+1, PLAYER_ID FROM PLAYER;
SELECT HEIGHT || WEIGHT FROM PLAYER; -- 문자형이 되어버림
SELECT TO_DATE('20190222') FROM DUAL; -- 최소 년월일이 적혀있어야 변환이 가능
--SELECT TO_DATE('20190222 111111') FROM DUAL; -- 안 되는 친구임
-- 책에 있는 친구
SELECT TO_CHAR(3654.158,'$999.999') FROM DUAL; --###으로 나오지롱
SELECT TO_CHAR(3654.158,'$9,999.999') FROM DUAL; -- 패턴 레이아웃
SELECT TO_CHAR(3654.158,'L999,999.9999999') FROM DUAL; -- 원화표시
------------------------------------------------------------
-- 240
-- IF문과 같은 문법 디비는 바디가 없으므로 CASE WHEN THEN ELSE END
-- IF(){}ELSE{}
-- IF(){}ELSE IF(){}
-- SWITCH 변수{CASE : 값 BREAK; DEFAULT}
-- CASE
-- WHEN THEN
-- WHEN THEN
-- WHEN THEN
-- ELSE END -- 스위치케이스문 같아서 두개로 나뉨
-- SWITCH : 1:1로 매핑 되는 처리 : SIMPLE
-- IF : 범위 / SEARCHED
-- ORACLE에만 있는 문법 : DECODE(컬럼, 비교할 값, 참, 거짓) ANSI 표준은 아님 SEARCHED가 안됨, 스위치 문 같음
-- DECODE 하기위해서 테이블 한 번 만들어 봄, 시험에 나올까봐 봐봄
-- ** 테이블을 생성해 봅시다!
CREATE TABLE HAPPY(
    C_CHAR CHAR(4), -- 크기 고정 변수(공간)
    C_VARCHAR2 VARCHAR2(4) -- 가변 크기 변수(공간)
);
INSERT INTO HAPPY VALUES ('A','A');--'A    ' , 'A' // 이케 들어가 있음
SELECT * 
    FROM HAPPY;
-- IF(YEAR%4 == 0 && YEAR % 100 != 0 || YEAR%400 == 0)
-- IF(YEAR%4 == 0){
--    IF(YEAR % 100 == 0){
--        IF(YEAR % 400 == 0){
--             윤년
--        }ELSE{
--            평년
--        }
--    }ELSE{
--         평년
-- } // 다중 IF문

-- ORACLE에만 있는 문법 : DECODE(컬럼, 비교할 값, 참, 거짓) ANSI 표준은 아님 SEARCHED가 안됨, 스위치 문 같음
SELECT DECODE(C_CHAR,'A   ', 'TRUE', 'FALSE'), -- 객체화되어서 올라가므로 리터럴이 아님 그래서 안됨
    DECODE(C_VARCHAR2,'A', 'TRUE', 'FALSE')        
    DECODE(C_VARCHAR2,'A    ', 'TRUE', 'FALSE')        
    FROM HAPPY; -- 이거 테이블 두개 만들어서 비교해봐
--
SELECT * FROM HAPPY WHERE C_CHAR='A'; -- 얘는 리터럴이라서 가능
SELECT * FROM HAPPY WHERE C_CHAR='A    '; -- 얘는 리터럴이라서 가능
-- CASE WHEN THEN ELSE
-- 1:1로 비교하는 것 SIMPLE CASE 방법 사용
-- DECODE(C_VARCHAR2,'A    ', 'TRUE', 'FALSE')        
SELECT CASE C_VARCHAR2 WHEN 'A   ' THEN 'TRUE' ELSE 'FALSE' END
    FROM HAPPY;
-- SAL 1250이라면 '상', 950 이상이라면 '중' 그 외의 인원은 '하'
SELECT ENAME, SAL,
    CASE WHEN SAL >= 1250 THEN 'H'
    WHEN SAL>=950 THEN 'M'
    ELSE 'L' END
FROM EMP;
-- 문제!
-- EMP에 보면, COMM(COMMITION : 보너스)가 NULL 이라면 '없음', 있다면 'COMM'
SELECT EMP.*,
    CASE WHEN COMM IS NULL THEN 'EMPTY' ELSE COMM END
    FROM EMP; -- 이거 안됨 컬럼이라는 대상은 타입과 크기가 정해지면 정해진 값만 들어갈 수 있음
SELECT EMP.*,
    CASE WHEN COMM IS NULL THEN 'EMPTY' ELSE TO_CHAR(COMM) END
    FROM EMP; -- 이거 안됨 컬럼이라는 대상은 타입과 크기가 정해지면 정해진 값만 들어갈 수 있음
    
SELECT EMP.*,
    CASE WHEN COMM IS NULL THEN 'EMPTY' ELSE 'COMM' END
    FROM EMP;
    
-- CASE 중첩, CASE
-- 사원 정보에서 급여가 2000이상이라면 보너스는 1000
-- 1000 이상이라면 500
-- 1000 미만이라면 0
-- 을 현재 COMM(보너스)에더해서 조회해주세요.
-- 내가 푼 것
SELECT EMP.*,
    CASE WHEN SAL >= '2000' THEN COMM+1000
    WHEN SAL >= '1000' THEN COMM+500
    ELSE 0 END C
    FROM EMP;
-- NVL() : NULL -> 치환 // ANSI 표준임, 사용해도 됨
SELECT COM, NVL(COMM, 0) FROM EMP;
-- 지금 배운 방식의 첫번째 풀이
SELECT ENAME, SAL, COMM,
    CASE WHEN COMM IS NULL AND SAL >= 2000 THEN 1000
    WHEN COMM IS NULL AND SAL >= 1000 THEN 500
    WHEN COMM IS NULL AND SAL < 1000 THEN 0 
    WHEN SAL >= 2000 THEN COMM + 1000
    WHEN SAL >= 1000 THEN COMM + 500
    ELSE 0
    END
    AS BONUS
    FROM EMP;
-- TABLE을 정제함 FROM 절에 넣고 사용
-- 빅데이터 처리시 이렇게 정제하고 사용함. NULL 값이 있을 수가  없으므로.
SELECT ENAME, SAL, COMM,
    CASE WHEN COMM IS NULL THEN 0
    ELSE COMM END AS ECOMM
    FROM EMP;
    
SELECT A.ENAME, A.SAL,
    CASE WHEN A.SAL >= 2000 THEN ECOMM + 1000
    WHEN A.SAL >= 1000 THEN ECOMM + 500
    ELSE ECOMM
    END BONUS
    FROM
    (SELECT ENAME, SAL, COMM,
        CASE WHEN COMM IS NULL THEN 0
        ELSE COMM END AS ECOMM
        FROM EMP) A; -- SUB QUERY
        
SELECT A.ENAME, A.SAL, A.COMM,
    CASE WHEN A.SAL >= 2000 THEN NVL(A.COMM,0) + 1000
    WHEN A.SAL >= 1000 THEN NVL(A.COMM,0) + 500
    ELSE NVL(A.COMM,0)
    END BONUS
    FROM EMP A;
SELECT ENAME, SAL, COMM,
    CASE WHEN SAL >= 2000 THEN NVL(COMM,0) + 1000
    WHEN SAL >= 1000 THEN NVL(COMM,0) + 500
    ELSE NVL(COMM,0)
    END BONUS
    FROM EMP;
-- 위에 3개다 같은 결과를 도출한다.
-- 아래에서 중첩 케이스문으로 변경하려고 한다. > 쌤이 원하신 정답 NVL이 더 좋아, 내장함수를 이용하는 것이 좋아
SELECT ENAME, SAL, COMM,
    CASE 
        WHEN COMM IS NULL THEN (CASE WHEN SAL >= 2000 THEN 1000
                                     WHEN SAL >= 1000 THEN 500
                                     ELSE 0
                               END)
        ELSE (CASE WHEN SAL >= 2000 THEN COMM + 1000
                   WHEN SAL >= 1000 THEN COMM + 500
                   ELSE 0
        END)
    END BONUS
FROM EMP;
-- 246---------------------------------------------------------------------------------
-- NULL의 특징, 함수(NVL, NULLIF, COALESCE)
-- NULL의 특징 : 연산을 하면 결과는 다 NULL, 비교하면 FALSE
-- NUL과 CONCATENATION -> 값이 나온다.
SELECT COMM, COMM * 30
    FROM EMP WHERE SAL > NULL; -- 공집합
    
SELECT'HAPPY'
    FROM DUAL WHERE '1' > NULL; -- 공집합
    
SELECT EMPNO, COMM, EMPNO || COMM
    FROM EMP;
-- 20190122 녹음 3번째
-- OWASP 전세계 개발자 센터 4년마다 웹취약점에대해서 발표해줌 크로스사이드스크립팅(게시판에다가 스크립트 넣어서해킹),
-- 인증 및 세션, SQL 인젝션, 프리페어드 어쩌고 쓰면 괜찮은데 잘 안씀
-- 구글의 INDEX OF는 보안 어쩌고 취약한 API 등등등,,,
-- 이력서 쓸 때,
-- OWASP 취약점에 대해서 
-- 장차법 등등
--------------------19023
-- 245 
-- NULL : 미지의 값, 타입 크기 없음 <-> ''
-- CREATE TABLE HAPPY_TEST()(NUM NUMBER(10),STR VARCHAR2(10));
-- NUMBER라고 선언된 공간에도 NULL이 들어갈 수 있음
SELECT * FROM EMP;
SELECT * FROM EMP WHERE '1' = '1' AND '1' = NULL;
SELECT * FROM EMP WHERE COMM IS NULL; -- NULL을 확인하는 방법은 IS NULL
-- 윈도우 10 확장자 연결 기본앱을 지워버려요.
-- NVL = MYSQL에서는  ISNULL : 만약에 컬럼의 값이 NULL이라면 치환, NULLIF
-- NULLIF : 컬럼1, 컬럼2 컬럼1=컬럼2 같다면 NULL 아니면 컬럼1 // 가입년도 따지는 경우에 주로 사용함
SELECT EMP.*, NVE(COMM,0)  FROM EMP; -- 얘를 사용하는 이유 NULL인 경우 연산이 되지 않음, 미지의 값이므로 계산대상에서 빠져버리므로 통계정보가 완전히 달라져버림
-- NULL으로 하는경우 하도급업체 때문에 우리가 비용을 지불하진 않지만, 통계를 낼 때 어떻게 낼 지 선택할 수 있게 됨
SELECT AVG(COMM), -- NULL을 제외한 계산
    AVG(NVL(COMM,0)), -- 디비는 객체가 아니므로 모두 아규먼트로 처리함
    AVG(CASE WHEN COMM IS NULL -- 서치드(WHEN 안에) NULL만
    THEN 0 ELSE COMM
    END)
    FROM EMP;
SELECT AVG(CASE WHEN COMM IS NULL THEN 0 ELSE COMM END) FROM EMP;
SELECT SAL,AVG(CASE WHEN COMM IS NULL THEN 0 ELSE COMM END) FROM EMP;
SELECT NULLIF(JOB,'PRESIDENT')
    FROM EMP;
    
-- COALESCE NULL이 아닌 값이 나오는 최초의 값을 출력
SELECT COMM, SAL, COALESCE(COMM, SAL)
    FROM EMP;
-- 공집합과 NULL의 차이점 !! 
-- 공집합 : 실행된 SQL의 결과가 없는  것
-- NULL : 미지의 값이 도출된 상태
-- 쿼리는 실행 됐다고 하면 무조건 성공 : 근데 아무것도 도출 안돼있음 > 공집합
-- NVL은 공집합 처리 못함. ORACLE만 NULL 찍어주고 다른 애들은 걍 비어보임(옵션임)
SELECT * FROM EMP WHERE ENAME = '전민균'; --공집합
SELECT COUNT(*), MAX(ENAME) FROM EMP WHERE ENAME = '전민균';
-- COUNT는 숫자를 반환, MAX
-- 255PAGE 
-- 집계함수 : 다중행함수
-- COUNT(*), COUNT(컬럼), AVG(), MAX(), MIN(), STDDEV() 표준편차, VARIANCE() 분산
-- 집계함수  NULL은 계산하지 않음
SELECT COUNT(*),-- * 와일드 카드는 ROW의 값이 하나라도 있다면 COUNT 처리
    COUNT(COMM),-- 컬럼 중에서 NULL을 제외하면 값이 있다면 COUNT 처리
    AVG(SAL), -- 컬럼(급여)의 평균값
    MAX(JOB), MAX(SAL), -- 최대값
    MIN(JOB), MAX(SAL), -- 최소값 
    SUM(SAL) --, SUM(JOB)
    FROM EMP;
    
-- 자바에서는 NULL을 최대값으로 인식함 > 개발에서는 INFINITY DB에서는 처리 못함
-- ** GROUP 단일 값은 표출할 수 없음 > 단일행 함수
--SQL Error [937] [42000]: ORA-00937: not a single-group group function
-- 집계가 되어있는 SELECT 절에 단일 ROW 값을 표출해서 발생됨
SELECT AVG(SAL), -- 집계함수
--    ENAME
    FROM EMP; 
-- 대망의 어려운 거!
-- ~~별 GROUP BY를 사용해서 풀이해야한다.
-- SELECT 컬럼 FROM 테이블 WHERE 조건 GROUP BY 컬럼 HAVING 그룹된 값의 조건
-- WHERE 먼저 조건을 제거함
-- HAVING 그룹된 상태의 조건제거
SELECT * FROM PLAYER WHERE "POSITION" IS NULL;
-- 선수들의 팀별 평균키를 구하고
-- SQL Error [979] [42000]: ORA-00979: not a GROUP BY expression
-- SELECT절에 잘못 컬럼 선택
SELECT  -- 사용할 수 있는 컬럼은 GROUP BY에 사용된 컬럼, 집계함수
    *
    FROM PLAYER GROUP BY TEAM_ID;
SELECT TEAM_ID, TRUNC(AVG(HEIGHT)) -- 사용할 수 있는 컬럼은 GROUP BY에 사용된 컬럼, 집계함수
    FROM PLAYER GROUP BY TEAM_ID HAVING AVG(HEIGHT) >= 180; -- 집계함수는 HAVING절과 SELECT절에서만 사용가능!!!!
    
-- 선수들 중 선수들의 평균키보다 큰 선수들의 정보를 보고 싶다.
SELECT PLAYER_NAME, HEIGHT FROM PLAYER WHERE HEIGHT >= (SELECT TRUNC(AVG(HEIGHT)) 
    FROM PLAYER); -- 집계함수는 HAVING절과 SELCET절에서만 사용
    
-- 서브쿼리는 두개로 나뉘어짐 > FROM에서 사용 : INLINE VIEW, WHERE절이나 SELECT절에 사용 : SCALA VIEW
-- INLINE VIEW는 EXPLAIN EXECUTION PLAN 눌러보면 하나만 돌아감, 서브쿼리는 지양해야함
SELECT AVG(HEIGHT) FROM PLAYER;
-- WHERE절은 FROM절 뒤에만 가능하다.
-- 조건을 먼저 제거하는게 SQL 튜닝의 기본
-- 문제 1) 선수들 중 키가 175 이상인 사람의 포지션별 평균키를 알고 싶다.
-- 내가 푼 거
SELECT "POSITION", TRUNC(AVG(HEIGHT))
    FROM PLAYER
        WHERE HEIGHT >= 175
            GROUP BY "POSITION";
-- 선생님 풀이
SELECT "POSITION", TRUNC(AVG(HEIGHT))
    FROM PLAYER
        WHERE HEIGHT >= 175 AND "POSITION" IS NOT NULL
            GROUP BY "POSITION";

-- 문제 2) 선수들 중 포지션별 평균키가 175이상인 포지션을 알고 싶다.
-- 내가 푼 거
SELECT "POSITION", TRUNC(AVG(HEIGHT))
    FROM PLAYER
        GROUP BY "POSITION"
            HAVING AVG(HEIGHT) >= 175;
-- 선생님 풀이
SELECT "POSITION", TRUNC(AVG(HEIGHT))
    FROM PLAYER
        WHERE "POSITION" IS NOT NULL
        GROUP BY "POSITION"
        HAVING AVG(HEIGHT) >= 175; -- HAVING은 그룹의 조건절
-- GROUP BY에서 ALIAS 사용시 유의점 : SELECT절에 ALIAS를 사용하지 말자
SELECT DEPTNO DEP
    FROM EMP E
        GROUP BY DEP;
        
-- ************ 겁나 중요한 거
-- 실행 순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
SELECT "POSITION", TRUNC(AVG(HEIGHT))
    FROM PLAYER
        WHERE "POSITION" IS NOT NULL
        GROUP BY "POSITION"
        HAVING AVG(HEIGHT) >= 175 AND "POSITION" != 'MF'; -- HAVING은 그룹의 조건절
-- 연산자 우선순위 : () -> NOT -> SQL 연산자  -> AND -> OR
        
-- 문제) CASE, 집계함수, IN-LINE VIEW, GROUP BY, BUILT-IN 함수(DATE)
-- 사원 테이블에서 입사월을 기준으로 부서별 급여를 출력해달라.
        
-- 1. EMP 테이블
-- 2. 각 입사일자는 HIREDATE에서 월만가져옴
-- 3. 2)를 사용해서 각 월의 급여를 출력 EX) CASE 2) WHEN 1 THEN SAL END * 12
-- 4. GROUP BY DEPTNO
-- 5. 집계함수인 SUM을 사용해서 급여를 집계함
--------------------------- 내가 한 거
SELECT * FROM EMP;
SELECT EMPNO, ENAME,SAL,
    EXTRACT(MONTH FROM HIREDATE) -- 숫자01 -> 1
    FROM EMP;

-----못 품------------------------------------------------------
---쌤
-- ① 필요 컬럼 정제
SELECT EMPNO,ENAME,HIREDATE FROM EMP;
SELECT SAL FROM EMT 
-- ② 입사일자 월
SELECT EMPNO, ENAME,
    EXTRACT(MONTH FROM HIREDATE), -- 숫자01 -> 1
    TO_CHAR(HIREDATE,'MM'), -- 문자 01 -> '01'
    TO_NUMBER(TO_CHAR(HIREDATE,'MM')), -- 문자를 숫자 01 -> 1
    TO_CHAR(HIREDATE,'MM')+0, -- 문자를 숫자 01 + 0 -> 1
    SUBSTR(TO_CHAR(HIREDATE),4,2) -- 년/월/일 문자 월
    FROM EMP;
-- ③ 출력/조화 사항 갯수에 표현
SELECT EMPNO, ENAME,DEPTNO, LOWER(ENAME)
    FROM EMP
    
-- ELSE문을 작성하지 않으면 모든 값은 NULL 
-- CASE와 WHEN절의 타입이 같아야하고
-- 표출 결과값인 THEN과 ELSE 타입 같아야 한다.
SELECT 
    CASE EXTRACT(MONTH FROM HIREDATE) WHEN 1 THEN SAL ELSE 0 END,
    CASE TO_CHAR(HIREDATE,'MM') WHEN '02' THEN SAL ELSE 0 END,
    CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 3 THEN SAL END,
    CASE TO_CHAR(HIREDATE,'MM')+0 WHEN 4 THEN SAL END,
    CASE SUBSTR(TO_CHAR(HIREDATE),4,2) WHEN '05' THEN SAL END,
    CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 6 THEN SAL END,
    CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 7 THEN SAL END,
    CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 8 THEN SAL END,
    CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 9 THEN SAL END,
    CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 10 THEN SAL END,
    CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 11 THEN SAL END,
    CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 12 THEN SAL END
        FROM EMP;
        
-- ④ GROUP BY
SELECT DEPTNO,
    AVG(CASE EXTRACT(MONTH FROM HIREDATE) WHEN 1 THEN SAL ELSE 0 END) "1",
    AVG(CASE TO_CHAR(HIREDATE,'MM') WHEN '02' THEN SAL ELSE 0 END) "2",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 3 THEN SAL END) "3",
    AVG(CASE TO_CHAR(HIREDATE,'MM')+0 WHEN 4 THEN SAL END) "4",
    AVG(CASE SUBSTR(TO_CHAR(HIREDATE),4,2) WHEN '05' THEN SAL END) "5",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 6 THEN SAL END) "6",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 7 THEN SAL END) "7",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 8 THEN SAL END) "8",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 9 THEN SAL END) "9",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 10 THEN SAL END) "10",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 11 THEN SAL END) "11",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 12 THEN SAL END) "12"
        FROM EMP
            GROUP BY DEPTNO;
           
SELECT DEPTNO,
    AVG(CASE EXTRACT(MONTH FROM HIREDATE) WHEN 1 THEN SAL ELSE 0 END) "1",
    AVG(CASE TO_CHAR(HIREDATE,'MM') WHEN '02' THEN SAL ELSE 0 END) "2",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 3 THEN SAL END) "3",
    AVG(CASE TO_CHAR(HIREDATE,'MM')+0 WHEN 4 THEN SAL END) "4",
    AVG(CASE SUBSTR(TO_CHAR(HIREDATE),4,2) WHEN '05' THEN SAL END) "5",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 6 THEN SAL END) "6",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 7 THEN SAL END) "7",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 8 THEN SAL END) "8",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 9 THEN SAL END) "9",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 10 THEN SAL END) "10",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 11 THEN SAL END) "11",
    AVG(CASE TO_NUMBER(TO_CHAR(HIREDATE,'MM')) WHEN 12 THEN SAL END) "12"
        FROM EMP
            GROUP BY DEPTNO;
            
-- ⑤ 고용일자 DATE -> 월, 정제된 테이블을 만들어서 사용하자 IN-LINE VIEW~
SELECT DEPTNO,
    SUM (CASE EXMONTH WHEN 1 THEN SAL ELSE 0 END) "1월",
    SUM(DECODE(EXMONTH, 2, SAL, 0)) "2월",
    SUM (CASE EXMONTH WHEN 3 THEN SAL ELSE 0 END) "3월",
    SUM (CASE EXMONTH WHEN 4 THEN SAL ELSE 0 END) "4월",
    SUM (CASE EXMONTH WHEN 5 THEN SAL ELSE 0 END) "5월",
    SUM (CASE EXMONTH WHEN 6 THEN SAL ELSE 0 END) "6월",
    SUM (CASE EXMONTH WHEN 7 THEN SAL ELSE 0 END) "7월",
    SUM (CASE EXMONTH WHEN 8 THEN SAL ELSE 0 END) "8월",
    SUM (CASE EXMONTH WHEN 9 THEN SAL ELSE 0 END) "9월",
    SUM (CASE EXMONTH WHEN 10 THEN SAL ELSE 0 END) "10월",
    SUM (CASE EXMONTH WHEN 11 THEN SAL ELSE 0 END) "11월",
    SUM (CASE EXMONTH WHEN 12 THEN SAL ELSE 0 END) "12월"
    FROM(
        SELECT SAL,DEPTNO,
            TO_NUMBER(TO_CHAR(HIREDATE,'MM')) EXMONTH
            FROM EMP)
        GROUP BY DEPTNO;
        
-- ORACLE CASE문 : DECODE(컬럼, 비교값, 참, 거짓) -- SIMPLE
    
-- POSITION별 평균키 -> 세로로 만들건
SELECT "POSITION", AVG(HEIGHT)
    FROM PLAYER
        WHERE "POSITION" IS NOT NULL
            GROUP BY "POSITION";
    
    
        
-- 포지션별 평균키 가로 <-> 세로
SELECT 
    AVG(CASE "POSITION" WHEN 'GK' THEN HEIGHT ELSE 0 END) "GK",
    AVG(DECODE("POSITION",'DF', HEIGHT, 0)) "DF",    
    AVG(CASE "POSITION" WHEN 'FW' THEN HEIGHT ELSE 0 END) "FW",
    AVG(DECODE("POSITION",'MF', HEIGHT, 0)) "MF"
    FROM PLAYER;
    
-- 297
-- 데이터 무결성 : 일관적이다 > 예측이 가능하다.
-- 데드락 상태 : 선행 트랜젝션에 의해 커밋이날 롤백이 진행되지않으면, 다음 타자는 실행이 되지않음.
-- 실습
-- CMD IPCONFIG
-- sqlplus hr/hr@192.68.4.254 -> 안됨 -> 제어판 -> 방화벽 -> 인바운드규칙
-- -> 새규칙-> 포트  -> 다음 -> 모든 로컬 포트(원래 아이피 넣고) -> 이름 oracle : 외부 접속 db
-- -> cmd 창에서 ip로 다른 컴퓨터 db에 접속할 수 있음(같은 공유기)
-- 5번 All or Nothing : 모두 실행이 되거나 안되거나
-- COUNT : row의 갯수
-- SUM : NULL을 제외한 합
-- AVG : NULL을 제외한 평균
-- STDDEV : 표준편차
-- 집합별로 집계된 데이터에 대한 조회 조건 제한 : HAVING

--20190124
-- 269page
-- ORDER BY, rownum : top(n) 쿼리
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
-- ORDER BY : SORT(정렬) ASCENDING(오름차순 DEFAULT), DECENDING(내림차순)
-- ORDER BY 컬럼1, 컬럼2, 컬럼3 -> 컬럼1 정렬된 상태에서 컬럼 2번 정렬
-- 사원테이블에서 부서 ASC, 사원 번호는 DESC
-- 컬럼명, 컬럼순서, ALIAS
SELECT EMPNO EM, DEPTNO
    FROM EMP ORDER BY DEPTNO, EMPNO DESC; -- 디비는 중복도 없고 순서도 없는 형태로 저장하고 있음, 읽어올 때 정렬함
    
SELECT EMPNO, DEPTNO
    FROM EMP ORDER BY 2, 1 DESC;
    
SELECT EMPNO EM, DEPTNO DE
    FROM EMP ORDER BY DE, EM DESC;
    
-- ROWNUM
-- ROWNUM : TABLE에서 조회된 ROW를 반환해서 SELECT에 생성할 때 번호를 생성해줌(COUNT 해줌) : SELECT에 생성할 때가 핵심
-- => FROM 절에서 테이블을 읽어오면 나가면서 순서를 COUNT 해줌
SELECT EMP.*, ROWNUM FROM EMP WHERE ROWNUM <=3;
SELECT EMP.*, ROWNUM FROM EMP WHERE ROWNUM =3; -- 1과 2가 없으므로 생성이 되지 않음
-- SAL기준으로 상위 3명만 출력하고 싶다.
-- RANK(), DENSE_RANK() :     10 20 30 40
-- RABK()                   5  4  2  2  Q
-- DENSERAMK               4  3  2  2  1

-- SELECT ROWUM FROM EMP ORDER BY SAL DESC,EMPNO];
SELECT ROWNUM, K.*
    FROM (SELECT *
            FROM EMP ORDER BY SAL DESC,EMPNO)K
            WHERE ROWNUM <= 3;
-- sql 서버에서만 사용 -> top(3),
-- 정규화 1 ~ 5차
-- 1차 식별자에 어떤값이 있으면빼자
-- 회사에서는 3정규화까지, 보이스코드 정규화
-- &CASE코막*KOMAR_데이터
--IQ / STREMA 객체를 잘 알아야함
WHR--JOIN
-- 조건(equo join:  1 대 1조인)
-- PK.식별자(무결성제약조건
-- FK.외래키(다른 테이블의PK이고 연결을 위해서 사용는 컬럼( 자식테이블)
-- FK와 PK 관계에서 타입과 크기는 같아야 하며 컬럼명은 달라도됨
SELECT RO 
ORDER BY SAL DESC, EMPNO 
--DQL -> 
-- FK를 가진에가 자식
    
CREATE TABLE T1(
    ID CHAR(4),
    NAME VARCHAR2(20),
    ADDRESS VARCHAR2(50),
    EX_ID VARCHAR2(4)
);

CREATE TABLE T2(
    EX VARCHAR2(4),
    AUTH VARCHAR(20),
    AGE NUMBER
);

-- NULL은 JOIN 대상도 아님

INSERT INTO HR.T1
(ID, NAME, ADDRESS, EX_ID)
VALUES('K001', '홍길동', '율도국', 'A');
INSERT INTO HR.T1
(ID, NAME, ADDRESS, EX_ID)
VALUES('K002', '도우너', '신림', 'B');
INSERT INTO HR.T1
(ID, NAME, ADDRESS, EX_ID)
VALUES('K003', '또치', '연신내', 'B');
INSERT INTO HR.T1
(ID, NAME, ADDRESS, EX_ID)
VALUES('K004', '초파', '관악산', 'C');

INSERT INTO HR.T2
(EX, AUTH, AGE)
VALUES('A', 'MASTER', 120);
INSERT INTO HR.T2
(EX, AUTH, AGE)
VALUES('B', 'STARTER', 120);
INSERT INTO HR.T2
(EX, AUTH, AGE)
VALUES('C', NULL, 120);

SELECT * FROM T1;
SELECT * FROM T2;

-- 데이터가 들어가기전에 구조를 잡고 데이터를 넣으세요.

ALTER TABLE T1 ADD CONSTRAINT T1_PK PRIMARY KEY (ID);
ALTER TABLE T2 ADD CONSTRAINT T2_PK PRIMARY KEY (EX);
ALTER TABLE T1 ADD CONSTRAINT T1_FK FOREIGN KEY (EX_ID) REFERENCES T2(EX);

DROP TABLE T1;
DROP TABLE T2;

-- JOIN :
-- FROM절, ANSI/ISO 표준 JOIN
-- 대부분의 회사는 FROM절을 활용
-- INNER JOIN <-> OUTER JOIN(LEFT OUTER JOIN
-- 							 ,RIGHT OUTER JOIN
--							 ,FULL OUTER JOIN
--							 ,CROSS JOIN)

-- ANSI 표준 : 테이블1 JOIN 테이블2 ON 연결된 컬럼1 = 컬럼2 
-- 앞에있는 애를 선행 테이블이라고함

SELECT *
	FROM T1 JOIN T2
		ON T1.EX_ID = T2.EX;
-- 여기서 NULL 없애고 이름순으로 ASC

-- 이너 조인
SELECT ID || NAME || ADDRESS
	FROM T1 JOIN T2
		ON T1.EX_ID = T2.EX
			WHERE AUTH IS NOT NULL
				ORDER BY NAME;

-- 실습 )PLAYER, TEAM 선수이름과 팀 이름을 출력
SELECT PLAYER_NAME, TEAM_NAME
	FROM PLAYER P JOIN TEAM T
		ON P.TEAM_ID = T.TEAM_ID;
	
SELECT *
	FROM T1, T2; -- 카티시안 프로덕트 -- 크로스조인 CARTESIAN PRODUCT
	
SELECT *
	FROM T1, T2
		WHERE T1.EX_ID = T2.EX; -- FROM절에서 사용하는 JOIN

-- 20190129

-- 집합연산자
-- UNION, UNION ALL,INTERSECT, MINUS(EXCEPT)

-- K 리그 소속 선수들 중에서 소속이 삼성 블루윙즈(K02)인 선수들과
-- 전남드레곤즈팀(K07)인 선수들에 대한 내용을 모두 보고싶다.

SELECT PLAYER_NAME, PLAYER_ID, TEAM_ID
	FROM PLAYER
		WHERE TEAM_ID = 'K02'
			OR TEAM_ID = 'K07';

SELECT PLAYER_NAME, PLAYER_ID, TEAM_ID
	FROM PLAYER
		WHERE TEAM_ID IN ('K02','K07');

-- K02의 결과를 조회함 + K07의 결과를 조회 => 합침

SELECT '삼성블루윙즈' 팀명, PLAYER_NAME, PLAYER_ID, TEAM_ID 팀아이디
	FROM PLAYER
		WHERE TEAM_ID IN ('K02')
UNION
SELECT '드래곤즈' ,PLAYER_NAME, PLAYER_ID, TEAM_ID 팀바보
	FROM PLAYER
		WHERE TEAM_ID IN ('K07');
--** 주의점
-- A 결과와 B 결과의 컬럼의 갯수와 타입이 같아야함
-- 컬럼의 이름은 A 결과의 컬럼명만 사용가능
-- ORDER BY는 UNION이 정의된 마지막에만 사용하면 A혹은 B의 SQL 문에는 사용불가
	
-- 2) K-리그 소속 선수들 중에서 소속이 삼성블루윙즈인 선수들과 -- OR 과가 중요해요~
-- 포지션이 골키퍼인 선수들을 모두 보고싶다.
SELECT PLAYER_NAME, PLAYER_ID, TEAM_ID
	FROM PLAYER
		WHERE TEAM_ID = 'K02' OR "POSITION" = 'GK';
		
SELECT PLAYER_NAME, PLAYER_ID, TEAM_ID
	FROM PLAYER
		WHERE TEAM_ID = 'K02' AND "POSITION" = 'GK';
		
SELECT PLAYER_NAME, PLAYER_ID, TEAM_ID
	FROM PLAYER
		WHERE (TEAM_ID,"POSITION") IN (('K02','GK'));

-- 중복 4명 : 2007067, 2007004, 2007203, 2007035
SELECT *
	FROM (SELECT PLAYER_NAME, PLAYER_ID, TEAM_ID
				FROM PLAYER
					WHERE (TEAM_ID) IN ('K02')
			UNION
			SELECT PLAYER_NAME, PLAYER_ID, TEAM_ID
				FROM PLAYER
					WHERE ("POSITION") IN ('GK'))
	WHERE PLAYER_ID IN (2007067, 2009004, 2007203, 2007035);
-- UNION ALL 이라하면 8명 나옴
	
-- 3) K-리그 소속 선수들 중에서 포지션별 평균키와
-- 팀별 평균키를 알고싶다.
SELECT "POSITION", TEAM_ID, AVG(HEIGHT)
	FROM PLAYER
		WHERE "POSITION" IS NOT NULL
			GROUP BY "POSITION", TEAM_ID
				ORDER BY 1;

-- 이런 식으로 할 수 있는데, UNION을 사용해서 하자,,,
SELECT TEAM_ID,"POSITION",
		AVG(CASE TEAM_ID WHEN 'K01' THEN HEIGHT,
			CASE TEAM_ID WHEN 'K02' THEN HEIGHT END)
	FROM PLAYER
		WHERE "POSITION" IS NOT NULL
			GROUP BY "POSITION", TEAM_ID
				ORDER BY 1;


SELECT '포지션' 기준, "POSITION" 포지션, TRUNC(AVG(HEIGHT))
	FROM PLAYER
		WHERE "POSITION" IS NOT NULL
		GROUP BY "POSITION"
UNION
SELECT '팀' ,TEAM_ID, TRUNC(AVG(HEIGHT))
	FROM PLAYER
		GROUP BY TEAM_ID;
		
-- K리그 소속선수들 중에서 소속이 삼성블루윙즈팀이면서
-- 포지션이미드필더가아닌 선수들의정보를 보고싶다.

-- 기본 쿼리로	
SELECT *
	FROM PLAYER
--		WHERE TEAM_ID = 'K02'
--		AND "POSITION" != 'MF'
--			WHERE TEAM_ID = 'K02'
--		AND "POSITION" ^= 'MF'
--			WHERE TEAM_ID = 'K02'
--		AND "POSITION" <> 'MF'
--			WHERE TEAM_ID = 'K02'
--		AND NOT "POSITION" = 'MF'; -- NOT 연산자는 꼭 컬럼명 앞에 사용하는데 IS NOT NULL은 괜춘
-- 		WHERE NOT (TEAM_ID != 'K02' OR POSITION = 'MF');		
-- MINUS

-- NOT IS NULL --> 틀린 문법
		
SELECT *
	FROM PLAYER
		WHERE TEAM_ID = 'K02'
MINUS
SELECT *
	FROM PLAYER
		WHERE "POSITION" = 'MF';
	
-- K-리그 소속 선수들 중에서 소속이 삼성블루윙즈이면서
-- 포지션이 골키퍼인 선수들의 정보를 보고싶다.
-- UNION ALL (A결과와 B 결과를 같이 보여줌)
-- UNION (A결과와 B결과를 보여주는 같은 중복의 값을 제거하고 보여줌)
-- UNION ALL과 UNION의 중복되는 값을 확인하고 싶다면 INTERSECT
SELECT *
	FROM PLAYER
		WHERE TEAM_ID = 'K02'
			AND "POSITION" = 'GK';
		
SELECT *
	FROM PLAYER
		WHERE TEAM_ID = 'K02'
INTERSECT
SELECT *
	FROM PLAYER
		WHERE "POSITION" = 'GK';

-- ROWNUM 이 두가지 형태가 있어요
-- WINDOW FUNCTION ROW_NUMBER() OVER() -- 연관 서브 쿼리
-- EXISTS 존재하는 것들을 찾아내는애

	
-- 소속팀이 'K02'이면서 포지션이 MF가 아닌 선수들을 보고싶다
SELECT *
	FROM PLAYER MainP
	WHERE "TEAM_ID" = 'K02'
	AND NOT EXISTS (SELECT 'XX' FROM PLAYER SubP
					WHERE MainP.PLAYER_ID = SubP.PLAYER_ID
						AND SubP."POSITION"='MF');
						
SELECT *
	FROM PLAYER MainP
	WHERE "TEAM_ID" = 'K02'
	AND NOT EXISTS (SELECT 'XX' FROM PLAYER SubP
					WHERE MainP.PLAYER_ID = SubP.PLAYER_ID
						AND SubP."POSITION"='MF');					
-- FROM 절에있는놈 메모리에 확(두 개) 올라갔었는데 > 셀프조인 해서 COST가 줄어듦					
					
-- ROWNUM은 결과 만들어지는 것이 아니라
--실행순서 : FROM-> WHERE -> SELECT -> ORDER BY
-- FROM 절에서SELECT 절으로 만들어지면서 번 부터 차례로 만들어짐

					
-- 셀프조인(계층형쿼리) : 정합의 문제 (테이블과 테이블을 붙였을 때의 문제점)는 해결되지만, 갱신이상이 발생할 수 있음
-- INSERT UPDATE DELETE(SELECT 빼고) 회사에서 꺼려하는이유란다.
-- 사용하는 이유가, 식별자이기 때문에 그냥 씀 업데이트 안해도되니깐

SELECT EMPNO, MGR
	FROM EMP
		ORDER BY 2 DESC;

-- 계층형 쿼리
-- FROM절 뒤에 : 시작점과 이동경로 -> START WITH CONNECT BY PRIOR
-- SELECT 절에 사용  옵션:  LEVEL(순위 1부터 증가), CONNECT_BY_ISLEAF(말단)
--				 	   SYS_CONNECT_BY_PATH(현재의 값을 상위에서 하위로 추적결과 보여줌)
-- 					   CONNECT_BY_ROOT(최상위 값을 찾아줌)

-- LPAD(값, 반복) : 값을 몇 번 반복시켜서 왼쪽(오른쪽 : RPAD) 붙임
	
SELECT E1.EMPNO 나,E1.MGR 상사, E2.MGR|| ENAME "순위상사"
	FROM EMP E1 JOIN EMP E2
		ON E1.MGR = E2.EMPNO
	
SELECT LEVEL EMPNO,MGR
	FROM EMP
	START WITH MGR IS NULL
	CONNECT BY PRIOR EMPNO =MGR
	ORDER BY 1;


SELECT LEVEL, LPAD(' ',4*LEVEL -1 )|| EMPNO, CONNECT_BY_ISLEAF)
LPAD: MPNO, MGR, CONNECT_BY_ISLEAF
	FROM EMP
	START WITH MGR IS NULL
	CONNECT BY PRIOR EMPNO =MGR
	ORDER BY 1;



-- 취상위지역방향전게
ㄴ	SELECT LEVEL EMPNO, MGR
	FROM EMP	
			START WITH
			
--계층형 쿼리
--FROM절 뒤에: 시작점과 이동경로->START WITH CONNECT BY PRIOR
--옵션:LEVEL 1->2(순위)
--    CONNECT_BY_ISLEAF (끝,말단)
--   SYS_CONNECT_BY_PATH (현재의 값을 상위에서 하위로 추적결과)
--    CONNECT_BY_ROOT (최상위 값을 보여줌)
--**LPAD(값,반복):값을 몇번 반복시켜서 왼쪽(오른쪽:RPAD) 붙임

			
			
			----- 민지
			
			
			
			-------- 계층형 쿼리 (SELF JOIN 셀프 조인)------
-- 정합성(테이블을 붙였을 때)의 문제는 해결이 되나, 갱신(UPDATE)이상이 발생할 수 있다.
-- INSERT, DELETE, UPDATE의 이상 (갱신이상때문에 실무에서 사용을 꺼린다) (식별자로 되어있는 경우에만 사용)
-- 사원번호 / 매니저 (사원번호) 
-- 그룹웨어에서 사용.
SELECT JOB, EMPNO, MGR FROM EMP;

SELECT JOB, EMPNO, MGR FROM EMP
   WHERE MGR = '7369';
   
SELECT E.EMPNO, E.ENAME, E.MGR, M.ENAME, M.MGR
   FROM EMP E, EMP M WHERE E.MGR=M.EMPNO;

-- 계층형 쿼리********** 문법 아래:
-- FROM 절 뒤에: 시작점과 이동경로 -> START WITH CONNECT BY PRIOR
-- SELECT 절에 사용: LEVEL(순위 1-> 증가), 
--      CONNECT_BY_ISLEAF(말단?), \
--      SYS_CONNECT_BY_PATH(현재의 값을 상위에서 하위로 추적결과),
--      CONNECT_BY_ROOT(최상위 값을 찾아줌)

-- *** LPAD(값, 반복) : 값을 몇 번 반복시켜서 왼쪽(오른쪽:RPAD)에 붙임

SELECT E1.EMPNO 나, E1.ENAME, E1.MGR 상사, E2.ENAME, E2.MGR "2순위상사"
   FROM EMP E1 JOIN EMP E2
      ON E1.MGR = E2.EMPNO;

SELECT * FROM EMP;


-- 위에 복잡하죠..
-- 최상위 직원부터 "순방향 전개"
SELECT LEVEL ,EMPNO, MGR
   FROM EMP
   START WITH MGR IS NULL 
   CONNECT BY PRIOR EMPNO = MGR
-- CONNECT BY MGR = PRIOR EMPNO; 도 사용 가능 (PRIOR 시작점)
   ORDER BY 1;
-- 사원에서 관리자로 가기 때문에 PRIOR EMPNO = MGR

SELECT LEVEL, LPAD(' ',3*LEVEL-1) || EMPNO, MGR, CONNECT_BY_ISLEAF "말단여부"
   FROM EMP
   START WITH MGR IS NULL
   CONNECT BY MGR = PRIOR EMPNO
   ORDER BY 1;
-- LPAD로 띄어쓰기를 추가해서 레벨별로 보기 편하게 함.

-- 7566의 하위 직원들을 보고 싶다 (7566이 보이지 않네요) 
-- 7566도 보고 싶으면 그 윗단계부터 시작해야 합니다.
SELECT LEVEL, LPAD(' ',3*LEVEL-1) || EMPNO, MGR, CONNECT_BY_ISLEAF "말단여부"
   FROM EMP
   START WITH MGR = '7566'
   CONNECT BY MGR = PRIOR EMPNO
   ORDER BY 1;

SELECT LEVEL, LPAD(' ',3*LEVEL-1) || EMPNO, MGR, CONNECT_BY_ISLEAF "말단여부"
   FROM EMP
   START WITH EMPNO = '7566'
   CONNECT BY MGR = PRIOR EMPNO
   ORDER BY 1;
   
------- 최상위 직원부터 "역방향 전개"
SELECT LEVEL, EMPNO, MGR, CONNECT_BY_ISLEAF
   FROM EMP
      START WITH EMPNO = 7369
      CONNECT BY PRIOR MGR = EMPNO;
      

------ 최상위 값, 현재값의 추적 값들
SELECT LEVEL, LPAD(' ',3*LEVEL-1) || EMPNO 사원번호, 
       MGR, CONNECT_BY_ISLEAF 말단여부,
      CONNECT_BY_ROOT EMPNO "최상위 사원", 
      SYS_CONNECT_BY_PATH(EMPNO, '>') 경로추적
   FROM EMP
   START WITH MGR IS NULL
   CONNECT BY MGR = PRIOR EMPNO
   ORDER BY 1;
  
  ------ 민지
			
			
			
SELECT E1.EMPNO 나,E1.MGR 상사, E2.MGR || E2.ENAME "2순위상상"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;

SELECT E1.EMPNO, E1.MGR, E2.EMPNO, E2.MGR, E2.ENAME
	FROM EMP E1 JOIN EMP E2
	ON E1.MGR = E2.EMPNO;

SELECT LEVEL, EMPNO, MGR
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR--CONNECT BY MGR=PRIOR EMPNO;(같음)
ORDER BY 1;

SELECT LEVEL, LPAD('   ',4*LEVEL-1)||EMPNO, MGR, CONNECT_BY_ISLEAF 
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO =MGR
ORDER BY 1;

--7566의 하위 직원들을 보고싶다.
SELECT LEVEL, LPAD('  ',4*LEVEL-1)||EMPNO, MGR ,CONNECT_BY_ISLEAF 
FROM EMP
START WITH MGR ='7566'
CONNECT BY MGR=PRIOR EMPNO
ORDER BY 1;

--최상위 직원부터 순방향 전개

SELECT LEVEL, EMPNO, MGR
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO =MGR
ORDER BY 1;

--최상위 직원부터 역방향 전개
SELECT LEVEL, EMPNO, MGR
FROM EMP
START WITH EMPNO='7369'
CONNECT BY PRIOR MGR = EMPNO;

--최상위 값, 현재값의 추적값들
SELECT LEVEL, LPAD('  ',4*LEVEL-1)||EMPNO, MGR ,CONNECT_BY_ISLEAF,
  CONNECT_BY_ROOT EMPNO "최상위 사원",SYS_CONNECT_BY_PATH(EMPNO,">") 경로
FROM EMP
START WITH MGR IS NOT NULL
CONNECT BY MGR =PRIOR EMPNO
ORDER BY 1;

-- 20190130 -- 서브쿼리
-- 서브쿼리

-- 최근에는 서브쿼리 걷어내는 추세
-- 1) 스칼라 서브쿼리 : FROM 절 외에 다 사용
-- 스칼라 서브쿼리는 회사에서는 잘 안씀
-- 예) EMP 테이블에서 평균 급여와 사원의 정보를 출력
SELECT EMP.*, (SELECT AVG(SAL)
					FROM EMP) 평균급여
		FROM EMP;
--	예) 선수들의 평균키보다 큰 선수들의 정보를 출력
SELECT *
	FROM PLAYER
		WHERE HEIGHT > (SELECT AVG(HEIGHT) FROM PLAYER);
-- 집계함수는 SELECT절이나 HAVING절에 올 수 있으며, WHERE 절에는 올 수가 없다.
-- 2) 인라인뷰 : FROM절에 사용
-- 잘 씀 , 속도면에서나 가독성 면에서 좋음
-- 예 ) 선수들의 BMI지수 계산하여 25보다 큰 선수들을 출력
	
SELECT TEAM_ID, PLAYER_ID, PLAYER_NAME,
		WEIGHT/(HEIGHT*HEIGHT)*10000 BMI
	FROM PLAYER;

SELECT *
	FROM (SELECT TEAM_ID, PLAYER_ID, PLAYER_NAME,
				WEIGHT/(HEIGHT*HEIGHT)*10000 BMI
					FROM PLAYER)
	WHERE BMI > 22;

-- 서브쿼리 없이 만들기
SELECT TEAM_ID, PLAYER_ID, PLAYER_NAME, WEIGHT/(HEIGHT*HEIGHT)*10000 BMI
	FROM PLAYER
		WHERE WEIGHT/(HEIGHT*HEIGHT)*10000 > 22

-- 예) 급여순으로 높은 사람 5명을 추출		
SELECT ROWNUM, ENAME, SAL
	FROM (SELECT * FROM EMP
			ORDER BY SAL DESC)
	WHERE ROWNUM <= 5;

SELECT  급여, EMP.* -- 번호 안겹치게 하는 쿼리도 있음
	FROM EMP	
		ORDER BY SAL DESC;
		
-- 스칼라 서브쿼리 
-- 결과 AVG <- 단일 값
-- 문제 ) 정현수가 소속된 팀의 선수들을 알고싶다.
SELECT *
	FROM PLAYER	
		WHERE PLAYER_NAME = '정현수';
		
SELECT *
	FROM PLAYER
		WHERE TEAM_ID IN (SELECT TEAM_ID -- 다중행 함수 
							FROM PLAYER	
								WHERE PLAYER_NAME = '정현수');
								
-- 문제 ) 각 팀별 가장 키큰 선수의 정보를 출력

SELECT P.TEAM_ID, PLAYER_NAME, HEIGHT
	FROM PLAYER P, (SELECT TEAM_ID, MAX(HEIGHT) MH
						FROM PLAYER
							GROUP BY TEAM_ID) HP
	WHERE P.TEAM_ID = HP.TEAM_ID
	AND HEIGHT = MH
		ORDER BY 1, 3;
	
-- 영재군의 소스
SELECT *
	FROM PLAYER P1 JOIN (SELECT TEAM_ID, MAX(HEIGHT) HEIGHT
							FROM PLAYER
								GROUP BY TEAM_ID) P2
	USING(TEAM_ID)
	WHERE P1.HEIGHT = P2.HEIGHT;
	

SELECT *
	FROM PLAYER
		WHERE (HEIGHT,TEAM_ID) IN (SELECT MAX(HEIGHT), TEAM_ID
										FROM PLAYER
											GROUP BY TEAM_ID)

-- 연관 서브 쿼리											
SELECT *
	FROM PLAYER P1 
		WHERE (TEAM_ID, HEIGHT) = (SELECT TEAM_ID, MAX(HEIGHT)
										FROM PLAYER P2
											WHERE P1.TEAM_ID = P2.TEAM_ID
												GROUP BY TEAM_ID);

-- 문제 ) 20120501부터 20120502 사이에 경기가 있는 경기장을 조회
SELECT *
	FROM STADIUM JOIN SCHEDULE
		USING(STADIUM_ID)
			WHERE SCHE_DATE BETWEEN 20120501 AND 20120502;
			
-- 책에서는 연관 서브 쿼리를 이용해서 풀고 있음. EXISTS
SELECT *
	FROM STADIUM ST
		WHERE EXISTS(SELECT 'XX'
						FROM SCHEDULE SC
							WHERE ST.STADIUM_ID = SC.STADIUM_ID
								AND SCHE_DATE BETWEEN 20120501 AND 20120502);
								
SELECT *
	FROM STADIUM ST
		WHERE EXISTS(SELECT 'XX'
						FROM SCHEDULE SC
							WHERE ST.STADIUM_ID = SC.STADIUM_ID
								AND SCHE_DATE BETWEEN 20120501 AND 20120502);
	
							
-- 연관 서브 쿼리 적은 걸 선행테이블로 하는 것이 좋아
-- EXISTS는 맞으면 SELECT 절로 던져줌!
							
-- RBO(RULE BASE), CBO(금액이 작으면 빠르다)
-- RBO를 가지고 튜닝을 하니까 알아주면 좋아. = 이 제일빠르고 그다음이 범위 가장 느린게 LIKE
							
-- INSERT문에서의 서브쿼리

-- 반정규화 : 정규화 테이블의 이상현상 제거(1차, 2차, 3차, BCNF, 4차, 5차)
-- 1차 : 한 컬럼의 값이 두 개 이상인 것을 테이블로 나눠라

-- 이상현상 : 삽입, 갱신, 삭제

SELECT * FROM TEAM;
SELECT * FROM STADIUM;


ALTER TABLE TEAM ADD (STADIUM_NAME VARCHAR2(40)); -- DDL이라서 커밋 필요 없음 수정되면 바로 들어감

-- UPDATE 테이블명 SET 컬럼 = 값 WHERE 조건절
UPDATE TEAM T1 SET T1.STADIUM_NAME = (SELECT STADIUM_NAME -- 이럴 때 사용하는 게 서브쿼리다. 연관서브 쿼리
											FROM STADIUM S1
													WHERE T1.STADIUM_ID = S1.STADIUM_ID); -- 엑셀 VLOOKUP

-- INSERT
-- 사원 EMPNO : 신입사원 입사시 현재의 사원번호에서 가장 큰 번호 + 1만듬

SELECT MAX(EMPNO) FROM EMP;

INSERT INTO EMP (EMPNO, ENAME, DEPTNO)
	VALUES ((SELECT MAX(EMPNO) FROM EMP) + 1,'이영재','20');
	
-- VIEW : 보안성, 독립성, 편리성
-- 테이블이 물리적으로 존재하지 않고, 가상으로 있음
CREATE VIEW YOUNGJAE_TABLE AS (SELECT P1.*
								FROM PLAYER P1 JOIN (SELECT TEAM_ID, MAX(HEIGHT) HEIGHT
									FROM PLAYER
										GROUP BY TEAM_ID) P2
								ON P1.TEAM_ID = P2.TEAM_ID
										WHERE P1.HEIGHT = P2.HEIGHT);
										
SELECT * FROM YOUNGJAE_TABLE;
DROP VIEW YOUNGJAE_TABLE;

--20190131
-- 그룹함수 : AVG(), MAX(), MIN(), COUNT() -> 집계함수
-- 		 : GROUP BY ~ HAVING
-- GROUP BY 뒤에서의 옵션 : ROLLUP, CUBE, GROUPING SETS
--						SELECT절에서 - GROUPING
--> 통계함수를 만들어 줌(소계, 총계, N과 N의 소계)
-- ROLLUP은 : 선택된 컬럼의 소계를 나타냄(DNAME, JOB) -> DNAME에 묶여있는 JOB, DNAME, 전체 

-- 예제 ) 부서명과 업무명을 기준으로 사원수와 급여합을 집계
-- ROLLUP(DEPTNO) -> DEPTNO의 소계를 출력
SELECT DEPTNO, COUNT(*), SUM(SAL)
	FROM EMP
		WHERE DEPTNO IS NOT NULL
		GROUP BY ROLLUP(DEPTNO)
			ORDER BY 1;
		
-- 교제에선
-- ROLLUP(DEPTNO) -> DEPTNO의 소계를 출력
-- 3개의 종류의 DNAME -> 3개의 소계
-- 전체			  -> 전체소계
-- DNAME + JOB 		-> N개의 소계
SELECT JOB, DNAME, SUM(SAL)
	FROM EMP JOIN DEPT
		USING(DEPTNO)
	GROUP BY JOB, ROLLUP(JOB,DNAME)
		ORDER BY DNAME;
		
		
SELECT DNAME, SUM(SAL), COUNT(*)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
		GROUP BY ROLLUP(DNAME, JOB)
		ORDER BY DNAME;
	
-- SELECT절의 GROUPING 컬럼의 GROUP 되었다면 1 아니면 0
SELECT DNAME, GROUPING(DNAME),SUM(SAL), COUNT(*)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
		GROUP BY ROLLUP(DNAME, JOB)
		ORDER BY DNAME;
	
SELECT DNAME, GROUPING(DNAME),GROUPING(JOB),SUM(SAL), COUNT(*)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
		GROUP BY ROLLUP (DNAME,JOB)
		ORDER BY DNAME;
	
SELECT CASE GROUPING(DNAME)
		WHEN 1 THEN '총계'
		ELSE DNAME END DN,
		CASE GROUPING(JOB)
		WHEN 1 THEN '소계'
		ELSE JOB END J,SUM(SAL), COUNT(*)
	FROM EMP E, DEPT D
		WHERE E.DEPTNO = D.DEPTNO
		GROUP BY ROLLUP (DNAME,JOB)
		ORDER BY DNAME;
	
CREATE VIEW NEWEMP AS(SELECT * FROM EMP JOIN DEPT USING(DEPTNO));

SELECT * FROM NEWEMP; -- JOIN된 테이블 -- 가상의 테이블 EMP와 DEPT가 바뀌면 같이 바뀜

SELECT DNAME, JOB, COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY DNAME, JOB;

-- ** GROUP BY의 컬럼이 우선이 되고 그 다음에 ROLLUP이 실행됨.
SELECT DNAME, JOB, COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY ROLLUP(DNAME), JOB;
-- 위랑 같은 연산입니다. 이거 헷갈리지마센 SQL 연산자가 우선임
SELECT DNAME, JOB, COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY JOB, ROLLUP(DNAME);
	
SELECT DNAME, JOB, COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY ROLLUP(JOB), ROLLUP(DNAME)
		ORDER BY DNAME, JOB;
-- 위와 같은 결과가 나옵니다... ^^
SELECT DNAME, JOB, COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY ROLLUP(DNAME), ROLLUP(JOB)
		ORDER BY DNAME, JOB;
	
SELECT DNAME, JOB, COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY ROLLUP(JOB, DNAME);	

SELECT DNAME, JOB, MGR,COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY ROLLUP(DNAME, JOB, MGR) -- 3개 묶인거 -> 두개 묶인거 -> 1개 묶인거 각각의 통계 다나옴
		ORDER BY DNAME;	
	
SELECT DNAME, JOB, MGR,COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY ROLLUP(DNAME, (JOB, MGR)) -- 3개 묶인거 -> 두개 묶인거 -> 1개 묶인거
		ORDER BY DNAME;

-- 큐브는 발생될 수 있는 모든 조건의 통계를 작성해준다.
SELECT DNAME, JOB,COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY CUBE(DNAME,JOB)
		ORDER BY DNAME;
-- 위와 같은 쿼리 순서에 상관이 없다.
SELECT DNAME, JOB,COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY CUBE(JOB, DNAME)
		ORDER BY DNAME;

-- 원하는 컬럼의 통계만 보고싶다.
-- 컬럼의 순서는 바뀌어도 상관이가 없다.
SELECT DNAME, JOB, COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY GROUPING SETS(DNAME,JOB);

	
-- 제일 쓸 데 없지만 시험에 나오는 애
	SELECT DNAME, JOB, MGR,COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY GROUPING SETS(DNAME,JOB, MGR)
		ORDER BY DNAME;
	
-- DNAME SUM COUNT
SELECT DNAME,'JOB',0, SUM(SAL), COUNT(*)
	FROM NEWEMP
		GROUP BY DNAME
UNION
-- JOB SUM COUNT
SELECT '_',JOB,0, SUM(SAL), COUNT(*)
	FROM NEWEMP
		GROUP BY JOB
UNION
-- MEG SUM COUNT
SELECT '_','_',MGR, SUM(SAL), COUNT(*)
	FROM NEWEMP
		GROUP BY MGR;

SELECT DNAME, JOB, MGR,COUNT(*), SUM(SAL)
	FROM NEWEMP
		GROUP BY GROUPING SETS((DNAME,JOB, MGR),(DNAME,JOB),(JOB, MGR))
		ORDER BY DNAME;

-- 385PAGE
-- WINDOW 함수
-- 왜 윈도우 함수라고 할까?
-- 오라클이나 안시표준에서 제공하는 함수 : 빌트인함수
-- 원래 없지만 SQL문을 작성하면 힘들어서 만들어준 메소드
-- SQL문을 메소드처럼 만드는 것 -> PL/SQL(TRIGGER)
-- 내가 뭔가있다가 , 반응이 있으면 시작!하는애
-- TRIGGER : 자동으로 실행되는 PL함수
-- 메소드() OVER(문법)

-- 1) 순위함수 
-- ROWNUM, RANK, DENSE_RANK
-- 필수 조건 : 정렬

-- 문제 ) 급여가 높은 순서대로 순위를 매겨주세요	
SELECT  ROWNUM 급여순,EMP.*
	FROM (SELECT *
			FROM EMP ORDER BY SAL DESC) EMP;
-- 위에꺼를 만들어낸 PL/SQL이 아래꺼			
SELECT ROW_NUMBER() OVER (ORDER BY SAL) 급여순, EMP.*
	FROM EMP;
			
SELECT RANK() OVER (ORDER BY SAL), EMP.*
	FROM EMP;
	
SELECT DENSE_RANK() OVER (ORDER BY SAL), EMP.*
	FROM EMP;



---------190201----------다시 시작!!!!

-- 390page
-- 일반집계함수(SUM, AVG, COUNT)
-- 예제 ) 사원들의 급여와 같은 매니저를 두고 있는 사원들의 급여의 합을 구하세요
--		-> 쪼개면 사원들의 급여, 같은 매니저를 두고 있는 사원들의 급여 합!

SELECT *
	FROM EMP E1, (SELECT MGR, SUM(SAL)
					FROM EMP
						GROUP BY MGR) E2
	WHERE E1.MGR = E2.MGR
	ORDER BY 4;

SELECT ENAME, EMPNO, SUM(SAL) OVER(PARTITION BY MGR)
	FROM EMP;

-- WINDOWING 절
-- WINDOW절에서 OVER에 사용됨
-- 반드시 ORDER BY 전제되어있어야함
-- (RANGE, ROWS), (PRECEDING, FOLLOWING), (CURRENT ROW, UNBOUNCED) , BETWEEN A AND B
-- DEFAULT 값은 RANGE UNBOUNCED PRECEDING

SELECT ENAME, EMPNO, MGR, SAL, SUM(SAL) OVER(PARTITION BY MGR) T
	FROM EMP
		ORDER BY 3, 4;
	
SELECT ENAME, EMPNO, MGR, SAL, SUM(SAL) OVER(PARTITION BY MGR ORDER BY SAL) T
	FROM EMP
		ORDER BY 3, 4;

SELECT ENAME, EMPNO, MGR, SAL, SUM(SAL) OVER(ORDER BY SAL) T -- SAL이 같으면 동일하게 나옴 RANK 사용한듯
	FROM EMP;
	
SELECT ENAME, EMPNO, MGR, SAL, SUM(SAL) OVER(ORDER BY SAL RANGE UNBOUNDED PRECEDING) T
	FROM EMP;

-- MAX
-- 예제 ) 사원들의 급여
--		같은 매니저를 두고 있는 사원들의 급여의 최댓값
SELECT EMPNO, ENAME, SAL, MGR, MIN(SAL) OVER (PARTITION BY MGR) T
	FROM EMP;
-- ORDER BY를 안 쓰면 RANGE UNBOUNCED PRECEDING이 안 맞음

-- 책에 있는 놈중에 가장 문제가 되는 친구
SELECT EMPNO, ENAME, SAL, MGR, HIREDATE,
		MIN(SAL) OVER (PARTITION BY MGR
						ORDER BY HIREDATE DESC) T
	FROM EMP;


SELECT EMPNO, ENAME, SAL, MGR, HIREDATE,
		MIN(SAL) OVER (PARTITION BY MGR
						ORDER BY SAL DESC
							RANGE UNBOUNDED PRECEDING) T
	FROM EMP;

SELECT EMPNO, ENAME, SAL, MGR, HIREDATE,
		MIN(SAL) OVER (PARTITION BY MGR
						ORDER BY HIREDATE DESC
							RANGE UNBOUNDED PRECEDING) T
	FROM EMP;

SELECT EMPNO, ENAME, SAL, MGR, HIREDATE,
		MIN(SAL) OVER(PARTITION BY MGR	
						ORDER BY HIREDATE
							ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) T
	FROM EMP;
	
SELECT EMPNO, ENAME, SAL, MGR, HIREDATE,
		MIN(SAL) OVER(PARTITION BY MGR	
						ORDER BY HIREDATE
							ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) T
	FROM EMP;
	
-- COUNT
-- ROWS :  물리적인 구분 1칸 1칸 뒤
-- RANGE : 50 이상 150 이하와 같이 범위가 변화하는 것.

-- 예제 ) 사원들을 급여 기준으로 정렬
--		급여가 자신보다 50 이하 & 150 이상인 인원을 알고싶다. 자신포함

SELECT ENAME, SAL, COUNT(*) OVER(ORDER BY SAL
								RANGE BETWEEN 50 PRECEDING AND 150 FOLLOWING) T
	FROM EMP;

-- 순서함수(마지막값, 처음값)
-- LAST_VALUE, FIRST_VALUE

-- 부서별 직원들의 연봉이 높은 순서로 정렬
-- 파티션 내에서 가장 먼저나온 값을 (최고 급여 사람 출력)
SELECT DEPTNO, ENAME, SAL
	FROM EMP
		ORDER BY DEPTNO;

SELECT E3.DEPTNO, ENAME, MAX(E3.SAL)
	FROM (SELECT E1.DEPTNO, ENAME, E1.SAL 
		FROM EMP E1, (SELECT DEPTNO, MAX(SAL) MS
						FROM EMP
							GROUP BY DEPTNO
								ORDER BY DEPTNO) E2
		WHERE E1.DEPTNO = E2.DEPTNO
			AND E1.SAL = E2.MS) E3
	GROUP BY E3.DEPTNO, ENAME
		ORDER BY DEPTNO;

SELECT E3.DEPTNO, ENAME, E3.SAL
	FROM (SELECT E1.DEPTNO, ENAME, E1.SAL 
			FROM EMP E1, (SELECT DEPTNO, SAL, MAX(SAL) MS
							FROM EMP
								GROUP BY DEPTNO, SAL
									ORDER BY DEPTNO, SAL DESC) E2
			WHERE E1.DEPTNO = E2.DEPTNO
				AND E1.SAL = E2.MS) E3
	GROUP BY E3.DEPTNO, ENAME
		ORDER BY E3.SAL;

-- 영재 님
SELECT * FROM EMP E1,
	(SELECT DEPTNO,ENAME,SAL
		FROM EMP
			WHERE (DEPTNO,SAL) IN (SELECT DEPTNO,MAX(SAL)
									FROM EMP
										WHERE MGR IS NOT NULL
											GROUP BY DEPTNO)) E2
		WHERE E1.DEPTNO=E2.DEPTNO
	ORDER BY E1.DEPTNO;

-- FIRST_VALUE
SELECT DEPTNO, ENAME,
		FIRST_VALUE(ENAME) OVER(PARTITION BY DEPTNO
									ORDER BY SAL DESC, ENAME) T,
		SAL
FROM EMP;

-- FIRST_VALUE
SELECT DEPTNO, ENAME,
		FIRST_VALUE(ENAME) OVER(PARTITION BY DEPTNO
									ORDER BY SAL DESC, ENAME
										ROWS UNBOUNDED PRECEDING) T,
		SAL
FROM EMP;

-- LAST_VALUE : 마지막 범위를 현재 줄에서 GROUP BY 마지막 범위까지 선택
--						CURRENT ROW UNBOUNCED FOLLOWING
SELECT DEPTNO, ENAME, SAL,
		LAST_VALUE(ENAME) OVER(PARTITION BY DEPTNO
									ORDER BY SAL DESC
										ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) T
FROM EMP;

SELECT DEPTNO, SAL
FROM EMP
	GROUP BY DEPTNO;

SELECT DEPTNO, SUM(SAL)
FROM EMP
	GROUP BY DEPTNO;

SELECT DEPTNO,SAL, SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL)
FROM EMP;

-- LAG, LEAD
-- 선행되어있는 값을 가져옴, 후행의 값을 가져옴

SELECT ENAME, SAL, LAG(ENAME,4,0) OVER(ORDER BY SAL DESC) LAG,
		LEAD(ENAME,1,1) OVER(ORDER BY SAL DESC) LEAD
FROM EMP;
			
-- 비율 함수
-- RATIO_TO_REPORT : 전체 중에서 내가 차지하는 비율
-- PERCENT_RANK : 1과 0 사이의 비율
-- CUME_DIST : 누적해서 비율을 말해주는 친구
-- 			   전체 값의 갯수를 비율로 나눈 후 누적
		
SELECT ENAME, SAL, TRUNC(RATIO_TO_REPORT(SAL) OVER() * 100) RATIO,
		TRUNC(PERCENT_RANK() OVER(ORDER BY SAL)*100) PERCENT,
		TRUNC(CUME_DIST() OVER(ORDER BY SAL DESC)*100) CUME
FROM EMP;


-- DCL(DATABASE CONTOL LANGEAGE) : 권한(GRANT), 회수(REVORK), COMMIT(적용), ROLLBACK(취소)
-- DDL(DATABASE DEFINED LANGEAGE) : 생성(CREATE), 삭제(DROP), 변경(ALTER)
--> 무조건 다 AUTOCOMMIT -> 바로 적용 : 롤백 같은 거 없다!


-- 마이그레이션, 데이터 구축
-- 빅데이터(정형데이터, 비정형데이터, 반정형데ㅔ이터)
-- 정형데이터 : DBMS(속성, 엔티티, 컬럼, 키, 제약조건, 정규화)
-- 비정형데이터 : 명사, 동사, 형용사 -> 엑셀, 기/값
-- 반정형데이터 : DBMS에 들어가있지 않음 -> KEY/VALUE(배열, JSON, EXCEL)

-- DDL을 시작하려면 데이터의 유형을 먼저 알아야함(문자, 숫자, 날짜) DB는 알아서 호환이 됨
-- 문자(CHAR,VARCHAR2), 숫자(NUMBER(10,2)), 날짜(DATE 년월일 시분초 YYYYMMDD (24)hhmiss))
-- CHAR와 VARCHAR는 다르다. CHAR와 CHAR을 비교할 때는 빈공간을 채워서 비교를 해야한다.

-- 모델? 모델링? 정보?
-- 정보는 컴퓨터화된 모든것 우리가 알고있는 모든것
-- 모델링 : 하나의 주제를 가지고 모아놓은 것
-- 모델링이란 주제에 맞춰 정보를 맞춰 정보를 모아 모델(저장될 수 있는 형태)로 만듦
-- 모델의 3대 요소 : 추상화, 단순화, 명확화

-- 모델링이랑 무엇일까?
-- 

-- 학생 테이블을 만든다고 치면
-- 첫번째로 생각해야할 것이 식별자(identifier) : 첫글자 숫자, 공백, 특수문자(_, $, # 제외) 안됨
-- 두번째 컬럼명(단수를 사용, 업무상 의미있는 단어를 사용), 주소를 예로 들면 si gun gu dong
-- 세번째 컬럼의 타입
-- 네번째 컬럼의 크기 : ATTRIBUTE value, ATTRIBUTE

-- 이해관계자 : 모델링을 통해서 완성된 dm을 사용하는 모든 사람들(교무처장, 학생, 강사, 교사,<- 유저/ dba와 어플리케이션 개발자포함)
-- 학생에 관련한 이해관계자
-- 학번, 이름, 학년, 주소, 전화번호, 학과, 생년월일
-- 이렇게 컬럼을 모아두고 타입을 생각해보자
-- NUMBER 9, varchar2 20, varchar2 50, varchar2 11(숫자는 맨 앞에 0이 들어갈 수 없으므로 varchar2)
-- varchar2 20, DATE date는 크기가 없음

-- 다시 식별자로 돌아가서 이름을 정해보자
-- HAKBUN, NAME, ADDRESS, PHONE, MAJOR, BIRTH


-- DDL의 특징은 AUTO COMMIT

CREATE TABLE EDU_INFO(
	HAKBUN NUMBER(9),
	NAME VARCHAR2(20),
	ADDRESS VARCHAR2(50),
	PHONE VARCHAR2(11),
	MAJOR VARCHAR2(20),
	BIRTH DATE
);

-- 컬럼정의 방식 바로 옆에다가 제약조건을 넣고 / 테이블 정의 방식 컬럼 다 적은 이후에 제약조건을 적음 

DROP TABLE EDU_INFO;

CREATE TABLE EDU_INFO(
	HAKBUN NUMBER(9), -- NOT NULL, -- 컬럼 LEVEL 정의 방식
	NAME VARCHAR2(20),
	ADDRESS VARCHAR2(50),
	PHONE VARCHAR2(11),
	MAJOR VARCHAR2(20),
	BIRTH DATE
--	CONSTRAINT EDN_INFO_PK PRIMARY KEY (HAKBUN) -- 테이블 LEVEL 정의방식
);

-- 제약조건 : NOT NULL, PK, FK, CHECK, DEFAULT : 이거 다섯개 뿐이 없음

-- DDL 컬럼 추가
-- EDU_INFO 테이블에 컬럼 재학여부(DELFLAG CHAR(1))
-- 컬럼추가의 단점 : 추가된 컬럼은 맨뒤에 붙는다.(앞에다 생성하기 없음)


-- 지금 부터의 모든 명령어는 ALTER

-- ALTER의 기본 SYNTEX
-- ALTER [적용대상(TABLE, USER)] 테이블명/계정명[명령어 ADD, MODIFY] [컬럼 수정내용]


ALTER TABLE EDU_INFO ADD (DELFLAG CHAR(1));

-- DROP은 두가지형태가 있음
-- 테이블 통째로 날리는 거랑 컬럼 날리는거

-- 컬럼 삭제
ALTER TABLE EDU_INFO DROP (DELFLAG);
ALTER TABLE EDU_INFO DROP COLUMN DELFLAG;

-- 컬럼 수정
-- 컬럼 이름을 바꾸는 것은 아님, 컬럼의 제약 조건을 바꾸는 것
-- NAME을 NOT NULL, BIRTH DEFAULT SYSDATE
ALTER TABLE EDU_INFO MODIFY (NAME NOT NULL, BIRTH DEFAULT SYSDATE);
-- 타입을 한 번 바꿔 보겠습니다.
ALTER TABLE EDU_INFO MODIFY (ADDRESS VARCHAR2(100));
-- 여기에서 특징일 몇가지있어요.

-- 테이블의 값이 없음 경우
-- 다 된다 (NOT NULL, 크기, 타입 등 다 가능)

-- 테이블 값이 있을 경우
-- 테이블의 컬럼 값 중 NULL이 있는 경우 NOT NULL 제약조건 할 수 없음
-- 크기는 줄일 수 없다. 키울수만 있음
-- TYPE은 값이있으면 변경이 가능하다.
-- DEFAULT는 적용한 순간부터 적용이되며 이전의 데이터는 적용이 되지 않는다.

ALTER TABLE EDU_INFO MODIFY (BIRTH); -- DEFAULT 옶션을 지우려면 다른 명령을사용해야함 DROP이나
ALTER TABLE EDU_INFO MODIFY (NAME VARCHAR2(20));

-- RENAME 그냥 쓰면 테이블명 ALTER쓰면 COLUMN명

-- 컬럼명 변경하기
ALTER TABLE EDU_INFO RENAME COLUMN PHONE TO TEL;

-- 제약조건 변경하기
-- NAME에 NOT NULL 조건인 SYS_C007333 삭제
ALTER TABLE EDU_INFO DROP CONSTRAINT SYS_C007333;

-- 제약조건 추가하기(값이 없는 상태, PK 무결성 제약조건, FK 키값 자식-부모가 존재하는지)
-- 제약조건 추가 시 가장 중요한 것 !!! -> 굉장히 애매한거 PK FK 관계 근데 FK가 더 애매해
ALTER TABLE EDU_INFO ADD CONSTRAINT EDU_INFO_PK PRIMARY KEY (HAKBUN);

ALTER TABLE EDU_INFO DROP CONSTRAINT EDU_INFO_PK;

-- 삭제시 자식 다음 부모 생성할 땐 부모 다음 자식

-- 테이블명 변경 : 회사에서 진짜 바꾸지 않습니다.
ALTER TABLE EDU_INFO RENAME TO STUDENT;

GRANT DBA, CONNECT, RESOURCE TO HR;

-- CASCADE CONSTRAINTS 옵션을 사용하지않을 경우 삭제가 되지않음
-- 옵션을 사용하지앓으면 자식테이블 찾아서 삭제한 후 삭제
-- 가장 좋은건 제약조건 삭제한 후에 하는 것이 좋음
DROP TABLE EDU_INFO; -- CASCADE CONSTRAINTS; -- 물려있는 모든 친구들을 추적해서 삭제

-- 삭제 명령어는 3가지가 있음 : DROP, DELETE, TRUNCATE
-- DROP 테이블을 삭제(CASCADE 옵션) : 테이블이 가지고 있는 값 + 테이블 삭제
-- DELETE, TRUNCATE : 테이블의 구조는 유지하고 값만 삭제

-- SYNTEX : DELETE FROM 테이블명(DML)
-- TRUNCATE TRUNCATE TABLE 테이블명(DDL) - 자동 COMMIT 

-- DELETE TABLE은 명령어를 EXECUTE한 후에 ROLLBACK이가능함 -> DELETE LOG 저장 -> 데이터가 많은 경우 부하가 심함
-- TRUNCATE TABLE은 -> DELETE LOG를 생성하지않음 -> 복구 불가능