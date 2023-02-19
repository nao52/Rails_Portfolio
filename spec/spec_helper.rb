RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    if Subject.count == 0
      Subject.create!( name: "国語" )
      Subject.create!( name: "数学" )
      Subject.create!( name: "英語" )
      Subject.create!( name: "社会" )
      Subject.create!( name: "理科" )
      Subject.create!( name: "体育" )
      Subject.create!( name: "家庭科" )
      Subject.create!( name: "音楽" )
      Subject.create!( name: "美術" )
    end

    if Club.count == 0
      Club.create!( name: "野球" )
      Club.create!( name: "サッカー" )
      Club.create!( name: "テニス" )
      Club.create!( name: "バスケットボール" )
      Club.create!( name: "バレーボール" )
      Club.create!( name: "ダンス" )
      Club.create!( name: "剣道" )
      Club.create!( name: "陸上" )
      Club.create!( name: "ソフトボール" )
      Club.create!( name: "水泳" )
      Club.create!( name: "卓球" )
      Club.create!( name: "軽音" )
      Club.create!( name: "料理" )
      Club.create!( name: "英語" )
      Club.create!( name: "JRC" )
    end

    if KindsOfSchool.count == 0
      KindsOfSchool.create!( name: "私立/中学" )
      KindsOfSchool.create!( name: "私立/高校" )
      KindsOfSchool.create!( name: "私立/中学高校" )
      KindsOfSchool.create!( name: "公立/中学" )
      KindsOfSchool.create!( name: "公立/高校" )
      KindsOfSchool.create!( name: "公立/中学高校" )
    end

    
  end

end