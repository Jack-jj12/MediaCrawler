# Neon.tech 云数据库配置指南

本文档将指导您如何将 MediaCrawler 项目配置为使用 Neon.tech 云数据库和 DBeaver 数据库管理工具。

## 前提条件

1. 已注册 [Neon.tech](https://neon.tech) 账户并创建项目
2. 已安装 [DBeaver](https://dbeaver.io/download/) 数据库管理工具
3. 已安装 Python 3.7+ 和项目依赖

## 安装必要的依赖

由于 Neon.tech 使用的是 PostgreSQL 数据库，我们需要安装 `asyncpg` 库：

```bash
pip install asyncpg
```

## 配置数据库连接

项目已经更新了数据库配置文件，支持 PostgreSQL 数据库。您需要修改 `config/db_config.py` 文件中的以下内容：

```python
# Neon.tech 云数据库配置
DB_HOST = "ep-cool-flower-123456.us-east-2.aws.neon.tech"  # 替换为您的neon.tech数据库主机地址
DB_PORT = 5432  # PostgreSQL默认端口
DB_USER = "neon_user"  # 替换为您的neon.tech用户名
DB_PASSWORD = "your_password"  # 替换为您的neon.tech密码
DB_DATABASE = "mediacrawler"  # 数据库名称

# PostgreSQL config for Neon.tech
RELATION_DB_PWD = os.getenv("RELATION_DB_PWD", "your_password")  # 替换为您的neon.tech密码
RELATION_DB_USER = os.getenv("RELATION_DB_USER", "neon_user")  # 替换为您的neon.tech用户名
RELATION_DB_HOST = os.getenv("RELATION_DB_HOST", "ep-cool-flower-123456.us-east-2.aws.neon.tech")  # 替换为您的neon.tech主机地址
RELATION_DB_PORT = os.getenv("RELATION_DB_PORT", 5432)  # PostgreSQL默认端口
```

## 在 Neon.tech 上创建数据库

1. 登录您的 Neon.tech 账户
2. 创建一个新项目或使用现有项目
3. 在项目中创建一个名为 `mediacrawler` 的数据库
4. 记下连接信息（主机地址、用户名、密码）

## 使用 DBeaver 连接 Neon.tech 数据库

1. 打开 DBeaver
2. 点击 "新建连接" 按钮
3. 选择 "PostgreSQL" 连接类型
4. 填写连接信息：
   - 主机：您的 Neon.tech 数据库主机地址（例如：`ep-cool-flower-123456.us-east-2.aws.neon.tech`）
   - 端口：5432
   - 数据库：mediacrawler
   - 用户名：您的 Neon.tech 用户名
   - 密码：您的 Neon.tech 密码
5. 点击 "测试连接" 确保连接成功
6. 点击 "完成" 保存连接

## 初始化数据库表结构

项目已经更新了数据库初始化代码，支持 PostgreSQL 数据库。您可以通过以下命令初始化数据库表结构：

```bash
python -c "import asyncio; from db import init_table_schema; asyncio.run(init_table_schema())"
```

或者直接运行：

```bash
python db.py
```

## 验证配置

1. 在 DBeaver 中打开您的 Neon.tech 连接
2. 展开 `mediacrawler` 数据库
3. 检查是否已创建所有表（如 `bilibili_video`、`douyin_aweme` 等）

## 故障排除

### 连接问题

- 确保您的 Neon.tech 项目处于活动状态
- 检查防火墙设置，确保允许出站连接到 Neon.tech 服务器
- 验证连接字符串中的主机地址、用户名和密码是否正确

### 表结构问题

如果在初始化表结构时遇到问题，可能是由于 MySQL 和 PostgreSQL 语法差异导致的。您可能需要修改 `schema/tables.sql` 文件，使其与 PostgreSQL 语法兼容。

## 注意事项

- Neon.tech 提供免费套餐，但有一定的资源限制，请合理使用
- 定期备份重要数据
- 在生产环境中，建议使用环境变量而不是硬编码的方式存储数据库凭据