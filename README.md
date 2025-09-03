# Reddit ETL Pipeline with Airflow

This project extracts data from the Reddit API, processes it using a **Medallion Architecture (Raw → Bronze → Silver)**, and stores it in PostgreSQL. Orchestration is handled by **Apache Airflow**.

---

## 🚀 Features
- Extract Reddit data via API
- Transform & clean data
- Load into PostgreSQL
- Orchestrated with Airflow
- Dockerized setup

---

## ⚙️ Setup

1. Clone the repo:
```bash
git clone https://github.com/YOUR_USERNAME/reddit-etl-project.git
cd reddit-etl-project
```
2. Environment Variables:
Create a .env file in the root folder based on .env.example:
- REDDIT_CLIENT_ID=your_client_id
- REDDIT_SECRET=your_secret
- REDDIT_USER_AGENT=your_agent
- DB_HOST=localhost
- DB_USER=postgres
- DB_PASS=yourpassword
- DB_NAME=redditdb

3. Install dependencies:
pip install -r requirements.txt

4. Start Airflow with Docker:
docker-compose up -d

5. Open Airflow UI:
http://localhost:8080

## Architecture
- Raw Layer → Extract Reddit API data and store as-is.
- Bronze Layer → Clean and structure raw JSON into tabular format.
- Silver Layer → Enrich and transform data for analytics.
- PostgreSQL → Final storage for queries and reporting.
- Airflow → Orchestrates the entire pipeline using DAGs.

## Tech Stack
- Python → ETL scripts
- Apache Airflow → Workflow orchestration
- PostgreSQL → Data storage
- Docker & Docker Compose → Containerized setup
- PRAW (Python Reddit API Wrapper) → Reddit API extraction