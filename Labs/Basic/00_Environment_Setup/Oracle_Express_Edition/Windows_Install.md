# Oracle Database 21c Express Edition Setup

## Windows Installation
1. Download from [Oracle's website](https://www.oracle.com/database/technologies/xe-downloads.html)
2. Run installer with admin privileges
3. Configure:
   - Password: `oracle123` (or your secure password)
   - Port: `1521`
   - SID: `XE`

## Verify Installation
```sql
CONNECT system/oracle123@XE
SELECT * FROM v$version;
