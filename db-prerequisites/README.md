# 🗄️ Database Prerequisites

> ⚠️ **Important**: These are database setup requirements, **NOT** Airflow requirements!

## 🎯 Purpose

This folder contains the essential database setup scripts that must be executed **before** running dbt models through Airflow. While Airflow itself doesn't require these scripts, your **dbt transformations will fail** without proper database preparation.

## 📋 What's Inside

| File | Purpose | Required |
|------|---------|----------|
| `snowflake_setup.sql` | Complete Snowflake database setup | ✅ **Essential** |

## 🚨 Critical Setup Steps

### 1. 🏗️ **Database Foundation** 
Execute `snowflake_setup.sql` in your Snowflake environment to create:
- 📊 `SAMPLE_DB` database
- 🏪 `RAW` schema (for source data)
- 📈 `ANALYTICS` schema (for dbt outputs)
- 📦 Sample data tables (`orders`, `customers`)

### 2. 🔗 **Airflow Integration**
Ensure your Airflow Snowflake connection (`snowflake_default`) points to:
- Database: `SAMPLE_DB`
- Default Schema: `ANALYTICS`

### 3. ✅ **Verification**
After setup, verify with these queries:
```sql
-- Check source data
SELECT * FROM SAMPLE_DB.RAW.orders LIMIT 5;

-- After dbt runs, check outputs
SELECT * FROM SAMPLE_DB.ANALYTICS.stg_orders LIMIT 5;
```

## 🎨 Visual Workflow

```mermaid
graph LR
    A[🗄️ Run db-prerequisites] --> B[🔧 Configure Airflow]
    B --> C[🚀 Execute dbt via Airflow]
    C --> D[✨ Success!]
    
    style A fill:#ff6b6b,color:#fff
    style B fill:#4ecdc4,color:#fff
    style C fill:#45b7d1,color:#fff
    style D fill:#96ceb4,color:#fff
```

## ⭐ Pro Tips

- 💡 **Run Once**: Execute these scripts only during initial setup
- 🔄 **Re-runnable**: Scripts use `IF NOT EXISTS` for safety
- 🎯 **Environment**: Can be run in any Snowflake environment (dev/staging/prod)
- 📝 **Logging**: Check Snowflake query history for execution status

## 🆘 Troubleshooting

| Issue | Solution |
|-------|----------|
| 🚫 dbt models fail | ➡️ Run `snowflake_setup.sql` first |
| 🔌 Connection errors | ➡️ Verify Airflow Snowflake connection |
| 📊 No source data | ➡️ Check `RAW.orders` table exists |
| 🔍 Empty results | ➡️ Verify sample data was inserted |

---

💫 **Remember**: Database first, then Airflow magic! ✨
