
# いいね機能関連
# 製作日 2020/12/02
# 更新日 2020/12/02

class LikesController < ApplicationController

  before_action :authenticate_user

  # いいね作成
  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    redirect_to("/posts/#{params[:post_id]}")
  end

  # いいね削除
  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to("/posts/#{params[:post_id]}")
  end

end
