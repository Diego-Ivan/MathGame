/* ExerciseGenerator.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MathGame.ExerciseGenerator {
    private Services.Settings settings = Services.Settings.get_instance ();

    public Exercise generate () {
        var operator = (Operator) Random.int_range (0, 4);

        int left = 0, right = 0;
        switch (operator) {
            case ADDITION:
            case SUBTRACTION:
                left = generate_integer (settings.max_number_addition);
                right = generate_integer (settings.max_number_addition);
                break;
            case MULTIPLICATION:
                left = generate_integer (settings.max_number_multiplication);
                right = generate_integer (settings.max_number_multiplication);
                break;
            case DIVISION:
                generate_division_operands (out left, out right);
                break;
            default:
                assert_not_reached ();
        }

        var operation = new Operation (left, right, operator);
        return new Exercise (operation);
    }

    private void generate_division_operands (out int left, out int right) {
        /*
         * Generating division is a little bit more tricky, as we want it to be an integer division,
         * so first we will look for the factors of a random number and pick one of those
         * as the right hand operand. We will also avoid prime numbers.
         */
        left = 0;
        GenericArray<int?> factors = null;
        do {
            left = generate_integer (settings.max_number_addition);
            factors = get_factors_for (left);
        } while (factors.length <= 2);
        right = factors[Random.int_range (0, factors.length)];

        bool make_negative = Random.boolean ();
        if (make_negative && settings.include_negatives) {
            right = -right;
        }
    }

    private GenericArray<int?> get_factors_for (int number) {
        var factors = new GenericArray<int?> ();
        if (number < 0) {
            number = -number;
        }

        for (int i = 1; i <= number; i++) {
            if (number % i == 0) {
                factors.add (i);
            }
        }

        return factors;
    }

    private int generate_integer (int upper_bound) {
        int lower_bound = settings.include_negatives ? -upper_bound : 1;
        return Random.int_range (lower_bound, upper_bound + 1);
    }
}
