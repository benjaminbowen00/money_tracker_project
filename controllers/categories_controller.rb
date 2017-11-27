require('pry-byebug')
require('sinatra')
require('sinatra/reloader')
require_relative('../models/category.rb')
require_relative('../models/shop.rb')
require_relative('../models/transaction.rb')
require_relative('../models/wallet.rb')


get '/categories' do
  @categories = Category.all()
  erb (:categories)
end

get '/categories/:id/transactions' do
    @transactions = Category.category_transactions(params[:id])
    erb (:category_transactions)
end
