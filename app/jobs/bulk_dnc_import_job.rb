class BulkDncImportJob < ApplicationJob
  queue_as :default

  def perform(dncs)
    dncs.each do |row|
      territory = Territory.find_by(name: row[:territoryName])
      territory.dncs.create(address: row[:address], date: row[:date])
      end
  end
end
