# TopWords
iOS app for English and Spanish language learners. Learn the keywords to master the language by playing a poker-style game. Track your progress, strengthen your weaknesses and learn the keywords in no time! Internet is not required. Used stack:
- Mvc
- User defaults
- Core Data
- Core Animation
- SqlLiteStudio
- Dependency Injection


## App Architecture Diagram
![Screen Shot 2022-10-20 at 7 07 14 PM](https://user-images.githubusercontent.com/99278919/197081868-e54f8ea5-8dc6-4dfa-8815-c1177a3f1efd.png)

## Instructions
### 1. Menu
The main menu has 4 buttons:
* Play Cards
* Play Compare
* Score
* Configuration

![Screen Shot 2022-10-21 at 10 51 49 AM](https://user-images.githubusercontent.com/99278919/198082286-0ea510bf-8560-4cc0-a285-27298e47cdbb.png)

From here, the user can access the two games, check the personal score and configure the complexity level of the games.

### 2. Play Cards
To play this game follow these steps:<br /><br />
a. Read the word to translate at the top of the screen. This word can be in English or Spanish<br />
b. Mentally translate the word<br />
c. Tab the card to flip it and see the correct translation<br />
d. Tap the "Thumb up" button if your answer was correct or the "Thumb down" button if not<br />
e. The score is updated and a new word is shown to translate<br />
f. Repeat the steps from point a<br />

![ezgif com-gif-maker (7)](https://user-images.githubusercontent.com/99278919/198085323-f28aabf4-03cc-4c2b-a2f1-8f458b261116.gif)


### 3. Play Compare
Two cards are shown:<br />
* Top card: Shows the word to translate<br />
* Bottom card: Shows the translated word<br /><br />
To play this game follow these steps:<br /><br />
a. If the translation is correct, tap the green button (True), if not tap the red button (False)<br />
b. The score is updated and the app gives a new set of cards<br />
c. Repeat the steps from point a<br />

![ezgif com-gif-maker (8)](https://user-images.githubusercontent.com/99278919/198084787-5fcb38d4-8c6c-4226-83fc-af116fcb09d1.gif)


### 4. Score
It gives a detailed list of words you have played with. For each word you see:
* Hits and fails per game
* Total hits and fails
* Total Score



At the bottom, there are 2 buttons: Top Hits and Top fails.
* Top Hits: Tap to check the words you have scored the best
* Top Fails: Tap to check the words you need to improve

### 5. Configuration

 You can set four main options for the app:

1. Train only my fails: It allows you to play the games only with the words you have failed at least once. This way you will strengthen your weaknesses
2. Train basic words: You will include basic words for playing the games
3. Train intermediate words: You will include intermediate words for playing the games
4. Train advanced words: You will include advanced words for playing the games

![Screen Shot 2022-10-21 at 11 22 06 AM](https://user-images.githubusercontent.com/99278919/198087495-77b95583-2886-4be8-bec6-c7b5bda59d5f.png)
