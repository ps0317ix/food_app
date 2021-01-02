# 製作日 2020/11/29
# 更新日 2020/12/12

#webに接続するためのライブラリ
require "open-uri"
#クレイピングに使用するライブラリ
require "nokogiri"


class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
     @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts/index")
    end
  end

  def allPlace
    @allPlaces = Place.all
  end





end
