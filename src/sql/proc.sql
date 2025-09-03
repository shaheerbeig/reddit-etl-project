CREATE OR REPLACE PROCEDURE silver_reddit_post()
LANGUAGE plpgsql
AS $$
begin

	truncate table reddit_silver_author;
	truncate table reddit_silver;
	
    INSERT INTO reddit_silver_author(author_name, over18)
    SELECT DISTINCT b.author, b.over18
    FROM reddit_bronze b
    WHERE b.author IS NOT NULL;
	
	INSERT INTO reddit_silver(user_id, title, created_utc, month_post, score, author_id, url, num_comments, upvote_percentage)
	    SELECT 
	        b.id AS post_id,
	        TRIM(b.title),
	        TO_TIMESTAMP(b.created_utc),
	        EXTRACT(MONTH FROM TO_TIMESTAMP(b.created_utc)) AS month_num,
	        COALESCE(b.score, 0),
	        a.author_id,
	        b.url,
	        COALESCE(b.num_comments, 0),
	        COALESCE(b.upvote_percentage, 0)
	    FROM (
	        SELECT *,
	               ROW_NUMBER() OVER (PARTITION BY id ORDER BY created_utc) AS id_check
	        FROM reddit_bronze
	    ) b
	    JOIN reddit_silver_author a 
	      ON a.author_name = b.author
	    WHERE b.id_check = 1;	
end
$$
