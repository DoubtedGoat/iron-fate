pragma foreign_keys = on;

create table characters (
  id integer primary key autoincrement,
  name varchar(64) not null,
  base_class_id integer,
    foreign key(base_class_id) references classes(id),
  heart_class_id integer,
    foreign key(heart_class_id) references classes(id),
  alt_heart_class_id integer,
    foreign key(alt_heart_class_id) references classes(id),
  prepromote_id integer,
    foreign key(prepromote_id) references classes(id)
);
  
create table classes (
  id integer primary key autoincrement,
  name varchar(64)
);

create table friendship_sets (
  id integer primary key autoincrement,
  character_id integer not null,
    foreign key(character_id) references characters(id),
  support_character_id integer not null,
    foreign key(support_character_id) references characters(id),
  class_id integer,
    foreign key(class_id) references classes(id)
);
  
create table partner_sets (
  id integer primary key autoincrement,
  character_id integer not null,
    foreign key(character_id) references characters(id),
  support_character_id integer not null,
    foreign key(support_character_id) references characters(id),
  class_id integer,
    foreign key(class_id) references classes(id)
);

create table parent_sets (
  id integer primary key autoincrement,
  character_id integer not null,
    foreign key(character_id) references characters(id),
  support_character_id integer not null,
    foreign key(support_character_id) references characters(id),
  class_id integer,
    foreign key(class_id) references classes(id)
);


create table characters_to_skills (
  id integer primary key autoincrement,
  character_id integer not null,
    foreign key(character_id) references characters(id),
  skill_id integer not null,
    foreign key(skill_id) references skills(id)
);

create table classes_to_skills (
  id integer primary key autoincrement,
  level integer not null,
  classes_id not null,
    foreign key(classes_id) references classes(id),
  skill_id integer not null
    foreign key(skill_id) references skills(id)
);

create table skills (
  id integer primary key autoincrement,
  name varchar(64),
  description varchar(256)
);