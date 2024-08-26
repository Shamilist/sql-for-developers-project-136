CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id BIGINT REFERENCES courses (id),
    title VARCHAR(255),
    content TEXT,
    video_url VARCHAR(255),
    position INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at BOOLEAN DEFAULT FALSE
);

CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    module_id BIGINT REFERENCES modules (id),
    title VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at BOOLEAN DEFAULT FALSE
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255),
    description VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at BOOLEAN DEFAULT FALSE
);

CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    price NUMERIC,
    program_type VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE course_modules (
  course_id INTEGER NOT NULL,
  module_id INTEGER NOT NULL,
  PRIMARY KEY (module_id, course_id),
  FOREIGN KEY (module_id) REFERENCES modules(id),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE program_modules (
  program_id INTEGER NOT NULL,
  module_id INTEGER NOT NULL,
  PRIMARY KEY (program_id, module_id),
  FOREIGN KEY (program_id) REFERENCES programs(id),
  FOREIGN KEY (module_id) REFERENCES modules(id)
);

CREATE TABLE users (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255),
  email VARCHAR(255),
  password_hash VARCHAR(255),
  role ENUM('студент', 'учитель', 'админ') NOT NULL,
  FOREIGN KEY (teaching_group_id) REFERENCES teaching_groups (id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  deleted_at BOOLEAN DEFAULT FALSE
);

CREATE TABLE teaching_groups (
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
  paid_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE program_completions  (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (program_id) REFERENCES programs(id),
  status ENUM('active', 'completed', 'pending', 'cancelled') NOT NULL,
  started_at TIMESTAMP,
  completed_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE certificates (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (program_id) REFERENCES programs(id),
  url VARCHAR(255),
  issued_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE quizzes (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id),
  title VARCHAR(255),
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
  FOREIGN KEY (user_id) REFERENCES users(id),
  text TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE blogs (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES users(id),
  title TEXT,
  content TEXT,
  status ENUM('created', 'in moderation', 'published', 'archived') NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);