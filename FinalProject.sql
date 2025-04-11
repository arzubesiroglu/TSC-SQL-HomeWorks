/*******************************************************************************
 📌 FINAL PROJECT – PostgreSQL ile Çevrimiçi Eğitim Platformu Veritabanı Tasarımı
********************************************************************************/

/********************************************************************************
    Bu dosya, TurkStudentCo Data Science Bootcamp SQL kapsamında 
    (Şubat–Nisan 2025) gerçekleştirilen final proje çalışmasıdır.

    İçerik:
    - Çevrimiçi bir eğitim platformu için PostgreSQL kullanılarak tasarlanan 
      veritabanı şeması
    - Tabloların yapıları, ilişkileri (PK/FK) ve adım adım açıklamalı SQL komutları

    Yazar: Arzu Beşiroğlu
    Tarih: Nisan 2025
*******************************************************************************/

-- =============================================================================
-- GÖREVLER ve TABLOLAR
-- =============================================================================
-- Aşağıda, final proje dokümanında belirtilen görevler doğrultusunda 
-- oluşturulmuş veritabanı tabloları yer almaktadır.
-- Her tablo, ilgili görev tanımı, CREATE komutu ve açıklamaları ile birlikte sunulmuştur.
-- Tablolar Roma rakamları (I, II, III...) ile sıralanmıştır.

-- =============================================================================
-- I. GÖREV VE TABLO: MEMBERS
-- =============================================================================

-- Görev Tanımı:
-- Üyeler (Members): Üye bilgilerini (kullanıcı adı (VARCHAR(50) UK), 
-- e-posta (VARCHAR(100) UK), şifre (VARCHAR(255)), kayıt tarihi (TIMESTAMP), 
-- ad (VARCHAR(50)), soyad (VARCHAR(50)) vb.) saklayacak bir tablo oluşturun. 
-- Bu tabloda bir Birincil Anahtar (PK) (INTEGER veya BIGINT) tanımlayın.


-- Members tablosunun oluşturulması
-- Alternatif olarak: CREATE TABLE IF NOT EXISTS members (...)

CREATE TABLE members (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Açıklama:
-- Bu tablo, platforma üye olan kullanıcıların bilgilerini tutar.
-- username ve email sütunları tekil (UNIQUE) olacak şekilde ayarlanmıştır.
-- created_at sütunu, kullanıcı kaydının oluşturulduğu tarihi otomatik olarak alır.

-- =============================================================================
-- II. GÖREV VE TABLO: CATEGORIES
-- =============================================================================

-- Görev Tanımı:
-- Kategoriler (Categories): Eğitim kategorilerini (yapayzeka (VARCHAR(100)), 
-- blokzincir (VARCHAR(100)), siber güvenlik (VARCHAR(100)) vb.) 
-- yönetebilecek bir tablo oluşturun. 
-- Bu tabloda bir Birincil Anahtar (PK) (INTEGER veya SMALLINT) tanımlayın.
-- Eğitimler ile kategoriler arasında bir ilişki kurun 
-- (Yabancı Anahtar (FK) (INTEGER veya SMALLINT) kullanılarak).

-- Categories tablosunun oluşturulması
-- Alternatif olarak: CREATE TABLE IF NOT EXISTS categories (...)

CREATE TABLE categories (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Açıklama:
-- Bu tablo, eğitim platformunda tanımlı olan kategorileri içerir.
-- Her kategori benzersiz bir id'ye sahiptir (SMALLINT veri tipiyle).
-- name sütunu, kategorinin adını tutar ve boş bırakılamaz (NOT NULL).

-- =============================================================================
-- III. GÖREV VE TABLO: COURSES
-- =============================================================================

-- Görev Tanımı:
-- Eğitimler (Courses): Platformdaki eğitimlerin bilgilerini 
-- (adı (VARCHAR(200)), açıklaması (TEXT), başlangıç tarihi (DATE), 
-- bitiş tarihi (DATE), eğitmen bilgisi (VARCHAR(100)) vb.) saklayacak 
-- bir tablo oluşturun. 
-- Bu tabloda bir Birincil Anahtar (PK) (INTEGER veya BIGINT) tanımlayın.

-- Courses tablosunun oluşturulması
-- Alternatif olarak: CREATE TABLE IF NOT EXISTS courses (...)

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    instructor VARCHAR(100),
    category_id SMALLINT REFERENCES categories(id)
);

-- Açıklama:
-- Bu tablo, platformdaki her bir eğitimin bilgilerini içerir.
-- name sütunu zorunludur, eğitim adını temsil eder.
-- description, eğitim içeriğinin genel açıklamasıdır.
-- start_date ve end_date, eğitimin zaman aralığını belirtir.
-- instructor sütunu, eğitimi veren kişi bilgisini tutar.
-- category_id sütunu, bu eğitimin hangi kategoriye ait olduğunu belirtir ve
-- categories tablosundaki id alanına dış anahtar (FK) olarak bağlanır.

-- =============================================================================
-- IV. GÖREV VE TABLO: ENROLLMENTS
-- =============================================================================

-- Görev Tanımı:
-- Katılımlar (Enrollments): Kullanıcıların hangi eğitimlere katıldığını takip edebilecek 
-- bir ara tablo oluşturun. 
-- Bu tablo, kullanıcılar (INTEGER veya BIGINT FK) ve eğitimler (INTEGER veya BIGINT FK) 
-- tabloları arasındaki çok-çok ilişkisini yönetmeli ve her iki tabloya ait 
-- Yabancı Anahtarları (FK) içermelidir.
-- Bu tabloda bir Birincil Anahtar (PK) (INTEGER veya BIGINT) da tanımlanabilir 
-- (örneğin, otomatik artan bir ID). 
-- İsteğe bağlı olarak katılım tarihi (TIMESTAMP) gibi bilgiler de eklenebilir.

-- Enrollments tablosunun oluşturulması
-- Alternatif olarak: CREATE TABLE IF NOT EXISTS enrollments (...)

CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER REFERENCES members(id),
    course_id INTEGER REFERENCES courses(id),
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Açıklama:
-- Bu tablo, kullanıcıların hangi kurslara katıldığını gösteren bir ilişki tablosudur.
-- member_id sütunu, üyeler tablosundaki id değerine FK olarak bağlanır.
-- course_id sütunu, courses tablosundaki id değerine FK olarak bağlanır.
-- Her kayıt, bir üyeye ait bir kurs katılımını temsil eder.
-- enrollment_date ile katılımın zamanı otomatik olarak kaydedilir.

-- =============================================================================
-- V. GÖREV VE TABLO: CERTIFICATES
-- =============================================================================

-- Görev Tanımı:
-- Sertifikalar (Certificates): Tamamlanan eğitimler için sertifika bilgilerini 
-- (sertifika kodu (VARCHAR(100) UK), veriliş tarihi (DATE) vb.) 
-- saklayacak bir tablo oluşturun. 
-- Bu tabloda bir Birincil Anahtar (PK) (INTEGER veya BIGINT) tanımlayın.

-- Certificates tablosunun oluşturulması
-- Alternatif olarak: CREATE TABLE IF NOT EXISTS certificates (...)

CREATE TABLE certificates (
    id SERIAL PRIMARY KEY,
    certificate_code VARCHAR(100) UNIQUE NOT NULL,
    issue_date DATE
);

-- Açıklama:
-- Bu tablo, verilen sertifikaların bilgilerini içerir.
-- certificate_code her sertifika için benzersiz olacak şekilde UNIQUE olarak tanımlanmıştır.
-- issue_date, sertifikanın verildiği tarihi tutar.
-- id sütunu otomatik artan birincil anahtardır.

-- =============================================================================
-- VI. GÖREV VE TABLO: CERTIFICATE_ASSIGNMENTS
-- =============================================================================

-- Görev Tanımı:
-- Sertifika Atamaları (CertificateAssignments): Hangi kullanıcının (INTEGER veya BIGINT FK) 
-- hangi sertifikayı (INTEGER veya BIGINT FK) aldığını ilişkilendirecek bir tablo oluşturun.
-- Yabancı Anahtarlar (FK) kullanarak üyeler ve sertifikalar tablolarına bağlanılmalıdır.
-- Bu tabloda bir Birincil Anahtar (PK) (INTEGER veya BIGINT) tanımlayın 
-- ve isteğe bağlı olarak alım tarihi (DATE) gibi bilgiler ekleyebilirsiniz.

-- CertificateAssignments tablosunun oluşturulması
-- Alternatif olarak: CREATE TABLE IF NOT EXISTS certificate_assignments (...)

CREATE TABLE certificate_assignments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER REFERENCES members(id),
    certificate_id INTEGER REFERENCES certificates(id),
    assignment_date DATE
);

-- Açıklama:
-- Bu tablo, hangi üyenin hangi sertifikayı aldığını gösterir.
-- member_id sütunu members tablosundaki kullanıcıya FK ile bağlanır.
-- certificate_id sütunu certificates tablosundaki sertifikaya FK ile bağlanır.
-- assignment_date, sertifikanın atandığı tarihi temsil eder.
-- id sütunu otomatik artan PRIMARY KEY olarak tanımlanmıştır.

-- =============================================================================
-- VII. GÖREV VE TABLO: BLOG_POSTS
-- =============================================================================

-- Görev Tanımı:
-- Blog Gönderileri (BlogPosts): Kullanıcıların blog gönderilerini 
-- (başlık (VARCHAR(255)), içerik (TEXT), yayın tarihi (TIMESTAMP), 
-- yazar bilgisi (INTEGER veya BIGINT FK) vb.) saklayacak bir tablo oluşturun. 
-- Bu tablo, üyeler tablosu ile ilişkilendirilmelidir (Yabancı Anahtar (FK) kullanılarak) 
-- ve bir Birincil Anahtar (PK) (INTEGER veya BIGINT) içermelidir.

-- BlogPosts tablosunun oluşturulması
-- Alternatif olarak: CREATE TABLE IF NOT EXISTS blog_posts (...)

CREATE TABLE blog_posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    author_id INTEGER REFERENCES members(id)
);

-- Açıklama:
-- Bu tablo, üyelerin blog paylaşım içeriklerini tutar.
-- title sütunu zorunludur ve gönderi başlığını ifade eder.
-- content sütunu gönderi içeriğini tutar.
-- published_at sütunu gönderinin yayınlandığı zamanı tutar ve varsayılan olarak şu anki zamanı alır.
-- author_id sütunu members tablosundaki kullanıcıya dış anahtar (FK) ile bağlanır.

----------------------------------------------------------------------------------------------------

