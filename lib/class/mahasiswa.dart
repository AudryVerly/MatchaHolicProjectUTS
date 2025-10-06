
class Mahasiswa {
  int id;
  String name;
  String photo;
  String program;
  String nrp;
  String biografi;

  Mahasiswa({
    required this.id,
    required this.name,
    required this.photo,
    required this.program,
    required this.nrp,
    required this.biografi,
  });
}

var mahasiswas = <Mahasiswa>[
  Mahasiswa(
    id: 1,
    name: 'Audry Wijaya',
    photo: 'https://picsum.photos/200/200?random=1',
    program: 'Ilmu Komunikasi',
    nrp: '160422127',
    biografi: 'Mahasiswa aktif yang tertarik pada bidang komunikasi digital dan media sosial.',
  ),
  Mahasiswa(
    id: 2,
    name: 'Budi Santoso',
    photo: 'https://picsum.photos/200/200?random=2',
    program: 'Informatika',
    nrp: '160422128',
    biografi: 'Passionate about software development and artificial intelligence.',
  ),
  Mahasiswa(
    id: 3,
    name: 'Citra Dewi',
    photo: 'https://picsum.photos/200/200?random=3',
    program: 'Desain Komunikasi Visual',
    nrp: '160422129',
    biografi: 'Creative designer with a passion for visual storytelling and branding.',
  ),
  Mahasiswa(
    id: 4,
    name: 'Dimas Pratama',
    photo: 'https://picsum.photos/200/200?random=4',
    program: 'Sistem Informasi',
    nrp: '160422130',
    biografi: 'Interest in data analytics and business intelligence systems.',
  ),
  Mahasiswa(
    id: 5,
    name: 'Elsa Maharani',
    photo: 'https://picsum.photos/200/200?random=5',
    program: 'Teknik Elektro',
    nrp: '160422131',
    biografi: 'Focused on renewable energy and electrical systems.',
  ),
];
