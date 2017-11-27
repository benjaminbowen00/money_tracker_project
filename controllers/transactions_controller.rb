require('pry-byebug')
require('sinatra')
require('sinatra/reloader')

require_relative('../models/category.rb')
require_relative('../models/shop.rb')
require_relative('../models/transaction.rb')
require_relative('../models/wallet.rb')







get '/transactions' do
  @transactions = Transaction.all
  @shops = Shop.all
  @categories = Category.all
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
