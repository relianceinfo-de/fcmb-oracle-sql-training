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

---

**## Verify Installation**
## MacOS (Docker Method)
```markdown
1. **Install Docker Desktop**:  
   ```bash
   brew install --cask docker
   open /Applications/Docker.app

## Start Oracle Container
docker run -d \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_PASSWORD=oracle123 \
--name oracle-xe \
gvenzl/oracle-xe:21-slim

## Connect
docker exec -it oracle-xe sqlplus system/oracle123@//localhost/XEPDB1


### **Linux (Native Install)**
```markdown
1. **For Debian/Ubuntu**:  
   ```bash
   wget https://download.oracle.com/otn-pub/otn_software/db-express/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
   sudo apt-get install alien libaio1
   sudo alien --scripts -d oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
   sudo dpkg -i oracle-database-xe-21c_1.0-2_amd64.deb
   sudo /etc/init.d/oracle-xe-21c configure

2. **For RHEL/CentOS**:
sudo yum install -y oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
sudo /etc/init.d/oracle-xe-21c configure
