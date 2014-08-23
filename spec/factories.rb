unless Rails.env.test?
  Dir["spec/factories/*"].each {|f| require Rails.root.join(f)}
end