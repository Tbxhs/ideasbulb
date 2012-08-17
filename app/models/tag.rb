class Tag < ActiveRecord::Base
  has_and_belongs_to_many :ideas

  def self.with_names(names)
    names.map do |name|
      Tag.find_or_create_by_name(name)
    end
  end

  def self.update_count(tag_ids)
    connection.update("UPDATE `tags` SET `ideas_count`=
    (SELECT count(*) FROM `ideas_tags` WHERE `tag_id` = `id`) 
    WHERE `id` in (#{tag_ids.join(',')})") if tag_ids && !tag_ids.empty?
  end

  def self.random(limit)
    tag_ids = Tag.find( :all, :select => 'id' ).map( &:id )
    tags = Tag.find((1..limit).map{tag_ids.delete_at(tag_ids.size*rand)})
  end
end
