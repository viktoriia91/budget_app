# Define categories with colors
categories_with_colors = [
  { name: 'Other', color: :gray },
  { name: 'Groceries', color: :orange },
  { name: 'Transportation', color: :green },
  { name: 'Utilities', color: :blue },
  { name: 'Entertainment', color: :rose },
  { name: 'Clothing', color: :indigo },
  { name: 'Healthcare', color: :purple },
  # Add more categories as needed
]

# Create categories
categories_with_colors.each do |category_data|
  category = Category.find_or_create_by(name: category_data[:name])
  category.update(color: category_data[:color])
end

# Create expenses for all categories for each month
(1..12).each do |month|
  categories = Category.all
  categories.each do |category|
    Expense.create(
      name: "Expense for #{Date::MONTHNAMES[month]} - #{category.name}",
      amount: rand(300),
      date: Date.new(2023, month, rand(1..28)),
      category: category
    )
  end
end
