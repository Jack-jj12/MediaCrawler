# 数据库配置
# 原始配置（已注释）
# DB_HOST = "192.168.121.212"  # 数据库主机地址
# DB_PORT = 3306  # 数据库端口
# DB_USER = "root"  # 数据库用户名
# DB_PASSWORD = "2496051005"  # 替换为你的数据库密码
# DB_DATABASE = "mediacrawler"  # 数据库名称

# Neon.tech 云数据库配置
DB_HOST = "ep-cool-silence-a4q9k7fm-pooler.us-east-1.aws.neon.tech"  # 替换为你的neon.tech数据库主机地址
DB_PORT = 5432  # PostgreSQL默认端口
DB_USER = "neondb_owner"  # 替换为你的neon.tech用户名
DB_PASSWORD = "npg_Bmyev4dOc0xV"  # 替换为你的neon.tech密码
DB_DATABASE = "mideacrawl"  # 数据库名称

# 注意：Neon.tech使用PostgreSQL数据库，与MySQL有所不同
# 在DBeaver中连接时，请选择PostgreSQL连接类型

# 声明：本代码仅供学习和研究目的使用。使用者应遵守以下原则：  
# 1. 不得用于任何商业用途。  
# 2. 使用时应遵守目标平台的使用条款和robots.txt规则。  
# 3. 不得进行大规模爬取或对平台造成运营干扰。  
# 4. 应合理控制请求频率，避免给目标平台带来不必要的负担。   
# 5. 不得用于任何非法或不当的用途。
#   
# 详细许可条款请参阅项目根目录下的LICENSE文件。  
# 使用本代码即表示您同意遵守上述原则和LICENSE中的所有条款。  


import os

# PostgreSQL config for Neon.tech
RELATION_DB_PWD = os.getenv("RELATION_DB_PWD", "your_password")  # 替换为你的neon.tech密码
RELATION_DB_USER = os.getenv("RELATION_DB_USER", "neon_user")  # 替换为你的neon.tech用户名
RELATION_DB_HOST = os.getenv("RELATION_DB_HOST", "ep-cool-flower-123456.us-east-2.aws.neon.tech")  # 替换为你的neon.tech主机地址
RELATION_DB_PORT = os.getenv("RELATION_DB_PORT", 5432)  # PostgreSQL默认端口
RELATION_DB_NAME = os.getenv("RELATION_DB_NAME", "mideacrawl")


# redis config
REDIS_DB_HOST = "127.0.0.1"  # your redis host
REDIS_DB_PWD = os.getenv("REDIS_DB_PWD", "123456")  # your redis password
REDIS_DB_PORT = os.getenv("REDIS_DB_PORT", 6379)  # your redis port
REDIS_DB_NUM = os.getenv("REDIS_DB_NUM", 0)  # your redis db num

# cache type
CACHE_TYPE_REDIS = "redis"
CACHE_TYPE_MEMORY = "memory"