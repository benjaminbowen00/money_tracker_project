require('pry-byebug')
require('sinatra')
require('sinatra/reloader')

require_relative('./models/category.rb')
require_relative('./models/shop.rb')
require_relative('./models/transaction.rb')
require_relative('./models/wallet.rb')

require_relative('./controllers/categories_controller.rb')
# binding.pry
require_relative('./controllers/shops_controller.rb')
require_relative('./controllers/transactions_controller.rb')
require_relative('./controllers/wallet_controller.rb')
require_relative('./controllers/month_controller.rb')






get '/' do
  @shops = Shop.all
  @categories = Category.all
  @wallet = Wallet.find(1)
  @wallet.update
  date = DateMonth.new
  @month = date.month
  @year = date.year
  @monthly_spend = Transaction.total_by_month(@year, @month)
  @last_five = Transaction.last_five_transactions_by_month_number(@year, @month)
  erb ( :home )
end

nil
