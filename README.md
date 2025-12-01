# SQL_Murder_Mystery
This capstone project leads to solve the murder mystery of a ceo through sql. "No guess just data speaks up"

# SQL Murder Mystery: “Who Killed the CEO?”

---

## **1. Story / Background**

The CEO of **TechNova Inc.** has been found dead in their office on **October 15, 2025, at 9:00 PM**.

You are the **lead data analyst** tasked with solving this case using SQL. All the clues you need are hidden in the company’s databases:

- Keycard logs
- Phone call records
- Alibis
- Evidence found in different rooms

Your mission is simple but challenging:

👉 **Find out who the killer is, where and when the crime took place, and how it happened — using only SQL queries.**

---

## **2. Database Schema & Dataset**

**📂 Use this File to create tables with data:**

> Right Click and Download:
> 
> 
> [SQL Murder Mystery.sql](attachment:eecb0a82-4c91-4319-942c-5ccb2b59a1e0:SQL_Murder_Mystery.sql)
> 

Once downloaded; open this file in PgAdmin or MySQL Workbench; and run the whole query. It will create tables, and insert all data.

The database contains 5 key tables:

### **Table: employees**

| Column | Type | Description |
| --- | --- | --- |
| employee_id | INT | Unique employee ID |
| name | VARCHAR | Full name of the employee |
| department | VARCHAR | Department of the employee |
| role | VARCHAR | Role or title |

---

### **Table: keycard_logs**

| Column | Type | Description |
| --- | --- | --- |
| log_id | INT | Log ID |
| employee_id | INT | ID of employee |
| room | VARCHAR | Room name |
| entry_time | TIMESTAMP | Time they entered |
| exit_time | TIMESTAMP | Time they left |

🕒 *Clue: Someone entered the CEO’s office around the time of the crime.*

---

### **Table: calls**

| Column | Type | Description |
| --- | --- | --- |
| call_id | INT | Call ID |
| caller_id | INT | ID of caller |
| receiver_id | INT | ID of receiver |
| call_time | TIMESTAMP | When the call happened |
| duration_sec | INT | Duration in seconds |

📞 *Clue: There was a suspicious call shortly before the crime.*

---

### **Table: alibis**

| Column | Type | Description |
| --- | --- | --- |
| alibi_id | INT | Alibi record ID |
| employee_id | INT | Employee ID |
| claimed_location | VARCHAR | Where they said they were |
| claim_time | TIMESTAMP | When they claimed to be there |

🤔 *Clue: Someone may have lied about their location.*

---

### **Table: evidence**

| Column | Type | Description |
| --- | --- | --- |
| evidence_id | INT | Evidence ID |
| room | VARCHAR | Where evidence was found |
| description | VARCHAR | What was found |
| found_time | TIMESTAMP | When it was found |

🧤 *Clue: Physical evidence was discovered at the scene.*

---

## **3. Investigation Steps / Questions**

This challenge is designed to **make you think like a detective** 👮‍♂️ — but using SQL instead of fingerprints.

| Step | Objective | SQL Concepts Practiced |
| --- | --- | --- |
| 1 | Identify where and when the crime happened | `WHERE`, filtering |
| 2 | Analyze who accessed critical areas at the time | `JOIN`, `BETWEEN` |
| 3 | Cross-check alibis with actual logs | `JOIN`, subqueries |
| 4 | Investigate suspicious calls made around the time | `JOIN`, filtering |
| 5 | Match evidence with movements and claims | `JOIN`, `WHERE` |
| 6 | Combine all findings to identify the killer | `INTERSECT`, multiple `JOIN`s |

---

### 💬 **Guiding Questions**

- Who entered the **CEO’s Office** close to the time of the murder?
- Who **claimed** to be somewhere else but was not?
- Who made or received calls around **20:50–21:00**?
- What evidence was found at the **crime scene**?
- Which suspect’s movements, alibi, and call activity **don’t add up**?

Your job is to write SQL queries to uncover the answers to these questions one step at a time.

---

## **4. Hints & Learning Goals**

💡 *Hints (not answers)*:

- Use `WHERE` and `BETWEEN` to filter logs.
- Use `JOIN` to connect tables like `employees` and `keycard_logs`.
- Compare **claimed locations** with **actual locations** to find lies.
- Look for **unusual access patterns** and **timing overlaps**.
- Cross-check **evidence** to narrow down suspects.

🧠 **Skills You’ll Practice:**

- Filtering data with `WHERE` and time ranges
- Joining multiple tables
- Using subqueries or CTEs for logical steps
- Combining results across multiple tables to reach a conclusion
- Analytical thinking using SQL

---

## **5. Expected Deliverables**

By the end of this mystery, you should submit:

- ✅ SQL queries for each investigation step
- 📝 A final **“Case Solved”** query that reveals the killer in below single column table format:
    
    
    | killer |
    | --- |
    | Full Name of Killer as in **employees.name** |
- 🕒 A short explanation of how you arrived at the conclusion


---

🎯 **Your Mission:**

Use SQL like a detective uses clues. Each query gets you closer to unmasking the killer.

Only the sharpest data analysts will crack the case. 🕵️‍♀️

Good luck, detective.


