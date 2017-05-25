def filter_real_games(games):
    return filter(check_game, games)


def check_game(game):
    game_words_count = len(game['words'])

    if 'id' not in game:
        return False

    guessed_words = 0
    skipped_words = 0
    deleted_words = 0
    all_words = 0
    time = 0

    for _, round in game['rounds'].items():
        for _, word in round['words'].items():
            all_words += 1
            time += word['time']

            if word['guessed'] and not word['deleted']:
                guessed_words += 1

            if word['deleted']:
                deleted_words += 1

                skipped_words += len(round['skipped'])

    average_time = time / all_words if all_words > 0 else 100

    if guessed_words == game_words_count and average_time > 2 and game_words_count > 10:
        return True
    else:
        return False
