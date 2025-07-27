FROM astrocrpublic.azurecr.io/runtime:3.0-6
# Use the latest Astro Runtime image

RUN pip install dbt-snowflake==1.9.4