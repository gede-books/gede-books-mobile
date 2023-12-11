// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    Model model;
    int pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int bookCode;
    String title;
    Language language;
    FirstName firstName;
    LastName lastName;
    Year year;
    String subjects;
    String category;
    int stock;
    int price;
    int rating;

    Fields({
        required this.bookCode,
        required this.title,
        required this.language,
        required this.firstName,
        required this.lastName,
        required this.year,
        required this.subjects,
        required this.category,
        required this.stock,
        required this.price,
        required this.rating,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        bookCode: json["bookCode"],
        title: json["title"],
        language: languageValues.map[json["language"]]!,
        firstName: firstNameValues.map[json["firstName"]]!,
        lastName: lastNameValues.map[json["lastName"]]!,
        year: yearValues.map[json["year"]]!,
        subjects: json["subjects"],
        category: json["category"],
        stock: json["stock"],
        price: json["price"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "bookCode": bookCode,
        "title": title,
        "language": languageValues.reverse[language],
        "firstName": firstNameValues.reverse[firstName],
        "lastName": lastNameValues.reverse[lastName],
        "year": yearValues.reverse[year],
        "subjects": subjects,
        "category": category,
        "stock": stock,
        "price": price,
        "rating": rating,
    };
}

enum FirstName {
    ABRAHAM,
    ANDREW,
    ANTHONY,
    ARTHUR_CONAN,
    BRENDAN_P,
    CHARLES,
    CHARLOTTE_PERKINS,
    EDGAR_RICE,
    EDNA_ST_VINCENT,
    EDWIN_ABBOTT,
    FRANCES_HODGSON,
    FRANKLIN_D_FRANKLIN_DELANO,
    FREDERICK,
    GEORGE,
    G_K_GILBERT_KEITH,
    HAROLD,
    HENRY_DAVID,
    HERMAN,
    H_G_HERBERT_GEORGE,
    JANE,
    JEAN,
    JOHN,
    JOHN_F_JOHN_FITZGERALD,
    JULES,
    J_M_JAMES_MATTHEW,
    KATE,
    LEWIS,
    LUDWIG_VAN,
    L_FRANK_LYMAN_FRANK,
    L_M_LUCY_MAUD,
    MARK,
    MARY,
    MARY_WOLLSTONECRAFT,
    MICHAEL,
    NATHANIEL,
    PATRICK,
    PETER_MARK,
    ROBERT_LOUIS,
    SAMUEL_TAYLOR,
    STEPHEN,
    THOMAS,
    UPTON,
    VIRGINIA,
    WALTER,
    WASHINGTON,
    WILKIE,
    WILLA,
    WILLIAM,
    WILLIAM_DEAN
}

final firstNameValues = EnumValues({
    "Abraham": FirstName.ABRAHAM,
    "Andrew": FirstName.ANDREW,
    "Anthony": FirstName.ANTHONY,
    "Arthur Conan": FirstName.ARTHUR_CONAN,
    "Brendan P.": FirstName.BRENDAN_P,
    "Charles": FirstName.CHARLES,
    "Charlotte Perkins": FirstName.CHARLOTTE_PERKINS,
    "Edgar Rice": FirstName.EDGAR_RICE,
    "Edna St. Vincent": FirstName.EDNA_ST_VINCENT,
    "Edwin Abbott": FirstName.EDWIN_ABBOTT,
    "Frances Hodgson": FirstName.FRANCES_HODGSON,
    "Franklin D. (Franklin Delano)": FirstName.FRANKLIN_D_FRANKLIN_DELANO,
    "Frederick": FirstName.FREDERICK,
    "George": FirstName.GEORGE,
    "G. K. (Gilbert Keith)": FirstName.G_K_GILBERT_KEITH,
    "Harold": FirstName.HAROLD,
    "Henry David": FirstName.HENRY_DAVID,
    "Herman": FirstName.HERMAN,
    "H. G. (Herbert George)": FirstName.H_G_HERBERT_GEORGE,
    "Jane": FirstName.JANE,
    "Jean": FirstName.JEAN,
    "John": FirstName.JOHN,
    "John F. (John Fitzgerald)": FirstName.JOHN_F_JOHN_FITZGERALD,
    "Jules": FirstName.JULES,
    "J. M. (James Matthew)": FirstName.J_M_JAMES_MATTHEW,
    "Kate": FirstName.KATE,
    "Lewis": FirstName.LEWIS,
    "Ludwig van": FirstName.LUDWIG_VAN,
    "L. Frank (Lyman Frank)": FirstName.L_FRANK_LYMAN_FRANK,
    "L. M. (Lucy Maud)": FirstName.L_M_LUCY_MAUD,
    "Mark": FirstName.MARK,
    "Mary": FirstName.MARY,
    "Mary Wollstonecraft": FirstName.MARY_WOLLSTONECRAFT,
    "Michael": FirstName.MICHAEL,
    "Nathaniel": FirstName.NATHANIEL,
    "Patrick": FirstName.PATRICK,
    "Peter Mark": FirstName.PETER_MARK,
    "Robert Louis": FirstName.ROBERT_LOUIS,
    "Samuel Taylor": FirstName.SAMUEL_TAYLOR,
    "Stephen": FirstName.STEPHEN,
    "Thomas": FirstName.THOMAS,
    "Upton": FirstName.UPTON,
    "Virginia": FirstName.VIRGINIA,
    "Walter": FirstName.WALTER,
    "Washington": FirstName.WASHINGTON,
    "Wilkie": FirstName.WILKIE,
    "Willa": FirstName.WILLA,
    "William": FirstName.WILLIAM,
    "William Dean": FirstName.WILLIAM_DEAN
});

enum Language {
    ENGLISH
}

final languageValues = EnumValues({
    "English ": Language.ENGLISH
});

enum LastName {
    ABBOTT,
    AUSTEN,
    BARRIE,
    BAUM,
    BEETHOVEN,
    BUNYAN,
    BURNETT,
    BURROUGHS,
    CARROLL,
    CATHER,
    CHESTERTON,
    CHOPIN,
    COLERIDGE,
    COLLINS,
    CRANE,
    DICKENS,
    DOUGLASS,
    DOYLE,
    ELIOT,
    FREDERIC,
    GILMAN,
    HARDY,
    HART,
    HAWTHORNE,
    HENRY,
    HOPE,
    HOWELLS,
    IRVING,
    JEFFERSON,
    KEHOE,
    KENNEDY,
    LANG,
    LINCOLN,
    MELVILLE,
    MILLAY,
    MILTON,
    MONTGOMERY,
    PAINE,
    ROGET,
    ROOSEVELT,
    SCOTT,
    SHAKESPEARE,
    SHELLEY,
    SINCLAIR,
    STEVENSON,
    THOREAU,
    TWAIN,
    VERNE,
    WEBSTER,
    WELLS,
    WOLLSTONECRAFT,
    WOOLF
}

final lastNameValues = EnumValues({
    "Abbott": LastName.ABBOTT,
    "Austen": LastName.AUSTEN,
    "Barrie": LastName.BARRIE,
    "Baum": LastName.BAUM,
    "Beethoven": LastName.BEETHOVEN,
    "Bunyan": LastName.BUNYAN,
    "Burnett": LastName.BURNETT,
    "Burroughs": LastName.BURROUGHS,
    "Carroll": LastName.CARROLL,
    "Cather": LastName.CATHER,
    "Chesterton": LastName.CHESTERTON,
    "Chopin": LastName.CHOPIN,
    "Coleridge": LastName.COLERIDGE,
    "Collins": LastName.COLLINS,
    "Crane": LastName.CRANE,
    "Dickens": LastName.DICKENS,
    "Douglass": LastName.DOUGLASS,
    "Doyle": LastName.DOYLE,
    "Eliot": LastName.ELIOT,
    "Frederic": LastName.FREDERIC,
    "Gilman": LastName.GILMAN,
    "Hardy": LastName.HARDY,
    "Hart": LastName.HART,
    "Hawthorne": LastName.HAWTHORNE,
    "Henry": LastName.HENRY,
    "Hope": LastName.HOPE,
    "Howells": LastName.HOWELLS,
    "Irving": LastName.IRVING,
    "Jefferson": LastName.JEFFERSON,
    "Kehoe": LastName.KEHOE,
    "Kennedy": LastName.KENNEDY,
    "Lang": LastName.LANG,
    "Lincoln": LastName.LINCOLN,
    "Melville": LastName.MELVILLE,
    "Millay": LastName.MILLAY,
    "Milton": LastName.MILTON,
    "Montgomery": LastName.MONTGOMERY,
    "Paine": LastName.PAINE,
    "Roget": LastName.ROGET,
    "Roosevelt": LastName.ROOSEVELT,
    "Scott": LastName.SCOTT,
    "Shakespeare": LastName.SHAKESPEARE,
    "Shelley": LastName.SHELLEY,
    "Sinclair": LastName.SINCLAIR,
    "Stevenson": LastName.STEVENSON,
    "Thoreau": LastName.THOREAU,
    "Twain": LastName.TWAIN,
    "Verne": LastName.VERNE,
    "Webster": LastName.WEBSTER,
    "Wells": LastName.WELLS,
    "Wollstonecraft": LastName.WOLLSTONECRAFT,
    "Woolf": LastName.WOOLF
});

enum Year {
    THE_15641616,
    THE_16081674,
    THE_16281688,
    THE_17361799,
    THE_17371809,
    THE_17431826,
    THE_17591797,
    THE_17701827,
    THE_17711832,
    THE_17721834,
    THE_17751817,
    THE_17791869,
    THE_17831859,
    THE_17971851,
    THE_18041864,
    THE_18091865,
    THE_18121870,
    THE_18171862,
    THE_18181895,
    THE_18191880,
    THE_18191891,
    THE_18241889,
    THE_18281905,
    THE_18321898,
    THE_18351910,
    THE_18371920,
    THE_18381926,
    THE_18401928,
    THE_18441912,
    THE_18491924,
    THE_18501894,
    THE_18501904,
    THE_18561898,
    THE_18561919,
    THE_18591930,
    THE_18601935,
    THE_18601937,
    THE_18631933,
    THE_18661946,
    THE_18711900,
    THE_18731947,
    THE_18741936,
    THE_18741942,
    THE_18751950,
    THE_18761916,
    THE_18781968,
    THE_18821941,
    THE_18821945,
    THE_18921950,
    THE_19171963,
    THE_19472011,
    THE_19702011
}

final yearValues = EnumValues({
    "1564-1616": Year.THE_15641616,
    "1608-1674": Year.THE_16081674,
    "1628-1688": Year.THE_16281688,
    "1736-1799": Year.THE_17361799,
    "1737-1809": Year.THE_17371809,
    "1743-1826": Year.THE_17431826,
    "1759-1797": Year.THE_17591797,
    "1770-1827": Year.THE_17701827,
    "1771-1832": Year.THE_17711832,
    "1772-1834": Year.THE_17721834,
    "1775-1817": Year.THE_17751817,
    "1779-1869": Year.THE_17791869,
    "1783-1859": Year.THE_17831859,
    "1797-1851": Year.THE_17971851,
    "1804-1864": Year.THE_18041864,
    "1809-1865": Year.THE_18091865,
    "1812-1870": Year.THE_18121870,
    "1817-1862": Year.THE_18171862,
    "1818-1895": Year.THE_18181895,
    "1819-1880": Year.THE_18191880,
    "1819-1891": Year.THE_18191891,
    "1824-1889": Year.THE_18241889,
    "1828-1905": Year.THE_18281905,
    "1832-1898": Year.THE_18321898,
    "1835-1910": Year.THE_18351910,
    "1837-1920": Year.THE_18371920,
    "1838-1926": Year.THE_18381926,
    "1840-1928": Year.THE_18401928,
    "1844-1912": Year.THE_18441912,
    "1849-1924": Year.THE_18491924,
    "1850-1894": Year.THE_18501894,
    "1850-1904": Year.THE_18501904,
    "1856-1898": Year.THE_18561898,
    "1856-1919": Year.THE_18561919,
    "1859-1930": Year.THE_18591930,
    "1860-1935": Year.THE_18601935,
    "1860-1937": Year.THE_18601937,
    "1863-1933": Year.THE_18631933,
    "1866-1946": Year.THE_18661946,
    "1871-1900": Year.THE_18711900,
    "1873-1947": Year.THE_18731947,
    "1874-1936": Year.THE_18741936,
    "1874-1942": Year.THE_18741942,
    "1875-1950": Year.THE_18751950,
    "1876-1916": Year.THE_18761916,
    "1878-1968": Year.THE_18781968,
    "1882-1941": Year.THE_18821941,
    "1882-1945": Year.THE_18821945,
    "1892-1950": Year.THE_18921950,
    "1917-1963": Year.THE_19171963,
    "1947-2011": Year.THE_19472011,
    "1970-2011": Year.THE_19702011
});

enum Model {
    MAIN_PRODUCT
}

final modelValues = EnumValues({
    "main.product": Model.MAIN_PRODUCT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
