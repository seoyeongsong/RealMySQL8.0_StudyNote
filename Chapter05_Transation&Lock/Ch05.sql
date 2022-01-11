/* AUTO-COMMIT 기능 ON/OFF  */
SET autocommit=ON;
SET autocommit=OFF;

/* MyIsSAM과 InnoDB 테이블 생성하기 */
CREATE TABLE tab_myisam ( fdpk INT NOT NULL, PRIMARY KEY (fdpk) ) ENGINE=MyISAM;
CREATE TABLE tab_innodb ( fdpk INT NOT NULL, PRIMARY KEY (fdpk) ) ENGINE=INNODB;

/* INSERT ROW */
INSERT INTO tab_myisam ( fdpk ) VALUES ( 3 );
INSERT INTO tab_innodb ( fdpk ) VALUES ( 3 );

/* INSERT ROWS */
INSERT INTO tab_myisam ( fdpk ) VALUES ( 1 ), ( 2 ), ( 3 );
INSERT INTO tab_innodb ( fdpk ) VALUES ( 1 ), ( 2 ), ( 3 );

/* GLOBAL LOCK */
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;

/* BACKUP LOCK */
LOCK INSTANCE FOR BACKUP;
UNLOCK INSTANCE;

/* TABLE LOCK */
LOCK TABLES tab_innodb READ;
LOCK TABLES tab_innodb WRITE;
UNLOCK TABLES;

/* NAMED LOCK */
-- GET_LOCK(str, timeout) : 입력받은 str으로 timeout(s) 동안 잠금 획득
SELECT GET_LOCK('test_lock', 3);    -- 3초후 잠금 자동 해제 (잠금 획득 시 1)
SELECT IS_FREE_LOCK('test_lock');   -- 잠금이 설정되어 있는지 조회 (획득 시 1, 해제 시 0 또는 NULL)
SELECT RELEASE_LOCK('test_lock');   -- 잠금을 해제 (해제 시 1)
SELECT RELEASE_ALL_LOCKS();         -- 중첩하여 획득한 잠금을 모두 해제

/* RENAME TABLE */
RENAME TABLE tab_innodb TO tab_innodb1; -- METADATA LOCK 자동 획득 및 해제