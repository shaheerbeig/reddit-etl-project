CREATE OR REPLACE PROCEDURE gold_reddit_post()
LANGUAGE plpgsql
AS $$
begin

	TRUNCATE TABLE fact_reddit_gold, dim_reddit_gold_author, dim_reddit_gold_date 
	RESTART IDENTITY CASCADE;
	
    INSERT INTO dim_reddit_gold_author(author_name, over18)
    SELECT DISTINCT author_name, over18
    FROM reddit_silver_author 
    WHERE author_name IS NOT NULL;

    INSERT INTO dim_reddit_gold_date (created_utc, year_date, month_date)
    SELECT 
    rs.created_utc,
    EXTRACT(YEAR FROM (rs.created_utc)) AS year_num,
    EXTRACT(MONTH FROM (rs.created_utc)) AS month_num
    FROM reddit_silver rs
    WHERE created_utc IS NOT NULL;
	
	INSERT INTO fact_reddit_gold(post_id,author_id,date_id,title,score,url,num_comments,upvote_percentage)
	SELECT
    rs.user_id,
    rga.author_id,
    rgd.date_id,
    rs.title,
    rs.score,
    rs.url,
    rs.num_comments,
    rs.upvote_percentage
    FROM reddit_silver rs
	JOIN reddit_silver_author sa 
    ON rs.author_id = sa.author_id
	JOIN dim_reddit_gold_author rga 
    ON sa.author_name = rga.author_name
	JOIN dim_reddit_gold_date rgd 
    ON rs.created_utc = rgd.created_utc
	WHERE rs.created_utc IS NOT NULL;
end
$$









