mixin AppLocale {
  static const String appTitle = 'appTitle';
  static const String leaderboard = 'leaderboard';
  static const String matches = 'matches';
  static const String news = 'news';
  static const String team = 'team';
  static const String w = 'w';
  static const String d = 'd';
  static const String l = 'l';
  static const String pts = 'pts';
  static const String refresh = 'refresh';
  static const String startNewMatch = 'startNewMatch';
  static const String matchHistory = 'matchHistory';
  static const String noMatchesPlayed = 'noMatchesPlayed';
  static const String newsFeed = 'newsFeed';
  static const String noNews = 'noNews';
  static const String matchSimulation = 'matchSimulation';
  static const String selectTeam1 = 'selectTeam1';
  static const String selectTeam2 = 'selectTeam2';
  static const String startMatch = 'startMatch';
  static const String matchResult = 'matchResult';
  static const String close = 'close';
  static const String simulationInProgress = 'simulationInProgress';
  static const String error = 'error';
  static const String anErrorOccurred = 'anErrorOccurred';
  static const String selectDifferentTeams = 'selectDifferentTeams';
  static const String newsTemplate1 = 'newsTemplate1';
  static const String newsTemplate2 = 'newsTemplate2';
  static const String newsTemplate3 = 'newsTemplate3';
  static const String newsTemplate4 = 'newsTemplate4';

  static const Map<String, dynamic> EN = {
    appTitle: 'Galactic Football',
    leaderboard: 'Leaderboard',
    matches: 'Matches',
    news: 'News',
    team: 'Team',
    w: 'W',
    d: 'D',
    l: 'L',
    pts: 'Pts',
    refresh: 'Refresh',
    startNewMatch: 'Start New Match',
    matchHistory: 'Match History',
    noMatchesPlayed: 'No matches have been played yet.',
    newsFeed: 'News Feed',
    noNews: 'No news yet. Play a match to generate a story!',
    matchSimulation: 'Match Simulation',
    selectTeam1: 'Select Team 1',
    selectTeam2: 'Select Team 2',
    startMatch: 'Start Match',
    matchResult: 'Match Result',
    close: 'Close',
    simulationInProgress: 'Simulation in progress...',
    error: 'Error',
    anErrorOccurred: 'An error occurred. Please try again.',
    selectDifferentTeams: 'Please select two different teams.',
    newsTemplate1: 'In an incredible showdown, {team1} secured a dramatic victory over {team2} with a final score of {score1}-{score2}! Their offensive power was simply unstoppable.',
    newsTemplate2: '{team2} couldn\'t handle the heat as {team1} dominated the field, winning {score1}-{score2}. A memorable performance!',
    newsTemplate3: 'A nail-biter of a match ended in a {score1}-{score2} draw between {team1} and {team2}, leaving fans on the edge of their seats.',
    newsTemplate4: 'It was a tough day for {team2}, who fell to {team1} with a score of {score1}-{score2}. {team1} showed true champion spirit.',
  };

  static const Map<String, dynamic> RU = {
    appTitle: 'Галактический футбол',
    leaderboard: 'Таблица',
    matches: 'Матчи',
    news: 'Новости',
    team: 'Команда',
    w: 'В',
    d: 'Н',
    l: 'П',
    pts: 'О',
    refresh: 'Обновить',
    startNewMatch: 'Начать новый матч',
    matchHistory: 'История матчей',
    noMatchesPlayed: 'Сыгранных матчей пока нет.',
    newsFeed: 'Лента новостей',
    noNews: 'Новостей пока нет. Сыграйте матч, чтобы создать историю!',
    matchSimulation: 'Симуляция матча',
    selectTeam1: 'Выберите команду 1',
    selectTeam2: 'Выберите команду 2',
    startMatch: 'Начать матч',
    matchResult: 'Результат матча',
    close: 'Закрыть',
    simulationInProgress: 'Идет симуляция...',
    error: 'Ошибка',
    anErrorOccurred: 'Произошла ошибка. Пожалуйста, попробуйте еще раз.',
    selectDifferentTeams: 'Пожалуйста, выберите две разные команды.',
    newsTemplate1: 'В невероятном поединке {team1} одержала драматическую победу над {team2} со счетом {score1}-{score2}! Их атакующая мощь была просто неудержима.',
    newsTemplate2: '{team2} не справилась с натиском, так как {team1} доминировала на поле, выиграв {score1}-{score2}. Запоминающееся выступление!',
    newsTemplate3: 'Напряженный матч между {team1} и {team2} завершился вничью {score1}-{score2}, оставив болельщиков в напряжении до самого конца.',
    newsTemplate4: 'Это был тяжелый день для {team2}, которая уступила {team1} со счетом {score1}-{score2}. {team1} проявила настоящий чемпионский дух.',
  };
}