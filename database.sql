CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_name VARCHAR(255),
    course_content VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_name VARCHAR(255),
    lesson_content VARCHAR(255),
    video_link VARCHAR(255),
    lesson_in_course_position INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    course_id BIGINT REFERENCES courses (id)
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    module_name VARCHAR(255),
    module_content VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_name VARCHAR(255),
    program_price NUMERIC,
    program_type VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);