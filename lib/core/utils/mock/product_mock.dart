import 'dart:math';

List<Map<String, dynamic>> productMock() {
  Random random = Random();
  List<Map<String, dynamic>> products = [
    {
      'name': 'Condicionador Ácido Fosfórico 37% - AllPrime',
      'description': 'Condicionador de dentina para preparações adesivas. Indicado para uso em esmalte e dentina.',
      'price': 29.90,
      'discount': 2.90,
      'imageUrl': 'https://cdn.dentalspeed.com/produtos/210/condicionador-acido-allprime-12474.jpg',
      'category': 'Dentística e Estética',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    },
    {
      'name': 'Resina Composta Z350 - 3M',
      'description': 'Resina composta nanohíbrida, indicada para restaurações estéticas e duráveis.',
      'price': 199.99,
      'discount': 12.99,
      'imageUrl': 'https://imgs.pontofrio.com.br/1518665417/1xg.jpg',
      'category': 'Dentística e Estética',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    },
    {
      'name': 'Fio de Sutura Nylon 5-0 - Technew',
      'description': 'Fio de sutura não absorvível, ideal para procedimentos cirúrgicos em odontologia.',
      'price': 14.90,
      'imageUrl':
          'https://images.tcdn.com.br/img/img_prod/593070/fio_agulhado_sutura_monofilamento_nylon_preto_2_0_2_0cm_3_8_45cm_com_24_fios_supermedy_2177_1_e9ab4a49deb14f5cfabb2e7032666089.jpg',
      'category': 'Cirurgia e Periodontia',
      'createdAt': DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch,
    },
    {
      'name': 'Espátula LeCron - Indusbello',
      'description': 'Espátula de dupla face, utilizada em escultura de cera para prótese dentária.',
      'price': 34.99,
      'discount': 2.90,
      'imageUrl':
          'https://lh6.googleusercontent.com/iWzKnIfcikQojBsBGjdRIiesET5wAGSgFsUyNmuQeENohCrTwcv2oDLXNpVeljBcywYvajNVUo0aMbSgw-TwC25Ogben6wy_7kihqLjw2u3zzQrOmHyThe_Fudy1KO9XUWDuIiJH',
      'category': 'Prótese',
      'createdAt': DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch,
    },
    {
      'name': 'Anestésico Xylocaína 2% - Aspen',
      'description': 'Anestésico local à base de lidocaína, utilizado para procedimentos odontológicos.',
      'price': 12.90,
      'imageUrl':
          'https://images.tcdn.com.br/img/img_prod/1266284/anestesico_mepivacaina_mepivalem_ad_2_1_100_000_dla_387_1_fbdf2d53e4574fa6f7b83fc67535a1a3.jpg',
      'category': 'Anestésicos',
      'createdAt': DateTime.now().subtract(Duration(days: random.nextInt(30) + 2)).millisecondsSinceEpoch,
    },
    {
      'name': 'Broca Carbide FG 245 - KG Sorensen',
      'description': 'Broca de alta rotação para corte e remoção de tecido dentário.',
      'price': 9.50,
      'imageUrl': 'https://http2.mlstatic.com/D_NQ_NP_854348-MLB74420955257_022024-O.webp',
      'category': 'Periféricos',
      'createdAt': DateTime.now().subtract(Duration(days: random.nextInt(30) + 2)).millisecondsSinceEpoch,
    },
  ];

  return products;
}
