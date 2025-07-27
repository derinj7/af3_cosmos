from datetime import datetime
from airflow import DAG
from airflow.providers.standard.operators.bash import BashOperator

default_args = {
    'owner': 'data-team',
    'retries': 0,
}

with DAG(
    'check_dbt_manifest',
    default_args=default_args,
    description='Check DBT manifest file presence and timestamp',
    schedule=None,
    start_date=datetime(2025, 1, 1),
    catchup=False,
    tags=['dbt', 'validation'],
) as dag:
    
    check_manifest = BashOperator(
        task_id='check_manifest_file',
        bash_command="""
        MANIFEST_PATH="/usr/local/airflow/dbt/snowflake_demo/target/manifest.json"
        
        echo "Checking manifest file at: $MANIFEST_PATH"
        echo "============================================"
        
        if [ -f "$MANIFEST_PATH" ]; then
            echo "✓ Manifest file exists!"
            echo ""
            echo "File details:"
            ls -la "$MANIFEST_PATH"
            echo ""
            echo "Last modified time:"
            stat -c "Modified: %y" "$MANIFEST_PATH" 2>/dev/null || stat -f "Modified: %Sm" "$MANIFEST_PATH"
            echo ""
            echo "File size:"
            du -h "$MANIFEST_PATH"
            echo ""
            echo "First 500 characters of manifest:"
            head -c 500 "$MANIFEST_PATH"
            echo ""
            echo "============================================"
            echo "Manifest validation: SUCCESS"
        else
            echo "✗ Manifest file NOT FOUND at $MANIFEST_PATH"
            echo ""
            echo "Checking parent directories:"
            ls -la /usr/local/airflow/dbt/snowflake_demo/ 2>/dev/null || echo "Project directory not found"
            ls -la /usr/local/airflow/dbt/snowflake_demo/target/ 2>/dev/null || echo "Target directory not found"
            echo ""
            echo "============================================"
            echo "Manifest validation: FAILED"
            exit 1
        fi
        """
    )