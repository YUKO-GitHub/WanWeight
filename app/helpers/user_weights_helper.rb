module UserWeightsHelper
  def date_options
    options = []
    date = Date.today
    while date >= Date.new(2020, 1)
      options << ["#{date.year}年#{date.month}月", "#{date.year}-#{date.month}"]
      date = date.prev_month
    end
    options
  end
end
