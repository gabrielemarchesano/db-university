/* SELECT QUERY */

/* 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT *
FROM `students`
WHERE year(`date_of_birth`) = 1990;
*/

/* 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT *
FROM `courses`
WHERE `cfu` > 10;
*/

/* 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT *
FROM `students`
WHERE year(current_date()) - year(`date_of_birth`) > 30;
*/

/* 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT *
FROM `courses`
WHERE `period` = "I semestre" AND `year`= 1;
*/

/* 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT *
FROM `exams`
WHERE `date` = "2020-06-20" AND hour(`hour`) >= 14;
*/

/* 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT *
FROM `degrees`
WHERE `name` LIKE "% Laurea Magistrale %";
*/

/* 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(id)
FROM `departments`;
*/

/* 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT count(id)
FROM `teachers`
WHERE `phone`IS NULL;
*/

/*********************/

/* GROUP BY QUERY */

/* 1. Contare quanti iscritti ci sono stati ogni anno
SELECT count(id), year(`enrolment_date`)
FROM `students`
GROUP BY year(`enrolment_date`);
*/

/* 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT count(id), `office_address`
FROM `teachers`
GROUP BY `office_address`;
*/

/* 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id`, avg(vote) AS `votes_average`
FROM `exam_student`
GROUP BY `exam_id`;
*/

/* 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT `department_id`, `name`, count(id)
FROM `degrees`
GROUP BY `department_id`;
*/

/*********************/


/* JOIN (lezione)*/

/* 1. Selezionare tutti i "corsi" del "Corso di Laurea" in Informatica(22) 
SELECT *
FROM `courses`.`id` AS `coursesId`, `courses`.`cfu`, `courses`.`description`, `courses`.`period`, `courses`.`website`, `degrees`.`name`
JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Informatica";
*/

/* 2. Selezionare le informazioni sul corso con id = 144, con tutti i relativi appelli d’esame 
SELECT `courses`.`id` AS `courseId`, `exams`.`id` AS `examId`, `courses`.`name`, `courses`.`cfu`, `exams`.`date`, `exams`.`hour`, `exams`.`location`, `exams`.`address`
FROM `courses`
JOIN `exams` ON `exams`.`course_id` = `courses`.`id`
WHERE `courses`.`id` = 144
*/

/* 3. Selezionare a quale dipartimento appartiene il Corso di Laurea in Diritto dell'Economia 
(Dipartimento di Scienze politiche, giuridiche e studi internazionali)
SELECT `departments`.`name` AS `departmentName`, `departments`.`address` AS `departmentsAddress`, `departments`.`phone`, `departments`.`head_of_department`,
`degrees`.`name`
FROM `departments`
JOIN `degrees` ON `degrees`.`department_id` = `departments`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Diritto dell'Economia"
*/

/* 4. Selezionare tutti gli appelli d'esame del Corso di Laurea Magistrale in Fisica del primo anno
#tables: exams, courses, degrees
SELECT degrees.name AS degree_name, courses.name AS course_name, courses.period, courses.year, courses.cfu, exams.date, exams.hour, exams.location
FROM degrees
JOIN courses ON courses.degree_id = degrees.id
JOIN exams ON exams.course_id = courses.id
WHERE degrees.name = "Corso di Laurea Magistrale in Fisica" AND courses.year = 1
*/

/* 5. Selezionare tutti i docenti che insegnano nel Corso di Laurea in Lettere (21)
#tables: teachers, course_teacher, courses, degrees
SELECT DISTINCT teachers.name, teachers.surname, teachers.phone, teachers.office_address
FROM teachers
JOIN course_teacher ON course_teacher.teacher_id = teachers.id
JOIN courses ON course_teacher.course_id = courses.id
JOIN degrees ON courses.degree_id = degrees.id
WHERE degrees.name = "Corso di Laurea in Lettere"
*/

/* 6. Selezionare il libretto universitario di Mirco Messina (matricola n. 620320)
#tables: students, courses, exams, exam_student
SELECT students.name, students.surname, students.registration_number, courses.name AS courses_name, exam_student.vote
FROM students
JOIN exam_student ON exam_student.student_id = students.id
JOIN exams ON exam_student.exam_id = exams.id
JOIN courses ON exams.course_id = courses.id
WHERE students.name = "Mirco" AND students.surname = "Messina" AND exam_student.vote >= 18
*/

/* 7. Selezionare il voto medio di superamento d'esame per ogni corso, 
con anche i dati del corso di laurea associato, ordinati per media voto decrescente 
#tables: exam_student, exams, courses, degrees
SELECT round(avg(exam_student.vote), 2) AS votes_average, courses.name AS courses_name, degrees.name AS degrees_name
FROM exam_student
JOIN exams ON exam_student.exam_id = exams.id
JOIN courses ON exams.course_id = courses.id
JOIN degrees ON courses.degree_id = degrees.id
WHERE exam_student.vote >= 18
GROUP BY courses.id
ORDER BY votes_average
*/

/********************/

/* JOIN QUERY */

/* 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia 
#tables: students, degrees
SELECT `students`.`name` AS `student_name`, `students`.`surname` AS `student_surname`, `degrees`.`name` AS `degree_name`
FROM `students`
JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia";
*/

/* 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
#tables: degrees, departments
SELECT `degrees`.`name` AS `degree_name`, `degrees`.`level`, `departments`.`name` AS `department_name`
FROM `degrees`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE `degrees`.`level` = "magistrale" AND `departments`.`name` = "Dipartimento di Neuroscienze"
*/

/* 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
#tables: teachers, course_teacher, courses
SELECT `teachers`.`name` AS `teacher_name`, `teachers`.`surname` AS `teacher_surname`, `course_id`, `courses`.`degree_id`, `courses`.`name` AS `course_name`
FROM `teachers`
JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id`
JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
WHERE `teachers`.`name` = "Fulvio" AND `teachers`.`surname` = "Amato"
*/

/* 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome 
#tables: students, degrees, departments
SELECT `students`.`surname`AS `student_surname`, `students`.`name` AS `student_name`, `degrees`.`name` AS `degree_name`, `departments`.`name` AS `department_name`
FROM `students`
JOIN `degrees`ON `students`.`degree_id` = `degrees`.`id`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
ORDER BY `student_surname`
*/

/* 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
#tables: teachers, course_teacher, courses, degrees
SELECT `degrees`.`name` AS `degree_name`, `courses`.`name` AS `course_name`, `teachers`.`surname` AS `teacher_surname`, `teachers`.`name` AS `teacher_name`
FROM `teachers`
JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id`
JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `degrees`ON `courses`.`degree_id` = `degrees`.`id`
*/

/* 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
#tables: teachers, course_teacher, courses, degrees, departments
SELECT DISTINCT `teachers`.`surname` AS `teacher_surname`, `teachers`.`name` AS `teacher_name`, `teachers`.`id`, `departments`.`name` AS `department_name`
FROM `teachers`
JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id`
JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = "Dipartimento di Matematica"
*/