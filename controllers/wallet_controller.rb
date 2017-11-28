require('pry-byebug')
require('sinatra')
require('sinatra/reloader')

require_relative('../models/category.rb')
require_relative('../models/shop.rb')
require_relative('../models/transaction.rb')
require_relative('../models/wallet.rb')

get '/wallets' do
  @wallet = Wallet.find(1)
  @wallet.update
  erb (:'wallet_views/wallets')
end
