/* StartView.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diego_ivan/mathgame/gtk/start-view.ui")]
public class MathGame.StartView : Adw.NavigationPage {
    [GtkChild]
    private unowned Adw.SpinRow addition_row;
    [GtkChild]
    private unowned Adw.SpinRow multiplication_row;
    [GtkChild]
    private unowned Adw.SwitchRow negatives_row;
    [GtkChild]
    private unowned Adw.SpinRow rounds_row;

    private Services.Settings settings = Services.Settings.get_instance ();
    public signal void start_request ();

    construct {
        ActionEntry[] action_entries = {
            { "start", on_start_action }
        };

        var action_group = new SimpleActionGroup ();
        action_group.add_action_entries (action_entries, this);
        insert_action_group ("start-view", action_group);

        settings.bind_property ("max-number-addition",
                                addition_row, "value",
                                SYNC_CREATE | BIDIRECTIONAL);
        settings.bind_property ("max-number-multiplication",
                                multiplication_row, "value",
                                SYNC_CREATE | BIDIRECTIONAL);
        settings.bind_property ("rounds",
                                rounds_row, "value",
                                SYNC_CREATE | BIDIRECTIONAL);
        settings.bind_property ("include-negatives",
                                negatives_row, "active",
                                SYNC_CREATE | BIDIRECTIONAL);
    }

    private void on_start_action () {
        start_request ();
    }
}
