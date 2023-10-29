/* Timer.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MathGame.Services.Timer {
    public int tick_milliseconds { get; set; default = 100; }
    private uint? source_id = null;
    public signal void tick ();

    public void start () {
        source_id = Timeout.add (tick_milliseconds, () => {
            tick ();
            return Source.CONTINUE;
        });
    }

    public void stop ()
    requires (source_id != null) {
        Source.remove (source_id);
    }
}
