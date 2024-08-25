CREATE TABLE Lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    content TEXT,
    video_link VARCHAR(255),
    position INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    course_id BIGINT REFERENCES Courses (id),
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE Courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    module_id BIGINT REFERENCES modules (id),
    name VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE Modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    content VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    price NUMERIC,
    type VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE ModuleCourse (
  module_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL,
  PRIMARY KEY (module_id, course_id),
  FOREIGN KEY (module_id) REFERENCES Modules(id),
  FOREIGN KEY (course_id) REFERENCES Courses(id)
);

CREATE TABLE ProgramModule (
  program_id INTEGER NOT NULL,
  module_id INTEGER NOT NULL,
  PRIMARY KEY (program_id, module_id),
  FOREIGN KEY (program_id) REFERENCES Programs(id),
  FOREIGN KEY (module_id) REFERENCES Modules(id)
);

CREATE TABLE Users (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  user_role ENUM('студент', 'учитель', 'админ') NOT NULL,
  full_name VARCHAR(255),
  email VARCHAR(255),
  password_hash VARCHAR(255),
  FOREIGN KEY (teaching_group_id) REFERENCES TeachingGroups (id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE TeachingGroups (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  slug VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE Enrollments (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (programs_id) REFERENCES Programs(id),
  status ENUM('active', 'pending', 'cancelled', 'completed') NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE Payments (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (enrollment_id) REFERENCES Enrollments(id),
  amount NUMERIC,
  status ENUM('pending', 'paid', 'failed', 'refunded') NOT NULL,
  date TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE ProgramCompletions (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (programs_id) REFERENCES Programs(id),
  status ENUM('active', 'completed', 'pending', 'cancelled') NOT NULL,
  start_at TIMESTAMP,
  end_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE TABLE Certificates (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (programs_id) REFERENCES Programs(id),
  url VARCHAR(255),
  release_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);