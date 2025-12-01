-- DROP TABLES if exist
DROP TABLE IF EXISTS employees, keycard_logs, calls, alibis, evidence;

-- Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    role VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'Alice Johnson', 'Engineering', 'Software Engineer'),
(2, 'Bob Smith', 'HR', 'HR Manager'),
(3, 'Clara Lee', 'Finance', 'Accountant'),
(4, 'David Kumar', 'Engineering', 'DevOps Engineer'),
(5, 'Eva Brown', 'Marketing', 'Marketing Lead'),
(6, 'Frank Li', 'Engineering', 'QA Engineer'),
(7, 'Grace Tan', 'Finance', 'CFO'),
(8, 'Henry Wu', 'Engineering', 'CTO'),
(9, 'Isla Patel', 'Support', 'Customer Support'),
(10, 'Jack Chen', 'HR', 'Recruiter');

-- Keycard Logs Table
CREATE TABLE keycard_logs (
    log_id INT PRIMARY KEY,
    employee_id INT,
    room VARCHAR(50),
    entry_time TIMESTAMP,
    exit_time TIMESTAMP
);

INSERT INTO keycard_logs VALUES
(1, 1, 'Office', '2025-10-15 08:00', '2025-10-15 12:00'),
(2, 2, 'HR Office', '2025-10-15 08:30', '2025-10-15 17:00'),
(3, 3, 'Finance Office', '2025-10-15 08:45', '2025-10-15 12:30'),
(4, 4, 'Server Room', '2025-10-15 08:50', '2025-10-15 09:10'),
(5, 5, 'Marketing Office', '2025-10-15 09:00', '2025-10-15 17:30'),
(6, 6, 'Office', '2025-10-15 08:30', '2025-10-15 12:30'),
(7, 7, 'Finance Office', '2025-10-15 08:00', '2025-10-15 18:00'),
(8, 8, 'Server Room', '2025-10-15 08:40', '2025-10-15 09:05'),
(9, 9, 'Support Office', '2025-10-15 08:30', '2025-10-15 16:30'),
(10, 10, 'HR Office', '2025-10-15 09:00', '2025-10-15 17:00'),
(11, 4, 'CEO Office', '2025-10-15 20:50', '2025-10-15 21:00'); -- killer

-- Calls Table
CREATE TABLE calls (
    call_id INT PRIMARY KEY,
    caller_id INT,
    receiver_id INT,
    call_time TIMESTAMP,
    duration_sec INT
);

INSERT INTO calls VALUES
(1, 4, 1, '2025-10-15 20:55', 45),
(2, 5, 1, '2025-10-15 19:30', 120),
(3, 3, 7, '2025-10-15 14:00', 60),
(4, 2, 10, '2025-10-15 16:30', 30),
(5, 4, 7, '2025-10-15 20:40', 90);

-- Alibis Table
CREATE TABLE alibis (
    alibi_id INT PRIMARY KEY,
    employee_id INT,
    claimed_location VARCHAR(50),
    claim_time TIMESTAMP
);

INSERT INTO alibis VALUES
(1, 1, 'Office', '2025-10-15 20:50'),
(2, 4, 'Server Room', '2025-10-15 20:50'), -- false alibi
(3, 5, 'Marketing Office', '2025-10-15 20:50'),
(4, 6, 'Office', '2025-10-15 20:50');

-- Evidence Table
CREATE TABLE evidence (
    evidence_id INT PRIMARY KEY,
    room VARCHAR(50),
    description VARCHAR(255),
    found_time TIMESTAMP
);

INSERT INTO evidence VALUES
(1, 'CEO Office', 'Fingerprint on desk', '2025-10-15 21:05'),
(2, 'CEO Office', 'Keycard swipe logs mismatch', '2025-10-15 21:10'),
(3, 'Server Room', 'Unusual access pattern', '2025-10-15 21:15');

#Investigation steps office on October 15, 2025, at 9:00 PM.

#1	Identify where and when the crime happened
select room, found_time from evidence
where found_time between '2025-10-15 20:50:00' and '2025-10-15 21:05:00';

#2	Analyze who accessed critical areas at the time
select e.employee_id, name, department, room, entry_time, exit_time from employees e
join keycard_logs k on k.employee_id = e.employee_id 
where  '2025-10-15 21:00:00' between entry_time and exit_time;

#3	Cross-check alibis with actual logs
select k.employee_id, e.name, claimed_location, claim_time, room as actual_location, entry_time, exit_time 
from alibis a
join employees e on e.employee_id = a.employee_id
join keycard_logs k on a.employee_id = k.employee_id
and claim_time between entry_time and exit_time;

#4	Investigate suspicious calls made around the time
select call_id, e.name as caller_name, e1.name as receiver_name, call_time, duration_sec from calls c
join employees e on e.employee_id = c.caller_id
join employees e1 on e1.employee_id = c.receiver_id
where call_time between '2025-10-15 20:00:00' and '2025-10-15 21:00:00';

#5	Match evidence with movements and claims
select ev.room as evidence_room, ev.found_time, ev.description,
e.name, k.room, k.entry_time, k.exit_time,
a.claim_time, a.claimed_location
from evidence ev 
join keycard_logs k on k.room = ev.room
join employees e on k.employee_id = e.employee_id
left join alibis a on e.employee_id = a.employee_id;

#6	Combine all findings to identify the killer
with investigation as(
select e.employee_id, name, room, entry_time,  exit_time
from employees e
join keycard_logs k on k.employee_id = e.employee_id 
where  '2025-10-15 21:00:00' between entry_time and exit_time
),
crime_place as(
select room, found_time, description from evidence
where found_time between '2025-10-15 21:00:00' and  '2025-10-15 21:05:00' ),
suspect as (select employee_id, name as killer, i.room, entry_time,  exit_time
from investigation i 
join crime_place c on i.room = c.room )
select killer from suspect;






