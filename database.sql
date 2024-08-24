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