# University DB

## Tables
- subjects
- graduation_courses
- courses
- teachers
- students
- exams

---

### Subjects
- id - PK / BIGINT / AI
- graduation_course_id - FK / BIGINT
- title - VARCHAR(20)
- description - TEXT

### Graduation_courses
- id - PK / BIGINT / AI
- course_id - FK / BIGINT
- student_id - FK / BIGINT
- title - VARCHAR(20)
- description - TEXT

### Courses
- id - PK / BIGINT / AI
- teacher_id - FK / BIGINT
- exam_id - FK / BIGINT
- title - VARCHAR(20)
- description - TEXT

### Teachers
- id - PK / BIGINT / AI
- lastname - VARCHAR(50)
- name - VARCHAR(50)

### Students
- id - PK / BIGINT / AI
- lastname - VARCHAR(50)
- name - VARCHAR(50)

### Exams
- id - PK / BIGINT / AI
- student_id - FK / BIGINT
- title - VARCHAR(20)
- date - DATETIME