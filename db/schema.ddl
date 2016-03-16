create table characters (
  name varchar(64) not null,
  shortname varchar(64) primary key,
  base_class varchar(64),
  heart_class varchar(64),
  alt_heart_class varchar(64),
  prepromote varchar(64)
);
  
create table classes (
  name varchar(64),
  shortname varchar(64) primary key
);

create table friendship_sets (
  character varchar(64) not null,
  support_character varchar(64) not null,
  class varchar(64)
);
  
create table partner_sets (
  character varchar(64) not null,
  support_character varchar(64) not null,
  class varchar(64)
);

create table parent_sets (
  character varchar(64) not null,
  support_character varchar(64) not null,
  class varchar(64)
);


create table characters_to_skills (
  character varchar(64) not null,
  skill varchar(64) not null
);

create table classes_to_skills(
  level integer not null,
  class varchar(64) not null,
  skill varchar(64) not null
);

create table skills (
  name varchar(64),
  shortname varchar(64),
  description varchar(256)
);

create table classes_to_weapons (
  class varchar(64) not null,
  weapon varchar(64) not null
);

create table weapons (
  name varchar(64),
  shortname varchar(64)
);

create table classes_to_promotions (
  class varchar(64) not null,
  promotion varchar(64) not null
);