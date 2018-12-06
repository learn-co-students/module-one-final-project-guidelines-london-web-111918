require_relative '../config/environment'

# uncomment the below lines before you run the program for the first time
# system("bundle &>/dev/null")
# system("rake db:migrate &>/dev/null")
# system("rake db:seed")

cli = CommandLineInterface.new
cli.run
