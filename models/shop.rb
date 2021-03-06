require_relative('../db/sql_runner.rb')

class Shop
  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO shops (name) VALUES ($1) RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    sql = "UPDATE shops SET (name)=($1) WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM shops ORDER BY LOWER(name) ASC"
    shops = SqlRunner.run(sql)
    result = shops.map {|shop| Shop.new(shop)}
  end

  # def self.shop_transactions(id)
  #   sql = 'SELECT transactions.* FROM transactions INNER JOIN shops ON shops.id = transactions.shop_id WHERE shops.id = $1 ORDER BY date_of_transaction DESC'
  #   values = [id]
  #   transactions = SqlRunner.run(sql, values)
  #   result = transactions.map {|transaction| Transaction.new(transaction)}
  # end


  def self.find(id)
    sql = "SELECT * FROM shops where id = $1"
    values = [id]
    shop = SqlRunner.run(sql, values).first
    return Shop.new(shop)
  end

  def delete
    sql = "DELETE FROM shops WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # def total_spend_by_shop
  #   sql = 'SELECT SUM(amount) FROM transactions WHERE shop_id = $1'
  #   values = [@id]
  #   total = SqlRunner.run(sql, values).first['sum']
  #   return total if total
  #   return 0
  # end


  def self.shop_transactions_year_month(id, year_id=nil, month_id=nil)
    sql = 'SELECT transactions.* FROM transactions INNER JOIN shops ON shops.id = transactions.shop_id WHERE shops.id = $1'
    values = [id]
    if year_id && month_id
      sql += ' AND EXTRACT(YEAR FROM date_of_transaction)=$2 AND EXTRACT(MONTH FROM date_of_transaction)=$3 ORDER BY date_of_transaction DESC'
      values += [year_id, month_id]
    end
    transactions = SqlRunner.run(sql, values)
    result = transactions.map {|transaction| Transaction.new(transaction)}
  end

  def total_spend_by_shop_year_month(year_id=nil, month_id=nil)
    sql = 'SELECT SUM(amount) FROM transactions WHERE shop_id = $1'
    values = [@id]
    if year_id && month_id
      sql += ' AND EXTRACT(YEAR FROM date_of_transaction)=$2 AND EXTRACT(MONTH FROM date_of_transaction)=$3'
      values += [year_id, month_id]
    end
    total = SqlRunner.run(sql, values).first['sum']
    return total if total
    return 0
  end




end
