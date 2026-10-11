-- Truy vấn phân tích rủi ro bảo mật
SELECT
    a.asset_id,
    a.asset_name,
    COUNT(t.threat_id)                          AS threat_count,
    MAX(r.likelihood * r.impact)                AS max_risk_score,
    SUM(CASE WHEN r.severity = 'HIGH'
             THEN 1 ELSE 0 END)                 AS high_severity_count
FROM assets a
    LEFT JOIN threats      t ON t.asset_id    = a.asset_id
    LEFT JOIN risk_matrix  r ON r.threat_id   = t.threat_id
WHERE a.active = TRUE
GROUP BY a.asset_id, a.asset_name
HAVING MAX(r.likelihood * r.impact) > 6
ORDER BY max_risk_score DESC;