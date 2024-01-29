(1..12).each do |month|
  Expense.create(
    name: "Expense for #{Date::MONTHNAMES[month]}",
    amount: rand(300),
    date: Date.new(2023, month, rand(1..28))
   )
end
