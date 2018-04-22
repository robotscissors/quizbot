class Topic < ActiveRecord::Base
  has_many :questions

  def self.get_list_of_topics
    output = ""
    Topic.all.each do |t|
      output = output.concat("Keyword: #{t.keyword.upcase}\n(#{t.description})\n")
    end
    output
  end
end
