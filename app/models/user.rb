# ユーザークラス
# 製作日 2020/11/29
# 更新日 2020/12/02

class User < ApplicationRecord
  has_secure_password

  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness:true}

  def posts
    return Post.where(user_id: self.id)
  end
end
