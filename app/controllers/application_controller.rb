class ApplicationController < ActionController::API
    def logged_in_user
        User.find_by(id: decode_token_and_get_user_id)
    end

    def logged_in?
        !!logged_in_user
    end

    def generate_token(payload)
        JWT.encode(payload, ENV["JWT_TOKEN_SECRET"])
    end 

    def decode_token_and_get_user_id(token = nil)
        headers = ActionDispatch::Http::Headers.from_hash(request.env)
        if headers["HTTP_AUTH"]
            return JWT.decode(headers["HTTP_AUTH"], ENV["JWT_TOKEN_SECRET"])[0]["id"]
        else
            return JWT.decode(token, ENV["JWT_TOKEN_SECRET"])[0]["id"]
        end
    end
end
