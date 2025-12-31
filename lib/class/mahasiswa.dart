import 'dart:convert';

class Mahasiswa {
  int id;
  String name;
  String email;
  String password;
  String photo;
  String program;
  String nrp;
  String biografi;
  List? friendRequest;

  Mahasiswa({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.photo,
    required this.program,
    required this.nrp,
    required this.biografi,
    required this.friendRequest
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      photo: json['photo'] != null ? json['photo'].toString() : '',
      program: json['program'] as String,
      nrp: json['nrp'] as String,
      biografi: json['biografi'] as String,
      friendRequest: json['friend_request'],
    );
  }
}

List<Mahasiswa> Mhs = [];

// var mahasiswas = <Mahasiswa>[
//   Mahasiswa(
//     id: 1,
//     name: 'Audry Wijaya',
//     email: 'auwi@gmail.com',
//     password: 'auwi123',
//     photo: 'https://picsum.photos/200/200?random=1',
//     program: 'IMES',
//     nrp: '160422127',
//     biografi:
//         'Audry Wijaya adalah mahasiswa aktif Program Studi Ilmu Komunikasi yang memiliki ketertarikan mendalam terhadap komunikasi digital, media sosial, dan strategi branding personal. Selama masa kuliah, Audry telah berpartisipasi dalam berbagai proyek kampus yang berfokus pada pembuatan konten kreatif dan pengelolaan media sosial organisasi mahasiswa. Ia juga aktif menulis artikel dan menjadi bagian dari tim publikasi acara kampus. Dengan kemampuannya dalam public speaking dan storytelling, Audry bercita-cita untuk menjadi seorang digital strategist yang dapat membantu brand mengomunikasikan nilai mereka secara efektif kepada masyarakat.',
//   ),
//   Mahasiswa(
//     id: 2,
//     name: 'Budi Santoso',
//     email: 'budsan@gmail.com',
//     password: 'budsan123',
//     photo: 'https://picsum.photos/200/200?random=2',
//     program: 'DSAI',
//     nrp: '160422128',
//     biografi:
//         'Budi Santoso adalah mahasiswa Informatika yang sangat antusias terhadap dunia pemrograman, kecerdasan buatan, dan pengembangan perangkat lunak berbasis web. Ia memiliki pengalaman membuat beberapa proyek aplikasi menggunakan bahasa pemrograman seperti Dart, Java, dan Python. Budi juga mengikuti berbagai kompetisi hackathon dan seminar teknologi untuk memperluas wawasan dan jejaring profesionalnya. Ia percaya bahwa teknologi dapat menjadi solusi untuk banyak permasalahan sosial dan berkomitmen untuk terus belajar serta berinovasi di bidang kecerdasan buatan dan machine learning.',
//   ),
//   Mahasiswa(
//     id: 3,
//     name: 'Citra Dewi',
//     email: 'citwi@gmail.com',
//     password: 'citwi123',
//     photo: 'https://picsum.photos/200/200?random=3',
//     program: 'ITDD',
//     nrp: '160422129',
//     biografi:
//         'Citra Dewi adalah seorang mahasiswa Desain Komunikasi Visual dengan minat besar pada bidang ilustrasi, fotografi, dan branding. Ia dikenal sebagai pribadi yang kreatif dan penuh imajinasi dalam mengekspresikan ide melalui media visual. Selama studinya, Citra telah mengerjakan berbagai proyek desain identitas visual, poster kampanye sosial, hingga desain antarmuka aplikasi. Baginya, desain bukan hanya tentang estetika, tetapi juga tentang bagaimana menyampaikan pesan dengan cara yang bermakna. Ia berharap dapat berkarier sebagai art director di industri kreatif setelah lulus.',
//   ),
//   Mahasiswa(
//     id: 4,
//     name: 'Dimas Pratama',
//     email: 'dimprat@gmail.com',
//     password: 'dimprat123',
//     photo: 'https://picsum.photos/200/200?random=4',
//     program: 'NCS',
//     nrp: '160422130',
//     biografi:
//         'Dimas Pratama adalah mahasiswa Sistem Informasi yang memiliki minat besar terhadap analisis data, transformasi digital, dan pengembangan sistem bisnis. Ia sering terlibat dalam penelitian dan proyek yang berkaitan dengan optimalisasi proses kerja menggunakan sistem informasi. Dimas memiliki kemampuan analitis yang kuat dan senang memecahkan masalah menggunakan pendekatan berbasis data. Dalam kesehariannya, ia juga aktif sebagai asisten laboratorium yang membantu mahasiswa lain memahami konsep sistem basis data dan analitik bisnis. Tujuannya adalah menjadi seorang business intelligence analyst yang mampu membantu perusahaan mengambil keputusan strategis berbasis data.',
//   ),
//   Mahasiswa(
//     id: 5,
//     name: 'Elsa Maharani',
//     email: 'elsni@gmail.com',
//     password: 'elsni123',
//     photo: 'https://picsum.photos/200/200?random=5',
//     program: 'DMT',
//     nrp: '160422131',
//     biografi:
//         'Elsa Maharani adalah mahasiswa Teknik Elektro yang fokus pada bidang energi terbarukan dan sistem kelistrikan cerdas (smart grid). Ia memiliki ketertarikan terhadap teknologi yang ramah lingkungan dan berkelanjutan. Elsa pernah mengikuti proyek penelitian yang berfokus pada penggunaan panel surya sebagai sumber energi alternatif untuk daerah terpencil. Selain aktif di bidang akademik, Elsa juga berpartisipasi dalam komunitas teknik di kampus yang mendorong inovasi teknologi hijau. Ia bercita-cita untuk menjadi insinyur profesional yang mampu berkontribusi dalam pengembangan sistem energi berkelanjutan di Indonesia.',
//   ),
// ];
