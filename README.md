# Soal Shift Modul 1 [ Kelompok D9 ]
Hasil pengerjaan Soal Shift Modul 1 Kelompok D9

## Soal No. 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah
dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah
nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh
file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari
jumat pada bulan Februari.
### Jawab
Pertama-tama yang dilakukan ialah mendownload serta men-_unzip_ file nature.zip
Setelah itu didalamnya terdapat banyak sekali file .jpg yang corrupt oleh karena itu kita harus mendecode file tersebut dengan bantuan command base64 dan hexdump (base64 dan xxd)

Dalam Script yg saya buat pertama saya menselect semua file yang .jpg dengan bantuan command grep
lalu dr banyaknya file didapat akan terlooping untuk menjalankan command decode yang berisi
> `base 64 -d ~/nature/"$decode" | xxd -r ~/nature/"dc$decode.jpg"`

| Options | Description |
| --- | --- |
| -d | decode data; untuk mendekripsi sebuah file  |
| -r | reverse operation; dikarenakan file yang didapat merupakan kebalikan dari file sebelumnya |

lalu file tersebut harus dieksekusi pada Jumat,14 Februari, 14:14 dengan bantuan crontab yaitu 
> 14 14 14 2 5 /bin/bash /home/kyielas/soal1.sh

## Soal No. 2
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:
   1. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun
       2012.
   2. Tentukan tiga product line yang memberikan penjualan(quantity)
       terbanyak pada soal poin a.
   3. Tentukan tiga product yang memberikan penjualan(quantity)
       terbanyak berdasarkan tiga product line yang didapatkan pada soal
       poin b.
       
### Jawab
**a.** Setelah mendownload file WA_Sales_Products_2012-14.csv
   Saya membuat script yang mencari negara dengan penjualan terbanyak pada tahun 2012
> hasilA=awk -F ',' '{if($7 == "2012") x[$1]+=10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv |sort,   -nrk2 | awk -F "," 'NR==1{print $1}'

Dengan bantuan command awk dan looping serta sorting dan number row dapat menghasilkan hasilnya

| Command | Description |
| --- | --- |
| -F | untuk memberi tahu parsing suatu command, sbg contoh ","  |
|  $ | $1,$7,$10 merupakan kolom yang dimaksud oleh soal yaitu negara,tahun,dan penjualan |
| -t | untuk memberi tahu seperator di sorting, sbg contoh ,  |
| -nrk2 | numerical, reverse, dan kolom dua; dikarenakan yang di sort merupakan kolom dua dari print yang di dapat, sbg contoh      "Zone, 188" |

**b.** untuk no 2 kita harus mencari 3 _productline_  dari hasil pencarian A
> hasilB1=awk -F ',' -v A="hasilA" '{if($1 == 'A' && $7 == "2012") x[$4]+=10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv | sort -t, -nrk2 | awk - F "," 'NR==1{print $1}'

perbedaan dr yang satu ialah $1 sesuai hasil bagian B ialah kita men-sort $4 yaitu product line dan kenapa itu variabelnya hasilB1 karena saya memprint tiap row satu-satu sehingga hal tersebut di print 3 kali dan number row (NR) diincrement untuk setiap printnya

**c.** untuk no 3 kita mencari 3 _product_ berdasarkan hasil pencarian B
> awk -F ',' -v X="$hasilB1" -v U1="$hasilA" '{if($4 == 'X' && $1 == 'U1' && $7 == "2012")x[$6]+=$10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv | sort -t, nrk2 | awk -F ',' 'NR<4{print $1}'

perbedaannya dari hasil b ialah $4 sesuai hasil bagian B ialah kita men-sort $6 yaitu product dan sama seperti atas di print 3 kali dan number row(NR) berisi 3 dengan (<4) 

## Soal No. 3
Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

* Jika tidak ditemukan file password1.txt maka password acak tersebut
  disimpan pada file bernama password1.txt
* Jika file password1.txt sudah ada maka password acak baru akan
  disimpan pada file bernama password2.txt dan begitu seterusnya.
* Urutan nama file tidak boleh ada yang terlewatkan meski filenya
  dihapus.
* Password yang dihasilkan tidak boleh sama.

### Jawab
Saya menggunakan satu script untuk memenuhi semua kriteria
**a.** untuk memenuhi password pertama ialah password1.txt ialah dengan memberi variabel tersebut dengan 1 (x=1)
> if [ -f /home/kyielas/Password/pass$x.txt ]
**b. & c.** untuk memenuhi password baru akan di simpan dalam passwordx+1.txt maka otomatis mengecek tiap angka dan apabila terlewat 
> then x=$((x + 1))
**d** dengan command tr dapat didapatkan password random dengan 12 karakter dengan huruf besar,kecil dan angka yaitu sbg berikut
> tr -cd '[:alnum:]' < /dev/urandom | fold -w12 | head -1 > /home/kyielas/Password/pass$x.txt

 
| Options | Description |
| --- | --- |
| /dev/urandom | merupakan pseudo random generator |
| tr -cd '[:alnum:]' | mentranslate string; mendelete karakter non-alphanumeric; Alphanumeric |
| fold -w12 | untuk memprint hanya 12 karakter |
| head -1 | untuk memprint hanya satu baris |

## Soal No. 4
Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-
bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:

* Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan
  pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki
  urutan ke 12+2 = 14.
* Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke
  empat belas, dan seterusnya.
* setelah huruf z akan kembali ke huruf a
* Backup file syslog setiap jam.
* dan buatkan juga bash script untuk dekripsinya.

### Jawab

## Soal No. 5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

* Tidak mengandung string “sudo”, tetapi mengandung string “cron”,
  serta buatlah pencarian stringnya tidak bersifat case sensitive,
  sehingga huruf kapital atau tidak, tidak menjadi masalah.
* Jumlah field (number of field) pada baris tersebut berjumlah kurang
  dari 13.
* Masukkan record tadi ke dalam file logs yang berada pada direktori
  /home/[user]/modul1.
* Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh
  13:02, 13:08, 13:14, dst.
  
  ### Jawab
  **a.** untuk memenuhi mengandung string "cron" (Tidak Case-sensitive) dan tidak mengandung string sudo ditambah kondisi sbg berikut
  > (/cron/ || /CRON/) && (!/sudo/)
  **b.** untuk memenuhi jumlah field kurang dari 13 maka ditambah kondisi sbg berikut
  > (NF < 13)
  **c.** untuk disimpan direktori /home/user/modul1 ditambah kondisi sbg berikut
  > >> /home/kyielas/modul1/kyielas.log
  **d.** untuk mengeksekusi script setiap 6 menit dari menit 2 sampai 30 diberi kondisi dengan bantuan crontab sbg berikut
  > 2-30/6 * * * * /bin/bash /home/kyielas/soal5.sh
