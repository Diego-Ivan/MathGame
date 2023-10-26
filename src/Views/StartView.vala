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

    construct {
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
}
