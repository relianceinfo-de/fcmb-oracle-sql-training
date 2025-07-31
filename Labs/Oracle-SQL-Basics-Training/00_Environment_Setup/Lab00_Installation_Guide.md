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

## macOS Installation (Docker Method)

### 1. Install Docker Desktop
```bash
brew install --cask docker
open /Applications/Docker.app
```

### 2. Start Oracle Container
```bash
docker run -d \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PASSWORD=oracle123 \
  --name oracle-xe \
  gvenzl/oracle-xe:21-slim
```

### 3. Connect to Database
```bash
docker exec -it oracle-xe sqlplus system/oracle123@//localhost/XEPDB1
```

---

## Linux Installation

### Debian/Ubuntu
```bash
# Download and convert RPM package
wget https://download.oracle.com/otn-pub/otn_software/db-express/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
sudo apt-get install alien libaio1
sudo alien --scripts -d oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

# Install and configure
sudo dpkg -i oracle-database-xe-21c_1.0-2_amd64.deb
sudo /etc/init.d/oracle-xe-21c configure
```

### RHEL/CentOS
```bash
sudo yum install -y oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
sudo /etc/init.d/oracle-xe-21c configure
```

---

## Verification (All Platforms)
```sql
-- Check database version
SELECT * FROM v$version;

-- Verify connectivity
SELECT 1 FROM dual;
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Port 1521 in use | `sudo lsof -i :1521` then `kill -9 <PID>` |
| Connection refused | Verify container is running: `docker ps -a` |
| ORA-12505 | Check SID name (use `XE` or `XEPDB1` for Docker) |

> **Note**: For Docker installations, use `XEPDB1` as SID instead of `XE`
```

