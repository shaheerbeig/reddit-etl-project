from airflow.providers.postgres.hooks.postgres import PostgresHook
import pandas as pd
import os
from pathlib import Path

def accessing_files_in_directory():
    postgres_hook = PostgresHook(postgres_conn_id='reddit_postgre')
    engine = postgres_hook.get_sqlalchemy_engine()
    directory = Path("/opt/airflow/data/bronze")
    
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.csv'):
                file_path = os.path.join(subdir, file)
                print(f"Processing: {file}")
                df = pd.read_csv(file_path)
                df.to_sql("reddit_bronze", engine, if_exists="append", index=False)
