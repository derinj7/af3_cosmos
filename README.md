# Airflow 3 + Cosmos + dbt + Snowflake Demo

This repository provides a comprehensive demo project illustrating the integration of:

- **Apache Airflow 3.0** - Modern workflow orchestration
- **Astronomer Cosmos** - dbt integration for Airflow
- **dbt (Data Build Tool)** - SQL-based data transformation
- **Snowflake** - Cloud data warehouse

## 🏗️ Project Structure

```
af3_cosmos/
├── dags/                           # Airflow DAG definitions
│   ├── dbt_snowflake_dag.py       # Main dbt DAG with manifest loading
│   └── dbt_manifest_verification.py # Manifest validation DAG
├── dbt/snowflake_demo/             # dbt project
│   ├── models/
│   │   ├── staging/                # Staging layer models
│   │   ├── marts/                  # Data mart models  
│   │   ├── example/                # Example dbt models
│   │   └── sequential/             # Sequential processing models
│   ├── target/                     # dbt compiled artifacts
│   │   └── manifest.json          # Pre-compiled dbt manifest
│   └── dbt_project.yml            # dbt project configuration
├── db-prerequisites/              # Database setup prerequisites
│   └── snowflake_setup.sql        # Snowflake database setup script
├── tests/                          # Test files
├── requirements.txt                # Python dependencies
|-- Dockerfile                      # Container definition
```

## 🚀 Key Features

### Multiple DAG Patterns
- **Full Project DAG**: Runs all dbt models with manifest loading
- **Manifest Verification**: Validates dbt manifest integrity
> More patterns coming soon! Feel free to fork and contribute via PR.

### Advanced Cosmos Configuration
- **Manifest Loading**: Uses pre-compiled `manifest.json` for faster task generation
- **Snowflake Integration**: Native Snowflake profile mapping
- **Local Execution**: Direct dbt execution without virtual environments
- **DBT Runner Mode**: Optimized performance with `InvocationMode.DBT_RUNNER`

### dbt Project Structure
- **Layered Architecture**: Staging → Marts data flow
- **Sequential Models**: 10-step data processing pipeline
- **Schema Testing**: Data quality validation
- **Snowflake Optimized**: Designed for Snowflake-specific features

## 📋 Prerequisites

1. **Snowflake Account**: Active Snowflake warehouse
2. **Astronomer CLI**: For local development
3. **Docker**: Container runtime
4. **Snowflake Connection**: Configured in Airflow

## 🗄️ Snowflake Database Setup

Before running the dbt models through Airflow, you need to set up your Snowflake database with the required source data.

### Quick Setup

1. **Execute the setup script**: Run the SQL commands in `db-prerequisites/snowflake_setup.sql` in your Snowflake environment. This script will:
   - Create the `SAMPLE_DB` database
   - Create `RAW` and `ANALYTICS` schemas
   - Create and populate the `orders` table with sample data
   - Create and populate the `customers` table (optional, for future use)
   

## 🎯 DAG Configuration Highlights

### Manifest-Based Rendering
```python
render_config = RenderConfig(
    load_method=LoadMode.DBT_MANIFEST,
)
```

### Snowflake Profile Mapping
```python
profile_config = ProfileConfig(
    profile_name="snowflake_demo",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_default",
        profile_args={"schema": "ANALYTICS", "threads": 4}
    )
)
```

### Optimized Execution
```python
execution_config = ExecutionConfig(
    execution_mode=ExecutionMode.LOCAL,
    invocation_mode=InvocationMode.DBT_RUNNER
)
```

## 🔍 Available DAGs

1. **dbt_snowflake_cosmos_dag_1**: Main production DAG
2. **dbt_manifest_verification**: CI/CD validation

## 📚 Explore More

- **[Astronomer Cosmos Documentation](https://astronomer.github.io/astronomer-cosmos/)** → Comprehensive guide for dbt + Airflow integration
- **[Astronomer Cosmos Source Code](https://github.com/astronomer/astronomer-cosmos)** → Latest features, examples, and community contributions