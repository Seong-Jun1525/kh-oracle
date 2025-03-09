-- Developer 테이블
CREATE TABLE Developer (
    dev_id NUMBER PRIMARY KEY,
    dev_name VARCHAR2(100) NOT NULL,
    dev_job VARCHAR2(50) NOT NULL,
    dev_hp NUMBER DEFAULT 100,
    dev_level NUMBER DEFAULT 1,
    dev_exp NUMBER DEFAULT 0,
    dev_turn NUMBER DEFAULT 1
);

-- Skill 테이블
CREATE TABLE Skill (
    skill_id NUMBER PRIMARY KEY,
    developer_id NUMBER NOT NULL,
    skill_name VARCHAR2(100) NOT NULL,
    skill_exp NUMBER DEFAULT 0,
    skill_level NUMBER DEFAULT 1,
    CONSTRAINT fk_developer FOREIGN KEY (developer_id) REFERENCES Developer(dev_id) ON DELETE CASCADE
);

-- Question 테이블
CREATE TABLE Question (
    id NUMBER PRIMARY KEY,
    question_text VARCHAR2(500) NOT NULL,
    question_hint VARCHAR2(500),
    question_answer NUMBER NOT NULL
);
