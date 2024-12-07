import itertools


def all_expressions(nums):
    # Permute all orders of the numbers
    for perm in itertools.permutations(nums):
        # Generate all operator combinations between numbers
        for ops in itertools.product(["+", "*"], repeat=len(perm) - 1):
            # Build the expression string
            expression_parts = []
            for i, num in enumerate(perm):
                expression_parts.append(str(num))
                if i < len(perm) - 1:
                    expression_parts.append(ops[i])
            expr = "".join(expression_parts)

            # Evaluate the expression (blind spot: watch out for `eval` safety)
            value = eval(expr)  # For controlled scenarios only
            yield expr, value


# Example usage
nums = [1, 2, 3]
for expr, val in all_expressions(nums):
    print(f"{expr} = {val}")
