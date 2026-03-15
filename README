# NEXUS — Criminal Network Intelligence Database

A research-grade human trafficking detection system built on MySQL 8.0 
with a live India threat map powered entirely by SQL queries.

## What This Is

NEXUS is a DBMS capstone project that models a real criminal intelligence 
database. It tracks persons, locations, incidents, criminal network 
connections, financial transactions, and evidence — all linked through 
a normalized relational schema.

The database is not just storage. It computes its own intelligence:
- Threat scores recomputed nightly via MySQL Event Scheduler
- Suspicious movements auto-flagged by triggers
- Criminal networks walked recursively in pure SQL
- Every change logged in a tamper-proof audit trail

## Technical Highlights

- **Recursive CTE** — walks criminal network graph to find kingpin
- **Window Functions** — LAG() detects suspicious movement patterns
- **GROUP BY WITH ROLLUP** — OLAP financial network analysis
- **Stored Procedure** — automated threat score engine with cursor
- **Event Scheduler** — runs every night at midnight automatically
- **5 Triggers** — passive audit logging + active movement flagging
- **ACID Transactions** — atomic incident reporting with ROLLBACK
- **3 Views** — access control abstraction layer
- **9 Indexes** — composite, covering, directional

## Stack

- MySQL 8.0
- Node.js + Express
- Leaflet.js (map)
- HTML/CSS/JS (frontend)

## Database Schema

12 tables:
- `persons` — victims, suspects, witnesses
- `locations` — safehouses, border crossings, transit hubs
- `incidents` — reported trafficking cases
- `connections` — criminal network graph (self-referencing)
- `movements` — location trails with timestamps
- `transactions` — financial trails (hawala, UPI, crypto)
- `evidence` — documents, CCTV, testimony
- `cases` — active investigations
- `case_persons` — many-to-many junction table
- `district_threat_scores` — powers the live map
- `investigators` — access-level based staff
- `audit_log` — immutable change history

## Setup

### 1. Clone the repo
\`\`\`
git clone https://github.com/ritipshah/nexus-criminal-intelligence
cd nexus-criminal-intelligence
\`\`\`

### 2. Install dependencies
\`\`\`
npm install
\`\`\`

### 3. Create .env file
\`\`\`
DB_PASSWORD=your_mysql_password
\`\`\`

### 4. Import the database
\`\`\`
mysql -u root -p < nexus_schema.sql
mysql -u root -p nexus < nexus_data.sql
\`\`\`

### 5. Start the server
\`\`\`
node server.js
\`\`\`

### 6. Open browser
\`\`\`
http://localhost:3000
\`\`\`

## Live Demo Features

- **Threat Map** — India map with color-coded district threat levels
- **Report Incident** — form that calls stored procedure directly
- **Audit Log** — live view of every database change

## Data

Based on NCRB (National Crime Records Bureau) district-level 
trafficking statistics for India. Real coordinates, real districts, 
real threat patterns.

## Normalization

Schema is normalized to 4NF:
- 1NF — atomic values, no repeating groups
- 2NF — no partial dependencies
- 3NF — no transitive dependencies  
- BCNF — every determinant is a candidate key
- 4NF — no multi-valued dependencies

## Author

Built as a DBMS capstone project demonstrating advanced MySQL 8.0 
features including recursive CTEs, window functions, stored procedures, 
triggers, and event scheduling.
