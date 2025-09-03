select * from (
    SELECT 
        id,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY created_utc) AS id_check
    FROM reddit_bronze
)t
WHERE id_check = 1;

select trim(title) from reddit_bronze
select coalesce(score,0) from reddit_bronze
select coalesce(num_comments,0) from reddit_bronze
select coalesce(upvote_percentage,0) from reddit_bronze
SELECT COALESCE(NULLIF(TRIM(author), ''), 'Unknown') AS cleaned_author FROM reddit_bronze;

select author , row_name from(
select * , row_number() over (partition by author order by created_utc) as row_name from reddit_bronze)t
where row_name =1
