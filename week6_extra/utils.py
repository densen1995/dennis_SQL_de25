import pandas as pd
import duckdb


def query_database(
    query: str, db_path: str = "data/lecture13.duckdb"
) -> pd.DataFrame:
    """convenience function to open a duckdb database connection and query it"""
    with duckdb.connect(db_path) as conn:
        return conn.execute(query=query).df()