# set timeout for delayed job workers

Delayed::Worker.max_run_time = 10.minutes
Delayed::Worker.max_attempts = 3
Delayed::Worker.logger = ActiveSupport::Logger.new(STDOUT)
