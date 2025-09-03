import praw
from dotenv import load_dotenv
import pandas as pd , os
from datetime import datetime
from pathlib import Path

load_dotenv()

CLIENT_ID = os.getenv('REDDIT_CLIENT_ID')
CLIENT_SECRET = os.getenv('REDDIT_CLIENT_SECRET')
USER_AGENT = os.getenv('REDDIT_USER_AGENT')

def extract_reddit(limit ,  subreddit_name):
    base_dir = "/opt/airflow/data"
    bronze_dir = Path(base_dir) / "bronze"
    bronze_dir.mkdir(parents=True, exist_ok=True)

    reddit = praw.Reddit(
        client_id=CLIENT_ID,
        client_secret=CLIENT_SECRET,
        user_agent=USER_AGENT,
    )

    subreddit = reddit.subreddit(subreddit_name)
    posts = []

    for post in subreddit.hot(limit=limit):
        posts.append({
            "id": post.id,
            "created_utc": post.created_utc,
            "title": post.title,
            "score": post.score,
            "author": str(post.author),
            "url": post.url,
            "num_comments": post.num_comments,
            "upvote_percentage":post.upvote_ratio,
            "name":post.subreddit,
            "over18":post.over_18
        })

    df = pd.DataFrame(posts)

    filename = bronze_dir / f"reddit_raw_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
    df.to_csv(filename, index=False)


