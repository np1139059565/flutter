/*https://blog.csdn.net/weixin_46089363/article/details/124651702*/
/*************************create*****************************/
drop database if exists reward_app;
create database reward_app;

use reward_app;

drop table if exists all_user;
create table all_user(
    uid int primary key auto_increment,
    user char(20) not null,
    pwd char(33) not null,/*使用md5加密*/
    createtime datetime default current_timestamp(0) on update current_timestamp(0));

drop table if exists all_job;
create table all_job(
    id int primary key auto_increment,
    uid int,
    title char(80) not null,
    money decimal(10,2),
    job_type char(40),
    system_type char(40),
	max_used_seconds int,
    avg_used_seconds int,
    success_count int,
    total_count int,
    avg_check_seconds int,
	max_check_seconds int,
    success_ratio decimal(4,2),
    job_tip char(100) not null default '',
    steps varchar(4000));

drop table if exists order_job;
create table order_job(
    job_id int not null,
    uid int not null,
    job_status char(3) not null,
    order_time datetime not null);

drop table if exists publishing_job;
create table publishing_job(
    job_id int not null,
    uid int not null,
    publishing_time datetime not null);

/**********************insert*****************************/
insert into all_user(user,pwd) values('admin','0192023a7bbd73250516f069df18b500');/*admin,admin123*/

insert into all_job values(
	0,
    1,
    '微信扫一扫',
    round(rand()*10,2),
    '浏览|外卖省优',
    '安卓 苹果',
	round(rand()*600,0),
    round(rand()*180,0),
    round(rand()*100,0),
    round(rand()*150,0),
    round(rand()*60,0),
	round(rand()*180,0),
    round(success_count/total_count,2),
    '限首次领取即可!',
    '[{"title":"微信扫码入群,进入 群公告 点击链接领取!","type":"image","value":"/title.png"},{"title":"这种不合格,不要提交","type":"copy","value":"https://www.baidu.com"},{"title":"领取之前必须和此图一样!","type":"input","value":""}]');

insert into all_job(uid,
    title,
    money,
    job_type,
    system_type,
    avg_used_seconds,
	max_used_seconds,
    success_count,
    total_count,
    avg_check_seconds,
	max_check_seconds,
    success_ratio,
    job_tip,
    steps) select uid,
      title,
      round(rand()*10,2),
      job_type,
      system_type,
      round(rand()*600,0),
      round(rand()*180,0),
      round(rand()*100,0),
      round(rand()*150,0),
      round(rand()*60,0),
      round(rand()*180,0),
      round(success_count/total_count,2),
      job_tip,
      steps from all_job;
insert into all_job(uid,
    title,
    money,
    job_type,
    system_type,
    avg_used_seconds,
	max_used_seconds,
    success_count,
    total_count,
    avg_check_seconds,
	max_check_seconds,
    success_ratio,
    job_tip,
    steps) select uid,
      title,
      round(rand()*10,2),
      job_type,
      system_type,
      round(rand()*600,0),
      round(rand()*180,0),
      round(rand()*100,0),
      round(rand()*150,0),
      round(rand()*60,0),
      round(rand()*180,0),
      round(success_count/total_count,2),
      job_tip,
      steps from all_job;
insert into all_job(uid,
    title,
    money,
    job_type,
    system_type,
    avg_used_seconds,
	max_used_seconds,
    success_count,
    total_count,
    avg_check_seconds,
	max_check_seconds,
    success_ratio,
    job_tip,
    steps) select uid,
      title,
      round(rand()*10,2),
      job_type,
      system_type,
      round(rand()*600,0),
      round(rand()*180,0),
      round(rand()*100,0),
      round(rand()*150,0),
      round(rand()*60,0),
      round(rand()*180,0),
      round(success_count/total_count,2),
      job_tip,
      steps from all_job;
insert into all_job(uid,
    title,
    money,
    job_type,
    system_type,
    avg_used_seconds,
	max_used_seconds,
    success_count,
    total_count,
    avg_check_seconds,
	max_check_seconds,
    success_ratio,
    job_tip,
    steps) select uid,
      title,
      round(rand()*10,2),
      job_type,
      system_type,
      round(rand()*600,0),
      round(rand()*180,0),
      round(rand()*100,0),
      round(rand()*150,0),
      round(rand()*60,0),
      round(rand()*180,0),
      round(success_count/total_count,2),
      job_tip,
      steps from all_job;


-- 日期加减 https://blog.csdn.net/qq_46416934/article/details/124004542
insert into order_job select id,uid,
case when (id+uid)%3=0 then '未提交'
 when (id+uid)%4=0 then '审核中'
 when (id+uid)%5=0 then '已通过'
 else '未通过' end as job_status,date_add(now(),interval -round(rand()*10,0) minute) as order_time from all_job where id%5=0;

insert into publishing_job select id,uid,date_add(now(),interval -round(rand()*10,0) minute) as publishing_time from all_job where id%4=0;







