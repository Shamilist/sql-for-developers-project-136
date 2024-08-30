CREATE TYPE role AS ENUM ('студент', 'учитель', 'админ');
CREATE TYPE status1 AS ENUM ('active', 'pending', 'cancelled', 'completed');
CREATE TYPE status2 AS ENUM ('pending', 'paid', 'failed', 'refunded');
CREATE TYPE status3 AS ENUM ('created', 'in moderation', 'published', 'archived');


CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at BOOLEAN DEFAULT FALSE
);

CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at BOOLEAN DEFAULT FALSE
);

CREATE TABLE course_modules (
  course_id BIGINT REFERENCES courses(id) NOT NULL,
  module_id BIGINT REFERENCES modules(id),
  PRIMARY KEY (module_id, course_id)
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id BIGINT REFERENCES courses (id),
    name VARCHAR(255),
    content TEXT,
    video_url VARCHAR(255),
    position INT,
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

CREATE TABLE program_modules (
  program_id BIGINT REFERENCES programs(id) NOT NULL,
  module_id BIGINT REFERENCES modules(id),
  PRIMARY KEY (program_id, module_id)
);

CREATE TABLE teaching_groups (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  slug VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE users (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255),
  email VARCHAR(255),
  password_hash VARCHAR(255),
  role role NOT NULL,
  teaching_group_id BIGINT REFERENCES teaching_groups (id) NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  deleted_at BOOLEAN DEFAULT FALSE
);

CREATE TABLE enrollments (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_id BIGINT REFERENCES users(id) NOT NULL,
  program_id BIGINT REFERENCES programs(id) NOT NULL,
  status status1 NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE payments (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  enrollment_id BIGINT REFERENCES enrollments(id) NOT NULL,
  amount NUMERIC,
  status status2 NOT NULL,
  paid_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE program_completions  (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_id BIGINT REFERENCES users(id) NOT NULL,
  program_id BIGINT REFERENCES programs(id) NOT NULL,
  status status1 NOT NULL,
  started_at TIMESTAMP,
  completed_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE certificates (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_id BIGINT REFERENCES users(id) NOT NULL,
  program_id BIGINT REFERENCES programs(id) NOT NULL,
  url VARCHAR(255),
  issued_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE quizzes (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
  name VARCHAR(255),
  content TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE exercises (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
  name VARCHAR(255),
  url VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE discussions (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
  user_id BIGINT REFERENCES users(id) NOT NULL,
  text TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE blogs (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_id BIGINT REFERENCES users(id) NOT NULL,
  name TEXT,
  content TEXT,
  status status3 NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);