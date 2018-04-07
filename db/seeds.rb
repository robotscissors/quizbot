# create a topic keyword and variations. Keyword is a single word string
# variations are an array of single string words that could include misspellings
# or variations of the keyword. Leave variations blank if you don't want to
# give support to variations
topics = [
  {keyword: "flu", variation: ["cold","sick"]},
  {keyword: "hip", variation: ["replacement"]}
]


topics.each do |t|
  Topic.create(t)
end
