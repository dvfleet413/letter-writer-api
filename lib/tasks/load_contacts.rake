require 'CSV'

namespace :load_contacts do
    task :seed => :environment do
        file = File.read("#{Rails.root}/territory.csv")
        csv = CSV.new(file)
        csv.each do |row|
            puts row
            name = "#{row[0]} #{row[1]} #{row[2]}"
            address = "#{row[4]} #{row[5]} #{row[6]} #{row[7]}"
            phone = "#{row[3]}"
            lat = row[9]
            lng = row[10]
            Contact.create!(name: name, address: address, phone: phone, lat: lat, lng: lng)
        end
    end
end
