require "csv"

def benchmark(start = Time.now)
  calculate("traffic-accidents", "INCIDENT_ADDRESS")
  calculate("traffic-accidents", "NEIGHBORHOOD_ID")
  calculate("crime", "NEIGHBORHOOD_ID")
  Time.now - start
end

def calculate(file, column)
  memo = Hash.new(0)

  CSV.foreach("./data/#{file}.csv", :headers => true) do |row|
    if file == "crime"
      memo[row["#{column}"]] += 1 if row["OFFENSE_CATEGORY_ID"] != "traffic-accident"
    end
  end

  puts memo.sort_by { |_, v| v }.reverse.first(5)
end

puts benchmark
