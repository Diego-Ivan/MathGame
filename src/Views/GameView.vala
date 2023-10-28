/* GameView.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diego_ivan/mathgame/gtk/game-view.ui")]
public class MathGame.GameView : Adw.NavigationPage {
    [GtkChild]
    private unowned Gtk.Label exercise_label;
    [GtkChild]
    private unowned Adw.EntryRow input_row;

    private GenericArray<Exercise> exercises;
    private Exercise current_exercise;
    private ExerciseGenerator generator = new ExerciseGenerator ();
    private Services.Settings settings = Services.Settings.get_instance ();

    private DateTime start_time;
    private DateTime? end_time = null;

    public void start_game () {
        start_time = new DateTime.now_local ();
        exercises = new GenericArray<Exercise> ();
        next_exercise ();
    }

    private void next_exercise () {
        if (exercises.length >= settings.rounds) {
            end_time = new DateTime.now_local ();
            message ("Game's Done!");
            foreach (unowned Exercise exercise in exercises) {
                message (@"Was $(exercise.operation) right? $(exercise.is_correct)");
                message (@"Your Answer: $(exercise.user_input). Answer: $(exercise.operation.result)");
            }
            return;
        }
        current_exercise = generator.generate ();
        exercise_label.label = @"$(current_exercise.operation) = ?";
        exercises.add (current_exercise);
        input_row.text = "";
    }

    [GtkCallback]
    private void input_validate () {
        int number;
        if (!int.try_parse (input_row.text, out number)) {
            input_row.add_css_class ("error");
            input_row.show_apply_button = false;
        } else {
            input_row.remove_css_class ("error");
            input_row.show_apply_button = true;
        }
    }

    [GtkCallback]
    private void input_submit () {
        int user_input;
        bool is_number = int.try_parse (input_row.text, out user_input);
        if (input_row.text != "" && is_number) {
            current_exercise.user_input = user_input;
            message (@"Submitting $user_input as answer for $(current_exercise.operation)");
            next_exercise ();
        } else {
            input_row.add_css_class ("error");
        }
    }
}
