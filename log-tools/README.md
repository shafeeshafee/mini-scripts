# log-tools

Tools for log file setup and analysis.

- **auth_log_setup.sh**: Creates an example /var/log/auth_log.log with normal and suspicious entries.
- **log_analyzer.sh**: Scans auth_log.log for suspicious keywords, appending them to suspicious_activity.log.
- **404_log_filter.sh**: Analyzes a web server access log to see which IPs triggered HTTP 404 errors.
