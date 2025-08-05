# Oracle SQL Client Setup Guide

## Table of Contents
1. [SQL Developer Setup](#sql-developer-setup)
2. [Toad for Oracle Setup](#toad-for-oracle-setup)
3. [Connection Troubleshooting](#troubleshooting)

---

## SQL Developer Setup

### 1. Download and Install
[Download SQL Developer](https://www.oracle.com/database/sqldeveloper/)  
![Download Page](<img width="975" height="488" alt="image" src="https://github.com/user-attachments/assets/ffbbe4e2-5083-4eea-b124-d758aa1d2113" />
)

**Installation Steps**:
1. Unzip the downloaded file
2. Run `sqldeveloper.exe` (Windows) or `sqldeveloper.sh` (Linux/Mac)
3. Accept default settings

### 2. Create Database Connection
![New Connection](https://i.imgur.com/5vVWz9k.png)

```sql
Connection Name: FCMB_Prod
Username: SYS  Role: SYSDBA
Password: ********
Hostname: localhost
Port: 1521
Service Name: 
```

**Test and Connect**  
![Successful Connection](https://i.imgur.com/8T7b4Nd.png)

### 3. Key Features
- **Object Navigator**: Browse tables, views, procedures  
  ![Object Navigator](https://i.imgur.com/mN2XK1U.png)
- **Query Builder**: Drag-and-drop interface  
  ![Query Builder](https://i.imgur.com/9pZJY1E.png)

---

## Toad for Oracle Setup

### 1. Installation
[Download Toad](https://www.quest.com/products/toad-for-oracle/)

**Installation Steps**:
1. Run the installer as Administrator
2. Select "Complete Installation"
3. License activation (provide your license key)

![Toad Install](https://i.imgur.com/LQh3YnG.png)

### 2. Configure Connection
![Toad Connection](https://i.imgur.com/Vp5R3kD.png)

```sql
Oracle Home: OraClient19Home1
Username: fcmb_analyst
Password: ********
Connect As: Normal
Host: 10.5.2.100
Port: 1521
Service Name: FCMBPROD
```

### 3. Key Features
- **Schema Browser**: Table data visualization  
  ![Schema Browser](https://i.imgur.com/ZYdGQ2E.png)
- **Code Analysis**: PL/SQL debugging  
  ![Code Analysis](https://i.imgur.com/9W7XbP4.png)

---

## Troubleshooting

### Common Issues
| Error | Solution |
|-------|----------|
| ORA-12541 | Verify listener is running on server |
| ORA-12154 | Check TNS names entry |
| ORA-28000 | Reset expired password |

**Connection Test Script**:
```sql
SELECT 
    status,
    instance_name,
    version
FROM v$instance;
```

---
