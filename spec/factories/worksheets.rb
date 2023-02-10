FactoryBot.define do
  factory :worksheet do
    name        { "ワークシート(テスト)" }
    file        { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/test1.pdf')) }
    likes_count { 0 }
  end
end