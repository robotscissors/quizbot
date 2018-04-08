# create a topic keyword and variations. Keyword is a single word string
# variations are an array of single string words that could include misspellings
# or variations of the keyword. Leave variations blank if you don't want to
# give support to variations
@topic1 = Topic.create(keyword: "flu", description: "Want to discover the 5 myths on dealing with the flu?")
Question.create(
  question: "You can catch the flu from the vaccine? (Reply T or F)",
  answer: "F",
  answer_description: "The flu vaccine that a person receives is an inactive virus that cannot be transmitted. Those that feel symptoms were already infected.",
  more_info: "https://www.health.harvard.edu/diseases-and-conditions/10-flu-myths",
  topic_id: @topic1.id)
Question.create(
  question: "Do you need a flu shot every year? (Reply T or F)",
  answer: "T",
  answer_description: "Flu viruses adapt quickly so the CDC recommends getting a flu vaccine yearly as the virus changes.",
  more_info: "https://www.cdc.gov/flu/about/qa/misconceptions.htm",
  topic_id: @topic1.id)
Question.create(
  question: "Pregnant woman should not get the flu shot? (Reply T or F)",
  answer: "F",
  answer_description: "That is a myth pregnant woman should get the shot and in many cases the benefit will help the baby in the first months of his or her life.",
  more_info: "http://www.health.com/health/gallery/0,,20861838,00.html#pregnant-women-can-t-get-a-flu-shot-0",
  topic_id: @topic1.id)
Question.create(
  question: "You can keep the flu away by frequently washing your hands? (Reply T or F)",
  answer: "F",
  answer_description: "Washing your hands with warm soapy water is important, but it won't stop the flu. Influenza is spread through the air. More specifically, through saliva droplets from someone who is infected.",
  more_info: "http://www.health.com/health/gallery/0,,20861838,00.html#you-can-stop-the-flu-by-washing-your-hands-a-lot-0",
  topic_id: @topic1.id)
Question.create(
  question: "Does the flu vaccine weaken your body's immune response? (Reply T or F)",
  answer: "F",
  answer_description: "Actually the opposite. The vaccine stimulates the production of antibodies and strengthens the immune system.",
  more_info: "https://www.npr.org/sections/health-shots/2014/10/10/354627818/32-myths-about-the-flu-vaccine-you-dont-need-to-fear",
  topic_id: @topic1.id)