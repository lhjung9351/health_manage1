.PHONY: help install setup db-start db-stop db-status db-init run clean

help:
	@echo "=== 건강 관리 프로그램 Makefile ==="
	@echo ""
	@echo "사용 가능한 명령어:"
	@echo "  make install    - 필수 패키지 설치"
	@echo "  make setup      - 프로그램 설치 (myhealth 명령어 등록)"
	@echo "  make db-start   - MySQL Docker 컨테이너 시작"
	@echo "  make db-stop    - MySQL Docker 컨테이너 중지"
	@echo "  make db-status  - MySQL Docker 컨테이너 상태 확인"
	@echo "  make db-init    - 데이터베이스 및 테이블 초기화"
	@echo "  make run        - 프로그램 실행"
	@echo "  make clean      - 컨테이너 및 볼륨 삭제"
	@echo ""
	@echo "처음 시작하는 경우:"
	@echo "  1. make install"
	@echo "  2. make db-start"
	@echo "  3. make db-init"
	@echo "  4. make setup"
	@echo "  5. make run (또는 myhealth 명령어)"

install:
	@echo "필수 패키지 설치 중..."
	pip install -r requirements.txt

setup:
	@echo "프로그램 설치 중..."
	pip install -e .
	@echo ""
	@echo "설치 완료! 이제 터미널에서 'myhealth' 명령어를 사용할 수 있습니다."

db-start:
	@echo "MySQL Docker 컨테이너 시작 중..."
	docker-compose up -d
	@echo "컨테이너가 시작되었습니다. 잠시 후 데이터베이스가 준비됩니다."
	@echo "10초 대기 중..."
	@sleep 3
	@echo "데이터베이스 준비 완료!"

db-stop:
	@echo "MySQL Docker 컨테이너 중지 중..."
	docker-compose down

db-status:
	@echo "Docker 컨테이너 상태:"
	@docker ps -a | grep mysql || echo "mysql 컨테이너가 없습니다."
	@echo ""
	@echo "데이터베이스 목록:"
	@docker exec mysql-container mysql -uroot -p1234 -e "SHOW DATABASES;" 2>/dev/null || echo "컨테이너가 실행 중이 아닙니다."

db-init:
	@echo "데이터베이스 초기화 중..."
	@echo "health_db 데이터베이스 생성..."
	@docker exec mysql-container mysql -uroot -p1234 -e "CREATE DATABASE IF NOT EXISTS health_db;" 2>/dev/null
	@echo "health_records 테이블 생성..."
	@docker exec mysql-container mysql -uroot -p1234 health_db < init_health.sql 2>/dev/null
	@echo ""
	@echo "데이터베이스 초기화 완료!"
	@echo "현재 테이블:"
	@docker exec mysql-container mysql -uroot -p1234 health_db -e "SHOW TABLES;" 2>/dev/null

run:
	@echo "건강 관리 프로그램 실행..."
	python health_manager.py

clean:
	@echo "주의: 이 명령은 컨테이너와 모든 데이터를 삭제합니다!"
	@read -p "계속하시겠습니까? (y/N): " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		docker-compose down -v; \
		echo "컨테이너와 볼륨이 삭제되었습니다."; \
	else \
		echo "취소되었습니다."; \
	fi
