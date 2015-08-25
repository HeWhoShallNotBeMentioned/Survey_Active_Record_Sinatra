class Survey < ActiveRecord::Base
  has_many(:questions)
  validates(:title, :presence => true)
  before_save(:upcase_title)

private

  define_method(:upcase_title) do
    multi_words = self.title.split
    multi_words.each_with_index() do |word, index|
      exempt_words = ["from", "the", "at", "to", "and"]
      if exempt_words.include?(word) && index != 0
        word.downcase!()
      else
        word.capitalize!()
      end
    end
    self.title = multi_words.join(" ")
  end

end
