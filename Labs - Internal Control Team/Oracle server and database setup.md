# Oracle server and Database setup Guide

## Table of Contents
1. [Oracle server setup](#Oracle-server-setup)
2. [Creating an Oracle Database in the Windows](#Creating-an-Oracle-Database-in-the-Windows)




# Oracle server setup
1. Login to device as administrator
2. Right-click on the Windows label in left down corner and select Computer Management
3. In the left panel, click on Local Users and Groups > Users
4. In the right panel, right-click on the space area and select New User
5. Fill-in the form as follows to create a user named as oracle then click on Create button.
  This user will be used as the administrator user

   <img width="975" height="722" alt="image" src="https://github.com/user-attachments/assets/f6ef487f-4681-497c-a66a-c5919337b9a5" />


6. Create another user, named as oraclesvc. This user will be used as the service account.
7. On the left panel, click on Groups link > double click on the Administrators group
8. Add oracle user to the group. Do not add oraclesrvc to the group.
9. Sign out from system and login to it as oracle

# Installing Oracle Database Software
In the following steps, you will install Oracle database 19c software in your device.

 10. Open the File Explorer > click on This PC > observe the storage drives available in the system.
We have two drives: C drive and D drive. C drive is dedicated to Windows operating system. We 
will used D drive for installing Oracle database software and database. It has 100 GB free disk 
space.
 11. Download Oracle database 19c installation file for Windows x64 from this [Link](#https://www.oracle.com/ae/database/technologies/oracle19c-windows-downloads.html). Its total 
size is nearly 3 GB.
12. Move the installation file to the shared folder configured in your device.
13. In winsrv, as oracle, create the following directory structure.
mkdir D:\oracle\product\19.0.0\db_1
14. Open the File Explorer > click on the drive mapped to the shared folder (usually it is c drive) > 
right click on WINDOWS.X64_193000_db_home.zip file and select Extract All > enter the folder 
structure D:\oracle\product\19.0.0\db_1 > click on Extract button
15. Wait for the extraction to finish
16. In the File Explorer > go to the folder c:\oracle\product\19.0.0\db_1 > double click on the 
setup.exe file
17. Respond to the Installer windows as follows

    the first window usually takes some time to pop up

    <img width="975" height="733" alt="image" src="https://github.com/user-attachments/assets/8ff7cf59-db84-4786-8078-8d868fcc712e" />

    <img width="975" height="738" alt="image" src="https://github.com/user-attachments/assets/1978a312-0091-4d8e-94bb-efd78c77bf82" />

    <img width="975" height="738" alt="image" src="https://github.com/user-attachments/assets/2cd851b1-3a47-440e-9aed-9c1ec529a3b9" />
    
    <img width="975" height="731" alt="image" src="https://github.com/user-attachments/assets/27642021-b229-4432-be9b-9c03aea930a9" />
    <img width="586" height="195" alt="image" src="https://github.com/user-attachments/assets/c3cca781-d3ba-41e9-8d5b-474950eb3efc" />

    <img width="975" height="733" alt="image" src="https://github.com/user-attachments/assets/72bf61fc-9257-48e5-bc41-c0920444423a" />

    <img width="975" height="745" alt="image" src="https://github.com/user-attachments/assets/0bfe9b14-45a9-49ec-8a22-869a4af6e0b8" />

    <img width="975" height="736" alt="image" src="https://github.com/user-attachments/assets/e0a7e283-5859-46f3-a327-ed1288545d6d" />


    # Creating an Oracle Database in the Windows

    In the following steps, you will use the dbca to create an Oracle 19c non-CDB database named 
orawindb. 
 1 . Start up your device
 2 . Login  as oracle 
 3. Open a command prompt window as administrator and issue the following command to verify 
that no listener is running in the system. 
    or run **lsnrctl status** 
 4. Run the following command to invoke Network Configuration Assistant utility. 
    We created the Listener using the silent mode in the previous section. Now, you will create the 
    Listener using the netca utility. 
   Run **netca**
 5. Respond to the utility windows as follows

    <img width="938" height="622" alt="image" src="https://github.com/user-attachments/assets/ed109f42-a8e0-4642-8606-9e4dd3d743aa" />
    <img width="895" height="616" alt="image" src="https://github.com/user-attachments/assets/2f6b7bf1-f666-44c2-b249-ac5c66d0d46f" />
    <img width="897" height="603" alt="image" src="https://github.com/user-attachments/assets/f87bef0f-e660-4df2-9826-88079ed0dd7d" />
    <img width="855" height="592" alt="image" src="https://github.com/user-attachments/assets/214278ed-ce2c-4bb7-ad75-4398c34f52c5" />
    <img width="909" height="627" alt="image" src="https://github.com/user-attachments/assets/59cb38dd-8756-4735-a91f-5fdc16aaaccd" />
    <img width="913" height="605" alt="image" src="https://github.com/user-attachments/assets/26ae1c80-6e3a-45f6-b754-76ffae90431b" />
    <img width="898" height="611" alt="image" src="https://github.com/user-attachments/assets/c02ea47e-03e8-4067-8f88-1596e157f73c" />



  In the command line window, type the following command to open the services window. 
Observe the OracleOraDB19Home1TNSListener is created and running. 
services.msc 
5. Open the properties of the service > click on the “Log On” tab > observe that the service is 
running as oraclesvc
7. In the command prompt window, issue the following command to verify that the listener is 
running. 
lsnrctl status 
8. Invoke the dbca utility and respond to its windows as follows. 

<img width="547" height="187" alt="image" src="https://github.com/user-attachments/assets/883206e4-eca5-4876-b9de-57b972101040" />
<img width="552" height="412" alt="image" src="https://github.com/user-attachments/assets/bc92792b-603c-4065-ae18-2f668eda5213" />
<img width="547" height="336" alt="image" src="https://github.com/user-attachments/assets/7a18f11f-8485-4288-9a23-32779e940850" />
<img width="553" height="352" alt="image" src="https://github.com/user-attachments/assets/a7e3a58d-7cb1-4d29-ad48-e7d1a95c66a8" />
<img width="410" height="336" alt="image" src="https://github.com/user-attachments/assets/bf33790c-21ee-4cd4-a809-4dfee3128909" />
<img width="588" height="228" alt="image" src="https://github.com/user-attachments/assets/db26aef7-1f54-4a28-9aa2-759e0ccec99a" />
<img width="567" height="276" alt="image" src="https://github.com/user-attachments/assets/8dd0488e-b91b-4796-a763-7145571d75f4" />

You need to select the database options as follows because they are needed by the sample schema that you will install in the database.

<img width="625" height="393" alt="image" src="https://github.com/user-attachments/assets/25e59de8-f554-48cb-858d-6cf8cbed25f3" />
<img width="625" height="208" alt="image" src="https://github.com/user-attachments/assets/10403594-864e-401f-9123-349cae0199da" />
<img width="563" height="232" alt="image" src="https://github.com/user-attachments/assets/424cba99-eca3-4f44-ada8-3e0d1442985f" />
<img width="327" height="111" alt="image" src="https://github.com/user-attachments/assets/095ebae9-befa-40ae-b609-2d819c5e974c" />

For the following window, we do not need to configure the EM Express in this vm because we will not need it in this vm in the course. In real life scenario, you may consider configuring it.

<img width="566" height="192" alt="image" src="https://github.com/user-attachments/assets/5cbe0232-78cb-4040-b247-20da99237d26" />
<img width="558" height="287" alt="image" src="https://github.com/user-attachments/assets/6963da63-38f2-4106-bc79-1d3ff744ef9b" />

In the following window, click on “Customize Storage Locations” button. Explore the contents of the popup window. 

<img width="555" height="422" alt="image" src="https://github.com/user-attachments/assets/13a8e6e3-1d6c-439b-949c-746e675fec65" />

**Observe the following in the window:** 

*1. The maximum data files in the database is set by default to 100. For some large databases, 
this might not be enough and you may need to increase it. This value can hardly be changed 
after the database is created.*

*2. The size of each redo log group member is 204800 KB, which is equivalent to 200 MB. We 
have 3 groups. Therefore, 600 MB will be occupied by redo log files. For real life databases, 
this size could be fair enough or we may need to increase it depending on the transaction 
generation rate.*

<img width="575" height="428" alt="image" src="https://github.com/user-attachments/assets/6b9d528d-d765-4e79-ad2f-049c90713d45" />
<img width="575" height="312" alt="image" src="https://github.com/user-attachments/assets/a90302d4-0e63-497c-adc1-9c8cf44fba28" />
<img width="572" height="232" alt="image" src="https://github.com/user-attachments/assets/75b93a65-091d-460a-8ede-d9e5556fc569" />

In the following window, we want to enable the HR account and set its password. Untick the “Lock 
Account” flag beside the HR user. Set its password. Then click on OK button. 

<img width="530" height="357" alt="image" src="https://github.com/user-attachments/assets/5880ed3e-16b4-47c3-ae12-7a09c7751c4b" />
<img width="567" height="432" alt="image" src="https://github.com/user-attachments/assets/c5beb3e4-faf2-44ce-923c-99a24dd519d5" />




















    

    









  










   


