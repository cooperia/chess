When /^I go to a new game page$/ do
  visit('/new')
end

Then /^An empty board is printed$/ do
  page.all('table#chessBoard tr').count.should == 9
  page.all('table#chessBoard td').count.should == 81
  row = 1
  count = 8

  page.all("#chessBoard tr td:nth-of-type(1)").each do |td|
    td.has_content?(count).should == true unless count == 0
    count -= 1
    row += 1
  end

  letter = "A"
  counter = 1
  page.all("#chessBoard tr:nth-of-type(9) td").each do |td|
    puts td
    td.has_content?(letter).should == true unless counter == 1
    letter = letter.next unless counter == 1
    counter += 1
  end

end