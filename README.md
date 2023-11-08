# Warehouse Inventory Mobile

Proyek Flutter untuk tugas mata kuliah Pemrograman Berbasis Platform Ganjil 2023/2024. Dibuat oleh Muhammad Nabil Mu'afa - 2206024972

### Daftar Isi

- [README.md Tugas 7](#tugas-7)
  - [Implementasi Checklist](#implementasi-checklist-tugas-7)
  - [Perbedaan utama stateless & stateful widget](#apa-perbedaan-utama-antara-stateless-dan-stateful-widget-dalam-konteks-pengembangan-aplikasi-flutter)
  - [Seluruh widget yang digunakan](#sebutkan-seluruh-widget-yang-kamu-gunakan-untuk-menyelesaikan-tugas-ini-dan-jelaskan-fungsinya-masing-masing)

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
