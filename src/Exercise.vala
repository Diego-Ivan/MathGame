/* Exercise.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MathGame.Exercise : Object {
    public Operation operation { get; construct; }
    public int user_input { get; set; }

    [CCode (notify = false)]
    public bool is_correct {
        get {
            return user_input == operation.result;
        }
    }

    public Exercise (Operation operation) {
        Object (operation: operation);
    }
}
