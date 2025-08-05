# Oracle SQL Client Setup Guide

## Table of Contents
1. [SQL Developer Setup](#sql-developer-setup)
2. [Toad for Oracle Setup](#toad-for-oracle-setup)
3. [Connection Troubleshooting](#troubleshooting)

---

## SQL Developer Setup

### 1. Download and Install
[Download SQL Developer](https://www.oracle.com/database/sqldeveloper/)  

#### Download Page
 <img width="975" height="488" alt="image" src="https://github.com/user-attachments/assets/455b06b0-1877-4615-87b3-d441876ca7d9" />


**Installation Steps**:
1. Unzip the downloaded file
2. Run `sqldeveloper.exe` (Windows) or `sqldeveloper.sh` (Linux/Mac)
3. Accept default settings

### 2. Create Database Connection
#### Click on Create Connection Manually
 <img width="975" height="518" alt="image" src="https://github.com/user-attachments/assets/7b692de1-d2ae-4f9d-80a2-90c1f6c7c37e" />

#### Open your command prompt and run the below scripts
#### Run scripts as typed
 <img width="975" height="862" alt="image" src="https://github.com/user-attachments/assets/749fb4b4-7349-4aab-b461-79377b800a6c" />

#### On the pop-up window in oracle, enter below details:
```sql
Connection Name: FCMB_Prod
Username: SYS  Role: SYSDBA
Password: sys123
Hostname: localhost
Port: 1521
Service Name: free
```

**Test and Connect**  
#### Successful Connection
 <img width="975" height="519" alt="image" src="https://github.com/user-attachments/assets/86390d5c-02ac-41d6-8827-c40c5e3f10a0" />

#### Confirm connection status: success.
 <img width="975" height="517" alt="image" src="https://github.com/user-attachments/assets/8c0959e7-5c52-4ba6-9a72-71c98e652662" />

### 3. Key Features
- **Object Navigator**: Browse tables, views, procedures  
 <img width="353" height="822" alt="image" src="https://github.com/user-attachments/assets/ce0be952-6e93-42fa-a726-ad6c0413f62b" />

- **Query Builder**: Drag-and-drop interface  
  <img width="773" height="548" alt="image" src="https://github.com/user-attachments/assets/dc25a0d5-df60-41fb-94d6-f4304c95313a" />

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
