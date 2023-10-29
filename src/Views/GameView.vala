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
    [GtkChild]
    private unowned Gtk.Stack content_stack;
    [GtkChild]
    private unowned Adw.StatusPage results_status;
    [GtkChild]
    private unowned Gtk.ListBox exercises_list;

    private ListStore exercises = new ListStore (typeof (Exercise));
    private Exercise current_exercise;
    private ExerciseGenerator generator = new ExerciseGenerator ();
    private Services.Settings settings = Services.Settings.get_instance ();

    private DateTime start_time;
    private DateTime? end_time = null;
    private int correct_answers = 0;

    public void start_game () {
        start_time = new DateTime.now_local ();
        exercises.remove_all ();
        correct_answers = 0;
        content_stack.visible_child_name = "exercise-view";
        can_pop = false;
        next_exercise ();
    }

    private void next_exercise () {
        if (exercises.get_n_items () >= settings.rounds) {
            can_pop = true;
            end_time = new DateTime.now_local ();
            display_results ();
            return;
        }
        current_exercise = generator.generate ();
        exercise_label.label = @"$(current_exercise.operation) = ?";
        exercises.append (current_exercise);
        input_row.text = "";
    }

    private void display_results ()
    requires (content_stack.visible_child_name != "results-view") {
        int correct_counter = 0;
        exercises_list.bind_model (exercises, bind_listbox_object);

        uint n_exercises = exercises.get_n_items ();
        for (int i = 0; i < n_exercises; i++) {
            var exercise = (Exercise) exercises.get_item (i);
            if (exercise.is_correct) {
                correct_counter++;
            }
        }

        results_status.description = @"You got $correct_counter/$n_exercises correct";
        content_stack.visible_child_name = "results-view";
    }

    [GtkCallback]
    private void input_submit () {
        int user_input;
        bool is_number = int.try_parse (input_row.text, out user_input);
        if (input_row.text != "" && is_number) {
            current_exercise.user_input = user_input;
            input_row.remove_css_class ("error");
            next_exercise ();
        } else {
            input_row.add_css_class ("error");
        }
    }

    private Gtk.Widget bind_listbox_object (Object item) {
        return new ExerciseRow () {
            exercise = (Exercise) item
        };
    }
}
