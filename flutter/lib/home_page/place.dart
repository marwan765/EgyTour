// Place class for storing place data
class Place {
  final String title;
  final String location;
  final String imagePath;
  final String description;
  final List<String> openingHours;
  final List<String> prices;
  final String category;
  final List<String> touristTips;
  final List<String> galleryImages;
  final DateTime? plannedDate;

  const Place({
    required this.title,
    required this.location,
    required this.imagePath,
    required this.description,
    required this.openingHours,
    required this.prices,
    required this.touristTips,
    required this.category,
    required this.galleryImages,
    this.plannedDate,
  });

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'location': location,
      'imagePath': imagePath,
      'description': description,
      'openingHours': openingHours,
      'prices': prices,
      'touristTips': touristTips,
      'category': category,
      'galleryImages': galleryImages,
      'plannedDate': plannedDate?.toIso8601String(),
    };
  }

  // إنشاء كائن Place من JSON
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        title: json['title'],
        location: json['location'],
        imagePath: json['imagePath'],
        description: json['description'],
        openingHours: List<String>.from(json['openingHours']),
        prices: List<String>.from(json['prices']),
        touristTips: List<String>.from(json['touristTips']),
    category: json['category'],
    galleryImages: List<String>.from(json['galleryImages']),
    plannedDate: json['plannedDate'] != null
    ? DateTime.parse(json['plannedDate'])
        : null,
    );
  }

  Place copyWith({DateTime? plannedDate}) {
    return Place(
      title: title,
      location: location,
      imagePath: imagePath,
      description: description,
      openingHours: openingHours,
      prices: prices,
      touristTips: touristTips,
      category: category,
      galleryImages: galleryImages,
      plannedDate: plannedDate,
    );
  }
}

List<Place> plannedPlaces = [];
// List of places (shortened for brevity, full list can be added as needed)
const List<Place> places = [
  Place(
    title: 'Giza Three Pyramids',
    location: 'Giza, Egypt',
    imagePath: 'lib/home_page/images/pyramids.jpg',
    description:
    'The Giza Three Pyramids, constructed during the Fourth Dynasty around 2600 BC, are among the most iconic monuments of ancient Egypt. They include the Great Pyramid of Khufu, the only remaining wonder of the Seven Wonders of the Ancient World, the Pyramid of Khafre, distinguished by its limestone cap, and the smaller Pyramid of Menkaure. These structures were built as tombs for the pharaohs and reflect the advanced engineering skills of the time. The Great Pyramid, originally 146.5 meters tall, was the tallest man-made structure for over 3,800 years. The site also includes the Great Sphinx, a limestone statue with a lion’s body and a human head. The Giza Plateau, a UNESCO World Heritage Site, attracts millions of tourists annually for its historical and architectural significance.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 160EGP/Ticket',
      'Foreign Student: 80EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit early in the morning to avoid crowds and heat, especially in summer.',
      'Wear comfortable shoes for walking on rocky terrain around the pyramids.',
      'Hire a licensed guide to learn about the history and avoid unofficial touts.',
      'Bring sunscreen, a hat, and water, as shade is limited on the plateau.',
      'Consider the Sound and Light Show in the evening for a unique experience.',
    ],
    category: 'Pyramid',
    galleryImages: [
      'lib/home_page/images/pyramids/pyramid_1.jpg',
      'lib/home_page/images/pyramids/pyramid_2.jpg',
      'lib/home_page/images/pyramids/pyramid_3.jpg',
    ],
  ),
  Place(
    title: 'Abu el-Abbas el-Mursi Mosque',
    location: 'Alexandria, Egypt',
    imagePath: 'lib/home_page/images/abu_el_abbas.jpg',
    description:
    'The Abu al-Abbas al-Mursi Mosque, located in the historic Anfoushi neighborhood of Alexandria, is a stunning Islamic landmark constructed in 1775 over the tomb of the 13th-century Sufi saint Ahmed Abu al-Abbas al-Mursi. The mosque is renowned for its cream-colored façade, four intricately designed domes, and a prominent minaret that stands 73 meters tall. Its interior features ornate arabesque designs, marble floors, and a prayer hall that can accommodate hundreds of worshippers. The mosque is a major pilgrimage site for Sufi Muslims and a symbol of Alexandria’s rich cultural heritage. It overlooks the Mediterranean Sea, offering a serene backdrop, and its architecture reflects a blend of Mamluk and Andalusian influences. The mosque was renovated in the 1940s to preserve its historical beauty.',
    openingHours: [
      'Sunday (08:00-20:00)',
      'Monday (08:00-20:00)',
      'Tuesday (08:00-20:00)',
      'Wednesday (08:00-20:00)',
      'Thursday (08:00-20:00)',
      'Friday (08:00-20:00)',
      'Saturday (08:00-20:00)',
    ],
    prices: [
      'Egyptian Student: Free',
      'Foreigner: Free',
      'Foreign Student: Free',
      'Egyptian: Free',
    ],
    touristTips: [
      'Dress modestly (cover shoulders and knees); women should bring a headscarf.',
      'Visit during non-prayer times to explore the interior peacefully.',
      'Walk along the nearby Corniche for scenic Mediterranean views.',
      'Photography is allowed outside, but be respectful inside the mosque.',
      'Combine with a visit to the nearby Citadel of Qaitbay.',
    ],
    category: 'Abu al-Abbas al-Mursi Mosque',
    galleryImages: [
      'lib/home_page/images/abu-el-abbas/abu-el-abbas-1.jpg',
      'lib/home_page/images/abu-el-abbas/abu-el-abbas-2.jpg',
      'lib/home_page/images/abu-el-abbas/abu-el-abbas-3.jpg',

    ],
  ),
  Place(
    title: 'Abu Haggag Mosque',
    location: 'Luxor, Egypt',
    imagePath: 'lib/home_page/images/abu_haggag.jpg',
    description:
    'The Abu al-Hajjaj Mosque, constructed in the 13th century during the Ayyubid period, is uniquely situated atop the ancient Luxor Temple, symbolizing the layered history of Egypt. The mosque houses the tomb of Sheikh Yusuf Abu al-Hajjaj, a revered local Sufi saint, and has become a significant religious and cultural site in Luxor. Its architecture features a mix of Islamic and ancient Egyptian elements, with parts of the Luxor Temple’s original structure visible within the mosque. The mosque hosts annual festivals, such as the Moulid of Abu al-Hajjaj, attracting thousands of devotees. Its location provides stunning views of the Nile River, and it serves as a testament to the coexistence of Egypt’s Pharaonic and Islamic heritage. The mosque was carefully preserved during excavations of the Luxor Temple in the 19th century.',
    openingHours: [
      'Sunday (08:00-18:00)',
      'Monday (08:00-18:00)',
      'Tuesday (08:00-18:00)',
      'Wednesday (08:00-18:00)',
      'Thursday (08:00-18:00)',
      'Friday (08:00-18:00)',
      'Saturday (08:00-18:00)',
    ],
    prices: [
      'Egyptian Student: Free',
      'Foreigner: 20EGP/Ticket',
      'Foreign Student: 10EGP/Ticket',
      'Egyptian: Free',
    ],
    touristTips: [
      'Combine with a tour of Luxor Temple for a full historical experience.',
      'Dress modestly and respect prayer times; women need a headscarf.',
      'Visit during the Moulid of Abu al-Hajjaj festival for cultural vibrancy.',
      'Enjoy Nile views from the mosque’s elevated position.',
      'Be cautious of steep steps when accessing the mosque.',
    ],
    category: 'Abu al-Hajjaj Mosque',
    galleryImages: [
      'lib/home_page/images/abu_haggag/abu_haggag_1.jpg',
      'lib/home_page/images/abu_haggag/abu_haggag_2.jpg',
      'lib/home_page/images/abu_haggag/abu_haggag_3.jpg',

    ],
  ),
  Place(
    title: 'Agiba Beach',
    location: 'Marsa Matruh, Egypt',
    imagePath: 'lib/home_page/images/agiba_beach.jpg',
    description:
    'Agiba Beach, nestled along the Mediterranean coast near Marsa Matruh, is renowned for its breathtaking natural beauty, characterized by turquoise waters, golden sands, and dramatic rock formations. The name "Agiba" means "miracle" in Arabic, reflecting the beach’s enchanting scenery. Accessible via a steep path or a staircase carved into the cliffs, the beach is relatively small but offers a serene escape from the busier coastal areas. Surrounded by towering limestone cliffs, it provides a picturesque setting for swimming and relaxation. Agiba Beach is a popular spot for locals and tourists alike, especially during the summer months, and is known for its clear waters, ideal for snorkeling. The nearby caves and rock formations add to its allure, making it a must-visit destination on Egypt’s north coast.',
    openingHours: [
      'Sunday (08:00-18:00)',
      'Monday (08:00-18:00)',
      'Tuesday (08:00-18:00)',
      'Wednesday (08:00-18:00)',
      'Thursday (08:00-18:00)',
      'Friday (08:00-18:00)',
      'Saturday (08:00-18:00)',
    ],
    prices: [
      'Egyptian Student: 10EGP/Ticket',
      'Foreigner: 50EGP/Ticket',
      'Foreign Student: 25EGP/Ticket',
      'Egyptian: 20EGP/Ticket',
    ],
    touristTips: [
      'Bring your own umbrella or rent one, as shade is limited.',
      'Wear water shoes to protect feet from rocks when entering the sea.',
      'Visit in early summer (May-June) to avoid peak crowds.',
      'Pack snacks and water, as food options may be limited.',
      'Explore nearby caves, but check tide times for safety.',
    ],
    category: 'Agiba Beach',
    galleryImages: [
      'lib/home_page/images/agiba_beach/agiba_beach_1.jpg',
      'lib/home_page/images/agiba_beach/agiba_beach_2.jpg',
      'lib/home_page/images/agiba_beach/agiba_beach_3.jpg'
    ],
  ),
  Place(
    title: 'Akhenaten',
    location: 'Minya, Egypt',
    imagePath: 'lib/home_page/images/akhenaten.jpg',
    description:
    'Akhenaten, originally named Amenhotep IV, was a revolutionary pharaoh of the 18th Dynasty who ruled Egypt from 1353 to 1336 BC. He is best known for introducing monotheism by promoting the worship of the sun disk, Aten, above all other gods, a radical departure from Egypt’s traditional polytheistic religion. Akhenaten moved the capital from Thebes to a newly built city, Amarna, to establish his religious reforms. His reign also saw a distinctive artistic shift, with more naturalistic depictions of the royal family, as seen in the famous Bust of Nefertiti, his queen. Akhenaten’s reforms were largely undone after his death, with his son Tutankhamun restoring the old gods. Despite his short-lived legacy, Akhenaten’s reign remains a fascinating chapter in Egyptian history, highlighting a bold, albeit controversial, experiment in religious and cultural transformation.',
    openingHours: [
      'Not Applicable',
    ],
    prices: [
      'Not Applicable',
    ],
    touristTips: [
      'Visit the Amarna site to see ruins of Akhenaten’s city.',
      'Hire a guide to explain the significance of his religious reforms.',
      'Bring a hat and sunscreen, as the site is exposed to the sun.',
      'Combine with a trip to Minya museums for more artifacts.',
      'Be prepared for limited facilities, as Amarna is remote.',
    ],
    category: 'Akhenaten',
    galleryImages: [
      'lib/home_page/images/akhenaten/akhenaten_1.jpg',
      'lib/home_page/images/akhenaten/akhenaten_2.jpg',
      'lib/home_page/images/akhenaten/akhenaten_3.jpg',

    ],
  ),
  Place(
    title: 'Alexandria Opera House',
    location: 'Alexandria, Egypt',
    imagePath: 'lib/home_page/images/alex_opera.jpg',
    description:
    'The Alexandria Opera House, also known as Sayed Darwish Theatre, is a cultural landmark in Alexandria, originally built in 1918 and renovated in 2004. Named after the renowned Egyptian composer Sayed Darwish, often called the "father of modern Arab music," it is a hub for artistic performances, including operas, ballets, and classical music concerts. The building’s architecture blends European and Islamic styles, with a grand façade and an elegant interior featuring a main auditorium with a capacity of 600 seats. The opera house hosts international and local performances, fostering cultural exchange in Egypt’s second-largest city. It also includes a music library and hosts workshops for young artists. Located in the heart of Alexandria, the opera house is a testament to the city’s legacy as a center of art and culture since ancient times.',
    openingHours: [
      'Sunday (10:00-22:00)',
      'Monday (10:00-22:00)',
      'Tuesday (10:00-22:00)',
      'Wednesday (10:00-22:00)',
      'Thursday (10:00-22:00)',
      'Friday (10:00-22:00)',
      'Saturday (10:00-22:00)',
    ],
    prices: [
      'Egyptian Student: 50EGP/Ticket',
      'Foreigner: 200EGP/Ticket',
      'Foreign Student: 100EGP/Ticket',
      'Egyptian: 100EGP/Ticket',
    ],
    touristTips: [
      'Check performance schedules and book tickets in advance.',
      'Dress smartly, as the opera house has a formal atmosphere.',
      'Visit the on-site music library for a cultural experience.',
      'Combine with a visit to Bibliotheca Alexandrina nearby.',
      'Arrive early to admire the elegant architecture.',
    ],
    category: 'Alexandria Opera House',
    galleryImages: [
      'lib/home_page/images/alex_opera/alex_opera_1.jpg',
      'lib/home_page/images/alex_opera/alex_opera_2.jpg',
      'lib/home_page/images/alex_opera/alex_opera_3.jpg',

    ],

  ),
  Place(
    title: 'Colossi of Memnon',
    location: 'Luxor, Egypt',
    imagePath: 'lib/home_page/images/colossi_of_memnon.jpg',
    description:
    'The Colossi of Memnon are two massive statues of Pharaoh Amenhotep III, erected around 1350 BC on the west bank of the Nile in Luxor. Standing at 18 meters tall, these twin statues were carved from quartzite sandstone and originally guarded the entrance to Amenhotep III’s mortuary temple, which was one of the largest in ancient Egypt but has since largely disappeared. Each statue weighs approximately 720 tons and depicts the seated pharaoh with his hands on his knees, flanked by smaller figures of his wife and mother. The northern statue became famous in antiquity for emitting a mysterious sound at dawn, likely due to temperature changes causing the stone to vibrate, a phenomenon that stopped after Roman repairs. Today, the Colossi are a popular tourist attraction, offering a striking view against the backdrop of the Theban Hills.',
    openingHours: [
      'Sunday (06:00-17:00)',
      'Monday (06:00-17:00)',
      'Tuesday (06:00-17:00)',
      'Wednesday (06:00-17:00)',
      'Thursday (06:00-17:00)',
      'Friday (06:00-17:00)',
      'Saturday (06:00-17:00)',
    ],
    prices: [
      'Egyptian Student: Free',
      'Foreigner: Free',
      'Foreign Student: Free',
      'Egyptian: Free',
    ],
    touristTips: [
      'Visit at sunrise for cooler weather and great photos.',
      'Combine with a tour of the Valley of the Kings nearby.',
      'Bring water and a hat, as the site offers little shade.',
      'Learn about the historical “singing” phenomenon of the statues.',
      'Negotiate prices clearly with guides to avoid overcharging.',
    ],
    category: 'Colossi of Memnon - Amenhotep III',
    galleryImages: [
      'lib/home_page/images/amenhotep/amenhotep_1.jpg',
      'lib/home_page/images/amenhotep/amenhotep_2.jpg',
      'lib/home_page/images/amenhotep/amenhotep_3.jpg',

    ],
  ),
  Place(
    title: 'Amr ibn al-Aas Mosque',
    location: 'Cairo, Egypt',
    imagePath: 'lib/home_page/images/amr_ibn_al_aas.jpg',
    description:
    'The Amr ibn al-As Mosque, constructed in 641 AD in Fustat, is the first mosque built in Egypt and Africa. Founded by Amr ibn al-As, the Muslim general who led the Islamic conquest of Egypt, it marks the beginning of Islam’s spread in the region. Originally a simple structure with palm trunks and mud bricks, the mosque has been rebuilt and expanded multiple times, with its current design dating to the 18th century. It features a large courtyard, a hypostyle prayer hall with 150 columns, and a minaret added during the Fatimid period. The mosque has served as a center for Islamic learning and worship for over a millennium. Located in Old Cairo, it remains an active place of worship and a significant historical site, reflecting Egypt’s Islamic heritage.',
    openingHours: [
      'Sunday (08:00-20:00)',
      'Monday (08:00-20:00)',
      'Tuesday (08:00-20:00)',
      'Wednesday (08:00-20:00)',
      'Thursday (08:00-20:00)',
      'Friday (08:00-20:00)',
      'Saturday (08:00-20:00)',
    ],
    prices: [
      'Egyptian Student: Free',
      'Foreigner: Free',
      'Foreign Student: Free',
      'Egyptian: Free',
    ],
    touristTips: [
      'Dress modestly; women should wear a headscarf.',
      'Visit during non-prayer times to explore the courtyard.',
      'Combine with a tour of Coptic Cairo nearby.',
      'Be respectful when taking photos inside the mosque.',
      'Learn about its history as Egypt’s first mosque.',
    ],
    category: 'Amr ibn al-As Mosque',
    galleryImages: [
      'lib/home_page/images/amr Ibn al-aas/amr Ibn al-aas_1.jpg',
      'lib/home_page/images/amr Ibn al-aas/amr Ibn al-aas_2.jpg',
      'lib/home_page/images/amr Ibn al-aas/amr Ibn al-aas_3.jpg',

    ],
  ),
  Place(
    title: 'Aswan High Dam',
    location: 'Aswan, Egypt',
    imagePath: 'lib/home_page/images/aswan_dam.jpg',
    description:
    'The Aswan High Dam, completed in 1970, is a modern engineering marvel located on the Nile River in Aswan. Built under the leadership of President Gamal Abdel Nasser, the dam controls the annual flooding of the Nile, provides irrigation for agriculture, and generates hydroelectric power, supplying about 10% of Egypt’s electricity needs. Stretching 3,830 meters long and 111 meters tall, it created Lake Nasser, one of the largest artificial lakes in the world, extending over 500 kilometers. The dam’s construction, however, led to the displacement of over 100,000 people and the relocation of ancient monuments like the Abu Simbel temples to prevent flooding. The project was funded with Soviet assistance during the Cold War era, symbolizing Egypt’s push for modernization. Today, the dam remains a vital part of Egypt’s infrastructure and a popular tourist site.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 10EGP/Ticket',
      'Foreigner: 50EGP/Ticket',
      'Foreign Student: 25EGP/Ticket',
      'Egyptian: 20EGP/Ticket',
    ],
    touristTips: [
      'Visit in the morning for cooler temperatures.',
      'Bring binoculars to view Lake Nasser and wildlife.',
      'Learn about the dam’s history at the on-site visitor center.',
      'Combine with a trip to Philae Temple or Abu Simbel.',
      'Photography may be restricted in some areas, so ask first.',
    ],
    category: 'Aswan High Dam',
    galleryImages: [
      'lib/home_page/images/high_dam/high_dam_1.jpg',
      'lib/home_page/images/high_dam/high_dam_2.jpg',
      'lib/home_page/images/high_dam/high_dam_3.jpg',

    ],
  ),
  Place(
    title: 'Babylon Fortress',
    location: 'Cairo, Egypt',
    imagePath: 'lib/home_page/images/babylon_fortress.jpg',
    description:
    'The Babylon Fortress, located in Old Cairo, was constructed by the Romans in the 1st century AD. Built along the Nile, it served as a key defensive structure during the Roman and Byzantine periods, protecting the city from invasions. The fortress was strategically positioned to control access to the Nile and featured massive towers and thick walls made of brick and stone. It later became the nucleus of Coptic Cairo, with several churches, including the Hanging Church, built within or above its walls. The fortress’s two main towers, the southern and northern gates, are among the best-preserved Roman structures in Egypt. Archaeological excavations have revealed Roman-era artifacts, including pottery and coins, shedding light on life in ancient Cairo. The site is now a popular attraction for those exploring Egypt’s Christian heritage.',
    openingHours: [
      'Sunday (09:00-16:00)',
      'Monday (09:00-16:00)',
      'Tuesday (09:00-16:00)',
      'Wednesday (09:00-16:00)',
      'Thursday (09:00-16:00)',
      'Friday (09:00-16:00)',
      'Saturday (09:00-16:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 100EGP/Ticket',
      'Foreign Student: 50EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit as part of a Coptic Cairo tour with the Hanging Church.',
      'Wear comfortable shoes for walking on uneven surfaces.',
      'Hire a guide to explain the Roman and Christian history.',
      'Bring a camera for photos of the fortress’s ancient towers.',
      'Check for nearby churches hosting festivals or events.',
    ],
    category: 'Babylon Fortress',
    galleryImages: [
      'lib/home_page/images/babylon fortress/babylon fortress_1.jpg',
      'lib/home_page/images/babylon fortress/babylon fortress_2.jpg',
      'lib/home_page/images/babylon fortress/babylon fortress_3.jpg',


    ],
  ),
  Place(
    title: 'Baron Empain Palace',
    location: 'Cairo, Egypt',
    imagePath: 'lib/home_page/images/baron_palace.jpg',
    description:
    'The Baron Palace, located in the Heliopolis district of Cairo, was built in 1911 by Belgian millionaire Baron Édouard Empain, who founded the Heliopolis suburb. Inspired by Hindu architecture, the palace features a unique design with a central tower, intricate carvings, and a blend of Eastern and Western styles, including elements reminiscent of the Angkor Wat temple in Cambodia. The interior boasts opulent rooms with marble floors, stained glass windows, and ornate woodwork, though it has been closed to the public for decades due to disrepair. The palace is surrounded by lush gardens and is rumored to be haunted, adding to its mystique. After years of neglect, restoration efforts began in 2020 to transform it into a cultural center, aiming to preserve its historical and architectural significance for future generations.',
    openingHours: [
      'Sunday (09:00-17:00)',
      'Monday (09:00-17:00)',
      'Tuesday (09:00-17:00)',
      'Wednesday (09:00-17:00)',
      'Thursday (09:00-17:00)',
      'Friday (09:00-17:00)',
      'Saturday (09:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 100EGP/Ticket',
      'Foreign Student: 50EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Check if the interior is open, as it’s under restoration.',
      'Explore the gardens for a relaxing walk.',
      'Visit in the late afternoon for cooler weather and photos.',
      'Learn about the palace’s unique Hindu-inspired design.',
      'Combine with a visit to nearby Heliopolis landmarks.',
    ],
    category: 'Baron Palace',
    galleryImages: [
      'lib/home_page/images/baron_palace/baron_palace_1.jpg',
      'lib/home_page/images/baron_palace/baron_palace_2.jpeg',
      'lib/home_page/images/baron_palace/baron_palace_3.jpg',

    ],
  ),
  Place(
    title: 'Bent Pyramid',
    location: 'Dahshur, Egypt',
    imagePath: 'lib/home_page/images/bent_pyramid.jpg',
    description:
    'The Bent Pyramid, located in the Dahshur necropolis, was constructed around 2600 BC during the reign of Pharaoh Sneferu, father of Khufu. Its unique bent shape, with an angle change from 54 to 43 degrees halfway up, resulted from structural concerns during construction, marking a transitional form in pyramid building between step pyramids and true pyramids. The pyramid stands 105 meters tall and retains much of its original limestone casing, offering a rare glimpse into ancient construction techniques. It has two entrances, one on the north and one on the west, a feature uncommon in pyramids. The Bent Pyramid is part of the Dahshur archaeological site, a UNESCO World Heritage Site, and is less crowded than Giza, making it a favorite for visitors seeking a quieter experience. Nearby, the Red Pyramid, also built by Sneferu, showcases further advancements in pyramid design.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 100EGP/Ticket',
      'Foreign Student: 50EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit early to enjoy a quieter experience than Giza.',
      'Bring water and a hat, as shade is scarce.',
      'Explore the nearby Red Pyramid for a complete Dahshur tour.',
      'Hire a guide to learn about the pyramid’s unique design.',
      'Wear sturdy shoes for walking on sandy terrain.',
    ],
    category: 'Bent Pyramid',
    galleryImages: [
      'lib/home_page/images/bent_pyramid/bent_pyramid_1.jpg',
      'lib/home_page/images/bent_pyramid/bent_pyramid_2.jpg',
      'lib/home_page/images/bent_pyramid/bent_pyramid_3.jpg',


    ],
  ),
  Place(
    title: 'Bibliotheca Alexandrina',
    location: 'Alexandria, Egypt',
    imagePath: 'lib/home_page/images/alex_lib.jpg',
    description:
    'The Bibliotheca Alexandrina, inaugurated in 2002, is a modern architectural marvel built to commemorate the ancient Library of Alexandria, one of the largest and most significant libraries of the ancient world. Located on the Mediterranean coast, it features a distinctive circular design with a slanted roof resembling a rising sun, symbolizing the dawn of knowledge. The library can house up to 8 million books and includes a main reading hall that spans 20,000 square meters, along with specialized libraries, museums, and galleries. It also features a planetarium, a conference center, and the Antiquities Museum, which displays artifacts from ancient Alexandria. The Bibliotheca serves as a cultural hub, hosting international events, exhibitions, and digital projects like the digitization of rare manuscripts. Its glass-paneled roof and granite walls are engraved with characters from 120 different scripts, reflecting its mission of global knowledge preservation.',
    openingHours: [
      'Sunday (10:00-19:00)',
      'Monday (10:00-19:00)',
      'Tuesday (10:00-19:00)',
      'Wednesday (10:00-19:00)',
      'Thursday (10:00-19:00)',
      'Friday (Closed)',
      'Saturday (10:00-19:00)',
    ],
    prices: [
      'Egyptian Student: 10EGP/Ticket',
      'Foreigner: 70EGP/Ticket',
      'Foreign Student: 35EGP/Ticket',
      'Egyptian: 20EGP/Ticket',
    ],
    touristTips: [
      'Book a guided tour to explore the library and museums.',
      'Visit the planetarium for an educational experience.',
      'Check for cultural events or exhibitions during your visit.',
      'Bring a light jacket, as the reading hall is air-conditioned.',
      'Enjoy a coffee at the café with Mediterranean views.',
    ],
    category: 'Bibliotheca Alexandrina',
    galleryImages: [
      'lib/home_page/images/bib_alex/bib_alex_1.jpg',
      'lib/home_page/images/bib_alex/bib_alex_2.jpg',
      'lib/home_page/images/bib_alex/bib_alex_3.jpg',

    ],
  ),
  Place(
    title: 'Bust of Ramesses Ii',
    location: 'Memphis, Egypt',
    imagePath: 'lib/home_page/images/bust_of_ramesses.jpg',
    description:
    'The Bust of Ramesses II, also known as the Younger Memnon, is a colossal granite statue of the great Pharaoh Ramesses II, dating to around 1250 BC. Discovered in 1820 by Giovanni Battista Caviglia in Memphis, the ancient capital of Egypt, it originally formed part of a larger seated statue that stood at the entrance of the Temple of Ptah. Weighing over 7 tons, the bust measures 2.67 meters in height and depicts Ramesses II with a serene expression, wearing the royal nemes headdress with a uraeus. The statue was transported to the British Museum in London in 1834, where it remains one of the most iconic artifacts of ancient Egypt. Its detailed craftsmanship highlights the artistic achievements of the New Kingdom, and its historical significance lies in representing Ramesses II, one of Egypt’s most powerful pharaohs, known for his military campaigns and monumental constructions.',
    openingHours: [
      'Not Applicable',
    ],
    prices: [
      'Not Applicable',
    ],
    touristTips: [
      'Visit the British Museum in London to see the bust.',
      'Learn about its journey from Memphis to London.',
      'Combine with a visit to other Egyptian artifacts in the museum.',
      'Take a guided tour for context on Ramesses II’s reign.',
      'Photography is allowed, but no flash is permitted.',
    ],
    category: 'Bust of Ramesses',
    galleryImages: [
      'lib/home_page/images/bust of ramesses/bust of ramesses_1.jpg',
      'lib/home_page/images/bust of ramesses/bust of ramesses_2.jpg',
      'lib/home_page/images/bust of ramesses/bust of ramesses_3.jpg',

    ],
  ),
  Place(
    title: 'Cairo Tower',
    location: 'Cairo, Egypt',
    imagePath: 'lib/home_page/images/cairo_tower.jpg',
    description:
    'The Cairo Tower, standing at 187 meters, is the tallest structure in Egypt and North Africa, completed in 1961. Located on Gezira Island in the Nile River, it was designed by Egyptian architect Naoum Shebib and constructed using a lattice design inspired by the lotus flower, a symbol of ancient Egypt. The tower offers panoramic views of Cairo, including landmarks like the Pyramids of Giza, the Nile, and the Citadel. At its summit, there is a rotating restaurant and an observation deck, making it a popular spot for tourists and locals alike. The tower’s construction was funded with money originally intended as a gift from the United States, but repurposed by President Nasser as a symbol of Egyptian independence. Illuminated at night with colorful lights, the Cairo Tower is a modern icon of the city and a testament to Egypt’s mid-20th-century architectural ambitions.',
    openingHours: [
      'Sunday (09:00-23:00)',
      'Monday (09:00-23:00)',
      'Tuesday (09:00-23:00)',
      'Wednesday (09:00-23:00)',
      'Thursday (09:00-23:00)',
      'Friday (09:00-23:00)',
      'Saturday (09:00-23:00)',
    ],
    prices: [
      'Egyptian Student: 40EGP/Ticket',
      'Foreigner: 200EGP/Ticket',
      'Foreign Student: 100EGP/Ticket',
      'Egyptian: 70EGP/Ticket',
    ],
    touristTips: [
      'Visit at sunset for stunning views of Cairo and the Nile.',
      'Make a reservation at the rotating restaurant for dinner.',
      'Bring binoculars to spot the Pyramids on clear days.',
      'Avoid peak hours to skip long elevator lines.',
      'Wear comfortable shoes for the observation deck.',
    ],
    category: 'Cairo Tower',
    galleryImages: [
      'lib/home_page/images/cairo tower/cairo tower_1.jpg',
      'lib/home_page/images/cairo tower/cairo tower_2.jpg',
      'lib/home_page/images/cairo tower/cairo tower_3.jpg',

    ],
  ),
  Place(
    title: 'Citadel of Qaitbay',
    location: 'Alexandria, Egypt',
    imagePath: 'lib/home_page/images/citadel_of_qaitbay.jpg',
    description:
    'The Citadel of Qaitbay, constructed in 1477 AD by Sultan Al-Ashraf Qaitbay, is located on the Mediterranean coast in Alexandria, on the site of the ancient Lighthouse of Alexandria, one of the Seven Wonders of the Ancient World. Built as a defensive fortress to protect against Ottoman invasions, the citadel features thick limestone walls, rounded towers, and a central keep with a labyrinthine interior. The structure incorporates stones from the ruins of the lighthouse, which had collapsed due to earthquakes in the 14th century. The citadel offers stunning views of the Mediterranean and houses a small naval museum displaying maritime artifacts. Its strategic location and historical significance make it a key attraction in Alexandria, reflecting the city’s role as a maritime power in the medieval Islamic world. The fortress was restored in the 20th century to preserve its original design.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 100EGP/Ticket',
      'Foreign Student: 50EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit early for fewer crowds and cooler weather.',
      'Explore the naval museum inside for maritime history.',
      'Enjoy panoramic Mediterranean views from the ramparts.',
      'Bring a hat and sunscreen, as the site is exposed.',
      'Combine with a walk along the Corniche.',
    ],
    category: 'Citadel of Qaitbay',
    galleryImages: [
      'lib/home_page/images/citadel_of_qaitbay/citadel_of_qaitbay_1.jpg',
      'lib/home_page/images/citadel_of_qaitbay/citadel_of_qaitbay_2.jpg',
      'lib/home_page/images/citadel_of_qaitbay/citadel_of_qaitbay_3.jpg',

    ],
  ),
  Place(
    title: 'Deir el-Medina',
    location: 'Luxor, Egypt',
    imagePath: 'lib/home_page/images/deir_el_medina.jpg',
    description:
    'Deir el-Medina, situated on the west bank of the Nile near the Valley of the Kings in Luxor, was a village founded during the New Kingdom (circa 1550–1070 BC) to house artisans who worked on the royal tombs, such as those of Tutankhamun and Ramesses II. The village, also known as the "Place of Truth," was home to skilled workers, including stonemasons, painters, and scribes, who left behind detailed records of daily life, wages, and even strikes, providing invaluable insights into ancient Egyptian society. The site includes well-preserved mud-brick houses, a small temple dedicated to Hathor, and nearby tombs decorated with vibrant frescoes depicting scenes of the afterlife. Deir el-Medina’s isolation ensured the secrecy of the royal tomb construction, and its archaeological remains, including ostraca (pottery shards with writings), make it a key site for Egyptologists studying the New Kingdom period.',
    openingHours: [
      'Sunday (06:00-17:00)',
      'Monday (06:00-17:00)',
      'Tuesday (06:00-17:00)',
      'Wednesday (06:00-17:00)',
      'Thursday (06:00-17:00)',
      'Friday (06:00-17:00)',
      'Saturday (06:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 100EGP/Ticket',
      'Foreign Student: 50EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Hire a guide to learn about the artisans’ lives.',
      'Visit the tombs for vibrant frescoes of daily life.',
      'Bring water and a hat, as the site is sunny.',
      'Combine with a Valley of the Kings tour.',
      'Wear sturdy shoes for uneven paths.',
    ],
    category: 'Deir el-Medina',
    galleryImages: [
      'lib/home_page/images/deir_el_medina/deir_el_medina_1.jpg',
      'lib/home_page/images/deir_el_medina/deir_el_medina_2.jpg',
      'lib/home_page/images/deir_el_medina/deir_el_medina_3.jpg',

    ],
  ),
  Place(
    title: 'Egyptian Museum Tahrir',
    location: 'Cairo, Egypt',
    imagePath: 'lib/home_page/images/egyptian_museum_tahrir.jpg',
    description:
    'The Egyptian Museum in Tahrir Square, opened in 1902, houses over 120,000 ancient Egyptian artifacts, making it one of the largest museums of its kind in the world. Located in the heart of Cairo, the museum’s iconic pink building was designed by French architect Marcel Dourgnon and features two floors of exhibits spanning 5,000 years of history. Highlights include the treasures of Tutankhamun’s tomb, such as his iconic gold mask, weighing 11 kilograms and inlaid with semi-precious stones, as well as the Narmer Palette, which commemorates the unification of Upper and Lower Egypt. The museum also displays royal mummies, colossal statues, and intricate jewelry, offering a comprehensive look at Pharaonic civilization. While many artifacts are being transferred to the new Grand Egyptian Museum in Giza, the Tahrir museum remains a must-visit for its historical ambiance and unparalleled collection.',
    openingHours: [
      'Sunday (09:00-17:00)',
      'Monday (09:00-17:00)',
      'Tuesday (09:00-17:00)',
      'Wednesday (09:00-17:00)',
      'Thursday (09:00-17:00)',
      'Friday (09:00-17:00)',
      'Saturday (09:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 200EGP/Ticket',
      'Foreign Student: 100EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Book a guided tour to navigate the vast collection.',
      'Visit Tutankhamun’s gallery for the gold mask.',
      'Allow 2-3 hours to explore the highlights.',
      'Photography requires a separate ticket, so plan ahead.',
      'Combine with a visit to nearby Tahrir Square.',
    ],
    category: 'Egyptian Museum Tahrir',
    galleryImages: [
      'lib/home_page/images/egyptian museum tahrir/egyptian museum tahrir_1.jpg',
      'lib/home_page/images/egyptian museum tahrir/egyptian museum tahrir_2.jpg',
      'lib/home_page/images/egyptian museum tahrir/egyptian museum tahrir_3.jpg',

    ],
  ),
  Place(
    title: 'Egyptian National Military Museum',
    location: 'Cairo, Egypt',
    imagePath: 'lib/home_page/images/egyptian_national_military_museum.jpg',
    description:
    'The Egyptian National Military Museum, located within the Citadel of Salah al-Din in Cairo, was established in 1937 to document Egypt’s military history from the Pharaonic era to modern times. Housed in the former palace of Mehmet Ali, the museum features an extensive collection of weapons, uniforms, military equipment, and dioramas depicting key battles, such as the Battle of Kadesh under Ramesses II and the 1973 October War against Israel. The museum is divided into several halls, including the Pharaonic Hall, Islamic Hall, and Modern History Hall, each showcasing artifacts like ancient swords, Ottoman armor, and tanks from the 20th century. The outdoor garden displays military vehicles and aircraft, adding to the immersive experience. The museum offers a detailed look at Egypt’s martial heritage and its role in shaping the nation’s history, making it a significant cultural and educational site.',
    openingHours: [
      'Sunday (09:00-16:00)',
      'Monday (09:00-16:00)',
      'Tuesday (09:00-16:00)',
      'Wednesday (09:00-16:00)',
      'Thursday (09:00-16:00)',
      'Friday (09:00-16:00)',
      'Saturday (09:00-16:00)',
    ],
    prices: [
      'Egyptian Student: 10EGP/Ticket',
      'Foreigner: 100EGP/Ticket',
      'Foreign Student: 50EGP/Ticket',
      'Egyptian: 20EGP/Ticket',
    ],
    touristTips: [
      'Explore the outdoor garden with military vehicles.',
      'Visit the October War hall for modern history.',
      'Wear comfortable shoes for the large museum.',
      'Combine with a tour of the Citadel of Salah al-Din.',
      'Bring a camera for photos of the displays.',
    ],
    category: 'Egyptian National Military Museum',
    galleryImages: [
      'lib/home_page/images/egyptian_national_military_museum/egyptian_national_military_museum_1.jpg',
      'lib/home_page/images/egyptian_national_military_museum/egyptian_national_military_museum_2.jpg',
      'lib/home_page/images/egyptian_national_military_museum/egyptian_national_military_museum_3.jpg',

    ],
  ),
  Place(
    title: 'Fatimid Cemetery in Aswan',
    location: 'Aswan, Egypt',
    imagePath: 'lib/home_page/images/fatimid_cemetery_aswan.jpg',
    description:
    'The Fatimid Cemetery in Aswan, established during the Fatimid Caliphate (909–1171 AD), is one of the oldest Islamic burial grounds in Egypt. Located on the east bank of the Nile, it contains hundreds of mud-brick tombs with domed roofs, reflecting the architectural style of the Fatimid period. The tombs belong to local dignitaries, scholars, and religious figures, many adorned with Arabic inscriptions and geometric patterns. The cemetery offers a glimpse into the funerary practices of medieval Islamic Egypt and the influence of Fatimid culture in the region. Some tombs date back to the 9th century, predating the Fatimid dynasty, indicating the site’s long history as a burial ground. The cemetery’s serene setting and historical significance make it a point of interest for visitors exploring Aswan’s Islamic heritage, though it remains less visited than other local attractions.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: Free',
      'Foreigner: Free',
      'Foreign Student: Free',
      'Egyptian: Free',
    ],
    touristTips: [
      'Visit in the late afternoon for cooler temperatures.',
      'Bring a guide to read Arabic inscriptions on tombs.',
      'Wear comfortable shoes for walking on uneven ground.',
      'Enjoy Nile views from the cemetery’s location.',
      'Be respectful, as it’s an active burial site.',
    ],
    category: 'Fatimid Cemetery in Aswan',
    galleryImages: [
      'lib/home_page/images/fatimid_cemetery/fatimid_cemetery_1.jpg',
      'lib/home_page/images/fatimid_cemetery/fatimid_cemetery_2.jpg',
      'lib/home_page/images/fatimid_cemetery/fatimid_cemetery_3.jpg',

    ],
  ),
  Place(
    title: 'Gebel el-Silsila',
    location: 'Aswan, Egypt',
    imagePath: 'lib/home_page/images/gebel_el_silsila.jpg',
    description:
    'Gebel el-Silsila, a sandstone quarry site on the Nile between Aswan and Luxor, was active from the Middle Kingdom to the Roman period (circa 2000 BC to 300 AD). It supplied stone for some of Egypt’s most famous monuments, including the temples of Karnak, Luxor, and the Ramesseum. The site features over 60 quarries, rock-cut chapels, and shrines dedicated to deities like Sobek and Amun-Ra, as well as thousands of inscriptions and graffiti left by workers. The most notable structure is the Speos of Horemheb, a rock-cut chapel from the 18th Dynasty, adorned with reliefs of the pharaoh making offerings. Gebel el-Silsila’s strategic location on the Nile made it a key resource hub, and its archaeological remains provide insights into ancient quarrying techniques and religious practices. The site’s dramatic cliffs and riverside setting make it a picturesque destination for history enthusiasts.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 80EGP/Ticket',
      'Foreign Student: 40EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Hire a guide to explain the quarrying techniques.',
      'Visit the Speos of Horemheb for unique reliefs.',
      'Bring sunscreen and water, as the site is exposed.',
      'Combine with a Nile cruise for easy access.',
      'Wear sturdy shoes for rocky terrain.',
    ],
    category: 'Gebel el-Silsila',
    galleryImages: [
      'lib/home_page/images/gebel_silsila/gebel_silsila_1.jpg',
      'lib/home_page/images/gebel_silsila/gebel_silsila_2.jpg',
      'lib/home_page/images/gebel_silsila/gebel_silsila_3.jpg',

    ],
  ),
  Place(
    title: 'Giza Zoo',
    location: 'Giza, Egypt',
    imagePath: 'lib/home_page/images/giza_zoo.jpg',
    description:
    'The Giza Zoo, founded in 1891 by Khedive Ismail, is one of the oldest zoological parks in the Middle East, spanning 80 acres near the Nile in Giza. It houses over 4,000 animals representing 175 species, including rare Egyptian wildlife like the Nubian ibex and the Egyptian mongoose, as well as international animals such as lions, elephants, and giraffes. The zoo features lush gardens, a suspension bridge designed by Gustave Eiffel, and a small museum displaying preserved specimens. It was originally created as part of Khedive Ismail’s modernization efforts, with animals sourced from Africa and Asia, and its design reflects a Victorian-era aesthetic with shaded pathways and artificial lakes. The zoo remains a popular family attraction in Cairo, offering educational programs and a chance to explore Egypt’s biodiversity, though it has faced criticism for animal welfare conditions in recent years.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 5EGP/Ticket',
      'Foreigner: 20EGP/Ticket',
      'Foreign Student: 10EGP/Ticket',
      'Egyptian: 10EGP/Ticket',
    ],
    touristTips: [
      'Visit early to see animals before the heat.',
      'Bring snacks and water, as food options are limited.',
      'Explore the suspension bridge for a unique view.',
      'Check for educational programs for kids.',
      'Wear comfortable shoes for walking the large park.',
    ],
    category: 'Giza Zoo',
    galleryImages: [
      'lib/home_page/images/giza_zoo/giza_zoo_1.jpg',
      'lib/home_page/images/giza_zoo/giza_zoo_2.jpg',
      'lib/home_page/images/giza_zoo/giza_zoo_3.jpg',
    ],
  ),
  Place(
    title: 'Great Hypostyle Hall of Karnak',
    location: 'Luxor, Egypt',
    imagePath: 'lib/home_page/images/great_hypostyle_hall_karnak.jpg',
    description:
    'The Great Hypostyle Hall of Karnak, part of the Karnak Temple Complex in Luxor, is a marvel of ancient Egyptian architecture, built primarily during the 19th Dynasty under Seti I and Ramesses II (circa 1290–1224 BC). The hall spans 5,000 square meters and features 134 colossal columns arranged in 16 rows, with the central 12 columns standing 21 meters tall, each with a diameter of over 3 meters. The columns are decorated with intricate reliefs depicting pharaonic rituals and offerings to Amun-Ra, the chief deity of Thebes. The hall’s roof, now largely gone, was once supported by massive stone lintels, creating a forest of towering stone that symbolized the primeval marsh of creation. The hall was used for religious ceremonies during the annual Opet Festival, connecting the precincts of Amun-Ra and Mut. Today, it remains one of the most awe-inspiring structures in Egypt, drawing visitors for its grandeur and historical significance.',
    openingHours: [
      'Sunday (06:00-17:30)',
      'Monday (06:00-17:30)',
      'Tuesday (06:00-17:30)',
      'Wednesday (06:00-17:30)',
      'Thursday (06:00-17:30)',
      'Friday (06:00-17:30)',
      'Saturday (06:00-17:30)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 200EGP/Ticket',
      'Foreign Student: 100EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit early or late to avoid crowds and heat.',
      'Hire a guide to explain the reliefs and columns.',
      'Bring a camera for the hall’s stunning architecture.',
      'Combine with a visit to other Karnak precincts.',
      'Wear comfortable shoes for walking the complex.',
    ],
    category: 'Great Hypostyle Hall of Karnak',
    galleryImages: [
      'lib/home_page/images/great hypostyle hall of karnak/great hypostyle hall of karnak_1.jpg',
      'lib/home_page/images/great hypostyle hall of karnak/great hypostyle hall of karnak_2.jpg',
      'lib/home_page/images/great hypostyle hall of karnak/great hypostyle hall of karnak_3.jpg',

    ],
  ),
  Place(
    title: 'Hanging Church (Cairo)',
    location: 'Cairo, Egypt',
    imagePath: 'lib/home_page/images/hanging_church_cairo.jpg',
    description:
    'The Hanging Church, or Saint Virgin Mary’s Coptic Orthodox Church, is one of the oldest Christian sites in Egypt, dating to the 3rd century AD. Located in Coptic Cairo, it is suspended over the southern gate of the Babylon Fortress, giving it the "hanging" appearance due to its elevated position on Roman-era foundations. The church features a wooden roof shaped like Noah’s Ark, 13 marble columns representing Christ and the apostles, and over 100 icons, some dating to the 8th century. Its façade is adorned with two bell towers, added in the 19th century, and its interior includes a marble pulpit and inlaid ivory screens. The church has been a center of Coptic worship for centuries and houses relics of saints, making it a significant pilgrimage site. It remains an active place of worship and a key stop on the Holy Family Trail, believed to trace the journey of Jesus, Mary, and Joseph in Egypt.',
    openingHours: [
      'Sunday (09:00-16:00)',
      'Monday (09:00-16:00)',
      'Tuesday (09:00-16:00)',
      'Wednesday (09:00-16:00)',
      'Thursday (09:00-16:00)',
      'Friday (09:00-16:00)',
      'Saturday (09:00-16:00)',
    ],
    prices: [
      'Egyptian Student: Free',
      'Foreigner: Free',
      'Foreign Student: Free',
      'Egyptian: Free',
    ],
    touristTips: [
      'Dress modestly to respect the religious site.',
      'Visit as part of a Coptic Cairo tour.',
      'Admire the icons and wooden roof design.',
      'Check for services or festivals for a cultural experience.',
      'Be prepared for narrow stairs to enter the church.',
    ],
    category: 'Hanging Church (Cairo)',
    galleryImages: [
      'lib/home_page/images/hanging_church/hanging_church_1.jpg',
      'lib/home_page/images/hanging_church/hanging_church_2.jpg',
      'lib/home_page/images/hanging_church/hanging_church_3.jpg',

    ],
  ),
  Place(
    title: 'Ibn Tulun Mosque',
    location: 'Cairo, Egypt',
    imagePath: 'lib/home_page/images/ibn_tulun_mosque.jpg',
    description:
    'The Ibn Tulun Mosque, built between 876 and 879 AD by Ahmad ibn Tulun, the Abbasid governor of Egypt, is one of the oldest and largest mosques in Egypt, covering 26,000 square meters. Its Samarra-style architecture, inspired by the Great Mosque of Samarra in Iraq, includes a spiral minaret—the only one of its kind in Egypt—offering panoramic views of Cairo. The mosque features a vast courtyard surrounded by arcades with pointed arches, a pioneering design in Islamic architecture, and stucco decorations with floral and geometric patterns. The prayer hall contains 42 windows for natural light and ventilation, and its mihrab is adorned with intricate marble work. The mosque has been a center of worship and learning for over a millennium and was recently restored to preserve its original structure. Located in the historic Sayyida Zaynab district, it remains an active mosque and a popular tourist destination.',
    openingHours: [
      'Sunday (08:00-20:00)',
      'Monday (08:00-20:00)',
      'Tuesday (08:00-20:00)',
      'Wednesday (08:00-20:00)',
      'Thursday (08:00-20:00)',
      'Friday (08:00-20:00)',
      'Saturday (08:00-20:00)',
    ],
    prices: [
      'Egyptian Student: Free',
      'Foreigner: Free',
      'Foreign Student: Free',
      'Egyptian: Free',
    ],
    touristTips: [
      'Climb the spiral minaret for panoramic Cairo views.',
      'Dress modestly; women should bring a headscarf.',
      'Visit during non-prayer times for a quiet experience.',
      'Admire the courtyard’s vast size and arches.',
      'Combine with a visit to the Gayer-Anderson Museum nearby.',
    ],
    category: 'Ibn Tulun Mosque',
    galleryImages: [
      'lib/home_page/images/ibn tulun/ibn tulun_1.jpg',
      'lib/home_page/images/ibn tulun/ibn tulun_2.jpg',
      'lib/home_page/images/ibn tulun/ibn tulun_3.jpg',

    ],
  ),
  Place(
    title: 'Isis with her child',
    location: 'Philae Temple, Aswan, Egypt',
    imagePath: 'lib/home_page/images/isis_with_her_child.jpg',
    description:
    'The image of Isis with her child, Horus, is a recurring motif in ancient Egyptian art, prominently featured in the Temple of Philae, a sacred site dedicated to Isis on an island in the Nile near Aswan. Dating to the Ptolemaic period (circa 300–30 BC), these depictions show Isis nursing Horus, symbolizing protection, motherhood, and divine nurturing. The temple, relocated to Agilika Island in the 1970s to save it from flooding caused by the Aswan High Dam, features well-preserved reliefs of this scene, often showing Isis seated with Horus on her lap, surrounded by lotus flowers and solar disks. Isis was one of the most revered deities in ancient Egypt, associated with magic and healing, and her cult spread across the Roman Empire. The temple’s serene setting and detailed carvings make it a highlight of Egypt’s Ptolemaic heritage, attracting visitors interested in mythology and ancient art.',
    openingHours: [
      'Sunday (07:00-17:00)',
      'Monday (07:00-17:00)',
      'Tuesday (07:00-17:00)',
      'Wednesday (07:00-17:00)',
      'Thursday (07:00-17:00)',
      'Friday (07:00-17:00)',
      'Saturday (07:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 140EGP/Ticket',
      'Foreign Student: 70EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Take a boat to the temple for a scenic approach.',
      'Visit at sunset for beautiful views and cooler weather.',
      'Hire a guide to explain the Isis mythology.',
      'Bring a camera for the temple’s detailed reliefs.',
      'Wear comfortable shoes for walking on uneven surfaces.',
    ],
    category: 'Isis with her child',
    galleryImages: [
      'lib/home_page/images/isis with her child/isis with her child_1.jpg',
      'lib/home_page/images/isis with her child/isis with her child_2.jpg',
      'lib/home_page/images/isis with her child/isis with her child_3.jpg',

    ],
  ),
  Place(
    title: 'Luxor Temple',
    location: 'Luxor, Egypt',
    imagePath: 'lib/home_page/images/luxor_temple.jpg',
    description:
    'Luxor Temple, founded around 1400 BC during the New Kingdom, is a magnificent ancient Egyptian temple dedicated to the Theban Triad of Amun-Ra, Mut, and Khonsu. Located on the east bank of the Nile in Luxor, it was a key religious center for the annual Opet Festival, during which statues of the gods were carried in a procession from Karnak to Luxor Temple, symbolizing the renewal of royal power. The temple features a grand entrance pylon, a colonnade of 14 columns with papyrus capitals built by Amenhotep III, and a large courtyard added by Ramesses II, who also erected two colossal statues of himself at the entrance. The Avenue of Sphinxes, a 2.7-kilometer-long path lined with sphinx statues, connects Luxor Temple to Karnak. The temple’s well-preserved reliefs and its nighttime illumination make it a stunning attraction, offering a window into ancient Egyptian religious practices.',
    openingHours: [
      'Sunday (06:00-21:00)',
      'Monday (06:00-21:00)',
      'Tuesday (06:00-21:00)',
      'Wednesday (06:00-21:00)',
      'Thursday (06:00-21:00)',
      'Friday (06:00-21:00)',
      'Saturday (06:00-21:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 160EGP/Ticket',
      'Foreign Student: 80EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit at night when the temple is beautifully lit.',
      'Walk the Avenue of Sphinxes to Karnak Temple.',
      'Hire a guide to learn about the Opet Festival.',
      'Bring a camera for the colossal statues and reliefs.',
      'Wear comfortable shoes for exploring the large complex.',
    ],
    category: 'Luxor Temple',
    galleryImages: [
      'lib/home_page/images/luxor_temple/luxor_temple_1.jpg',
      'lib/home_page/images/luxor_temple/luxor_temple_2.jpg',
      'lib/home_page/images/luxor_temple/luxor_temple_3.jpg',

    ],
  ),
  Place(
    title: 'Mask of Tutankhamun',
    location: 'Grand Egyptian Museum,Cairo, Egypt',
    imagePath: 'lib/home_page/images/mask_of_tutankhamun.jpg',
    description:
    'The Mask of Tutankhamun, discovered in 1925 by Howard Carter in the Valley of the Kings, is an iconic artifact from around 1323 BC, crafted for the young pharaoh’s burial. Made of 11 kilograms of solid gold and inlaid with lapis lazuli, turquoise, and carnelian, the mask depicts Tutankhamun with a serene expression, wearing a nemes headdress with a broad collar necklace and a vulture and cobra on his forehead, symbolizing protection. The mask was found covering the face of Tutankhamun’s mummy in his tomb (KV62), which contained over 5,000 artifacts, making it one of the most significant archaeological discoveries in history. Housed in the Egyptian Museum in Cairo, the mask is a masterpiece of ancient Egyptian art, showcasing the skill of New Kingdom craftsmen. Its discovery brought global attention to Tutankhamun, a relatively minor pharaoh who ruled for only nine years, and it remains a symbol of Egypt’s ancient splendor.',
    openingHours: [
      'Sunday (09:00-17:00)',
      'Monday (09:00-17:00)',
      'Tuesday (09:00-17:00)',
      'Wednesday (09:00-17:00)',
      'Thursday (09:00-17:00)',
      'Friday (09:00-17:00)',
      'Saturday (09:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 30EGP/Ticket',
      'Foreigner: 500EGP/Ticket',
      'Foreign Student: 250EGP/Ticket',
      'Egyptian: 60EGP/Ticket',
    ],
    touristTips: [
      'Visit the Grand Egyptian Museum to see the mask.',
      'Book a guided tour for context on Tutankhamun’s tomb.',
      'Allow time to explore other artifacts from KV62.',
      'Photography may require a special ticket, so check.',
      'Visit early to avoid crowds in the gallery.',
    ],
    category: 'Mask of Tutankhamun',
    galleryImages: [
      'lib/home_page/images/mask of tutankhamun/mask of tutankhamun_1.jpg',
      'lib/home_page/images/mask of tutankhamun/mask of tutankhamun_2.jpg',
      'lib/home_page/images/mask of tutankhamun/mask of tutankhamun_3.jpg',

    ],
  ),
  Place(
    title: 'Monastery of Saint Simeon in Aswan',
    location: 'Aswan, Egypt',
    imagePath: 'lib/home_page/images/monastery_of_saint_simeon.jpg',
    description:
    'The Monastery of Saint Simeon, a 7th-century Coptic monastery in Aswan, was home to up to 1,000 monks at its peak, making it one of the largest monastic communities in early Christian Egypt. Located on a hill overlooking the Nile, the monastery was built from mud bricks and features a basilica-style church with remnants of frescoes depicting biblical scenes, as well as living quarters, a refectory, and a defensive wall with towers. Dedicated to Saint Simeon, a local hermit, the monastery played a key role in spreading Christianity in Nubia, with monks traveling as far as Sudan to evangelize. The site was abandoned in the 13th century due to water shortages and invasions. Accessible by camel or boat, the monastery offers stunning views of the Nile and the surrounding desert, providing a peaceful retreat for visitors interested in Egypt’s Christian heritage.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 80EGP/Ticket',
      'Foreign Student: 40EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Access by camel or boat for an adventurous trip.',
      'Bring water and a hat for the sunny hilltop site.',
      'Explore the frescoes in the basilica-style church.',
      'Enjoy Nile and desert views from the monastery.',
      'Wear sturdy shoes for walking on rocky paths.',
    ],
    category: 'Monastery of Saint Simeon in Aswan',
    galleryImages: [
      'lib/home_page/images/monastery_of_saint_simeon/monastery_of_saint_simeon_1.jpg',
      'lib/home_page/images/monastery_of_saint_simeon/monastery_of_saint_simeon_2.jpg',
      'lib/home_page/images/monastery_of_saint_simeon/monastery_of_saint_simeon_3.jpg',
    ],
  ),
  Place(
    title: 'Montaza Palace',
    location: 'Alexandria, Egypt',
    imagePath: 'lib/home_page/images/montaza_palace.jpg',
    description:
    'Montaza Palace, built in 1892 by Khedive Abbas II in Alexandria, is a royal residence blending Ottoman and Florentine architectural styles, reflecting the eclectic tastes of Egypt’s monarchy during the late 19th century. Located on the Mediterranean coast, the palace is surrounded by 150 acres of lush gardens filled with palm trees, gazebos, and rare plants, making it a popular recreational spot for locals and tourists. The palace itself features a central tower, arched windows, and ornate interiors with frescoed ceilings and marble floors, though it is not open to the public. It served as a summer retreat for the royal family until the 1952 revolution, when it was nationalized. The gardens include several pavilions, a beach, and a bridge connecting the palace to the seafront, offering stunning views of the Mediterranean. Montaza remains a symbol of Alexandria’s cosmopolitan past and its role as a royal resort city.',
    openingHours: [
      'Sunday (08:00-18:00)',
      'Monday (08:00-18:00)',
      'Tuesday (08:00-18:00)',
      'Wednesday (08:00-18:00)',
      'Thursday (08:00-18:00)',
      'Friday (08:00-18:00)',
      'Saturday (08:00-18:00)',
    ],
    prices: [
      'Egyptian Student: 10EGP/Ticket',
      'Foreigner: 50EGP/Ticket',
      'Foreign Student: 25EGP/Ticket',
      'Egyptian: 20EGP/Ticket',
    ],
    touristTips: [
      'Explore the gardens for a relaxing walk.',
      'Visit the beach area for Mediterranean views.',
      'Bring a picnic to enjoy in the lush grounds.',
      'Check if pavilions are open for events.',
      'Wear comfortable shoes for the large estate.',
    ],
    category: 'Montaza Palace',
    galleryImages: [
      'lib/home_page/images/montaza_palace/montaza_palace_1.jpg',
      'lib/home_page/images/montaza_palace/montaza_palace_2.jpg',
      'lib/home_page/images/montaza_palace/montaza_palace_3.jpg',

    ],
  ),
  Place(
    title: 'Nefertiti',
    location: 'Amarna, Egypt',
    imagePath: 'lib/home_page/images/nefertiti.jpg',
    description:
    'The Bust of Nefertiti, discovered in 1912 by German archaeologist Ludwig Borchardt in Amarna, is a masterpiece of ancient Egyptian art from around 1345 BC. Depicting Queen Nefertiti, the wife of Pharaoh Akhenaten, the bust is renowned for its exquisite realism, with a lifelike depiction of the queen’s facial features, including her high cheekbones, almond-shaped eyes, and a slight smile. Crafted by the sculptor Thutmose, the bust is made of limestone with a stucco overlay, painted in vivid colors, and features a blue headdress with a golden band and a broad collar necklace. The right eye is inlaid with quartz and a black pupil, while the left eye is unfinished, adding to its mystery. Housed in Berlin’s Neues Museum, the bust has become a global symbol of ancient beauty and is one of the most recognizable artifacts from Amarna, reflecting the artistic revolution of Akhenaten’s reign.',
    openingHours: [
      'Not Applicable ',
    ],
    prices: [
      'Not Applicable',
    ],
    touristTips: [
      'Visit the Neues Museum in Berlin to see the bust.',
      'Book a guided tour for context on the Amarna period.',
      'Learn about Nefertiti’s role in Akhenaten’s reign.',
      'Photography is allowed, but no flash is permitted.',
      'Combine with other Egyptian artifacts in the museum.',
    ],
    category: 'Nefertiti',
    galleryImages: [
      'lib/home_page/images/nefertiti/nefertiti_1.jpg',
      'lib/home_page/images/nefertiti/nefertiti_2.jpg',
      'lib/home_page/images/nefertiti/nefertiti_3.jpg',

    ],
  ),
  Place(
    title: 'Ptolemaic Temple of Hathor in Deir el-Medina',
    location: 'Luxor, Egypt',
    imagePath: 'lib/home_page/images/ptolemaic_temple_hathor.jpg',
    description:
    'The Ptolemaic Temple of Hathor in Deir el-Medina was constructed during the Ptolemaic period (circa 300–30 BC) near the workers’ village of Deir el-Medina, close to the Valley of the Kings in Luxor. Dedicated to Hathor, the goddess of love, music, and fertility, the temple was a place of worship for the artisans who built the royal tombs. The small, well-preserved structure features a sandstone façade with a gateway leading to a hall decorated with colorful reliefs of Hathor, often depicted as a cow or with cow ears, symbolizing her nurturing role. The temple also includes scenes of the Ptolemaic rulers making offerings, reflecting the blending of Greek and Egyptian traditions during this period. The temple’s intimate size and detailed carvings make it a hidden gem, offering a contrast to the larger monuments of Luxor and a glimpse into the religious life of the Deir el-Medina community.',
    openingHours: [
      'Sunday (06:00-17:00)',
      'Monday (06:00-17:00)',
      'Tuesday (06:00-17:00)',
      'Wednesday (06:00-17:00)',
      'Thursday (06:00-17:00)',
      'Friday (06:00-17:00)',
      'Saturday (06:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 100EGP/Ticket',
      'Foreign Student: 50EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Hire a guide to explain Hathor’s mythology.',
      'Visit with Deir el-Medina for a complete tour.',
      'Bring a camera for the temple’s colorful reliefs.',
      'Wear sturdy shoes for walking the site.',
      'Explore nearby artisans’ tombs for context.',
    ],
    category: 'Ptolemaic Temple of Hathor in Deir el-Medina',
    galleryImages: [
      'lib/home_page/images/ptolemaic_temple_of_hathor/ptolemaic_temple_of_hathor_1.jpg',
      'lib/home_page/images/ptolemaic_temple_of_hathor/ptolemaic_temple_of_hathor_2.jpg',
      'lib/home_page/images/ptolemaic_temple_of_hathor/ptolemaic_temple_of_hathor_3.jpg',
    ],
  ),
  Place(
    title: 'Pyramid of Djoser in Saqqara',
    location: 'Giza, Egypt',
    imagePath: 'lib/home_page/images/pyramid_of_djoser.jpg',
    description:
    'The Pyramid of Djoser, located in Saqqara, is the first pyramid ever built in ancient Egypt, dating to around 2630 BC during the Third Dynasty. Designed by Imhotep, who is often credited as the world’s first named architect, the pyramid is a step pyramid with six tiers, rising to a height of 62 meters. It marks the beginning of monumental stone architecture in Egypt, transitioning from earlier mastaba tombs to the more ambitious pyramid form. The pyramid is part of a larger funerary complex that includes a colonnaded courtyard, a heb-sed court for the king’s jubilee festival, and a southern tomb. The complex is surrounded by a 10.5-meter-high limestone wall with 14 false doors, symbolizing the boundary between the sacred and the profane. Recently restored, the pyramid’s interior chambers are now accessible, revealing ancient construction techniques. The site is a UNESCO World Heritage Site and a key stop for those exploring Egypt’s Old Kingdom history.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 180EGP/Ticket',
      'Foreign Student: 90EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit early for a quieter experience than Giza.',
      'Hire a guide to learn about Imhotep’s design.',
      'Explore the funerary complex’s courtyards.',
      'Bring sunscreen and water, as shade is limited.',
      'Wear sturdy shoes for walking the sandy site.',
    ],
    category: 'Pyramid of Djoser in Saqqara',
    galleryImages: [
      'lib/home_page/images/pyramid of djoser/pyramid of djoser_1.jpg',
      'lib/home_page/images/pyramid of djoser/pyramid of djoser_2.jpg',
      'lib/home_page/images/pyramid of djoser/pyramid of djoser_3.jpg',
    ],
  ),
  Place(
    title: 'Pyramid of Unas',
    location: 'Saqqara, Egypt',
    imagePath: 'lib/home_page/images/pyramid_of_unas.jpg',
    description:
    'The Pyramid of Unas, built around 2350 BC in Saqqara, belongs to Pharaoh Unas, the last ruler of the Fifth Dynasty. Though modest in size at 43 meters tall, it is famous for the Pyramid Texts inscribed on the walls of its burial chamber and antechamber, making it the earliest known example of such religious writings in a royal tomb. These texts, a collection of spells and prayers intended to guide the pharaoh to the afterlife, later evolved into the Book of the Dead. The pyramid’s exterior was originally cased in fine Tura limestone, though much of it has eroded, revealing the rough core. The complex includes a causeway decorated with reliefs of daily life and a mortuary temple, both well-preserved. The pyramid’s historical significance lies in its role as a precursor to the more elaborate tomb decorations of the New Kingdom, and its serene setting in Saqqara makes it a fascinating visit.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 180EGP/Ticket',
      'Foreign Student: 90EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Explore the Pyramid Texts inside the burial chamber.',
      'Hire a guide to explain the religious significance.',
      'Visit with other Saqqara pyramids for a full tour.',
      'Bring a flashlight for better visibility in chambers.',
      'Wear comfortable shoes for the sandy terrain.',
    ],
    category: 'Pyramid of Unas',
    galleryImages: [
      'lib/home_page/images/pyramid_of_unas/pyramid_of_unas_1.jpg',
      'lib/home_page/images/pyramid_of_unas/pyramid_of_unas_2.jpg',
      'lib/home_page/images/pyramid_of_unas/pyramid_of_unas_3.jpg',

    ],
  ),
  Place(
    title: 'Qubbet el-Hawa',
    location: 'Aswan, Egypt',
    imagePath: 'lib/home_page/images/qubbet_el_hawa.jpg',
    description:
    'Qubbet el-Hawa, or the Dome of the Wind, is a necropolis on the west bank of the Nile in Aswan, used as a burial ground for nobles and officials from the Old and Middle Kingdoms (circa 2686–1782 BC). The site contains over 80 rock-cut tombs carved into the hillside, many with detailed inscriptions and reliefs depicting the deceased’s journey to the afterlife. Notable tombs include those of Harkhuf, a governor who led expeditions to Nubia, and Sarenput II, whose tomb features a statue niche and vivid paintings. The tombs offer insights into ancient burial practices, trade routes, and the administrative roles of Aswan’s elite. At the summit of the hill is a small Islamic shrine, the Qubbet el-Hawa, which gives the site its name and provides panoramic views of the Nile and the surrounding desert. The necropolis’s historical and scenic value makes it a unique destination in Aswan.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 80EGP/Ticket',
      'Foreign Student: 40EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Hire a guide to read inscriptions in the tombs.',
      'Visit the hilltop shrine for Nile views.',
      'Bring water and a hat for the sunny climb.',
      'Wear sturdy shoes for the rocky hillside.',
      'Combine with a visit to Aswan’s other sites.',
    ],
    category:  'Qubbet_el_Hawa',
    galleryImages: [
      'lib/home_page/images/qubbet_el_hawa/qubbet_el_hawa_1.jpg',
      'lib/home_page/images/qubbet_el_hawa/qubbet_el_hawa_2.jpg',
      'lib/home_page/images/qubbet_el_hawa/qubbet_el_hawa_3.jpg',
    ],
  ),
  Place(
    title: 'Ramesseum',
    location: 'Luxor, Egypt',
    imagePath: 'lib/home_page/images/ramesseum.jpg',
    description:
    'The Ramesseum is the mortuary temple of Pharaoh Ramesses II, built in the 13th century BC on the west bank of the Nile in Luxor. Dedicated to the worship of Ramesses II after his death, the temple features a colossal statue of the pharaoh, originally 17 meters tall, though now fallen and fragmented, inspiring Percy Bysshe Shelley’s poem "Ozymandias." The temple’s hypostyle hall contains 48 columns, some still standing, adorned with reliefs of Ramesses II’s military victories, including the Battle of Kadesh against the Hittites, which resulted in one of the first recorded peace treaties in history. The complex also includes a smaller temple for Ramesses II’s mother, Tuya, and a sacred library, one of the earliest known in the world. The Ramesseum’s partially ruined state, with scattered statues and mud-brick remains, evokes the passage of time, making it a poignant site for visitors exploring the legacy of one of Egypt’s greatest pharaohs.',
    openingHours: [
      'Sunday (06:00-17:00)',
      'Monday (06:00-17:00)',
      'Tuesday (06:00-17:00)',
      'Wednesday (06:00-17:00)',
      'Thursday (06:00-17:00)',
      'Friday (06:00-17:00)',
      'Saturday (06:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 100EGP/Ticket',
      'Foreign Student: 50EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Hire a guide to explain the Battle of Kadesh reliefs.',
      'Visit the fallen colossal statue for photos.',
      'Bring a hat and water, as shade is limited.',
      'Combine with a tour of nearby Medinet Habu.',
      'Wear comfortable shoes for the large site.',
    ],
    category: 'Ramesseum',
    galleryImages: [
      'lib/home_page/images/ramesseum/ramesseum_1.jpg',
      'lib/home_page/images/ramesseum/ramesseum_2.jpg',
      'lib/home_page/images/ramesseum/ramesseum_3.jpg',

    ],
  ),
  Place(
    title: 'Saint George Church in Coptic Cairo',
    location: 'Cairo, Egypt',
    imagePath: 'lib/home_page/images/saint_george_church.jpg',
    description:
    'The Saint George Church, located in Coptic Cairo, is a 10th-century Greek Orthodox church built over a Roman tower of the Babylon Fortress. Dedicated to Saint George, a Christian martyr revered for slaying a dragon in legend, the church is a significant site for Egypt’s Coptic and Greek Orthodox communities. Its circular design, unusual for Coptic architecture, features a domed roof and a small nave with a wooden iconostasis adorned with icons of Saint George and other saints. The church was rebuilt several times after fires, with its current structure dating to 1909, though it retains elements from earlier periods, such as 13th-century frescoes. Adjacent to the church is a small museum and a hall used for weddings and baptisms, reflecting its active role in the community. The church is part of the Coptic Cairo complex, which traces the Holy Family’s journey in Egypt, making it a key stop for religious tourists.',
    openingHours: [
      'Sunday (09:00-16:00)',
      'Monday (09:00-16:00)',
      'Tuesday (09:00-16:00)',
      'Wednesday (09:00-16:00)',
      'Thursday (09:00-16:00)',
      'Friday (09:00-16:00)',
      'Saturday (09:00-16:00)',
    ],
    prices: [
      'Egyptian Student: Free',
      'Foreigner: Free',
      'Foreign Student: Free',
      'Egyptian: Free',
    ],
    touristTips: [
      'Dress modestly to respect the religious site.',
      'Visit the small museum for historical artifacts.',
      'Combine with a Coptic Cairo tour.',
      'Check for religious services or festivals.',
      'Admire the circular design and icons.',
    ],
    category:'Saint George Church in Coptic Cairo',
    galleryImages: [
      'lib/home_page/images/saint_george_church_in_coptic/saint_george_church_in_coptic_1.jpg',
      'lib/home_page/images/saint_george_church_in_coptic/saint_george_church_in_coptic_2.jpg',
      'lib/home_page/images/saint_george_church_in_coptic/saint_george_church_in_coptic_3.jpg',
    ],
  ),
  Place(
    title: 'Sphinx',
    location: 'Giza, Egypt',
    imagePath: 'lib/home_page/images/sphinx.jpg',
    description:
    'The Great Sphinx of Giza, carved around 2500 BC during the Fourth Dynasty, is a limestone statue with the body of a lion and the head of a human, believed to represent Pharaoh Khafre, whose pyramid stands nearby. Located on the Giza Plateau, the Sphinx measures 73 meters long and 20 meters high, making it one of the largest monolithic statues in the world. Its face, thought to be a portrait of Khafre, gazes eastward toward the rising sun, symbolizing protection and divine power. The Sphinx was carved directly from the bedrock of the plateau and features a small temple between its paws, where offerings were made. Over the centuries, it has been buried by sand multiple times, with excavations beginning in the 19th century uncovering its full form. The Sphinx’s nose is missing, likely due to natural erosion or vandalism, and its enduring mystery and grandeur make it a global symbol of ancient Egypt.',
    openingHours: [
      'Sunday (08:00-17:00)',
      'Monday (08:00-17:00)',
      'Tuesday (08:00-17:00)',
      'Wednesday (08:00-17:00)',
      'Thursday (08:00-17:00)',
      'Friday (08:00-17:00)',
      'Saturday (08:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 160EGP/Ticket',
      'Foreign Student: 80EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit with the Giza Pyramids for a full tour.',
      'Take photos at sunrise for the best lighting.',
      'Hire a guide to learn about the Sphinx’s mysteries.',
      'Bring sunscreen and a hat, as shade is scarce.',
      'Attend the Sound and Light Show for a unique view.',
    ],
    category: 'Sphinx',
    galleryImages: [
      'lib/home_page/images/sphinx/sphinx_1.jpg',
      'lib/home_page/images/sphinx/sphinx_2.jpg',
      'lib/home_page/images/sphinx/sphinx_3.jpg',

    ],
  ),
  Place(
    title: 'Statue of King Zoser',
    location: 'Egyptian Museum,Saqqara, Egypt',
    imagePath: 'lib/home_page/images/statue_of_king_zoser.jpg',
    description:
    'The Statue of King Zoser, discovered in 1924 in Saqqara, is a life-sized limestone statue of Pharaoh Djoser from the Third Dynasty (circa 2670 BC), making it one of the earliest known monumental statues in Egyptian history. Found in a serdab (a sealed chamber) near the Step Pyramid of Djoser, the statue depicts the pharaoh seated, wearing a long kilt and a nemes headdress with a false beard, symbols of royal authority. The statue’s eyes, originally inlaid with alabaster and rock crystal, give it a strikingly lifelike appearance, though the inlays have since been removed. Now housed in the Egyptian Museum in Cairo, the statue is painted in vibrant colors, with a black body, white kilt, and red face, reflecting ancient artistic conventions. The statue’s discovery provided key insights into Old Kingdom portraiture and the development of royal iconography, cementing Djoser’s legacy as a pioneering ruler of early Egypt.',
    openingHours: [
      'Sunday (09:00-17:00)',
      'Monday (09:00-17:00)',
      'Tuesday (09:00-17:00)',
      'Wednesday (09:00-17:00)',
      'Thursday (09:00-17:00)',
      'Friday (09:00-17:00)',
      'Saturday (09:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 200EGP/Ticket',
      'Foreign Student: 100EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit the Egyptian Museum to see the statue.',
      'Learn about Djoser’s role in pyramid building.',
      'Book a guided tour for Old Kingdom context.',
      'Photography requires a separate ticket, so plan ahead.',
      'Combine with other museum artifacts.',
    ],
    category: 'Statue of King Zoser',
    galleryImages: [
      'lib/home_page/images/statue of king zoser/statue of king zoser_1.jpg',
      'lib/home_page/images/statue of king zoser/statue of king zoser_2.jpg',
      'lib/home_page/images/statue of king zoser/statue of king zoser_3.jpg',
    ],
  ),
  Place(
    title: 'Statue of Ramesses II',
    location: 'Grand Egyptian Museum,Giza, Egypt',
    imagePath: 'lib/home_page/images/statue_of_ramesses_ii.jpg',
    description:
    'The Statue of Ramesses II is a colossal granite statue of the pharaoh, originally placed at the entrance of the Temple of Ptah in Memphis, the ancient capital of Egypt, around 1250 BC. Discovered in 1820, the statue stands 10 meters tall and depicts Ramesses II standing, holding a staff and wearing a double crown with a uraeus, symbolizing his rule over Upper and Lower Egypt. The statue’s detailed carving highlights the pharaoh’s muscular build and serene expression, showcasing the artistic mastery of the New Kingdom. It was moved to the Grand Egyptian Museum near Giza in 2018, where it greets visitors at the entrance, symbolizing Ramesses II’s enduring legacy as one of Egypt’s greatest rulers. Known for his military campaigns, including the Battle of Kadesh, and his extensive building projects, Ramesses II ruled for 66 years, leaving behind a wealth of monuments that define ancient Egypt’s golden age.',
    openingHours: [
      'Sunday (09:00-17:00)',
      'Monday (09:00-17:00)',
      'Tuesday (09:00-17:00)',
      'Wednesday (09:00-17:00)',
      'Thursday (09:00-17:00)',
      'Friday (09:00-17:00)',
      'Saturday (09:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 30EGP/Ticket',
      'Foreigner: 500EGP/Ticket',
      'Foreign Student: 250EGP/Ticket',
      'Egyptian: 60EGP/Ticket',
    ],
    touristTips: [
      'See the statue at the Grand Egyptian Museum’s entrance.',
      'Book a guided tour for Ramesses II’s history.',
      'Allow time to explore other museum galleries.',
      'Photography may require a special ticket.',
      'Visit early to avoid crowds.',
    ],
    category: 'Statue of Ramesses II',
    galleryImages: [
      'lib/home_page/images/statue of ramesses/statue of ramesses_1.jpg',
      'lib/home_page/images/statue of ramesses/statue of ramesses_2.jpg',
      'lib/home_page/images/statue of ramesses/statue of ramesses_3.jpg',

    ],
  ),
  Place(
    title: 'Statue of Tutankhamun with Ankhesenamun',
    location: 'Grand Egyptian Museum,Giza, Egypt',
    imagePath: 'lib/home_page/images/statue_of_tutankhamun_with_ankhesenamun.jpg',
    description:
    'The Statue of Tutankhamun with Ankhesenamun, found in Tutankhamun’s tomb (KV62) in the Valley of the Kings, dates to around 1323 BC and depicts the young pharaoh and his queen in a tender moment, symbolizing their royal bond. Crafted from wood and overlaid with gold, the small statue shows Tutankhamun standing with Ankhesenamun, who is slightly shorter, holding a lotus flower, a symbol of rebirth. The figures are adorned with detailed jewelry and royal attire, reflecting the opulence of the 18th Dynasty. The statue, now housed in the Egyptian Museum in Cairo, offers a rare glimpse into the personal life of Tutankhamun, who ascended the throne at age nine and ruled for only a decade. Ankhesenamun, his half-sister and wife, is believed to have played a significant role in his reign, and the statue’s intimate portrayal highlights the importance of familial ties in ancient Egyptian royal iconography.',
    openingHours: [
      'Sunday (09:00-17:00)',
      'Monday (09:00-17:00)',
      'Tuesday (09:00-17:00)',
      'Wednesday (09:00-17:00)',
      'Thursday (09:00-17:00)',
      'Friday (09:00-17:00)',
      'Saturday (09:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 30EGP/Ticket',
      'Foreigner: 500EGP/Ticket',
      'Foreign Student: 250EGP/Ticket',
      'Egyptian: 60EGP/Ticket',
    ],
    touristTips: [
      'Visit the Grand Egyptian Museum to see the statue.',
      'Learn about Tutankhamun’s reign with a guide.',
      'Explore other artifacts from his tomb nearby.',
      'Photography may require a special ticket.',
      'Visit early to enjoy a quieter experience.',
    ],
    category: 'Statue of Tutankhamun with Ankhesenamun',
    galleryImages: [
      'lib/home_page/images/statue of tutankhamun with ankhesenamun/statue of tutankhamun with ankhesenamun_1.jpg',
      'lib/home_page/images/statue of tutankhamun with ankhesenamun/statue of tutankhamun with ankhesenamun_2.jpg',
      'lib/home_page/images/statue of tutankhamun with ankhesenamun/statue of tutankhamun with ankhesenamun_3.jpg',

    ],
  ),
  Place(
    title: 'Temple of Kom Ombo',
    location: 'Kom Ombo, Egypt',
    imagePath: 'lib/home_page/images/temple_of_kom_ombo.jpg',
    description:
    'The Temple of Kom Ombo, built during the Ptolemaic period (180–47 BC), is a unique double temple dedicated to two gods: Sobek, the crocodile god associated with fertility and protection, and Horus, the falcon god of the sky and kingship. Located on a bend in the Nile near Aswan, the temple’s symmetrical design features two mirrored sections, each with its own entrance, sanctuary, and hypostyle hall, reflecting the dual dedication. The temple is adorned with well-preserved reliefs, including scenes of surgical instruments, suggesting it may have served as a healing center. A small museum on-site displays mummified crocodiles, emphasizing Sobek’s importance to the region. The temple’s riverside location offers stunning views, especially at sunset, and its columns bear traces of original paint, giving a sense of its ancient vibrancy. Kom Ombo is a testament to the Ptolemaic blending of Greek and Egyptian cultures, making it a fascinating stop on Nile cruises.',
    openingHours: [
      'Sunday (07:00-18:00)',
      'Monday (07:00-18:00)',
      'Tuesday (07:00-18:00)',
      'Wednesday (07:00-18:00)',
      'Thursday (07:00-18:00)',
      'Friday (07:00-18:00)',
      'Saturday (07:00-18:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 140EGP/Ticket',
      'Foreign Student: 70EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit at sunset for stunning Nile views.',
      'Explore the crocodile museum on-site.',
      'Hire a guide to explain the dual temple design.',
      'Bring a camera for the well-preserved reliefs.',
      'Wear comfortable shoes for the temple grounds.',
    ],
    category: 'Temple of Kom Ombo',
    galleryImages: [
      'lib/home_page/images/temple_of_kom_ombo/temple_of_kom_ombo_1.jpg',
      'lib/home_page/images/temple_of_kom_ombo/temple_of_kom_ombo_2.jpg',
      'lib/home_page/images/temple_of_kom_ombo/temple_of_kom_ombo_3.jpg',

    ],
  ),
  Place(
    title: 'Temple of Seti I in Abydos',
    location: 'Abydos, Egypt',
    imagePath: 'lib/home_page/images/temple_of_seti_i.jpg',
    description:
    'The Temple of Seti I in Abydos, built around 1290 BC during the 19th Dynasty, is a well-preserved ancient Egyptian temple dedicated to Osiris and other deities like Isis, Horus, and Amun-Ra. Located in the sacred city of Abydos, it was constructed by Pharaoh Seti I and completed by Ramesses II. The temple is famous for its stunning bas-reliefs, including the Abydos King List, which records 76 pharaohs, showcasing Egypt’s historical legacy. Its unique L-shaped design includes two hypostyle halls with papyrus columns, seven sanctuaries, and the Osireion, a symbolic tomb of Osiris with astronomical carvings. The temple’s detailed reliefs depict Seti I’s offerings and military victories, reflecting the New Kingdom’s artistic excellence. Abydos was a pilgrimage site for Osiris worship, and the temple’s serene setting offers a peaceful visit, highlighting ancient Egypt’s religious and cultural depth.',
    openingHours: [
      'Sunday (07:00-17:00)',
      'Monday (07:00-17:00)',
      'Tuesday (07:00-17:00)',
      'Wednesday (07:00-17:00)',
      'Thursday (07:00-17:00)',
      'Friday (07:00-17:00)',
      'Saturday (07:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 140EGP/Ticket',
      'Foreign Student: 70EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Hire a guide to explain the Abydos King List.',
      'Visit the Osireion for its unique design.',
      'Bring a camera for the stunning bas-reliefs.',
      'Wear comfortable shoes for the temple grounds.',
      'Combine with a visit to nearby Dendera Temple.',
    ],
    category: 'Temple of Seti I in Abydos',
    galleryImages: [
      'lib/home_page/images/temple_of_seti/temple_of_seti_1.jpg',
      'lib/home_page/images/temple_of_seti/temple_of_seti_2.jpg',
      'lib/home_page/images/temple_of_seti/temple_of_seti_3.jpg',

    ],
  ),
  Place(
    title: 'The Great Temple of Ramesses II',
    location: 'Abu Simbel, Egypt',
    imagePath: 'lib/home_page/images/great_temple_of_ramesses_ii.jpg',
    description:
    'The Great Temple of Ramesses II, carved into a mountainside around 1264 BC, is one of the most iconic monuments of ancient Egypt, located in Abu Simbel near the Sudanese border. Built by Pharaoh Ramesses II, the temple is dedicated to the gods Amun-Ra, Ra-Horakhty, and Ptah, as well as the deified pharaoh himself. Its façade features four colossal statues of Ramesses II, each 20 meters tall, seated and flanked by smaller figures of his family, symbolizing his power and divine status. Inside, the hypostyle hall contains eight Osiris pillars, leading to a sanctuary where the sun illuminates the statues of the gods twice a year, on February 22 and October 22, a phenomenon showcasing ancient Egyptian astronomical precision. The temple was relocated in the 1960s to save it from flooding by Lake Nasser, a UNESCO-led effort. Its grandeur and remote desert setting make it a breathtaking destination, reflecting Ramesses II’s enduring legacy.',
    openingHours: [
      'Sunday (05:00-18:00)',
      'Monday (05:00-18:00)',
      'Tuesday (05:00-18:00)',
      'Wednesday (05:00-18:00)',
      'Thursday (05:00-18:00)',
      'Friday (05:00-18:00)',
      'Saturday (05:00-18:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 300EGP/Ticket',
      'Foreign Student: 150EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Visit during the Sun Festival (Feb 22 or Oct 22).',
      'Book a guided tour for historical context.',
      'Bring sunscreen and water for the desert site.',
      'Arrive early to avoid crowds and heat.',
      'Explore the nearby Nefertari Temple.',
    ],
    category: 'The Great Temple of Ramesses II',
    galleryImages: [
      'lib/home_page/images/great temple of ramesses/great temple of ramesses_1.jpg',
      'lib/home_page/images/great temple of ramesses/great temple of ramesses_2.jpg',
      'lib/home_page/images/great temple of ramesses/great temple of ramesses_3.jpg',

    ],
  ),
  Place(
    title: 'Unfinished Obelisk in Aswan',
    location: 'Aswan, Egypt',
    imagePath: 'lib/home_page/images/unfinished_obelisk.jpg',
    description:
    'The Unfinished Obelisk in Aswan, dating to the New Kingdom around 1500 BC, is the largest known ancient obelisk, still lying in its quarry. Commissioned by Queen Hatshepsut, it was intended to stand 42 meters tall and weigh nearly 1,200 tons, but was abandoned due to cracks in the granite. The obelisk offers a rare glimpse into ancient Egyptian stone-working techniques, with visible tool marks and lines showing how workers carved and extracted massive stone blocks using dolerite tools. Located in a granite quarry that supplied stone for many of Egypt’s monuments, the site includes other partially carved stones and inscriptions. Now an open-air museum, the Unfinished Obelisk provides insight into the monumental ambitions of the New Kingdom and the challenges faced by ancient engineers, making it a fascinating stop for visitors exploring Aswan’s historical significance.',
    openingHours: [
      'Sunday (07:00-17:00)',
      'Monday (07:00-17:00)',
      'Tuesday (07:00-17:00)',
      'Wednesday (07:00-17:00)',
      'Thursday (07:00-17:00)',
      'Friday (07:00-17:00)',
      'Saturday (07:00-17:00)',
    ],
    prices: [
      'Egyptian Student: 20EGP/Ticket',
      'Foreigner: 80EGP/Ticket',
      'Foreign Student: 40EGP/Ticket',
      'Egyptian: 40EGP/Ticket',
    ],
    touristTips: [
      'Hire a guide to learn about stone-working techniques.',
      'Bring a hat and sunscreen for the open quarry.',
      'Wear sturdy shoes for walking on rocky ground.',
      'Combine with a visit to Aswan’s other sites.',
      'Visit the open-air museum for more context.',
    ],
    category: 'Unfinished Obelisk in Aswan',
    galleryImages: [
      'lib/home_page/images/unfinished_obelisk/unfinished_obelisk_1.jpg',
      'lib/home_page/images/unfinished_obelisk/unfinished_obelisk_2.jpg',
      'lib/home_page/images/unfinished_obelisk/unfinished_obelisk_3.jpg',

    ],
  ),
];