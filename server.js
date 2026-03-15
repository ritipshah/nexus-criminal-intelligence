const express = require('express');
const mysql   = require('mysql2');
const path    = require('path');

const app = express();
app.use(express.json());
app.use(express.static('public'));

// ── Database connection ──────────────────────────
const db = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'Root@123$',
  database : 'nexus'
});

db.connect((err) => {
  if (err) {
    console.error('MySQL connection failed:', err.message);
    return;
  }
  console.log('Connected to NEXUS database');
});

// ── Route 1: Get all district threat scores ──────
app.get('/api/threats', (req, res) => {
  const sql = `
    SELECT
      district,
      state,
      latitude,
      longitude,
      incident_count,
      victim_count,
      suspect_count,
      threat_score,
      threat_level,
      last_computed,
      RANK() OVER (ORDER BY threat_score DESC) AS national_rank
    FROM district_threat_scores
    WHERE latitude IS NOT NULL
      AND longitude IS NOT NULL
    ORDER BY threat_score DESC
  `;
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// ── Route 2: Get all locations for dropdown ──────
app.get('/api/locations', (req, res) => {
  const sql = `
    SELECT location_id, name, district, state
    FROM locations
    ORDER BY state, name
  `;
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// ── Route 3: Report a new incident ───────────────
app.post('/api/report', (req, res) => {
  const {
    title, date, location_id, type,
    severity, victims, suspects, source
  } = req.body;

  const sql = `CALL sp_report_incident(?, ?, ?, ?, ?, ?, ?, ?)`;
  const params = [
    title, date, location_id, type,
    severity, victims, suspects, source
  ];

  db.query(sql, params, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ success: true, message: results[0][0].result });
  });
});

// ── Route 4: Get recent audit log ────────────────
app.get('/api/audit', (req, res) => {
  const sql = `
    SELECT
      log_id,
      table_name,
      operation,
      changed_by,
      changed_at,
      new_data
    FROM audit_log
    ORDER BY changed_at DESC
    LIMIT 20
  `;
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// ── Route 5: Get network for a suspect ───────────
app.get('/api/network/:id', (req, res) => {
  const sql = `
    WITH RECURSIVE network AS (
      SELECT
        person_id, full_name, role, risk_score,
        0 AS depth,
        CAST(full_name AS CHAR(1000)) AS path
      FROM persons
      WHERE person_id = ?

      UNION ALL

      SELECT
        p.person_id, p.full_name, p.role, p.risk_score,
        n.depth + 1,
        CONCAT(n.path, ' → ', p.full_name)
      FROM persons p
      JOIN connections c ON c.person_b = p.person_id
      JOIN network n     ON n.person_id = c.person_a
      WHERE n.depth < 5
        AND FIND_IN_SET(p.person_id,
            REPLACE(n.path, ' → ', ',')) = 0
    )
    SELECT * FROM network ORDER BY depth, risk_score DESC
  `;
  db.query(sql, [req.params.id], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// ── Start server ─────────────────────────────────
app.listen(3000, () => {
  console.log('NEXUS server running at http://localhost:3000');
});
