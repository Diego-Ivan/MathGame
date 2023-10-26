/* Game.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MathGame.Game : Object {
    private ExerciseGenerator generator = new ExerciseGenerator ();
    private ListStore exercises_store = new ListStore (typeof(Exercise));
    [CCode (notify = false)]
    public ListModel exercises {
        get {
            return exercises_store;
        }
    }

    public signal void done ();

    public int max_rounds { get; construct; }
    public int played_rounds { get; private set; default = 0; }
    public Exercise current_exercise { get; private set; }

    public Game (int max_rounds) {
        Object (max_rounds: max_rounds);
    }

    public void next () {
        if (played_rounds >= max_rounds) {
            done ();
            return;
        }
        current_exercise = generator.generate ();
        exercises_store.append (current_exercise);
        played_rounds++;
    }
}
