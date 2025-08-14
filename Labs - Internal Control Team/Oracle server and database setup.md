# Oracle server and Database setup Guide



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
 11. Download Oracle database 19c installation file for Windows x64 from this link or this link. Its total 
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
 1 . Start up winsrv
 2 . Login to winsrv as oracle 
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
    

    









  










   


