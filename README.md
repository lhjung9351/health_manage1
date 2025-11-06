# 🩺 Health Management CLI Program

## 📘 프로젝트 개요

이 프로젝트는 **Python**과 **MySQL**을 사용하여 간단한 건강 기록 관리 프로그램을 제공합니다. 사용자는 **CLI(Command Line Interface)** 를 통해 건강 기록을 **추가**, **조회**, **수정**, **삭제**할 수 있으며, 데이터는 `health_db`의 `health_records` 테이블에 안전하게 저장됩니다. (로컬 MySQL 또는 Docker 기반 MySQL 8.0 환경 사용 가능)

---

## 🚀 주요 기능

| 기능           | 설명                                            |
| ------------ | --------------------------------------------- |
| 1️⃣ 건강 기록 추가 | 키(cm), 몸무게(kg), 혈압(수축/이완), 메모를 입력해 DB에 저장합니다. |
| 2️⃣ 건강 기록 조회 | 저장된 건강 기록을 최신순으로 조회합니다.                       |
| 3️⃣ 건강 기록 수정 | ID 기준으로 키/몸무게/혈압/메모를 수정합니다.                   |
| 4️⃣ 건강 기록 삭제 | 더 이상 필요 없는 기록을 삭제합니다.                         |

---

## ⚙️ 빠른 실행

```bash
pip install pymysql
python main.py
```

메뉴 예시:

```
1. 건강 기록 추가
2. 건강 기록 조회
3. 건강 기록 수정
4. 건강 기록 삭제
5. 종료
```

> 기본 접속 정보(코드 내 설정): `host=localhost`, `port=3307`, `user=root`, `password=1234`, `database=health_db`

---

## 🗄️ 테이블 구조(요약)

```sql
CREATE TABLE health_records (
  id INT AUTO_INCREMENT PRIMARY KEY,
  height INT NOT NULL,
  weight INT NOT NULL,
  blood_pressure VARCHAR(15) NOT NULL,
  memo VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 🧩 기술 스택

**Python 3.9+**, **MySQL 8.x**, **PyMySQL**

---

> 필요시 상세 설치/문제 해결/개선 포인트는 확장형 README를 참고하세요.
