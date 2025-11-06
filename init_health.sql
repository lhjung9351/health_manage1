SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 데이터베이스 생성 (이미 존재하면 무시)
CREATE DATABASE IF NOT EXISTS health_db;
USE health_db;

-- 건강 기록 테이블 생성
CREATE TABLE IF NOT EXISTS health_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    height INT NOT NULL COMMENT '키(cm)',
    weight INT NOT NULL COMMENT '몸무게(kg)',
    blood_pressure VARCHAR(10) NOT NULL COMMENT '수축/이완',
    memo VARCHAR(200) COMMENT '메모',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '기록 생성 시간'
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
COMMENT '건강 기록 테이블';