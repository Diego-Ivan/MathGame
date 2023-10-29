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
    [GtkChild]
    private unowned Gtk.Label time_label;

    private ListStore exercises = new ListStore (typeof (Exercise));
    private Exercise current_exercise;
    private ExerciseGenerator generator = new ExerciseGenerator ();
    private Services.Settings settings = Services.Settings.get_instance ();
    private Services.Timer timer = new Services.Timer ();

    private DateTime start_time;
    private int correct_answers = 0;

    construct {
        timer.tick.connect (() => {
            var current_time = new DateTime.now_local ();
            float elapsed_time = (float) current_time.difference (start_time) / TimeSpan.SECOND;
            time_label.label = "%02.1f".printf (elapsed_time);
        });
    }

    public void start_game () {
        content_stack.visible_child_name = "exercise-view";
        start_time = new DateTime.now_local ();

        exercises.remove_all ();
        correct_answers = 0;
        can_pop = false;

        time_label.visible = settings.show_timer;
        if (settings.show_timer) {
            timer.start ();
        }

        next_exercise ();
    }

    private void next_exercise () {
        if (exercises.get_n_items () >= settings.rounds) {
            timer.stop ();
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
        exercises_list.bind_model (exercises, bind_listbox_object);

        can_pop = true;
        time_label.visible = false;

        var end_time = new DateTime.now_local ();
        float elapsed_time = (float) end_time.difference (start_time) / TimeSpan.SECOND;

        uint n_exercises = exercises.get_n_items ();
        results_status.description = @"You got $correct_answers/$n_exercises correct in $elapsed_time seconds";
        content_stack.visible_child_name = "results-view";
    }

    [GtkCallback]
    private void input_submit () {
        int user_input;
        bool is_number = int.try_parse (input_row.text, out user_input);
        if (input_row.text != "" && is_number) {
            current_exercise.user_input = user_input;
            input_row.remove_css_class ("error");

            if (current_exercise.is_correct) {
                correct_answers++;
            }

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
