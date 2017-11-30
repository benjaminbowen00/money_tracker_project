require('date')

class DateMonth
  attr_reader :today

  def initialize()
    @today = Date.today
  end

  def last_six_months
    month_date_array=[]
    i=0
    while i<6
      month_date_array << @today.prev_month(i)
    i += 1
    end
    return month_date_array
  end

  def self.find_month_name(options)
    "#{Date::MONTHNAMES[options['month_id'].to_i]} #{options['year_id']}"
  end

  def month
    return @today.month
  end

  def year
    return @today.year
  end

end
