// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

//Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

//String categoryToJson(Category data) => json.encode(data.toJson());
const kTipoPost = 'post';
const kTipoMeditation = 'meditation';

class Category {
    final String? documentId;
    String? tipo;
    String? nome;
    String? valor;

    Category({
        this.documentId,
        this.tipo,
        this.nome,
        this.valor,
    });

    factory Category.fromJson(Map<String, dynamic> json, String documentId) => Category(
        documentId: documentId,
        tipo: json['tipo'],
        nome: json['nome'],
        valor: json['valor'],
    );

    Map<String, dynamic> toJson() => {
        'tipo': tipo,
        'nome': nome,
        'valor': valor,
    };

 // partially applicable sorter
  static Function(Category, Category) sorter(int sortOrder, String property) {
     int handleSortOrder(int sortOrder, int sort) {
       if (sortOrder == 1) {
         // a is before b
         if (sort == -1) {
           return -1;
         } else if (sort > 0) {
           // a is after b
           return 1;
         } else {
           // a is same as b
           return 0;
         }
       } else {
         // a is before b
         if (sort == -1) {
           return 1;
         } else if (sort > 0) {
           // a is after b
           return 0;
         } else {
           // a is same as b
           return 0;
         }
       }
     }

     return (Category a, Category b) {
      switch (property) {
        case 'nome':
            var sort = a.nome!.compareTo(b.nome!);
            return handleSortOrder(sortOrder, sort);
        case 'valor':
            var sort = a.valor!.compareTo(b.valor!);
            return handleSortOrder(sortOrder, sort);
        default:
            return 0;
      }
    };
  }

  // sortOrder = 1 ascending | 0 descending
  static void sortCategories(List<Category> categories, {int sortOrder = 1, String property = 'valor'}) {
    switch (property) {
      case 'nome':
        categories.sort(sorter(sortOrder, property) as int Function(Category, Category)?);
        break;
      case 'valor':
        categories.sort(sorter(sortOrder, property) as int Function(Category, Category)?);
        break;
      default:
        print('Unrecognized property $property');
    }
  }
}
