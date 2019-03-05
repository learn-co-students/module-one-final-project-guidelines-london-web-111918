require_relative '../config/environment'

# comment out system after running the program for the first time

# system("bundle &>/dev/null")
# system("rake db:migrate &>/dev/null")
# system("rake db:seed")

cli = CommandLineInterface.new
cli.run
