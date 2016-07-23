class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :microposts
    validates :region,    length: { maximum: 20 },on: :update

    #お気に入り
    has_many :favorite_relations, class_name:"Favorite", dependent:   :destroy
    has_many :favorite_microposts, through: :favorites_relations, source: :micropost
    #フォロー

    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    has_many :follower_relationships, class_name:  "Relationship",
                                     foreign_key: "followed_id",
                                     dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower

    # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  def favorites(other_micropost)
    # binding.pry
    favorite_relations.find_or_create_by(micropost_id: other_micropost.id)
  end

  def unfavorites(other_micropost)
    favorite = favorite_relations.find_by(micropost_id: other_micropost.id)
    favorite.destroy if favorite
  end

  def favorites?(other_micropost)
    favorite_relations.find_by(micropost_id: other_micropost.id)
  end
end
