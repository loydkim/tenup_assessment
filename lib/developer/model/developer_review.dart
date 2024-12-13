class DeveloperReview {
  final String image;
  final String name;
  final String position;
  final String company;
  final String review;

  DeveloperReview(
      {required this.image,
      required this.company,
      required this.name,
      required this.position,
      required this.review});
}

final List<DeveloperReview> developerReviews = [
  DeveloperReview(
      company: "Rappid Software Design Inc.",
      image:
          "https://media.licdn.com/dms/image/v2/C5603AQHn1sG1YTjWyQ/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1576616932679?e=1739404800&v=beta&t=YrNAM9DkthqcdxiQznEFfmDdq67-ZAvC3lOCceWenFk",
      name: "Sonja Hamilton",
      position: "Owner",
      review:
          "Loyd has been a strong asset to the Rappid Design team. He has delivered quality solutions in a tight time frame. He is a great team member and strong developer, always showing up with a smile on his face. I highly recommend Loyd for any mobile development needs!"),
  DeveloperReview(
      company: "Bankjoy",
      image:
          "https://media.licdn.com/dms/image/v2/C5603AQG5l93Xj8Q80A/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1517754031522?e=1739404800&v=beta&t=kfAmIXY4BXf-Daea7Obevai-B9AcWeo4Xz_ROSp1nCA",
      name: "Eduardo Dalmasso",
      position: "Senior Developer",
      review:
          "Loyd is the best Flutter developer I've worked with, it is very easy to work with him and he is always there to help everyone.\nWhen things get difficult, he is always there helping to work it out.\nReally good person and developer."),
  DeveloperReview(
      company: "Cronometer",
      image:
          "https://media.licdn.com/dms/image/v2/D5603AQHTBH5_aA_d-w/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1683571706361?e=1739404800&v=beta&t=Eo0d1WzFe-yOrfhs6w45vUEfQ1PwCwHV-5thhhu30eQ",
      name: "Laura Sand",
      position: "Senior Product Designer",
      review:
          "I had the pleasure of working with Loyd for one year at Cronometer, collaborating on several projects. Loyd's ability to take instructions and deliver a quality solution without much further direction was unlike any I have seen before. No matter what was going on in the office, Loyd always kept his positive attitude and kind demeanor. Loyd would be an asset to any team. :)"),
  DeveloperReview(
      company: "Cronometer",
      image:
          "https://media.licdn.com/dms/image/v2/C4E03AQGdoHnFyzUrkw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1652323337563?e=1739404800&v=beta&t=UxH-2yKFb3VdgZhYz8iUNuUGEKCBYIir9KI-R90szOc",
      name: "Ben Clark",
      position: "Software Developer",
      review:
          "Working with Loyd at Cronometer was great. Our small team moves fast and requires a lot of independence and self-direction, and Loyd rose to the challenge. He's thorough and hard working too."),
  DeveloperReview(
      company: "Cronometer",
      image:
          "https://media.licdn.com/dms/image/v2/D5603AQHamUth95VE_A/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1683574484925?e=1739404800&v=beta&t=9lG_z1AeRzto6ar3l-vIgJP5-YAOpZiM78C-ZgtZ_9I",
      name: "Derek Marcinyshyn",
      position: "Software Developer",
      review:
          "Loyd did an exceptional job on recent projects. As I remember, Loyd was a very productive person and is a multi-skilled person with vast knowledge. Loyd is careful, proactive, self motivated and intelligent team player. It was a pleasure working with Loyd."),
];
