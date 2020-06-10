require 'CSV'

namespace :load_contacts do
    task :seed => :environment do
        file = File.read("#{Rails.root}/territory.csv")
        csv = CSV.new(file)
        csv.each do |row|
            puts row
            name = row[0]
            address = row[1]
            phone = row[2]
            Contact.create!(name: name, address: address, phone: phone) if name.length > 0
        end
    end
end
