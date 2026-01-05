# Most Popular Spotify Songs Analysis

**Author:** Robert Mahoney  
**Date:** May 5, 2025  
**Course:** CIS366.NO1  
**Instructor:** Jiaying Liu  

---

## Overview
This project analyzes what makes songs popular on Spotify. Using a dataset of Spotify tracks, the goal is to identify which musical characteristics—such as danceability, energy, valence, and loudness—are most strongly associated with high popularity scores.  

Through data cleaning, exploration, and visualization, the analysis uncovers patterns that explain listener preferences and provides insights useful for artists, producers, and marketers.  

---

## Key Features
- Data cleaning and transformation using R packages
- Exploratory Data Analysis (EDA) to uncover trends in track popularity
- Visualizations highlighting key insights
- Reproducible scripts for analysis

---

## Packages Used
- **tidyverse**: Core data manipulation and visualization (dplyr, ggplot2, readr)  
- **lubridate**: Handling and normalizing dates  
- **stringr**: Cleaning and formatting character strings  

---

## Data Preparation
- Dataset: `spotify_songs.csv`  
- Original dataset contained 23 variables (track metadata, audio features, playlist info)  
- Removed rows with missing values in key fields (`track_name`, `track_artist`, `track_album_name`)  
- Standardized dates by creating a `release_year` column  
- Converted `duration_ms` to `duration_min` and removed songs under 30 seconds  
- Cleaned character fields for consistency (lowercase, removed whitespace/punctuation)  
- Formatted numeric values for clarity (rounded to 3 digits, corrected scientific notation)  
- Verified numeric fields align with expected ranges  

---

## Dataset Summary

| Variable | Type | Summary |
|----------|------|---------|
| track_id | Character | Unique identifier |
| track_name | Character | Name of the track |
| track_artist | Character | Performing artist |
| track_popularity | Numeric | 0–100 (Mean: 42.5) |
| track_album_name | Character | Album name |
| playlist_name | Character | Playlist name |
| playlist_genre | Character | Genre category |
| danceability | Numeric | 0.077–0.983 (Mean: 0.655) |
| energy | Numeric | 0.0002–1.0 (Mean: 0.699) |
| loudness | Numeric | -46.45–-0.05 dB (Mean: -6.72) |
| valence | Numeric | 0.00001–0.991 (Mean: 0.511) |
| … | … | … |

*(Full variable summary available in project scripts)*  

---

## Exploratory Data Analysis
Eight research questions guided the analysis:

1. **Danceability vs. Popularity:** Slight upward trend; more danceable tracks are slightly more popular.  
2. **Energy Levels:** Higher energy tracks are less likely to be popular.  
3. **Loudness:** Slight negative correlation; quieter tracks slightly more popular.  
4. **Valence (Positivity):** Vocal tracks more popular than instrumental-only tracks.  
5. **Genre Analysis:** Pop and Latin genres dominate in popularity.  
6. **Popularity Over Time:** Slight decline until post-2015, where popularity increases, likely due to streaming trends.  
7. **Tempo:** No significant effect on popularity.  
8. **Speechiness:** Popular tracks generally have lower speechiness, aligning with Spotify’s musical focus.  

These findings reveal patterns that contribute to a song’s success.  

---

## Insights
- Danceability positively impacts popularity  
- High-energy tracks tend to be less popular  
- Vocal songs outperform instrumental tracks  
- Pop and Latin songs dominate popularity charts  
- Popularity trends have shifted over time with streaming platforms  
- Tempo has little effect  
- Lower speechiness correlates with higher popularity  

---

## Usage
1. Clone the repository  
2. Open `MostPopularSpotifySongs.R` in R or RStudio  
3. Ensure required packages (`tidyverse`, `lubridate`, `stringr`) are installed  
4. Run the script to reproduce the analysis and visualizations  

---

## Presentation
- [Google Slides Presentation](https://drive.google.com/file/d/1ivx7intEQ_CAKTABxpK042pRiCcw7dJ0/view?usp=drive_link)  
