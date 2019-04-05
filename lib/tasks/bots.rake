desc "Populate bots file"
task bots: :environment do
  sh "tools/robot_user_agents.rb > bots.txt"
end
