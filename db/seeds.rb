# create a topic keyword and variations. Keyword is a single word string
# variations are an array of single string words that could include misspellings
# or variations of the keyword. Leave variations blank if you don't want to
# give support to variations
class Q
  def self.make(question,answer,answer_description,more_info,topic)

    @question = Question.create(
      detail: question,
      answer: answer.downcase,
      answer_description: answer_description,
      more_info: more_info,
      topic_id: topic
    )

  end
end

@topic1 = Topic.create(keyword: "flu", description: "Discover the 5 myths on dealing with the flu")

Q.make(
  "You can catch the flu from the vaccine. (Reply T or F)",
  "F",
  "The flu vaccine that a person receives is an inactive virus that cannot be transmitted. Those that feel symptoms were already infected.",
  "https://www.health.harvard.edu/diseases-and-conditions/10-flu-myths",
  @topic1.id
)

Q.make(
  "Do you need a flu shot every year? (Reply T or F)",
  "T",
  "Flu viruses adapt quickly so the CDC recommends getting a flu vaccine yearly as the virus changes.",
  "https://www.cdc.gov/flu/about/qa/misconceptions.htm",
  @topic1.id
)

Q.make(
  "Pregnant woman should not get the flu shot? (Reply T or F)",
  "F",
  "That is a myth pregnant woman should get the shot and in many cases the benefit will help the baby in the first months of his or her life.",
  "http://www.health.com/health/gallery/0,,20861838,00.html#pregnant-women-can-t-get-a-flu-shot-0",
  @topic1.id
)

Q.make(
  "You can keep the flu away by frequently washing your hands? (Reply T or F)",
  "F",
  "Washing your hands with warm soapy water is important, but it won't stop the flu. Influenza is spread through the air. More specifically, through saliva droplets from someone who is infected.",
  "http://www.health.com/health/gallery/0,,20861838,00.html#you-can-stop-the-flu-by-washing-your-hands-a-lot-0",
  @topic1.id
)

Q.make(
  "Does the flu vaccine weaken your body's immune response? (Reply T or F)",
  "F",
  "Actually the opposite. The vaccine stimulates the production of antibodies and strengthens the immune system.",
  "https://www.npr.org/sections/health-shots/2014/10/10/354627818/32-myths-about-the-flu-vaccine-you-dont-need-to-fear",
  @topic1.id
)

@topic2 = Topic.create(keyword: "heart", description: "Test your knowledge about heart disease.")

Q.make(
  "Most Heart Attacks happen on a Monday. (Reply T or F)",
  "T",
  "Time of day, day of the week including the time of the year can have influences in cardiovascular wellness.",
  "http://circres.ahajournals.org/content/106/3/430",
  @topic2.id
)

Q.make(
  "You can die from a Broken Heart. (Reply T or F)",
  "T",
  "Broken heart syndrome is a real condition. It is a social condition that can affect your health.",
  "https://www.healthline.com/health-news/can-you-die-of-broken-heart#1",
  @topic2.id
)

Q.make(
  "In the U.S., someone suffers from a heart attack every 10 minutes. (Reply T or F)",
  "F",
  "According to the CDC, someone suffers from a heart attack every 40 seconds!",
  "https://www.cdc.gov/dhdsp/data_statistics/fact_sheets/fs_heart_disease.htm",
  @topic2.id
)

Q.make(
  "The most common day to have a heart attack is on Christmas day. (Reply T or F)",
  "T",
  "Cardiac deaths peak during this season and is most likely due to stress and overindulgences.",
  "http://circ.ahajournals.org/content/110/25/3744",
  @topic2.id
)
