/* Settings.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[SingleInstance]
public sealed class MathGame.Services.Settings : Object {
    protected static Settings? instance = null;
    public static Settings get_instance () {
        if (instance == null) {
            instance = new Settings ();
        }
        return instance;
    }

    private GLib.Settings g_settings = new GLib.Settings ("io.github.diego_ivan.mathgame");

    public int max_number_addition { get; set; }
    public int max_number_mulitplication { get; set; }
    public bool include_negatives { get; set; }

    protected Settings () {
    }

    construct {
        bind ("max-number-addition");
        bind ("max-number-multplication");
        bind ("include-negatives");
        g_settings.delay ();
    }

    private void bind (string property) {
        g_settings.bind (property, this, property, DEFAULT);
    }

    public void apply () {
        g_settings.apply ();
    }
}
