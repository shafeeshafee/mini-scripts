### Set execute permissions for `analyze.log.sh` & `auth_log_creation.sh`

```
chmod +x auth_log_creation.sh
chmod +x analyze_log.sh
```

### Open the Crontab editor

```
crontab -e
```

### Schedule the script

**As in, run the script daily at 6 AM**

```
0 6 * * * /path/to-your/script.sh
```
