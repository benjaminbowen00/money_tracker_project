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

  def self.all()
    sql = "SELECT * FROM shops"
    shops = SqlRunner.run(sql)
    result = shops.map {|shop| Shop.new(shop)}
  end


end
