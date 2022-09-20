# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
  subject {
     described_class.new(
        title: "This is tesing",
        body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        post_category_id: 1,
        header_img: File.open(io: Rails.root.join("public/assets/profile_img-9f7db6fe66a347566157a80fad374979fca61f81dfef6250c43f69fb87385aa6.jpg"), filename: "image.jpg")
      )
   }

  it "is valid post" do
    expect(subject).to be_valid
  end
end
