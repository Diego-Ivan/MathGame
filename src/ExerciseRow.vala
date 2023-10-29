/* ExerciseRow.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diego_ivan/mathgame/gtk/exercise-row.ui")]
public class MathGame.ExerciseRow : Adw.PreferencesRow {
    [GtkChild]
    private unowned Gtk.Label operation_label;
    [GtkChild]
    private unowned Gtk.Label user_label;
    [GtkChild]
    private unowned Gtk.Label answer_label;
    [GtkChild]
    private unowned Gtk.Image feedback_icon;

    private const string CHECKMARK_ICON = "checkmark-large-symbolic";
    private const string CROSS_ICON = "cross-large-symbolic";

    private Exercise _exercise;
    public Exercise exercise {
        get {
            return _exercise;
        }
        set {
            _exercise = value;
            answer_label.visible = !exercise.is_correct;
            user_label.label = @"Your answer: $(exercise.user_input)";
            answer_label.label = @"Correct Answer: $(exercise.operation.result)";
            operation_label.label = exercise.operation.to_string ();

            if (exercise.is_correct) {
                feedback_icon.icon_name = CHECKMARK_ICON;
                feedback_icon.add_css_class ("correct_answer");
                feedback_icon.remove_css_class ("wrong_answer");
            } else {
                feedback_icon.icon_name = CROSS_ICON;
                feedback_icon.add_css_class ("wrong_answer");
                feedback_icon.remove_css_class ("correct_answer");
            }
        }
    }
} 
