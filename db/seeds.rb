require_relative('../models/shop.rb')
require_relative('../models/category.rb')
require_relative('../models/wallet.rb')
require_relative('../models/transaction.rb')

require_relative('./sql_runner.rb')
clothes = Category.new({"name"=>"clothing"})
food = Category.new({"name"=>"food"})
bills = Category.new({"name"=>"household bills"})
transport = Category.new({"name"=>"transport"})
entertainment = Category.new({"name"=>"entertainment"})
savings = Category.new({"name"=>"savings"})
personal = Category.new({"name"=>"personal care"})
other = Category.new({"name"=>"other"})

clothes.save
food.save
bills.save
transport.save
entertainment.save
savings.save
personal.save
other.save

tesco = Shop.new({"name"=>"Tesco"})
marks = Shop.new({"name"=>"Marks and Spencer"})
lothian = Shop.new({"name"=>"Lothian buses"})
gas = Shop.new({"name"=>"British Gas"})
nandos = Shop.new({"name"=>"Nandos"})

tesco.save
marks.save
lothian.save
gas.save
nandos.save

wallet1 = Wallet.new({"budget"=>1000, "spend"=>0})
wallet1.save

transaction1 = Transaction.new({'amount'=>10, 'date_of_transaction'=>'2017-11-23', "comment"=>'Bought food for party', "wallet_id"=>wallet1.id, "shop_id"=>tesco.id, "category_id"=>food.id})
transaction2 = Transaction.new({'amount'=>30, 'date_of_transaction'=>'2017-11-24', "comment"=>'dinner for two', "wallet_id"=>wallet1.id, "shop_id"=>nandos.id, "category_id"=>entertainment.id})
transaction3 = Transaction.new({'amount'=>50, 'date_of_transaction'=>'2017-11-25', "comment"=>'monthly bus pass', "wallet_id"=>wallet1.id, "shop_id"=>lothian.id, "category_id"=>transport.id})
transaction1.save
transaction2.save
transaction3.save
