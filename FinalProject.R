library(tidyverse)
spotify <- read.csv('spotify_songs.csv')

# lowercase, trim, and remove punctuation from each character field
spotify <- spotify %>%
  mutate(across(where(is.character), ~ str_trim(str_to_lower(gsub("[[:punct:]]", "", .)))))

# Check missing
colSums(is.na(spotify))

# Replace or remove missing values (depending on importance)
spotify <- spotify %>%
  filter(!is.na(track_artist), !is.na(track_name), !is.na(track_album_name))

# Ensure values are in valid ranges
spotify <- spotify %>%
  filter(
    between(track_popularity, 0, 100),
    between(loudness, -60, 0),
    between(danceability, 0, 1),
    between(energy, 0, 1),
    between(speechiness, 0, 1),
    between(acousticness, 0, 1),
    between(instrumentalness, 0, 1),
    between(liveness, 0, 1),
    between(valence, 0, 1),
    tempo > 0,
    duration_ms > 0,
    key >= -1 & key <= 11,
    mode %in% c(0, 1)
  )

colSums(is.na(spotify))

# Create new features
spotify <- spotify %>%
  mutate(duration_min = duration_ms / 60000)

#filter out sounds or jingles
spotify <- spotify %>%
  filter(duration_ms >= 30000)

# Normalize the date column to always start with 4-digit year
spotify <- spotify %>%
  mutate(
    album_release_year = str_extract(track_album_release_date, "^\\d{4}"),  # extract 4-digit year
    album_release_year = as.integer(album_release_year)  # convert to integer
  ) %>%
  select(-track_album_release_date)  # drop original column if no longer needed

#round instrumentalness
spotify <- spotify %>%
  mutate(instrumentalness = round(instrumentalness, 3))

#cleaned data
music_clean <- spotify

# genre vs popularity
music_clean %>%
  group_by(playlist_genre) %>%
  summarise(avg_popularity = mean(track_popularity, na.rm = TRUE)) %>%
  ggplot(aes(x = reorder(playlist_genre, -avg_popularity), y = avg_popularity)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Average Popularity by Genre", x = "Genre", y = "Avg Popularity") +
  theme_minimal() +
  coord_flip()

#energy vs popularity
ggplot(music_clean, aes(x = energy, y = track_popularity, color = playlist_genre)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = "Energy vs. Popularity", x = "Energy", y = "Track Popularity") +
  theme_minimal()

#danceability vs popularity
ggplot(music_clean, aes(x = danceability, y = track_popularity)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = "Danceability vs. Popularity", x = "Danceability", y = "Popularity") +
  theme_minimal()

#loudness vs popularity
music_clean$loudness_bin <- cut(music_clean$loudness,
                                breaks = c(-60, -50, -40, -30, -20, -10, 0),
                                labels = c("Very Quiet", "Quiet", "Slightly Quiet", "Average", "Slightly Loud", "Loud"),
                                include.lowest = TRUE)

avg_popularity <- music_clean %>%
  group_by(loudness_bin) %>%
  summarise(avg_pop = mean(track_popularity, na.rm = TRUE))

ggplot(avg_popularity, aes(x = loudness_bin, y = avg_pop, fill = loudness_bin)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Track Popularity by Loudness Category",
       x = "Loudness Category",
       y = "Average Popularity") +
  theme_minimal()

#tempo by popularity
music_clean$popularity_quartile <- ntile(music_clean$track_popularity, 4)

ggplot(music_clean, aes(x = as.factor(popularity_quartile), y = tempo)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Tempo Across Popularity Quartiles", x = "Popularity Quartile", y = "Tempo (BPM)") +
  theme_minimal()

#popularity over time
music_clean %>%
  group_by(album_release_year) %>%
  summarise(avg_popularity = mean(track_popularity, na.rm = TRUE)) %>%
  ggplot(aes(x = album_release_year, y = avg_popularity)) +
  geom_line(color = "darkred") +
  labs(title = "Average Track Popularity by Year", x = "Year", y = "Avg Popularity") +
  theme_minimal()

#instrument popularity
music_clean$Intru_bin <- cut(music_clean$instrumentalness,
                             breaks = c(0, 0.5, 1),
                             labels = c("Vocal", "Instrumental"),
                             include.lowest = TRUE)

avg_popularity <- music_clean %>%
  group_by(Intru_bin) %>%
  summarise(avg_pop = mean(track_popularity, na.rm = TRUE))

ggplot(avg_popularity, aes(x = Intru_bin, y = avg_pop, fill = Intru_bin)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Track Popularity by Song Type",
       x = "Type",
       y = "Average Popularity") +
  theme_minimal()

#Speechiness vs popularity
music_clean$speech_bin <- cut(music_clean$speechiness,
                             breaks = c(0, 0.33, .66, 1),
                             labels = c("No Words", "Mix", "No Music"),
                             include.lowest = TRUE)

avg_popularity <- music_clean %>%
  group_by(speech_bin) %>%
  summarise(avg_pop = mean(track_popularity, na.rm = TRUE))

ggplot(avg_popularity, aes(x = speech_bin, y = avg_pop, fill = speech_bin)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Track Popularity by Instrument Category",
       x = "Instrument Category",
       y = "Average Popularity") +
  theme_minimal()
