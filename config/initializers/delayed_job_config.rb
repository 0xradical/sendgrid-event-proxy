Delayed::Worker.destroy_failed_jobs = false if Rails.env == "development"
Delayed::Worker.max_attempts = 5
