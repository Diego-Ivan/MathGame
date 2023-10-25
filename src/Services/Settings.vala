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

    public int max_number { get; set; }
    public bool include_negatives { get; set; }

    protected Settings () {
    }

    construct {
        g_settings.bind ("max-number", this, "max-number", DEFAULT);
        g_settings.bind ("include-negatives", this, "include-negatives", DEFAULT);
        g_settings.delay ();
    }

    public void apply () {
        g_settings.apply ();
    }
}
