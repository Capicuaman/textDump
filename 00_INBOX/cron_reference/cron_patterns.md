# Cron Schedule Patterns - Quick Reference

## Every X Minutes/Hours
```bash
*/5 * * * *        # Every 5 minutes
*/15 * * * *       # Every 15 minutes
*/30 * * * *       # Every 30 minutes
0 * * * *          # Every hour (on the hour)
0 */2 * * *        # Every 2 hours
0 */4 * * *        # Every 4 hours
```

## Specific Times
```bash
0 9 * * *          # Every day at 9:00 AM
30 14 * * *        # Every day at 2:30 PM
0 0 * * *          # Every day at midnight
0 12 * * *         # Every day at noon
```

## Multiple Specific Times
```bash
0 9,12,15,18 * * *              # At 9am, 12pm, 3pm, 6pm daily
0 10,12,14,16,18,20 * * *       # Every 2 hours from 10am-8pm (your journal agent)
*/30 9-17 * * *                 # Every 30 min between 9am-5pm
```

## Days of Week
```bash
0 9 * * 1          # Every Monday at 9am
0 18 * * 5         # Every Friday at 6pm
0 9 * * 1-5        # Weekdays (Mon-Fri) at 9am
0 0 * * 0          # Every Sunday at midnight
0 0 * * 6,0        # Every weekend (Sat & Sun) at midnight
```

## Days of Month
```bash
0 0 1 * *          # First day of every month at midnight
0 0 15 * *         # 15th of every month at midnight
0 9 1,15 * *       # 1st and 15th at 9am
0 0 L * *          # Last day of month (use 28-31 with logic)
```

## Specific Months
```bash
0 0 1 1 *          # January 1st at midnight (New Year)
0 0 1 */3 *        # First day of every quarter (Jan, Apr, Jul, Oct)
0 9 * 1-6 1        # Every Monday, Jan-June at 9am
```

## Complex Schedules
```bash
*/10 9-17 * * 1-5              # Every 10 min, 9am-5pm, weekdays only
0 */2 * * 1-5                  # Every 2 hours on weekdays
30 8,20 * * 1-5                # 8:30am & 8:30pm on weekdays
0 0 * * 0 [ $(date +\%d) -le 7 ] && command    # First Sunday of month
```

## Special Shortcuts (if supported)
```bash
@reboot            # Run at startup
@yearly            # Run once a year  (0 0 1 1 *)
@monthly           # Run once a month (0 0 1 * *)
@weekly            # Run once a week  (0 0 * * 0)
@daily             # Run once a day   (0 0 * * *)
@hourly            # Run once an hour (0 * * * *)
```

## Pro Tips

### Business Hours Only
```bash
0 9-17 * * 1-5     # Every hour, 9am-5pm, weekdays
*/30 9-17 * * 1-5  # Every 30 min, 9am-5pm, weekdays
```

### Off-Peak Operations
```bash
0 2 * * *          # 2am daily (backups, maintenance)
0 3 * * 0          # 3am Sundays (weekly tasks)
```

### Staggered Execution
```bash
5 * * * *          # Run at 5 min past the hour
0,30 * * * *       # Run at top and bottom of each hour
15,45 * * * *      # Run at :15 and :45 each hour
```

### Time Zone Considerations
- Cron uses system time zone
- Check: `timedatectl` or `date`
- Set in cron: `CRON_TZ=America/New_York`

### Testing Schedules
Use online tools like crontab.guru to visualize schedules:
https://crontab.guru/

Example: https://crontab.guru/#0_10,12,14,16,18,20_*_*_*
Shows: "At minute 0 past hour 10, 12, 14, 16, 18, and 20."
