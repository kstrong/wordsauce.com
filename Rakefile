
namespace :wordsauce do
  desc "Deploy wordsauce website to live server"
  task :deploy do
    require 'colorize'
    puts 'Starting deployment to wordsauce.com...'.yellow

    r = system("ssh wordsauce \"bash -l ~/update_server.sh\"")
    if !r
      puts 'Deployment failed'.red
      exit(-1)
    end

    puts 'Success!'.green
  end
end
