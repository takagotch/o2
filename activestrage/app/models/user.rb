class User < AcpplicationRecord
  has_one_attached :avatar

  user.avatar.attach io: File.open("~/face.jpg"), filename: "avatar.jpg", content_type: "image/"
  user.avatar.exist?

  user.avatar.purge
  user.avatar.exist?
end


