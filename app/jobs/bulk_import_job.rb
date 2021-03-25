class BulkImportJob < ApplicationJob
  queue_as :default

  def perform(contacts, congregation)
    contacts.each do |row|
      if row[:zipCode].length == 3
          zipCode = "00#{row[:zipCode]}"
      elsif row[:zipCode].length == 4
          zipCode = "0#{row[:zipCode]}"
      else
          zipCode = row[:zipCode]
      end
      congregation.external_contacts.create(
          name: "#{row[:firstName]} #{row[:lastName]}",
          phone: row[:phone],
          address: "#{row[:address]}\n#{row[:city]}, #{row[:state]}  #{zipCode}",
          lat: row[:lat],
          lng: row[:lng])
      end
  end
end
