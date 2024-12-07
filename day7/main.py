#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import operator
from itertools import product

ops = ["+", "*", "||"]

operations = {
    "+": operator.add,
    "*": operator.mul,
    "||": operator.add,
}

if __name__ == "__main__":
    with open("input.txt", "r") as f:
        text = f.read()
        row = text.split("\n")

        total = 0

        for r in row:
            if len(r) > 0:
                input = r.replace(":", "").split(" ")
                answer = int(input.pop(0))

                op_perms = product(ops, repeat=len(input) - 1)

                for o in op_perms:
                    eq = int(input[0])
                    for i in range(1, len(input)):
                        if o[i - 1] == "||":
                            eq = int(operations[o[i - 1]](str(eq), input[i]))
                        else:
                            eq = operations[o[i - 1]](eq, int(input[i]))
                    if eq == answer:
                        # print(f"{' '.join(input)} = {answer}")
                        total += eq
                        break

        print(total)
