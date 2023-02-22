# sql_project
PostgreSQL ve C# kullanılarak yapılmış bir kütüphane-kitap sistemidir.
-Actor ödünç kitap alabilir,
-Kitap isteğinde bulunabilir,
-Kitap adını ve yerini aratabilir,
-Kullanıcı şifresini güncelleyebilir.<br>
<br>
İŞ KURALLARI<br>
-Her hesabın bir adı, numarası, maili, şifresi , bölümü, sınıfı, cinsiyeti vardır.
-kitapId’si ,kitap adı, sayfa sayısı, yazarId’si , konuId , rafadres ve turId ' sine sahip kitaplar vardır.
-yazarId ,adı bilgilerini içeren yazar vardır.
-KonuId 'si ve kitapId bilgilerini içeren kitap konuları vardır.
-turId ve tur adına sahip kitap türleri vardır.
-Id'si ,emanet alan no ,rafId, kitapId içeren emanetler vardır.
-Adres , fakulte ,kutuphaneId içeren kütüphane vardır.
-Kitap iste için kitap adı ,yazar Adı ,numara' si mevcuttur.
-Her bir raf için rafId ,rafAdres ,rafDurumu ,rafKonumu, kutuphaneId mevcuttur.
-Her öğrencinin yalnız bir hesabı mevcuttur ve bu hesap tüm kütüphanelerde geçerlidir.
-Her öğrenci birden fazla kitabı aynı anda alabilir.
-Her kitap hiç alınmayadabilir.Birden fazla kez de alınabilir.
-Her kitabın birden fazla konusu vardır.
-Bir kitap yalnız bir türde olabilir. Bir türde birden fazla kitap bulunabilir.
-Bir kitabın birden fazla adresi bulunabilir de bulunmayabilir de.
-Bir kitap her kütüphanede çok sayıda bulunabilir.
-Bir kitabı aynı anda birden fazla öğrenci ödünç alamaz.
-Bir kitap emanet alınmışsa rafDurum boş gözükür.
-Her kütüphanenin yalnız bir adresi vardır.
-Bir kütüphane en fazla bir fakültede bulunur.
-Her öğrenci birden fazla kitap iste talebinde bulunabilir,hiç bulunmayadabilir.
-Bir kitabın kitap iste yalnızca bir öğrenci yapabilir.<br>
<br>
İLİŞKİSEL ŞEMA<br>
Hesap (numara:varchar, kisiadi:varchar, sifre: varchar ,mail:varchar , bolum:varchar , sınıf:varchar,
cinsiyet:varchar)
Emanet (Id:int, EserId:int, EmanetAlanNo:varchar, RafId:int , kitapId:int)
Kitap ( Kitapadi:varchar , sayfasayisi:int, yazarId:int, KonuId:int, TurId:int, kitapId:int,
RafAdres:varchar)
YazarKitap (KitapId:int, YazarId:int)
Yazar (YazarId:int, yazarAdı:varchar)
hesapKutuphane (KutuphaneId:int, numara:varchar)
Kutuphane (KutuphaneId:int, Adres: varchar, Fakulte: varchar)
IstekKitap (kitapAdi:varchar, numara:varchar, YazarAdi:varchar)
Raf (RafId:int, RafAdres:varchar, RafKonum:int, RafDurum:varchar, KutuphaneId:int)
kitapKonu (KonuId:int, kitapId:int)
Konu (KonuId:int, KonuAdi:varchar)
Tur (TurId:int, TurAdi:varchar)
