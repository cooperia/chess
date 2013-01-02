require "stringio"
 output = ""

  When /^I start a new game$/ do
     output = %x('./commanding_chess.rb')
  end

  Then /^A blank board is printed$/ do
    output.should == " 8 [    ][    ][    ][    ][    ][    ][    ][    ]\n 7 [    ][    ][    ][    ][    ][    ][    ][    ]\n 6 [    ][    ][    ][    ][    ][    ][    ][    ]\n 5 [    ][    ][    ][    ][    ][    ][    ][    ]\n 4 [    ][    ][    ][    ][    ][    ][    ][    ]\n 3 [    ][    ][    ][    ][    ][    ][    ][    ]\n 2 [    ][    ][    ][    ][    ][    ][    ][    ]\n 1 [    ][    ][    ][    ][    ][    ][    ][    ]\n ___  A __  B __  C __  D __  E __  F __  G __  H _\n"
  end

