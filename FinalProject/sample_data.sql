
-- sample_data.sql: Örnek veri ekleme komutları

-- categories
INSERT INTO categories (id, name) VALUES
(1, 'Yapay Zeka'),
(2, 'Siber Guvenlik'),
(3, 'Veri Bilimi');

-- members
INSERT INTO members (id, username, email, password, created_at, first_name, last_name) VALUES
(1, 'ece01', 'ece@example.com', 'hashed_pw1', NOW(), 'Ece', 'Yildiz'),
(2, 'eda02', 'eda@example.com', 'hashed_pw2', NOW(), 'Eda', 'Demir');

-- courses
INSERT INTO courses (id, name, description, start_date, end_date, instructor, category_id) VALUES
(1, 'Makine Ogrenmesine Giris', 'Temel ML kavramlari', '2025-05-01', '2025-06-01', 'Dr. Yilmaz', 1),
(2, 'Siber Guvenlik 101', 'Bilgi guvenligi ve saldiri turleri', '2025-05-10', '2025-06-10', 'Prof. Derin', 2);

-- enrollments
INSERT INTO enrollments (id, member_id, course_id, enrollment_date) VALUES
(1, 1, 1, '2025-04-20 14:00:00'),
(2, 2, 2, '2025-04-21 09:30:00');

-- certificates
INSERT INTO certificates (id, certificate_code, issue_date) VALUES
(1, 'CERT-ML-001', '2025-06-02'),
(2, 'CERT-SC-002', '2025-06-11');

-- certificate_assignments
INSERT INTO certificate_assignments (id, member_id, certificate_id, assignment_date) VALUES
(1, 1, 1, '2025-06-03'),
(2, 2, 2, '2025-06-12');

-- blog_posts
INSERT INTO blog_posts (id, title, content, published_at, author_id) VALUES
(1, 'Makine Ogrenmesine Giris', 'Bu yazida temel ML kavramlarini ele aldim...', NOW(), 1),
(2, 'Siber Guvenlikte Onemli Adımlar', 'Siber guvenlikte en çok karsilasilan riskler...', NOW(), 2);
