require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @topic_iPhone = topics(:topic_iPhone)    
    @topic_website = topics(:topic_website)    
  end

  test "validate empty topic" do
    topic = Topic.new
    assert topic.invalid?
    assert topic.errors[:name].any?
  end

  test "validate name" do
    topic = Topic.new
    max_name = ''
    3.times do
      max_name = max_name + '1234567890'
    end
    topic.name = max_name + '1'
    assert topic.invalid?,"bad name #{topic.name}"
    assert topic.errors[:name].any?
    topic.name = max_name
    assert topic.valid?,"good name #{topic.name}"
  end

  test "validate name format" do
    topic = Topic.new
    topic.name = "design"
    assert topic.valid?
    assert topic.errors[:name].empty?
    topic.name = "des.ign"
    assert topic.invalid?
    assert topic.errors[:name].any?
    topic.name = "de/sign"
    assert topic.invalid?
    assert topic.errors[:name].any?
    topic.name = "d.e/sign"
    assert topic.invalid?
    assert topic.errors[:name].any?
  end

  test 'validate remove topic that don`t have ideas' do
    assert !@topic_iPhone.check_product_count
    assert @topic_iPhone.errors[:base].any?
    @topic_website.check_product_count
    assert @topic_website.errors[:base].empty?
  end

  test "validate description" do
    topic = @topic_iPhone
    description = ""
    4.times do
      description = topic.description + description
    end
    topic.description = description
    assert topic.valid?,"good description #{description}"
    topic.description = description+"a"
    assert topic.invalid?,"bad description #{description}"
    assert topic.errors[:description].any?
  end

  test "validate website" do
    topic = @topic_iPhone
    bad = %w{1234 ftp://dom http://tt.a http://dd.abcdef}
    bad.each do |website|
      topic.website = website
      assert topic.invalid?,"bad website #{website}"
      assert topic.errors[:website].any?
    end
    ok = %w{https://gmail.com http://test.danthought.com http://hello.mobi http://james.org http://kk.abcde}
    ok.each do |website|
      topic.website = website
      assert topic.valid?,"good website #{website}"
    end
  end
end
