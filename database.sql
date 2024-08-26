CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    content TEXT,
    video_link VARCHAR(255),
    position INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    course_id BIGINT REFERENCES courses (id),
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    module_id BIGINT REFERENCES modules (id),
    name VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    content VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    price NUMERIC,
    program_type VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE moduleCourse (
  module_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL,
  PRIMARY KEY (module_id, course_id),
  FOREIGN KEY (module_id) REFERENCES modules(id),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE programModule (
  program_id INTEGER NOT NULL,
  module_id INTEGER NOT NULL,
  PRIMARY KEY (program_id, module_id),
  FOREIGN KEY (program_id) REFERENCES programs(id),
  FOREIGN KEY (module_id) REFERENCES modules(id)
);

CREATE TABLE users (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_role ENUM('студент', 'учитель', 'админ') NOT NULL,
  full_name VARCHAR(255),
  email VARCHAR(255),
  password_hash VARCHAR(255),
  FOREIGN KEY (teaching_group_id) REFERENCES teachingGroups (id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE teachingGroups (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  slug VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE enrollments (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (programs_id) REFERENCES programs(id),
  status ENUM('active', 'pending', 'cancelled', 'completed') NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE payments (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (enrollment_id) REFERENCES enrollments(id),
  amount NUMERIC,
  status ENUM('pending', 'paid', 'failed', 'refunded') NOT NULL,
  date TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE programCompletions (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (programs_id) REFERENCES programs(id),
  status ENUM('active', 'completed', 'pending', 'cancelled') NOT NULL,
  start_at TIMESTAMP,
  end_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE certificates (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (programs_id) REFERENCES programs(id),
  url VARCHAR(255),
  release_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE quizzes (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id),
  name VARCHAR(255),
  content TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE exercises (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id),
  name VARCHAR(255),
  url VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE discussions (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id),
  debate TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE blog (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES users(id),
  title TEXT,
  content TEXT,
  status ENUM('created', 'in moderation', 'published', 'archived') NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);