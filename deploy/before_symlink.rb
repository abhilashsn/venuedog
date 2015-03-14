if node[:instance_role] =~ /^app/ || node[:instance_role] == 'solo'
  run "cd #{release_path}; RAILS_ENV=#{framework_env} bundle exec rake assets:precompile"
end

run "sudo ln -sf /usr/share/zoneinfo/EST5EDT /etc/localtime"
