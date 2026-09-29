-- UPDATE
UPDATE Task
SET status='Completed'
WHERE task_id = 502;

-- DELETE
DELETE FROM Bug
WHERE bug_id = 604;

-- SELECT / WHERE
SELECT title, status
FROM Task
WHERE status <> 'Completed';

-- JOIN
SELECT d.name, t.title, t.status
FROM Developer d
JOIN Task t
ON d.developer_id = t.developer_id
ORDER BY d.name;

-- GROUP BY - Task count per developer
SELECT d.name, COUNT(t.task_id) AS total_tasks
FROM Developer d
LEFT JOIN Task t
ON d.developer_id = t.developer_id
GROUP BY d.name;

-- GROUP BY - Open bugs per module
SELECT m.module_name, COUNT(b.bug_id) AS open_bugs
FROM Module m
JOIN Task t
ON m.module_id = t.module_id
JOIN Bug b
ON t.task_id = b.task_id
WHERE b.status='Open'
GROUP BY m.module_name;

-- GROUP BY - Bugs by severity
SELECT severity, COUNT(*) AS bug_count
FROM Bug
GROUP BY severity
ORDER BY bug_count DESC;

-- VIEW - Developer workload
CREATE VIEW DeveloperWorkload AS
SELECT d.name, COUNT(t.task_id) AS active_tasks
FROM Developer d
JOIN Task t
ON d.developer_id=t.developer_id
WHERE t.status<>'Completed'
GROUP BY d.name;
