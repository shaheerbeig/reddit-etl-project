DROP TABLE IF EXISTS reddit_silver;
create table reddit_silver(
user_id varchar(20) ,
title varchar(1000),
created_utc TIMESTAMP,
month_post int,
score int,
author_id int,
url varchar(500),
num_comments int,
upvote_percentage float
);

DROP TABLE IF EXISTS reddit_silver_author;
CREATE TABLE reddit_silver_author(
    author_id SERIAL,                     
    author_name VARCHAR(100),     
    over18 BOOL
);
