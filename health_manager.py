import pymysql
from pymysql.cursors import Cursor

# db 연결하는 함수
def get_db_connection() -> pymysql.Connection:
    try:
        return pymysql.connect(
            host="localhost",
            port=3307,
            user="root",
            password='1234',
            database='health_db'
        )
    except Exception as e:
        print(f"데이터베이스 연결 실패: {e}")
        exit(1)

def add_record(cursor: Cursor): #사용자 입력 받기
    """건강 기록 추가"""
    
    try: #에러가 나면 예외처리를 하기 위해서    
        height = int(input('키를 입력하세요.(cm): '))
        weight = int(input('몸무게를 입력하세요.(kg): '))
        blood_pressure = input('혈압을 입력해주세요.(수축/이완) ')
        memo = input('기타사항: ')

        sql = '''
            INSERT INTO health_records (height, weight, blood_pressure, memo)
            VALUES (%s, %s, %s, %s)        
        ''' 

        cursor.execute(sql, (height, weight, blood_pressure, memo))
        print('건강 기록이 추가 되었습니다.')
    except ValueError: #try랑 같이 쌍으로 다니기 / 예외 어케 할껀데
        print('키와 몸무게는 숫자만 입력해주세요.')
    except Exception as e:
        print(f'기록 작성 중 오류가 발생: {e}')

def get_records(cursor: Cursor): #등록된 정보 가져오기
    # 쿼리 작성
    sql = "SELECT id, height, weight, blood_pressure, memo, created_at FROM health_records ORDER BY created_ at DESC"
    # 쿼리 실행
    cursor.execute(sql)
    # 실행된 쿼리에서 튜플 가져오기
    records = cursor.fetchall()

    if not records:
        print('등록된 정보가 없습니다.')
        return
    
    print('\n=== 건강 기록 정보 ===')
    for record in records:
        id, height, weight, blood_pressure, memo, created_at = record

        print('[ID]: {id}')
        print('키(cm): {height}, 몸무게(kg): {weight}')
        print('혈압: {blood_pressure}')
        print('작성 일시: {created_at}')

def update_record(cursor: Cursor):
    try:
        id = int(input('수정할 ID: '))

        n_weight = int(input('수정할 키를 입력하세요.(cm): '))
        n_height = int(input('수정할 몸무게를 입력하세요.(kg): '))
        n_blood_pressure = input('수정할 혈압을 입력하세요.(수축/이완): ')
        n_memo = input('수정할 메모사항을 입력하세요')

        sql = '''
            UPDATE health_records SET height = %s, weight = %s, blood_pressure = %s, memo WHERE id = %s
        '''

        cursor.execute(sql, (n_weight, n_height, n_blood_pressure, n_memo, id))
    except ValueError:
        print('ID, 키, 몸무게는 숫자로 입력하세요.')
    except Exception as e:
        print('기록 수정 중 오류 발생: {e}')

def delete_record(cursor: Cursor):
    raise Exception("함수 미구현")

def show_menu() -> str:
    """메뉴 표시"""
    print("\n=== 건강 관리 프로그램 ===")
    print("1. 건강 기록 추가")
    print("2. 건강 기록 조회")
    print("3. 건강 기록 수정")
    print("4. 건강 기록 삭제")
    print("5. 종료")
    return get_user_choice()

def get_user_choice() -> str:
    """사용자 선택 입력"""
    return input("\n선택: ")

def main():
    """메인 함수"""
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        while True:
            choice = show_menu()

            if choice == "1":
                add_record(cursor)
                conn.commit()
            elif choice == "2":
                get_records(cursor)
            elif choice == "3":
                update_record(cursor)
                conn.commit()
            elif choice == "4":
                delete_record(cursor)
                conn.commit()
            elif choice == "5":
                print("프로그램을 종료합니다.")
                break
            else:
                print("올바른 메뉴를 선택해주세요.")

    except Exception as e:
        print(f"프로그램 실행 중 오류 발생: {e}")
        conn.rollback()

    finally:
        cursor.close()
        conn.close()

if __name__ == '__main__':
    main()
