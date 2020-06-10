class ApplicationController < ActionController::API
    def current_user
        User.find_by(id: decode_token_and_get_user_id)
    end

    def logged_in?
        !!current_user
    end

    def generate_token(payload)
        JWT.encode(payload, ENV["JWT_TOKEN_SECRET"])
    end 

    def decode_token_and_get_user_id
        headers = ActionDispatch::Http::Headers.from_hash(request.env)
        JWT.decode(headers["HTTP_AUTH"], ENV["JWT_TOKEN_SECRET"])[0]["id"]
    end
end
