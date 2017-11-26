require('pry-byebug')
require('sinatra')
require('sinatra/reloader')
require_relative('./models/category.rb')
require_relative('./models/shop.rb')
require_relative('./models/transaction.rb')
require_relative('./models/wallet.rb')

binding.pry

get '/' do
  @last_five = Transaction.last_five
  @shops = Shop.all
  @categories = Category.all
  erb ( :home )
end
