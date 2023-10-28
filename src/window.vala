/* window.vala
 *
 * Copyright 2023 Diego Iván
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diego_ivan/mathgame/window.ui")]
public class MathGame.Window : Adw.ApplicationWindow {
    [GtkChild]
    private unowned Adw.NavigationView navigation_view;
    [GtkChild]
    private unowned GameView game_view;

    static construct {
        typeof (StartView).ensure ();
    }

    public Window (Gtk.Application app) {
        Object (application: app);
    }

    [GtkCallback]
    private void on_game_start_request () {
        navigation_view.push_by_tag ("game-view");
        game_view.start_game ();
    }
}
