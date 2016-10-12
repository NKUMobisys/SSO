class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @no_nav = true
    @sso_params = get_sso_params
    super
  end

  # POST /resource/sign_in
  def create
    @sso_params = get_sso_params
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
    def after_sign_in_path_for(resource_or_scope)
      if from_site && validate_token
        nonceStr = SecureRandom.hex
        timestamp = Time.now.to_i.to_s
        uid = current_user.id.to_s
        site_token = access_token(from_site)
        resp_parm = "uid=#{uid}&timestamp=#{timestamp}&nonceStr=#{nonceStr}&token=#{generate_token(timestamp+uid+nonceStr+site_token.token)}"
        return "//#{from_site}/?#{resp_parm}"
      end
      super
    end

    def generate_token(key)
      Digest::MD5.new.update(key).hexdigest
    end

    def validate_token
      site_token = access_token(from_site)
      return false if site_token.nil?
      request_token == generate_token(from_site + request_timestamp + site_token.token)
    end

    def access_token(site)
      AccessToken.find_by(domain: site)
    end

    def get_sso_params
      { from: from_site, timestamp: request_timestamp, token: request_token }
    end

    def from_site
      params["from"]
    end

    def request_timestamp
      params["timestamp"]
    end

    def request_token
      params["token"]
    end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
