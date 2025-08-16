from datetime import datetime
from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig, RenderConfig, LoadMode
from cosmos.profiles import SnowflakeUserPasswordProfileMapping
from cosmos.constants import InvocationMode, ExecutionMode

# Using Airflow connection with username/password authentication
profile_config = ProfileConfig(
    profile_name="snowflake_demo",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_default",
        profile_args={
            "schema": "ANALYTICS",
            "threads": 4,
        },
    )
)

# Configure to use manifest
render_config = RenderConfig(
    load_method=LoadMode.DBT_MANIFEST,
)

# Configure execution for local mode without virtual environment
# Since dbt is installed directly in the Docker image, use LOCAL mode
execution_config = ExecutionConfig(
    # Remove dbt_executable_path since we're using system-installed dbt
    # The system will find dbt in the PATH
    execution_mode=ExecutionMode.LOCAL,
    invocation_mode=InvocationMode.DBT_RUNNER,  # Use DBT_RUNNER for better performance
)

# Project config with manifest path
project_config = ProjectConfig(
    dbt_project_path="/usr/local/airflow/dbt/snowflake_demo",
    manifest_path="/usr/local/airflow/dbt/snowflake_demo/target/manifest.json",
    # Since manifest is pre-generated in CI/CD, don't install deps
    install_dbt_deps=False,
)

dbt_snowflake_dag = DbtDag(
    project_config=project_config,
    profile_config=profile_config,
    execution_config=execution_config,
    render_config=render_config,
    schedule="@daily",
    start_date=datetime(2024, 1, 1),
    dag_id="dbt_snowflake_cosmos_dag_1",
    catchup=False,
    tags=["dbt", "cosmos", "snowflake"],
)