require 'jwt'

class JwtService
    def self.encode(payload)
        payload[:exp] = 24.hours.from_now.to_i
        token = JWT.encode(payload, Rails.application.secret_key_base, "HS256")
    end

    def self.decode(token)
        decoded = JWT.decode(token, Rails.application.secret_key_base, true, algorithms: ["HS256"])
        payload = decoded.first
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        nil
    end
end