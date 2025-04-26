import psycopg2
from psycopg2.pool import SimpleConnectionPool
import os

# 数据库连接配置
DB_CONFIG = {
    'dbname': 'mediacrawler',
    'user': 'neondb_owner',
    'password': 'npg_Bmyev4dOc0xV',  # 请修改为你的实际密码
    'host': 'ep-cool-silence-a4q9k7fm-pooler.us-east-1.aws.neon.tech',
    'port': '5432'
}

# 创建连接池
db_pool = None

def init_db_pool(min_conn=1, max_conn=10):
    """初始化数据库连接池"""
    global db_pool
    try:
        db_pool = SimpleConnectionPool(min_conn, max_conn, **DB_CONFIG)
        print("数据库连接池初始化成功")
    except Exception as e:
        print(f"数据库连接池初始化失败: {str(e)}")
        raise

def get_connection():
    """从连接池获取连接"""
    if db_pool is None:
        init_db_pool()
    return db_pool.getconn()

def return_connection(conn):
    """将连接返回到连接池"""
    if db_pool is not None:
        db_pool.putconn(conn)

def init_tables():
    """初始化数据库表"""
    conn = None
    try:
        conn = get_connection()
        cur = conn.cursor()
        
        # 读取SQL文件
        sql_file_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'schema', 'tables.sql')
        with open(sql_file_path, 'r', encoding='utf-8') as f:
            sql_commands = f.read()
        
        # 执行SQL命令
        cur.execute(sql_commands)
        conn.commit()
        print("数据库表创建成功")
        
    except Exception as e:
        if conn:
            conn.rollback()
        print(f"创建表失败: {str(e)}")
        raise
    finally:
        if cur:
            cur.close()
        if conn:
            return_connection(conn)

def insert_data(table_name, data_dict):
    """插入数据到指定表
    
    Args:
        table_name (str): 表名
        data_dict (dict): 要插入的数据字典，键为列名，值为对应的值
    """
    conn = None
    try:
        conn = get_connection()
        cur = conn.cursor()
        
        columns = list(data_dict.keys())
        values = list(data_dict.values())
        placeholders = ['%s'] * len(values)
        
        query = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({', '.join(placeholders)})"
        cur.execute(query, values)
        conn.commit()
        
    except Exception as e:
        if conn:
            conn.rollback()
        print(f"插入数据失败: {str(e)}")
        raise
    finally:
        if cur:
            cur.close()
        if conn:
            return_connection(conn)

if __name__ == '__main__':
    # 初始化数据库连接池和表
    init_db_pool()
    init_tables()