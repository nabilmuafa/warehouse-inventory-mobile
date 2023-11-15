# Warehouse Inventory Mobile

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
