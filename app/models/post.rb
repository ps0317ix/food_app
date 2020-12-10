# 製作日 2020/11/29
# 更新日 2020/12/02

class Post < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 140}}
  validates :user_id, {presence: true}

  # 投稿に紐づいたユーザー情報を取得
  def user
    return User.find_by(id: self.user_id)
  end
end
