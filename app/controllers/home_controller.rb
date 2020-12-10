
# ホーム関連
# 製作日 2020/11/29
# 更新日 2020/12/02


class HomeController < ApplicationController

  before_action :forbid_login_user, {only: [:top]}

  def top
  end

  def about
  end
end
