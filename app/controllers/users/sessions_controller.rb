class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  skip_before_action :authenticate_user!, only: [:new, :create]


  # GET /resource/sign_in
  def new
    @no_nav = true
    @sso_params = get_sso_params
    if from_site && !from_site.empty? && !validate_token
      render :status => :forbidden, :plain => "Invalid token"
      return
    end
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
      return edit_user_registration_path(current_user) if current_user.first_login?
      if from_site && validate_token
        nonceStr = SecureRandom.hex
        timestamp = Time.now.to_i.to_s
        uid = current_user.id.to_s
        uinfo = package_user_info
        resp_parm = {
          uid: uid,
          timestamp: timestamp,
          nonceStr: nonceStr,
          uinfo: uinfo,
          token: generate_token(timestamp+uid+nonceStr+@site_token.token+uinfo)
        }.to_query
        return "#{from_site}/?#{resp_parm}"
      end
      super
    end

    def generate_token(key)
      Digest::MD5.new.update(key).hexdigest
    end

    def validate_token
      @site_token = access_token(from_host)
      return false if @site_token.nil?
      request_token == generate_token(from_host + request_timestamp + @site_token.token)
    end

    def access_token(site)
      AccessToken.find_by(domain: site)
    end

    def get_sso_params
      { from: from_site, timestamp: request_timestamp, token: request_token }
    end

    def from_host
      URI(from_site).host
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

    def package_user_info
      Base64.encode64(
        [:account, :name, :nickname, :email].collect{|key| [key,current_user[key]]}.to_h.to_json
        )
    end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
