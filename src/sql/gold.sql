DROP TABLE IF EXISTS fact_reddit_gold cascade;
DROP TABLE IF EXISTS dim_reddit_gold_author cascade;
DROP TABLE IF EXISTS dim_reddit_gold_date cascade;

create table dim_reddit_gold_author(
author_id serial primary key,
author_name varchar(100),
over18 bool
);

create table dim_reddit_gold_date(
date_id serial primary key,
created_utc timestamp,
year_date int,
month_date int
);

create table fact_reddit_gold(
post_id varchar(20) primary key,
author_id int,
date_id int,
title varchar(1000),
score int,
url varchar(500),
num_comments int,
upvote_percentage float,
constraint author_key foreign key(author_id) references dim_reddit_gold_author,
constraint date_key foreign key(date_id) references dim_reddit_gold_date
);
