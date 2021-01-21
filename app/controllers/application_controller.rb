class ApplicationController < ActionController::Base
  before_action :basic_auth if Rails.env.production?
  # あとでONする

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  PER = 6

  private

  def configure_permitted_parameters
    # 新規登録時にnameの取得を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # 編集時にnameの取得を許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']  # 環境変数を読み込む記述に変更
    end
  end

  def authenticate_user_admin!
    redirect_to root_path unless user_signed_in? || admin_signed_in?
  end
end
