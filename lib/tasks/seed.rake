
task :seed do
  exec("rails db:seed RAILS_ENV=production")
end
after "deploy:migrate", "seed"



