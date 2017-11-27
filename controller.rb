require('pry-byebug')
require('sinatra')
require('sinatra/reloader')
require_relative('./models/category.rb')
require_relative('./models/shop.rb')
require_relative('./models/transaction.rb')
require_relative('./models/wallet.rb')

# binding.pry

get '/' do
  @last_five = Transaction.last_five
  @shops = Shop.all
  @categories = Category.all
  @wallet = Wallet.find(1)
  erb ( :home )
end

get '/transactions' do
  @transactions = Transaction.all
  @shops = Shop.all
  @categories = Category.all
  erb (:index)
end

get '/transactions/new' do
  @shops = Shop.all
  @categories = Category.all
  erb (:new)
end

post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  wallet = Wallet.find(1)
  wallet.transaction(transaction)
  wallet.update
  redirect to "/"
end

get '/transactions/:id/edit' do
  @transaction = Transaction.find(params[:id])
  @shops = Shop.all
  @categories = Category.all
  erb (:edit)
end

put '/transactions/:id' do
  Transaction.new(params).update
  redirect to '/transactions'
end

delete '/transactions/:id' do
  transaction = Transaction.find(params[:id])
  transaction.delete
  redirect to '/'
end
