require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,'0')[0..4]
end

def clean_phone_numbers(number)
  bad_number = '0000000000'
  if number.length == 10
    return number
  elsif number.length == 11
    first_number = number[0]
    if first_number == 1
      return number[1..10]
    else
      return bad_number
    end
  else
    return bad_number
  end
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  
  begin
    civic_info.representative_info_by_address(
        address: zipcode,
        levels: 'country',
        roles: ['legislatorUpperBody', 'legislatorLowerBody']
      ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir('output') unless Dir.exists? 'output'
  
  filename = "output/thanks_#{id}.html"
  
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def time_targeting_hour(date_object)
  date_object.hour
end

def time_targeting_day(date_object)
  date_object.wday
end

def find_optimal_time(registration_time)
  optimal = registration_time.inject{ |sum, el| sum + el }.to_f / registration_time.size
end

def convert_day(optimal_day)
  optimal_day = optimal_day.round
  case optimal_day
  when 0
    return 'Sunday'
  when 1
    return 'Monday'
  when 2
    return 'Tuesday'
  when 3
    return 'Wednesday'
  when 4
    return 'Thursday'
  when 5
    return 'Friday'
  when 6
    return 'Saturday'
  end
end

puts "EventManager Initialized!"

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read 'form_letter.erb'
erb_template = ERB.new template_letter

registration_hours = []
registration_days = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  phone_number = clean_phone_numbers(row[:homephone])
  
  date_object = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
  registration_hours.push(time_targeting_hour(date_object))
  registration_days.push(time_targeting_day(date_object))
  
  form_letter = erb_template.result(binding)
  
  save_thank_you_letters(id, form_letter)
  
end

puts registration_hours
puts registration_days

optimal_hour = find_optimal_time(registration_hours).round
optimal_day = convert_day(find_optimal_time(registration_days))

puts "optimal hour: #{optimal_hour}"  
puts "optimal day: #{optimal_day}" 

