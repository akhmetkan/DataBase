------------------------1-task-----------------------
--------------------------a--------------------------
select title from course
where credits >= 3;
--------------------------b--------------------------
select room_number from classroom
where building = 'Watson' or building = 'Packard';
--------------------------c--------------------------
select title from course
where dept_name = 'Comp. Sci.';
--------------------------d--------------------------
select title from course c, teaches t
where t.semester = 'Fall' and c.course_id = t.course_id;
--------------------------e--------------------------
select name from student
where tot_cred between 45 and 90;
--------------------------f--------------------------
select name from student
where name ~* '[aewiuoy]$';
--------------------------g--------------------------
select title from course c, prereq p
where c.course_id = p.course_id and p.prereq_id = 'CS-101';
-------------------------2-task----------------------
--------------------------a--------------------------
select dept_name, avg(salary) AS avg_salary from instructor
group by dept_name
ORDER BY avg_salary;
--------------------------b--------------------------
SELECT d.building,count(1) FROM department d,course c
WHERE d.dept_name = c.dept_name
GROUP BY d.building
HAVING count(1)=(SELECT MAX(second.number) FROM
(SELECT count(1) as number FROM department,course
WHERE department.dept_name = course.dept_name
group by department.building) as second);
--------------------------c--------------------------
select d.dept_name, count(1) from department d, course c
where d.dept_name = c.dept_name
group by d.dept_name
having count(1) = (select min(second.number) from
(select count(1) as number from department d, course c
where d.dept_name = c.dept_name
group by d.dept_name) as second);
--------------------------d--------------------------
SELECT DISTINCT s.id,s.name FROM student s
WHERE s.id IN (SELECT third.id FROM
(SELECT student.id, count(1) as number
FROM student,takes,course
WHERE student.id=takes.id and takes.course_id=course.course_id
and course.dept_name='Comp. Sci.' group by student.id)as third
WHERE third.number>3);
--------------------------e--------------------------
select name from instructor
where dept_name = 'Philosophy' or dept_name = 'Music' or dept_name = 'Biology';
--------------------------f--------------------------
select distinct i.id, i.name from instructor i, teaches t
where i.id = t.id and  t.year = 2018 and
      t.id not in (select distinct i.id from instructor i, teaches t
                    where i.id = t.id and t.year = 2017);
-------------------------3-task----------------------
--------------------------a--------------------------
select s.name from student s, takes t
where s.id = t.id and (t.grade = 'A' or t.grade = 'A-') and t.course_id like 'CS%'
group by s.name order by s.name;
--------------------------b--------------------------
select id, name from instructor
where id in (select a.i_id from advisor a, student s, takes t
    where a.s_id = s.id and t.id = s.id and
    (t.grade != 'A' and t.grade != 'A-' and t.grade != 'B+' and t.grade != 'B' or t.grade is NULL));
--------------------------c--------------------------
select distinct s.dept_name from student s, takes t
where s.id = t.id and s.dept_name not in
                      (select s.dept_name from takes t, student s
                          where t.id = s.id and (grade = 'F' or grade = 'C'));
--------------------------d--------------------------
select id, name from instructor
where id not in (select i.id from instructor i, advisor a, takes t
    where i.id = a.i_id and a.s_id = t.id and t.grade = 'A');

select id, name from instructor
where id not in (select i.id from instructor i, teaches te, takes t
    where i.id = te.id and te.course_id = t.course_id and t.grade = 'A');
--------------------------e--------------------------
select distinct c.title from course c, section s, time_slot t
where c.course_id = s.course_id and s.time_slot_id = t.time_slot_id and t.end_hr <= 13;