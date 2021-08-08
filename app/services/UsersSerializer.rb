class UsersSerializer
    def initialize(user_objects)
        @users = user_objects
    end

    def to_serialized_json
        @users.to_json(:only => [:id, :name, :role, :email])
    end

end