# 声明：本代码仅供学习和研究目的使用。使用者应遵守以下原则：  
# 1. 不得用于任何商业用途。  
# 2. 使用时应遵守目标平台的使用条款和robots.txt规则。  
# 3. 不得进行大规模爬取或对平台造成运营干扰。  
# 4. 应合理控制请求频率，避免给目标平台带来不必要的负担。   
# 5. 不得用于任何非法或不当的用途。
#   
# 详细许可条款请参阅项目根目录下的LICENSE文件。  
# 使用本代码即表示您同意遵守上述原则和LICENSE中的所有条款。  


# -*- coding: utf-8 -*-
# @Time    : 2024/6/20
# @Desc    : 异步PostgreSQL的增删改查封装，用于支持neon.tech云数据库
from typing import Any, Dict, List, Union

import asyncpg


class AsyncPgDB:
    def __init__(self, pool: asyncpg.Pool) -> None:
        self.__pool = pool

    async def query(self, sql: str, *args: Union[str, int]) -> List[Dict[str, Any]]:
        """
        从给定的 SQL 中查询记录，返回的是一个列表
        :param sql: 查询的sql
        :param args: sql中传递动态参数列表
        :return:
        """
        async with self.__pool.acquire() as conn:
            # PostgreSQL使用$1, $2等作为参数占位符，而不是MySQL的%s
            # 将MySQL风格的查询转换为PostgreSQL风格
            pg_sql = self._convert_to_pg_style(sql)
            rows = await conn.fetch(pg_sql, *args)
            # 将Record对象转换为字典
            return [dict(row) for row in rows] if rows else []

    async def get_first(self, sql: str, *args: Union[str, int]) -> Union[Dict[str, Any], None]:
        """
        从给定的 SQL 中查询记录，返回的是符合条件的第一个结果
        :param sql: 查询的sql
        :param args:sql中传递动态参数列表
        :return:
        """
        async with self.__pool.acquire() as conn:
            pg_sql = self._convert_to_pg_style(sql)
            row = await conn.fetchrow(pg_sql, *args)
            return dict(row) if row else None

    async def item_to_table(self, table_name: str, item: Dict[str, Any]) -> int:
        """
        表中插入数据
        :param table_name: 表名
        :param item: 一条记录的字典信息
        :return: 插入记录的ID
        """
        fields = list(item.keys())
        values = list(item.values())
        # PostgreSQL中字段名使用双引号而不是反引号
        fields = ["\""+field+"\"" for field in fields]
        fieldstr = ','.join(fields)
        # 使用$1, $2等作为参数占位符
        placeholders = [f'${i+1}' for i in range(len(item))]
        valstr = ','.join(placeholders)
        sql = f"INSERT INTO {table_name} ({fieldstr}) VALUES({valstr}) RETURNING id"
        
        async with self.__pool.acquire() as conn:
            # 在PostgreSQL中使用RETURNING子句获取插入的ID
            row = await conn.fetchrow(sql, *values)
            return row['id'] if row else 0

    async def update_table(self, table_name: str, updates: Dict[str, Any], field_where: str,
                           value_where: Union[str, int, float]) -> int:
        """
        更新指定表的记录
        :param table_name: 表名
        :param updates: 需要更新的字段和值的 key - value 映射
        :param field_where: update 语句 where 条件中的字段名
        :param value_where: update 语句 where 条件中的字段值
        :return: 更新的行数
        """
        upsets = []
        values = []
        counter = 1
        
        for k, v in updates.items():
            # PostgreSQL中字段名使用双引号
            s = f'\"{k}\"=${counter}'
            upsets.append(s)
            values.append(v)
            counter += 1
            
        upsets = ','.join(upsets)
        # 添加where条件的值到参数列表
        values.append(value_where)
        
        sql = f'UPDATE {table_name} SET {upsets} WHERE \"{field_where}\"=${counter}'
        
        async with self.__pool.acquire() as conn:
            # PostgreSQL的execute返回字符串如'UPDATE 1'，需要提取数字
            result = await conn.execute(sql, *values)
            # 提取更新的行数
            return int(result.split()[1]) if result else 0

    async def execute(self, sql: str, *args: Union[str, int]) -> int:
        """
        需要更新、写入等操作的 excute 执行语句
        :param sql: SQL语句
        :param args: 参数
        :return: 影响的行数
        """
        async with self.__pool.acquire() as conn:
            # 处理MySQL风格的SQL语句
            pg_sql = self._convert_to_pg_style(sql)
            result = await conn.execute(pg_sql, *args)
            # 尝试提取影响的行数
            try:
                if result and ' ' in result:
                    return int(result.split()[1])
                return 0
            except (ValueError, IndexError):
                return 0
    
    def _convert_to_pg_style(self, sql: str) -> str:
        """
        将MySQL风格的SQL转换为PostgreSQL风格
        - 替换反引号为双引号
        - 处理AUTO_INCREMENT等MySQL特有语法
        :param sql: MySQL风格的SQL
        :return: PostgreSQL风格的SQL
        """
        # 替换反引号为双引号
        sql = sql.replace('`', '\"')
        
        # 替换MySQL的AUTO_INCREMENT为PostgreSQL的SERIAL
        sql = sql.replace('AUTO_INCREMENT', 'SERIAL')
        
        # 处理表引擎和字符集设置
        if 'ENGINE=' in sql:
            # 移除MySQL特有的表引擎和字符集设置
            parts = sql.split('ENGINE=')
            if len(parts) > 1:
                # 找到分号前的位置
                engine_part = parts[1]
                if ';' in engine_part:
                    sql = parts[0] + ';'
        
        return sql