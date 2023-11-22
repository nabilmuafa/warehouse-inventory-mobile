# Warehouse Inventory Mobile

![Staging badge](https://github.com/nabilmuafa/warehouse-inventory-mobile/actions/workflows/staging.yml/badge.svg)
![Prerelease badge](https://github.com/nabilmuafa/warehouse-inventory-mobile/actions/workflows/pre-release.yml/badge.svg)
![Release badge](https://github.com/nabilmuafa/warehouse-inventory-mobile/actions/workflows/release.yml/badge.svg)
[![Build status](https://build.appcenter.ms/v0.1/apps/97fbda49-8790-4ff1-ba6f-f4d1130a4f53/branches/main/badge)](https://appcenter.ms)

Proyek Flutter untuk tugas mata kuliah Pemrograman Berbasis Platform Ganjil 2023/2024. Dibuat oleh Muhammad Nabil Mu'afa - 2206024972

### Daftar Isi

- [README.md Tugas 7](#tugas-7)
  - [Implementasi Checklist](#implementasi-checklist-tugas-7)
  - [Perbedaan utama stateless & stateful widget](#apa-perbedaan-utama-antara-stateless-dan-stateful-widget-dalam-konteks-pengembangan-aplikasi-flutter)
  - [Seluruh widget yang digunakan](#sebutkan-seluruh-widget-yang-kamu-gunakan-untuk-menyelesaikan-tugas-ini-dan-jelaskan-fungsinya-masing-masing)
- [README.md Tugas 8](#tugas-8)
  - [Implementasi Checklist](#implementasi-checklist-tugas-8)
  - [Perbedaan antara `Navigator.push()` dengan `Navigator.pushReplacement()`](#perbedaan-antara-navigatorpush-dan-navigatorpushreplacement)
  - [Masing-masing layout widget pada Flutter](#jelaskan-masing-masing-layout-widget-pada-flutter-dan-konteks-penggunaannya-masing-masing)
  - [Elemen input form yang saya gunakan](#sebutkan-apa-saja-elemen-input-pada-form-dan-mengapa-digunakan)
  - [Penerapan clean architecture pada Flutter](#penerapan-clean-architecture-pada-aplikasi-flutter)
- [README.md Tugas 9](#tugas-9)
  - [Implementasi Checklist](#implementasi-checklist-tugas-9)
  - [Apakah bisa mengambil data JSON tanpa model terlebih dahulu?](#apakah-bisa-kita-melakukan-pengambilan-data-json-tanpa-membuat-model-terlebih-dahulu-jika-iya-apakah-hal-tersebut-lebih-baik-daripada-membuat-model-sebelum-melakukan-pengambilan-data-json)
  - [Jelaskan fungsi CookieRequest dan kenapa instance-nya dibagikan ke semua komponen](#jelaskan-fungsi-dari-cookierequest-dan-jelaskan-mengapa-instance-cookierequest-perlu-untuk-dibagikan-ke-semua-komponen-di-aplikasi-flutter)
  - [Mekanisme pengambilan data JSON hingga ditampilkan pada Flutter](#jelaskan-mekanisme-pengambilan-data-dari-json-hingga-dapat-ditampilkan-pada-flutter)
  - [Mekanisme autentikasi dari Flutter ke Django](#jelaskan-mekanisme-autentikasi-dari-input-data-akun-pada-flutter-ke-django-hingga-selesainya-proses-autentikasi-oleh-django-dan-tampilnya-menu-pada-flutter)
  - [Sebutkan seluruh widget yang dipakai pada tugas ini](#sebutkan-seluruh-widget-yang-kamu-pakai-pada-tugas-ini-dan-jelaskan-fungsinya-masing-masing)

## Tugas 7

### Implementasi Checklist Tugas 7

<details>
<summary>Membuat sebuah program Flutter baru</summary>

Saya menjalankan command:

```
flutter create warehouse_inventory_mobile
```

Kemudian beberapa bagian dari `main.dart` dipindahkan ke file baru `menu.dart`, yaitu bagian

```dart
class myHomePage ... {
...
}
```

Tidak seperti tutorial, `class _MyHomePageState ... {}` langsung saya hapus karena myHomePage akan diubah menjadi stateless widget. Kemudian, saya mengubah judul `MyApp` menjadi "Warehouse Inventory" dan aksen warnanya menjadi light blue dengan shade 400 (`Colors.lightBlue.shade400`), serta menghapus judul pada pemanggilan constructor `MyHomePage()`.

Pada `menu.dart`, myHomePage saya ubah menjadi stateless widget:

```dart
class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context){
        return Scaffold();
    }
}
```

</details>
<details>
<summary>Membuat tiga tombol sederhana dengan ikon dan teks</summary>

Pertama saya define sebuah class untuk menyimpan informasi (teks, icon, warna) setiap tombol:

```dart
class WarehouseItem {
  final String name;
  final IconData icon;
  final Color color;

  WarehouseItem(this.name, this.icon, this.color);
}
```

Setelah itu, saya definisikan setiap tombol (icon, teks, dan warnanya):

```dart
final List<WarehouseItem> items = [
    WarehouseItem("Lihat Item", Icons.format_list_bulleted_rounded, Colors.lightBlue),
    WarehouseItem("Tambah Item", Icons.format_list_bulleted_add, Colors.indigo),
    WarehouseItem("Logout", Icons.logout_rounded, Colors.pink.shade300),
  ];
```

Kemudian saya buat ketiga tombol tersebut pada widget build di MyHomePage:

```dart
@override
Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: const Text("Warehouse Inventory"),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(
                                "Warehouse Inventory",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                        ),
                        GridView.count(
                            primary: true,
                            // padding
                            padding: const EdgeInsets.all(20),
                            // gap
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            // count
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            children: items.map((WarehouseItem item) {
                                return ItemCard(item);
                            }).toList(),
                        ),
                    ],
                ),
            ),
        ),
    );
}
```

Bagian yang mendefinisikan tombol ada di `GridView.count()`, dimana pada method itu didefinisikan suatu grid dengan jumlah 3 elemen (`crossAxisCount: 3`), dengan masing-masing gap horizontal dan vertikal 10. Setiap elemen tombol didefinisikan pada `children` dari `GridView`. Dalam kasus kode ini, children nya adalah pemetaan dari list `items` yang sudah didefinisikan, dimana dari setiap item pada list tersebut akan dimasukkan ke fungsi constructor widget `ItemCard()` dan diubah ke list dengan `.toList()`.

`ItemCard` sendiri saya definisikan sebagai widget yang mendefinisikan 'isi' setiap tombol. Class inilah yang 'mengekstrak' icon, teks, dan warna yang sudah didefinisikan pada list `item`.

```dart
class ItemCard extends StatelessWidget{
    final WarehouseItem item;

    const ItemCard(this.item, {super.key});

    @override
    Widget build(BuildContext context){
        return Material(
            color: item.color,
            child: InkWell(
                onTap: () {
                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("Kamu telah menekan tombol ${item.name}")));
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                    item.icon,
                                    color: Colors.white,
                                    size: 30.0
                                ),
                                const Padding(padding: EdgeInsets.all(3)),
                                Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}
```

Dapat dilihat bahwa constructor menerima argumen berupa sebuah `WarehouseItem`. Warna dari widget ini diambil dari `WarehouseItem` tersebut yaitu `item.color`. Icon diambil dari `item.icon`, dan nama tombol diambil dari `item.name`

Setelah menjalankan `flutter run`, tombol-tombol sudah bisa dilihat.

![Screenshot tampilan](https://media.discordapp.net/attachments/1133956580728127550/1171626269155274752/image.png?ex=655d5cfe&is=654ae7fe&hm=c7b7fb762ec00cc658f4931cb5596a95c29ed94d2508c236e26aa6487a17c2cd&=&width=282&height=579)

</details>
<details>
<summary>Memunculkan Snackbar ketika tombol ditekan</summary>

Fungsionalitas ini didefinisikan pada widget `ItemCard` yang mendefinisikan tiap tombol. Pada child `Material` yang direturn dari fungsi build widget, didefinisikan properti `onTap` yang akan memunculkan snackbar apabila tombol ditekan:

```dart
return Material(
    color: item.color,
    child: InkWell(
        onTap: () {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}")));
        },
        ...
    )
)
```

Teks dari snackbar yang dimunculkan juga disesuaikan dengan nama item yang sedang diakses. Apabila tombol ditekan, tampilannya akan seperti ini:
![Tampilan snackbar apabila tombol ditekan](https://media.discordapp.net/attachments/1133956580728127550/1171628949055471658/image.png?ex=655d5f7d&is=654aea7d&hm=210a80961153cf487b1fa7d0cd6ea4875a11e2c2251c2c9fb6056a9c074b2222&=&width=282&height=579)

</details>
<details>
<summary>Bonus: Membedakan warna tiap tombol</summary>

Untuk melakukan hal ini, saya menambahkan properti warna pada class `WarehouseItem`, sehingga ketika tombol dibentuk, warnanya tidak statik melainkan bisa disesuaikan dengan warna yang digunakan ketika constructor pembentuk setiap tombol dipanggil.

```dart
class WarehouseItem {
  final String name;
  final IconData icon;
  final Color color; // bagian ini

  WarehouseItem(this.name, this.icon, this.color);
}
...
final List<WarehouseItem> items = [
    WarehouseItem("Lihat Item", Icons.format_list_bulleted_rounded, Colors.lightBlue),
    WarehouseItem("Tambah Item", Icons.format_list_bulleted_add, Colors.indigo),
    WarehouseItem("Logout", Icons.logout_rounded, Colors.pink.shade300),
];
...
class ItemCard extends StatelessWidget{
    final WarehouseItem item;

    const ItemCard(this.item, {super.key});

    @override
    Widget build(BuildContext context){
        return Material(
            color: item.color,  // bagian ini
            child: InkWell(
                ...
            )
        )
    }
}
```

</details>

### Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?

Widget yang stateless adalah widget yang bersifat immutable, artinya isi dan propertinya tidak bisa berubah, statis. Wujud dari widget tersebut ditentukan hanya ketika pembentukan widget tersebut dan tidak akan bisa berubah meskipun ada interaksi oleh user. Stateless widget dapat digunakan apabila tampilan yang ingin ditunjukkan tidak memerlukan perubahan, misalnya untuk merepresentasikan posisi-posisi tombol pada tugas ini. Stateless widget juga lebih baik untuk performa karena tidak ada yang perlu diupdate.

Sementara itu, widget yang stateful adalah widget yang mutable, artinya isi dan propertinya bisa diubah-ubah seiring berjalannya program, misalnya ketika ada interaksi oleh user. Stateful widgets bisa digunakan ketika kita membutuhkan tampilan yang berubah atau bisa di update, misalnya teks yang menunjukkan berapa kali pengguna sudah menenak sebuah tombol. Stateful widget sendiri dibantu oleh dua class, yaitu objek itu sendiri dan sebuah state yang dapat diupdate.

### Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

- `MyApp`: Widget sebagai root aplikasi
- `MaterialApp`: Widget utama untuk 'menampung' widget-widget lain pada aplikasi
- `ThemeData`: Mendefinisikan konfigurasi keseluruhan dari visual aplikasi
- `ColorScheme`: Menentukan skema warna yang digunakan pada `ThemeData`
- `MyHomePage`: Widget yang menampilkan halaman utama
- `Scaffold`: Widget yang menyediakan banyak widget-widget bawaan lainnya, anggap sebagai kerangka
- `AppBar`: Widget yang mendefinisikan bar atas dari aplikasi (judul aplikasi/semacam navbar kalau di web development)
- `Text`: Widget yang menghasilkan teks
- `SingleChildScrollView`: Sebuah widget yang menampilkan satu child secara scrollable
- `Padding`: Memberikan padding di luar child widget
- `EdgeInsets`: Mendefinisikan offset untuk edge visual
- `Column`: Widget yang mendisplay childnya secara vertikal
- `TextAlign`: Widget untuk menentukan posisi teks secara horizontal di dalam parent
- `TextStyle`: Widget untuk menentukan styling pada elemen teks, seperti ukuran font dsb.
- `FontWeight`: Widget untuk menentukan ketebalan font pada `TextStyle`
- `GridView`: Widget yang menampilkan list items sebagai array 2D
- `ItemCard`: Widget custom yang untuk mendefinisikan setiap tombol
- `Material`: Widget dasar sebagai material untuk melakukan clipping, elevation, dan ink effects
- `InkWell`: Widget persegi bagian dari `Material` yang bereaksi ke sentuhan
- `ScaffoldMessenger`: Widget yang memberikan API untuk memunculkan snackbar atau material banner di atas atau bawah layar.
- `SnackBar`: Memunculkan pesan ringan yang muncul sesaat di bawah layar
- `Center`: Widget yang meletakkan child nya ditengah dirinya sendiri
- `Container`: Widget yang menggabungkan beberapa pengaturan seperti warna, lebar, tinggi, padding, dll.
- `MainAxisAlignment`: Menentukan bagaimana Row dan Column bisa memposisikan childrennya dalam space yang tersisa
- `Icon`: Widget yang menampilkan icon dengan mendefinisikan constraints seperti ukuran, warna, dll.

## Tugas 8

### Implementasi Checklist Tugas 8

<details>
<summary>Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah item baru</summary>

Untuk halaman form item, saya menggunakan StatefulWidget, karena terdapat sebuah state yaitu isi dari setiap field pada form yang akan terus berubah sesuai interaksi pengguna.

```dart
class ItemFormPage extends StatefulWidget {
  const ItemFormPage({super.key});

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add Item Form'),
        ),
        backgroundColor: Colors.lightBlue.shade400,
        foregroundColor: Colors.white,
      ),
      ...
```

Di sini saya sudah membuat 3 variabel (`_name`, `_amount`, `description`) sebagai state untuk masing masing elemen input `name`, `amount`, dan `description`. Pada widget build, saya mendefinisikan `TextForm` untuk masing-masing input field:

**Name**

```dart
Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        decoration: InputDecoration(
        hintText: "Item Name",
        labelText: "Item Name",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
        setState(() {
            _name = value!;
        });
        },
        validator: (String? value) {
        if (value == null || value.isEmpty) {
            return "Name can't be empty!";
        }
        return null;
        })),
```

**Amount**

```dart
Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        decoration: InputDecoration(
        hintText: "Amount",
        labelText: "Amount",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
        setState(() {
            _amount = int.parse(value!);
        });
        },
        validator: (String? value) {
        if (value == null || value.isEmpty) {
            return "Amount can't be empty!";
        }
        if (int.tryParse(value) == null) {
            return "Amount has to be an integer!";
        }
        return null;
        })),
```

**Description**

```dart
Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        decoration: InputDecoration(
        hintText: "Description",
        labelText: "Description",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (String? value) {
        setState(() {
            _description = value!;
        });
        },
        validator: (String? value) {
        if (value == null || value.isEmpty) {
            return "Description can't be empty!";
        }
        return null;
        })),
```

Ketiga elemen input tersebut sudah mempunyai validasi input kosong dan kesesuaian tipe data pada bagian `validator:`. Ketiga elemen tersebut diletakkan di dalam widget Form dengan "dibungkus" oleh sebuah Column di dalam SingleChildScrollView:

```dart
class _ItemFormPageState extends State<ItemFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _amount = 0;
    String _description = "";

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Center(
            child: Text('Add Item Form'),
            ),
            backgroundColor: Colors.lightBlue.shade400,
            foregroundColor: Colors.white,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // ketiga elemen tadi
```

Pada bagian akhir dari childrennya `Column`. saya juga menambahkan tombol `Save` untuk menyimpan item yang telah dituliskan ke form:

```dart
...
body: Form(
  key: _formKey,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(          // ini tombolnya
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.lightBlue.shade400),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Your item is saved"),
                      content: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment:
                        CrossAxisAlignment.start,
                      children: [
                        Text("Item name: $_name"),
                        Text("Amount: $_amount"),
                        Text("Description: $_description")
                      ],
                      )),
                      actions: [
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                        Navigator.pop(context);
                        },
                      )
                      ]);
                  });
                _formKey.currentState!.reset();
                }
              },
              child: const Text(
                "Save",                     // ini tulisan save nya
                style: TextStyle(color: Colors.white),
              )
            )
          )
        )
      ]
    )
  )
)
```

</details>
<details>
<summary>Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item</summary>

Sebelum melakukan bagian ini, saya sudah memindahkan kode widget card pada halaman utama ke file .dart terpisah yang diberi nama `item_card.dart`

Pada `item_card.dart`, saya menambahkan navigasi apabila tombol yang ditekan adalah "Add Item", lebih tepatnya akan menambahkan fungsionalitas navigasi ketika widget yang di render oleh Flutter adalah tombol tersebut.

item_card.dart

```dart
class ItemCard extends StatelessWidget {
  final WarehouseItem item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}")));
          if (item.name == "Add Item") {              // bagian ini
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ItemFormPage()));
          }
        },
        ...
```

Ketika tombol Add Item ditekan, maka Navigator akan melakukan pushReplacement halaman sekarang dengan halaman ItemFormPage.

</details>
<details>
<summary>Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save</summary>

Fungsionalitas ini ditambahkan pada widget yang menambahkan tombol Save pada ItemFormPage dengan menggunakan widget AlertDialog. Fungsionalitas ditambahkan pada atribut onTap, tentunya dengan validasi terlebih dahulu:

```dart
onPressed: () {
  if (_formKey.currentState!.validate()) {
  showDialog(
    context: context,
    builder: (context) {
    return AlertDialog(
      title: const Text("Your item is saved"),
      content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text("Item name: $_name"),
          Text("Amount: $_amount"),
          Text("Description: $_description")
        ],
      )),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ]);
    });
  _formKey.currentState!.reset();
  }
},
```

Disini saya membuat anonymous function, kemudian memeriksa validitas form terlebih dahulu. Apabila form valid, maka showDialog akan dipanggil dengan mengembalikan AlertDialog yang mendisplay nama, jumlah, dan deskripsi barang yang baru saja ditambahkan. Apabila tombol OK ditekan, maka dialog akan di pop sehingga menghilang dari layar.

</details>
<details>
<summary>Membuat sebuah drawer pada aplikasi</summary>

Drawer saya buat pada file `left_drawer.dart` sebagai sebuah stateless widget (karena isi drawer tidak akan berubah).

```dart
class LeftDrawer extends StatelessWidget {
const LeftDrawer({super.key});

@override
Widget build(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: Column(children: [
              Text(
                'Warehouse Inventory',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text("Store your items on this app!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ))
            ])),
            ...
```

Widget ini mengembalikan sebuah `Drawer` yang didalamnya adalah `ListView`. Pada children `ListView`, paling atas terdapat sebuah header untuk drawer (`DrawerHeader`), dengan judul Warehouse Inventory dan tagline "Store your items on this app", lalu diberikan warna light blue sebagai background.

Masih pada childrennya ListView, setelah header drawer saya menambahkan dua opsi/dua tombol halaman:

```dart
const Drawer(
  child: ListView(
    children: [
      const DrawerHeader(
        ...
      ),
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text("Home"),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
        }),
      ListTile(
        leading: const Icon(Icons.format_list_bulleted_add),
        title: const Text("Add Items"),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ItemFormPage(),
            ));
        })
    ]
  )
)
```

`ListTile` yang pertama adalah tombol Home Page/Halaman Utama, sementara itu `ListTile` yang kedua adalah tombol Add Item/Tambah Item. Pada masing-masing tombol, atribut onTap sudah diberikan fungsi yang memanggil Navigator.pushReplacement dan melakukan redirection sesuai dengan halaman dari tombol yang ditekan.

</details>

### Perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()`

Pada Flutter, navigasi berfungsi seperti sebuah stack. Halaman yang sedang kita lihat seolah-olah adalah _top of the stack_. Dengan melakukan `Navigator.push()`, kita mem-push route suatu halaman baru ke bagian paling atas dari (seolah-olah) stack tersebut, sehingga yang sekarang kita lihat adalah halaman yang baru kita push. Halaman sebelumnya masih bisa diakses kembali apabila kita melakukan `.pop()`. Sementara itu, `Navigator.pushReplacement()` akan melakukan push terlebih dahulu, kemudian apabila halaman sudah selesai di "render" dan dianimasi, route dari halaman sebelumnya akan dihapus.

### Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing.

- Align: Sebuah widget yang mengatur posisi childnya sendiri, dan dapat secara opsional mengatur ukuran dirinya sendiri dengan menyesuaikan ukuran childnya. Digunakan ketika ingin mengatur spesifik posisi suatu child.
- AspectRatio: Widget yang akan (mencoba) mengatur childnya agar mengikuti aspect ratio tertentu. Digunakan ketika ingin menentukan secara spesifik aspect ratio dari sebuah child
- Center: Sebuah widget yang mengatur posisi childnya sendiri menjadi di tengah. Digunakan ketika kita ingin center sebuah child secara vertikal dan horizontal di dalam parentnya.
- Padding: Sebuah widget yang memberikan inset/pergeseran pada childnya dengan jumlah padding yang diberikan. Digunakan ketika ingin memberikan jarak yang spesifik antara child dengan parentnya.
- Column: Sebuah widget yang akan menampilkan sebuah list dari child widgets dengan arah vertikal (atas ke bawah). Digunakan ketika ingin men-display sebuah list dari child widgets secara memanjang ke bawah (misalnya keranjang atau list barang tersimpan pada toko)
- Row: Sebuah widget yang akan menampilkan sebuah list dari child widgets dengan arah horizontal. Dapat digunakan ketika ingin mendisplay sebuah list dari child widgets dari kiri ke kanan, tetapi mungkin child yang ditampilkan tidak boleh terlalu besar dan terlalu banyak karena row lebih sempit.
- ListView: Sebuah widget yang bisa discroll yang merupakan list linear dari widget-widget lainnya. Widget ini sangat umum digunakan sebagai widget yang bisa di scroll. Akan menampilkan elemen satu satu ke arah scroll.

### Sebutkan apa saja elemen input pada form dan mengapa digunakan

- TextInputForm: Digunakan agar bisa menerima input dari user
- ElevatedButton: Digunakan untuk bisa memproses input dari user dari TextInputForm, dari validasi hingga (nanti) menambahkan ke database. Pada tugas ini tombol digunakan juga untuk mendisplay dialog box sebagaii tanda sukses melakukan input pada form.

### Penerapan clean architecture pada aplikasi Flutter

Pada aplikasi Flutter, kita bisa membuat dua folder yang diberi nama `screens` dan `widgets`. Folder `screens` digunakan untuk menyimpan widget-widget buatan yang merupakan satu tampilan/satu layar, sementara folder `widgets` digunakan untuk menyimpan widget-widget buatan yang merupakan widget "kecil" yang di display pada halaman-halaman yang ada di `screens`. Pada Flutter, setiap widget sebaiknya dipisah pada tiap file, meskipun widget tersebut berkaitan. Dengan begitu, kita mempunyai satu file untuk setiap widget.

## Tugas 9

### Implementasi Checklist Tugas 9

<details>
<summary>Memastikan deployment proyek tugas Django telah berjalan dengan baik</summary>

Deployment sudah aman. Dapat diakses pada https://muhammad-nabil22-tugas.pbp.cs.ui.ac.id

</details>
<details>
<summary>Membuat halaman login pada proyek Flutter</summary>

Halaman login pada kasus ini harus menggunakan stateful widget karena memiliki field yang bisa berubah (tidak konstan). Halaman ini punya tombol yang akan berinteraksi dengan endpoint autentikasi mobile pada proyek Django di auth/login sesuai dengan data yang diinput pengguna. Halaman juga akan memunculkan snackbar sukses ataupun gagal ketika tombol login ditekan. Jika login berhasil, halaman akan redirect ke home page.

Kode dapat dilihat pada [`login.dart`](./lib/screens/login.dart) (karena terlalu panjang)

</details>
<details>
<summary> Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.</summary>

Untuk integrasi ini, saya membuat app baru pada proyek Django yang bernama `authentication` yang memiliki fungsi-fungsi views berupa login dan logout. Fungsionalitasnya tidak berbeda jauh dengan yang login biasa, hanya saja app authentication ini me-return JSON response sebagai respon dari login atau logout tersebut.

authentication/views.py:

```python
# import stuff

def login(request):
    username = request.POST.get("username")
    password = request.POST.get("password")
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!",
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)
    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)


@csrf_exempt
def logout(request):
    username = request.user.username

    try:
        auth_logout(request)
        return JsonResponse({
            "username": username,
            "status": True,
            "message": "Logout berhasil!"
        }, status=200)
    except:
        return JsonResponse({
            "status": False,
            "message": "Logout gagal."
        }, status=401)

```

Tentunya saya juga menambahkan routing agar page-page ini bisa diakses. Untuk login berada di auth/login dan logout berada di auth/logout. Pada proyek django saya juga menambahkan dependency dengan `django-cors-headers` agar komunikasi antar "origin", serta menambahkannya ke konfigurasi proyek django. Saya juga menambahkan variabel-variabel yang berkaitan dengan cors headers.

Sementara itu, pada proyek flutter, saya menambahkan dependency package `provider` dan `pbp_django_auth` untuk memudahkan autentikasi. Provider digunakan agar kita bisa menyediakan CookieRequest kepada semua child widgets. Fungsionalitas menyediakan CookieRequest ini saya tambahkan pada `main.dart`. Saya juga mengganti halaman utama ketika aplikasi pertama dibuka.

```dart
...
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest(); // bagian ini
          return request;
        },
        child: MaterialApp(
          title: 'Warehouse Inventory',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade400),
            useMaterial3: true,
          ),
          home: LoginPage(),
        ));
  }}
```

Saya juga menambahkan fungsionalitas logout yang ditambahkan pada tombol di menu.

</details>
<details>
<summary>Membuat model kustom sesuai dengan proyek aplikasi Django.</summary>

Untuk melakukan ini, saya memanfaatkan tool online bernama Quicktype yang bisa mengubah JSON dari sebuah objek menjadi sebuah objek kustom di Dart/Flutter. Untuk membuat model kustom ini saya hanya mengakses endpoint json/ pada proyek Django saya untuk mendapat JSON dari semua barang dan mengubahnya menjadi sebuah objek di Dart. Saya definisikan model ini pada lib/models/item.dart.

item.dart

```dart
// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  String model;
  int pk;
  Fields fields;

  Item({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String name;
  int amount;
  String description;

  Fields({
    required this.user,
    required this.name,
    required this.amount,
    required this.description,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        amount: json["amount"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "amount": amount,
        "description": description,
      };
}
```

</details>
<details>
<summary>Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah dideploy.</summary>

Sebelum implementasi, saya menambahkan dependensi package http ke proyek Flutter dan permission internet pada AndroidManifest (agar permission akses internet pada aplikasi diperbolehkan)

Kemudian, saya mengimplementasikan halaman list item pada `list_item.dart`.

list_item.dart:

```dart
class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Future<List<Item>> fetchItem() async {
    var url = Uri.parse('https://muhammad-nabil22-tugas.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Item
    List<Item> list_item = [];
    for (var d in data) {
      if (d != null) {
        list_item.add(Item.fromJson(d));
      }
    }
    return list_item;
  }
```

Pertama halaman akan melakukan fetch terlebih dahulu dari endpoint tersebut (fungsi ini akan dipanggil pertama ketika widget builder dipanggil). Setelah itu, response JSON yang didapat akan diolah menjadi sebuah objek Item yang sebenarnya dan disimpan pada `list_item.`, kemudian di-return untuk diolah sebagai widget.`

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Item List'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchItem(), // item di fetch disini
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "There are no items.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItemDetailPage(
                                            snapshot.data![index])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data![index].fields.name}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                        "Jumlah: ${snapshot.data![index].fields.amount}"),
                                    const SizedBox(height: 10),
                                    Text(
                                        "${snapshot.data![index].fields.description}")
                                  ],
                                ),
                              ))));
                }
              }
            }));
  }
```

Tiap item adalah sebuah elemen pada ListView yang diolah dalam ListView.builder(). Setiap elemen adalah sebuah Inkwell yang dalamnya adalah Padding yang punya child Column yang childnya adalah masing-masing field pada Item, yaitu name, amount, dan description.

</details>
<details>
<summary>Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.</summary>

Fungsionalitas akses halaman detail ini terletak pada ListView.builder() pada halaman list item:

list_item.dart:

```dart
return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItemDetailPage(
                                            snapshot.data![index])));
                              },
                              ....
```

Untuk setiap item (yang merupakan sebuah Inkwell), apabila item tersebut ditekan, maka Navigator akan melakukan redirect ke ItemDetailPage dengan memasukkan informasi Item yang ditekan. ItemDetailPage sendiri hanya sebuah halaman yang memunculkan nama jumlah, dan deskripsi. Tombol back/kembali ke halaman list item disediakan by default.

item_detail.dart:

```dart
import "package:flutter/material.dart";
import "package:warehouse_inventory_mobile/models/item.dart";

class ItemDetailPage extends StatelessWidget {
  final Item item;

  const ItemDetailPage(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Item Detail")),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.fields.name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Jumlah: ${item.fields.amount}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          item.fields.description,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        )),
                  ],
                ))));
  }
}

```

</details>

### Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?

Bisa saja, akan tetapi pengolahan data akan lebih rumit karena tiap data masih terpisah-pisah. Apabila kita membuat model terlebih dahulu, kita bisa mengubah JSON tersebut menjadi instance dari model dan kita dapat melakukan pengolahan atau manipulasi data dengan lebih mudah.

### Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

Secara garis besar, CookieRequest akan meng-handle/menerima dan mengelola cookies yang diterima dari response pertama kali ketika login. Seperti yang kita tahu bahwa cookie di web browser disimpan pada browser. Dalam kasus Flutter ini, CookieRequest dapat dianggap menjadi pengelola cookie tersebut. Instance CookieRequest dibagikan ke semua komponen agar semua komponen lain dapat melakukan request dengan menggunakan cookie yang saat ini dimiliki.

### Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.

Berdasarkan kode, pertama JSON data akan di fetch dari endpoint JSON pada web page menggunakan URL parse dulu kemudian GET request dengan package http. Data yang telah diterima akan diubah menjadi objek Item yang berkaitan di Flutter. Dari objek Item tersebut, tiap-tiap fieldnya akan bisa ditampilkan melalui FutureBuilder yang menunggu hingga request secara asinkronus selesai

### Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

Pertama, username dan password akan dikirimkan dalam POST request ke endpoint login Django yang telah dibuat khusus untuk mobile. Melalui views di Django, Django akan mencoba login dengan username dan password yang diberikan. Apabila login gagal, maka request akan mengembalikan respon 401. Namun apabila login berhasil, request akan mengembalikan respon 200, pesan sukses, dan juga username yang berhasil di-login-kan, kemudian melakukan redirect ke home page.

### Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.

**(dengan asumsi bahwa yang dimaksud adalah \*widget baru yang dipakai\* pada tugas ini)**

- `FutureBuilder`: Sebuah widget yang akan membangun dirinya sendiri berdasarkan interaksi dengan sebuah objek Future yang paling terbaru.
- `CircularProgressIndicator`: Sebuah widget Material Design yang merupakan progress indicator lingkaran, akan berputar dan menandakan bahwa aplikasi sedang sibuk/sedang melakukan pemrosesan.
- `ItemDetailPage`: Sebuah widget buatan yang memunculkan halaman detail dari setiap Item
- `SizedBox`: Sebuah widget berupa box yang ukurannya dapat ditentukan.
- `TextEditingController`: Controller untuk sebuah text field yang bisa diedit. Akan memberikan notifikasi kepada listeners dari text field yang dimaksud bahwa nilainya telah diupdate.
- `LoginPage`: Widget buatan berupa halaman untuk melakukan fungsionalitas login.
