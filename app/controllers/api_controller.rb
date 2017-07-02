class ApiController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_request!

  def query_user
  end

  def query_all_user
    render json: User.all.
      select('id, account, email, name, nickname,  stu_id, study_state_id').to_json
  end

  protected
    def authenticate_request!
      return true if validate_token
      render :status => :forbidden, :plain => "Invalid request"
    end

    def from_host
      params["from"]
    end

    def request_timestamp
      params["timestamp"]
    end

    def request_token
      params["token"]
    end

    def generate_token(key)
      Digest::MD5.new.update(key).hexdigest
    end

    def validate_token
      @site_token = access_token(from_host)
      return false if @site_token.nil?
      return false if Time.now.to_i - params["timestamp"].to_i > 30
      return false if Rails.cache.read(params["token"])

      Rails.cache.write(params["token"], true, expires_in: 2.minutes)
      request_token == generate_token(from_host + request_timestamp + @site_token.token)
    end

    def access_token(site)
      AccessToken.find_by(domain: site)
    end
end
