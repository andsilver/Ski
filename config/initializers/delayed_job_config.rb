# Default is 25. Something's not working by that time, so 5 is plenty. What's
# more is delayed_job workers seem to be dying when whizzing around commonly
# failed jobs (noticed with attempts to open files that were already deleted).
Delayed::Worker.max_attempts = 5
