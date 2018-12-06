require_relative '../config/environment'

system("bundle &>/dev/null")
system("rake db:migrate &>/dev/null")
system("rake db:seed")

cli = CommandLineInterface.new
cli.run
