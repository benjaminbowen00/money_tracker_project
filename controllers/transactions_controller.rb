require('pry-byebug')
require('sinatra')
require('sinatra/reloader')

require_relative('../models/category.rb')
require_relative('../models/shop.rb')
require_relative('../models/transaction.rb')
require_relative('../models/wallet.rb')
require_relative('../models/date_month.rb')

get '/transactions' do
  @transactions = Transaction.all
  @shops = Shop.all
  @categories = Category.all
  @wallet = Wallet.find(1)
  @wallet.update
  erb (:'transaction_views/index')
end

get '/transactions/new' do
  @shops = Shop.all
  @categories = Category.all
  erb (:'transaction_views/new')
end

post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  redirect to "/"
end

get '/transactions/:id/edit' do
  @transaction = Transaction.find(params[:id])
  @shops = Shop.all
  @categories = Category.all
  erb (:'transaction_views/edit')
end

put '/transactions/:id' do
  Transaction.new(params).update
  redirect to '/transactions'
end

delete '/transactions/:id' do
  Transaction.find(params[:id]).delete
  redirect to '/'
end

get '/transactions/current' do
  date = DateMonth.new
  @month = date.month
  @year = date.year
  @transactions = Transaction.transactions_by_month_number(@year, @month)
  @monthly_spend = Transaction.total_by_month(@year, @month)
  erb (:'transaction_views/current')

end
