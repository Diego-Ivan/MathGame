/* ExerciseGenerator.vala
 *
 * Copyright 2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class MathGame.ExerciseGenerator {
    private Services.Settings settings = Services.Settings.get_instance ();

    public Exercise generate (Operator? operator = null) {
        if (operator == null) {
            operator = (Operator) Random.int_range (0, 4);
        }
        switch (operator) {
            case ADDITION:
            case SUBTRACTION:
            case MULTIPLICATION:
                return generate_exercise_for_operator (operator);
            case DIVISION:
                return generate_division ();
            default:
                assert_not_reached ();
        }
    }

    private Exercise generate_exercise_for_operator (Operator operator) {
        int left_operand = generate_integer (), right_operand = generate_integer ();
        var operation = new Operation (left_operand, right_operand, operator);
        return new Exercise (operation);
    }

    private Exercise generate_division () {
        /*
         * Generating division is a little bit more tricky, as we want it to be an integer division,
         * so first we will look for the factors of a random number and pick one of those
         * as the right hand operand. We will also avoid prime numbers.
         */
        int left_operand = 0;
        GenericArray<int?> factors = null;

        do {
            left_operand = generate_integer ();
            factors = get_factors_for (left_operand);
        } while (factors.length <= 2);
        int right_operand = factors[Random.int_range (0, factors.length)];

        bool make_negative = Random.boolean ();
        if (make_negative) {
            right_operand = -right_operand;
        }

        var operation = new Operation (left_operand, right_operand, DIVISION);

        return new Exercise (operation);
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

    private int generate_integer () {
        int upper_bound = settings.max_number_addition;
        int lower_bound = settings.include_negatives ? -upper_bound : 1;

        return Random.int_range (lower_bound, upper_bound + 1);
    }
}
