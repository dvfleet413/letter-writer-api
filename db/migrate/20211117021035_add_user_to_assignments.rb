class AddUserToAssignments < ActiveRecord::Migration[6.0]
  def change
    add_reference :assignments, :user, foreign_key: true
    Assignment.find_each do |assignment|
      user = User.find_by(name: assignment.publisher)
      if !user
        user = User.new(name: assignment.publisher, role: "Publisher")
        user.congregation = assignment.territory.congregation
        user.password = SecureRandom.base64(10)
        user.save!
      end
      assignment.user = user
      assignment.save!
    end
  end
end
