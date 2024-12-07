#!/usr/bin/env python3
# -*- coding: utf-8 -*-


def find_guard(grid: list[str]) -> tuple[int, int, int]:
    directions = "^v<>"
    for i, row in enumerate(grid):
        for j, cell in enumerate(row):
            if cell in directions:
                guard_idx = directions.index(cell)
                return i, j, guard_idx
    raise ValueError("guard not found")


def simulate(grid: list[str], x: int, y: int, direction: int) -> int:
    visited = set()

    directions = [(-1, 0), (0, 1), (1, 0), (0, -1)]

    rows = len(grid)
    cols = len(grid[0]) if rows > 0 else 0

    while True:
        visited.add((x, y))
        dx, dy = directions[direction]
        nx, ny = x + dx, y + dy

        if not (0 <= nx < rows and 0 <= ny < cols):
            return len(visited)

        if grid[nx][ny] == "#":
            direction = (direction + 1) % 4
        else:
            x, y = nx, ny


if __name__ == "__main__":
    with open("input.txt", "r") as f:
        grid = [line.rstrip("\n") for line in f if line.strip() != ""]
    start_x, start_y, start_dir = find_guard(grid)
    visited_count = simulate(grid, start_x, start_y, start_dir)
    print(visited_count)
