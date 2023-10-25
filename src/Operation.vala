/* Operation.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MathGame.Operation {
    public Operator operator { get; private set; }
    public int left_operand { get; private set; }
    public int right_operand { get; private set; }

    private int _result;
    public int result {
        get {
            return _result;
        }
    }

    public Operation (int left_operand, int right_operand, Operator operator) {
        this.left_operand = left_operand;
        this.right_operand = right_operand;
        this.operator = operator;

        compute_result ();
    }

    private void compute_result () {
        switch (operator) {
            case ADDITION:
                _result = left_operand + right_operand;
                break;
            case SUBTRACTION:
                _result = left_operand - right_operand;
                break;
            case MULTIPLICATION:
                _result = left_operand * right_operand;
                break;
            case DIVISION:
                _result = left_operand / right_operand;
                break;
        }
    }

    public string to_string () {
        var builder = new StringBuilder (@"$left_operand $operator ");
        if (right_operand < 0) {
            builder.append (@"($right_operand)");
        } else {
            builder.append (@"$right_operand");
        }
        return builder.str;
    }
}

public enum MathGame.Operator {
    ADDITION,
    SUBTRACTION,
    MULTIPLICATION,
    DIVISION;

    public string to_string () {
        switch (this) {
            case ADDITION:
                return "+";
            case SUBTRACTION:
                return "-";
            case MULTIPLICATION:
                return "*";
            case DIVISION:
                return "/";
            default:
                assert_not_reached ();
        }
    }
}
