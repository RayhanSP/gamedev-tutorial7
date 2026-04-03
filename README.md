# Tutorial 7: Basic 3D Game Mechanics & Level Design

**Nama** : Rayhan Syahdira Putra
**NPM** : 2306275903

---

## Proses Pengerjaan Tutorial dan Latihan Mandiri
Pada tutorial kali ini, saya mengimplementasikan mekanik dasar game 3D (First-Person), desain level menggunakan *Constructive Solid Geometry* (CSG), serta sistem interaksi objek berbasis *RayCast*. Saya juga mengimplementasikan beberapa fitur tambahan untuk Latihan Mandiri. Berikut adalah penjelasan mengenai proses implementasinya:

1. **Pergerakan Karakter & Kamera First-Person:** Karakter utama (`Player.tscn`) dibangun menggunakan `CharacterBody3D` dengan bentuk *collision* `CapsuleShape3D`. Logika pergerakan memanfaatkan `Vector3` untuk translasi sumbu X dan Z, serta interpolasi linear (`lerp`) untuk memberikan efek akselerasi dan friksi. Rotasi pandangan ditangani menggunakan `InputEventMouseMotion` yang mengubah rotasi vertikal kamera (dibatasi *clamp* 90 derajat) dan rotasi horizontal keseluruhan badan *player*.
2. **Interaksi RayCast (Saklar Lampu):** Sistem interaksi objek diimplementasikan menggunakan node `RayCast3D` yang disematkan pada kamera *player*. Node *switch* (saklar) yang dibekali fisik `StaticBody3D` mendeteksi benturan pancaran *raycast* dan mengeksekusi logika perubahan properti *Light Energy* pada node `OmniLight3D` untuk menyalakan atau mematikan lampu secara dinamis.
3. **Level Design menggunakan CSG:** Lingkungan map (`World 1.tscn`) disusun menggunakan node CSG. Lantai dasar dan tembok dibuat menggunakan `CSGBox3D`, sedangkan objek yang lebih kompleks seperti lampu meja dibangun dari gabungan `CSGCylinder3D` dan `CSGPolygon3D` ber- *mode spin*. Saya menerapkan metode pemotongan bentuk (*Boolean Operation: Subtraction* dan *Union*) untuk membuat halangan berupa jurang.
4. **Implementasi Latihan Mandiri (Pick up item, Inventory & Win Condition):**
   * **Custom 3D Coffee Cup (Sistem Pick-Up):** Sebagai pengganti *item pickup* statis, saya merakit model 3D gelas kopi secara mandiri langsung di dalam Godot menggunakan tumpukan node CSG. Untuk badan gelas utama yang memiliki bentuk *tapered* (mengecil ke bawah), saya menggunakan `CSGMesh3D` dengan bentuk `CylinderMesh` dan mengatur radius atas-bawahnya secara terpisah. Saya menambahkan `CSGCylinder3D` ekstra sebagai tutup (*lid*) dan *sleeve* penahan panas. Agar setiap bagian dapat diwarnai secara independen (putih, hitam, cokelat) tanpa saling mempengaruhi material asli, saya menggunakan fungsi *Make Unique* pada material `Albedo`. 
   * **Penerapan Decal & Animasi:** Untuk mempertegas efek rotasi gelas, saya memproyeksikan tekstur gambar biji kopi PNG ke permukaan lengkung *sleeve* gelas menggunakan node `Decal`. Node proyeksi ini ditempatkan pada *root* dan dirotasikan sumbu kemiringannya agar sorotannya tegak lurus sejajar dengan kemiringan dinding gelas tanpa menembus dinding belakang. Node utama kopi (`Area3D`) kemudian dianimasikan berputar dengan fungsi `rotate_y` dan akan memanggil sistem *inventory* *player* sesaat sebelum objek dihancurkan (`queue_free()`).
   * **Inventory & HUD Dinamis:** Saya menambahkan sistem inventori sederhana berupa variabel `collected_cups` di dalam *script* `Player`. Untuk memberikan *feedback* visual secara instan, saya membuat antarmuka HUD menggunakan node `CanvasLayer` dan `Label` yang selalu berada di layar depan, dan memperbarui teks kemajuannya ("Kopi: x / 4") setiap kali *player* memungut kopi.
   * **Real-time Win Trigger:** Pada seberang rintangan parkour, saya meletakkan area kemenangan yang melakukan validasi inventori *player* secara *real-time* di dalam fungsi `_process`. Jika *player* melompat menyentuh area kemenangan dan gelas kopi ke-4 di waktu yang bersamaan, kondisi terpenuhi dan *game* akan otomatis memuat layar `Win Screen.tscn`.
   * **Custom Win Screen:** Saya menyusun UI penutup permainan menggunakan `Control` Node, lengkap dengan foto yang diproyeksikan menggunakan `TextureRect` (*Keep Aspect*), teks pesan kemenangan, dan tombol *Retry* fungsional. Pada *script* UI ini, *mouse cursor* diaktifkan kembali (`MOUSE_MODE_VISIBLE`) agar interaksi UI berjalan optimal.

## Referensi
- Materi Tutorial 7 - Basic 3D Game Mechanics & Level Design, Mata Kuliah Game Development Fakultas Ilmu Komputer Universitas Indonesia.
- Godot 3D Tutorial & Godot FPS Tutorial.
- Dokumentasi Resmi Godot Engine (v4.6) mengenai UI CanvasLayer, CSG Nodes, Decal, dan RayCast3D.