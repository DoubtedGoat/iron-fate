create table characters (
  id integer primary key autoincrement,
  name varchar(64) not null,
  shortname varchar(64),
  base_class_id integer,
  heart_class_id integer,
  alt_heart_class_id integer,
  prepromote_id integer
);
  
create table classes (
  id integer primary key autoincrement,
  name varchar(64),
  shortname varchar(64)
);

create table friendship_sets (
  id integer primary key autoincrement,
  character_id integer not null,
  support_character_id integer not null,
  class_id integer
);
  
create table partner_sets (
  id integer primary key autoincrement,
  character_id integer not null,
  support_character_id integer not null,
  class_id integer
);

create table parent_sets (
  id integer primary key autoincrement,
  character_id integer not null,
  support_character_id integer not null,
  class_id integer
);


create table characters_to_skills (
  id integer primary key autoincrement,
  character_id integer not null,
  skill_id integer not null
);

create table classes_to_skills(
  id integer primary key autoincrement,
  level integer not null,
  class_id not null,
  skill_id integer not null
);

create table skills (
  id integer primary key autoincrement,
  name varchar(64),
  shortname varchar(64),
  description varchar(256)
);

create table classes_to_weapons (
  id integer primary key autoincrement,
  class_id integer not null,
  weapon_id integer not null
);

create table weapons (
  id integer primary key autoincrement,
  name varchar(64),
  shortname varchar(64)
);

create table classes_to_promotions (
  id integer primary key autoincrement,
  class_id integer not null,
  promotion_id integer not null
);