
task :seed do
  exec("rake rails db:seed RAILS_ENV=production")
end
after "deploy:migrate", "seed"



