-- create a view with the top artists in 2017
CREATE VIEW top_artists_2017 AS
SELECT artist_title.artist FROM artist_title
INNER JOIN top_15_2017
ON artist_title.reviewid = top_15_2017.reviewid;



--create view for top genres by review count
CREATE VIEW top_genres_by_reviews AS 
SELECT genres.genre AS "Genre", COUNT(reviews.reviewid) AS "Review COUNT" FROM 
genres
LEFT JOIN
reviews 
ON genres.reviewid = reviews.reviewid
WHERE Genre IS NOT null 
GROUP BY genres.genre
ORDER BY genres.genre DESC 


--create view for top 10 artists by review count for each year 
CREATE OR REPLACE VIEW ranked_artists_y AS 
with ranked_artists AS (
SELECT pub_year, artist, COUNT(reviewid) "Review COUNT",
ROW_NUMBER() OVER(
    partition by pub_year
    order by count(reviewid) DESC ) row_num
from reviews 
group by pub_year, artist ) 
select pub_year, artist, "Review Count", row_num
from ranked_artists
where row_num between 1 and 10 